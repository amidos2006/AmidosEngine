package Demo.GameEntity 
{
	import AmidosEngine.AE;
	import AmidosEngine.Entity;
	import AmidosEngine.Key;
	import AmidosEngine.KeyStatus;
	import AmidosEngine.Spritemap;
	import Demo.CollisionNames;
	import Demo.LayerConstants;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Amidos
	 */
	public class PlayerEntity extends Entity
	{
		private const MOVE_SPEED:Number = 100;
		
		private var spritemap:Spritemap;
		private var status:String;
		private var direction:String;
		
		public function PlayerEntity() 
		{
			status = "Standing";
			direction = "Down";
			
			spritemap = new Spritemap(16, 16);
			spritemap.smoothing = "none";
			spritemap.alignPivot();
			
			spritemap.AddAnimation("playerMoveRight", 10);
			spritemap.AddAnimation("playerMoveLeft", 10);
			spritemap.AddAnimation("playerMoveUp", 10);
			spritemap.AddAnimation("playerMoveDown", 10);
			
			spritemap.AddAnimation("playerStandingRight");
			spritemap.AddAnimation("playerStandingLeft");
			spritemap.AddAnimation("playerStandingUp");
			spritemap.AddAnimation("playerStandingDown");
			
			spritemap.PlayAnimation("player" + status + direction);
			
			graphic = spritemap;
			layer = LayerConstants.PLAYER_LAYER;
			
			hitBox = new Rectangle(-spritemap.pivotX, -spritemap.pivotY, spritemap.width, spritemap.height);
		}
		
		override public function update(dt:Number):void 
		{
			super.update(dt);
			
			status = "Standing";
			var movingVector:Point = new Point();
			if (AE.GetKeyStatus(Key.UP) == KeyStatus.DOWN)
			{
				movingVector.y -= 1;
			}
			if (AE.GetKeyStatus(Key.DOWN) == KeyStatus.DOWN)
			{
				movingVector.y += 1;
			}
			if (AE.GetKeyStatus(Key.LEFT) == KeyStatus.DOWN)
			{
				movingVector.x -= 1;
			}
			if (AE.GetKeyStatus(Key.RIGHT) == KeyStatus.DOWN)
			{
				movingVector.x += 1;
			}
			
			movingVector.normalize(MOVE_SPEED * dt);
			
			if (collideName(CollisionNames.SOLID_NAME, x + movingVector.x, y + movingVector.y) == null)
			{
				x += movingVector.x;
				y += movingVector.y;
				
				if (movingVector.length > 0)
				{
					status = "Move";
				}
			}
			
			if (movingVector.x > 0)
			{
				direction = "Right";
			}
			else if (movingVector.x < 0)
			{
				direction = "Left";
			}
			
			if (movingVector.y > 0)
			{
				direction = "Down";
			}
			else if (movingVector.y < 0)
			{
				direction = "Up";
			}
			
			spritemap.PlayAnimation("player" + status + direction);
		}
	}

}