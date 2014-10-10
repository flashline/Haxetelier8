/**
 * Copyright (c) jm Delettre.
 */

package custom ;
import babylonx.mesh.Mesh;
import babylonx.tools.math.Vector3;


class Vertex {
	public var mesh(default,null):Mesh;
	public var index(default, null):Int;
	//
	//public var edgeArray(default, default):Array<Edge>;
    public var faceArray(default, default):Array<Face>;
    //
	public var corner:Corner;
	public var position:Vector3;
    public var normal:Vector3;
    //
	public function new (m:Mesh,i:Int){
        mesh = m;  	
		index = i;
		faceArray = [];
    }
	public function move (v3:Vector3) {
       position.addInPlace(v3);
    }
	
	public function toString() :String {
		var str = "";
		if (position == null) {
			 str += MeshExtender.EMPTY_ERROR_MSG;
		} else {
			str += "vertex [" + index+ "]" ;
			str += " position=" + position+"   ";
			str += "normal=" + normal ;
		}
		return str;
    }	
}

  