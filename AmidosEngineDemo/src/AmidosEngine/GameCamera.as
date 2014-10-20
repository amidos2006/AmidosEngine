package AmidosEngine 
{
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * In Game Camera Don't Create object from it
	 * @author Amidos
	 */
	public class GameCamera 
	{
		private var localWidth:Number;
		private var localHeight:Number;
		private var localX:Number;
		private var localY:Number;
		private var localZoomX:Number;
		private var localZoomY:Number;
		private var localRotation:Number;
		
		public function get width():Number
		{
			return localWidth / zoomX;
		}
		
		public function get height():Number
		{
			return localHeight / zoomY;
		}
		
		public function set x(value:Number):void
		{
			localX = value;
		}
		
		public function get x():Number
		{
			return localX;
		}
		
		public function set y(value:Number):void
		{
			localY = value;
		}
		
		public function get y():Number
		{
			return localY;
		}
		
		public function set zoomX(value:Number):void
		{
			localZoomX = value;
		}
		
		public function get zoomX():Number
		{
			return localZoomX;
		}
		
		public function set zoomY(value:Number):void
		{
			localZoomY = value;
		}
		
		public function get zoomY():Number
		{
			return localZoomY;
		}
		
		public function set rotation(value:Number):void
		{
			localRotation = value;
		}
		
		public function get rotation():Number
		{
			return localRotation;
		}
		
		/**
		 * Create in game camera don't create object from it there is one created in Game class
		 * @param	w width of the world
		 * @param	h height of the world
		 */
		public function GameCamera(w:Number, h:Number) 
		{
			localX = 0;
			localY = 0;
			
			localWidth = w;
			localHeight = h;
			
			localZoomX = 1;
			localZoomY = 1;
			
			localRotation = 0;
		}
		
		/**
		 * Get a screen point in form of world Point
		 * @param	x position of camera coordinate point
		 * @param	y position of camera coordinate point
		 * @return world coordinate point
		 */
		public function GetWorldPoint(x:Number, y:Number):Point
		{
			var cameraMatrix:Matrix = new Matrix();
			cameraMatrix.translate(-zoomX * AE.game.gameCamera.width / 2, -zoomY * AE.game.gameCamera.height / 2);
			cameraMatrix.scale(1 / zoomX, 1 / zoomY);
			cameraMatrix.rotate(-rotation);
			cameraMatrix.translate(this.x, this.y);
			
			return cameraMatrix.transformPoint(new Point(x, y));
		}
		
		/**
		 * Get a world point in form of screen point
		 * @param	x position of world coordinate point
		 * @param	y position of world coordinate point
		 * @return camera coordinate point
		 */
		public function GetCameraPoint(x:Number, y:Number):Point
		{
			var cameraMatrix:Matrix = new Matrix();
			cameraMatrix.translate(-this.x, -this.y);
			cameraMatrix.scale(zoomX, zoomY);
			cameraMatrix.rotate(rotation);
			cameraMatrix.translate(zoomX * width / 2, zoomY * height / 2);
			
			return cameraMatrix.transformPoint(new Point(x, y));
		}
		
		/**
		 * Check if a certain point inside viewing scene
		 * @param	x position of tested point
		 * @param	y position of tested point
		 * @return True if the point inside the viewing scene, false otherwise
		 */
		public function PointInsideCamera(x:Number, y:Number):Boolean
		{
			var rectangle:Rectangle = new Rectangle(this.x, this.y, this.width, this.height);
			return rectangle.contains(x, y);
		}
		
		/**
		 * Check if a certain rectangle inside the viewing scene
		 * @param	x position of tested rectangle
		 * @param	y position of tested rectangle
		 * @param	width of tested rectangle
		 * @param	height of tested rectangle
		 * @return True if the rectangle inside the viewing scene, false otherwise
		 */
		public function RectInsideCamera(x:Number , y:Number, width:Number, height:Number):Boolean
		{
			var rectangle:Rectangle = new Rectangle(this.x, this.y, this.width, this.height);
			return rectangle.intersects(new Rectangle(x, y, width, height));
		}
	}

}