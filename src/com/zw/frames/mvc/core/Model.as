package com.zw.frames.mvc.core
{
	import flash.utils.Proxy;
	
	import com.zw.frames.mvc.interfaces.IFacade;
	import com.zw.frames.mvc.interfaces.IModel;
	import com.zw.frames.mvc.interfaces.IProxy;
	
	public class Model implements IModel
	{
		public var facade:IFacade;
		protected var proxyMap:Object;
		
		
		public function Model(facade:IFacade)
		{
			this.facade = facade;
			proxyMap = new Object();
		}
		
		public function registerProxy(proxy:IProxy):void{
			proxyMap[proxy.name] = proxy;
			proxy.facade = this.facade;
			proxy.onRegister();
		}
		
		public function retrieveProxy(proxyName:String):IProxy
		{
			return proxyMap[proxyName];
		}
		
		public function removeProxy(proxyName:String):IProxy
		{
			var proxy:IProxy = null;
			if(proxyMap.hasOwnProperty(proxyName)){
				proxy = proxyMap[proxy.name]
				delete proxyMap[proxy.name];
				proxy.facade = null
				proxy.onRemove();
			}
			return proxy;
		}
		
		public function hasProxy(proxyName:String):Boolean
		{
			return proxyMap.hasOwnProperty(proxyName);
		}
	}
}