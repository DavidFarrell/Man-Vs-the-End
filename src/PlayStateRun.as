package
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.flixel.*;
	
	public class PlayStateRun extends FlxState
	{
		[Embed(source="data/map1.png")] private var ImgMap1:Class;
		//[Embed(source="data/tiles.png")] private var ImgTiles:Class;
		[Embed(source="data/RoadTile.png")] private var ImgTiles:Class;
		[Embed(source="data/CloudsBackground.png")] private var ImgCloudBackground:Class;
		[Embed(source="data/SkyBackground.png")] private var ImgSkyBackground:Class;
		[Embed(source="data/ForegroundPropLayer.png")] private var ImgPropLayer:Class;
		[Embed(source="data/proplayer1_4096.png")] private var ImgPropLayer4096:Class;
		[Embed(source="data/MountainsBackground.png")] private var ImgMountainLayer:Class;
		[Embed(source="data/ForegroundFloor.png")] private var ImgForegroundLayer:Class;
		[Embed(source="data/LetterboxSinglePanel.png")] private var LetterBox:Class;
		[Embed(source="data/VFX/VignetteOverlay.png")] private var Vignette:Class;
		[Embed(source = "data/cursor.png")] private var ImgCursor:Class;
		[Embed(source = "data/UI/SlowMotionBar.png")] private var SlowmoBar:Class;
		[Embed(source = "data/VFX/WhiteFlash.png")] private var WhiteFlash:Class;
		[Embed(source="data/Music/MainGameTheme.mp3")] 	public var mainMusic:Class;
		[Embed(source="data/Music/SlowMotionSegment.mp3")] 	public var slowMusic:Class;
		[Embed(source="data/Music/sheep-baa.mp3")] 	public var sheep:Class;
		[Embed(source="data/MeteorGib.png")] private var ImgGibs:Class;
		[Embed(source="data/ScientistGib.png")] private var ImgScientistGibs:Class;
		[Embed(source="data/sheepGib.png")] private var ImgSheepGibs:Class;
		[Embed(source="data/VFX/RainAnimation.png")] private var Rain:Class;
		[Embed(source="data/VFX/CrazySurroundA.png")] private var Surround:Class;
		
		[Embed(source="data/sheep.png")] private var ImgSheepAnim:Class;
		
		protected var population:int = 690000000;
		
		public var endOfGameTimer : Timer;
		
		public var map: FlxTilemap; 
		
		protected var _fps:FlxText;
		protected var _population:FlxText;
		public var scoreText : FlxText;
		
		protected var _player : PlayerDude;
		public var playerLegs : PlayerLegs;
		
		// collision groups
		private var _obstacles : FlxGroup;
		private var _meteors: FlxGroup;
		private var _ufos : FlxGroup;
		private var _bullets:FlxGroup;
		private var _gibs : FlxGroup;
		private var _baddieGroup : FlxGroup;
		private var _goodieGroup : FlxGroup;
		
		
		private var _meteorSpawnTimer:Number;
		private var _meteorSpawnInterval:Number = 2.5;
		
		private var _obstacleSpawnTimer:Number;
		private var _obstacleSpawnInterval:Number = 5.5;
		
		private var _ufoSpawnTimer:Number;
		private var _ufoSpawnInterval:Number = 10;
		
		private var emitter:FlxEmitter;
		private var baddies : Array;
		
		//various parallax layers
		public static var BG_SKY : uint = 0;
		public static var BG_CLOUD : uint = 1;
		public static var BG_MOUNTAIN : uint = 2;
		public static var BG_FOREGROUND : uint = 3;
		public static var BG_PROP : uint = 4;
		
		public var _skyLayer:FlxSprite;
		public var _cloudLayer:FlxSprite;
		public var _mountainLayer:FlxSprite;
		public var _foregroundLayer:FlxSprite;
		public var _propLayer:FlxSprite;
		public var letterBoxTop:FlxSprite;
		public var letterBoxBottom:FlxSprite;
		public var vignetteOverlay:FlxSprite;
		public var rainOverlay:FlxSprite;
		public var slowModeSurround:FlxSprite;
		
		public var _cloudLayer2:FlxSprite;
		public var _mountainLayer2:FlxSprite;
		public var _propLayer2:FlxSprite;
		
		public var backgrounds : Array;
		
		public var slowmo : Boolean;
		
		public var slowmoIncrement : Number;
		public var slowmoStartValue : Number;
		public var slowmoTargetValue : Number;
		public var slowmoUI : FlxSprite;
		
		public var slowmoTimer: Timer;
		
		public var lightBoxFlashTimer : Timer;
		public var lightBoxFlashStage : Number;
		public var lightBox : FlxSprite;
		
		override public function create():void
		{
			//show cursor for our testing
			FlxG.mouse.show();
			
			FlxG.score = 0;
			FlxG.scores = new Array();
			FlxG.scores[0] = 0;
			
			//addAnimation("sheepDeath",[0,1,2,3,4],12,true);
			
			//Play background music
			FlxG.playMusic(mainMusic);
			
			//Background 
			FlxState.bgColor = 0x00000000;		
			
			//sky parallax layer.
			_skyLayer = new FlxSprite(0,0, ImgSkyBackground);
			_skyLayer.scrollFactor = new FlxPoint(0,0);
			_skyLayer.solid = false;
			_skyLayer.moves = false;
			_skyLayer.collideBottom = _skyLayer.collideLeft = _skyLayer.collideRight = _skyLayer.collideTop = false;
			add(_skyLayer);
			
			
			//cloud parallax layer.
			_cloudLayer = new FlxSprite(0,0, ImgCloudBackground);
			_cloudLayer.scrollFactor = new FlxPoint(0.1,0);
			_cloudLayer.solid = false;
			_cloudLayer.moves = false;
			_cloudLayer.collideBottom = _cloudLayer.collideLeft = _cloudLayer.collideRight = _cloudLayer.collideTop = false;
			add(_cloudLayer);
			
			//cloud parallax layer.
			_cloudLayer2 = new FlxSprite(0,0, ImgCloudBackground);
			_cloudLayer2.scrollFactor = new FlxPoint(0.1,0);
			_cloudLayer2.solid = false;
			_cloudLayer2.moves = false;
			_cloudLayer2.collideBottom = _cloudLayer2.collideLeft = _cloudLayer2.collideRight = _cloudLayer2.collideTop = false;
			add(_cloudLayer2);
			
			//mountain parallax layer.
			_mountainLayer = new FlxSprite(0,0, ImgMountainLayer);
			_mountainLayer.scrollFactor = new FlxPoint(0.2,0);
			_mountainLayer.solid = false;
			_mountainLayer.moves = false;
			_mountainLayer.collideBottom = _mountainLayer.collideLeft = _mountainLayer.collideRight = _mountainLayer.collideTop = false;
			add(_mountainLayer);
			
			
			//mountain parallax layer.
			_mountainLayer2 = new FlxSprite(_mountainLayer.width,0, ImgMountainLayer);
			_mountainLayer2.scrollFactor = new FlxPoint(0.2,0);
			_mountainLayer2.solid = false;
			_mountainLayer2.moves = false;
			_mountainLayer2.collideBottom = _mountainLayer2.collideLeft = _mountainLayer2.collideRight = _mountainLayer2.collideTop = false;
			add(_mountainLayer2);
			
			
			//foreground parallax layer.
			_foregroundLayer = new FlxSprite(0,112, ImgForegroundLayer);
			_foregroundLayer.scrollFactor = new FlxPoint(0,0);
			_foregroundLayer.solid = false;
			_foregroundLayer.moves = false;
			_foregroundLayer.collideBottom = _foregroundLayer.collideLeft = _foregroundLayer.collideRight = _foregroundLayer.collideTop = false;
			add(_foregroundLayer);
			
		/*	//prop parallax layer.
			_propLayer = new FlxSprite(0,0, ImgPropLayer);
			_propLayer.scrollFactor = new FlxPoint(0.4,0);
			_propLayer.solid = false;
			_propLayer.moves = false;
			_propLayer.collideBottom = _propLayer.collideLeft = _propLayer.collideRight = _propLayer.collideTop = false;
			add(_propLayer);*/
			
			//prop parallax layer.
			_propLayer = new FlxSprite(0,0, ImgPropLayer4096);
			_propLayer.scrollFactor = new FlxPoint(0.4,0);
			_propLayer.solid = false;
			_propLayer.moves = false;
			_propLayer.collideBottom = _propLayer.collideLeft = _propLayer.collideRight = _propLayer.collideTop = false;
			add(_propLayer);
			
			
			//prop parallax layer.
			_propLayer2 = new FlxSprite(_propLayer.width,0, ImgPropLayer);
			_propLayer2.scrollFactor = new FlxPoint(0.4,0);
			_propLayer2.solid = false;
			_propLayer2.moves = false;
			_propLayer2.collideBottom = _propLayer2.collideLeft = _propLayer2.collideRight = _propLayer2.collideTop = false;
			add(_propLayer2);
			
		
			
			backgrounds = new Array();
		//	backgrounds.push(_skyLayer);
	//		backgrounds.push(_foregroundLayer);
			backgrounds.push(_propLayer);
			
			backgrounds.push(_propLayer2);
			backgrounds.push(_cloudLayer2);
			backgrounds.push(_mountainLayer2);

			
			lightBoxFlashStage = 0;
			// lightbox
			lightBox = new FlxSprite(0,0, WhiteFlash);
			lightBox.scrollFactor = new FlxPoint(0,0);
			lightBox.solid = false;
			lightBox.moves = false;
			lightBox.alpha = 0;
			lightBox.collideBottom = lightBox.collideLeft = lightBox.collideRight = lightBox.collideTop = false;
			add(lightBox);	
			
			// load tile map
			map = new FlxTilemap();
			map.auto = FlxTilemap.OFF;
			map.loadMap(FlxTilemap.pngToCSV(ImgMap1,false,2),ImgTiles);
			map.follow(0);
			add(map);
			
			
			_bullets = new FlxGroup();	//Initializing the array is very important and easy to forget!
			for(var i : uint = 0; i < 32; i++)		//Create 32 bullets for the player to recycle
			{
				//load the Bullet class offscreen
				var s:FlxSprite = new Bullet( -100, -100);
				s.solid = true;
				s.exists = false;
				_bullets.add(s);	//Add it to the array of player bullets
			}
			add(_bullets); //add the group to the flixel rendering and updating engine
			
			// Player legs and torso are independant.
			_player = new PlayerDude(32,176);
			_player.solid = true;
			_player.moves = true;
			
			playerLegs = new PlayerLegs(32,176);
			playerLegs.solid = false;
			add(playerLegs);
			
			
			slowmo = false;
			slowmoStartValue = 0;
			slowmoTargetValue = slowmoIncrement = 1000;
			
			slowmoUI = new FlxSprite((FlxG.width/2) - 20, 154);
			slowmoUI.x = (FlxG.width/2) - (slowmoUI.width);
			slowmoUI.loadGraphic(SlowmoBar, true, false, 32, 6);
			slowmoUI.scrollFactor = new FlxPoint(0,0);
			slowmoUI.solid = false;
			slowmoUI.moves = false;
			slowmoUI.collideBottom = slowmoUI.collideLeft = slowmoUI.collideRight = slowmoUI.collideTop = false;
			add(slowmoUI);
			
			FlxG.follow(_player,15);
			FlxG.followAdjust(.3, 0);
			
			_player.giveBullets(_bullets.members);
			add(_player);
			
			_meteors = new FlxGroup();
			add(_meteors);
			
			_obstacles = new FlxGroup();
			add(_obstacles);
			
			_ufos = new FlxGroup();
			add(_ufos);			
			
			resetMeteorSpawnTimer();
			resetObstacleTimer();
			resetUfoTimer();
			
			_gibs = new FlxGroup();
			_baddieGroup = new FlxGroup();
			_goodieGroup = new FlxGroup();
			
			_baddieGroup.add(_meteors);
			_baddieGroup.add(_obstacles);
			
			_goodieGroup.add(_player);
			_goodieGroup.add(_bullets);
			
			
			baddies = new Array();
			
			
			//slow mode surround layer.
			slowModeSurround = new FlxSprite(0,0);
			slowModeSurround.loadGraphic(Surround, true, false, 256, 192);
			slowModeSurround.scrollFactor = new FlxPoint(0,0);
			slowModeSurround.solid = false;
			slowModeSurround.moves = false;
			slowModeSurround.addAnimation("flip", [0,1], 24, true);
			slowModeSurround.collideBottom = slowModeSurround.collideLeft = slowModeSurround.collideRight = slowModeSurround.collideTop = false;
			slowModeSurround.play("flip");
			add(slowModeSurround);
			slowModeSurround.visible = false;
		
			//Letter Box Top
			letterBoxTop = new FlxSprite(0,0, LetterBox);
			letterBoxTop.scrollFactor = new FlxPoint(0,0);
			letterBoxTop.solid = false;
			letterBoxTop.moves = false;
			letterBoxTop.collideBottom = letterBoxTop.collideLeft = letterBoxTop.collideRight = letterBoxTop.collideTop = false;
			add(letterBoxTop);
			
			//Letter Box Bottom
			letterBoxBottom = new FlxSprite(0,(FlxG.height - letterBoxTop.height ), LetterBox);
			letterBoxBottom.scrollFactor = new FlxPoint(0,0);
			letterBoxBottom.solid = false;
			letterBoxBottom.moves = false;
			letterBoxBottom.collideBottom = letterBoxBottom.collideLeft = letterBoxBottom.collideRight = letterBoxBottom.collideTop = false;
			add(letterBoxBottom);
			
			//rain layer.
			rainOverlay = new FlxSprite(0,0);
			rainOverlay.loadGraphic(Rain, true, false, 256, 192);
			rainOverlay.scrollFactor = new FlxPoint(0,0);
			rainOverlay.solid = false;
			rainOverlay.moves = false;
			rainOverlay.addAnimation("rain", [0,1,2,3], 12, true);
			rainOverlay.collideBottom = rainOverlay.collideLeft = rainOverlay.collideRight = rainOverlay.collideTop = false;
			rainOverlay.play("rain");
			add(rainOverlay);
			rainOverlay.visible = false;
			
			// Vignette
			vignetteOverlay = new FlxSprite(0,0, Vignette);
			vignetteOverlay.scrollFactor = new FlxPoint(0,0);
			vignetteOverlay.solid = false;
			vignetteOverlay.moves = false;
			vignetteOverlay.collideBottom = vignetteOverlay.collideLeft = vignetteOverlay.collideRight = vignetteOverlay.collideTop = false;
			add(vignetteOverlay);
			
			//Instructions and stuff
			
			
			_fps = new FlxText(FlxG.width-30,0,40).setFormat(null,8,0x778ea1,"right",0x233e58);
			_fps.scrollFactor.x = _fps.scrollFactor.y = 0;
			add(_fps);
			
			
			scoreText = new FlxText(2,letterBoxTop.height ,FlxG.width,"");
			scoreText.scrollFactor.x = scoreText.scrollFactor.y = 0;
			scoreText.color = 0x778ea1;
			scoreText.shadow = 0x233e58;
			add(scoreText);
			
			var tx:FlxText;
			tx = new FlxText(2,FlxG.height-12,FlxG.width,"");
			tx.scrollFactor.x = tx.scrollFactor.y = 0; 
			tx.color = 0x778ea1;
			tx.shadow = 0x233e58;
			add(tx);
			
			
			
			
		}
		
		
		private function disposeOfBaddie( baddie : FlxSprite, somethingElse : FlxObject) : void {
			baddie.kill();
		}
		
		private function randomRange(max:Number, min:Number = 0):Number
		{
			return Math.random() * (max - min) + min;
		}
		
		public function goToMainMenu( e : TimerEvent ) : void {
			endOfGameTimer.stop();
			FlxG.state = new EndGameState();
		}
		
		private function overlapBaddies(baddie:FlxSprite,goodie:FlxSprite):void
		{
			
			if ( (goodie is PlayerDude ) ) {
				playerLegs.kill();
				// player is dead - wait 1 second then transition to menu
				
				FlxG.timeScale = 1;
				endOfGameTimer = new Timer(1000);
				endOfGameTimer.addEventListener(TimerEvent.TIMER, goToMainMenu);
				endOfGameTimer.start();
				
				var emitter1:FlxEmitter = createScientistGibEmitter();
				emitter1.at(goodie);
			}
			
			if (goodie is Bullet ) {				
				
				if ( baddie is Meteor ) {
					FlxG.score += 100;
					var emitter:FlxEmitter = createEmitter();
					emitter.at(baddie);
				} else if ( baddie is Obstacle ) {
					if ( ( baddie as Obstacle ).obstacleType == Obstacle.STATE_SHEEP ) {
						FlxG.score += 50;
						var emitter2:FlxEmitter = createSheepEmitter();
						emitter2.at(baddie);
					}
				}
				
			}
			
			goodie.kill();
			baddie.kill();
			
			FlxG.quake.start(0.02);
		}
		
		private function createEmitter():FlxEmitter
		{
			var emitter:FlxEmitter = new FlxEmitter();
			emitter.delay = 1.5;
			emitter.gravity = 40;
			emitter.maxRotation = 0;
			emitter.setXSpeed(-100, 100);
			emitter.setYSpeed(-100, 100);
			
			var particles: int = 10;
			if (slowmo) {
				particles =5;
			}
			
			for(var i: int = 0; i < particles; i++)
			{
				var particle:FlxSprite = new FlxSprite();
				//particle.createGraphic(2, 2, 0xFF597137);
				particle.loadGraphic(ImgGibs);
				particle.exists = false;
				particle.collideBottom = true;
				particle.collideLeft = particle.collideRight = particle.collideTop = false;
				emitter.add(particle);
			}
			add(emitter);
			emitter.start();
			return emitter;
		}
		
		private function createSheepEmitter():FlxEmitter
		{
			var emitter:FlxEmitter = new FlxEmitter();
			emitter.delay = 1.5;
			emitter.gravity = 40;
			emitter.maxRotation = 0;
			emitter.setXSpeed(-100, 100);
			emitter.setYSpeed(-100, 100);
			
			var particles: int = 10;
			if (slowmo) {
				particles =5;
			}
			
			for(var i: int = 0; i < particles; i++)
			{
				var particle:FlxSprite = new FlxSprite();
				//particle.createGraphic(2, 2, 0xFF597137);
				particle.loadGraphic(ImgSheepGibs);
				particle.exists = false;
				particle.collideBottom = true;
				particle.collideLeft = particle.collideRight = particle.collideTop = false;
				emitter.add(particle);
			}
			add(emitter);
			emitter.start();
			return emitter;
		}
		
		private function createScientistGibEmitter():FlxEmitter
		{
			var emitter:FlxEmitter = new FlxEmitter();
			emitter.delay = 1.5;
			emitter.gravity = -2;
			emitter.maxRotation = 0;
			emitter.setXSpeed(-50, 50);
			emitter.setYSpeed(-50, 50);
			var particles: int = 5;
			if ( slowmo ) {
				particles = 3;
			}
			for(var i: int = 0; i < particles; i++)
			{
				var particle:FlxSprite = new FlxSprite();
				//particle.createGraphic(2, 2, 0xFF597137);
				particle.loadGraphic(ImgScientistGibs);
				particle.exists = false;
				particle.collideBottom = true;
				particle.collideLeft = particle.collideRight = particle.collideTop = false;
				emitter.add(particle);
			}
			add(emitter);
			emitter.start();
			return emitter;
		}
		
		private function spawnMeteor():void
		{
			// Enemy ship starts on right off screen
			var x: Number = FlxG.width + ( -1 * FlxG.scroll.x  ) + 100;
			
			// Meteor starts at ceiling
			var y: Number = 0;
			
			var meteor:Meteor = new Meteor(x, y);
			baddies.push(meteor);
			_meteors.add(meteor);
		}
		
		
		private function resetMeteorSpawnTimer():void
		{
			// Reset the count down timer
			_meteorSpawnTimer = Math.random() * _meteorSpawnInterval + 0.5;		
		}
		
		private function spawnObstacle():void
		{
			//start on the ground at right of screen.
			var x: Number = FlxG.width + ( -1 * FlxG.scroll.x ) ;
			
			//start and stay on the ground
			var y: Number = 136;
			
			var obstacle:Obstacle = new Obstacle(x, y);
			baddies.push(obstacle);
			_obstacles.add(obstacle);		
		}
		
		private function resetObstacleTimer():void
		{
			// Reset the count down timer
			_obstacleSpawnTimer = _obstacleSpawnInterval;		
		}
		
		private function spawnUfo():void
		{
			//start on the ground at right of screen.
			var x: Number = _player.x - 100;
			
			//start and stay on the ground
			var y: Number = 0;
			
			var ufo : UFO = new UFO(x, y);
			baddies.push(ufo);
			_ufos.add(ufo);		
			
			FlxG.log("SPAWNED UFO");
		}
		
		private function resetUfoTimer():void
		{
			// Reset the count down timer
			_ufoSpawnTimer = _ufoSpawnInterval;		
		}
		
		
		private function manageBackgrounds() : void {
			for ( var i:uint = 0; i < backgrounds.length; i++) {
				var background : FlxSprite = ( backgrounds[i] as FlxSprite );
				if ( ( background.getScreenXY().x + background.width  ) <= 10 ) {
			
					if ( background == _propLayer ) {
						_propLayer.x = _propLayer2.x + _propLayer2.width;
					} else if ( background == _propLayer2 ) {
						_propLayer2.x = _propLayer.x + _propLayer.width;
					} else if ( background == _cloudLayer ) {
						_cloudLayer.x = _cloudLayer2.x + _cloudLayer2.width;
					} else if ( background == _cloudLayer2 ) {
						_cloudLayer2.x = _cloudLayer.x + _cloudLayer.width;
					} else if ( background == _mountainLayer ) {
						_mountainLayer.x = _mountainLayer2.x + _mountainLayer2.width;
					} else if ( background == _mountainLayer2 ) {
						_mountainLayer2.x = _mountainLayer.x + _mountainLayer.width;
					} 
					
				}
			}
		}
		
		public function startSlowmo() : void {
			
			FlxG.music.stop();
			//Play background music
			FlxG.playMusic(slowMusic);
			//
			lightBox.alpha = 1;
			
			slowModeSurround.visible = true;
			
			//FlxG.flash.start(0xffffffff, 1);
			slowmo = true;
			slowmoTimer = new Timer(5000);
			slowmoTimer.addEventListener(TimerEvent.TIMER, stopSlowmo);
			slowmoTimer.start();
			slowmoTargetValue = 99999;
			FlxG.timeScale = 0.25;
			
			for ( var i : Number = 0; i < 5; i ++) {
				spawnMeteor();
			}
			
			
		}
		
		public function stopSlowmo( e : TimerEvent ) : void {
			
			FlxG.music.stop();
			//Play background music
			FlxG.playMusic(mainMusic);
			
			slowmoTimer.stop();
			FlxG.timeScale = 1;
			slowmoStartValue = FlxG.score;
			slowmoTargetValue = slowmoStartValue += slowmoIncrement;
			
			slowModeSurround.visible = false;
			
			lightBoxFlashTimer = new Timer(10);
			lightBoxFlashTimer.addEventListener(TimerEvent.TIMER, letterBoxFlash);
			lightBoxFlashTimer.start();	
			
		}
		
		public function letterBoxFlash( e : TimerEvent ) : void {
			FlxG.log('reduce' + lightBox.alpha);
			lightBox.alpha -= .1;
			if ( lightBox.alpha <= 0) {
				lightBox.alpha = 0;
				lightBoxFlashTimer.stop();
			}
		}
		
		public function updateSlowmoUI ( ) : void {
			// first update the ui 
			var segmentsPercentage : Number = Math.floor (  (FlxG.score - slowmoStartValue) / (slowmoTargetValue - slowmoStartValue) * 100 );
			if ( segmentsPercentage >= 100 ) {
				slowmoUI.frame = 8;
				startSlowmo();
			} else if ( segmentsPercentage >= 87.5 ) {
				slowmoUI.frame = 7;
			} else if ( segmentsPercentage >= 75 ) {
				slowmoUI.frame = 6;
			} else if ( segmentsPercentage >= 62.5 ) {
				slowmoUI.frame = 5;
			} else if ( segmentsPercentage >= 50 ) {
				slowmoUI.frame = 4;
			} else if ( segmentsPercentage >= 37.5 ) {
				slowmoUI.frame = 3;
			} else if ( segmentsPercentage >= 25 ) {
				slowmoUI.frame = 2;
			} else if ( segmentsPercentage >= 12.5 ) {
				slowmoUI.frame = 1;
			} else  {
				slowmoUI.frame = 0;
			}
		}
		
		override public function update():void
		{
			// text updates
			_fps.text = FlxU.floor(1/FlxG.elapsed)+" fps";
			
			
			
			// count down to new meteor
			_meteorSpawnTimer -= FlxG.elapsed;
			if(_meteorSpawnTimer < 0)
			{
				spawnMeteor();
				resetMeteorSpawnTimer();
			}
			
			
			//count for new ground object
			_obstacleSpawnTimer -= FlxG.elapsed;
			if (_obstacleSpawnTimer < 0)
			{
				spawnObstacle();
				resetObstacleTimer();
			}
			
			_ufoSpawnTimer -= FlxG.elapsed;
			if ( _ufoSpawnTimer < 0)
			{
				spawnUfo();
				resetUfoTimer();
			}
			
			
			for ( var i: uint = 0; i < baddies.length; i++) {
				if ( baddies[i] is Meteor ) {
					var meteor : Meteor = ( baddies[i] as Meteor);
					if ( meteor.y >= 134 ) {
						//if ( meteor.collide(map)) {
						meteor.kill();
						baddies.splice(i, 1);
						FlxG.quake.start(0.02);
						
						var emitter:FlxEmitter = createEmitter();
						emitter.at(meteor);
					}
				}
				
			}
			
			manageBackgrounds()
			
			FlxU.collide(_player, map);
			FlxU.overlap(_baddieGroup, _goodieGroup,  overlapBaddies);
			//	FlxU.overlap(_obstacles, _player, overlapBaddies);
			//FlxU.overlap(_meteors, map, disposeOfBaddie);
			
			
			FlxG.score++;
			scoreText.text = "" + FlxG.score;
			
			super.update();
			
			updateSlowmoUI();
			
			
			if ( _player.x != playerLegs.x ) {
				playerLegs.x = _player.x;
			}
			if ( _player.y != playerLegs.y) {
				playerLegs.y = _player.y;
			}
			
			//collide();
		}
		
	}
}
