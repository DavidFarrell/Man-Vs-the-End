package
{
	import org.flixel.*;
	
	public class Godzilla extends FlxSprite
	{
		[Embed(source='data/Godzilla.png')]public var GodzillaAnim:Class;
		
		private var alive : Boolean = true;
		
		public function Godzilla(x:Number, y:Number)
		{
			super(x,y, GodzillaAnim);
			loadGraphic(GodzillaAnim, true, true, 64, 32);
			solid = true;
			//var speedX : int = (Math.random() * 15) + 10;//Math.floor(Math.random() * 100) + 100;
			//velocity.x = speedX;
			addAnimation("GodzillaAlive", [0], 1, true);	
			addAnimation("GodzillaDead", [1], 1, false);
		}
		
		override public function update():void
		{
			if (alive)
			{
				play("GodzillaAlive");
			}
			else
			{
				play("GodzillaDead");
			}
			
			super.update();
		}
	}
}