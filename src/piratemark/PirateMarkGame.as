package piratemark 
{
	import dulldude.Game;
	import dulldude.Global;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	/**
	 * ...
	 * @author Iain Lobb - iainlobb@gmail.com
	 */
	public class PirateMarkGame extends Game
	{
		private var options:Options;
		public var numPirates:int;
		
		public function PirateMarkGame() 
		{
			
		}
		
		override protected function startGame():void 
		{
			super.startGame();
			
			options = new Options();
			options.addEventListener(TouchEvent.TOUCH, onTouchButton);
			options.y = 30;
			addChild(options);
			
			addPirate();
		}
		
		override protected function update(elapsedTime:Number):void 
		{
			super.update(elapsedTime);
		}
		
		protected function onTouchButton(event:TouchEvent):void
		{
			var touches:Vector.<Touch> = event.getTouches(options);
			
			if (touches)
			{
				for each (var touch:Touch in touches)
				{
					if (touch.phase == TouchPhase.HOVER || touch.phase == TouchPhase.ENDED) continue;
				
					addPirate();
					
					break;
				}
			}
		}
		
		protected function addPirate():void
		{
			var pirate:Pirate = new Pirate();
			addEntity(pirate);
			
			numPirates++;
			
			options.updateText(numPirates);
		}
	}
}