///////////////////////////////////////////////////////////
//  MinnerStage3DRoot.as
//  Macromedia ActionScript Implementation of the Class MinnerStage3DRoot
//  Created on:      2016-9-8 下午4:54:23
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.ui.root.minner
{
	import com.sociodox.theminer.TheMiner;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import com.zw.ui.root.Stage3DRoot;
	
	/**
	 * 带Minner功能的Stage3DRoot
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2016-9-8 下午4:54:23
	 */
	public class MinnerStage3DRoot extends Stage3DRoot
	{
		private var _miner:TheMiner;
		
		public function MinnerStage3DRoot(){
			super();
		}
		
		override protected function creatChildren():void{
			stage.frameRate  = 60;
			super.creatChildren();
		}
		
		override protected function initEvent():void{
			super.initEvent();
			stage.addEventListener(KeyboardEvent.KEY_DOWN , onKey);
		}
		
		private function onKey($e:KeyboardEvent):void{
			if($e.keyCode!=Keyboard.M){
				return
			}
			if(!_miner){
				_miner = new TheMiner(true);
				stage.addChild(_miner);
				_miner.visible = false
			}
			_miner.visible = !_miner.visible;
		}
	}
}