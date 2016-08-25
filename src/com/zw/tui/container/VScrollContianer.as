///////////////////////////////////////////////////////////
//  VScrollContianer.as
//  Macromedia ActionScript Implementation of the Class VScrollContianer
//  Created on:      2016-3-8 下午8:06:42
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.tui.container
{
	
	import com.zw.event.ZEvent;
	import com.zw.tui.control.VScrollBar;
	import com.zw.utils.Utils_UI;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	/**
	 * 带垂直滚动条的容器
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2016-3-8 下午8:06:42
	 */
	public class VScrollContianer extends Sprite
	{
		protected var _scroll:VScrollBar;
		protected var _spr:Sprite;
		protected var _shp:Shape;
		
		private var _width:Number;
		private var _height:Number;
		private var _mc:MovieClip;
		
		public function VScrollContianer($mc:MovieClip , $width:Number=100 , $height:Number=100){
			super();
			_mc = $mc;
			_width = $width;
			_height = $height;
				
			creatChildren();
			initEvent();
			creatComplete();
			resize(_width , _height);
		}
		
		
//init
		protected function creatChildren():void{
			_spr = new Sprite();
			super.addChild(_spr);
			_shp = Utils_UI.creatMask(_spr , this , 0 , 0 , _width , _height);
			super.addChild(_shp);
			
			_scroll = new VScrollBar(_mc);
			super.addChild(_scroll);
		}
		
		protected function initEvent():void{
			_spr.addEventListener(Event.ADDED , onResize);
			_spr.addEventListener(Event.REMOVED , onResize);
			_scroll.addEventListener(ZEvent.Change , onScroll);
		}
		
		
		protected function creatComplete():void{
			//TODO...
		}
		
//event handler
		private function onScroll($e:Event):void{
			_spr.y = - _scroll.value;
		}
		
		private function onResize($e:Event=null):void{
			_scroll.visible = _shp.height <= _spr.height;
			if(!_scroll.visible){
				_spr.y = 0;
			}else{
				var h:Number = _spr.height - _shp.height;
				if(h!=_scroll.max){
					_scroll.setRange(0 , h);
					h = (_shp.height / _spr.height) * _scroll.height
					_scroll.setThumbHeight(h);
				}
			}
		}
		
//interface
		public function resize($width:Number , $height:Number):void{
			_width = $width;
			_height = $height;
			_shp.width = _width;
			_shp.height =_height; 
			
			_scroll.x = $width - _scroll.width;
			_scroll.height = _height;
			
			onResize();
		}		
		
		public function jumpToTOP():void{
			if(_scroll.visible){
				_spr.y = 0;
				_scroll.value = 0;
			}
		}
		
		override public function addChild(child:DisplayObject):DisplayObject{
			return _spr.addChild(child)
		}
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject{return _spr.addChildAt(child, index)}
		override public function removeChild(child:DisplayObject):DisplayObject{return _spr.removeChild(child)}
		override public function removeChildAt(index:int):DisplayObject{return _spr.removeChildAt(index)}
		override public function setChildIndex(child:DisplayObject, index:int):void{_spr.setChildIndex(child, index)}
		override public function swapChildren(child1:DisplayObject, child2:DisplayObject):void{_spr.swapChildren(child1 , child2)}
		override public function swapChildrenAt(index1:int, index2:int):void{_spr.swapChildrenAt(index1, index2)}
		override public function getChildAt(index:int):DisplayObject{return _spr.getChildAt(index)}
		override public function getChildByName(name:String):DisplayObject{return _spr.getChildByName(name)}
		override public function getChildIndex(child:DisplayObject):int{return _spr.getChildIndex(child)}
		override public function contains(child:DisplayObject):Boolean{return _spr.contains(child)}
		public function getChildIndex2($c:DisplayObject):int{
			return super.getChildIndex($c);
		}
		
//getter and setter
		override public function get numChildren():int{return _spr.numChildren}
		override public function get width():Number{return _width;}
		override public function set width(value:Number):void{}
		override public function get height():Number{return _height;}
		override public function set height($value:Number):void{
			resize(_width , $value);
		}
		
		public function get listHeight():Number{
			return _spr.height;
		}
		 
	}
}