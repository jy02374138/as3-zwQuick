///////////////////////////////////////////////////////////
//  UIBase.as
//  Macromedia ActionScript Implementation of the Class UIBase
//  Created on:      2016-3-9 上午10:06:31
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.tui
{
	import flash.display.Sprite;
	
	
	/**
	 * 常用组件基础类
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2016-3-9 上午10:06:31
	 */
	public class UIBase extends Sprite
	{
		public function UIBase()
		{
			super();
			creatChildren();
			initEvent();
			creatComplete();
		}
		
		protected function creatChildren():void{
			
		}
		
		protected function initEvent():void{
		}
		
		protected function creatComplete():void{
			
		}
	}
}