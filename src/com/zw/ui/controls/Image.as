///////////////////////////////////////////////////////////
//  Image.as
//  Macromedia ActionScript Implementation of the Class Image
//  Created on:      2015-7-7 上午10:37:19
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.ui.controls
{
	import com.zw.ui.Component;
	import com.zw.ui.utils.UIUtils;
	
	import flash.display.DisplayObject;
	
	
	/**
	 * 图片
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2015-7-7 上午10:37:19
	 */
	public class Image extends Component
	{
		public function Image($skin:*=null)
		{
			super();
			this.mouseChildren = false;
			this.mouseEnabled = false;
			skin = $skin;
		}
		
		override public function set skin($value:*):void{
			super.skin = $value;
			var c:DisplayObject = UIUtils.skin2DisplayObject($value);
			if(c){
				this.addChild(c);
			}
		}
	}
}