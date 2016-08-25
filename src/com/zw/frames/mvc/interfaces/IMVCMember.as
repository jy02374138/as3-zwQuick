package com.zw.frames.mvc.interfaces
{
	public interface IMVCMember extends INotifier
	{
		function get facade():IFacade;
		function set facade(value:IFacade):void;
	}
}