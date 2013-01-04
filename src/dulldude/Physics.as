package dulldude  
{
	/**
	 * ...
	 * @author Iain Lobb - iainlobb@gmail.com
	 */
	public class Physics
	{
		public var entity:Entity;
		public var drag:Vector2D = new Vector2D(1, 1);
		public var velocity:Vector2D = new Vector2D();
		public var oldVelocity:Vector2D = new Vector2D();
		public var velocityZ:Number = 0;
		public var dragZ:Number = 1;
		public var gravity:Vector2D = new Vector2D();
		public var gravityZ:Number = 0;
		public var angularVelocity:Number = 0;
		public var oldAngularVelocity:Number = 0;
		
		/*
		 * Provides a basic physics step without collision detection. Extend to add collision handling.
		 */
		
		public function Physics(entity:Entity) 
		{
			this.entity = entity;
		}
		
		public function update(elapsedTime:Number):void
		{
			velocity.x *= Math.pow(drag.x, elapsedTime);
			velocity.y *= Math.pow(drag.y, elapsedTime);
			
			velocity.x += gravity.x * elapsedTime;
			velocity.y += gravity.y * elapsedTime;
			
			entity.body.angle += angularVelocity * elapsedTime;
			
			var averageSpeedX:Number = (velocity.x + oldVelocity.x) * 0.5;
			var averageSpeedY:Number = (velocity.y + oldVelocity.y) * 0.5;
			
			entity.body.position.x += averageSpeedX * elapsedTime;
			entity.body.position.y += averageSpeedY * elapsedTime;
			
			oldVelocity.setEquals(velocity);
		}
		
		public function thrust(power:Number):void
		{
			velocity.x += Math.sin(-entity.body.angle) * power;
			velocity.y += Math.cos(-entity.body.angle) * power;
		}
	}
}