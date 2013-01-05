package asteroids 
{
	import dulldude.Body;
	import dulldude.Entity;
	import dulldude.Health;
	import dulldude.Physics;
	import dulldude.View;
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Iain Lobb - iainlobb@gmail.com
	 */
	public class EnemyShip extends Entity
	{
		protected var turnDirection:Number = 1;
		
		public function EnemyShip() 
		{
			body = new Body(this);
			body.position.x = 750;
			body.position.y = 550;
			
			physics = new Physics(this);
			physics.drag.setXY(0.9, 0.9);
			
			view = new View(this);
			view.image = new Image(AsteroidsGame.textureAtlas.getTexture("EnemyShip0000"));
			view.image.pivotX = view.image.width / 2;
			view.image.pivotY = view.image.height / 2;
			view.scale = 0.5;
			
			health = new Health(this);
			health.hits = 5;
			health.died.add(onDied);
		
			weapon = new Gun(this);
		}
		
		override public function update(elapsedTime:Number):void 
		{
			super.update(elapsedTime);
		
			if (Math.random() < 0.1) turnDirection = -turnDirection;
			
			body.angle += turnDirection * 0.1;
			
			physics.thrust(Math.random());
			
			if (Math.random() < 0.05) weapon.fire();
		}
		
		protected function onDied(entity:Entity):void
		{
			destroy();
		}
		
	}

}