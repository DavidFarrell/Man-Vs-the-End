package 
{
	import org.flixel.*;
	[SWF(width="1024", height="768", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
	
	public class GameJam extends FlxGame
	{
		
		
		public function GameJam()
		{
			super(256,192,SplashSwfState,4);0xff233e58
			//super(256,192,PlayStateRun,4);0xff233e58
			this.pause = new PauseScreen();
			//super(256,192,MenuState,4);0x00000000
			FlxState.bgColor = 0x00000000;
		}
	}
}
