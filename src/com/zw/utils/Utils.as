package com.zw.utils
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.external.ExternalInterface;
	import flash.net.LocalConnection;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.Capabilities;
	import flash.system.System;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;

	public class Utils
	{
/********************************************************字符串****************************************************************************/
		/**判断是否为纯数字*/
		public static function isInteger(str:String):Boolean{
			var reg:RegExp = /^-?[0-9]\d*$/;
			return reg.test(str);
		}
		
		/**将字符串中的<和"转义*/
		public static function getXMLText($msg:String):String {
			var ss:String = $msg.replace(/</g, "&lt;").replace(/\"/g, "&quot;");
			return ss;
		}
		
		/**获取某一字符串的单字节总长度*/
		public static function getSBCSLength($str:String):int
		{
			return $str.replace(/[^\x00-\xFF]/g, "aa").length;
		}
		
		/**拼html字符串*/
		public static function str2html(str:String , color:String , size:int=-1):String{
			var value:String = "<font color='" + color + "'"
			if(size!=-1){
				value += " size='" + size + "'";
			}
			value += ">" + str + "</font>"
			return value
		}
		
/********************************************************操作数组****************************************************************************/
		public static function deletInArray(a:Array , o:*):void{
			if(!a || a.length==0){
				return
			}
			var index:int = a.indexOf(o);
			a.splice(index , 1);
		}
		
		public static function deleteElementsInArry(soure:Array , deleteTargets:Array):Array{
			if(!soure){
				return null;
			}
			soure = soure.slice();
			for(var i:int=0;i<deleteTargets.length;i++){
				var index:int = soure.indexOf(deleteTargets[i]);
				if(index>-1){
					soure.splice(index , 1);
				}
			}
			return soure;
		}
		
		public static function removeNullFromArray(arr:Array):Array{
			if(!arr){
				return null
			}
			for(var i:int=0;i<arr.length;i++){
				if(arr[i]==null){
					arr.splice(i);
					i--
				}
			}
			return arr
		}
		
/********************************************************时间日期****************************************************************************/
		public static function getDateString():String{
			var d:Date = new Date();
			var date:String = d.getFullYear() + "-" + (d.getMonth()+1) + "-" +d.getDate() + " " + 
				d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();
			return date;
		}
		
		public static function getTimeStr():String{
			var timeStr:String;
			var d:Date = new Date();
			var h:String = (d.hours>9 ? "" : "0") + d.hours;
			var m:String = (d.minutes>9 ? "" : "0") + d.minutes;
			var s:String = (d.seconds>9 ? "" : "0") + d.seconds;
			var ms:String = d.milliseconds<10 ? "0" : "";
			ms += (d.milliseconds<100 ? "0" : "");
			ms += d.milliseconds;
			timeStr = h + ":" + m + ":" + s + ":" + ms;
			return timeStr;
		}
		
		public static function sec2timeStr(numSeconds:int , join:String=":"):String{
			var hour:int = int(numSeconds /3600);
			var minute:int = int((numSeconds % 3600) /60);
			var seconds:int = numSeconds % 60;
			var s:String = timeFormat(hour) + join + timeFormat(minute) + join + timeFormat(seconds);
			return s;
			
			function timeFormat(number:uint):String{
				return  String((number<10) ? String("0"+number) : String(number));
			}
		}
		
/*************************************************************XML********************************************************************/
		/**
		 * 去除XML字符串中的NameSpace
		 * @param $str
		 * @return 
		 */
		public static function removeXMLNameSpace($str:String):String{
			var a:Array = findXMLNameSpace($str);
			//去除空间声明
			var r:RegExp = /xmlns[^"]+"[^"]+"/g;
			$str = $str.replace(r , "");
			
			//去除空间名使用
			for (var i:int = 0; i < a.length; i++){
				var s:String = a[i] + ":"
				r = new RegExp(s , "g");
				$str = $str.replace(r , "");
			}
			return $str;
		}
		
		/**
		 * 查询XML字符串中的命名空间列表
		 * @param $str
		 * @return <b>Array</b> NameSpace列表
		 */
		public static function findXMLNameSpace($str:String):Array{
			var arr:Array = new Array();
			var r:RegExp = /xmlns[^"]+"[^"]+"/g;
			var a:Array = $str.match(r);
			r = /xmlns:[^=]+=/g;
			for each (var s:String in a){
				var a1:Array = s.match(r);
				if(a1 && a1.length){
					s = a1[0];
					s = s.replace("xmlns:" ,"")
					s = s.replace("=","");
					arr.push(s);
				}
			}
			return arr;
		}
		
		/**
		 * 将XML转为Object
		 * @param xml
		 * @return Object
		 */
		public static function xml2Object(xml:XML):Object{
			var obj:Object = new Object();
			var ls:XMLList = xml.children();
			var atts:XMLList = xml.attributes();
			
			for each (var att:XML  in atts){
				obj[att.name().toString()]= att.toString();
			}
			
			if(ls.length() > 0){
				for each(var node:XML in ls){
					var objsub:Object = xml2Object(node);
					var tmp:Object = obj[node.name()];
					if(tmp==null){
						obj[node.name()]=objsub;
					}else if(tmp is Array){
						(tmp as Array).push(objsub);
					}
					else{
						obj[node.name()]=new Array(tmp,objsub);
					}
				}
			}
			return obj;
		}
		
		
		
/********************************************************调试************************************************************************/
		public static function Object2String(obj:Object):String
		{
			var str:String = "";
			for (var i:*in obj)
			{
				str += i + ": " + obj[i] + "\n";
				if (obj[i] is Object)
				{
					str += Object2String(obj[i]);
				}
			}
			return str;
		}
		
/*************************************************************浏览器******************************************************************/
		/**
		 * 跳转或者新开一个浏览器窗口，用于替换flex的BrowserManager 
		 * note:采用flex自带的navigateToURL时， 弹出窗口经常会被某些浏览器安全屏蔽，因此改成用js调用。
		 * 
		 * @param url		目标url
		 * @param window    打开目标url的方式，_blank为打开新窗口
		 * @param features  ???
		 */
		public static function JJNavigateToURL(url:String, window:String="_blank", features:String=""):void
		{
			var BROWSER_OPEN_WINDOW:String = "window.open";
			
			var myURL:URLRequest = new URLRequest(url);                       
			var browserName:String = getBrowserName();
			
			if(getBrowserName() == "Firefox")
			{
				ExternalInterface.call(BROWSER_OPEN_WINDOW, url, window, features);
			}
				//If IE,
			else if(browserName == "IE")
			{
				ExternalInterface.call(BROWSER_OPEN_WINDOW, url, window, features);
			}
				//If Safari
			else if(browserName == "Safari")
			{                          
				navigateToURL(myURL, window);
			}
				//If Opera
			else if(browserName == "Opera")
			{       
				navigateToURL(myURL, window);
			} 
			else 
			{
				navigateToURL(myURL, window);
			}
		}
		
		/**
		 * 获取浏览器的名称 
		 * @return 
		 */
		public static function getBrowserName():String
		{
			var browser:String;
			
			//Uses external interface to reach out to browser and grab browser useragent info.
			var browserAgent:String = ExternalInterface.call("function getBrowser(){return navigator.userAgent;}");
			
			//Determines brand of browser using a find index. If not found indexOf returns (-1).
			if(browserAgent != null && browserAgent.indexOf("Firefox") >= 0) {
				browser = "Firefox";
			}
			else if(browserAgent != null && browserAgent.indexOf("Safari") >= 0){
				browser = "Safari";
			}                         
			else if(browserAgent != null && browserAgent.indexOf("MSIE") >= 0){
				browser = "IE";
			}                 
			else if(browserAgent != null && browserAgent.indexOf("Opera") >= 0){
				browser = "Opera";
			}
			else {
				browser = "Undefined";
			}
			return browser;
		}
		
		
		/**
		 * 获取URL参数
		 * 比如：test.html?name=wlh&address=beijing
		 * 调用这个参数后可以获得一个object，object.name=wlh; object.address=beijing
		 * 
		 * note:在使用BrowserManager获取URL的时候，会在原来的URL上加"#"号，非常难看
		 * 
		 * @return URL参数的NameValuePair
		 */
		public static function getURLParams():Object 
		{  
			var params:Object = {};  
			var query:String = ExternalInterface.call("window.location.search.substring", 1);  
			if(query) 
			{  
				var pairs:Array = query.split("&");  
				for(var i:uint=0; i < pairs.length; i++)
				{  
					var pos:int = pairs[i].indexOf("=");  
					
					if(pos != -1) 
					{  
						var argname:String = pairs[i].substring(0, pos);  
						var value:String = pairs[i].substring(pos+1);  
						
						params[argname] = value;  
					}  
				}  
			}  
			return params;  
		}
		
/********************************************************其他********************************************************/
		public static function clone(obj:Object):* {
			if(obj == null) {
				return obj;
			}
			var copier:ByteArray = new ByteArray();
			copier.writeObject(obj);
			copier.position = 0;
			return copier.readObject();
		}
		
		public static function gc() : void  {
			try {
				System.gc()
			} catch ( e : * ) {}
		}
		
		public static function class2Object($className:String):Object{
			if(!$className){
				return null
			}
			var c:Class = getDefinitionByName($className) as Class;
			if(!c){
				return null
			}
			
			var d:Object = new c();
			return d;
		}
		
		/**
		 * remove事件侦听 
		 * @param $e			事件Event实例
		 * @param $fun		事件侦听函数
		 */
		public static function remoeEvent($e:Event , $fun:Function):void{
			if(!$e || $fun==null){
				return
			}
			var d:IEventDispatcher = $e.currentTarget as IEventDispatcher;
			d.removeEventListener($e.type , $fun);
		}
		
		
		/**
		 * 检查StageVideo是否可用
		 * @return 
		 */
		public static function checkVersionForStageVideo() : Boolean{
			var a:Array = Capabilities.version.split(" ");
			var s:String = a[0];
			if (s == null || s != "WIN" && s != "MAC" && s != "LNX"){
				return false;
			}
			var v:String = a[1];
			if (compareVersion("10,3,181,14", v) < 0){
				return false;
			}
			return true;
		}
		
		/**
		 * 比较两个版本的先后
		 * @param $v0
		 * @param $v1
		 * @return
		 * 			-1		 v0是新版本
		 * 			1		 v1是新版本
		 * 			0		两者相同
		 */
		public static function compareVersion($v0:String, $v1:String):int{
			var a0:Array = $v0.split(",");
			var a1:Array = $v0.split(",");
			var n:int = Math.min(a0.length, a1.length);
			var result:int = 0;
			for (var i:int = 0; i < n; i++){
				var n0:int = parseInt(a0[i]);
				var n1:int = parseInt(a1[i]);
				if (n0 > n1){
					result = -1;
					break;
				}
				else if (n0 < n1){
					result = 1;
					break;
				}
			}
			if(result==0){
				if (a0.length > a1.length){
					result = -1;
				}
				else if (a0.length < a1.length){
					result= 1;
				}
			}
			return result;
		}
	}
}