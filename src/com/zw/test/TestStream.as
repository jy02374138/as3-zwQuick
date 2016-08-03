///////////////////////////////////////////////////////////
//  TestStream.as
//  Macromedia ActionScript Implementation of the Class TestStream
//  Created on:      2015-11-30 下午3:38:34
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.test
{
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	
	/**
	 * 测试用Stream
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2015-11-30 下午3:38:34
	 */
	public class TestStream extends NetStream
	{
		public function TestStream($url:String)
		{
			var nc:NetConnection = new NetConnection();
			nc.connect(null);
			super(nc);
			client = new CustomClient();
			play($url);
		}
	}
}


internal class CustomClient {
	public function onMetaData(info:Object):void {
		trace("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
	}
	public function onCuePoint(info:Object):void {
		trace("cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
	}
	
	public function onXMPData(info:Object):void{
		
	}
	
	public function onImageData(info:Object):void{
		
	}
	
	public function onPlayStatus(info:Object):void{
		
	}
	public function onSeekPoint(info:Object):void{
		
	}
	public function onTextData(info:Object):void{
		
	}
}