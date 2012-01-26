package
{
	import org.flixel.*;
	
	public class UFO extends FlxSprite
	{
		[Embed(source='data/Flying-Saucer.png')]public var UFOAnim:Class;
		
		[Embed(source = 'data/music/ufo.mp3')]public var UFOSound:Class;
		
		//public var health : uint = 10;
		public var alive : Boolean = true;
		private var up : Boolean = true;
		
		private var _moveTimer:Number;
		private var _moveTimerInterval:Number = 25;
		
		public function UFO(x:Number, y:Number)
		{
			super(x,y, UFOAnim);
			loadGraphic(UFOAnim, true, true, 64, 32);
			solid = true;
			var speedX : int = (Math.random() * 20) + 350;//Math.floor(Math.random() * 100) + 100;
			velocity.x = speedX;
			velocity.y = 0;
			addAnimation("UFOflying", [0,1,2,3,4,5,6,7,8],12,true);		
			
			resetMoveTimer();
		}
		
		override public function update():void
		{
			if (alive)
			{
				play("UFOflying");
				FlxG.play(UFOSound,1,false);
				
		//		_moveTimer -= FlxG.elapsed;
				if (_moveTimer < 0)
				{
					up = !up;
					resetMoveTimer();
				}
				
				if (up)
				{
					velocity.y++;	
				}
				else
				{
					velocity.y--;	
				}
			}
			_moveTimer--;
			super.update();
		}
		
		private function resetMoveTimer():void
		{
			_moveTimer = _moveTimerInterval;	
		}
	}
}