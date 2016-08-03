package com.zw
{
	import com.zw.utils.Utils_UI;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.external.ExternalInterface;
	import flash.text.TextField;
	import flash.ui.Keyboard;

	public class ZLog
	{
		public static var isH5:Boolean = false;
		public static var useLog:Boolean = true
		public static var useConsole:Boolean = true
		
		private static var _instance:ZLog;
		private var _showText:Boolean = false
		
		private var _stage:Stage;
		private var _txt:AutoScrollText;
		
		public function ZLog()
		{
			if(_instance){
				throw new Error("单例已存在");
			}
			_instance = this;
		}
		
		public function addLog($o:Object):void{
			if(!useLog){
				return
			}
			var str:String = $o.toString();
			if(isH5){
				var js:String ="alert(" + str  + ");"; 
			}else{
				trace(str);
			}
			if(useConsole){
				ExternalInterface.call("console.log" , str)
			}
			if(showText && _txt){
				_txt.appendText(str);
			}
		}
		
		public function init($s:Stage):void
		{
			if(_stage){
				return
			}
			_stage = $s;
			_txt = new AutoScrollText();
			_txt.alpha = 0.5
			_stage.addEventListener(KeyboardEvent.KEY_DOWN , onKeyBoard);
		}
		
//Event Handler
		private function onKeyBoard(e:KeyboardEvent):void
		{
			if(!e.ctrlKey){
				return
			}
			switch(e.keyCode){
				case Keyboard.F5:
					showText = true;
					break
				case Keyboard.F6:
					showText = false;
					break
			}
		}
		
		
//getter and setter
		public function get showText():Boolean
		{
			return _showText;
		}
		
		public function set showText($value:Boolean):void
		{
			if(!_txt){
				return
			}
			_showText = $value;
			if(_showText){
				Utils_UI.addChildAtPos(_txt , _stage);
			}else{
				Utils_UI.removeChild(_txt);
			}
		}
		
//静态接口
		public static function Init($s:Stage):void{
			instance.init($s);
		}
		
		public static function Add($o:Object):void{
			instance.addLog($o);
		}
		
		public static function isShowText($b:Boolean):void{
			instance.showText = $b
		}
		
		public static function get instance():ZLog{
			if(!_instance){
				_instance = new ZLog();
			}
			return _instance;
		}
	}
}
import flash.display.DisplayObjectContainer;
import flash.display.Stage;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

internal class AutoScrollText extends TextField
{
	private var _stage:Stage
	public function AutoScrollText()
	{
		super();
		this.background = true;
		this.backgroundColor = 0x009cff;
		this.autoSize = TextFieldAutoSize.NONE;
		this.textColor = 0xffffff;
		this.width = 350;
		this.wordWrap = true;
		this.addEventListener(Event.ADDED_TO_STAGE , onAdded);
		this.addEventListener(Event.REMOVED_FROM_STAGE , onRemove);
	}
	
	private function onAdded(e:Event):void{
		this.removeEventListener(Event.ADDED_TO_STAGE , onAdded);
		_stage = stage;
		_stage.addEventListener(Event.RESIZE , onResize);
		_stage.addEventListener(Event.ADDED_TO_STAGE , onAddChild);
		onResize();
	}
	
	private function onRemove(e:Event):void{
		_stage.removeEventListener(Event.RESIZE , onResize);
		_stage.removeEventListener(Event.ADDED_TO_STAGE , onAddChild);
	}
	
	
	private function onAddChild(event:Event):void
	{
		if(stage)
		{
			var c:DisplayObjectContainer = this.parent;
			c.setChildIndex(this , c.numChildren-1);
		}
	}
	
	private function onResize(e:Event=null):void{
		if(stage){
			this.height = stage.stageHeight;
		}
	}
	
	override public function appendText(newText:String):void{
		var h:Number = this.textHeight + 20;
		if(!this.text || h>this.height){
			this.text = newText;
		}else{
			this.text = this.text + "\n" + newText;
		}
	}
}