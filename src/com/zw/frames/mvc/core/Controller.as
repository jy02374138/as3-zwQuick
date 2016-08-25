package com.zw.frames.mvc.core
{
	import com.zw.frames.mvc.interfaces.ICommand;
	import com.zw.frames.mvc.interfaces.IController;
	import com.zw.frames.mvc.interfaces.IFacade;
	import com.zw.frames.mvc.interfaces.INotification;

	/**
	 * 每一条Notification只能映射到一个
	 * */
	public class Controller implements IController
	{
		public var facade:IFacade;
		protected var commandsMap:Object;
		
		public function Controller(facade:IFacade)
		{
			this.facade = facade;
			commandsMap = new Object();
		}
		
		public function registerCommand(notificationName:String, commandClassRef:Class):void{
			if(commandsMap.hasOwnProperty(notificationName)){
				return
			}
			commandsMap[notificationName] = commandClassRef;
			facade.registerObserver(notificationName , executeCommand);
		}
		
		public function executeCommand(notification:INotification):void{
			if(!commandsMap.hasOwnProperty(notification.getName())){
				return
			}
			var c:Class = commandsMap[notification.getName()];
			var command:ICommand = new c();
			command.execute(notification ,this.facade);
		}
		
		public function removeCommand(notificationName:String):void{
			if(!commandsMap.hasOwnProperty(notificationName)){
				return
			}
			delete commandsMap[notificationName];
		}
		
		public function hasCommand(notificationName:String):Boolean
		{
			return commandsMap.hasOwnProperty(notificationName);
		}
	}
}