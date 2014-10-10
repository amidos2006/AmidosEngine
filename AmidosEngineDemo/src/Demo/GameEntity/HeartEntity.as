package Demo.GameEntity 
{
	import AmidosEngine.AE;
	import AmidosEngine.Entity;
	import Demo.CollisionNames;
	import Demo.LayerConstants;
	import flash.geom.Rectangle;
	import starling.display.Image;
	/**
	 * ...
	 * @author Amidos
	 */
	public class HeartEntity extends Entity
	{
		public function HeartEntity(x:Number, y:Number) 
		{
			this.x = x;
			this.y = y;
			
			var image:Image = new Image(AE.assetManager.getTexture("heartImage"));
			image.smoothing = "none";
			image.alignPivot();
			
			graphic = image;
			layer = LayerConstants.HEART_LAYER;
			
			hitBox = new Rectangle(-image.pivotX, -image.pivotY, image.width, image.height);
			collisionName = CollisionNames.SOLID_NAME;
		}
		
	}

}