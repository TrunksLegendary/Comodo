<?php

class APIResponse {
    public $code;
    public $errorMsg;

    /**
     * APIResponse constructor.
     * @param string $msg
     */
    public function __construct(string $msg)
    {
        $response = json_decode($msg);
        if (!isset($response->error)) {
            if(empty($response->validationErrors)) {
               $this->code = 200;
            } else {
                $this->code = 500;
                $this->errorMsg = $response->validationErrors;
            }
        } else {
            $this->code = $response->status;
            $this->errorMsg = $response->message;
        }
    }
}

class APIController
{
    // URL where API reside, please do not change
    const API_URL = 'https://partner.cwatch.comodo.com';
    const API_ERROR = '{"error": "Server Error", "message": "Server Error", "status": 500}';

    // Class variable to hold auth token
    private $token='';

    /**
     * APIController constructor.
     * @param string $login
     * @param string $pass
     */
    public function __construct(string $login, string $pass) {
        $params = "{\"username\": \"{$login}\",  \"password\": \"{$pass}\"}";
        $response = $this->api_call('login', $params);

        if($response) {
            $auth = $this->api_get_auth_header($response['headers']);
            $this->token = $auth . "\r\n";
        }
    }

    public function createLicence(string $email, string $name, string $surname, string $country, string $product, string $term) {
        $apiResponse = $this->createUser($email, $name, $surname, $country);
        if (200 === $apiResponse->code) {
            $apiResponse = $this->distributeLicense($product, $term, $email, $name, $surname, $country);
        }

        return $apiResponse;
    }

    /**
     * @param string $email
     * @param string $name
     * @param string $surname
     * @param string $country
     * @return APIResponse
     */
    private function createUser(string $email, string $name, string $surname, string $country) {
        $params = "{\"email\": \"{$email}\",  \"name\": \"{$name}\",  \"surname\": \"{$surname}\",  \"country\": \"{$country}\"}";
        $response = $this->api_call('customer/add', $params);

        if(!$response) {
            $responseBody = self::API_ERROR;
        } else {
            $responseBody = $response['content'];
        }

        return new APIResponse($responseBody);
    }

    /**
     * @param string $product
     * @param string $term
     * @param string $email
     * @param string $name
     * @param string $surname
     * @param string $country
     * @return APIResponse
     */
    private function distributeLicense(string $product, string $term, string $email, string $name, string $surname, string $country) {
        $params = "{\"term\":\"{$term}\",\"product\":\"{$product}\",\"customers\":[{\"surname\":\"{$surname}\",\"email\":\"{$email}\",\"country\":\"{$country}\",\"name\":\"{$name}\"}],\"autoLicenseUpgrade\":false,\"renewAutomatically\":false}";
        $response = $this->api_call('customer/distributeLicenseForCustomers', $params);

        if(!$response) {
            $responseBody = self::API_ERROR;
        } else {
            $responseBody = $response['content'];
        }

        return new APIResponse($responseBody);
    }

    /**
     * @param string $route
     * @param string $body
     * @return array|bool
     */
    private function api_call(string $route, string $body) {

       // Prepare request URL
       $url = self::API_URL . "/{$route}";
       // Prepare request headers
       $header = "Content-type: application/json\r\n".
                 "Accept: application/json\r\n".
                 $this->token;

       // HTTP request options
       $context_options = array (
            'http' => array (
                'ignore_errors'=> true,
                'method' => 'POST',
                'header'=> $header,
                'content' => $body
                )
            );

       // Send request
       $context = stream_context_create($context_options);
       $fp = fopen($url, 'r', false, $context);
       if(! $fp) return false;

       // Get request body and headers
       $content = stream_get_contents($fp);
       $headers = $this->api_get_headers($fp);
       fclose($fp);

       // Return request response
       $response = array(
         'content' => $content,
         'headers' => $headers
       );

       return $response;
    }

    /**
     * Get headers from request on handler $fp
     * @param resource $fp
     * @return mixed
     */
    private function api_get_headers($fp) {
       $data = stream_get_meta_data($fp);
       return $data['wrapper_data'];
    }

    /**
     * Acquire 'Authorization' header from array of $headers
     * @param array $headers
     * @return mixed|string
     */
    private function api_get_auth_header(array $headers) {
       foreach ($headers as $header) {
           if( substr( $header, 0, 14 ) === "Authorization:" ) {
               return $header;
           }
       }
       return '';
    }


}

// -------------------------------------------------------------------------------------------------------------
// Example of usage
// -------------------------------------------------------------------------------------------------------------
//  $api = new APIController($login, $password);
//  $apiResponse = $api->createLicence($email, $name, $surname, $country, $product, $term);
//  if (200 !== $apiResponse->code) {
//         var_dump( $apiResponse->errorMsg );
//  } 

?>
