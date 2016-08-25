package com.zw.frames.mvc.patterms.command 
{
	import com.zw.frames.mvc.interfaces.ICommand;
	import com.zw.frames.mvc.interfaces.IFacade;
	import com.zw.frames.mvc.interfaces.INotification;

	public class MacroCommand implements ICommand
	{
		private var subCommands:Array;
		
		public function MacroCommand()
		{
			subCommands = new Array();
			initializeMacroCommand();			
		}
		
		protected function initializeMacroCommand():void
		{
		}
		
		protected function addSubCommand( commandClassRef:Class ): void
		{
			subCommands.push(commandClassRef);
		}
		
		public final function execute( notification:INotification ,facade:IFacade) : void
		{
			while ( subCommands.length > 0) {
				var commandClassRef : Class = subCommands.shift();
				var commandInstance : ICommand = new commandClassRef();
				commandInstance.execute( notification ,facade);
			}
		}
								
	}
}