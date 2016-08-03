///////////////////////////////////////////////////////////
//  Scale9.as
//  Macromedia ActionScript Implementation of the Class Scale9
//  Created on:      2015-7-3 下午2:15:36
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.ui.controls.scale
{
	import com.zw.ui.DefaultStyle;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * 九宫格缩放
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2015-7-3 下午2:15:36
	 */
	public class Scale9 extends ScaleBase
	{
		public function Scale9($w:Number, $h:Number , $skin:*=null)
		{
			super($w, $h);
			if($skin){
				skin = $skin;
			}
		}
		
		override protected function draw():void{
			var arr_source:Array = new Array();
			var arr_target:Array = new Array();
			
			var r:Rectangle = _rect_scale.clone();
			r.right = _width - (_bmd.width - _rect_scale.right);
			r.bottom = _height - (_bmd.height - _rect_scale.bottom);
			
			//左上
			var r_source:Rectangle = new Rectangle(0 , 0 , _rect_scale.left , _rect_scale.top);
			var r_target:Rectangle = r_source;
			add();
			
			//右上
			r_source.left = _rect_scale.right;
			r_source.right = _bmd.width
			r_target = r_source.clone();
			r_target.x = r.right;
			add();
			
			//右下
			r_source.top = _rect_scale.bottom;
			r_source.bottom = _bmd.height;
			r_target = r_source.clone();
			r_target.x = r.right;
			r_target.y = r.bottom;
			add();
			
			//左下
			r_source.left = 0;
			r_source.right = _rect_scale.left;
			r_target = r_source.clone();
			r_target.x = 0;
			r_target.y = r.bottom;
			add();
			
			//上中
			r_source = _rect_scale.clone();
			r_source.top = 0;
			r_source.bottom = _rect_scale.top;
			r_target = r_source.clone();
			r_target.width = r.width;
			add();
			
			//下中
			r_source.y = _rect_scale.bottom;
			r_target.y = r.bottom;
			add();
			
			//左中
			r_source = _rect_scale.clone();
			r_source.left = 0;
			r_source.right = _rect_scale.left;
			r_target = r_source.clone();
			r_target.bottom = r.bottom;
			add();
			
			//右中
			r_source.x = r_source.right;
			r_target.x = r.right;
			add();
			
			//中
			r_source = _rect_scale.clone();
			r_target = r.clone();
			add();
			
			for (var i:int = 0; i < arr_source.length; i++) {
				creat(arr_source[i] , arr_target[i]);
			}
			
			function add():void
			{
				arr_source.push(r_source.clone());
				arr_target.push(r_target.clone());
			}
		}
		
		override protected function creatDefaultSkin():void{
			skin = DefaultStyle.Bar_h;
		}
	}
}