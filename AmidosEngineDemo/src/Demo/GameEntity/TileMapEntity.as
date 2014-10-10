package Demo.GameEntity 
{
	import AmidosEngine.AE;
	import AmidosEngine.Entity;
	import AmidosEngine.Tilemap;
	import Demo.LayerConstants;
	/**
	 * ...
	 * @author Amidos
	 */
	public class TileMapEntity extends Entity
	{
		
		public function TileMapEntity() 
		{
			var tilemap:Tilemap = new Tilemap(AE.assetManager.getTexture("tileSheet"), 16, 16, "none");
			for (var i:int = -50; i < 50; i++) 
			{
				for (var j:int = -50; j < 50; j++) 
				{
					tilemap.AddTile(j, i, AE.GetIntRandom(10));
				}
			}
			
			graphic = tilemap;
			layer = LayerConstants.TILE_LAYER;
		}
		
	}

}