package{
	import flash.display.MovieClip;
	import org.flixel.*;
	
	public class SplashSwfState2 extends FlxState
	{
		//----------------------------------------------------------------------
		[Embed(source = 'data/Movies/IntroCutScene.swf')] private var SwfClass:Class;
		//----------------------------------------------------------------------
		protected var m_swf   	: MovieClip = null;
		private var timer		: Number	= 0;
		//----------------------------------------------------------------------
		public function SplashSwfState2() : void
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
			if (timer > 14){
				FlxG.state = new PlayStateRun();
			}
			super.update();
		}
		//----------------------------------------------------------------------
	}
}
