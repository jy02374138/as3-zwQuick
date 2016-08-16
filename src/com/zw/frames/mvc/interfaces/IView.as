package com.zw.frames.mvc.interfaces
{
	
	public interface IView 
	{
		
		function registerMediator( mediator:IMediator ) : void;

		function retrieveMediator( mediatorName:String ) : IMediator;

		function removeMediator( mediatorName:String ) : IMediator;
		
		function hasMediator( mediatorName:String ) : Boolean;
	}
	
}