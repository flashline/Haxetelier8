/**
 * Copyright (c) jm Delettre.
 */

package custom ;
import babylonx.mesh.Mesh;
import babylonx.mesh.VertexBuffer;
import babylonx.tools.math.Vector3;
import custom.Vertex;
import apix.common.util.StepIterator;


class MeshExtender {
	/** properties added to Mesh as dynamic vars 
	public var vertexArray  :Array<Vertex> ;
	public var cornerArray  :Array<Corner> ;
	public var faceArray  :Array<Face> ;
	*/	
	/**
	 * in Mesh.hx added by flnet TODO otherwise
	var _vertexBuffers:Dynamic; // see VertexBuffer xxxxKind
	*/
	static public inline var EMPTY_ERROR_MSG:String = "vertexArray is empty. Call Mesh.getVertexArray() before." ;
	static public inline var VERTEX_INDEX_ERROR_MSG:String = "index in a Vertex's instance is not valid." ;
	static public inline var NORMAL_EQUAL_ERROR_MSG:String = "Vertices with same position must have not equal normal." ;
	static public inline var POSITION_EQUAL_ERROR_MSG:String = "Vertices with same normal must have not equal position." ;
	static var saveStack:Array<Array<Float>> ;
	public static function createVertexArray (m:Mesh,?unconditional:Bool=false):Array<Vertex> {
        var mesh:Mesh = m; 
		var vertexArray:Array<Vertex>=[];
		var arr=mesh.getVerticesData(VertexBuffer.PositionKind);  
		var vertexNumber = mesh.getTotalVertices();	
		var stride:Int = m.getVertexBuffer(VertexBuffer.PositionKind).getStrideSize();
		// or var stride:Int =  Std.int(arr.length / vertexNumber) ;		
		// or var stride:Int = m.getVertexBuffer(VertexBuffer.PositionKind).getStrideSize(); 
		var vi:Vertex;
		if (getDynamic(m,"vertexArray")==null || unconditional ) {
			for (i in 0...vertexNumber) {
				vi = new Vertex(mesh,i);
				vi.position = new Vector3(arr[i * stride], arr[i * stride + 1], arr[i * stride + 2]);				
				vertexArray.push(vi);			
			}		
			arr=mesh.getVerticesData(VertexBuffer.NormalKind);  
			if (stride != Std.int(arr.length / vertexNumber) || (arr.length/stride)!=vertexArray.length) {
				trace("FATALE ERROR :");
				trace("                 stride=" + stride + " vs arr.length/vertexNumber=" + Std.int(arr.length / vertexNumber));
				trace("                 arr.length=" + arr.length + " vs vertexArray.length=" + vertexArray.length);
				
			} else {
				for (i in 0...vertexNumber) {
					vertexArray[i].normal = new Vector3(arr[i * stride], arr[i * stride + 1], arr[i * stride + 2]);			
				}				
			}
			setDynamic(m,"vertexArray",vertexArray );
		} else {
			vertexArray = getDynamic(m,"vertexArray") ;
		}
		createCorner(m);
		createTriangle(m);
		//
		trace("bound=\n" + m.getBoundingInfo().boundingBox.vectors);
		
		
		//
		return vertexArray;		
    }
	public static function verticesToString (m:Mesh):String {
		if (getDynamic(m,"vertexArray") == null ) createVertexArray (m);
		var title:String = "\n\n             ** Vertices info **\n";
		var str:String = "";
		str += "\nTotal vertices : " + m.getTotalVertices() ; 
		str += "\nTotal indices : " +  m.getTotalIndices () ;
		str += "\n";
		str += vertexArrayToString (m);
		str += "\n";
		str += cornerArrayToString  (m);
		str += "\n";
		str += faceArrayToString (m);
		
		//
		str += "\n\nIndices:\n";
		var arr = m.getIndices(); var len = m.getTotalIndices ();
		for (vi in 0...len) {
			str += "[" + vi + "]" + arr[vi]+"\n";			
		}	
		return title+str;
	}
	public static function vertexArrayToString (m:Mesh):String {
		var title:String = "\nPosition and normal : ";
		var str:String = "\n";
		//var vertexArray:Array<Dynamic>=[];
		if (getDynamic(m,"vertexArray") == null ) {
			str = EMPTY_ERROR_MSG;
		} else {			
			for (i in getDynamic(m,"vertexArray")) {
				str +=  i.toString() + "\n"; 
			}
		}
		return title+str;		
	}
	
