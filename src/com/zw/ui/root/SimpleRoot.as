///////////////////////////////////////////////////////////
//  SimpleRoot.as
//  Macromedia ActionScript Implementation of the Class SimpleRoot
//  Created on:      2016-6-21 下午3:47:37
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.ui.root
{
	import com.zw.utils.Utils;
	import com.zw.utils.Utils_UI;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	
	
	/**
	 * 轻量级便捷型程序根容器
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2016-6-21 下午3:47:37
	 */
	public class SimpleRoot extends Sprite
	{
		public function SimpleRoot(){
			super();
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
				onFrame();
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
			Utils_UI.setYaheiFont();
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