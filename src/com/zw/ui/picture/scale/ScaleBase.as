///////////////////////////////////////////////////////////
//  ScaleBase.as
//  Macromedia ActionScript Implementation of the Class ScaleBase
//  Created on:      2015-7-2 下午7:48:43
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.ui.picture.scale
{
	import com.zw.ui.ISkin;
	import com.zw.utils.Utils;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	
	/**
	 * 九宫格和三宫格的基础类
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2015-7-2 下午7:48:43
	 */
	public class ScaleBase extends Sprite implements ISkin
	{
		protected var _width:Number;
		protected var _height:Number;
		
		protected var _skin:*;
		protected var _bmd:BitmapData;
		protected var _rect_scale:Rectangle
		
		public function ScaleBase($w:Number , $h:Number)
		{
			super();
			this.mouseChildren = this.mouseEnabled = false;
		}
		
		protected function refuse():void
		{
			while(this.numChildren){
				var b:Bitmap = this.removeChildAt(0) as Bitmap;
				if(b && b.bitmapData){
					b.bitmapData.dispose();
					b.bitmapData = null;
				}
			}
			
			if(!_bmd || !_rect_scale){
				return
			}
			draw();
		}
		
		protected function draw():void{
			
		}
		
		protected function creat($r_source:Rectangle , $r_target:Rectangle):void{
			var b:BitmapData = new BitmapData($r_source.width , $r_source.height , true , 0x0);
			b.copyPixels(_bmd , $r_source , new Point());
			
			var bmp:Bitmap = new Bitmap(b);
			bmp.width = $r_target.width;
			bmp.height = $r_target.height;
			bmp.x = $r_target.x;
			bmp.y = $r_target.y;
			this.addChild(bmp);
		}
		
//getter and setter
		private function get bmd():BitmapData{
			return _skin as BitmapData;
		}
		
		
		/**
		 * @param $value 皮肤源
		 * 	可以是Bitmap
		 * 可以使BitmapData
		 * 可以使BitmapData或Bitmap的类名String
		 * 将来也许还会支持SWF
		 */
		public function set skin($value:*):void
		{
			_skin = $value;
			if($value is String){
				$value = Utils.class2Object($value) as BitmapData;
			}
			
			if($value is BitmapData){
				_bmd = $value;
			}
			else if($value is Bitmap){
				_bmd = ($value as Bitmap).bitmapData;
			}
			
			if(_bmd && !_rect_scale){
				_rect_scale = _bmd.rect.clone();
				if(_rect_scale.width>20){
					_rect_scale.left = 10;
					_rect_scale.right = 10;
				}
				if(_rect_scale.height>20){
					_rect_scale.top = 10;
					_rect_scale.bottom = 10;
				}
			}
			refuse();
		}
		
		public function get rect_scale():Rectangle{
			return _rect_scale;
		}
		
		public function set rect_scale(value:Rectangle):void{
			_rect_scale = value;
			refuse();
		}
		
		public function get skin():*
		{
			return _skin;
		}

		override public function get width():Number
		{
			return _width;
		}

		override public function set width(value:Number):void
		{
			_width = value;
			refuse();
		}

		override public function get height():Number
		{
			return _height;
		}

		override public function set height(value:Number):void
		{
			_height = value;
			refuse();
		}
	}
}