///////////////////////////////////////////////////////////
//  ScrollBar.as
//  Macromedia ActionScript Implementation of the Class ScrollBar
//  Created on:      2016-3-8 下午7:00:47
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.tui.control
{
	import com.zw.event.ZEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	 * 滚动条
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2016-3-8 下午7:00:47
	 */
	public class VScrollBar extends Sprite
	{
		private var _mc:MovieClip;
		private var _mc_bg:MovieClip;
		private var _mc_thumb:MovieClip;
		
		private var _stage:Stage;
		
		private var _height:Number = 500;
		private var _value:Number = 0;
		private var _rect:Rectangle;
		private var _min:Number = 0;
		private var _max:Number = 100;
		
		private var _ypos:Number;
		
		
		public function VScrollBar($mc:MovieClip){
			super();
			
			this.addChild($mc);
			
			_mc = $mc;
			_mc.x = _mc.y = 0
			_mc_bg = $mc.mc_bg;
			_mc_thumb = $mc.mc_thumb;
			
			_rect = new Rectangle(0 , 0 , 0 , _mc_bg.height - _mc_thumb.height);
			
			_mc.mouseEnabled = _mc.mouseChildren = true;
			_mc_thumb.mouseEnabled = _mc_thumb.buttonMode = true;
			
			_mc_thumb.addEventListener(MouseEvent.MOUSE_DOWN,onDown);
		}
		
		private function onDown($e:MouseEvent):void{
			_stage = _mc.stage;
			_ypos = _mc.stage.mouseY;
			_stage.addEventListener(MouseEvent.MOUSE_UP,onStage);
			_stage.addEventListener(MouseEvent.ROLL_OVER,onStage);
			_stage.addEventListener(MouseEvent.ROLL_OUT,onStage);
			_stage.addEventListener(MouseEvent.MOUSE_MOVE,onMove);
		}
		
		private function onMove($e:MouseEvent):void{
			var yy:Number = _stage.mouseY - _ypos;
			_ypos = _stage.mouseY;
			_mc_thumb.y += yy;
			_mc_thumb.y  = Math.min(_rect.height , _mc_thumb.y);
			_mc_thumb.y  = Math.max(0 , _mc_thumb.y);
			_value = _mc_thumb.y / _rect.height;
			_value = _min + (_max - _min)*_value;
			var evt:ZEvent = new ZEvent(ZEvent.Change , _value);
			this.dispatchEvent(evt);
		}
		
		private function onStage($e:MouseEvent):void{
			_stage.removeEventListener(MouseEvent.MOUSE_UP,onStage);
			_stage.removeEventListener(MouseEvent.ROLL_OVER,onStage);
			_stage.removeEventListener(MouseEvent.ROLL_OUT,onStage);
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMove);
		}
		
//interface
		public function setThumbHeight($val:Number):void{
			_mc_thumb.height = $val;
			height = _height;
		}
		
		public function setRange($min:Number , $max:Number):void{
			_min = $min;
			_max =  $max;
			value = _value;
		}
		
//getter and setter
		
		override public function get height():Number{
			return _height;
		}

		override public function set height($value:Number):void{
			_height = $value;
			_mc_bg.height = $value;
			_rect.height = _height - _mc_thumb.height;
			value = _value;
		}

		public function get value():Number{
			return _value;
		}

		public function set value($value:Number):void{
			_value = Math.max($value , _min);
			_value = Math.min($value , _max);
			var n:Number = (_value - _min) / (_max - _min);
			_mc_thumb.y = _rect.height * n;
		}
		
		public function get max():Number{
			return _max;
		}
	}
}