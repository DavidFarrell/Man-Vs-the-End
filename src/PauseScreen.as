package
{
	import org.flixel.*;
	
	public class PauseScreen extends FlxGroup
	{
		[Embed(source="data/UI/key_minus.png")] private var ImgKeyMinus:Class;
		[Embed(source="data/UI/key_plus.png")] private var ImgKeyPlus:Class;
		[Embed(source="data/UI/key_0.png")] private var ImgKey0:Class;
		[Embed(source="data/UI/key_p.png")] private var ImgKeyP:Class;
		//[Embed(source="media/key_f.png")] private var ImgKeyF:Class;
		[Embed(source="data/UI/PauseMenuLogo.png")] private var pauseL:Class;
		public var pauseLogo:FlxSprite;
		
		/**
		 * Constructor.
		 */
		
		public function PauseScreen(){
			super();
			scrollFactor.x = 0;
			scrollFactor.y = 0;
			var w:uint = 100;
			var h:uint = 106;
			x = (FlxG.width-w)/2;
			y = (FlxG.height-h)/2;
			
			add((new FlxSprite()).createGraphic(w,h,0xaa000000,true),true);	
			pauseLogo = new FlxSprite(-2,-5,pauseL);
			add(pauseLogo,true);
			
			
			(add(new FlxText(0,53,w,"this game is"),true) as FlxText).alignment = "center";
			add((new FlxText(0,63,w,"PAUSED")).setFormat(null,16,0xffffff,"center"),true);
			add(new FlxSprite(14,89,ImgKeyP),true);
			add(new FlxText(26,89,w-16,"Pause Game"),true);
			
			
			//add(new FlxSprite(4,50,ImgKey0),true);
			//add(new FlxText(16,50,w-16,"Mute Sound"),true);
			//add(new FlxSprite(4,64,ImgKeyMinus),true);
			//add(new FlxText(16,64,w-16,"Sound Down"),true);
			//add(new FlxSprite(4,78,ImgKeyPlus),true);
			//add(new FlxText(16,78,w-16,"Sound Up"),true);
			//add(new FlxSprite(4,92,ImgKeyF),true);
			//add(new FlxText(16,92,w-16,"Flummox"),true);
		}
	}
}