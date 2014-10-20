package AmidosEngine 
{
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	/**
	 * a button class where it make using the buttons more easy
	 * @author Amidos
	 */
	public class ButtonEntity extends Entity
	{
		private const STARTING_HOLD_TIMER:Number = 0.5;
		private const HOLD_TIMER:Number = 0.1;
		
		/// a function called when the button is just pressed
		public var pressFunction:Function;
		/// a function called when you keep pressing on the button
		public var holdFunction:Function;
		/// a function called when you are pressing then you move your finger outside 
		public var moveOutFunction:Function;
		/// a function called when you just disable the button (mark as inactive)
		public var disableFunction:Function;
		/// a function called when you just release you touch from the button
		public var releaseFunction:Function;
		/// means the button is active and can be pressed
		public var active:Boolean;
		
		private var currentID:int;
		private var startHoldTimer:DelayedCall;
		private var holdTimer:DelayedCall;
		
		public function get IsPressed():Boolean
		{
			return currentID != -1;
		}
		
		/**
		 * You have to set the graphic variable and set hibox and add some event handlers
		 */
		public function ButtonEntity() 
		{
			active = true;
			currentID = -1;
			startHoldTimer = new DelayedCall(EnableHoldTimer, STARTING_HOLD_TIMER);
			holdTimer = new DelayedCall(ButtonDown, HOLD_TIMER);
			useCamera = false;
		}
		
		override public function add():void 
		{
			super.add();
			
			ButtonOut();
			Input.AddPressFunction(PressHandle);
			Input.AddMoveFunction(MoveHandle);
			Input.AddReleaseFunction(ReleaseHandle);
		}
		
		override public function remove():void 
		{
			super.remove();
			
			Input.RemovePressFunction(PressHandle);
			Input.RemoveMoveFunction(MoveHandle);
			Input.RemoveReleaseFunction(ReleaseHandle);
		}
		
		private function PressHandle(mX:Number, mY:Number, id:int):void
		{
			if (!active)
			{
				return;
			}
			
			if (currentID == -1 && collidePoint(mX, mY, x, y))
			{
				currentID = id;
				if (pressFunction != null)
				{
					pressFunction();
				}
				startHoldTimer.repeatCount = 1;
				startHoldTimer.reset(EnableHoldTimer, STARTING_HOLD_TIMER);
				Starling.current.juggler.add(startHoldTimer);
				ButtonIn();
			}
		}
		
		private function MoveHandle(mX:Number, mY:Number, id:int):void
		{
			if (!active)
			{
				return;
			}
			
			if (id == currentID && !collidePoint(mX, mY, x, y))
			{
				currentID = -1;
				if (moveOutFunction != null)
				{
					moveOutFunction();
				}
				Starling.current.juggler.remove(startHoldTimer);
				Starling.current.juggler.remove(holdTimer);
				ButtonOut();
			}
			
			if (currentID == -1 && collidePoint(mX, mY, x, y))
			{
				currentID = id;
				if (pressFunction != null)
				{
					pressFunction();
				}
				startHoldTimer.repeatCount = 1;
				startHoldTimer.reset(EnableHoldTimer, STARTING_HOLD_TIMER);
				Starling.current.juggler.add(startHoldTimer);
				ButtonIn();
			}
		}
		
		private function ReleaseHandle(mX:Number, mY:Number, id:int):void
		{
			if (!active)
			{
				return;
			}
			
			if (id == currentID && collidePoint(mX, mY, x, y))
			{
				currentID = -1;
				if (releaseFunction != null)
				{
					releaseFunction();
				}
				Starling.current.juggler.remove(startHoldTimer);
				Starling.current.juggler.remove(holdTimer);
				ButtonOut();
			}
		}
		
		private function EnableHoldTimer():void
		{
			holdTimer.reset(ButtonDown, HOLD_TIMER);
			holdTimer.repeatCount = 0;
			Starling.current.juggler.add(holdTimer);
		}
		
		/**
		 * a function called when the button is pressed (use for dicoration)
		 */
		protected function ButtonIn():void
		{
			
		}
		
		/**
		 * a function called when the button is not pressed (use for dicoration)
		 */
		protected function ButtonOut():void
		{
			
		}
		
		private function ButtonDown():void
		{
			if (holdFunction != null)
			{
				holdFunction();
			}
		}
		
		override public function update(dt:Number):void 
		{
			super.update(dt);
			
			if (!visible)
			{
				active = false;
			}
			if (!active)
			{
				if (currentID != -1 && disableFunction != null)
				{
					disableFunction();
				}
				currentID = -1;
				Starling.current.juggler.remove(startHoldTimer);
				Starling.current.juggler.remove(holdTimer);
				ButtonOut();
			}
		}
	}

}