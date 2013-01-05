package asteroids 
{
	import dulldude.Entity;
	import dulldude.Weapon;
	/**
	 * ...
	 * @author Iain Lobb - iainlobb@gmail.com
	 */
	public class Gun extends Weapon 
	{
		public function Gun(entity:Entity) 
		{
			super(entity);
		}
		
		override public function fire():void 
		{
			var bullet:Bullet = new Bullet();
			bullet.targets = entity.targets;
			bullet.body.position.x = entity.body.position.x;
			bullet.body.position.y = entity.body.position.y;
			bullet.body.angle = entity.body.angle;
			bullet.physics.thrust(10);
			entity.entityCreated.dispatch(bullet);
			
			super.fire();
		}
		
	}

}