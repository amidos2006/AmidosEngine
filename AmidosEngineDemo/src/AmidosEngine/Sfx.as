package AmidosEngine 
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	/**
	 * Sound effect object used to play embedded sounds.
	 */
	public class Sfx 
	{
		/// function called on completing the sfx playing
		public var complete:Function;
		
		private var sound:Sound;
		private var soundChannel:SoundChannel;
		private var soundTransform:SoundTransform;
		private var looping:Boolean;
		
		/**
		 * Creates a sound effect from an embedded source. Store a reference to
		 * this object so that you can play the sound using play() or loop().
		 * @param	source		The embedded sound class to use or a Sound object.
		 * @param	complete	Optional callback function for when the sound finishes playing.
		 */
		public function Sfx(sound:Sound, complete:Function = null) 
		{
			this.sound = sound;
			this.complete = complete;
			
			this.soundChannel = null;
			this.soundTransform = new SoundTransform(1, 0);
			this.looping = false;
		}
		
		/**
		 * Play sound file one time
		 * @param	vol volume to be played with (0, 1)
		 * @param	pan which speaker it prefer for 3D sound (-1=left, 1=right)
		 * @param	position in seconds to continue playing from it
		 */
		public function Play(vol:Number = 1, pan:Number = 0, position:Number = 0):void
		{
			if (soundChannel)
			{
				Stop();
			}
			
			soundTransform.volume = vol;
			soundTransform.pan = pan;
			soundChannel = sound.play(position * 1000, 0, soundTransform);
			soundChannel.addEventListener(Event.SOUND_COMPLETE, onComplete);
			looping = false;
		}
		
		/**
		 * Loop sound file forever
		 * @param	vol volume to be played with (0, 1)
		 * @param	pan which speaker it prefer for 3D sound (-1=left, 1=right)
		 * @param	position in seconds to continue playing from it
		 */
		public function Loop(vol:Number = 1, pan:Number = 0, position:Number = 0):void
		{
			Play(vol, pan, position);
			looping = true;
		}
		
		/**
		 * Stop current played sound
		 */
		public function Stop():void
		{
			if (soundChannel != null)
			{
				soundChannel.removeEventListener(Event.SOUND_COMPLETE, onComplete);
				soundChannel.stop();
				soundChannel = null;
			}
		}
		
		private function onComplete(e:Event = null):void
		{
			if (looping)
			{
				Loop(soundTransform.volume, soundTransform.pan);
			}
			else 
			{
				Stop();
			}
			
			if (complete != null)
			{
				complete();
			}
		}
		
		/**
		 * Get the volume value for sound
		 */
		public function get volume():Number { return soundTransform.volume; }
		
		/**
		 * Set the volume value for sound
		 */
		public function set volume(value:Number):void
		{
			soundTransform.volume = value;
			if (soundChannel != null)
			{
				soundChannel.soundTransform = soundTransform;
			}
		}
		
		/**
		 * Get the pan value for 3D sound (-1=left, 1=right)
		 */
		public function get pan():Number { return soundTransform.pan; }
		
		/**
		 * Set the pan value for 3D sound (-1=left, 1=right)
		 */
		public function set pan(value:Number):void
		{
			soundTransform.pan = value;
			if (soundChannel != null)
			{
				soundChannel.soundTransform = soundTransform;
			}
		}
		
		/**
		 * If the sound is currently playing.
		 */
		public function get playing():Boolean { return soundChannel != null; }
		
		/**
		 * Position of the currently playing sound, in seconds.
		 */
		public function get position():Number { return (soundChannel ? soundChannel.position : 0) / 1000; }
		
		/**
		 * Length of the sound, in seconds.
		 */
		public function get length():Number { return sound.length / 1000; }
	}
}
