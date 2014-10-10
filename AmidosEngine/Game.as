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
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
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
		internal var numberOfTouches:int;
		internal var stageWidth:int;
		internal var stageHeight:int;
		internal var pressedKeys:Array;
		internal var keyboardKeys:Array;
		
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
			numberOfTouches = 0;
			
			pressedKeys = new Array();
			keyboardKeys = new Array();
			for (var i:int = 0; i < 256; i++) 
			{
				pressedKeys[i] = KeyStatus.UP;
				keyboardKeys[i] = KeyStatus.UP;
			}
			
			this.addEventListener(TouchEvent.TOUCH, onTouch);
			this.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			this.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, update);
			
			this.stageWidth = Starling.current.stage.stageWidth;
			this.stageHeight = Starling.current.stage.stageHeight;
			
			AE.game = this;
		}
		
		private function update(event:EnterFrameEvent):void
		{
			if (currentWorld != null)
			{
				for (var i:int = 0; i < keyboardKeys.length; i++) 
				{
					switch (keyboardKeys[i]) 
					{
						case KeyStatus.UP:
							if (pressedKeys[i])
							{
								keyboardKeys[i] = KeyStatus.PRESS;
							}
							break;
						case KeyStatus.PRESS:
							if (pressedKeys[i])
							{
								keyboardKeys[i] = KeyStatus.DOWN;
							}
							else
							{
								keyboardKeys[i] = KeyStatus.RELEASE;
							}
							break;
						case KeyStatus.DOWN:
							if (!pressedKeys[i])
							{
								keyboardKeys[i] = KeyStatus.RELEASE;
							}
							break;
						case KeyStatus.RELEASE:
							if (pressedKeys[i])
							{
								keyboardKeys[i] = KeyStatus.PRESS;
							}
							else
							{
								keyboardKeys[i] = KeyStatus.UP;
							}
							break;
					}
				}
				
				currentWorld.update(event.passedTime);
			}
			
			if (nextWorld != null)
			{
				if (currentWorld != null)
				{
					currentWorld.end();
					removeChild(currentWorld);
				}
				
				AE.RemoveAllPressFunction();
				AE.RemoveAllMoveFunction();
				AE.RemoveAllReleaseFunction();
				
				for (i = 0; i < keyboardKeys.length; i++) 
				{
					pressedKeys[i] = false;
					keyboardKeys[i] = KeyStatus.UP;
				}
				
				nextWorld.begin();
				addChild(nextWorld);
				
				currentWorld = nextWorld;
				nextWorld = null;
			}
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			pressedKeys[event.keyCode] = true;
		}
		
		private function onKeyUp(event:KeyboardEvent):void
		{
			pressedKeys[event.keyCode] = false;
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touches:Vector.<Touch> = event.getTouches(this, TouchPhase.BEGAN);
			var i:int = 0;
			var j:int = 0;
			var localPos:Point;
			
			numberOfTouches += touches.length;
			if (touches.length > 0)
			{
				for (i = 0; i < touches.length; i++) 
				{
					localPos = touches[i].getLocation(this);
					for (j = 0; j < AE.pressFunction.length; j++) 
					{
						AE.pressFunction[j](localPos.x, localPos.y, touches[i].id);
					}
				}
			}
			
			touches = event.getTouches(this, TouchPhase.MOVED);
			i = 0;
			j = 0;
			if (touches.length > 0)
			{
				for (i = 0; i < touches.length; i++) 
				{
					localPos = touches[i].getLocation(this);
					for (j = 0; j < AE.moveFunction.length; j++) 
					{
						AE.moveFunction[j](localPos.x, localPos.y, touches[i].id);
					}
				}
			}
			
			touches = event.getTouches(this, TouchPhase.ENDED);
			i = 0;
			j = 0;
			numberOfTouches -= touches.length;
			if (touches.length > 0)
			{
				for (i = 0; i < touches.length; i++) 
				{
					localPos = touches[i].getLocation(this);
					for (j = 0; j < AE.releaseFunction.length; j++) 
					{
						AE.releaseFunction[j](localPos.x, localPos.y, touches[i].id);
					}
				}
			}
		}
	}

}