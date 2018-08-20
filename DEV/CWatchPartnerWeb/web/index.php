<?php

define('PROJECT_DIR', __DIR__ . '/../');
define('PROJECT_SRC', PROJECT_DIR . '/src');

$step = $_GET['step'] ?? '';
$config = require_once PROJECT_SRC . '/config.php';
require_once PROJECT_SRC . '/Template.php';
require_once PROJECT_SRC . '/InternalLists.php';
switch ($step) {
    case 'profile':
        $html = require_once PROJECT_SRC . "/pages/step2.php";
        break;
    case 'final':
        $html = require_once PROJECT_SRC . "/pages/step3.php";
        break;
    default:
        $html = require_once PROJECT_SRC . "/pages/step1.php";
}
echo $html;