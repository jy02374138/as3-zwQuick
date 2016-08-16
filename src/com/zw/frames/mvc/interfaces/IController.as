/*
 PureMVC - Copyright(c) 2006-08 Futurescale, Inc., Some rights reserved.
 Your reuse is governed by the Creative Commons Attribution 3.0 United States License
*/
package com.zw.frames.mvc.interfaces
{
	
	public interface IController
	{

		function registerCommand( notificationName : String, commandClassRef : Class ) : void;
		
		
		function executeCommand( notification : INotification ) : void;

		
		function removeCommand( notificationName : String ):void;

		function hasCommand( notificationName:String ) : Boolean;
	}
}