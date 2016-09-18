///////////////////////////////////////////////////////////
//  Stage3DRoot.as
//  Macromedia ActionScript Implementation of the Class Stage3DRoot
//  Created on:      2016-9-8 下午4:46:33
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.ui.root
{
	import flash.display.Stage3D;
	import flash.display3D.Context3DRenderMode;
	import flash.events.Event;
	
	/**
	 * 简易Stage3DRoot
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2016-9-8 下午4:46:33
	 */
	public class Stage3DRoot extends SimpleRoot
	{
		public var stage3D:Stage3D;
		
		public function Stage3DRoot(){
			super();
		}
		
		override protected function creatChildren():void{
			stage3D = stage.stage3Ds[0];
		}
		
		override protected function initEvent():void{
			super.initEvent();
			stage3D.addEventListener(Event.CONTEXT3D_CREATE, onStageReady);
		}
		
		override protected function creatComplete():void{
			super.creatComplete();
			stage3D.requestContext3D(Context3DRenderMode.AUTO);
		}
		
		private function onStageReady($e:Event):void{
			stage3D.removeEventListener(Event.CONTEXT3D_CREATE, onStageReady);
			stage3DInited();
		}
		
		protected function stage3DInited():void{
			
		}
	}
}