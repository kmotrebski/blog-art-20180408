<?php
use Phalcon\Di\FactoryDefault;

error_reporting(E_ALL);

define('BASE_PATH', dirname(__DIR__));
define('APP_PATH', BASE_PATH . '');

try {

    $di = new FactoryDefault();

    include APP_PATH . "/config/services.php";

    $config = $di->getConfig();

    include APP_PATH . '/config/loader.php';

    include $config->application->vendorDir . 'autoload.php';

    $application = new \Phalcon\Mvc\Application($di);

    echo $application->handle()->getContent();

} catch (\Exception $e) {
    echo (string) $e;
}
