package dulldude 
{
	import flash.utils.getTimer;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Iain Lobb - iainlobb@gmail.com
	 */
	
	public class Game extends StarlingScreen
	{
		public var entities:Vector.<Entity> = new Vector.<Entity>();
		public var isPaused:Boolean;
		public var ticks:int;
		public var lastTime:int;
		public var hasTimerStarted:Boolean;
		public var timeScale:Number = 30;
		
		/*
		 * Game is the base class for games.
		 */
		
		public function Game() 
		{

		}
		
		override protected function onEnterFrame(event:EnterFrameEvent):void 
		{
			if (isPaused) return;
			
			var newTime:int = getTimer();
			var elapsed:int;
			if (hasTimerStarted)
			{
				elapsed = newTime - lastTime;
			}
			else
			{
				elapsed = 167;
			}
			
			var elapsedTime:Number = (elapsed / 1000) * timeScale;
			
			update(elapsedTime);
			
			renderGame(elapsedTime);
			
			ticks++;
			
			lastTime = newTime;
			hasTimerStarted = true;
		}
		
		protected function update(elapsedTime:Number):void
		{
			for each (var entity:Entity in entities) entity.update(elapsedTime);
		}
		
		protected function renderGame(elapsedTime:Number):void
		{
			for each (var entity:Entity in entities)
			{
				if (entity.view)
				{
					entity.render(elapsedTime);
				}
			}
		}
		
		override protected function onAddedToStage(event:Event):void 
		{
			super.onAddedToStage(event);
		
			startGame();
		}
		
		protected function startGame():void
		{
			
		}
		
		protected function stopGame():void
		{
			for each (var entity:Entity in entities)
			{
				if (entity.view)
				{
					
				}
			}
			
			entities.length = 0;
		}
		
		public function addEntity(entity:Entity):Entity
		{
			entities.push(entity);
			
			entity.destroyed.add(onEntityDestroyed);
			entity.entityCreated.add(addEntity);
			
			if (entity.view)
			{
				addChild(entity.view.displayObject);
			}
			
			return entity;
		}
		
		protected function onEntityDestroyed(entity:Entity):void
		{
			entities.splice(entities.indexOf(entity), 1);
			
			if (entity.view)
			{
				removeChild(entity.view.displayObject);
			}
			
			entity.destroyed.remove(onEntityDestroyed);
		}
	}
}