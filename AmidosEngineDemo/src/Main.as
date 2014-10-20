package 
{
	import AmidosEngine.AE;
	import AmidosEngine.Game;
	import AmidosEngine.LoadingWorld;
	import Demo.GameWorld.DemoWorld;
	import Demo.GameData.*
	import flash.display.Bitmap;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import starling.core.Starling;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Amidos
	 */
	public class Main extends Sprite 
	{
		[Embed(source="../assests/Loading/1024.png")]private var ipadClass:Class;
		[Embed(source="../assests/Loading/1136.png")]private var iphone5Class:Class;
		[Embed(source="../assests/Loading/960.png")]private var iphone4Class:Class;
		
		public static const FRAMERATE:int = 30;
		public static const GAME_SCALE:Number = 2;
		
		private var mStarling:Starling;
		private var currentLoadingScreen:Bitmap;
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.BEST;
			
			stage.addEventListener(flash.events.Event.DEACTIVATE, deactivate);
			stage.addEventListener(flash.events.Event.ACTIVATE, activate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// entry point
			AE.Initialize();
			
			var screenWidth:int = stage.stageWidth;
			var screenHeight:int = stage.stageHeight;
			
			//For Covering the loading
			if (screenWidth < 980)
			{
				currentLoadingScreen = new iphone4Class();
			}
			else if (screenWidth / screenHeight == 4 / 3)
			{
				currentLoadingScreen = new ipadClass();
			}
			else
			{
				currentLoadingScreen = new iphone5Class();
			}
			currentLoadingScreen.smoothing = true;
			currentLoadingScreen.scaleX = screenWidth / currentLoadingScreen.width;
			currentLoadingScreen.scaleY = screenHeight / currentLoadingScreen.height;
			currentLoadingScreen.x = -(currentLoadingScreen.width - screenWidth) / 2;
			
			stage.addChild(currentLoadingScreen);
			
			Starling.multitouchEnabled = true;
			Starling.handleLostContext = true;
			
			mStarling = new Starling(Game, stage, new Rectangle(0, 0, screenWidth, screenHeight));
			mStarling.addEventListener(starling.events.Event.ROOT_CREATED, gameStarted);
			mStarling.stage.stageWidth = screenWidth / GAME_SCALE;
			mStarling.stage.stageHeight = screenHeight / GAME_SCALE;
			//uncomment next line if you want to see the fps
			//mStarling.showStatsAt("right", "top", 2);
			mStarling.start();
		}
		
		private function gameStarted(e:starling.events.Event):void
		{
			mStarling.removeEventListener(starling.events.Event.ROOT_CREATED, gameStarted);
			//Set background color
			AE.game.background.color = 0xFFCCCCCC;
			
			AE.assetManager.enqueue(EmbeddedGraphics);
			AE.assetManager.enqueue(EmbeddedSounds);
			AE.assetManager.enqueue(EmbeddedData);
			AE.assetManager.loadQueue(loadingFunction);
		}
		
		private function deactivate(e:flash.events.Event):void 
		{
			//when game lose focus
		}
		
		private function activate(e:flash.events.Event):void 
		{
			//when game gets focus
		}
		
		private function loadingFunction(ratio:Number):void
		{
			if (ratio == 1)
			{
				//Playing with camera parameter
				AE.game.gameCamera.zoomX = 5;
				AE.game.gameCamera.zoomY = 5;
				AE.game.gameCamera.rotation = Math.PI / 6;
				AE.game.gameCamera.x = -20;
				AE.game.gameCamera.y = 20;
				
				AE.game.ActiveWorld = new LoadingWorld(new DemoWorld() ,currentLoadingScreen);
			}
		}
		
	}
	
}