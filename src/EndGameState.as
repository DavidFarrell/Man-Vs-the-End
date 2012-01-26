package  
{
	import org.flixel.*;
	
	public class EndGameState extends FlxState
	{
		[Embed(source="data/UI/MenuScreensBG.png")] private var background:Class;
		[Embed(source="data/UI/DeathScreenTitle.png")] private var startScrTtl:Class;
		
		public var bg:FlxSprite;
		public var strtScrTtl:FlxSprite;
		
		public var createTime:Number = 0;
		public var fadeSpeed:Number = 0.05;
		public var startDelay:Number = 1;
		
		public var moveCreateTime:Number = 0;
		public var moveSpeed:Number = 5;
		public var moveStartDelay:Number = 1;
		
		override public function create():void
		{
			bg = new FlxSprite(0,0,background);
			add(bg);
			
			strtScrTtl = new FlxSprite(0,-75,startScrTtl);
			
			add(strtScrTtl);
			strtScrTtl.alpha = 0;
			
			var text1:FlxText
			text1 = new FlxText(0, FlxG.height - 32, FlxG.width, "You managed " + FlxG.score + " points before extinction.")
			text1.setFormat (null, 8, 0xFFFFFFFF, "center")
			this.add(text1);
			
			
			
			FlxG.mouse.show();
		}
		override public function update():void
		{
			FadeIn();
			MoveDown();
			if (FlxG.mouse.justPressed())
			{
				FlxG.state = new PlayStateRun();
			}
			
		}
		public function FadeIn():void
		{
			createTime += FlxG.elapsed;
			if(createTime > startDelay && strtScrTtl.alpha < 1)
			{
				strtScrTtl.alpha += 0.1*fadeSpeed;			
			}  
		}
		
		public function MoveDown():void
		{
			moveCreateTime += FlxG.elapsed;
			if(moveCreateTime > moveStartDelay && strtScrTtl.y < 0)
			{
				strtScrTtl.y += 0.1*moveSpeed;			
			}  
		}
		
	}
	
}


/*package  
{
	import org.flixel.*;
	
	public class EndGameState extends FlxState
	{
		override public function create():void
		{
			var title:FlxText
			title = new FlxText(0, 16, FlxG.width, "The human race is no more.")
			title.setFormat (null, 16, 0xFFFFFFFF, "center")
			this.add(title);
			
			var text1:FlxText
			text1 = new FlxText(0, FlxG.height - 32, FlxG.width, "You scored " + FlxG.score + " points before being obliterated.");
			text1.setFormat (null, 8, 0xFFFFFFFF, "center")
			this.add(text1);
			
			var text2:FlxText
			text2 = new FlxText(0, FlxG.height / 2, FlxG.width, "Press SPACE or Click your mouse to continue.")
			text2.setFormat (null, 8, 0xFFFFFFFF, "center")
			this.add(text2);
			
			FlxG.mouse.show();
		}
		override public function update():void
		{
			if (FlxG.keys.justPressed("SPACE") || FlxG.mouse.justPressed())
			{
				FlxG.state = new MenuState();
			}
		}
		
	}
	
}*/