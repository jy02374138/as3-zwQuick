package com.zw.frames.mvc.patterms.facade
{
	import flash.events.IEventDispatcher;
	
	import com.zw.frames.mvc.core.Controller;
	import com.zw.frames.mvc.core.Model;
	import com.zw.frames.mvc.core.View;
	import com.zw.frames.mvc.interfaces.IController;
	import com.zw.frames.mvc.interfaces.IFacade;
	import com.zw.frames.mvc.interfaces.IMediator;
	import com.zw.frames.mvc.interfaces.IModel;
	import com.zw.frames.mvc.interfaces.INotification;
	import com.zw.frames.mvc.interfaces.IProxy;
	import com.zw.frames.mvc.interfaces.IView;
	import com.zw.frames.mvc.patterms.observer.NotificationDispatcher;
	
	public class Facade extends NotificationDispatcher implements IFacade
	{
		protected var controller : IController;
		protected var model : IModel;
		protected var view : IView;
		
		
		public function Facade()
		{
			super();
			initializeFacade()
		}
		
	//初始化
		protected function initializeFacade():void {
			initializeModel();
			initializeController();
			initializeView();
			FacadePile.getInsance().registerFacade(this);
		}
		
		protected function initializeModel():void{
			if ( model != null ) return;
			model = new Model(this);
		}
		protected function initializeController():void{
			if ( controller != null ) return;
			controller = new Controller(this);
		}
		protected function initializeView():void{
			if ( view != null ) return;
			view = new View(this);
		}
		
	//内部MVC
		public function registerProxy(proxy:IProxy):void
		{
			model.registerProxy(proxy);
		}
		
		public function retrieveProxy(proxyName:String):IProxy
		{
			return model.retrieveProxy(proxyName);
		}
		
		public function removeProxy(proxyName:String):IProxy
		{
			return model.removeProxy(proxyName);;
		}
		
		public function hasProxy(proxyName:String):Boolean
		{
			return model.hasProxy(proxyName);
		}
		
		public function registerCommand(noteName:String, commandClassRef:Class):void
		{
			controller.registerCommand(noteName , commandClassRef)
		}
		
		public function removeCommand(notificationName:String):void{
			controller.removeCommand(notificationName);
		}
		
		public function hasCommand(notificationName:String):Boolean
		{
			return controller.hasCommand(notificationName);
		}
		
		public function registerMediator(mediator:IMediator):void{
			view.registerMediator(mediator);
		}
		
		public function retrieveMediator(mediatorName:String):IMediator
		{
			return view.retrieveMediator(mediatorName);
		}
		
		public function removeMediator(mediatorName:String):IMediator
		{
			return view.removeMediator(mediatorName);
		}
		
		public function hasMediator(mediatorName:String):Boolean
		{
			return view.hasMediator(mediatorName);
		}
		
	//管道通信
		public function getPileNotificationNames():Array{
			return [];
		}
		
		public function pileNotificationHandler(notification:INotification):void{
			
		}
	}
}