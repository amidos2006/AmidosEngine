package AmidosEngine 
{
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	/**
	 * Just combine objects in one list
	 * @author Amidos
	 */
	public class Graphiclist extends DisplayObjectContainer
	{	
		public function Graphiclist() 
		{
			
		}
		
		/**
		 * Add graphic to the list
		 * @param	g required displayobject to be combined
		 */
		public function AddGraphic(g:DisplayObject):void
		{
			addChild(g);
		}
		
		/**
		 * Remove graphic from the list
		 * @param	g required displayobject to be removed
		 */
		public function RemoveGraphic(g:DisplayObject):void
		{
			removeChild(g);
		}
	}

}