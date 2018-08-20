<?php
$template = new Template(PROJECT_SRC . '/templates/step3.php');
$plans = InternalLists::$productLicence;
if (!empty($_GET['plan']) && !empty($plans[$_GET['plan']])) {
    $price = $config['price'][$_GET['plan']];
    $template->set('price', $price);
}
$period = InternalLists::$productPeriods[htmlspecialchars($_GET['period'])];
$email = htmlspecialchars($_GET['email']);
$template->set('email', $email);

$template->set('period', $period);
return $template->render();
