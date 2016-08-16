///////////////////////////////////////////////////////////
//  EventDispatchCenter.as
//  Macromedia ActionScript Implementation of the Class EventDispatchCenter
//  Created on:      2016-3-29 下午9:47:22
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.frames.ec
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	
	/**
	 * 事件调度中心
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2016-3-29 下午9:47:22
	 */
	public class EventDispatchCenter extends EventDispatcher
	{
		private static var _instance:EventDispatchCenter;
		
		public function EventDispatchCenter(){
			super();
			if(_instance){
				throw new Error(EventBase.SingletonError)
			}
			_instance = this;
		}

		public static function get instance():EventDispatchCenter{
			if(!_instance){
				_instance = new EventDispatchCenter();
			}
			return _instance;
		}
	}
}