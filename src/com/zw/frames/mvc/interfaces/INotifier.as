package com.zw.frames.mvc.interfaces
{
	public interface INotifier
	{
		
		function sendNotification( notificationName:String, body:Object=null, type:String=null ):void; 
		function get name():String;
	}
}