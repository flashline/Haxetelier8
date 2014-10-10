/**
 * Copyright (c) jm Delettre.
 */

package custom ;
import babylonx.cameras.FreeCamera;
import babylonx.Scene;
import babylonx.tools.math.Vector3;

class FreeCameraX extends FreeCamera {
	
    public function new(name:String, position:Vector3, scene:Scene){
		super(name, position,scene);
	}
	public function f1() {
		trace("f1 name="+this.name);
	}
	
}

