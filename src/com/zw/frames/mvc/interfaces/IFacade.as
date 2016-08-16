package com.zw.frames.mvc.interfaces
{

	public interface IFacade extends INotificationDispatcher 
	{
		function getPileNotificationNames():Array;
		function pileNotificationHandler(notification:INotification):void
		
		function registerProxy( proxy:IProxy ) : void;
		function retrieveProxy( proxyName:String ) : IProxy;
		function removeProxy( proxyName:String ) : IProxy;
		function hasProxy( proxyName:String ) : Boolean;

		function registerCommand( noteName : String, commandClassRef : Class ) : void;
		function removeCommand( notificationName:String ): void;
		function hasCommand( notificationName:String ) : Boolean;
		function registerMediator( mediator:IMediator ) : void;

		function retrieveMediator( mediatorName:String ) : IMediator;
		function removeMediator( mediatorName:String ) : IMediator;
		function hasMediator( mediatorName:String ) : Boolean;

	}
}