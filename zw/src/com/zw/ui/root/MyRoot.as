///////////////////////////////////////////////////////////
//  MyRoot.as
//  Macromedia ActionScript Implementation of the Class MyRoot
//  Created on:      2015-11-25 下午4:10:45
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.ui.root
{
	import com.zw.ui.UIManager;
	import com.zw.utils.Utils;
	import com.zw.utils.Utils_UI;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	
	
	/**
	 * 顶部类
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2015-11-25 下午4:10:45
	 */
	public class MyRoot extends Sprite
	{
		protected var _url_skin:String = "assets/defaultSkin.swf"
		
		
		public function MyRoot()
		{
			super();
			UIManager.startUp(_url_skin , onSkinInit)
		}
		
		private function onSkinInit():void{
			if(stage){
				onAdd();
			}else{
				this.addEventListener(Event.ADDED_TO_STAGE , onAdd);
			}
		}
		
		protected function onAdd($e:Event=null):void{
			Utils.remoeEvent($e , onAdd);
			Utils_UI.initStage(stage);
			if(!stage.stageWidth || !stage.stageHeight){
				onFrame()
				return
			}else{
				this.addEventListener(Event.ENTER_FRAME , onFrame);
			}
		}
		
		private function onFrame($e:Event=null):void{
			if(!stage.stageWidth || !stage.stageHeight){
				return
			}
			Utils.remoeEvent($e , onFrame);
			creatChildren();
			initEvent();
			creatComplete();
		}
		
		protected function creatChildren():void{
			
		}
		
		protected function initEvent():void{
			stage.addEventListener(FullScreenEvent.FULL_SCREEN , onResize)
			stage.addEventListener(Event.RESIZE , onResize);
		}
		
		protected function creatComplete():void{
			
		}
		
		protected function onResize($e:Event):void{}
	}
}