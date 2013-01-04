package dulldude  
{
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Iain Lobb - iainlobb@gmail.com
	 */
	public class View
	{
		public var entity:Entity;
		public var scale:Number = 1;
		public var scaleX:Number = 1;
		public var scaleY:Number = 1;
		public var alpha:Number = 1;
		public var visible:Boolean = true;
		private var _sprite:Sprite;
		private var _image:Image;
		public var displayObject:DisplayObject;
		
		/*
		 * View is display component which renders an Entity using Starling. 
		 */
		
		public function View(entity:Entity) 
		{
			this.entity = entity;
		}
		
		public function render():void
		{
			displayObject.x = entity.body.position.x;
			displayObject.y = entity.body.position.y;
			displayObject.rotation = entity.body.angle;
			displayObject.alpha = alpha;
			displayObject.scaleX = scale * scaleX;
			displayObject.scaleY = scale * scaleY;
		}
		
		public function get sprite():Sprite 
		{
			return _sprite;
		}
		
		public function set sprite(value:Sprite):void 
		{
			displayObject = value;
			_sprite = value;
		}
		
		public function get image():Image 
		{
			return _image;
		}
		
		public function set image(value:Image):void 
		{
			displayObject = value;
			_image = value;
		}
	}
}