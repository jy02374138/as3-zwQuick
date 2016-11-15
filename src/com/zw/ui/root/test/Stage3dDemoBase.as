///////////////////////////////////////////////////////////
//  Stage3DDemoBase.as
//  Macromedia ActionScript Implementation of the Class Stage3DDemoBase
//  Created on:      2016-11-9 下午5:14:31
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com.zw.ui.root.test
{
	import com.adobe.utils.PerspectiveMatrix3D;
	import com.google.analytics.core.Utils;
	import com.zw.frames.mvc.core.Controller;
	import com.zw.ui.root.Stage3DRoot;
	import com.zw.utils.Utils_UI;
	
	import flash.display.BitmapData;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	import flash.display3D.textures.Texture;
	import flash.geom.Matrix3D;
	
	
	/**
	 * 
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2016-11-9 下午5:14:31
	 */
	public class Stage3dDemoBase extends Stage3DRoot
	{
		/**矩阵*/
		protected var _matrix_projection:PerspectiveMatrix3D;
		protected var _matrix_view:Matrix3D;
		protected var _matrix_model:Matrix3D;
		protected var _matrix_result:Matrix3D;
		
		//基础数据
		protected var _data_vertex:Vector.<Number>;
		protected var _data_index:Vector.<uint>;
		protected var _bmd:BitmapData;
		
		//可提交的数据
		protected var _buffer_index:IndexBuffer3D;
		protected var _buffer_vectex:VertexBuffer3D;
		protected var _texture:Texture;
		
		public function Stage3dDemoBase($isDebug:Boolean=false){
			super($isDebug);
		}
		
		override protected function stage3DInited():void{
			super.stage3DInited();
			onResize(null);
			initData();
			initEngine();
			uploadData();
			setCamera();
			start();
		}
		
		protected function initData():void{
			_data_index = new Vector.<uint>();
			_data_vertex = new Vector.<Number>();
		}
		
		protected function initEngine():void{
			// TODO Auto Generated method stub
		}
		
		protected function uploadData():void{
			if(_bmd){
				_texture = context3D.createTexture(_bmd.width , _bmd.height , Context3DTextureFormat.BGRA , false);
				Utils_UI.mip(_texture , _bmd);			 //
				context3D.setTextureAt(0 , _texture);  //写入 fs0纹理采样寄存器
			}
			
			program3D.upload(_agal_vertex.agalcode , _agal_fragment.agalcode);
			context3D.setProgram(program3D);
		}
		
		protected function setCamera():void{
			_matrix_projection = new PerspectiveMatrix3D();
			_matrix_view = new Matrix3D();
			_matrix_model = new Matrix3D();
			_matrix_result = new Matrix3D();
		}
		
//getter and setter 
		protected function numTriangles():int{
			var n:int = 0;
			if(_data_index){
				n = _data_index.length / 3;
			}
			return n;
		}
	}
}