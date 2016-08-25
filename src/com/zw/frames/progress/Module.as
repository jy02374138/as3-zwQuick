///////////////////////////////////////////////////////////
//  Module.as
//  Macromedia ActionScript Implementation of the Class Module
//  Created on:      2016-8-15 下午5:33:40
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.frames.progress
{
	import flash.utils.Dictionary;
	
	/**
	 * 模块
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2016-8-15 下午5:33:40
	 */
	public class Module
	{
		private const processorMap:Dictionary  = new Dictionary();
		private static const moduleMap:Dictionary = new Dictionary();
		
		public function Module(){
			this.onInit();
		}
		
//init
		protected function onInit() : void{
			return;
		}
		
		protected function onRegister():void{}
		protected function onRemove() : void{}
		
		protected function listProcessors() : Array{
			return null;
		}
		
		
//interface
		public function getClass() : Class{
			return this["constructor"];
		}
		
//progress
		private function registerProcessor($processor:Processor) : void{
			if (this.processorMap[$processor.getClass()] != null){
				throw Error("同一Module不能注册两个相同的Processor");
			}
			processorMap[$processor.getClass()] = $processor;
			$processor.registerEvents();
			$processor.onRegister();
		}
		
		private function hasProcessor($processorClass:Class) : Boolean{
			return processorMap[$processorClass] != null;
		}
		
		public function getProcessor($processorClass:Class) : Processor{
			return processorMap[$processorClass];
		}
		
		private function removeProcessor($processorClass:Class) : Processor{
			var p:Processor = this.processorMap[$processorClass] as Processor;
			if (p){
				this.processorMap[$processorClass] = null;
				delete this.processorMap[$processorClass];
				p.removeEvents();
				p.onRemove();
			}
			return p;
		}
		
		private function registerProcessors() : void{
			var p:Processor = null;
			var a:Array = this.listProcessors();
			if (!a){
				return
			}
			if (a.length > 0){
				for each (p in a){
					this.registerProcessor(p);
				}
			}
		}
		
		private function removeProcessors() : void{
			var p:Processor = null;
			var a:Array = this.listProcessors();
			if (!a){
				return
			}
			if (a.length > 0){
				for each (p in a){
					this.removeProcessor(p.getClass());
				}
			}
		}
		
//static方法，	增删查Module
		public static function hasModule($moduleClass:Class) : Boolean{
			return moduleMap[$moduleClass] != null;
		}
		
		public static function getModule($moduleClass:Class) : Module{
			return moduleMap[$moduleClass];
		}
		
		public static function removeModule($moduleClass:Class) : Module{
			var m:Module = moduleMap[$moduleClass] as Module;
			if (m){
				moduleMap[$moduleClass] = null;
				delete moduleMap[$moduleClass];
				m.removeProcessors();
				m.onRemove();
			}
			return m;
		}
		
		public static function registerModule($module:Module) : void{
			if (moduleMap[$module.getClass()] != null){
				throw Error("不能注册两个相同的Module");
			}
			moduleMap[$module.getClass()] = $module;
			$module.registerProcessors();
			$module.onRegister();
		}
	}
}