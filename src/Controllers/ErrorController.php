<?php declare(strict_types=1);

namespace KMOtrebski\BlogApp\Controllers;

use Phalcon\Mvc\Controller;

class ErrorController extends Controller
{
    const NAME = 'error';

    const A_ERROR_404 = 'error404';

    public function error404Action()
    {
        $this->view->disable();
        echo 'ERROR';
    }
}
