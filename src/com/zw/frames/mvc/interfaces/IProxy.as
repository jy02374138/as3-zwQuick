package com.zw.frames.mvc.interfaces
{
	
	public interface IProxy extends IMVCMember
	{
		
		function setData( data:Object ):void;
		
		function getData():Object; 
		
		function onRegister( ):void;

		function onRemove( ):void;
	}
}