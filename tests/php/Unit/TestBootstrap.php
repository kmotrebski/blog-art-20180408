<?php declare(strict_types=1);

ini_set("display_errors", '1');
error_reporting(E_ALL);

define('BASE_PATH', dirname(__DIR__) . '/../..');
define('APP_PATH', BASE_PATH . '/src');
define('TESTS_PATH', __DIR__);

$config = include APP_PATH . "/config/config.php";

include APP_PATH . '/config/loader.php';

include BASE_PATH . '/vendor/autoload.php';
