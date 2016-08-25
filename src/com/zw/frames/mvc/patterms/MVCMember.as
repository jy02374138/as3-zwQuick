package com.zw.frames.mvc.patterms
{
	import flash.utils.getQualifiedClassName;
	
	import com.zw.frames.mvc.interfaces.IFacade;
	import com.zw.frames.mvc.interfaces.IMVCMember;
	
	public class MVCMember implements IMVCMember
	{
		private static  var MVCMemberIndex:int=int.MAX_VALUE;
		
		private var _name:String
		protected var _facade:IFacade;
		
		public function MVCMember()
		{
			initializeName()
		}
		
		protected function initializeName():void{
			_name = getName(this);
		} 
		
		public function sendNotification(notificationName:String, body:Object=null, type:String=null):void
		{
			_facade.sendNotification(notificationName, body, type);
		}
			
		public function get facade():IFacade
		{
			return _facade;
		}

		public function set facade(value:IFacade):void
		{
			_facade = value;
		}

		public function get name():String{
			return _name;
		}
		
		public static function getName(o:*):String{
			if(MVCMemberIndex<=0)MVCMemberIndex=int.MAX_VALUE;
			var str:String = getQualifiedClassName(o);
			str += MVCMemberIndex;
			MVCMemberIndex --;
			return str;
		}
	}
}