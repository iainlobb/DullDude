package asteroids 
{
	import dulldude.Body;
	import dulldude.Entity;
	import dulldude.Health;
	import dulldude.MathHelper;
	import dulldude.Physics;
	import dulldude.View;
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Iain Lobb - iainlobb@gmail.com
	 */
	public class Asteroid extends Entity
	{
		public function Asteroid() 
		{
			body = new Body(this);
			body.radius = 20;
			body.position.x = Math.random() * 800;
			body.position.y = Math.random() * 600;
			
			physics = new Physics(this);
			physics.velocity.x = (Math.random() * 10) - 5;
			physics.velocity.y = (Math.random() * 10) - 5;
			physics.angularVelocity = MathHelper.random( -MathHelper.CIRCLE / 20, MathHelper.CIRCLE / 20);
			
			view = new View(this);
			view.image = new Image(AsteroidsGame.textureAtlas.getTexture("Asteroid0000"));
			view.image.pivotX = view.image.width / 2;
			view.image.pivotY = view.image.height / 2;
			view.scale = 0.5;
			
			health = new Health(this);
			health.hits = 3;
			health.hurt.add(onHurt);
		}
		
		override public function update(elapsedTime:Number):void 
		{
			super.update(elapsedTime);
		
			for each (var target:Entity in targets)
			{
				if (body.position.distanceTo(target.body.position) < (body.radius + target.body.radius) * 0.5)
				{
					target.health.hit(1);
					destroy();
					return;
				}
			}
		}
		
		protected function onHurt(entity:Entity):void
		{
			body.radius *= 0.75;
			view.scale *= 0.75;
			
			if (body.radius < 10)
			{
				destroy();
				return;
			}
			
			var asteroid:Asteroid = new Asteroid();
			asteroid.targets = targets;
			group.push(asteroid);
			asteroid.group = group;
			asteroid.body.position.x = body.position.x;
			asteroid.body.position.y = body.position.y;
			asteroid.body.radius = body.radius;
			asteroid.view.scale = view.scale;
			entityCreated.dispatch(asteroid);
		}
		
	}

}