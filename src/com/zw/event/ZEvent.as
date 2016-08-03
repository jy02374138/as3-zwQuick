///////////////////////////////////////////////////////////
//  ZEvent.as
//  Macromedia ActionScript Implementation of the Class ZEvent
//  Created on:      2015-7-2 下午8:00:06
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.event
{
	import flash.events.Event;
	
	
	/**
	 * 通用事件
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2015-7-2 下午8:00:06
	 */
	public class ZEvent extends Event
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
		
		public function ZEvent($type:String, $data:Object=null , $bubbles:Boolean=false)
		{
			super($type, $bubbles);
			data = $data;
		}
		
	}
}