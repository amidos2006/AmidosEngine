package Demo.GameWorld 
{
	import AmidosEngine.AE;
	import AmidosEngine.Entity;
	import AmidosEngine.Input;
	import AmidosEngine.Sfx;
	import AmidosEngine.Shapes;
	import AmidosEngine.World;
	import Demo.GameEntity.*;
	import flash.geom.Point;
	import starling.display.Image;
	/**
	 * ...
	 * @author Amidos
	 */
	public class DemoWorld extends World
	{
		private var gameMusicSfx:Sfx;
		private var player:PlayerEntity;
		
		public function DemoWorld() 
		{
			gameMusicSfx = new Sfx(AE.assetManager.getSound("gameMusic"));
			
			var buttonEntity:DemoButtonEntity = new DemoButtonEntity();
			buttonEntity.x = AE.game.width / 2;
			buttonEntity.y = buttonEntity.hitBox.height / 2;
			AddEntity(buttonEntity);
			
			var tilemapEntity:TileMapEntity = new TileMapEntity();
			AddEntity(tilemapEntity);
			
			player = new PlayerEntity();
			AddEntity(player);
			
			var text:DemoTextEntity = new DemoTextEntity();
			text.x = AE.game.width / 2;
			text.y = AE.game.height;
			AddEntity(text);
		}
		
		override public function begin():void 
		{
			super.begin();
			
			gameMusicSfx.Loop();
			
			Input.AddPressFunction(AddHeart);
		}
		
		override public function end():void 
		{
			super.end();
			
			gameMusicSfx.Stop();
			
			Input.RemovePressFunction(AddHeart);
		}
		
		private function AddHeart(tX:Number, tY:Number, tID:int):void
		{
			var worldPosition:Point = AE.game.gameCamera.GetWorldPoint(tX, tY);
			AddEntity(new HeartEntity(worldPosition.x, worldPosition.y));
		}
		
		override public function update(dt:Number):void 
		{
			super.update(dt);
			
			AE.game.gameCamera.x = player.x;
			AE.game.gameCamera.y = player.y;
		}
	}

}