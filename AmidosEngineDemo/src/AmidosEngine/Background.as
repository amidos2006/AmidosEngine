package AmidosEngine 
{
	import flash.geom.Point;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * Repeating background
	 * @author Amidos
	 */
	public class Background extends Image
	{
		private var localX:Number;
		private var localY:Number;
		
		override public function get x():Number 
		{
			return localX;
		}
		
		override public function set x(value:Number):void 
		{
			localX = value;
			UpdateTexCoords();
		}
		
		override public function get y():Number 
		{
			return localY;
		}
		
		override public function set y(value:Number):void 
		{
			localY = value;
			UpdateTexCoords();
		}
		
		private function UpdateTexCoords():void
		{
			this.setTexCoords(0, new Point(0 + localX / this.width, 0 + localY / this.height));
			this.setTexCoords(1, new Point(1 + localX / this.width, 0 + localY / this.height));
			this.setTexCoords(2, new Point(0 + localX / this.width, 1 + localY / this.height));
			this.setTexCoords(3, new Point(1 + localX / this.width, 1 + localY / this.height));
		}
		
		/**
		 * Construct a repeating background
		 * @param	texture required to be repeated
		 */
		public function Background(texture:Texture) 
		{
			super(texture);
			texture.repeat = true;
			localX = 0;
			localY = 0;
			UpdateTexCoords();
		}
	}

}