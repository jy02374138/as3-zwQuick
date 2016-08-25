package com.zw.frames.mvc.patterms.observer
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import com.zw.frames.mvc.interfaces.INotificationDispatcher;
	import com.zw.frames.mvc.patterms.MVCMember;
	
	public class NotificationDispatcher extends EventDispatcher implements INotificationDispatcher
	{
		private var _name:String;
		
		public function NotificationDispatcher(target:IEventDispatcher=null)
		{
			super(target);
			_name = MVCMember.getName(this);
		}
		
		public function registerObserver(notificationName:String, handler:Function):void
		{
			this.addEventListener(notificationName ,handler); 
		}
		
		public function removeObserver(notificationName:String, handler:Function):void
		{
			this.removeEventListener(notificationName ,handler);
		}
		
		public function sendNotification(notificationName:String, body:Object=null, type:String=null):void
		{
			var note:Notification = new Notification(notificationName , body , type);
			this.dispatchEvent(note);
		}
		
		public function get name():String{
			return _name;
		}
	}
}