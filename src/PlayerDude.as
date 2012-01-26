package
{
	import org.flixel.*;
	
	public class PlayerDude extends FlxSprite
	{
		[Embed(source='data/charBody.png')]public var Body:Class;
		
		public static var STATE_RUNNING 		: uint = 0;
		public static var STATE_FLINCHING 		: uint = 1;
		public static var STATE_DYING 			: uint = 2;
		public static var STATE_SHOOTING 		: uint = 3;
		public static var STATE_IDLE 			: uint = 4;
		
		private var playerState : uint;
		
		private var bullets:Array;		
		private var bulletIndex:int;
		public var aimAngle:Number = 0;
		
		private var _jump:Number;
		
		public function PlayerDude(x:Number=0, y:Number=0)
		{
			super(x, y);
			loadGraphic(Body, true, false, 32, 32);
			
			
			maxVelocity.x = 1200;			//walking speed
			acceleration.y = 400;			//gravity
			drag.x = maxVelocity.x*4;		//deceleration (sliding to a stop)
			
			playerState = STATE_IDLE;
			
			addAnimation("run",[0,1,2,3,4,5,6],12,true);
			addAnimation("aimAngle", [7,8,9,10,11,12], 12, true);
			addAnimation("aimUp", [13,14,15,16,17,18,19], 12, true);
		}
		
		public function giveBullets(inBullets : Array) : void {
			bullets = inBullets;
			bulletIndex = 0;	
			
		}
		
		public function run() : void {
			playerState = STATE_RUNNING;
		}
		
		
		override public function update():void
		{ 
			setAimAngle();
			
			
			if ( FlxG.mouse.justPressed()) {
				fireBullet(x, y, aimAngle);
			}
			
			if((_jump >= 0) && (FlxG.keys.justPressed("SPACE")))
			{
				FlxG.log("jump");
				_jump += FlxG.elapsed;
				if(_jump > 0.25) _jump = -1;
			}
			else _jump = -1;
			
			if (_jump > 0)
			{
				if(_jump < 0.065){
					FlxG.log("jump low");
					velocity.y += -170; 
				}else{
					FlxG.log("jump high");
					velocity.y = -400;
				}
			}
			
			
			if ( playerState == STATE_RUNNING ) {
				if (-100 < aimAngle && aimAngle < -45 ) {
					play("aimUp");
				} else if ( -45 < aimAngle && aimAngle < -15) {
					play("aimAngle");
				} else {
					play("run");
				}
				
				velocity = new FlxPoint(350, velocity.y);
			}
			
			super.update();
			
			if (playerState == STATE_IDLE) {
				run();	
			}
		}
		
		
		private function setAimAngle():void
		{
			this.aimAngle = FlxU.getAngle((FlxG.mouse.x - (x + (width/2))), (FlxG.mouse.y - (y + (height/2))));

		}
		
		override public function hitBottom(Contact:FlxObject, Velocity:Number):void {
			_jump = 0;
			super.hitBottom(Contact, Velocity);
		}
		
		private function fireBullet(x:Number, y:Number, dFireAngle:Number):void
		{
			var b:FlxSprite = bullets[bulletIndex];	//Figure out which bullet to fire
			var rFireAngle:Number; //create a variable for the angle in radians (required for velocity calculations because they don't work with degrees)
			b.reset(x + 16, y + 8); //this puts the bullets in the middle of the PlayerUpper sprite, but you may not want the shots to originate from here (or change it depending on the angle, much like the animations above)
			//b.angle = dFireAngle; //if your bullet shape doesn't need to be rotated (such as a circle) then remove this line to speed up the rendering
			rFireAngle = (dFireAngle * (Math.PI / 180)); //convert the fire angle from degrees into radians and apply that value to the radian fire angle variable
			//rFireAngle = (dFireAngle * (Math.PI)); //convert the fire angle from degrees into radians and apply that value to the radian fire angle variable
			b.velocity.x = Math.cos(rFireAngle) * 850; //calculate a velocity along the x axis, multiply the result by our diagonalVelocity (just 100 here).
			b.velocity.y = Math.sin(rFireAngle) * 850; //calculate a velocity along the y axis, ditto.
			bulletIndex++;							//Increment our bullet list tracker,
			if(bulletIndex >= bullets.length)		//and check to see if we went over,
				bulletIndex = 0;					//if we did just reset.
		}
	}
}