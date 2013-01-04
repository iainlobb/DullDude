package dulldude
{
	import flash.utils.Dictionary;
	import org.osflash.signals.Signal;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Iain Lobb - iainlobb@googlemail.com
	 */
	
	public class StarlingScreen extends Sprite
	{
		public var isShown:Boolean;
		protected var hasNextScreen:Array;
		protected var depthOfScreen:Dictionary;
		protected var currentScreenAtDepth:Array;
		protected var newScreenAtDepth:Array;
		protected var screenClassesByName:Object;
		protected var screensByClass:Object;
		
		private var _hidden:Signal;
		public function get hidden():Signal { return _hidden };
		
		private var _shown:Signal;
		public function get shown():Signal { return _shown };
		
		private var _screenHidden:Signal;
		public function get screenHidden():Signal { return _screenHidden };
		
		private var _screenShown:Signal;
		public function get screenShown():Signal { return _screenShown };
		
		private var _navigated:Signal;
		public function get navigated():Signal { return _navigated };
		
		protected var updateFunction:Function;
		
		public function StarlingScreen() 
		{
			screenClassesByName = { };
			screensByClass = { };
			
			hasNextScreen = [];
			
			_hidden = new Signal();
			_shown = new Signal();
			_navigated = new Signal();
			_screenHidden = new Signal(StarlingScreen);
			_screenShown = new Signal(StarlingScreen);
			
			depthOfScreen = new Dictionary();
			
			currentScreenAtDepth = [];
			newScreenAtDepth = [];
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function onEnterFrame(event:EnterFrameEvent):void
		{
			if (updateFunction != null) updateFunction();
		}
		
		public function destroy():void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function show():void
		{
			isShown = true;
			
			animateShow();
		}
		
		protected function animateShow():void
		{
			onShown();
		}
		
		public function hide():void
		{
			isShown = false;
			
			animateHide();
		}
		
		protected function animateHide():void
		{
			onHidden();
		}
		
		protected function onHidden():void
		{
			_screenHidden.dispatch(this);
			_hidden.dispatch();
		}
		
		protected function onShown():void
		{
			_screenShown.dispatch(this);
			_shown.dispatch();
		}
		
		public function updateText():void
		{
			
		}
		
		public function showScreenByName(name:String, depth:int = 0):void
		{
			showScreen(getScreenByName(name), depth);
		}
		
		public function showScreenByClass(screenClass:Class, depth:int = 0):void
		{
			showScreen(getScreenByClass(screenClass), depth);
		}
		
		public function showScreen(screen:StarlingScreen, depth:int = 0):void
		{
			if (this.contains(screen)) return;

			screen.screenHidden.add(onScreenHidden);
			
			hasNextScreen[depth] = true;
			
			newScreenAtDepth[depth] = screen;
			
			depthOfScreen[screen] = depth;
			
			if (currentScreenAtDepth[depth] && this.contains(currentScreenAtDepth[depth]))
			{
				hideCurrentScreen(depth);
			}
			else
			{
				showNewScreen(depth);
			}
		}
		
		protected function hideCurrentScreen(depth:int = 0):void
		{
			currentScreenAtDepth[depth].hide();
		}
		
		protected function getScreenByName(name:String):StarlingScreen
		{
			return getScreenByClass(screenClassesByName[name]);
		}
		
		protected function getScreenByClass(ScreenClass:Class):StarlingScreen
		{
			var screen:StarlingScreen = screensByClass[ScreenClass];
			
			if (!screen)
			{
				screen = new ScreenClass();
				screensByClass[ScreenClass] = screen;
			}
			
			return screen;
		}
		
		protected function onScreenHidden(screen:StarlingScreen):void
		{
			var depth:int = depthOfScreen[screen];
			
			if (this.contains(screen)) removeChild(currentScreenAtDepth[depth]);
			
			currentScreenAtDepth[depth] = null;
			
			if (hasNextScreen[depth])
			{
				showNewScreen(depth);
			}
		}
		
		protected function onScreenShown(screen:StarlingScreen):void
		{
			var depth:int = depthOfScreen[screen];
			
			hasNextScreen[depth] = false;
		}
		
		protected function onNavigated(screenName:String):void
		{
			showScreenByName(screenName);
		}
		
		protected function showNewScreen(depth:int):void
		{
			StarlingScreen(newScreenAtDepth[depth]).navigated.add(onNavigated);
			StarlingScreen(newScreenAtDepth[depth]).screenShown.add(onScreenShown);
			
			addChild(newScreenAtDepth[depth]);
			
			newScreenAtDepth[depth].show();
			
			currentScreenAtDepth[depth] = newScreenAtDepth[depth];
			
			sortDepths();
		}
		
		protected function sortDepths():void
		{
			var n:int = currentScreenAtDepth.length;
			
			for (var i:int = 0; i < n; i++)
			{
				var screen:StarlingScreen = currentScreenAtDepth[i];
				
				if (screen && contains(screen))
				{
					setChildIndex(screen, numChildren - 1);
				}
			}
		}
	}
}