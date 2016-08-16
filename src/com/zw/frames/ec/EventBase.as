///////////////////////////////////////////////////////////
//  EventBase.as
//  Macromedia ActionScript Implementation of the Class EventBase
//  Created on:      2016-3-29 下午10:13:45
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.frames.ec
{
	import flash.events.Event;
	
	
	/**
	 * 基础事件
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2016-3-29 下午10:13:45
	 */
	public class EventBase extends Event
	{
		public static const SingletonError:String = "singletonError";
		public static const ABSError:String = "absError";
		
		public static const Init:String = "init";
		
		public static const Selected:String = "selected";
		public static const Cancel:String = "cancel";
		public static const Failed:String = "failed";
		public static const Complete:String = "complete";
		public static const Change:String = "change";
		
		public var data:Object;
		
		
		public function EventBase($type:String, $data:Object=null , $bubbles:Boolean=false){
			super($type, $bubbles);
			data = $data;
		}
	}
}