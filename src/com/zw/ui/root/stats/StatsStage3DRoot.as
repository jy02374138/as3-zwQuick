///////////////////////////////////////////////////////////
//  StatsStage3DRoot.as
//  Macromedia ActionScript Implementation of the Class StatsStage3DRoot
//  Created on:      2016-9-13 下午5:02:25
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.ui.root.stats
{
	import com.zw.ui.root.Stage3DRoot;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import net.hires.debug.Stats;
	
	
	/**
	 * 带Stats功能的Stage3DRoot
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2016-9-13 下午5:02:25
	 */
	public class StatsStage3DRoot extends Stage3DRoot{
		
		private var _showStats:Boolean = true;
		
		protected var _stats:Stats;
		
		public function StatsStage3DRoot(){
			super();
		}
		
		override protected function creatComplete():void{
			super.creatComplete();
			showStats = _showStats;
		}
		
		override protected function initEvent():void{
			super.initEvent();
			stage.addEventListener(KeyboardEvent.KEY_DOWN , onKey);
		}
		
//event handler	
		private function onKey($e:KeyboardEvent):void{
			if($e.keyCode!=Keyboard.S){
				return
			}
			showStats = !showStats;
		}
		
//getter and setter
		public function get showStats():Boolean{
			return _showStats;
		}
		
		public function set showStats($val:Boolean):void{
			_showStats = $val;
			if(_showStats){
				if(!_stats && stage){
					_stats = new Stats();
				}
				stage.addChild(_stats);
			}
			_stats.visible = _showStats;
		}
	}
}