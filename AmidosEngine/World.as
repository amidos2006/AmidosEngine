package AmidosEngine 
{
	import adobe.utils.CustomActions;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	/**
	 * World used to add entities to it and make physics runs
	 * @author Amidos
	 */
	public class World extends DisplayObjectContainer
	{
		private var addedList:Vector.<Entity>;
		private var removedList:Vector.<Entity>;
		private var notSorted:Boolean;
		
		/**
		 * Construct the world
		 */
		public function World() 
		{
			addedList = new Vector.<Entity>();
			removedList = new Vector.<Entity>();
			notSorted = false;
		}
		
		private function SortFunction(x:Entity, y:Entity):Number
		{
			if (x.layer < y.layer)
			{
				return -1;
			}
			
			if (x.layer > y.layer)
			{
				return 1;
			}
			
			return 0;
		}
		
		/**
		 * Called when the world is active
		 */
		public function begin():void
		{
			AddPendingEntities();
			if (notSorted)
			{
				sortChildren(SortFunction);
				notSorted = false;
			}
		}
		
		private function AddPendingEntities():void
		{
			var e:Entity;
			for (var j:int = 0; j < addedList.length; j++) 
			{
				e = addedList[j];
				if (addChild(e) != null)
				{
					e.world = this;
					e.add();
				}
			}
			if (addedList.length > 0)
			{
				notSorted = true;
			}
			addedList.length = 0;
		}
		
		private function RemovePendingEntities():void
		{
			var e:Entity;
			for (var k:int = 0; k < removedList.length; k++) 
			{
				e = removedList[k];
				if (removeChild(e) != null)
				{
					e.remove();
					e.world = null;
				}
			}
			removedList.length = 0;
		}
		
		/**
		 * Called when the world become inactive
		 */
		public function end():void
		{
			for (var i:int = 0; i < numChildren; i++) 
			{
				(getChildAt(i) as Entity).remove();
				(getChildAt(i) as Entity).world = null;
			}
			removeChildren();
		}
		
		/**
		 * Add entity to this world
		 * @param	e added entity
		 */
		public function AddEntity(e:Entity):void
		{
			addedList.push(e);
		}
		
		/**
		 * Remove specific entity from this world
		 * @param	e removed entity
		 */
		public function RemoveEntity(e:Entity):void
		{
			removedList.push(e);
		}
		
		/**
		 * Get all entities with specific names (tags)
		 * @param	collisionName name required to search with it
		 * @return vector of all entities in the world have this collisionName
		 */
		public function className(collisionName:String):Vector.<Entity>
		{
			var collidedEntities:Vector.<Entity> = new Vector.<Entity>();
			
			for (var i:int = 0; i < numChildren; i++) 
			{
				
				var e:Entity = getChildAt(i) as Entity;
				if (e.collisionName == collisionName)
				{
					collidedEntities.push(e);
				}
			}
			
			for (i = 0; i < addedList.length; i++)
			{
				e = addedList[i] as Entity;
				if (e.collisionName == collisionName)
				{
					collidedEntities.push(e);
				}
			}
			
			return collidedEntities;
		}
		
		/**
		 * Get all entities collide with certain point
		 * @param	x point of collision
		 * @param	y point of collision
		 * @return vector of all entities that collide with certain point (x, y)
		 */
		public function collidePoint(x:int, y:int):Vector.<Entity>
		{
			var collidedEntities:Vector.<Entity> = new Vector.<Entity>();
			
			for (var i:int = 0; i < numChildren; i++) 
			{
				var e:Entity = getChildAt(i) as Entity;
				if (e.collidePoint(x, y, e.x, e.y))
				{
					collidedEntities.push(e);
				}
			}
			
			return collidedEntities;
		}
		
		/**
		 * update the world and all entities in it
		 * @param	dt amount of time from last update function
		 */
		public function update(dt:Number):void
		{
			RemovePendingEntities();
			AddPendingEntities();
			if (notSorted)
			{
				sortChildren(SortFunction);
				notSorted = false;
			}
			
			for (var i:int = 0; i < numChildren; i++) 
			{
				var gameEntity:Entity = (getChildAt(i) as Entity);
				var layerBefore:Number = gameEntity.layer;
				gameEntity.update(dt);
				if (gameEntity.layer != layerBefore)
				{
					notSorted = true;
				}
			}
		}
	}

}