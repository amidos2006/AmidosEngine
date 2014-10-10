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
		public var x:Number;
		public var y:Number;
		public var width:Number;
		public var height:Number;
		
		/**
		 * Create in game camera don't create object from it there is one created in Game class
		 * @param	w width of the world
		 * @param	h height of the world
		 */
		public function GameCamera(w:Number, h:Number) 
		{
			x = 0;
			y = 0;
			
			width = w;
			height = h;
		}
		
		/**
		 * Get a screen point in form of world Point
		 * @param	x position of camera coordinate point
		 * @param	y position of camera coordinate point
		 * @return world coordinate point
		 */
		public function GetWorldPoint(x:Number, y:Number):Point
		{
			return new Point(x + this.x, y + this.y);
		}
		
		/**
		 * Get a world point in form of screen point
		 * @param	x position of world coordinate point
		 * @param	y position of world coordinate point
		 * @return camera coordinate point
		 */
		public function GetLocalPoint(x:Number, y:Number):Point
		{
			return new Point(x - this.x, y - this.y)
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