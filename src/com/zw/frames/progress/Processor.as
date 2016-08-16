///////////////////////////////////////////////////////////
//  Processor.as
//  Macromedia ActionScript Implementation of the Class Processor
//  Created on:      2016-8-15 下午5:35:13
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.frames.progress
{
	import com.zw.frames.progress.event.ModuleEvent;
	import com.zw.frames.progress.event.ModuleEventManager;
	
	/**
	 * 过程
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2016-8-15 下午5:35:13
	 */
	public class Processor
	{
		private var _module:Module;
		
		public function Processor($module:Module){
			this._module = $module;
			this.onInit();
		}


//init
		protected function onInit() : void{}
		
		public function onRegister() : void{}
		public function onRemove() : void{}
		
		protected function listenModuleEvents() : Array{
			return [];
		}
		
//event handler
		protected function receivedModuleEventHandle($e:ModuleEvent) : void{
			
		}
		
		
//interface
		final public function dispatchEvent($e:ModuleEvent) : void{
			ModuleEventManager.dispatchEvent($e);
		}
		
		final public function registerEvents() : void{
			var a:Array = this.listenModuleEvents();
			if (a && a.length>0){
				ModuleEventManager.addEvents(a, receivedModuleEventHandle);
			}
		}
		
		final public function removeEvents() : void{
			ModuleEventManager.removeEvents(listenModuleEvents() , receivedModuleEventHandle);
		}
		
		final public function getClass() : Class{
			return this["constructor"];
		}
		
//getter and setter
		public function get module() : Module{
			return _module;
		}
	}
}