package com.zw.frames.mvc.interfaces
{
	/**
	 * Notification的广播者，可以注册和广播Notification
	 * */
	public interface INotificationDispatcher extends INotifier
	{
		function registerObserver ( notificationName:String, handler:Function ):void;
		function removeObserver ( notificationName:String, handler:Function ):void;
	}
}