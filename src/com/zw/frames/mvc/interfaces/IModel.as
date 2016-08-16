/*
 PureMVC - Copyright(c) 2006-08 Futurescale, Inc., Some rights reserved.
 Your reuse is governed by the Creative Commons Attribution 3.0 United States License
*/
package com.zw.frames.mvc.interfaces
{
	public interface IModel 
	{
		
		function registerProxy( proxy:IProxy ) : void;
		function retrieveProxy( proxyName:String ) : IProxy;

		function removeProxy( proxyName:String ) : IProxy;

		/**
		 * Check if a Proxy is registered
		 * 
		 * @param proxyName
		 * @return whether a Proxy is currently registered with the given <code>proxyName</code>.
		 */
		function hasProxy( proxyName:String ) : Boolean;

	}
}