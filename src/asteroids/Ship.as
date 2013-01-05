package asteroids 
{
	import com.iainlobb.gamepad.Gamepad;
	import com.iainlobb.gamepad.KeyCode;
	import dulldude.Body;
	import dulldude.Entity;
	import dulldude.Global;
	import dulldude.Health;
	import dulldude.Physics;
	import dulldude.View;
	import starling.display.Image;
	import starling.display.Sprite;

	/**
	 * ...
	 * @author Iain Lobb - iainlobb@gmail.com
	 */
	public class Ship extends Entity
	{
		protected var gamepad:Gamepad;
		
		public function Ship() 
		{
			body = new Body(this);
			body.position.x = 400;
			body.position.y = 300;
			
			physics = new Physics(this);
			physics.drag.setXY(0.9, 0.9);
			
			view = new View(this);
			view.image = new Image(AsteroidsGame.textureAtlas.getTexture("PlayerShip0000"));
			view.image.pivotX = view.image.width / 2;
			view.image.pivotY = view.image.height / 2;
			view.scale = 0.5;
			
			health = new Health(this);
			health.hits = 20;
			health.died.add(onDied);
											
			weapon = new Gun(this);
											
			gamepad = new Gamepad(Global.flashStage, false);
			gamepad.fire1.mapKey(KeyCode.SPACEBAR);
		}
		
		override public function update(elapsedTime:Number):void 
		{
			super.update(elapsedTime);
		
			body.angle += gamepad.x * 0.1;
			
			physics.thrust(-gamepad.y);
			
			//trace("updateShip", gamepad.x, gamepad.y);
			
			if (gamepad.fire1.isPressed) weapon.fire();
		}
		
		protected function onDied(entity:Entity):void
		{
			destroy();
		}
	}

}