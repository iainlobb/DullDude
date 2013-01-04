package piratemark 
{
	import dulldude.Game;
	/**
	 * ...
	 * @author Iain Lobb - iainlobb@gmail.com
	 */
	public class PirateMarkGame extends Game
	{
		
		public function PirateMarkGame() 
		{
			
		}
		
		override protected function startGame():void 
		{
			super.startGame();
			
			var pirate:Pirate;
			for (var i:int = 0; i < 100; i++)
			{
				pirate = new Pirate();
				addEntity(pirate);
			}
			
			touchable = false;
		}
		
		override protected function update(elapsedTime:Number):void 
		{
			super.update(elapsedTime);
		}
	}
}