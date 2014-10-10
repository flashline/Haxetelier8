﻿/**
 * Copyright (c) jm Delettre.
 */

package custom ;
import babylonx.mesh.Mesh;
import babylonx.tools.math.Vector3;


class Face {
	public var mesh(default,null):Mesh;
	public var index(default,null):Int;
    public var children(default, null):Array<Vertex>;
    public var cornerChildren(default, null):Array<Corner>;
    public var edgeChildren(default, null):Array<Edge>;
    public var indiceArray(default,default):Array<Int>;
	
    public function new (m:Mesh,?idx:Int){
        mesh = m;  
		index = idx;
		children = null;
		cornerChildren = null;
		edgeChildren = null;
		indiceArray = [];
    }
	public function push(v:Vertex) : Void {
		if (children == null) {
			children = [];
			cornerChildren = [];
			edgeChildren = [];
		}
		children.push(v);
		cornerChildren.push(v.corner);
		//
		var ed = new Edge(mesh, v);
		edgeChildren.push(ed);
	}
	public function finishEdgeSetUp() : Void {
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
		for (i in cornerChildren) {
			i.move(v3);
		}
		return mesh;
	}
	//
	public function toString() :String {
		var str = "";
		if (index == null) {
			 str += MeshExtender.EMPTY_ERROR_MSG;
		} else {
			str += "\ntriangle [" + index+ "] \twith vertex children:\t" ;			
			for (i in children) {
				str +=  "["+i.index + "]"; 
			}
			str += "\n\t\t\twith corner children : " ;
			for (i in cornerChildren) {
				if (i != null) str +=  "[" + i.index + "]"; 
			}
			str += "\n\t\t\twith edge children : " ;
			for (i in edgeChildren) {
				//str +=  "[" + i.index + "]"; 
				str += i.toString(); 
			}
			str += "\n\t\t\twith indices : " + indiceArray.join(",") +" \n" ;
		}
		return str;
    }
	
}

  