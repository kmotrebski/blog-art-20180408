<?php declare(strict_types=1);

$loader = new \Phalcon\Loader();

$loader->registerNamespaces([
    'KMOtrebski\BlogApp'    => $config->application->appDir,
])->register();
