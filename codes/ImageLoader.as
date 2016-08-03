///////////////////////////////////////////////////////////
//  ImageLoader.as
//  Macromedia ActionScript Implementation of the Class ImageLoader
//  Created on:      2016-3-21 下午8:10:36
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.tui.utils
{
	import com.alex.rpc.events.AutoLoaderEvent;
	
	import flash.events.EventDispatcher;
	
	/**
	 * 
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2016-3-21 下午8:10:36
	 */
	internal class ImageLoader extends EventDispatcher{
		
		private var _arr_loader:Array;
		private var _arr:Array;
		
		public function ImageLoader(){
			_arr_loader = new Array();
		}
		
		//EventHandler
		private function onLoaded($e:AutoLoaderEvent):void{
			var b:Bitmap = ($e.dataProvider as BitmapMedia).content as Bitmap
			var a:AutoLoader = $e.target as AutoLoader;
			ArrayUtil.removeElementFromeArray(_arr_loader , a);
			var evt:PluginEvent = new PluginEvent(PluginEvent.Success , b);
			this.dispatchEvent(evt);
			load()
		}
		
		private function onFault($e:AutoLoaderEvent):void{
			var a:AutoLoader = $e.target as AutoLoader;
			ArrayUtil.removeElementFromeArray(_arr_loader , a);
			load()
		}
		
		//logic
		private function load():void{
			if(!_arr.length){
				return
			}
			var url:String = _arr.shift();
			var a:AutoLoader = Utils.creatAutoLoader(url , ResourceType.BITMAP , onLoaded , onFault);
			_arr_loader.push(a);
		}
		
		
		//interface
		public function setData($a:Array):void{
			clear();
			_arr = $a
			load()
		}
		
		public function clear():void{
			for each (var a:AutoLoader in _arr_loader){
				Utils.destroyAutoLoader(a , onLoaded , onFault);
			}
			_arr_loader.length = 0;
		}
	}
}