package com.zw
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	public class ResLoader extends Loader
	{
		private var _onComplete:Function;
		private var _onCancel:Function;
		
		public function ResLoader($url:String , $onComplete:Function=null , $onCancel:Function=null)
		{
			super();
			var c:LoaderContext = new LoaderContext(false , ApplicationDomain.currentDomain);
			var q:URLRequest = new URLRequest($url);
			_onComplete = $onComplete;
			_onCancel = $onCancel;
			
			contentLoaderInfo.addEventListener(Event.COMPLETE , onLoad);
			contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR , onError);
			contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR , onError);
			load(q , c);
		}
		
		protected function onError(e:Event):void
		{
			if(_onCancel!=null){
				_onCancel();
			}
			end();
		}
		
		protected function onLoad(event:Event):void
		{
			if(_onComplete!=null){
				_onComplete();
			}
			end();
		}
		
		private function end():void
		{
			contentLoaderInfo.removeEventListener(Event.COMPLETE , onLoad);
			contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR , onError);
			contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR , onError);
			_onComplete = null;
			_onCancel = null;
		}
	}
}