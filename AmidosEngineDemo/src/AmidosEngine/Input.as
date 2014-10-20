package AmidosEngine 
{
	import flash.geom.Point;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	/**
	 * ...
	 * @author Amidos
	 */
	public class Input 
	{
		internal static var pressFunction:Vector.<Function>;
		internal static var moveFunction:Vector.<Function>;
		internal static var releaseFunction:Vector.<Function>;
		internal static var numberOfTouches:int;
		internal static var pressedKeys:Array;
		internal static var keyboardKeys:Array;
		
		internal static function Initialize():void
		{
			pressFunction = new Vector.<Function>();
			moveFunction = new Vector.<Function>();
			releaseFunction = new Vector.<Function>();
			
			pressedKeys = new Array();
			keyboardKeys = new Array();
			for (var i:int = 0; i < 256; i++) 
			{
				pressedKeys[i] = KeyStatus.UP;
				keyboardKeys[i] = KeyStatus.UP;
			}
			
			numberOfTouches = 0;
		}
		
		/**
		 * Add a Function that would be called when a finger just touch the screen
		 * @param	f should be function(tX:Number, tY:Number, tID:int):void where tX is the touch X position tY is the touch Y position and tID is a unique id for that touch
		 */
		public static function AddPressFunction(f:Function):void
		{
			pressFunction.push(f);
		}
		
		/**
		 * Remove a specific press function
		 * @param	f required to be removed
		 */
		public static function RemovePressFunction(f:Function):void
		{
			var index:int = pressFunction.indexOf(f);
			pressFunction.splice(index, 1);
		}
		
		/**
		 * Remove all press functions event handlers
		 */
		public static function RemoveAllPressFunction():void
		{
			pressFunction.length = 0;
		}
		
		/**
		 * Add a Function that would be called when a touching finger moves on screen
		 * @param	f should be function(tX:Number, tY:Number, tID:int):void where tX is the touch X position tY is the touch Y position and tID is a unique id for that touch
		 */
		public static function AddMoveFunction(f:Function):void
		{
			moveFunction.push(f);
		}
		
		/**
		 * Remove specific move function
		 * @param	f required to be removed
		 */
		public static function RemoveMoveFunction(f:Function):void
		{
			var index:int = moveFunction.indexOf(f);
			moveFunction.splice(index, 1);
		}
		
		/**
		 * Remove all move functions event handlers
		 */
		public static function RemoveAllMoveFunction():void
		{
			moveFunction.length = 0;
		}
		
		/**
		 * Add a Function that would be called when a touched finger just go out of screen
		 * @param	f should be function(tX:Number, tY:Number, tID:int):void where tX is the touch X position tY is the touch Y position and tID is a unique id for that touch
		 */
		public static function AddReleaseFunction(f:Function):void
		{
			releaseFunction.push(f);
		}
		
		/**
		 * Remove a specific release function
		 * @param	f required to be removed
		 */
		public static function RemoveReleaseFunction(f:Function):void
		{
			var index:int = releaseFunction.indexOf(f);
			releaseFunction.splice(index, 1);
		}
		
		/**
		 * Remove all release functions event handlers
		 */
		public static function RemoveAllReleaseFunction():void
		{
			releaseFunction.length = 0;
		}
		
		/**
		 * Get KeyStatus for specific keyboard key
		 * @param	key required to check its status
		 * @return current status of keyboard key (KeyStatus.PRESS, KeyStatus.DOWN, KeyStatus.RELEASE, KeyStatus.UP)
		 */
		public static function GetKeyStatus(key:int):int
		{
			return keyboardKeys[key];
		}
		
		/**
		 * Make keyboard is if it is not pressed
		 */
		public static function RemoveAllPressedKeys():void
		{
			for (var i:int = 0; i < keyboardKeys.length; i++) 
			{
				pressedKeys[i] = false;
				keyboardKeys[i] = KeyStatus.UP;
			}
		}
		
		/**
		 * Get number of fingers on screen
		 * @return integer value show number of touches on screen
		 */
		public static function get NumberOfTouches():int
		{
			return numberOfTouches;
		}
		
		internal static function onKeyDown(event:KeyboardEvent):void
		{
			pressedKeys[event.keyCode] = true;
		}
		
		internal static function onKeyUp(event:KeyboardEvent):void
		{
			pressedKeys[event.keyCode] = false;
		}
		
		internal static function UpdateKeys():void
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
		}
		
		internal static function onTouch(event:TouchEvent):void
		{
			var touches:Vector.<Touch> = event.getTouches(AE.game, TouchPhase.BEGAN);
			var i:int = 0;
			var j:int = 0;
			var localPos:Point;
			
			numberOfTouches += touches.length;
			if (touches.length > 0)
			{
				for (i = 0; i < touches.length; i++) 
				{
					localPos = touches[i].getLocation(AE.game);
					for (j = 0; j < Input.pressFunction.length; j++) 
					{
						Input.pressFunction[j](localPos.x, localPos.y, touches[i].id);
					}
				}
			}
			
			touches = event.getTouches(AE.game, TouchPhase.MOVED);
			i = 0;
			j = 0;
			if (touches.length > 0)
			{
				for (i = 0; i < touches.length; i++) 
				{
					localPos = touches[i].getLocation(AE.game);
					for (j = 0; j < Input.moveFunction.length; j++) 
					{
						Input.moveFunction[j](localPos.x, localPos.y, touches[i].id);
					}
				}
			}
			
			touches = event.getTouches(AE.game, TouchPhase.ENDED);
			i = 0;
			j = 0;
			numberOfTouches -= touches.length;
			if (touches.length > 0)
			{
				for (i = 0; i < touches.length; i++) 
				{
					localPos = touches[i].getLocation(AE.game);
					for (j = 0; j < Input.releaseFunction.length; j++) 
					{
						Input.releaseFunction[j](localPos.x, localPos.y, touches[i].id);
					}
				}
			}
		}
	}

}