package com.zw.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class Utils_UI{
		
		public static var MICROSOFT_YAHEI:String = "Arial";
		
/******************************************************Text类************************************************************/
		/**初始化雅黑字体*/
		public static function setYaheiFont() : void{
			var t1:TextField = new TextField();
			t1.defaultTextFormat = new TextFormat("Microsoft YaHei", 12 , 0xffffff);
			t1.text = "雅黑";
			var t2:TextField = new TextField();
			t2.defaultTextFormat = new TextFormat("微软雅黑", 12, 0xffffff);
			t2.text = "雅黑";
			var t3:TextField = new TextField();
			t3.defaultTextFormat = new TextFormat(null, 12, 0xffffff);
			t3.text = "雅黑";
			if (t1.textHeight == t3.textHeight){
				MICROSOFT_YAHEI = "微软雅黑";
			}
			if (t1.textHeight >= t2.textHeight){
				MICROSOFT_YAHEI = "Microsoft YaHei";
			}
		}
		
		
		//单行文本
		public static function creatTextField(c:DisplayObjectContainer , 
											  label:String="" ,
											  x:Number = 0 , y:Number = 0,
											  size:int = 12 , color:uint=0x000000, font:String="" , bold:Boolean=false,
											  width:Number = 0,
											  auto:String=TextFieldAutoSize.LEFT , align:String=TextFormatAlign.LEFT):TextField{
			var t:TextField = new TextField();
			if(width>0){
				t.width = width
			}
			if(!font){
				font = MICROSOFT_YAHEI;
			}
			
			var fomate:TextFormat = new TextFormat(null , size , color)
			fomate.font = font;
			fomate.bold = bold
			fomate.align = align;
			t.defaultTextFormat = fomate;
			
			t.autoSize = auto;
			if(auto==TextFieldAutoSize.NONE){
				t.height = size + 6;
			}
			t.selectable = false;
			t.mouseEnabled = false;
			t.blendMode = BlendMode.LAYER;
			t.text = label;
			t.x = x;
			t.y = y;
			c.addChild(t);
			return t
		}
		
		//多行文本
		public static function creatTextArea(c:DisplayObjectContainer , label:String="" ,
											 x:Number = 0 , y:Number = 0, width:Number=0 , height:Number=0 ,
											 size:int = 12 ,
											 color:uint=0x000000, font:String="" , bold:Boolean=false,
											 auto:String=TextFieldAutoSize.NONE , align:String=TextFormatAlign.LEFT):TextField{
			var t:TextField = new TextField();
			if(width>0){
				t.width = width
			}
			if(height>0){
				t.height = height
			}
			if(!font){
				font = MICROSOFT_YAHEI
			}
			
			var fomate:TextFormat = new TextFormat(null , size , color)
			fomate.font = font;
			fomate.bold = bold
			fomate.align = align;
			t.defaultTextFormat = fomate;
			
			t.autoSize = auto
			t.wordWrap = true;
			t.selectable = false;
			t.mouseEnabled = false;
			t.blendMode = BlendMode.LAYER;
			t.text = label;
			t.x = x;
			t.y = y;
			c.addChild(t);
			return t
		}
		
		//智能设置文字内容
		public static function autoSetText(txt:TextField , text:String):void{
			txt.text = text;
			while(txt.textWidth>txt.width){
				text = text.substr(0 , text.length-1);
				txt.text = text + "...";
				if(txt.text=="..."){
					return
				}
			}
		}
		
		public static function setTextFormat(t:TextField , size:int , color:int , bold:Boolean):TextFormat{
			var tf:TextFormat = new TextFormat(MICROSOFT_YAHEI , size , bold)
			t.defaultTextFormat = tf;
			t.text = t.text;
			return tf
		}
		
		/**
		 * 字符串转HTML格式字符串
		 * @param str
		 * @param color
		 * @param size
		 * @return 
		 */
		public static function str2html(str:String , color:String , size:int=-1):String{
			var value:String = "<font color='" + color + "'"
			if(size!=-1){
				value += " size='" + size + "'";
			}
			value += ">" + str + "</font>"
			return value
		}
		
		/************************************************************布局类*************************************************************/
		
		/**
		 * 初始化Stage
		 * @param $s 
		 */
		public static function initStage($s:Stage):void{
			$s.align = StageAlign.TOP_LEFT;
			$s.scaleMode = StageScaleMode.NO_SCALE;
			$s.tabChildren = false;
			$s.showDefaultContextMenu = false;
		}
		
		
		/**
		 * 设置居中显示 
		 * @param child		要设置的显示对象
		 * @param fiducial 	作为基准的显示对象
		 */
		public static function toCenter(child:DisplayObjectContainer, fiducial:DisplayObject):void{
			child.x = int((fiducial.width - child.width) / 2);
			child.y = int((fiducial.height - child.height) / 2);
		}
		
		/**
		 * 缩放居中
		 * @param child		被处理的显示对象
		 * @param childRect			被处理的显示对象的原始宽高		
		 * @param parentRect		要居中的区域
		 */
		public static function scaleAndCenter(child:DisplayObject , childRect:Rectangle , parentRect:Rectangle):void{
			var scaleX:Number = childRect.width / parentRect.width;
			var scaleY:Number = childRect.height / parentRect.height;
			var scale:Number = Math.min(scaleX , scaleY);
			child.scaleX = child.scaleY = scale;
			parentRect.width -= childRect.width;
			parentRect.width /= 2;
			parentRect.height -= childRect.height;
			parentRect.height /= 2;
			child.x = parentRect.right;
			child.y = parentRect.bottom;
		}
		
		/************************************************************显示列表操作*************************************************************************/
		
		public static function removeChild($c:DisplayObject):void{
			if($c && $c.parent){
				$c.parent.removeChild($c);
			}
		}
		
		public static function removeAll(c:DisplayObjectContainer) : void  {
			while(c.numChildren){
				c.removeChildAt(0);
			}
		}
		
		public static function addChildAtPos(child:DisplayObject , parent:DisplayObjectContainer , xpos:Number=0 , ypos:Number=0):void{
			child.x = xpos;
			child.y = ypos;
			parent.addChild(child)
		}
		
		/**
		 * 将source内一点坐标转换为target内相应点的坐标
		 * @param source		原始显示对象
		 * @param target		目标显示对象
		 * @param xPos		原始X坐标
		 * @param yPos		原始Y坐标
		 * @return 				相对于target的坐标
		 */
		public static function local2Local(source:DisplayObject , target:DisplayObject , xPos:Number=0 , yPos:Number=0):Point{
			var p:Point = new Point(xPos , yPos);
			p = source.localToGlobal(p);
			p = target.globalToLocal(p);
			return p;
		}
		
		/**
		 * 将一个显示对象从一个容器移动到另一容器内，并且保证其相对于舞台坐标位置不变
		 * @param source		要移动的显示对象
		 * @param target		目标父容器
		 */
		public static function cut2There(source:DisplayObject , target:DisplayObjectContainer):void{
			if(!target.stage || !source.stage){
				return;
			}
			var p:Point = source.localToGlobal(new Point());
			p = target.globalToLocal(p);
			source.x = p.x;
			source.y = p.y;
			target.addChild(source);
		}
		
		/**
		 * 目标在父容器内置顶
		 * @param child
		 */
		public static function set2Top(child:DisplayObject):void{
			if(!child.parent){
				return;
			}
			var p:DisplayObjectContainer = child.parent;
			p.setChildIndex(child , p.numChildren-1);
		}
		
		/**
		 * 为目标显示对象添加矩形遮罩
		 * @param child		目标显示对象
		 * @param parent		父容器
		 * @param x	
		 * @param y
		 * @param width
		 * @param height
		 * @return 
		 */
		public static function creatMask(child:DisplayObject , parent:DisplayObjectContainer ,  
										 x:Number = 0 , y:Number = 0 , width:Number = 100 , height:Number=100):Shape{
			var shp:Shape = new Shape()
			var g:Graphics = shp.graphics;
			g.beginFill(0x000000);
			g.drawRect(0 , 0 , width , height);
			g.endFill()
			shp.x = x;
			shp.y = y;
			parent.addChild(shp);
			child.mask = shp;
			return shp
		}
		
		/************************************************************图像处理*************************************************************************/
		public static function drawRect(g:Graphics , x:Number , y:Number , w:Number , h:Number , color:int=0x000000 , alpha:Number=1):void{
			g.clear();
			g.beginFill(color , alpha);
			g.drawRect(x , y , w , h);
			g.endFill();
		} 
		public static function drawLine(g:Graphics, fromeX:int , fromeY:int, toX:int , toY:int , color:int=0x49494a , ness:int=1):void{
			g.lineStyle(ness , color);
			g.moveTo(fromeX , fromeY);
			g.lineTo(toX , toY);
		}
		
		
		/**
		 *	截图 
		 * @param c		显示对象
		 * @param w	宽
		 * @param h		高
		 * @param m	用于截图的矩阵
		 * @return 此显示对象的位图
		 * 
		 */
		public static function displayObject2Bitmap(c:DisplayObject , w:int=0 , h:int=0 , m:Matrix=null):Bitmap{
			w = w==0 ? c.width : w;
			h = h==0 ? c.width : h;
			var bmd:BitmapData = new BitmapData(w , h , true , 0x00000000);
			bmd.draw(c , m)
			return new Bitmap(bmd)
		}
		
		/**
		 * 区域截图 
		 * @param $c	源
		 * @param $r	要截取的区域
		 * @return 
		 */
		public static function darwRect($c:DisplayObject , $r:Rectangle=null):BitmapData{
			if(!$r){
				$r = new Rectangle(0 , 0 , $c.width , $c.height);
			}
			var bmd:BitmapData = new BitmapData($r.width , $r.height);
			var m:Matrix = null;
			if($r.x>0 || $r.y>0){
				m.tx = -$r.x;
				m.ty = -$r.y;
			}
			bmd.draw($c , m);
			return bmd
		}
		
		
		/**
		 * 将彩色图转换为黑白图
		 * */
		public static function grayFilter(source:BitmapData):BitmapData
		{
			var rLum:Number = 0.3086;
			var gLum:Number = 0.6094;
			var bLum:Number = 0.0820;
			
			var s:Bitmap = new Bitmap(source);
			s.filters = [new ColorMatrixFilter([rLum, gLum, bLum, 0, 0, rLum, gLum, bLum, 0, 0, rLum, gLum, bLum, 0, 0, 0, 0, 0, 1, 0])];
			var r:BitmapData = new BitmapData(s.width, s.height, true, 0x00ffffff);
			r.draw(s);
			return r;
		}
		
		public static function initMC($mc:MovieClip):void{
			if(!$mc){
				return
			}
			$mc.tabChildren = $mc.tabEnabled = false;
			
			for (var i:int = 0; i < $mc.numChildren; i++){
				var c:DisplayObject = $mc.getChildAt(i);
				var t:TextField = c as TextField;
				var mc:MovieClip = c as MovieClip;
				if(t){
					t.embedFonts = false;
					if(t.type!=TextFieldType.INPUT){
						t.mouseEnabled = false;
					}
				}
				if(mc){
					initMC(mc)
				}
			}
		}
		
		public static function setTextByWidth($txt:TextField , $text:String , $maxWidth:Number):void{
			if(!$txt){
				return
			}
			$txt.text = $text;
			var b:Boolean = $txt.textWidth>$maxWidth;
			var isShot:Boolean = b;
			while(b){
				$text = $text.slice(0 , $text.length-2);
				$txt.text = $text + "...";
				b = $txt.textWidth>$maxWidth;
			}
		}
		
		public static function setHtmlByWidth($txt:TextField , $text:String , $maxWidth:Number , $head:String , $end:String="</font>"):void{
			if(!$txt){
				return
			}
			$txt.htmlText = label();
			var b:Boolean = $txt.textWidth>$maxWidth;
			var isShot:Boolean = b;
			while(b){
				$text = $text.slice(0 , $text.length-2);
				$txt.text = label(true);
				b = $txt.textWidth>$maxWidth || $text.length==0;
			}
			
			function label($add:Boolean=false):String{
				var s:String = $add ? "..." : "";
				s = 	$head + $text + s + $end;
				return s;
			}
		}
	}
}