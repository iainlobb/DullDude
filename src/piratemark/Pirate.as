package piratemark 
{
	import dulldude.Body;
	import dulldude.Entity;
	import dulldude.Global;
	import dulldude.MathHelper;
	import dulldude.Physics;
	import dulldude.View;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	/**
	 * ...
	 * @author Iain Lobb - iainlobb@gmail.com
	 */
	
	public class Pirate extends Entity 
	{
		[Embed(source = "/../lib/pirate.png")]
		public var PirateArt:Class;
		static public var texture:Texture;
		private var image:Image;
		public var minX:Number = 100;
		public var minY:Number = 0;
		public var maxX:Number = 800;
		public var maxY:Number = 600;
		
		public function Pirate():void 
		{
			view = new View(this);
			view.sprite = new Sprite();
			
			if (!texture)
			{
				texture = Texture.fromBitmap(new PirateArt());
			}
			
			image = new Image(texture);
			image.x = - image.width / 2;
			image.y = - image.height / 2;
			view.sprite.addChild(image);
			view.scale = MathHelper.random(0.5, 1.5);
			view.alpha = MathHelper.random(0.2, 1);
			
			view.sprite.touchable = false;
			image.touchable = false;
			
			body = new Body(this);
			body.position.x = MathHelper.randomInt(0, Global.starlingStage.stageWidth);
			body.position.y = MathHelper.randomInt(0, Global.starlingStage.stageHeight);
			
			physics = new Physics(this);
			physics.velocity.setXY(MathHelper.random(-20, 20), MathHelper.random(-20, 20));
			physics.angularVelocity = MathHelper.random(-MathHelper.CIRCLE / 360, MathHelper.CIRCLE / 360);
			physics.gravity.y = 1.5;
		}
		
		override public function update(elapsedTime:Number):void 
		{
			super.update(elapsedTime);
			
			maxX = Global.starlingStage.stageWidth - 100;
			maxY = Global.starlingStage.stageHeight;
			
			if (body.position.x < minX)
			{
				body.position.x = minX;
				physics.velocity.x *= -1;
				
			}
			else if (body.position.x > maxX)
			{
				body.position.x = maxX;
				physics.velocity.x *= -1;
			}
			
			var feetOffset:Number = Math.abs(Math.cos(body.angle) * image.height * view.scale * 0.5);
			var tummyOffset:Number = Math.abs(Math.sin(body.angle) * image.width * view.scale * 0.5);
			
			var yOffset:Number = Math.max(feetOffset, tummyOffset);
			
			if (body.position.y + yOffset > maxY)
			{
				body.position.y = maxY - yOffset;
				physics.velocity.y *= -0.8;
				
				if (Math.random() > 0.5)
				{
					physics.velocity.y -= Math.random() * 20;
				}
			}
		}
	}
}