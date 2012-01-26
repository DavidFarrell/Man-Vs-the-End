package  
{
	import org.flixel.*;
	
	public class Bullet extends FlxSprite
	{
		[Embed(source = "data/bullet.png")] private var ImgBullet:Class;
		
		public function Bullet(x:Number, y:Number):void
		{
			super(x, y);
			loadGraphic(ImgBullet);
		}
		
	}
	
}