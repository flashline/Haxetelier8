/**
 * Copyright (c) jm Delettre.
 */

package custom ;
import babylonx.mesh.Mesh;
import babylonx.tools.math.Vector3;

/**
 * edge 
 */
class Edge {
	public var mesh(default,null):Mesh;
	public var start(default, null):Vertex;
	public var end(default, default):Vertex;
	
    public function new (m:Mesh,v:Vertex){
        mesh = m;  
			start = v;
		end = new Vertex(m, -1);
    }
	//
	public function move(v3:Vector3) : Mesh {
		for (i in start.corner.children) {		
			i.move(v3);
		}
		for (i in end.corner.children) {		
			i.move(v3);
		}
		return mesh;
	}
	//
	public function toString() :String {
		var str = ""; 
		str += " ("+start.index + ","+end.index + ") " ;			
		return str;
    }
	
	
}

  