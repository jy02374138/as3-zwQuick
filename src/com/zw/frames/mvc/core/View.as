package com.zw.frames.mvc.core
{
	import com.zw.frames.mvc.interfaces.IFacade;
	import com.zw.frames.mvc.interfaces.IMediator;
	import com.zw.frames.mvc.interfaces.INotification;
	import com.zw.frames.mvc.interfaces.IView;
	
	public class View implements IView
	{
		public var facade:IFacade;
		protected var mediatorMap:Object;
		
		public function View(facade:IFacade)
		{
			this.facade = facade;
			mediatorMap = new Object();
		}
		
		public function registerMediator(mediator:IMediator):void{
			if(mediatorMap.hasOwnProperty(mediator.name)){
				return
			}
			mediatorMap[mediator.name] = mediator;
			var a:Array = mediator.listNotificationInterests();
			for(var i:int=0;i<a.length;i++){
				var str:String = a[i];
				facade.registerObserver(str ,mediator.handleNotification)
			}
			mediator.facade = this.facade;
			mediator.onRegister();
		}
		
		public function retrieveMediator(mediatorName:String):IMediator
		{
			var mediator:IMediator = mediatorMap.hasOwnProperty(mediatorName) ? mediatorMap[mediatorName] : null;
			return mediator;
		}
		
		public function removeMediator(mediatorName:String):IMediator
		{
			var mediator:IMediator = null;
			if(mediatorMap.hasOwnProperty(mediatorName)){
				mediator = mediatorMap[mediatorName];
				delete mediatorMap[mediatorName];
				var a:Array = mediator.listNotificationInterests();
				for(var i:int=0;i<a.length;i++){
					var str:String = a[i];
					facade.removeObserver(str ,mediator.handleNotification);
				} 
				mediator.facade = null
				mediator.onRemove();
			}
			return mediator;
		}
		
		public function hasMediator(mediatorName:String):Boolean
		{
			return mediatorMap.hasOwnProperty(mediatorName);
		}
	}
}