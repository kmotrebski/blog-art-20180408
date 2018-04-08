<?php declare(strict_types=1);

use Phalcon\Mvc\View;
use Phalcon\Mvc\Url;
use KMOtrebski\BlogApp\Library\AwesomeMachine;

$di->setShared('config', function () {
    return include APP_PATH . "/config/config.php";
});

$di->setShared('url', function () {
    $config = $this->getConfig();

    $url = new Url();
    $url->setBaseUri($config->application->baseUri);
    $url->setStaticBaseUri($config->application->baseUri);

    return $url;
});

$di->setShared('view', function () {

    $viewDir = $this->get('config')->application->viewsDir;

    $view = new View();
    $view->setDI($this);
    $view->setViewsDir($viewDir);

    return $view;
});

$di->setShared('machine', function () {

    return new AwesomeMachine();
});

$di->setShared('router', function () {

    return include APP_PATH . '/config/routes.php';
});
