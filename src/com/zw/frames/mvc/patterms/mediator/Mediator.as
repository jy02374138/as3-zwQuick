package com.zw.frames.mvc.patterms.mediator
{
	import com.zw.frames.mvc.interfaces.IMediator;
	import com.zw.frames.mvc.interfaces.INotification;
	import com.zw.frames.mvc.patterms.MVCMember;
	
	public class Mediator extends MVCMember implements IMediator
	{
		public function Mediator(viewComponent:Object=null)
		{
			super();
			this.setViewComponent(viewComponent);
		}
		
		public function getViewComponent():Object
		{
			return null;
		}
		
		public function setViewComponent(viewComponent:Object):void
		{
		}
		
		public function listNotificationInterests():Array
		{
			return [];
		}
		
		public function handleNotification(notification:INotification):void
		{
		}
		
		public function onRegister():void
		{
		}
		
		public function onRemove():void
		{
		}
	}
}