package dulldude
{
	import com.furusystems.dconsole2.DConsole;
	import com.furusystems.dconsole2.plugins.StageUtil;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	/**
	 * ...
	 * @author Iain Lobb - iainlobb@gmail.com
	 * 
	 * The base class for all dulldude framework projects. It extends a standard Flash Sprite, but for EVERYTHING else use Starling.
	 */
	public class Main extends Sprite 
	{
		private var starling:Starling; // Our one and only instance of Starling.
		public static var stage:Stage; // The Flash standard stage.
		public var isMobile:Boolean; // Is it mobile? Determines whether it shoudld allow multitouch and handle lost context.
		public var starlingMainClass:Class; // The class to instantiate Starling with. Must extend StarlingMain. Controls our whole application.
		public var starlingMain:StarlingMain; // The instance of StarlingMain that controls our whole application.
		
		public function Main():void 
		{
			if (stage)
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event = null):void 
		{
			Global.flashStage = stage;
			
			DConsole.registerPlugins(StageUtil);
			
			removeEventListener(Event.ADDED_TO_STAGE, init);

			Starling.multitouchEnabled = isMobile;
            Starling.handleLostContext = !isMobile;
            
            starling = new Starling(starlingMainClass, stage);
            starling.simulateMultitouch = true;
            starling.enableErrorChecking = false;
            starling.start();
			
			addChild(DConsole.view);
			DConsole.refresh();
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.RESIZE, onResize);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
		
		protected function onEnterFrame(event:Event):void
		{
			starling.showStats = true;
			starling.stage.stageWidth = Global.flashStage.stageWidth;
			starling.stage.stageHeight = Global.flashStage.stageHeight;
			starling.viewPort = new Rectangle(0, 0, Global.flashStage.stageWidth, Global.flashStage.stageHeight);
		}
		
		protected function onResize(event:Event):void
		{
			starling.stage.stageWidth = stage.stageWidth;
			starling.stage.stageHeight = stage.stageHeight;
			starling.viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
		}
	}
}