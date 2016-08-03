import com.tgame.common.ui.componets.SecondButton;

import flash.display.DisplayObject;
import flash.display.Stage;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.getClassByAlias;
import flash.utils.getQualifiedClassName;
import flash.utils.setTimeout;

private var isListen_test:Boolean = false
	
private function test():void{
	setTimeout(onAdd_test , 10000);
}

private function onAdd_test(e:Event=null):void{
	this.removeEventListener(Event.ADDED_TO_STAGE , onAdd_test);
	var btn:SecondButton = new SecondButton()
	this.stage.addChild(btn);
	btn.addEventListener(MouseEvent.CLICK , onClick_test);
}

private function onClick_test(e:MouseEvent):void{
	if(isListen_test){
		this.stage.removeEventListener( MouseEvent.CLICK, onClick_stage);
	}
	else{
		this.stage.addEventListener( MouseEvent.CLICK, onClick_stage);
	}
	isListen_test = !isListen_test;
}

private function onClick_stage(e:MouseEvent):void{
	var child:DisplayObject = e.target as  DisplayObject;
	while(child.parent){
		var str:String = getQualifiedClassName(child);
		trace(str)
		child = child.parent
	}
}
