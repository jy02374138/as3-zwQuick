///////////////////////////////////////////////////////////
//  UIManager.as
//  Macromedia ActionScript Implementation of the Class UIManager
//  Created on:      2015-7-4 下午12:19:15
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.ui
{
	import com.zw.ResLoader;
	import com.zw.event.ZEvent;
	
	/**
	 * UI组件库中枢，负责启动UI控件
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2015-7-4 下午12:19:15
	 */
	public class UIManager
	{
		private static var _instance:UIManager;
		
		public static var isReady:Boolean = false;
		private var _fun:Function;
		
		public function UIManager()
		{
			if(_instance){
				throw new ZEvent(ZEvent.SingletonError);
			}
			_instance = this
		}
		
		public function loadSkin($url:String  , $fun:Function=null):void{
			_fun = $fun;
			new ResLoader($url , onLoad);
		}
		
		private function onLoad():void
		{
			if(_fun!=null){
				isReady = true;
				_fun.apply();
				_fun = null;
			}
		}		
		
//interface
		/**
		 * 启动组件库
		 * 开始加载默认皮肤，加载完成后将调用回调函数
		 * @param $url
		 */
		public static function startUp($url:String="assets/defaultSkin.swf"  , $fun:Function=null):void{
			if(isReady){
				if($fun!=null){
					$fun.apply();
				}
				return
			}
			if(!$url){
				$url = "assets/defaultSkin.swf";
			}
			instance.loadSkin($url , $fun);
		}
		
//getter and setter
		public static function get instance():UIManager{
			if(!_instance){
				_instance = new UIManager();
			}
			return _instance;
		}
	}
}