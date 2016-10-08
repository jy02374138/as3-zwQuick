///////////////////////////////////////////////////////////
//  Stage3DRoot.as
//  Macromedia ActionScript Implementation of the Class Stage3DRoot
//  Created on:      2016-9-8 下午4:46:33
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.ui.root
{
	import com.adobe.utils.AGALMiniAssembler;
	
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DRenderMode;
	import flash.events.Event;
	import flash.display3D.Program3D;
	
	/**
	 * 简易Stage3DRoot
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2016-9-8 下午4:46:33
	 */
	public class Stage3DRoot extends SimpleRoot{
		
		public var stage3D:Stage3D;
		public var context3D:Context3D;
		public var program3D:Program3D;
		public var agal:AGALMiniAssembler;
		
		/**是否为debug版本*/
		protected var _isDebug:Boolean;
		
		
		public function Stage3DRoot($isDebug:Boolean=false){
			_isDebug = $isDebug
			super();
		}
		
		override protected function creatChildren():void{
			stage3D = stage.stage3Ds[0];
			context3D = stage3D.context3D;
			program3D = context3D.createProgram();
			agal = new AGALMiniAssembler();
			
			context3D.enableErrorChecking = _isDebug;
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