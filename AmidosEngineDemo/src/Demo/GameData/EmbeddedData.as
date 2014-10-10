package Demo.GameData 
{
	/**
	 * ...
	 * @author Amidos
	 */
	public class EmbeddedData 
	{
		[Embed(source = "../../../assests/data/gameText.xml", mimeType = "application/octet-stream")]public static var gameText:Class;
	}

}