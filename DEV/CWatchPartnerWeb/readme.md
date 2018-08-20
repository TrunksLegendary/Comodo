System Requirements
-------------------

This code require web server with support of PHP version not less than 5.2.0.


Archive content
---------------

Subfolder "src" containing PHP code and libraries for application. Subfolder "web" for CSS styles, JavaScript and images.

Entry point for application: web/index.php

Folder "src/pages" containing PHP code for application pages.

Folder "src/templates" containing HTML templates for application pages. In need to change application design, it have to be done here.

Other files in "src" folder:

  APIController.php - code to make API calls to COMODO Partner Portal

  InternalLists.php - contain common constans such as country names/codes etc

  Template.php - simple class to draw PHP templates

  config.php - configuration files. Put your values here.

Especially pay close attention to values 'login' and 'pass'. Fill these values with your reseller login and password.


Installation
------------

To install this code just copy content of "partner" folder containing inside of ZIP file to any folder on your web server root.

Alternatively it's possible to install this app in separate virtual host.


API library
-----------

Library to make calls to COMODO Partner Portal api located in file "src/APIController.php".

It contain simple constructor which take your reseller login and password as arguments.

API library have two useful functions:

createUser(string $email, string $name, string $surname, string $country);

distributeLicense(string $product, string $term, string $email, string $name, string $surname, string $country);

First function is to create Partner Portal user second is to issue license to this user.

  Valid values for $product: "BASIC_DETECTION" "PRO" "PRO_FREE" "PRO_FREE_60D" "PREMIUM" "PREMIUM_FREE" "PREMIUM_FREE_60D"

  Valid values for $term: "MONTH_1" "MONTH_12" "MONTH_24" "MONTH_36" "MONTH_2" "UNLIMITED"

Also it possible to use aggregate function:

createLicence(string $email, string $name, string $surname, string $country, string $product, string $term)

This function made consistent calls to first and second function to unify two operations in one place.


Example of usage
----------------

  $api = new APIController($login, $password);
  $apiResponse = $api->createLicence($email, $name, $surname, $country, $product, $term);
  if (200 !== $apiResponse->code) {
         var_dump( $apiResponse->errorMsg );
  }
