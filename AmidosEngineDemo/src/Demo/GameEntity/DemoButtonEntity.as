package Demo.GameEntity 
{
	import AmidosEngine.AE;
	import AmidosEngine.ButtonEntity;
	import AmidosEngine.Sfx;
	import Demo.LayerConstants;
	import flash.geom.Rectangle;
	import starling.display.Image;
	/**
	 * ...
	 * @author Amidos
	 */
	public class DemoButtonEntity extends ButtonEntity
	{
		private var buttonSfx:Sfx;
		
		public function DemoButtonEntity() 
		{
			useCamera = false;
			
			buttonSfx = new Sfx(AE.assetManager.getSound("clickSound"));
			
			pressFunction = PlaySound;
			
			var image:Image = new Image(AE.assetManager.getTexture("buttonImage"));
			image.alignPivot();
			image.smoothing = "none";
			
			graphic = image;
			layer = LayerConstants.HUD_LAYER;
			
			hitBox = new Rectangle(-image.pivotX, -image.pivotY, image.width, image.height);
		}
		
		override protected function ButtonIn():void 
		{
			super.ButtonIn();
			
			scaleX = 1.1;
			scaleY = 1.1;
		}
		
		override protected function ButtonOut():void 
		{
			super.ButtonOut();
			
			scaleX = 1;
			scaleY = 1;
		}
		
		private function PlaySound():void
		{
			buttonSfx.Play();
		}
	}

}