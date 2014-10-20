package AmidosEngine 
{
	import adobe.utils.CustomActions;
	import flash.geom.Vector3D;
	import flash.system.Capabilities;
	import flash.utils.ByteArray;
	import starling.utils.AssetManager;
	/**
	 * Static class where it contains lots of useful functions
	 * @author Amidos
	 */
	public class AE 
	{
		/// The main game object
		public static var game:Game;
		/// responsible for loading assets for the game
		public static var assetManager:AssetManager;
		
		/**
		 * get the current running os
		 */
		//public static function get currentOS():int
		//{
			//var os:String = Capabilities.os.toLowerCase();
			//var man:String = Capabilities.manufacturer.toLowerCase();
			//if (os.search("windows"))
			//{
				//return OS.WINDOWS;
			//}
			//
			//if (os.search("mac"))
			//{
				//return OS.MAC;
			//}
			//
			//if (man.search("android"))
			//{
				//return OS.ANDROID;
			//}
			//
			//if (man.search("ios"))
			//{
				//return OS.IOS;
			//}
			//
			//return OS.LINUX;
		//}
		
		/**
		 * Must be called to initialize the whole amidos engine
		 */
		public static function Initialize():void
		{
			Input.Initialize();
			
			assetManager = new AssetManager();
		}
		
		/**
		 * Get an integer random number between 0<=number<max
		 * @param	max the upper boundry for the random number
		 * @return random integer number
		 */
		public static function GetIntRandom(max:int):int
		{
			return Math.floor(max * Math.random());
		}
		
		/**
		 * Get a random number between 0<=number<1
		 * @return random number
		 */
		public static function GetRandom():Number
		{
			return Math.random();
		}
		
		/**
		 * Check if number is +ve or -ve the zero is treated as +ve
		 * @param	number value to check its sign
		 * @return sign 1 or -1
		 */
		public static function GetSign(number:Number):int
		{
			if (number < 0)
			{
				return -1;
			}
			return 1;
		}
		
		/**
		 * Shuffle array in place
		 * @param	array array of objects required to be shuffled
		 */
		public static function ShuffleArray(array:Array):void
		{
			for (var i:int = 0; i < array.length; i++) 
			{
				var index1:int = GetIntRandom(array.length);
				var index2:int = GetIntRandom(array.length);
				
				var temp:Object = array[index1];
				array[index1] = array[index2];
				array[index2] = temp;
			}
		}
		
		/**
		 * Get a uint value for the combinaton of the colors (r, g, b)
		 * @param	red value for red color 0<=value<255
		 * @param	green value for green color 0<=value<255
		 * @param	blue value for blue color 0<=value<255
		 * @return color value consists of rgb
		 */
		public static function RGBValue(red:uint, green:uint, blue:uint):uint
		{
			return 0xFF << 24 | red << 16 | green << 8 | blue;
		}
		
		/**
		 * Return r,g,b components of a specific color
		 * @param	value combined color value
		 * @return vector consists of red value as x, green value as y, blue value as z
		 */
		public static function ValueRGB(value:uint):Vector3D
		{
			var red:uint = value >> 16;
			red = red & 0xFF;
			var green:uint = value >> 8;
			green = green & 0xFF;
			var blue:uint = value;
			blue = blue & 0xFF;
			
			return new Vector3D(red, green, blue);
		}
		
		/**
		 * return number in form of string with length >= s
		 * @param	n integer number required to be transformed
		 * @param	s size not less than it
		 * @return string of the integer consisting of at least s digits
		 */
		public static function GetFixedNumber(n:int, s:int):String
		{
			var result:String = n.toString();
			for (var i:int = 0; i < s - result.length; i++) 
			{
				result = "0" + result;
			}
			
			return result;
		}
	}

}