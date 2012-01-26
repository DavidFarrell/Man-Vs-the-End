package
{
	import org.flixel.*;
	
	public class Obstacle extends FlxSprite
	{
		[Embed(source='data/sheep.png')]public var sheepAnim:Class;
		[Embed(source='data/tvSet.png')]public var TVAnim:Class;
		[Embed(source='data/cattle.png')]public var yakAnim:Class;
		//[Embed(source='data/sheep.png')]public var petrolPumpAnim:Class;
		[Embed(source='data/Red_Squirrel.png')]public var squirrelAnim:Class;
		[Embed(source='data/AwsemoHorse.png')]public var horseAnim:Class;
		
		
		[Embed(source="data/Music/sheep-baa.mp3")] 	public var sheepNoise:Class;
		[Embed(source="data/Music/sheep-baa.mp3")]  public var TVnoise:Class;
		[Embed(source="data/Music/sheep-baa.mp3")] 	public var yakNoise:Class;
		//[Embed(source="date/Music/sheep-baa.mp3")]  public var petrolPumpNoise:Class;
		[Embed(source="data/Music/Horse.mp3")] 	public var squirrelNoise:Class;
		[Embed(source="data/Music/Horse.mp3")] 	public var horseNoise:Class;
		
		public static var STATE_SHEEP			: uint = 0;
		public static var STATE_TV 				: uint = 1;
		public static var STATE_YAK 			: uint = 2;
		public static var STATE_PETROLPUMP 		: uint = 3;
		public static var STATE_SQUIRREL 		: uint = 4;
		
		public var obstacleType : uint;
		public var alive : Boolean = true;
		
		public function Obstacle(x:Number=0, y:Number=0)
		{
			super(x,y);
			var obstacleType : uint = Math.floor(Math.random() * 4);
			
			FlxG.log("Obstacle Type is: " + obstacleType);
			//sheep
			if (obstacleType == 0)
			{
				loadGraphic(sheepAnim, true, true, 32, 16);
				solid = true; 
				//addAnimation("sheepAlive", [0]);
				//addAnimation("sheedInjured", [1], 4, false);
				addAnimation("sheepDead", [1,2,3,4,5], 12, false);
				//FlxG.play(sheep,1,false);
				FlxG.play(sheepNoise,1,false);
			}
			
			else if (obstacleType == 1)
			{
				loadGraphic(TVAnim, true, true, 32, 24);
				solid = true;
				addAnimation("TVAlive", [0], 4, false);
				addAnimation("TVDead", [1,2], 12, false);
				FlxG.play(TVnoise,1,false);
			}
			
			else if (obstacleType == 2)
			{
				loadGraphic(yakAnim, true, true, 32, 20);
				solid = true;
				addAnimation("yakAlive", [0], 4, false);
				addAnimation("yakDead", [1,2,3,4,5,6,7,8,9,10,11], 12, false);
				FlxG.play(yakNoise,1,false);
			}
			
			//else if (obstacleType == 3)
			//{
			//	loadGraphic(petrolPumpAnim, true, true, 96, 32);
			//	solid = true;
			//	addAnimation("petrolPumpAlive", [0], 4, false);
		//		addAnimation("petrolPumpDead", [1], 4, false);
		//		FlxG.play(
			//}
			else if (obstacleType == 3)
			{
				loadGraphic(squirrelAnim, true, true, 16, 16);
				solid = true;
				addAnimation("squirrelAlive", [0], 4, false);
				addAnimation("squirrelDead", [1], 12, false);
				FlxG.play(squirrelNoise,1,false);
			}		
			else if (obstacleType == 4)
			{
				loadGraphic(horseAnim, true, true, 64, 32);
				solid = true;
				addAnimation("horseAlive", [0], 4, false);
				addAnimation("horseDead", [1], 12, false);
				FlxG.play(horseNoise,1,false);
			}
		}
		
		/**
		 * Update the enemy ship.
		 * */
		override public function update():void
		{
			if ( alive )
			{
				if (obstacleType == 0)
				{	play("sheepAlive"); }
				if (obstacleType == 1)
				{	play("TVAlive"); }
				if (obstacleType == 2)
				{	play("yakAlive"); }
				if (obstacleType == 3)
				{	play("petrolPumpAlive"); }
				if (obstacleType == 4)
				{	play("squirrelAlive"); }
				if (obstacleType == 5)
				{	play("horseAlive"); }
			}
			else
			{
				if (obstacleType == 0)
				{	play("sheepDead"); }
				if (obstacleType == 1)
				{	play("TVDead"); }
				if (obstacleType == 2)
				{	play("yakDead"); }
				if (obstacleType == 3)
				{	play("petrolDead"); }
				if (obstacleType == 4)
				{	play("squirrelDead"); }
				if (obstacleType == 5)
				{	play("horseDead"); }
			}
			super.update();
		}
	}
}