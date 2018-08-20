<?php
$template = new Template(PROJECT_SRC . '/templates/step1.php');
$template->set('pricePro' , $config['price']['pro']);
$template->set('pricePremium' , $config['price']['premium']);
return $template->render();