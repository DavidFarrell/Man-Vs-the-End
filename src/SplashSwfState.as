package{
	import flash.display.MovieClip;
	import org.flixel.*;
	
	public class SplashSwfState extends FlxState
	{
		//----------------------------------------------------------------------
		[Embed(source = 'data/Movies/IntroSplash.swf')] private var SwfClass:Class;
		//----------------------------------------------------------------------
		protected var m_swf   	: MovieClip = null;
		private var timer		: Number	= 0;
		//----------------------------------------------------------------------
		public function SplashSwfState() : void
		{
			super();
			
			m_swf = new SwfClass();
			m_swf.x = 0;
			m_swf.y = 0;
			addChild(m_swf);
		}
		//----------------------------------------------------------------------
		override public function update():void 
		{
			timer += FlxG.elapsed;
			if (timer > 9.6){
				FlxG.state.destroy();
				FlxG.state = new MenuState();
			}
			super.update();
		}
		//----------------------------------------------------------------------
	}
}
