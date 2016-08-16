package com.zw.frames.mvc.interfaces
{
	public interface ICommand
	{
		function execute( notification:INotification ,facade:IFacade) : void;
	}
}