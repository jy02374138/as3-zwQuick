package com.zw.utils
{
	public class Utils_Math
	{
		
		//保留小数点
		public static function saveRadixPoint(num:Number , numPoint:uint=2):Number{
			var i:int = Math.pow(10 , numPoint)
			var j:int = int(i * num)
			num = j / i;
			return num;
		}
		
		public static function ceil(value:Number , per:Number):Number{
			var num:int = Math.ceil(value / per);
			value = per * num;
			return value;
		}
		
		public static function floor(value:Number , per:Number):Number{
			var num:int = Math.floor(value / per);
			value = per * num;
			return value;
		}
		
		public static function round(value:Number , per:Number):Number{
			var num:int = Math.round(value / per);
			value = per * num;
			return value;
		}
		
		/**角度转弧度 */
		public static function angle2Radian(num:Number):Number{return (num/180)*Math.PI;}
		
		/** 弧度转角度*/
		public static function radian2angle(num:Number):Number{	return (num/Math.PI)*180;}
		
	}
}