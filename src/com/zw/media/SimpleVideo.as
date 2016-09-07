///////////////////////////////////////////////////////////
//  SimpleVideo.as
//  Macromedia ActionScript Implementation of the Class SimpleVideo
//  Created on:      2016-9-2 上午11:38:38
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.media
{
	import com.zw.event.ZEvent;
	
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	
	/**
	 * 简易Video,用于播放flv等文件
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2016-9-2 上午11:38:38
	 */
	public class SimpleVideo extends Video{
		
		private var _url:String = "";
		
		private var _connection:NetConnection;
		private var _stream:NetStream;
		private var _client:CustomClient;
		private var _inited:Boolean = false;
		
		public function SimpleVideo(width:int=320, height:int=240){
			super(width, height);
			
			_client = new CustomClient();
			_connection = new NetConnection();
			_client.addEventListener(ZEvent.Init , onClient);
			_connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			_connection.connect(null);
		}
		
		
//event handler
		private function onClient($e:ZEvent):void{
			var o:Object = $e.data;
			this.width = o.width;
			this.height = o.height;
		}
	
//logic
		//链接过程
		private function netStatusHandler(event:NetStatusEvent):void {
			switch (event.info.code) {
				case "NetConnection.Connect.Success":
					connectStream();
					break;
				case "NetStream.Play.StreamNotFound":
					trace("Stream not found: " + url);
					break;
			}
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
		
		private function connectStream():void {
			_stream = new NetStream(_connection);
			_stream.client = _client;
			
			_stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			attachNetStream(_stream);
			_inited = true;
			if(_url){
				url = _url;
			}
		}

		
//getter and setter
		public function get url():String{
			return _url;
		}

		public function set url($value:String):void{
			_url = $value;
			if(_inited){
				_stream.play(_url);
			}
		}
	}
}

import com.zw.event.ZEvent;

import flash.events.EventDispatcher;
import flash.geom.Rectangle;

internal class CustomClient extends EventDispatcher{
	public function onMetaData(info:Object):void {
		trace("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
		var r:Rectangle = new Rectangle(0 , 0 , info.width , info.height)
		var evt:ZEvent = new ZEvent(ZEvent.Init , r);
		this.dispatchEvent(evt);
	}
	public function onCuePoint(info:Object):void {
		trace("cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
	}
	
	public function onPlayStatus(...args):void{
		trace(args.length)
	}
}