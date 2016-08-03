///////////////////////////////////////////////////////////
//  Image_web.as
//  Macromedia ActionScript Implementation of the Class Image_web
//  Created on:      2015-7-17 下午8:44:29
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.ui.picture
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	
	/**
	 * 网络图片
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2015-7-17 下午8:44:29
	 */
	public class Image_web extends Loader
	{
		public static const Auto:int = 0;
		private static const Fix:int = 1;
		
		
		public var noCookie:Boolean = false;
		public var loading:Boolean = false;
		public var imageWidth:Number = -1;
		public var imageHeight:Number = -1;
		
		private var _url:String = "";
		
		
		private var _sizeType:int = Auto;
		
		public function Image_web($url:String , $width:Number=-1 , $height:Number=-1){
			super();
			this.mouseEnabled = false;
			if($width>0 && $height>0){
				imageWidth = $width;
				imageHeight = $height;
				sizeType = Fix;
			}
			var c:LoaderInfo = this.contentLoaderInfo;
			c.addEventListener(Event.COMPLETE , onComplete);
			c.addEventListener(IOErrorEvent.IO_ERROR , onError);
		}
		
//Logic
		private function loadImage():void{
			if(loading){
				this.close();
			}
			if(this.content){
				this.unload();
			}
			if(!_url){
				return
			}
			var str:String = _url;
			if(noCookie){
				var index:int = str.indexOf("?");
				str += index==-1 ? "?" : "&";
				str += "MathRandom=" + Math.random().toString();
			}
			var q:URLRequest = new URLRequest(str);
			var c:LoaderContext = new LoaderContext(true);
			this.load(q , c);
		}
		
		private function refuseSize():void{
			var i:int = _sizeType;
			if(_sizeType==Fix && (imageWidth<0 || imageHeight<0)){
				i = Auto;
			}
			
			switch(i){
				case Auto:
					this.scaleX = this.scaleY = 1;					
					break
				case Fix:
					this.scaleX = this.scaleY = 1;
					this.width = imageWidth;
					this.height = imageHeight;
					break
			}
		}
		
		
//Event Handler
		private function onError(e:IOErrorEvent):void{
			trace("读取图片失败：" + url)
			var evt:Event = new Event(Event.CANCEL);
			this.dispatchEvent(evt);
		}
		
		private function onComplete(e:Event):void{
			this.dispatchEvent(e);
			refuseSize();
		}
		
		
//interface
		public function setSize($width:Number , $height:Number):void{
			imageWidth = $width;
			imageHeight = $height;
			if(sizeType==Fix){
				refuseSize();
			}
		}
		
//getter and setter
		public function get url():String{
			return _url;
		}

		public function set url(value:String):void{
			if(value==url && loading){
				return
			}
			_url = value;
			loadImage();
		}

		public function get sizeType():int
		{
			return _sizeType;
		}

		public function set sizeType(value:int):void{
			if(_sizeType == value){
				return
			}
			_sizeType = value;
			refuseSize()
		}
	}
}