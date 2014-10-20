package Demo.GameEntity 
{
	import AmidosEngine.AE;
	import AmidosEngine.Entity;
	import AmidosEngine.Graphiclist;
	import AmidosEngine.Shapes;
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
			
			var circle:Image = new Image(Shapes.GetCircle(8));
			circle.smoothing = "none";
			circle.alignPivot();
			
			var graphicList:Graphiclist = new Graphiclist();
			graphicList.AddGraphic(image);
			graphicList.AddGraphic(circle);
			
			graphic = graphicList;
			layer = LayerConstants.HEART_LAYER;
			
			hitBox = new Rectangle(-image.pivotX, -image.pivotY, image.width, image.height);
			collisionName = CollisionNames.SOLID_NAME;
		}
	}

}