///////////////////////////////////////////////////////////
//  HSlider.as
//  Macromedia ActionScript Implementation of the Class HSlider
//  Created on:      2015-7-7 下午3:01:27
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.ui.controls
{
	import com.zw.ui.Component;
	import com.zw.ui.DefaultStyle;
	import com.zw.ui.controls.scale.HBar;
	import com.zw.ui.utils.UIUtils;
	
	import flash.display.SimpleButton;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	/**
	 * 水平滑块组件
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2015-7-7 下午3:01:27
	 */
	public class HSlider extends Component
	{
		public var min:Number = 0;
		public var max:Number = 100;
		
		private var _width:Number = 100;
		private var _value:Number = 0;
		
		private var _lastMouseX:Number
		
		private var _bar:HBar;
		private var _thumb:SimpleButton;
		
		public function HSlider($width:Number=100)
		{
			super();
			_width = $width;
		}
		
//初始化
		override protected function onAdded(e:Event):void{
			super.onAdded(e);
			initEvent()
		}
		
		override protected function creatDefaultSkin():void{
			_bar = new HBar(100 , 20);
			_bar.skin = DefaultStyle.Slider_hbar;
			this.addChild(_bar);
			_bar.buttonMode = true;
			
			_thumb = UIUtils.creatSimplButton(this , DefaultStyle.Slider_thumb_up , 0 , 0 ,  DefaultStyle.Slider_thumb_over , DefaultStyle.Slider_thumb_down);
			_thumb.y = (_bar.height - _thumb.height) / 2;
		}
		
		private function initEvent():void{
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN , onDown);
		}
		
		
//Event Handler
		protected function onDown(event:MouseEvent):void
		{
			_thumb.x = this.mouseX
			stage.addEventListener(MouseEvent.MOUSE_MOVE , onMove);
			stage.addEventListener(MouseEvent.MOUSE_UP , onUp);
			stage.addEventListener(MouseEvent.MOUSE_OUT , onUp);
		}
		
		private function onMove(event:MouseEvent):void
		{
			var l:Number = _bar.width - _thumb.width;
			_thumb.x += (mouseX - _lastMouseX);
			_thumb.x = Math.max(0 , _thumb.x);
			_thumb.x = Math.min(l , _thumb.x);
			_lastMouseX = mouseX;
		}		
		
		private function onUp(event:MouseEvent):void
		{
			var s:Stage = event.currentTarget as Stage;
			stage.removeEventListener(MouseEvent.MOUSE_MOVE , onMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP , onUp);
			stage.removeEventListener(MouseEvent.MOUSE_OUT , onUp);
		}
		
//getter and setter
		override public function get width():Number
		{
			return _width;
		}

		override public function set width(value:Number):void
		{
			_width = value;
		}

		public function get value():Number
		{
			return _value;
		}

		public function set value(value:Number):void
		{
			_value = value;
		}

		
	}
}