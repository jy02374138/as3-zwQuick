package com.zw.frames.mvc.interfaces
{
	public interface IFacadePile extends INotificationDispatcher
	{
		function registerFacade( facade:IFacade ) : void;
		
		function retrieveFacade( facadeName:String ) : IFacade;
		
		function removeFacade( facadeName:String ) : IFacade;
		
		function hasFacade( facadeName:String ) : Boolean;
	}
}