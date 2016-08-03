///////////////////////////////////////////////////////////
//  FrameTool.as
//  Macromedia ActionScript Implementation of the Class FrameTool
//  Created on:      2015-12-15 上午11:07:37
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.test
{
	import com.zw.ui.utils.UIUtils;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.getTimer;
	
	
	/**
	 * 实时帧频检测
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2015-12-15 上午11:07:37
	 */
	public class FrameTool extends Sprite
	{
		public static var inited:Boolean = false;
		
		private var _time:Number;
		public var frame:Number
		
		private var _stage:Stage;
		
		private static var _instance:FrameTool = null;
		
		public function FrameTool($stage:Stage){
			super();
			_stage = $stage
			$stage.addEventListener(Event.ENTER_FRAME , onFrame);
		}
		
		private function onFrame($e:Event):void{
			var t1:Number = getTimer();
			var  t2:Number = t1 - _time;
			_time = t1;
			t2 = 1000 / t2;
			t2 = Math.round(t2*10);
			t2 /= 10;
			frame = t2;
		}
		
//interface
		public static function init($stage:Stage):void{
			if(!inited && $stage){
				inited = true
				_instance = new FrameTool($stage);
			}
		}
		
//getter and setter
		public static function get instance():FrameTool{
			return _instance;
		}

	}
}