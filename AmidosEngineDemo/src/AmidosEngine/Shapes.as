package AmidosEngine 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.geom.Matrix;
	import starling.textures.Texture;
	/**
	 * Used to draw native fixed shapes
	 * @author Amidos
	 */
	public class Shapes 
	{
		/**
		 * Get Texture containing circle
		 * @param	radius of the circle
		 * @param	color of the circle
		 * @param	thickness of stroke of the circle
		 * @param	fill is it filled circle?
		 * @return Texture containing the circle
		 */
		public static function GetCircle(radius:Number, color:uint = 0xFFFFFF, thickness:Number = 2, fill:Boolean = false):Texture
		{
			var sprite:Sprite = new Sprite();
			sprite.graphics.lineStyle(thickness, color);
			if (fill)
			{
				sprite.graphics.beginFill(color);
			}
			sprite.graphics.drawCircle(radius + thickness, radius + thickness, radius);
			if (fill)
			{
				sprite.graphics.endFill();
			}
			
			var bitmapData:BitmapData = new BitmapData(2 * (radius + thickness), 2 * (radius + thickness), true, 0);
			bitmapData.drawWithQuality(sprite);
			
			return Texture.fromBitmapData(bitmapData);
		}
		
		/**
		 * 
		 * @param	width
		 * @param	height
		 * @param	color
		 * @param	thickness
		 * @param	fill
		 * @return
		 */
		public static function GetRectangle(width:Number, height:Number, color:uint = 0xFFFFFF, thickness:Number = 2, fill:Boolean = false):Texture
		{
			var sprite:Sprite = new Sprite();
			sprite.graphics.lineStyle(thickness, color);
			if (fill)
			{
				sprite.graphics.beginFill(color);
			}
			sprite.graphics.drawRoundRect(thickness, thickness, width, height, 0, 0);
			if (fill)
			{
				sprite.graphics.endFill();
			}
			
			var bitmapData:BitmapData = new BitmapData(width + 2 * thickness, height + 2 * thickness, true, 0);
			bitmapData.drawWithQuality(sprite);
			
			return Texture.fromBitmapData(bitmapData);
		}
	}

}