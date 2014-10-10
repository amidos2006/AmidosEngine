package Demo.GameData 
{
	/**
	 * ...
	 * @author Amidos
	 */
	public class EmbeddedGraphics 
	{
		[Embed(source = "../../../assests/graphics/playerSpritesheet.png")]public static var playerSpritesheet:Class;
		[Embed(source = "../../../assests/graphics/playerAtlas.xml", mimeType = "application/octet-stream")]public static var playerAtlas:Class;
		
		[Embed(source = "../../../assests/graphics/tileSheet.png")]public static var tileSheet:Class;
		[Embed(source = "../../../assests/graphics/buttonImage.png")]public static var buttonImage:Class;
		[Embed(source = "../../../assests/graphics/heartImage.png")]public static var heartImage:Class;
	}

}