package AmidosEngine 
{
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	/**
	 * Spritemap that can be used for animation
	 * @author Amidos
	 */
	public class Spritemap extends Sprite
	{
		private var animations:Array;
		private var currentAnimation:String;
		private var endFunction:Function;
		
		private var localScaleX:Number;
		private var localScaleY:Number;
		private var localRotation:Number;
		private var localPivotX:Number;
		private var localPivotY:Number;
		private var localWidth:Number;
		private var localHeight:Number;
		private var localAlpha:Number;
		private var localSmoothing:String;
		
		/**
		 * Set x origin
		 */
		override public function set pivotX(value:Number):void 
		{
			localPivotX = value;
			UpdateAllAnimation();
		}
		
		/**
		 * Get x origin
		 */
		override public function get pivotX():Number 
		{
			return localPivotX;
		}
		
		/**
		 * Set y origin
		 */
		override public function set pivotY(value:Number):void 
		{
			localPivotY = value;
			UpdateAllAnimation();
		}
		
		/**
		 * Get y origin
		 */
		override public function get pivotY():Number 
		{
			return localPivotY;
		}
		
		/**
		 * Set x scale
		 */
		override public function set scaleX(value:Number):void 
		{
			localScaleX = value;
			UpdateAllAnimation();
		}
		
		/**
		 * Get x scale
		 */
		override public function get scaleX():Number 
		{
			return localScaleX;
		}
		
		/**
		 * Set y scale
		 */
		override public function set scaleY(value:Number):void 
		{
			localScaleY = value;
			UpdateAllAnimation();
		}
		
		/**
		 * Get y scale
		 */
		override public function get scaleY():Number 
		{
			return localScaleY;
		}
		
		/**
		 * Set rotation in radians
		 */
		override public function set rotation(value:Number):void 
		{
			localRotation = value;
			UpdateAllAnimation();
		}
		
		/**
		 * Get rotation in radians
		 */
		override public function get rotation():Number 
		{
			return localRotation;
		}
		
		/**
		 * set current alpha of the spritemap
		 */
		override public function set alpha(value:Number):void 
		{
			localAlpha = value;
			UpdateAllAnimation();
		}
		
		/**
		 * get current alpha of the spritemap
		 */
		override public function get alpha():Number 
		{
			return localAlpha;
		}
		
		/**
		 * set if smoothing the picture should be used on scaling
		 */
		public function set smoothing(value:String):void 
		{
			localSmoothing = value;
			UpdateAllAnimation();
		}
		
		/**
		 * get if smoothing the picture should be used on scaling
		 */
		public function get smoothing():String 
		{
			return localSmoothing;
		}
		
		/**
		 * the name of the played animation
		 */
		public function get CurrentAnimation():String
		{
			return this.currentAnimation;
		}
		
		/**
		 * the number of the played frame
		 */
		public function get currentFrame():int
		{
			if (currentAnimation != "")
			{
				return animations[currentAnimation].currentFrame;
			}
			
			return -1;
		}
		
		/**
		 * Set the current width of the spritemap
		 */
		override public function set width(value:Number):void 
		{
			localWidth = value;
		}
		
		/**
		 * Get the current width of the spritemap (scale is applied to the value)
		 */
		override public function get width():Number 
		{
			return localWidth * localScaleX;
		}
		
		/**
		 * Set the current height of the spritemap
		 */
		override public function set height(value:Number):void 
		{
			localHeight = value;
		}
		
		/**
		 * Get the current height of the spritemap (scale is applied to the value)
		 */
		override public function get height():Number 
		{
			return localHeight * localScaleY;
		}
		
		private function UpdateAllAnimation():void
		{
			for each (var movieClip:MovieClip in animations) 
			{
				movieClip.pivotX = localPivotX;
				movieClip.pivotY = localPivotY;
				movieClip.scaleX = localScaleX;
				movieClip.scaleY = localScaleY;
				movieClip.rotation = localRotation;
				movieClip.alpha = localAlpha;
				movieClip.smoothing = localSmoothing;
			}
		}
		
		/**
		 * Align the center point
		 * @param	hAlign the horizontal alignment (center, left, right)
		 * @param	vAlign the vertical alignment (center, top, bottom)
		 */
		override public function alignPivot(hAlign:String = "center", vAlign:String = "center"):void 
		{
			switch (hAlign) 
			{
				case HAlign.CENTER:
					localPivotX = localWidth / 2;
					break;
				case HAlign.LEFT:
					localPivotX = 0;
					break;
				case HAlign.RIGHT:
					localPivotX = localWidth;
					break;
			}
			
			switch (vAlign) 
			{
				case VAlign.CENTER:
					localPivotY = localHeight / 2;
					break;
				case VAlign.TOP:
					localPivotY = 0;
					break;
				case VAlign.BOTTOM:
					localPivotY = localHeight;
					break;
			}
			
			UpdateAllAnimation();
		}
		
		/**
		 * Create a spritemap that can be used in animation
		 * Requires a texture atlas sheet before using it
		 * @param	w width of the sprite in the sheet
		 * @param	h height of the sprite in the sheet
		 * @param	animationEnd called on animation ends when not looping
		 */
		public function Spritemap(w:Number, h:Number, animationEnd:Function = null) 
		{
			localPivotX = 0;
			localPivotY = 0;
			localScaleX = 1;
			localScaleY = 1;
			localRotation = 0;
			localAlpha = 1;
			localSmoothing = "bilinear";
			
			localWidth = w;
			localHeight = h;
			
			currentAnimation = "";
			endFunction = animationEnd;
			animations = new Array();
		}
		
		/**
		 * Add new animation to the spritemap
		 * @param	animationName prefix of the animation in the texture atlas
		 * @param	fps frames per second to play the animation (can't be zero)
		 * @param	looping if the animation will loop or not
		 */
		public function AddAnimation(animationName:String, fps:Number = 1, looping:Boolean = true):void
		{
			var movieClip:MovieClip = new MovieClip(AE.assetManager.getTextures(animationName), fps);
			movieClip.loop = looping;
			movieClip.pivotX = localPivotX;
			movieClip.pivotY = localPivotY;
			movieClip.scaleX = localScaleX;
			movieClip.scaleY = localScaleY;
			movieClip.rotation = localRotation;
			movieClip.alpha = localAlpha;
			movieClip.smoothing = localSmoothing;
			animations[animationName] = movieClip;
		}
		
		/**
		 * Play a specific animation
		 * @param	animationName name of animation to be played (must be added first)
		 * @param	reset start the animation from the beginning if calling the function
		 */
		public function PlayAnimation(animationName:String, reset:Boolean = false):void
		{
			if (currentAnimation != animationName)
			{
				StopAnimation();
				currentAnimation = animationName;
				
				animations[currentAnimation].addEventListener(Event.COMPLETE, EndAnimation);
				addChild(animations[currentAnimation]);
				animations[currentAnimation].play();
				Starling.current.juggler.add(animations[currentAnimation]);
			}
			else if (reset)
			{
				animations[currentAnimation].stop();
				animations[currentAnimation].play();
			}
		}
		
		private function EndAnimation(e:Event):void
		{
			if (!animations[currentAnimation].loop && endFunction != null)
			{
				PauseAnimation();
				endFunction();
			}
		}
		
		/**
		 * Pause current animation
		 */
		public function PauseAnimation():void
		{
			animations[currentAnimation].pause();
		}
		
		/**
		 * Resume current paused animation
		 */
		public function ResumeAnimation():void
		{
			animations[currentAnimation].play();
		}
		
		/**
		 * Stop current played animation so nothing is played
		 */
		public function StopAnimation():void
		{
			if (currentAnimation != "")
			{
				animations[currentAnimation].removeEventListener(Event.COMPLETE, EndAnimation);
				animations[currentAnimation].stop();
				removeChild(animations[currentAnimation]);
				Starling.current.juggler.remove(animations[currentAnimation]);
			}
			
			currentAnimation = "";
		}
	}

}