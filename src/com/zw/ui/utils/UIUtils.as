///////////////////////////////////////////////////////////
//  UIUtils.as
//  Macromedia ActionScript Implementation of the Class UIUtils
//  Created on:      2015-7-3 下午6:15:30
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.ui.utils
{
	import com.zw.utils.Utils;
	import com.zw.utils.Utils_UI;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.SimpleButton;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * UI控件简单常用静态方法
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2015-7-3 下午6:15:30
	 */
	public class UIUtils
	{
		/**添加单行文本*/
		public static function creatTextField(c:DisplayObjectContainer , 
											  label:String="" ,
											  x:Number = 0 , y:Number = 0,
											  size:int = 12 , color:uint=0x000000, font:String="" , bold:Boolean=false,
											  width:Number = 0,
											  auto:String=TextFieldAutoSize.LEFT , align:String=TextFormatAlign.LEFT):TextField{
			var t:TextField = new TextField();
			if(width>0){
				t.width = width
			}
			font = font ? font : "YH";
			
			var fomate:TextFormat = new TextFormat(null , size , color)
			fomate.font = font;
			fomate.bold = bold
			fomate.align = align;
			t.defaultTextFormat = fomate;
			
			t.autoSize = auto;
			if(auto==TextFieldAutoSize.NONE){
				t.height = size + 6;
			}
			t.selectable = false;
			t.mouseEnabled = false;
			t.blendMode = BlendMode.LAYER;
			t.text = label;
			t.x = x;
			t.y = y;
			c.addChild(t);
			return t
		}
		
		/**添加多行文本*/
		public static function creatTextArea(c:DisplayObjectContainer , label:String="" ,
											 x:Number = 0 , y:Number = 0, width:Number=0 , height:Number=0 ,
											 size:int = 12 ,
											 color:uint=0x000000, font:String="微软雅黑" , bold:Boolean=false,
											 auto:String=TextFieldAutoSize.NONE , align:String=TextFormatAlign.LEFT):TextField{
			var t:TextField = new TextField();
			if(width>0){
				t.width = width;
			}
			if(height>0){
				t.height = height;
			}
			
			var fomate:TextFormat = new TextFormat(null , size , color)
			fomate.font = font;
			fomate.bold = bold
			fomate.align = align;
			t.defaultTextFormat = fomate;
			
			t.autoSize = auto
			t.wordWrap = true;
			t.selectable = false;
			t.mouseEnabled = false;
			t.blendMode = BlendMode.LAYER;
			t.text = label;
			t.x = x;
			t.y = y;
			c.addChild(t);
			return t
		}
		
		
		/**
		 * 
		 * @param $c
		 * @param $up			弹起状态的皮肤，可以是displayObject，BitmapData，类名
		 * @param $xpos
		 * @param $ypos
		 * @param $over		鼠标经过状态皮肤，弹起状态的皮肤，可以是displayObject，BitmapData，类名（如果缺省将用up代替）
		 * @param $down	鼠标按下状态皮肤，弹起状态的皮肤，可以是displayObject，BitmapData，类名（如果缺省将用down代替）
		 * @return 
		 * 
		 */
		public static function creatSimplButton($c:DisplayObjectContainer , $up:* , $xpos:Number=0 , $ypos:Number=0 , $over:*=null , $down:*=null):SimpleButton{
			if(!$c){
				return null
			}
			var up:DisplayObject = skin2DisplayObject($up);
			if(!up){
				return null
			}
			var over:DisplayObject = $over ? skin2DisplayObject($over) : up;
			over = over ? over : up;
			var down:DisplayObject = $down ? skin2DisplayObject($down) : over;
			down = down ? down : over;
			
			var b:SimpleButton = new SimpleButton(up , over , down , up);
			Utils_UI.addChildAtPos(b , $c , $xpos , $ypos);
			return b;
		}
		
		/**
		 * 将系统可以接收的skin转为DisplayObjcet
		 * @param $skin
		 * @return 
		 * 
		 */
		public static function skin2DisplayObject($skin:*):DisplayObject{
			if(!$skin){
				return null;
			}
			if($skin is String){
				$skin = Utils.class2Object($skin);
			}
			
			if($skin is BitmapData){
				$skin = new Bitmap($skin as BitmapData);
			}
			var c:DisplayObject = $skin as DisplayObject;
			return c;
		}
	}
}