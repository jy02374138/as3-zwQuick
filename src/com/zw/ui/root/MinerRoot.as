///////////////////////////////////////////////////////////
//  MinerRoot.as
//  Macromedia ActionScript Implementation of the Class MinerRoot
//  Created on:      2016-8-30 上午11:19:37
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.ui.root
{
	import com.sociodox.theminer.TheMiner;
	import com.sociodox.theminer.TheMinerActionEnum;
	import com.zw.utils.Utils_UI;
	
	import flash.events.KeyboardEvent;
	import flash.ui.KeyLocation;
	import flash.ui.Keyboard;
	import flash.ui.KeyboardType;
	
	/**
	 * 性能测试舞台Root
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2016-8-30 上午11:19:37
	 */
	public class MinerRoot extends MyRoot
	{
		private var _miner:TheMiner;
		
		public function MinerRoot(){
			super();
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