package asteroids 
{
	import dulldude.Main;
	/**
	 * ...
	 * @author Iain Lobb - iainlobb@gmail.com
	 */
	
	[SWF(width="1024", height="768", frameRate="60", backgroundColor="#000000")]
	public class AsteroidsMain extends Main
	{
		public function AsteroidsMain() 
		{
			starlingMainClass = AsteroidsStarlingMain;
			
			super();
		}
	}
}