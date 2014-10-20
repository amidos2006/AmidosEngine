package AmidosEngine 
{
	import flash.display.Bitmap;
	import starling.core.Starling;
	/**
	 * Just covers long time of loading don't use it in any place except the main
	 * @author Amidos
	 */
	public class LoadingWorld extends World
	{
		private var loadingBitmap:Bitmap;
		private var nextWorld:World;
		
		/**
		 * Remove the loading screen that covers long loading times
		 * @param	nextWorld world after loading to show
		 * @param	currentLoadingBitmap current image used for loading
		 */
		public function LoadingWorld(nextWorld:World, loadingBitmap:Bitmap = null) 
		{
			this.loadingBitmap = loadingBitmap;
			this.nextWorld = nextWorld;
		}
		
		override public function update(dt:Number):void 
		{
			super.update(dt);
			
			if (loadingBitmap != null)
			{
				Starling.current.nativeStage.removeChild(loadingBitmap);
				AE.game.ActiveWorld = nextWorld;
				loadingBitmap = null;
			}
		}
	}

}