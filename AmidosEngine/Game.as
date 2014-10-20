package AmidosEngine
{
	import flash.geom.Point;
	import starling.animation.DelayedCall;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.TouchEvent;
	/**
	 * Main Game Object
	 * @author Amidos
	 */
	public class Game extends Sprite
	{
		/**
		 * Current background render after everything
		 */
		public var background:Quad;
		/**
		 * Current in game camera
		 */
		public var gameCamera:GameCamera;
		
		internal var currentWorld:World;
		internal var nextWorld:World;
		internal var stageWidth:int;
		internal var stageHeight:int;
		
		/**
		 * Get current active world
		 */
		public function get ActiveWorld():World
		{
			return currentWorld;
		}
		
		/**
		 * Set current active world
		 */
		public function set ActiveWorld(world:World):void
		{
			nextWorld = world;
		}
		
		/**
		 * Get the width of the game world
		 */
		public override function get width():Number
		{
			return stageWidth;
		}
		
		/**
		 * Set the width of the game world
		 */
		public override function set width(value:Number):void
		{
			this.stageWidth = value;
			Starling.current.stage.stageWidth = this.stageWidth;
		}
		
		/**
		 * Get the height of the game world
		 */
		public override function get height():Number
		{
			return stageHeight;
		}
		
		/**
		 * Set the height of the game world
		 */
		public override function set height(value:Number):void
		{
			this.stageHeight = value;
			Starling.current.stage.stageHeight = this.stageHeight;
		}
		
		public function Game() 
		{
			background = new Quad(Starling.current.stage.stageWidth, Starling.current.stage.stageHeight, 0xFF000000);
			addChild(background);
			
			gameCamera = new GameCamera(Starling.current.stage.stageWidth, Starling.current.stage.stageHeight);
			
			this.addEventListener(TouchEvent.TOUCH, Input.onTouch);
			this.addEventListener(KeyboardEvent.KEY_DOWN, Input.onKeyDown);
			this.addEventListener(KeyboardEvent.KEY_UP, Input.onKeyUp);
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, update);
			
			this.stageWidth = Starling.current.stage.stageWidth;
			this.stageHeight = Starling.current.stage.stageHeight;
			
			AE.game = this;
		}
		
		private function update(event:EnterFrameEvent):void
		{
			if (currentWorld != null)
			{
				Input.UpdateKeys();
				
				currentWorld.update(event.passedTime);
			}
			
			if (nextWorld != null)
			{
				if (currentWorld != null)
				{
					currentWorld.end();
					removeChild(currentWorld);
				}
				
				Input.RemoveAllPressFunction();
				Input.RemoveAllMoveFunction();
				Input.RemoveAllReleaseFunction();
				Input.RemoveAllPressedKeys();
				
				nextWorld.begin();
				addChild(nextWorld);
				
				currentWorld = nextWorld;
				nextWorld = null;
			}
		}
	}
}