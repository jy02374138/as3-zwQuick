///////////////////////////////////////////////////////////
//  ModuleEventManager.as
//  Macromedia ActionScript Implementation of the Class ModuleEventManager
//  Created on:      2016-8-15 下午5:27:51
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.frames.progress.event
{
	import com.zw.event.ZEvent;
	
	import flash.events.EventDispatcher;
	
	/**
	 * 模块事件管理器
	 * 相当于是对ObserverThread的封装
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2016-8-15 下午5:27:51
	 * 
	 * @see com.zw.event.ZEvent
	 */
	public class ModuleEventManager extends EventDispatcher{
		
		private static var _instance:ModuleEventManager;
		
		
		public function ModuleEventManager(){
			if(_instance){
				throw new Error(ZEvent.SingletonError);
			}
			_instance = this
		}
		
		public static function addEvent($type:String, $callBack:Function) : void{
			instance.addEventListener($type , $callBack);
		}
		
		public static function addEvents($types:Array, $callBack:Function) : void{
			var type:String = null;
			for each (type in $types){
				addEvent(type, $callBack);
			}
		}
		
		public static function removeEvent($type:String, $callBack:Function) : void{
			instance.removeEventListener($type , $callBack);
		}
		
		
		public static function removeEvents($types:Array, $callBack:Function) : void{
			for each (var type:String in $types){
				removeEvent(type, $callBack);
			}
		}
		
		public static function dispatchEvent($e:ModuleEvent) : void{
			instance.dispatchEvent($e);
		}

		public static function get instance():ModuleEventManager{
			if(!_instance){
				_instance = new ModuleEventManager();
			}
			return _instance;
		}
	}
}