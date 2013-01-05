package asteroids 
{
	import dulldude.Entity;
	import dulldude.Game;
	import flash.display.Bitmap;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author Iain Lobb - iainlobb@gmail.com
	 */
	public class AsteroidsGame extends Game
	{
		static public var textureAtlas:TextureAtlas;
		public var players:Vector.<Entity> = new Vector.<Entity>();
		public var enemies:Vector.<Entity> = new Vector.<Entity>();
		//public var messageField:TextField;
		
		[Embed(source = "/../lib/ships.png")]
		public var SpriteSheet:Class;
		
		[Embed(source = "/../lib/ships.xml", mimeType="application/octet-stream")]
		public var SpriteSheetXML:Class;
		
		public function AsteroidsGame() 
		{
			var bitmap:Bitmap = new SpriteSheet();
			var texture:Texture = Texture.fromBitmap(bitmap);
			var xml:XML = XML(new SpriteSheetXML());
			
			textureAtlas = new TextureAtlas(texture, xml);
			
			//var frames:Vector.<Texture> = textureAtlas.getTextures("running_");
		}
		
		override protected function startGame():void 
		{
			var asteroid:Asteroid;
			for (var i:int = 0; i < 10; i++)
			{
				asteroid = new Asteroid();
				asteroid.targets = players;
				asteroid.group = enemies;
				enemies.push(asteroid);
				addEntity(asteroid);
			}
			
			var ship:Ship = new Ship();
			ship.targets = enemies;
			ship.destroyed.add(onPlayerDestroyed);
			players.push(ship);
			addEntity(ship);
			
			var enemyShip:EnemyShip = new EnemyShip();
			enemyShip.targets = players;
			enemyShip.group = enemies;
			enemies.push(enemyShip);
			addEntity(enemyShip);
			
			//filters = [new GlowFilter(0xFFFFFF, 0.8, 6, 6, 1)];
			
			update(0);
			
			renderGame(0);
			
			//isPaused = true;
			
			
			
			/*
			if (messageField)
			{
				addChild(messageField);
			}
			else
			{
				createMessage();
			}
			*/
			
			//stage.addEventListener(MouseEvent.MOUSE_DOWN, start);
		}
		
		protected function createMessage():void
		{
			/*
			messageField = new TextField();
			messageField.selectable = false;
			messageField.textColor = 0xFFFFFF;
			messageField.width = 600;
			messageField.scaleX = 2;
			messageField.scaleY = 3;
			messageField.text = "CLICK TO START";
			messageField.x = 400 - messageField.textWidth;
			messageField.y = 240;
			addChild(messageField);
			*/
		}
		
		//protected function start(event:MouseEvent):void
		protected function start():void
		{
			//stage.removeEventListener(MouseEvent.MOUSE_DOWN, start);
			
			isPaused = false;
			//removeChild(messageField);
			//stage.focus = stage;
		}
		
		protected function onPlayerDestroyed(entity:Entity):void
		{
			gameOver();
		}
		
		protected function gameOver():void
		{
			trace("gameOver");
			
			//addChild(messageField);
			isPaused = true;
			//stage.addEventListener(MouseEvent.MOUSE_DOWN, restart);
		}
		
		//protected function restart(event:MouseEvent):void
		protected function restart():void
		{
			stopGame();
			startGame();
			
			//stage.removeEventListener(MouseEvent.MOUSE_DOWN, restart);
			
			isPaused = false;
			
			//removeChild(messageField);
			//stage.focus = stage;
		}
		
		override protected function stopGame():void 
		{
			super.stopGame();
			
			players.length = 0;
			enemies.length = 0;
		}
		
		override protected function update(elapsedTime:Number):void 
		{
			super.update(elapsedTime);
		
			for each (var entity:Entity in entities)
			{
				
				if (entity.body.position.x > stage.stageWidth + 50) entity.body.position.x -= stage.stageWidth + 100;
				if (entity.body.position.x < -50) entity.body.position.x += stage.stageWidth + 100;
			
				if (entity.body.position.y > stage.stageHeight + 50) entity.body.position.y -= stage.stageHeight + 100;
				if (entity.body.position.y < -50) entity.body.position.y += stage.stageHeight + 100;
			}
			
			//if (enemies.length == 0) gameOver();
		}
		
	}
}