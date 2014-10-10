package AmidosEngine 
{
	import flash.geom.Point;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * Image constructed from a huge sheet
	 * @author Amidos
	 */
	public class TileImage extends Image
	{
		/**
		 * Constucting the image from the tile sheet
		 * @param	texture texture from which it will be constructed
		 * @param	imageIndex the index inside the texture
		 * @param	currentWidth width of the tile
		 * @param	currentHeight height of the tile
		 */
		public function TileImage(texture:Texture, imageIndex:int, currentWidth:Number, currentHeight:Number) 
		{
			super(texture);
			width = currentWidth;
			height = currentHeight;
			
			var numberOfXTiles:int = Math.floor(texture.nativeWidth / currentWidth);
			var numberOfYTiles:int = Math.floor(texture.nativeHeight / currentHeight);
			var xTileIndex:int = imageIndex % numberOfXTiles;
			var yTileIndex:int = imageIndex / numberOfXTiles;
			
			setTexCoords(0, new Point((0 + xTileIndex) * currentWidth / texture.nativeWidth, (0 + yTileIndex) * currentHeight / texture.nativeHeight));
			setTexCoords(1, new Point((1 + xTileIndex) * currentWidth / texture.nativeWidth, (0 + yTileIndex) * currentHeight / texture.nativeHeight));
			setTexCoords(2, new Point((0 + xTileIndex) * currentWidth / texture.nativeWidth, (1 + yTileIndex) * currentHeight / texture.nativeHeight));
			setTexCoords(3, new Point((1 + xTileIndex) * currentWidth / texture.nativeWidth, (1 + yTileIndex) * currentHeight / texture.nativeHeight));
		}
	}

}