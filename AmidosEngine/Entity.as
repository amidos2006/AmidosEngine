package AmidosEngine 
{
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	/**
	 * Entity class holder for entities in the world contain useful functions
	 * @author Amidos
	 */
	public class Entity extends Sprite
	{
		private var localX:Number;
		private var localY:Number;
		private var localLayer:Number;
		private var localHitBox:Rectangle;
		private var localGraphic:DisplayObject;
		private var localCollisionName:String;
		private var localWorld:World;
		private var localUseCamera:Boolean;
		private var localVisible:Boolean;
		
		/**
		 * Set x position of the entity
		 */
		override public function set x(value:Number):void 
		{
			localX = value;
		}
		
		/**
		 * Get x position of the entity
		 */
		override public function get x():Number 
		{
			return localX;
		}
		
		/**
		 * Set y position of the entity
		 */
		override public function set y(value:Number):void 
		{
			localY = value;
		}
		
		/**
		 * Get y position of the entity
		 */
		override public function get y():Number 
		{
			return localY;
		}
		
		/**
		 * if the entity is not visible
		 */
		override public function set visible(value:Boolean):void 
		{
			localVisible = value;
		}
		
		/**
		 * if the entity is visible
		 */
		override public function get visible():Boolean 
		{
			return localVisible;
		}
		
		/**
		 * Set if the Entity follow the camera
		 * if the entity is hud set it to false, else leave it true
		 */
		public function set useCamera(value:Boolean):void
		{
			localUseCamera = value;
		}
		
		/**
		 * Get if the Entity follow the camera
		 */
		public function get useCamera():Boolean
		{
			return localUseCamera;
		}
		
		/**
		 * Set current layer for rendering (as number increase its render last)
		 */
		public function set layer(value:Number):void
		{
			
			localLayer = value;
		}
		
		/**
		 * Get current layer for rendering (as number increase its render last)
		 */
		public function get layer():Number
		{
			return localLayer;
		}
		
		/**
		 * Set current hitbox
		 */
		public function set hitBox(value:Rectangle):void
		{
			localHitBox = value;
		}
		
		/**
		 * Get current hitbox
		 */
		public function get hitBox():Rectangle
		{
			return localHitBox;
		}
		
		/**
		 * Set new graphic to the object to be rendered
		 */
		public function set graphic(value:DisplayObject):void
		{
			if (localGraphic != null && localWorld != null)
			{
				removeChild(localGraphic);
			}
			
			localGraphic = value;
			
			if (localGraphic != null && localWorld != null)
			{
				addChild(localGraphic);
			}
			
		}
		
		/**
		 * Get current graphic rendered
		 */
		public function get graphic():DisplayObject
		{
			return localGraphic;
		}
		
		/**
		 * Set current collision name
		 */
		public function set collisionName(value:String):void
		{
			localCollisionName = value;
		}
		
		/**
		 * Get current collision name
		 */
		public function get collisionName():String
		{
			return localCollisionName;
		}
		
		/**
		 * Set current world that its added to it
		 */
		public function set world(value:World):void
		{
			localWorld = value;
		}
		
		/**
		 * Get current world that is added to it
		 */
		public function get world():World
		{
			return localWorld;
		}
		
		private function UpdatePosition():void
		{
			if (localUseCamera)
			{
				super.x = localX - AE.game.gameCamera.x;
				super.y = localY - AE.game.gameCamera.y;
			}
			else
			{
				super.x = localX;
				super.y = localY;
			}
		}
		
		/**
		 * Create the entity object
		 */
		public function Entity() 
		{
			localX = 0;
			localY = 0;
			localLayer = 0;
			localHitBox = null;
			localGraphic = null;
			localCollisionName = "";
			localWorld = null;
			localUseCamera = true;
			localVisible = true;
			touchable = false;
		}
		
		/**
		 * It is called when the object is just added to the world
		 */
		public function add():void
		{
			UpdatePosition();
			if (graphic != null)
			{
				addChild(graphic);
			}
		}
		
		/**
		 * It is called when object is just removed from the world
		 */
		public function remove():void
		{
			if (graphic != null)
			{
				removeChild(graphic);
			}
		}
		
		/**
		 * Check if this entity collide with certain point
		 * @param	pX x position require to test its collision with
		 * @param	pY y position require to test its collision with
		 * @param	sX x position of this entity to be tested for collision
		 * @param	sY y position of this entity to be tested for collision
		 * @return true if it collides, false otherwise
		 */
		public function collidePoint(pX:Number, pY:Number, sX:Number, sY:Number):Boolean
		{
			var currentRectangle:Rectangle = new Rectangle(hitBox.x + sX, hitBox.y + sY, hitBox.width, hitBox.height);
			
			return currentRectangle.contains(pX, pY);
		}
		
		/**
		 * Check if it collide with certain type of entity
		 * @param	otherName name of collision of other entity
		 * @param	sX x position of this entity to be tested for collision
		 * @param	sY y position of this entity to be tested for collision
		 * @return collided entity if exisit, else null is returned
		 */
		public function collideName(otherName:String, sX:Number, sY:Number):Entity
		{
			var entities:Vector.<Entity> = AE.game.ActiveWorld.className(otherName);
			var currentRectangle:Rectangle = new Rectangle(hitBox.x + sX, hitBox.y + sY, hitBox.width, hitBox.height);
			
			for (var i:int = 0; i < entities.length; i++) 
			{
				var otherRectangle:Rectangle = new Rectangle(entities[i].x + entities[i].hitBox.x, entities[i].y + entities[i].hitBox.y, 
					entities[i].hitBox.width, entities[i].hitBox.height);
				if (currentRectangle.intersects(otherRectangle))
				{
					return entities[i];
				}
			}
			
			return null;
		}
		
		/**
		 * Called every update frame
		 * @param	dt amount of time since last update
		 */
		public function update(dt:Number):void
		{
			UpdatePosition();
			if (useCamera)
			{
				super.visible = localVisible;
				//super.visible = localVisible && AE.game.gameCamera.RectInsideCamera(x - width, y - height, 2 * width, 2 * height);
			}
		}
	}

}