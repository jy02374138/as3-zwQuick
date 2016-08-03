///////////////////////////////////////////////////////////
//  Component.as
//  Macromedia ActionScript Implementation of the Class component
//  Created on:      2015-7-6 下午9:01:30
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * 组件基础类
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2015-7-6 下午9:01:30
	 * 
	 * 使用此类的子类请注意：在添加到舞台后如未设置皮肤，将为该组件添加默认皮肤
	 */
	public class Component extends Sprite implements ISkin
	{
		protected var _skin:* = null;
		
		public function Component()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE , onAdded);
		}
		
		protected function onAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE , onAdded);
			if(!_skin){
				creatDefaultSkin();
			}
		}
		
		protected function creatDefaultSkin():void
		{
			
		}
		
		public function set skin($value:*):void
		{
			_skin = $value;
		}
		
		public function get skin():*
		{
			return null;
		}
	}
}