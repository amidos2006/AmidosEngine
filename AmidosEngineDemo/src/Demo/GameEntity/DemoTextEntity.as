package Demo.GameEntity 
{
	import AmidosEngine.AE;
	import AmidosEngine.Entity;
	import Demo.LayerConstants;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	/**
	 * ...
	 * @author Amidos
	 */
	public class DemoTextEntity extends Entity
	{
		
		public function DemoTextEntity() 
		{
			var text:String = AE.assetManager.getXml("gameText").text[0].toString();
			var pattern:RegExp = /\\n/g;
			text = text.replace(pattern, "\n");
			
			var textField:TextField = new TextField(200, 32, text, BitmapFont.MINI, 8, 0xFFFFFFFF);
			textField.alignPivot("center", "bottom");
			
			graphic = textField;
			layer = LayerConstants.HUD_LAYER;
			
			useCamera = false;
		}
		
	}

}