package dulldude
{
	/**
	 * ...
	 * @author Iain Lobb - iainlobb@gmail.com
	 */
	
	public class Body
	{
		public var entity:Entity;
		public var position:Vector2D = new Vector2D();
		public var oldPosition:Vector2D = new Vector2D();
		public var z:Number = 0;
		public var angle:Number = 0;
		public var radius:Number = 10;
		
		/*
		* If you give an entity a body it can take physical form in the world, although to see it you will need a view.
		*/
		
		public function Body(entity:Entity) 
		{
			this.entity = entity;
		}
		
		public function update(elapsedTime:Number):void
		{
			oldPosition.setEquals(position);
		}
	}
}