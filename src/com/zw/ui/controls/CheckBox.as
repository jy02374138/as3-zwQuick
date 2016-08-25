///////////////////////////////////////////////////////////
//  CheckBox.as
//  Macromedia ActionScript Implementation of the Class CheckBox
//  Created on:      2015-7-6 下午9:36:57
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.ui.controls
{
	import com.zw.ui.Component;
	import com.zw.ui.DefaultStyle;
	import com.zw.ui.event.UIEvent;
	import com.zw.ui.utils.Color;
	import com.zw.ui.utils.UIUtils;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	
	/**
	 * CkeckBox选中组件
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2015-7-6 下午9:36:57
	 * 
	 * @see flash.events.Event.Select
	 */
	public class CheckBox extends Component
	{
		private var _skin_up:DisplayObject;
		private var _skin_select:DisplayObject;
		
		private var _selected:Boolean = false;
		private var _label:String = "";
		
		public var txt:TextField;
		private var _currentChild:DisplayObject;
		
		public function CheckBox($label:String="")
		{
			super();
			this.mouseChildren = false;
			this.buttonMode = true;
			txt = UIUtils.creatTextField(this , $label , 20 , 0 , 12 , Color.WHITE);
			this.addEventListener(MouseEvent.CLICK , onClick);
		}
		
		override protected function creatDefaultSkin():void{
			_skin_up = new Image(DefaultStyle.CheckBox_up);
			_skin_select = new Image(DefaultStyle.CheckBox_selected);
			currentChild = _skin_up;
		}
		
//Event Handler
		private function onClick($e:MouseEvent):void{
			selected = !selected;
			var evt:UIEvent = new UIEvent(UIEvent.Select , _selected);
			this.dispatchEvent(evt);
		}
		
//getter and setter
		private function get currentChild():DisplayObject{
			return _currentChild;
		}
		
		private function set currentChild(value:DisplayObject):void{
			if(value==_currentChild){
				return
			}
			if(_currentChild){
				this.removeChild(_currentChild);
			}
			_currentChild = value;
			if(_currentChild){
				this.addChildAt(_currentChild , 0);
			}
		}

		public function get selected():Boolean{
			return _selected;
		}

		public function set selected($value:Boolean):void{
			if(_selected ==$value){
				return
			}
			_selected = $value;
			currentChild = _selected ? _skin_select : _skin_up;
		}

		public function get label():String
		{
			return _label;
		}

		public function set label($value:String):void
		{
			_label = $value;
			txt.text = _label;
		}
		
		public function set color($value:int):void{
			txt.textColor = $value;
			label = _label;
		}
	}
}