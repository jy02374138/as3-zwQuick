package com.zw.frames.mvc.interfaces
{
	
	public interface IMediator extends IMVCMember
	{
		
		function getViewComponent():Object;

		function setViewComponent( viewComponent:Object ):void;
		
		function listNotificationInterests( ):Array;
		
		function handleNotification( notification:INotification ):void;
		
		function onRegister( ):void;

		function onRemove( ):void;
		
	}
}