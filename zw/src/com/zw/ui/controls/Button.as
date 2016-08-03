///////////////////////////////////////////////////////////
//  Button.as
//  Macromedia ActionScript Implementation of the Class Button
//  Created on:      2015-7-4 下午3:52:45
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.ui.controls
{
	import com.zw.ui.Component;
	import com.zw.ui.DefaultStyle;
	import com.zw.ui.ISkin;
	import com.zw.ui.controls.scale.Scale9;
	import com.zw.ui.event.UIEvent;
	import com.zw.ui.utils.Color;
	import com.zw.ui.utils.UIUtils;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	
	/**
	 * 按钮
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2015-7-4 下午3:52:45
	 */
	public class Button extends Component
	{
		/**
		 * 自动对齐模式，只允许单行文本
		 * 按钮的大小取决于padding数值和文字大小 
		 */
		public static const AutoPadding:String = "padding";
		/**
		 * 固定宽高，可以有多行文本
		 */
		public static const Fix:String = "fix";
		
		
		private var _scaleMode:String = AutoPadding;
		private var _selected:Boolean = false;
		private var _useSelect:Boolean = false;
		
		private var _label:String = "";
		
		public var paddingLeft:Number = 20;
		public var paddingRight:Number = 20;
		public var paddingTop:Number = 5;
		public var paddingBottom:Number = 5;
		
		public var _skin_up:DisplayObject;
		public var _skin_over:DisplayObject;
		public var _skin_down:DisplayObject;
		public var _skin_selected:DisplayObject;
		private var _currentChild:DisplayObject = null;
		
		private var _txt:TextField
		private var _width:Number = 100;
		private var _height:Number = 100;
		
		public function Button($label:String="")
		{
			super()
			mouseChildren = false;
			this.buttonMode=  true
			_txt = UIUtils.creatTextField(this , "" , 0 , 0 , 12 , Color.FUCHSIA);
			this.addEventListener(MouseEvent.MOUSE_OVER , onMouse);
			this.addEventListener(MouseEvent.MOUSE_OUT , onMouse);
			this.addEventListener(MouseEvent.MOUSE_DOWN , onMouse);
			this.addEventListener(MouseEvent.MOUSE_UP , onMouse);
			label = $label;
		}
		
		override protected function creatDefaultSkin():void{
			if(!_skin_up){
				_skin_up = new Scale9(_width , _height , DefaultStyle.Btn2_up);
				_skin_over = new Scale9(_width , _height , DefaultStyle.Btn2_over);
				_skin_down = new Scale9(_width , _height , DefaultStyle.Btn2_down);
				_skin_selected = new Scale9(_width , _height , DefaultStyle.Btn2_selected);
				currentChild = _skin_up;
			}
		}

//Event Handler
		private function onMouse(e:Event):void{
			switch(e.type){
				case MouseEvent.MOUSE_OVER:
					currentChild = _skin_over;
					break
				case MouseEvent.MOUSE_DOWN:
					currentChild = _skin_down;
					break
				case MouseEvent.CLICK:
					_selected = !_selected;
					var evt:UIEvent = new UIEvent(UIEvent.Select , _selected);
					this.dispatchEvent(evt);
				case MouseEvent.MOUSE_UP:
				case MouseEvent.MOUSE_OUT:
					if(_useSelect && _skin_selected && _selected){
						currentChild = _skin_selected;
					}else{
						currentChild = _skin_up;	
					}
					break
			}
		}
		
//逻辑功能实现
		private function layout():void{
			creatDefaultSkin()
			var f:TextFormat = _txt.defaultTextFormat;
			if(scaleMode==AutoPadding){
				f.align = TextFormatAlign.LEFT;
				_txt.defaultTextFormat = f;
				_txt.autoSize = TextFieldAutoSize.LEFT
				_txt.wordWrap = false;
				_txt.y = paddingTop;
				_txt.width = _txt.textWidth+4;
				_txt.height = _txt.textHeight+3;
				_width = _txt.width + paddingRight + paddingLeft;
				_height = _txt.height + paddingTop + paddingBottom;
			}
			
			if(scaleMode==Fix){
				_txt.autoSize = TextFieldAutoSize.NONE
				f.align = TextFormatAlign.CENTER;
				_txt.defaultTextFormat = f;
				_txt.wordWrap = true;
				_txt.width = _width - paddingLeft - paddingRight;
				var h:Number = _height - paddingLeft - paddingBottom;
				_txt.height = Math.min((_txt.textHeight+4) , h);
				_txt.y = paddingTop + (h - _txt.height)/2;
			}
			
			_txt.x = paddingLeft;
			_txt.text = _txt.text;
			_skin_up.width = _skin_over.width = _skin_down.width = _skin_selected.width = _width;
			_skin_up.height = _skin_over.height = _skin_down.height = _skin_selected.height = _height;
		}
		
//interface
		public function setPadding($left:Number=-1 , $right:Number=-1 , $top:Number=-1 , $bottom:Number=-1):void{
			paddingLeft = $left>=0 ? $left : paddingLeft;
			paddingRight = $right>=0 ? $right : paddingRight;
			paddingTop = $top>=0 ? $top : paddingTop;
			paddingBottom = $bottom>=0 ? $bottom : paddingBottom;
			layout();
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
		
		/**
		 * 对齐模式模式（设置此值不能触发重绘，）
		 * @see Button.AutoPadding
		 * @see Button.Fix
		 */
		public function get scaleMode():String
		{
			return _scaleMode;
		}

		/**
		 * @private
		 */
		public function set scaleMode(value:String):void
		{
			_scaleMode = value;
			layout()
		}
		
		public function get useSelect():Boolean
		{
			return _useSelect;
		}

		public function set useSelect(value:Boolean):void
		{
			_useSelect = value;
			if(_useSelect){
				_selected = false;
				this.addEventListener(MouseEvent.CLICK , onMouse);
			}else{
				if(currentChild==_skin_selected){
					currentChild = _skin_up;
				}
				this.removeEventListener(MouseEvent.CLICK , onMouse);
			}
		}

		public function get label():String
		{
			return _label;
		}

		public function set label(value:String):void
		{
			_label = value;
			_txt.text = _label;
			if(_scaleMode==AutoPadding){
				layout()
			}
		}

		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void{
			_selected = value;
		}
		
		override public function set skin($value:*):void{};
		override public 	function get skin():*{return null}
		
		/**
		 * 设置按钮宽度，当缩放模式为AutoPadding时，对其赋值不起作用。
		 */
		override public function get width():Number
		{
			return _width;
		}
		
		/**
		 * @param $value
		 * 设置按钮宽度，当缩放模式为AutoPadding时，对其赋值不起作用。
		 */
		override public function set width($value:Number):void{
			if(scaleMode==AutoPadding){
				return
			}
			_width = $value;
			layout()
		}
		
		/**
		 * 设置按钮高度，当缩放模式为AutoPadding时，对其赋值不起作用。
		 */
		override public function get height():Number{
			return _height;
		}
		
		/**
		 * @param $value
		 * 设置按钮宽度，当缩放模式为AutoPadding时，对其赋值不起作用。
		 */
		override public function set height($value:Number):void
		{
			if(scaleMode==AutoPadding){
				return
			}
			_height = $value;
			layout()
		}

		public function get color():int
		{
			var f:TextFormat = _txt.defaultTextFormat;
			var c:int = f.color as int;
			return c;
		}

		public function set color(value:int):void
		{
			var f:TextFormat = _txt.defaultTextFormat;
			f.color = value;
			_txt.defaultTextFormat = f;
			_txt.text = _txt.text;
		}

	}
}