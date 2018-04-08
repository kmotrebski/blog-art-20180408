<?php declare(strict_types=1);

namespace KMOtrebski\BlogApp\Library;

use Phalcon\Mvc\User\Component;

class AwesomeMachine extends Component
{
    /**
     * Generates awesome number.
     *
     * @return int
     */
    public function generateAwesomeNumber() : int
    {
        return rand(1,100);
    }
}
