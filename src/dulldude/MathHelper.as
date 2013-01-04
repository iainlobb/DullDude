package dulldude 
{
	/**
	 * ...
	 * @author Iain Lobb
	 */
	
	public class MathHelper 
	{
		public static var TAU:Number = Math.PI * 2;
		public static var TWO_PI:Number = Math.PI * 2;
		public static var PI_OVER_TWO:Number = Math.PI / 2;
		public static var PI_OVER_FOUR:Number = Math.PI / 4;
		public static var PI_OVER_EIGHT:Number = Math.PI / 8;
		public static var DEGREES_TO_RADIANS:Number = Math.PI / 180;
		public static var RADIANS_TO_DEGREES:Number = 180 / Math.PI;
		
		public static var CIRCLE:Number = Math.PI * 2;
		public static var HALF_CIRCLE:Number = Math.PI;
		public static var QUARTER_CIRCLE:Number = Math.PI / 2;
		public static var EIGHTH_CIRCLE:Number = Math.PI / 4;
		public static var SIXTEENTH_CIRCLE:Number = Math.PI / 8;
		
		/*
		 * Useful static functions for working with math. DO NOT INSTANTIATE.
		 */
		
		public function MathHelper() 
		{
			
		}
		
		public static function random(from:Number = 0, to:Number = 1):Number
		{
			return (Math.random() * (to - from)) + from;
		}
		
		public static function randomInt(from:Number = 0, to:Number = 1):int
		{
			return Math.floor(MathHelper.random(from, to));
		}
		
		public static function randomIntInclusive(from:Number = 0, to:Number = 1):int
		{
			return Math.floor(MathHelper.randomInt(from, to + 1));
		}
		
		public static function randomBoolean(chance:Number = 0.5):Boolean
		{
			return Math.random() < chance;
		}
		
		public static function randomPlusMinus(chance:Number = 0.5):int
		{
			return (Math.random() < chance) ? -1 : 1;
		}
		
		public static function roundToDecimalPlaces(number:Number, decimalPlaces:int):Number
		{
			var shift:int = Math.pow(10, decimalPlaces);
			return Math.round(number * shift) / shift;
		}
		
		public static function floorToDecimalPlaces(number:Number, decimalPlaces:int):Number
		{
			var shift:int = Math.pow(10, decimalPlaces);
			return Math.floor(number * shift) / shift;
		}
		
		public static function ceilToDecimalPlaces(number:Number, decimalPlaces:int = 0):Number
		{
			var shift:int = Math.pow(10, decimalPlaces);
			return Math.ceil(number * shift) / shift;
		}
		
		public static function getSign(value:Number):Number
		{
			return (value >= 0) ? 1 : -1;
		}
		
		public static function getDistance(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			var dx:Number = x1 - x2;
			var dy:Number = y1 - y2;
			return Math.sqrt((dx * dx) + (dy * dy));
		}
		
		public static function constrain(value:Number, min:Number = 0, max:Number = 1):Number
		{
			if (value > max)
			{
				return max;
			}
			else if (value < min)
			{
				return min;
			}
			
			return value;
		}
		
		public static function boxesCollide(left1:Number, right1:Number, top1:Number, bottom1:Number, left2:Number, right2:Number, top2:Number, bottom2:Number):Boolean
		{
			if (bottom1 < top2)
			{
				return false;
			}
			else if (top1 > bottom2)
			{
				return false;
			}
			else if (right1 < left2)
			{
				return false;
			}
			else if (left1 > right2)
			{
				return false;
			}
			
			return true;
		}
		
		public static function convertToFraction(value:Number, lowerLimit:Number, upperLimit:Number):Number
		{
			var range:Number = upperLimit - lowerLimit;
			var valueOffset:Number = value - lowerLimit;
			return valueOffset / range;
		}
		
		public static function convertToRange(value:Number, lowerLimit:Number, upperLimit:Number):Number
		{
			var range:Number = upperLimit - lowerLimit;
			return lowerLimit + (value * range);
		}
		
		public static function convertRanges(value:Number, lowerLimit1:Number, upperLimit1:Number, lowerLimit2:Number, upperLimit2:Number, isClamped:Boolean = false):Number
		{
			var fraction:Number = convertToFraction(value, lowerLimit1, upperLimit1);
			if (isClamped)
			{
				return convertToRange(fraction, lowerLimit2, upperLimit2);
			}
			else
			{
				var result:Number = convertToRange(fraction, lowerLimit2, upperLimit2);
				var max:Number = Math.max(lowerLimit2, upperLimit2);
				
				if (result > max)
				{
					return max;
				}
				else
				{
					var min:Number = Math.min(lowerLimit2, upperLimit2);
					if (result < min) return min;
					
					return result;
				}
			}
		}
		
		public static function isWithinRange(value:Number, lowerLimit:Number, upperLimit:Number):Boolean
		{
			return value > lowerLimit && value < upperLimit;
		}
		
			
		public static function smallestAngle(angle:Number, targetAngle:Number):Number
		{
			angle = limitRadians(angle);
			targetAngle = limitRadians(targetAngle);
			
			// STANDARD
			
			var difference1:Number = targetAngle - angle;
			
			// "ROUND THE HORN" CLOCKWISE / POSITIVE 
			
			var difference2:Number = (targetAngle + (Math.PI * 2)) - angle;
						
			// "ROUND THE HORN" ANTI-CLOCKWISE / NEGATIVE 
			
			var difference3:Number = (targetAngle - (Math.PI * 2)) - angle;
			
			// GET SHORTEST		
			
			var absDifference1:Number = Math.abs(difference1);
			var absDifference2:Number = Math.abs(difference2);
			var absDifference3:Number = Math.abs(difference3);
			
			var difference:Number = difference1;
			
			if (absDifference2 < absDifference1 && absDifference2 < absDifference3)
			{
				difference = difference2;
			}
			else if (absDifference3 < absDifference1 && absDifference3 < absDifference2)
			{
				difference = difference3;
			}
			
			return difference;
		}
		
		public static function limitPlusMinus(value:Number, max:Number):Number
		{
			var output:Number = Math.min(Math.abs(value), max);
			output *= MathHelper.getSign(value);
			
			return output;
		}
		
		/* LIMIT RADIANS 
		limit angle to +/- PI */
		
		public static function limitRadians(angle:Number):Number
		{
			if (angle >= 0)
			{
				while (angle > Math.PI)
				{
					angle -= MathHelper.TWO_PI;
				}
			}
			else
			{
				while (angle < -Math.PI)
				{
					angle += MathHelper.TWO_PI;
				}
			}
			
			return angle;
		}
		
		/*
		 * return distance between 2 points
		 */
		
		public static function hyp(x1:Number, y1:Number, x2:Number, y2:Number):Number 
		{
			var dx:Number = x1 - x2;
			var dy:Number = y1 - y2;
			
			return Math.sqrt((dx*dx)+(dy*dy));
		}
		
		public static function hyp2(dx:Number, dy:Number):Number 
		{
			return Math.sqrt((dx*dx)+(dy*dy));
		}
		
		public static function closerThan(x1:Number, y1:Number, x2:Number, y2:Number, distance:Number):Boolean 
		{
			var dx:Number = x1 - x2;
			var dy:Number = y1 - y2;
			
			return (dx*dx)+(dy*dy) < distance * distance;
		}
		
		public static function xor(condition1:Boolean, condition2:Boolean):Boolean
		{
			return !( condition1 && condition2 ) && ( condition1 || condition2 );
		}
		
		public static function getOutcome(condition1:Boolean, condition2:Boolean):Boolean
		{
			return !( condition1 && condition2 ) && ( condition1 || condition2 );
		}
	}
}