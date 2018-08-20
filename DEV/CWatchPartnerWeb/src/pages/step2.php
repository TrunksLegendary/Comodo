<?php

$url_path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

if (empty($_POST)) {
    header('Location: '.$url_path);
}
$template = new Template(PROJECT_SRC . '/templates/step2.php');

$errors = [];
$plans = InternalLists::$productLicence;

if (!empty($_POST['plan']) && !empty($plans[$_POST['plan']])) {
    $template->set('plan', htmlspecialchars($_POST['plan']));
    $price = $config['price'][$_POST['plan']] ?? 0;
    $template->set('price', $price);
}

$formValues = [
        'cc_number' => $config['card']['number'],
        'cc_expr_month' => $config['card']['mm'],
        'cc_expr_year' => $config['card']['yy'],
        'cc_cvv' => $config['card']['cvc'],
        'cc_name' => $config['card']['name'],
        'cc_currency' => $config['card']['currency'],
        'period' => $config['card']['period'],
        'first_name' => $config['customer']['name'],
        'last_name' => $config['customer']['surname'],
        'address' => $config['customer']['address'],
        'email' => $config['customer']['email'],
        'city' => $config['customer']['city'],
        'state' => $config['customer']['state'],
        'country' => $config['customer']['country'],
        'zip' => $config['customer']['zip'],
        'plan' => 'plan',
];

if (isset($_POST['submit'])) {
    $fields  = [
        'cc_number' => 'cc_number',
        'cc_expr_month' => 'cc_expr_month',
        'cc_expr_year' => 'cc_expr_year',
        'cc_cvv' => 'cc_cvv',
        'cc_name' => 'cc_name',
        'cc_currency' => 'cc_currency',
        'period' => 'period',
        'first_name' => 'first_name',
        'last_name' => 'last_name',
        'address' => 'address',
        'email' => 'email',
        'city' => 'city',
        'state' => 'state',
        'country' => 'country',
        'zip' => 'zip',
        'plan' => 'plan',
    ];

// Defaults for form
/*
    $_POST['cc_currency'] = 'USD';
    $_POST['country'] = 'US';
    if($_POST['plan'] == 'basic') {
       $_POST['period'] = 'UNLIMITED';
     } else {
       $_POST['period'] = 'MONTH_1';
     }
*/
    $data = [];
    foreach ($fields as $fieldName => $fieldFormName) {
        // do not test credit card data for basic license
        if($_POST['plan'] == "basic" && strpos($fieldFormName, "cc_") === 0) continue;
        if (empty($_POST[$fieldFormName])) {
            $errors[] = 'Empty field ' . $fieldFormName;
            continue;
        }
        $data[$fieldName] = htmlspecialchars($_POST[$fieldFormName]);
        $formValues[$fieldFormName] =$data[$fieldName];
    }

    if (empty($plans[$_POST['plan']])) {
        $errors[] = 'wrong plan';
    } else {
        $plan = $plans[$_POST['plan']];
    }

    if (empty($errors)) {
        require_once PROJECT_SRC . '/APIController.php';

        $api = new APIController($config['api']['auth']['login'], $config['api']['auth']['pass']);

        $apiResponse = $api->createLicence($data['email'], $data['first_name'], $data['last_name'], $data['country'], $plan, $data['period']);
        if (200 !== $apiResponse->code) {
            $errors[] = $apiResponse->errorMsg;
        }

        if (empty($errors)) {
            //all ok
            header('Location: '.$url_path.'?step=final&plan=' . $data['plan'] . '&period=' . $data['period'] . '&email=' . $data['email'] );
            exit();
        }
    }

    $errorsHtml = 'Please, fix next errors: <br>' . join('<br>', $errors);
    $template->set('errors' , $errorsHtml);
}

$countriesHtml = '';
foreach (InternalLists::$countries as $countryCode => $countryName) {
    $countriesHtml .= '<option value="' . $countryCode . '">' . $countryName . '</option>';
}

$currenciesHtml = '';
foreach (InternalLists::$currencies as $currencyCode => $currencyName) {
    $currenciesHtml .= '<option value="' . $currencyCode . '">' . $currencyName . '</option>';
}

$periodsHtml = '';
foreach (InternalLists::$productPeriods as $periodCode => $periodName) {
    $periodsHtml .= '<option value="' . $periodCode . '">' . $periodName . '</option>';
}


$template->set('formValues' , $formValues);
$template->set('countries' , $countriesHtml);
$template->set('currencies' , $currenciesHtml);
$template->set('periods' , $periodsHtml);

$template->set('errors' , $errors);

return $template->render();
