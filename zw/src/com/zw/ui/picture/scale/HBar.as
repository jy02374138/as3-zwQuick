///////////////////////////////////////////////////////////
//  HBar.as
//  Macromedia ActionScript Implementation of the Class HBar
//  Created on:      2015-7-2 下午8:59:35
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.ui.picture.scale
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * 水平拉伸条
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2015-7-2 下午8:59:35
	 */
	public class HBar extends ScaleBase
	{
		public function HBar($w:Number, $h:Number)
		{
			super($w, $h);
		}
		
		override protected function draw():void{
			//左
			var r_source:Rectangle = new Rectangle(0 , 0 , _rect_scale.left , _height);
			var r_target:Rectangle = r_source.clone();
			creat(r_source , r_target);
			
			//中
			r_source.left = _rect_scale.left;
			r_source.right = _rect_scale.right;
			r_target.left = _rect_scale.left;
			r_target.right = _width - (_bmd.width - _rect_scale.right);
			creat(r_source , r_target);
			
			//右
			r_source.left = _rect_scale.right;
			r_source.right = _bmd.width;
			
			r_target.left = r_target.right;
			r_target.right = _width
			creat(r_source , r_target);
		}
	}
}