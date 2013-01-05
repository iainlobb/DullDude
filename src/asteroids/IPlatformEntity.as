package asteroids 
{
	import engine.IEntity;
	
	/**
	 * ...
	 * @author Iain Lobb - iainlobb@gmail.com
	 */
	public interface IPlatformEntity extends IEntity
	{
		function set platformController(value:PlatformController):void;
		function get platformController():PlatformController;
	}
}