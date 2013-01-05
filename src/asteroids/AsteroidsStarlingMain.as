package asteroids 
{
	import dulldude.Game;
	import dulldude.StarlingMain;
	import starling.events.Event;
	/**
	 * ...
	 * @author Iain Lobb - iainlobb@gmail.com
	 */
	public class AsteroidsStarlingMain extends StarlingMain
	{
		public function AsteroidsStarlingMain() 
		{
			
		}
		
		override protected function onAddedToStage(event:Event):void 
		{
			super.onAddedToStage(event);
			
			var game:AsteroidsGame = new AsteroidsGame();
			showScreen(game);
		}
		
	}

}