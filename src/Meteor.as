package
{
	import org.flixel.*;
	
	public class Meteor extends FlxSprite
	{
		//[Embed(source='data/meteor.png')]public var meteorAnim:Class;
		[Embed(source='data/MeteorSmall1.png')]public var meteorAnim:Class;
		
		public function Meteor(x:Number=0, y:Number=0)
		{
			
			super(x,y, meteorAnim);
			loadGraphic(meteorAnim, true, true, 32, 8);
			solid = true;
			var speedX : int =  -1 * (Math.random() * 200) + 50;//Math.floor(Math.random() * 100) + 100;
			velocity.x = -1 * speedX;
			var speedY : int =  Math.floor(Math.random() * 250) + 100;
			acceleration.y = speedY;
			addAnimation("meteorFall",[0,1,2],3,true);
		
			// get angle for rotation
			var aimAngle : Number = 0;
			aimAngle = FlxU.getAngle(-100,0 - speedY) + 70;
			angle = aimAngle;
		}
		
		/**
		 * Update the enemy ship.
		 * */
		override public function update():void
		{
			play("meteorFall");
			super.update();
		}
	}
}