/**
 * Copyright (c) jm Delettre.
 */

package custom ;
import babylonx.mesh.Mesh;
import babylonx.tools.math.Vector3;
using custom.MeshExtender;

class SurFace {
	public var mesh(default,null):Mesh;
    public var children(default, null):Array<Vertex>;
    public var edgeChildren(default, null):Array<Edge>;
	public var id(default, null):String;
    public function new (m:Mesh,indArr:Array<Int>,?vid:String){
        mesh = m;  
		id = vid;
		children =[] ;
		edgeChildren = [];
		for (i in indArr) { 	
			var v:Vertex = m.getDynamic("vertexArray")[i] ;
			children.push(v);
			edgeChildren.push(new Edge(mesh, v));
		}		
		finishEdgeSetUp();
    }	
	function finishEdgeSetUp() : Void {
		var j:Int=0;
		for (i in edgeChildren) {
			j ++;
			if (j == edgeChildren.length ) j = 0 ;					
			i.end = children[j];
		}
	}
	public function getEdge (edgeNum:Int):Edge {		
		return edgeChildren[edgeNum];
	}
	public function getCorner (vtxNum:Int):Corner {		
		return children[vtxNum].corner;
	}
	//	
	public function move(v3:Vector3) : Mesh {
		for (i in children) {
			i.corner.move(v3);
		}
		return mesh;
	}
	//
	public function toString() :String {
		var str = "";		
		str += "\nsurface [" + id + "] \twith vertex children:\t" ;			
		for (i in children) {
			str +=  "["+i.index + "]"; 
		}
		str += "\n\t\t\twith corner children : " ;
		for (i in children) {
			str +=  i.corner.toString(); 
		}
		str += "\n\t\t\twith edge children : " ;
		for (i in edgeChildren) {			
			str += i.toString(); 
		}		
		return str;
    }
	
}

  