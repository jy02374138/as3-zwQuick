///////////////////////////////////////////////////////////
//  UIEvent.as
//  Macromedia ActionScript Implementation of the Class UIEvent
//  Created on:      2015-7-2 下午7:55:43
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.ui.event
{
	import flash.events.Event;
	
	
	/**
	 * UI事件
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2015-7-2 下午7:55:43
	 */
	public class UIEvent extends Event
	{
		public static const Select:String = "select"; 
		public static const Change:String = "change";
		
		public var data:Object;
		
		public function UIEvent(type:String, data:Object=null , bubbles:Boolean=false)
		{
			super(type, bubbles);
			data = data;
		}
	}
}