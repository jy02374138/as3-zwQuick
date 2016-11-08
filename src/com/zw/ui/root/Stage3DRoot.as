///////////////////////////////////////////////////////////
//  Stage3DRoot.as
//  Macromedia ActionScript Implementation of the Class Stage3DRoot
//  Created on:      2016-9-8 下午4:46:33
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.ui.root
{
	import com.adobe.utils.AGALMiniAssembler;
	import com.zw.utils.Utils;
	import com.zw.utils.Utils_UI;
	
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DRenderMode;
	import flash.display3D.Program3D;
	import flash.events.Event;
	
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
		
		protected var _agal_vertex:AGALMiniAssembler;
		protected var _agal_fragment:AGALMiniAssembler;
		
		/**是否为debug版本*/
		protected var _isDebug:Boolean;
		
		
		public function Stage3DRoot($isDebug:Boolean=false){
			_isDebug = $isDebug
			super();
		}
		
//init
		override protected function creatComplete():void{
			super.creatComplete();
			_agal_vertex = new AGALMiniAssembler();
			_agal_fragment = new AGALMiniAssembler();
			stage3D = stage.stage3Ds[0];
			stage3D.addEventListener(Event.CONTEXT3D_CREATE, onStageReady);
			stage3D.requestContext3D();
		}
		
		private function onStageReady($e:Event):void{
			stage3D.removeEventListener(Event.CONTEXT3D_CREATE, onStageReady);
			context3D = stage3D.context3D;
			program3D = context3D.createProgram();
			context3D.enableErrorChecking = _isDebug;
			stage3DInited();
		}
		
		protected function stage3DInited():void{
			
		}
		
		public function start():void{
			this.addEventListener(Event.ENTER_FRAME , onFrame);
		}
		
		public function stop():void{
			this.removeEventListener(Event.ENTER_FRAME , onFrame);
		}
		
//event handler
		protected function onFrame($e:Event):void{}
		
		override protected function onResize($e:Event):void{
			super.onResize($e);
			if(context3D){
				context3D.configureBackBuffer(stage.stageWidth , stage.stageHeight , 0 , true);
			}
		}
	}
}