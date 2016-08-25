package com.zw.frames.mvc.patterms.facade
{
	import flash.events.IEventDispatcher;
	
	import com.zw.frames.mvc.interfaces.IFacade;
	import com.zw.frames.mvc.interfaces.IFacadePile;
	import com.zw.frames.mvc.patterms.observer.NotificationDispatcher;
	
	public class FacadePile extends NotificationDispatcher implements IFacadePile
	{
		private static var instance:FacadePile = null;
		private var facadeMap:Object;
		
		public function FacadePile(target:IEventDispatcher=null){
			super(target);
			if(instance){
				throw new Error("单利只能初始化一次！")
			}
			instance = this;
			facadeMap = new Object();
		}
		
		public function registerFacade(facade:IFacade):void
		{
			if(facadeMap.hasOwnProperty(facade.name)){
				return
			}
			facadeMap[facade.name] = facade;
			var a:Array = facade.getPileNotificationNames();
			for(var i:int=0;i<a.length;i++){
				var str:String = a[i];
				this.registerObserver(str ,facade.pileNotificationHandler)
			}
		}
		
		public function retrieveFacade(facadeName:String):IFacade
		{
			var facade:IFacade = facadeMap.hasOwnProperty(facadeName) ? facadeMap[facadeName] : null;
			return facade;
		}
		
		public function removeFacade(facadeName:String):IFacade
		{
			var facade:IFacade = null;
			if(facadeMap.hasOwnProperty(facadeName)){
				facade = facadeMap[facadeName];
				delete facadeMap[facadeName];
				var a:Array = facade.getPileNotificationNames();
				for(var i:int=0;i<a.length;i++){
					var str:String = a[i];
					this.removeObserver(str ,facade.pileNotificationHandler);
				} 
			}
			return facade;
		}
		
		public function hasFacade(facadeName:String):Boolean
		{
			return facadeMap.hasOwnProperty(facadeName);
		}
		
		public static function getInsance():FacadePile{
			if(!instance){
				instance = new FacadePile()
			}
			return instance
		}
	}
}