package dulldude 
{
	/**
	 * ...
	 * @author Iain Lobb
	 */
	public class Vector2D 
	{
		private var _x:Number = 0;
		private var _y:Number = 0;
		
		/*
		 * Vector2D is a useful multi-purpose Vector with an x and y axis.
		 */
		
		public function Vector2D(x:Number = 0, y:Number =0) 
		{
			this.x = x;
			this.y = y;
		}
		
		public function get magnitude():Number
		{
			return Math.sqrt(x * x + y * y);
		}
		
		public function get x():Number { return _x; }
		
		public function set x(value:Number):void 
		{
			_x = value;
		}
		
		public function get y():Number { return _y; }
		
		public function set y(value:Number):void 
		{
			_y = value;
		}
		
		public function toString():String
		{
			return "x:" + x + " y:" + y;
		}
		
		public function plusEquals(vector2D:Vector2D):Vector2D
		{
			x += vector2D.x;
			y += vector2D.y;
			
			return this;
		}
		
		public function minusEquals(vector2D:Vector2D):Vector2D
		{
			x -= vector2D.x;
			y -= vector2D.y;
				
			return this;
		}
		
		public function timesEquals(vector2D:Vector2D):Vector2D
		{
			x *= vector2D.x;
			y *= vector2D.y;
			
			return this;
		}
		
		public function plus(vector2D:Vector2D):Vector2D
		{
			return new Vector2D(x + vector2D.x, y + vector2D.y);
		}
		
		public function plusXY(x:Number, y:Number):Vector2D
		{
			return new Vector2D(this.x + x, this.y + y);
		}
		
		public function minus(vector2D:Vector2D):Vector2D
		{
			return new Vector2D(x - vector2D.x, y - vector2D.y);
		}
		
		public function minusXY(x:Number, y:Number):Vector2D
		{
			return new Vector2D(this.x - x, this.y - y);
		}
		
		public function times(vector2D:Vector2D):Vector2D
		{
			return new Vector2D(x * vector2D.x, y * vector2D.y);
		}
		
		public function timesScalar(scalar:Number):Vector2D
		{
			return new Vector2D(x * scalar, y * scalar);
		}
		
		public function timesEqualsScalar(scalar:Number):Vector2D
		{
			x *= scalar;
			y *= scalar;
			
			return this;
		}
		
		public function setEquals(vector2D:Vector2D):Vector2D
		{
			x = vector2D.x;
			y = vector2D.y;
			
			return this;
		}
		
		public function plusEqualsXY(x:Number, y:Number):Vector2D
		{
			this.x += x;
			this.y += y;
			
			return this;
		}
		
		public function minusEqualsXY(x:Number, y:Number):Vector2D
		{
			this.x -= x;
			this.y -= y;
			
			return this;
		}
		
		public function setXY(x:Number, y:Number):Vector2D
		{
			this.x = x;
			this.y = y;
			
			return this;
		}
		
		public function clone():Vector2D
		{
			return new Vector2D(x, y);
		}
		
		public function normalize():Vector2D
		{
			var m:Number = magnitude;
			if (m == 0) m = 0.0001;
			return timesScalar(1 / m);
		}
		
		public function isCloserThan(position:Vector2D, distance:Number):Boolean
		{
			var dx:Number = position.x - x;
			var dy:Number = position.y - y;
			
			return (dx * dx) + (dy * dy) < distance * distance;
		}
		
		public function isWithinBox(top:Number, right:Number, bottom:Number, left:Number):Boolean
		{
			return x <= right && x >= left && y >= top && y <= bottom;
		}
		
		public function distanceTo(position:Vector2D):Number
		{
			return this.minus(position).magnitude;
		}
		
		public function yDistanceTo(position:Vector2D):Number
		{
			return position.y - y;
		}
		
		public function xDistanceTo(position:Vector2D):Number
		{
			return position.x - x;
		}
		
		public function absoluteYDistanceTo(position:Vector2D):Number
		{
			return Math.abs(y - position.y);
		}
		
		public function absoluteXDistanceTo(position:Vector2D):Number
		{
			return Math.abs(x - position.x);
		}
		
		
		public function angleTo(position:Vector2D):Number
		{
			var dx:Number = position.x - x;
			var dy:Number = position.y - y;
			return Math.atan2(dx, dy);
		}
		
		public function get angle():Number
		{
			return Math.atan2(x, y);
		}
		
		public function projectOnto(v:Vector2D):Vector2D
		{
			var dp:Number = this.dot(v);
			var f:Number  = dp / ( v.x*v.x + v.y*v.y );
			return new Vector2D( f*v.x , f*v.y);
		}
		
		public function dot(v:Vector2D):Number
		{
			return x * v.x + y * v.y;
		}
			
		public function cross(v:Vector2D):Number
		{
			return x * v.y - y * v.x;
		}
		
		public function rotate(angle:Number):Vector2D
		{
			var a:Number = angle;
			var cos:Number = Math.cos(a);
			var sin:Number = Math.sin(a);
			return new Vector2D( (cos*x) - (sin*y) , (cos*y) + (sin*x) );
		}
		
		public function rotateSelf(angle:Number):Vector2D
		{
			var a:Number = angle;
			var cos:Number = Math.cos(a);
			var sin:Number = Math.sin(a);
			setXY((cos * x) - (sin * y), (cos * y) + (sin * x));
			return this;
		}
		
		public function leftHandNormal():Vector2D
		{
			return new Vector2D(this.y, -this.x);
		}
		
		public function rightHandNormal():Vector2D
		{
			return new Vector2D(-this.y, this.x);
		}
		
		public function getClosest(others:Vector.<Vector2D>):Vector2D
		{
			var closest:Vector2D;
			var closestDistance:Number = Infinity;
			
			for each (var other:Vector2D in others)
			{
				var distance:Number = this.distanceTo(other);
				if (distance < closestDistance)
				{
					closest = other;
					closestDistance = distance;
				}
			}
			
			return closest;
		}
		
		public function clampAbsolute(maximum:Number):Vector2D
		{
			var clamped:Vector2D = clone();
			
			if (clamped.x > maximum)
			{
				clamped.x = maximum;
			}
			else if (clamped.x < -maximum)
			{
				clamped.x = -maximum;
			}
			
			if (clamped.y > maximum)
			{
				clamped.y = maximum;
			}
			else if (clamped.y < -maximum)
			{
				clamped.y = -maximum;
			}
			
			return clamped;
		}
	}
}