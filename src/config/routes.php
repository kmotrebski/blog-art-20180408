<?php declare(strict_types=1);

$router = new \Phalcon\Mvc\Router(false);

$router->setDefaultNamespace('KMOtrebski\BlogApp\Controllers');
$router->removeExtraSlashes(true);

$router->add("/", [
    "controller" => "index",
    "action"     => "index",
])->setName('home');

$router->add('/:controller/:action/:params', [
        "controller" => 1,
        "action"     => 2,
        "params"     => 3,
])->setName('someRoute');

$router->notFound([
    "controller" => "index",
    "action"     => "error404",
]);

return $router;
