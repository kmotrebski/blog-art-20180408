<?php declare(strict_types=1);

namespace KMOtrebski\BlogApp\Library;

abstract class UrlFactory
{
    public static function someRoute(
        string $controller,
        string $action
    ) : array {

        return [
            'for' => 'someRoute',
            "controller" => $controller,
            "action"     => $action,
        ];
    }

    /**
     * @return string[]
     */
    public static function home() : array
    {
        return [
            'for' => 'home',
        ];
    }
}
