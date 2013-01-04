package dulldude 
{
	import starling.events.Event;
	/**
	 * ...
	 * @author Iain Lobb - iainlobb@gmail.com
	 */
	public class StarlingMain extends StarlingScreen
	{
		public function StarlingMain() 
		{

		}
		
		override protected function onAddedToStage(event:Event):void 
		{
			super.onAddedToStage(event);
			
			Global.starlingStage = stage;
		}
	}
}