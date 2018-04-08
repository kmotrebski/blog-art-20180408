<?php declare(strict_types=1);

namespace KMOtrebski\BlogApp\Tests\Unit\Controllers;

use KMOtrebski\BlogApp\Library\UrlFactory;
use KMOtrebski\BlogApp\Tests\Unit\TestCase;
use Phalcon\Mvc\Application;

class UnitTest extends TestCase
{
    /**
     * @var Application $application
     */
    protected $application;

    public function setUp()
    {
        parent::setUp();

        $this->application = new Application($this->di);
    }

    public function testHomePageContainsButtonToGenerationPage()
    {
        //arrange

        //act
        $response = $this->application->handle('/')->getContent();

        //assert
        $this->assertTrue(self::containsButtonToLotteryPage($response));
    }

    public function testGenerationPageGeneratesAnAwesomeNumber()
    {
        //arrange

        //act
        $response = $this->goToGenerationPage();

        //assert
        $this->assertTrue(self::pageContainsAwesomeNumber($response));
    }

    protected function goToGenerationPage() : string
    {
        $url = $this->di->get('url')->get(UrlFactory::someRoute('index', 'generate'));
        $response = $this->application->handle($url)->getContent();

        return $response;
    }

    protected static function containsButtonToLotteryPage(string $response) : bool
    {
        if (false === strpos($response, 'Generate!')) {
            throw new \Exception('Button on home page is missing.');
        }

        return true;
    }

    protected static function pageContainsAwesomeNumber(string $response) : bool
    {
        if (false === strpos($response, 'Your number is')) {
            throw new \Exception('Awesome number is missing!');
        }

        return true;
    }
}
