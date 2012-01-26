package
{
	import org.flixel.*;
	
	public class PlayerLegs extends FlxSprite
	{
		[Embed(source='data/charLegs.png')]public var Legs:Class;
		
		public static var STATE_RUNNING 		: uint = 0;
		public static var STATE_FLINCHING 		: uint = 1;
		public static var STATE_DYING 			: uint = 2;
		public static var STATE_IDLE 			: uint = 4;
		
		private var playerState : uint;
		
		public function PlayerLegs(x:Number=0, y:Number=0)
		{
			super(x, y);
			loadGraphic(Legs, true, false, 32, 32);
			
			playerState = STATE_IDLE;
			
			addAnimation("run",[0,1,2,3,4,5,6],12,true);
		}
		
		public function run() : void {
			playerState = STATE_RUNNING;
		}
		
		
		override public function update():void
		{
			//Smooth slidey walking controls
			if ( playerState == STATE_RUNNING ) {
				play("run");
				velocity = new FlxPoint(200, 0);
			}
			
			super.update();
			
			if (playerState == STATE_IDLE) {
				run();	
			}
		}
		
		
		
	}
}