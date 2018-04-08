<?php declare(strict_types=1);

namespace KMOtrebski\BlogApp\Tests\Unit;

use Phalcon\Di;
use Phalcon\Test\UnitTestCase;

abstract class TestCase extends UnitTestCase
{
    /**
     * @var bool
     */
    private $_loaded = false;

    public function setUp()
    {
        parent::setUp();

        $di = new Di\FactoryDefault();

        include APP_PATH . "/config/services.php";

        $this->setDi($di);

        $this->_loaded = true;
    }

    /**
     * Check if the test case is setup properly
     *
     * @throws \PHPUnit_Framework_IncompleteTestError;
     */
    public function __destruct()
    {
        if (!$this->_loaded) {
            throw new \PHPUnit_Framework_IncompleteTestError(
                "Please run parent::setUp()."
            );
        }
    }
}
