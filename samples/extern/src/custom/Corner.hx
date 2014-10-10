/**
 * Copyright (c) jm Delettre.
 */

package custom ;
import babylonx.mesh.Mesh;
import babylonx.tools.math.Vector3;


class Corner {
	public var mesh(default,null):Mesh;
	public var index(default,null):Int;
    public var children(default, null):Array<Vertex>;
    public var firstVertex(default, null):Int;
    public var position(get,set):Vector3;
    public function new (m:Mesh,idx:Int,?first:Int=null){
        mesh = m;  
		index = idx;
		firstVertex = first ;
		children = [];
    }
	public function push(v:Vertex) : Void {
		children.push(v);
		v.corner = this;
	}
	//
	public function move(v3:Vector3) : Void {
		for (i in children) {
			i.move(v3);
		}
	}
	//
	public function toString() :String {
		var str = "";
		if (index == null) {
			 str += MeshExtender.EMPTY_ERROR_MSG;
		} else {
			str += "\n corner [" + index+ "] with children:\n" ;			
			for (i in children) {
				str +=  i.toString()+"\n" ; // "[" + i.index + "] ";				
			}
		}
		return str;
    }
	//private
	function set_position(v:Vector3) :Vector3 {		
		for (i in children) {
			i.position.x = v.x;
			i.position.y = v.y;
			i.position.z = v.z;
		}
		return v ;
	} 
	function get_position() :Vector3 {
		var v3:Vector3=null;
		if  ( children.length > 0 ) {
			var v = children[0].position	;	
			v3=new Vector3(v.x,v.y,v.z);
		}
		return v3 ;
	} 
}

  