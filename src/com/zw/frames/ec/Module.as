///////////////////////////////////////////////////////////
//  Module.as
//  Macromedia ActionScript Implementation of the Class Module
//  Created on:      2016-3-29 下午10:16:05
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.frames.ec
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	
	/**
	 * 模块基础类
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2016-3-29 下午10:16:05
	 */
	public class Module extends EventDispatcher
	{
		public function Module(){
			super();
			var a:Array = listNotificationInterests();
			for (var i:int = 0; i < a.length; i++){
				EventDispatchCenter.instance.addEventListener(a[i] , handleNotification);
			}
		}
		
		protected function listNotificationInterests():Array{
			return [];
		}
		
		protected function handleNotification($e:EventBase):void {}
		
		protected function sendNotification($type:String , $data:Object=null):void{
			var evt:EventBase = new EventBase($type , $data);
			EventDispatchCenter.instance.dispatchEvent(evt);
		}
	}
}