///////////////////////////////////////////////////////////
//  mouseoverAndOut.as
//  ActionScript file
//  Created on:      2016-3-21 下午8:13:07
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

private function onOver($e:MouseEvent):void{
	if(_isOver){
		return
	}
	if(_spr.height<=_shp.height){
		return
	}
	onTime();
	_isOver = true;
	_scroll.visible = true;
}	

private function onOut($e:MouseEvent):void{
	if(!_isOver){
		return
	}
	var r:Rectangle = new Rectangle(0 , 0 , _width , _height);
	_isOver = r.contains(mouseX , mouseY);
	_scroll.visible = _isOver;
}