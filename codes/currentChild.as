// ActionScript file

private var _currentChild:DisplayObject = null;

public function get currentChild():DisplayObject{
	return _currentChild;
}

public function set currentChild(value:DisplayObject):void{
	if(value==_currentChild){
		return
	}
	if(_currentChild){
		this.removeChild(_currentChild);
	}
	_currentChild = value;
	if(_currentChild){
		this.addChild(_currentChild);
	}
}
