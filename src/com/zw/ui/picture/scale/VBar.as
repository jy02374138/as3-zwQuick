///////////////////////////////////////////////////////////
//  VBar.as
//  Macromedia ActionScript Implementation of the Class VBar
//  Created on:      2015-7-3 下午2:05:29
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.ui.picture.scale
{
	import flash.geom.Rectangle;
	
	/**
	 * 垂直拉伸条
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2015-7-3 下午2:05:29
	 */
	public class VBar extends ScaleBase
	{
		public function VBar($w:Number, $h:Number)
		{
			super($w, $h);
		}
		
		override protected function draw():void{
			//上
			var r_source:Rectangle = new Rectangle(0 , 0 , _width , _rect_scale.top);
			var r_target:Rectangle = r_source.clone();
			creat(r_source , r_target);
			
			//中
			r_source = _rect_scale.clone();
			r_source.top = _rect_scale.top;
			r_source.bottom = _rect_scale.bottom;
			r_target.top = _rect_scale.top;
			r_target.bottom = _height - (_bmd.height - _rect_scale.bottom);
			creat(r_source , r_target);
			
			//下
			r_source.top = _rect_scale.bottom;
			r_source.bottom = _bmd.height;
			r_target.top = r_target.bottom;
			r_target.bottom = _height;
			creat(r_source , r_target);
		}
	}
}