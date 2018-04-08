<?php declare(strict_types=1);

namespace KMOtrebski\BlogApp\Controllers;

use KMOtrebski\BlogApp\Library\AwesomeMachine;
use Phalcon\Mvc\Controller;

/**
 * @property AwesomeMachine $machine
 */
class IndexController extends Controller
{
    public function indexAction()
    {
        //view does not need any data
    }

    public function generateAction()
    {
        $number = $this->machine->generateAwesomeNumber();

        $this->view->setVar('number', $number);
    }
}
