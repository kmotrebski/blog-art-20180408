<?php declare(strict_types=1);

namespace KMOtrebski\BlogApp\Tests\Unit\Library;

use KMOtrebski\BlogApp\Library\AwesomeMachine;
use PHPUnit\Framework\TestCase;

class AwesomeMachineTest extends TestCase
{
    public function testReturnsRandomNumberBetween1And100()
    {
        //arrange
        $machine = new AwesomeMachine();

        for($i = 0; $i<1000; $i++) {

            //act
            $number = $machine->generateAwesomeNumber();

            //assert
            $this->assertTrue(self::assertNumberIsBeetween1And100($number));
        }
    }

    protected static function assertNumberIsBeetween1And100(int $number) : bool
    {
        if ($number >= 0 && $number <= 100) {
            return true;
        }

        $fmt = 'Number %s is not from 1-100 range.';
        $msg = sprintf($fmt, $number);
        throw new \Exception($msg);
    }
}
