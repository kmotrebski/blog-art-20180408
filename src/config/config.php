<?php declare(strict_types=1);

defined('BASE_PATH') || define('BASE_PATH', getenv('BASE_PATH') ?: realpath(dirname(__FILE__) . '/../..'));
defined('APP_PATH') || define('APP_PATH', BASE_PATH . '');

return new \Phalcon\Config([
    'application' => [
        'appDir'         => APP_PATH . '/',
        'viewsDir'       => APP_PATH . '/views/',
        'vendorDir'      => APP_PATH . '/../vendor/',
        'baseUri'        => '/',
    ],
]);
