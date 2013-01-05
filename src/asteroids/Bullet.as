package asteroids 
{
	import dulldude.Body;
	import dulldude.Entity;
	import dulldude.Physics;
	import dulldude.View;
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Iain Lobb - iainlobb@gmail.com
	 */
	public class Bullet extends Entity
	{
		public function Bullet() 
		{
			body = new Body(this);
			body.radius = 5;
			
			physics = new Physics(this);
			
			view = new View(this);
			view.image = new Image(AsteroidsGame.textureAtlas.getTexture("Bullet0000"));
			view.image.pivotX = view.image.width / 2;
			view.image.pivotY = view.image.height / 2;
			view.scale = 0.5;
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
			
			//age++;
			if (age > 40) view.alpha -= 0.2;
			if (age > 50) destroy();
		}
		
	}

}