///////////////////////////////////////////////////////////
//  AAA_trunk.as
//  Macromedia ActionScript Implementation of the Class AAA_trunk
//  Created on:      2015-11-11 上午11:19:21
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.study
{
	import com.zw.ui.UIManager;
	import com.zw.ui.controls.Button;
	import com.zw.ui.root.MyRoot;
	import com.zw.ui.utils.UIUtils;
	import com.zw.utils.Utils_UI;
	
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	import flash.net.sendToURL;
	import flash.text.TextField;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	/**
	 * LocalConnection研究
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * 注：
	 * 1. 通用FlashPlayer与FireFox版Player之间可以通信（含客户端本地swf）
	 * 2. Google内置FlashPlayer与上述两Player之间不能通信
	 * 3. 部分浏览器的小号窗口与非小号窗口之间，小号窗口之间不能通信（搜狗不可以，遨游可以）
	 * 
	 * 
	 * @created  2015-11-11 上午11:19:21
	 */
	[SWF(width="600" , height="600")]
	public class LocalConnectionStudy extends MyRoot{
		
		private static const ConnectionName:String = "connectionName";
		private static const GetLC:String = "getLC";
		private static const SetLC:String = "setLC";
		
		private var _myName:String;
		private var _times:int = 0;
		private var _lc:String = null;
		
		private var _local:LocalConnection;
		
		private var _btn:Button;
		private var _txt:TextField;
		private var _functionId:uint;
		
		public function LocalConnectionStudy()
		{
			super()
		}
		
//init
		override protected function creatChildren():void{
			_txt = UIUtils.creatTextArea(this , "" , 10 , 10 , 260 , 100);
			_txt.border = true;
			_txt.borderColor = 0x009cff;
			_btn = new Button("发消息B")
			Utils_UI.addChildAtPos(_btn , this , 200 , 300)
			
			_local = new LocalConnection()
		}
		
		override protected function initEvent():void{
			super.initEvent()
			_local.addEventListener(StatusEvent.STATUS , onLocal);
		}
		
		override protected function creatComplete():void{
			_local.allowDomain("*");
			_local.allowInsecureDomain("*");
			_local.client = this;
			content()
		}
		
		//第1步，注册到专属消息通道
		private function content():void{
			_times ++;
			var str:String = ConnectionName + _times;
			try{
				_local.connect(str)
			}catch($e:Error){
				content();
			}finally{
				_myName = str;
				sendGet();
				_functionId = setTimeout(onTime	 , 3000);
			}
		}
		
		//第2步，地毯式请求lc
		private function sendGet():void{
			for (var i:int = 1; i < 100; i++){
				if(i==_times){
					continue
				}
				var str:String = ConnectionName + i;
				_local.send(str , GetLC , _myName);
			}
		}
		
		/**没收到任何回应*/
		private function onTime():void{
			if(_lc){
				return
			}
			_functionId = 0;
			_lc = Math.random().toString();
			_txt.text = _lc + "（创始者  " + _times	+"）"
		}
		
		/**收到LC*/
		public function setLC($lc:String):void{
			clearTimeout(_functionId);
			_functionId = 0
			_lc = $lc;
			_txt.text = $lc + "（" + _times	+"）";
		}
		
		//第3步，收到LC请求并响应
		public function getLC($name:String):void{
			if(_lc){
				_local.send($name , SetLC , _lc);
			}
		}
		
//Event
		private function onLocal($e:StatusEvent):void{
			if($e.level=="status"){
				trace($e.level)
			}
		}
	}
}