package piratemark 
{
	import dulldude.Game;
	import dulldude.StarlingMain;
	import starling.events.Event;
	/**
	 * ...
	 * @author Iain Lobb - iainlobb@gmail.com
	 */
	public class PirateMarkStarlingMain extends StarlingMain
	{
		public function PirateMarkStarlingMain() 
		{
			
		}
		
		override protected function onAddedToStage(event:Event):void 
		{
			super.onAddedToStage(event);
			
			var game:PirateMarkGame = new PirateMarkGame();
			showScreen(game);
		}
		
	}

}