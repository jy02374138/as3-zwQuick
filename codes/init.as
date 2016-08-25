///////////////////////////////////////////////////////////
//  init.as
//  ActionScript file
//  Created on:      2015-7-6 下午8:55:51
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

if(stage){
	onAdd();
}else{
	this.addEventListener(Event.ADDED_TO_STAGE , onAdd);
}

	private function onAdd(e:Event=null):void{
		if(e){
			this.removeEventListener(Event.ADDED_TO_STAGE , onAdd);
		}
		Utils_UI.initStage(stage);
	}
}