	public static function createFace (m:Mesh,indArr:Array<Int>,?idx:Int=null):Face {
		var face:Face = new Face(m,idx);	
		var len = indArr.length; var v:Vertex;
		for (i in 0...len) { 			
			v = getDynamic(m,"vertexArray")[indArr[i]]	; 
			face.push(v);
			face.finishEdgeSetUp();			
		}
		return face;
	}	
	public static function getVertex (m:Mesh, vNum:Int):Vertex {
		if (getDynamic(m,"vertexArray") == null ) createVertexArray (m);
		return getDynamic(m,"vertexArray")[vNum];
	}
	public static function getTriangle (m:Mesh, faceNum:Int):Face {
		if (getDynamic(m,"vertexArray") == null ) createVertexArray (m);
		return cast(getDynamic(m,"faceArray")[faceNum],Face);
	}
	public static function getCorner (m:Mesh, cornerNum:Int):Corner {
		if (getDynamic(m,"vertexArray") == null ) createVertexArray (m);
		return cast(getDynamic(m,"cornerArray")[cornerNum],Corner);
	}
	
	public static function updateShape (m:Mesh):Mesh {
		var arr = [];
		if (getDynamic(m,"vertexArray") != null ) {
			for (i in getDynamic(m,"vertexArray")) {
				arr.push(i.position.x);
				arr.push(i.position.y);
				arr.push(i.position.z);			
			}	
		}
		m.updateVerticesData (VertexBuffer.PositionKind, arr);
		return m;
	}
	public static function saveShape (m:Mesh):Mesh {
		if (saveStack == null) saveStack = [];
		saveStack.push(m.getVerticesData (VertexBuffer.PositionKind));
		return m;
	}
	public static function restoreShape (m:Mesh):Mesh {
		if (saveStack != null) {
			if (saveStack.length>0) {
				m.updateVerticesData (VertexBuffer.PositionKind, saveStack[saveStack.length - 1]);
				createVertexArray (m, true);
			}
		}
		return m;
	}
	
	
	static function cornerArrayToString (m:Mesh):String {
		var title:String = "\nList of corner (vertices with same position) : ";
		var str:String = "\n"; 
		if (getDynamic(m,"vertexArray") == null ) {
			str = EMPTY_ERROR_MSG ;
		} else {
			
			str += getDynamic(m,"cornerArray").toString();
		}
		return title+str;		
	}
	static function createCorner (m:Mesh):Void {
		setDynamic(m,"cornerArray",null);
		var done:Array<Int>=[];
		var corner:Corner = null;
		var idx:Int = 0;
		for (i in getDynamic(m,"vertexArray")) {
			if (!isDone(done, i.index)) {
				for (j in getDynamic(m,"vertexArray")) {
					if (i.index != j.index) {
						if (i.position.equals(j.position)) {	
							//match
							if (corner == null) { 								
								corner=new Corner(m,idx,i.index);idx++;
								corner.push(i);
								done.push(i.index);
							}
							corner.push(j);
							done.push(j.index);							
						}						
					}					
				}
				if (corner != null) {
					if (getDynamic(m,"cornerArray") == null) setDynamic(m,"cornerArray",[]);
					getDynamic(m, "cornerArray").push(untyped corner);
					trace("corner pos=" + corner.position);
				}
				corner = null;
			}
		}		
	}
	static function faceArrayToString (m:Mesh):String {
		var title:String = "\nList of triangle : ";
		var str:String = "\n"; 
		if (getDynamic(m,"vertexArray") == null ) {
			str = EMPTY_ERROR_MSG ;
		} else {			
			str += getDynamic(m,"faceArray").toString();
		}
		return title+str;		
	}
	static function createTriangle (m:Mesh):Void {
		var face:Face = null;
		var idx:Int = 0;
		var arr =  m.getIndices(); var len = arr.length; var v:Vertex;
		for (i in new StepIterator(0, len, 3)) { 			
			face=new Face(m,idx);idx++;
			for (j in new StepIterator(0, 3 ) ) {
				v = getDynamic(m,"vertexArray")[arr[i + j]]	; 
				face.push(v);	
				face.indiceArray.push(i + j) ;
				//
				v.faceArray.push(face);
			}
			face.finishEdgeSetUp();
			if (getDynamic(m,"faceArray") == null) setDynamic(m,"faceArray",[]); 
			getDynamic(m,"faceArray").push(untyped face);
		}
	}
	
	static function isDone (d:Array<Int>,n:Int):Bool {
		var ret:Bool = false;
		for (di in d) {
			if (n == di) {
				ret = true;
				break;
			}
		}
		return ret;
	}
	
	public static function setDynamic (m:Mesh,prop:String,?val:Dynamic=null) {
		untyped __js__ ("m[prop]=val;");
		return untyped m;
	}
	public static function getDynamic (m:Mesh,prop:String)  {
		return untyped __js__ ("m[prop];");
	}
	
}

  
        