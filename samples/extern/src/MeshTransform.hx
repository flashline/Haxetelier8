/**
 * Copyright (c) jm Delettre.
 */
/**
* MeshTransform app root package
*/
package;
/**
* classes imports
*/
import babylonx.cameras.FreeCamera;
import babylonx.Engine;
import babylonx.lights.PointLight;
import babylonx.materials.Material;
import babylonx.materials.MultiMaterial;
import babylonx.materials.StandardMaterial;
import babylonx.materials.textures.Texture;
import babylonx.mesh.Mesh;
import babylonx.mesh.SubMesh;
import babylonx.mesh.VertexBuffer;
import babylonx.Scene;
import babylonx.Scene.ScenePickResult;
import babylonx.tools.math.Matrix;
import babylonx.tools.math.Vector3;
import babylonx.tools.Tools;
import custom.Face;
import custom.SurFace;
import haxe.Timer;
import js.Browser;
import js.html.Element;
import js.html.CanvasElement;
import js.html.Event;
import js.html.MouseEvent;
import apix.common.event.StandardEvent;
//ici
import custom.FreeCameraX;
//
import babylonx.mesh.Mesh; import custom.MeshExtender; using custom.MeshExtender;
//
/**
* root class
*/
class MeshTransform  {
	var engine:Engine;
	var scene:Scene;
	var renderLoop:Dynamic;
	//ici var camera:FreeCameraX;
	var camera:FreeCamera;
	var localDirection:Vector3 ;
    var transformedDirection:Vector3 ;
	var cameraTransformMatrix:Matrix;
	//translations
	var goCamEnable:Bool;
	var backCamEnable:Bool;
	var leftCamEnable:Bool;
	var rightCamEnable:Bool;
	var upCamEnable:Bool;
	var downCamEnable:Bool;
	//rotations
	var leftRotEnable:Bool;
	var rightRotEnable:Bool;
	var upRotEnable:Bool;
	var downRotEnable:Bool;
	var rightZRotEnable:Bool;
	var leftZRotEnable:Bool;
	var changeEnable:Bool;
	var box:Mesh ;
	var cyl:Mesh ;
	//html elems
	var canvas:CanvasElement;
	//
	var max:Float;
	var loop:Int;
	//
	public function new () {	
		// bug incompability btween babylon/haxe
		untyped __js__ ("var noop = function () {} ");
		untyped __js__ ("for (var i in Array.prototype) Array.prototype[i].prepare = noop ");
		//
		loop = 0;
		//translations
		goCamEnable = false;
		backCamEnable = false;
		leftCamEnable = false;
		rightCamEnable = false;
		upCamEnable = false;
		downCamEnable = false;		
		//rotations
		leftRotEnable = false;
		rightRotEnable = false;
		upRotEnable = false;
		downRotEnable = false;
		rightZRotEnable=false;
		leftZRotEnable = false;
		changeEnable = false;
		//
		canvas = cast(Browser.document.getElementById("renderCanvas"),CanvasElement);
		var control:Element = Browser.document.getElementById("control");
		//look
		if (!Engine.isSupported()) {
			control.innerHTML = "<h1 style='text-align:center' >WEBGL is NOT supported ! </h1>";
		} else {
			// used to translations
			localDirection= Vector3.Zero();
			transformedDirection = Vector3.Zero();
			cameraTransformMatrix = Matrix.Zero();
			//translations		
			var goCam = Browser.document.getElementById("goCam");
			var backCam = Browser.document.getElementById("backCam");
			var leftCam = Browser.document.getElementById("leftCam");
			var rightCam = Browser.document.getElementById("rightCam");
			var upCam = Browser.document.getElementById("upCam");
			var downCam = Browser.document.getElementById("downCam");
			//rotations
			var leftRot = Browser.document.getElementById("leftRot");
			var rightRot = Browser.document.getElementById("rightRot");
			var upRot = Browser.document.getElementById("upRot");
			var downRot = Browser.document.getElementById("downRot");
			var rightZRot = Browser.document.getElementById("rightZRot");
			var leftZRot = Browser.document.getElementById("leftZRot");
			var stage=Browser.document.getElementById("renderCanvas");
			//
			//look
			engine = new Engine(canvas, true);
			//look
			scene = new Scene(engine);			
			//look
			camera = new FreeCamera("Camera", new Vector3(0, 0, -5), scene); //camera = new FreeCameraX("Camera", new Vector3(0, 0, -5), scene); // camera.f1();	//ici			
			//look // actions souris
			camera.attachControl(canvas);
			//look // positionne projecteurs de lumière
			new PointLight("Omni0", new Vector3(200, 50, -100), scene);
			new PointLight("Omni1", new Vector3(-200, -50, -200), scene);
			//look // création d'un objet 3d display
			box = Mesh.CreateBox("Box", 50, scene, true);			
			box.position = new Vector3(0, 0, 200);
			//look // déclanche loop d'exéc de onClock()
			var renderLoop = function () {scene.render(); };
			engine.runRenderLoop(renderLoop);
			scene.beforeRender = function() {
				onClock();
			};
			// look // les textures
			var mat0:StandardMaterial = new StandardMaterial("mat0", scene);
			var mat1:StandardMaterial = new StandardMaterial("mat1", scene);
			var mat2:StandardMaterial = new StandardMaterial("mat2", scene);
			var mat3:StandardMaterial = new StandardMaterial("mat3", scene);
			var mat4:StandardMaterial = new StandardMaterial("mat4", scene);
			var mat5:StandardMaterial = new StandardMaterial("mat5", scene);			
			mat0.diffuseTexture = new Texture("asset/clo0.jpg", scene);
			mat1.diffuseTexture = new Texture("asset/clo1.jpg", scene);
			mat2.diffuseTexture = new Texture("asset/clo2.jpg", scene);
			mat3.diffuseTexture = new Texture("asset/clo3.jpg", scene);
			mat4.diffuseTexture = new Texture("asset/clo4.jpg", scene);
			mat5.diffuseTexture = new Texture("asset/clo5.jpg", scene);
			box.isVisible = true;
			var xm = new MultiMaterial ("mx", scene);
			xm.subMaterials.push(mat0);
			xm.subMaterials.push(mat1);
			xm.subMaterials.push(mat2);
			xm.subMaterials.push(mat3);
			xm.subMaterials.push(mat4);
			xm.subMaterials.push(mat5);
			box.material =  xm;			
			box.subMeshes = [];
			var verticesCount = box.getTotalVertices();	
			box.subMeshes.push(new SubMesh(0, 0, verticesCount, 0, 6, box));
			box.subMeshes.push(new SubMesh(1, 0, verticesCount, 6,6, box));
			box.subMeshes.push(new SubMesh(2, 0, verticesCount, 12,6, box));
			box.subMeshes.push(new SubMesh(3, 0, verticesCount, 18,6, box));			
			box.subMeshes.push(new SubMesh(4, 0, verticesCount, 24, 6, box));
			box.subMeshes.push(new SubMesh(5, 0, verticesCount, 30, 6, box));/**/
			//
			//
			// translations
			goCam.addEventListener("mousedown", onGoCamMouseDown, false);
			goCam.addEventListener("mouseup", onGoCamMouseUp, false);
			backCam.addEventListener("mousedown", onBackCamMouseDown, false);
			backCam.addEventListener("mouseup", onBackCamMouseUp, false);
			leftCam.addEventListener("mousedown", onLeftCamMouseDown, false);
			leftCam.addEventListener("mouseup", onLeftCamMouseUp, false);
			rightCam.addEventListener("mousedown", onRightCamMouseDown, false);
			rightCam.addEventListener("mouseup", onRightCamMouseUp, false);
			upCam.addEventListener("mousedown", onUpCamMouseDown, false);
			upCam.addEventListener("mouseup", onUpCamMouseUp, false);
			downCam.addEventListener("mousedown", onDownCamMouseDown, false);
			downCam.addEventListener("mouseup", onDownCamMouseUp, false);			
			// rotations
			leftRot.addEventListener("mousedown", onLeftRotMouseDown , false);
			rightRot.addEventListener("mousedown", onRightRotMouseDown, false);	
			upRot.addEventListener("mousedown", onUpRotMouseDown, false);
			downRot.addEventListener("mousedown", onDownRotMouseDown, false);
			rightZRot.addEventListener("mousedown", onRightZRotMouseDown, false);
			leftZRot.addEventListener("mousedown", onLeftZRotMouseDown, false);
			//pick,start,stop
			canvas.addEventListener(StandardEvent.CLICK, onSceneClick , false);			
			//
			Browser.document.getElementById("change").addEventListener("click", onChangeMeshClick , false);
			//	
			trace(box.verticesToString());
			box.createVertexArray();			
			box.saveShape();
			
		}
	}
	//look // typDef ScenePickResult		
	function onSceneClick (e:Event) {  
		var evt = cast(e,MouseEvent);
		var pickResult:ScenePickResult = scene.pick(evt.clientX, evt.clientY);
		trace("hit="+pickResult.hit );
		trace("distance="+pickResult.distance );
		trace("meshname="+pickResult.pickedMesh.name );
		trace("picking v3="+pickResult.pickedPoint );
	}
	function onChangeMeshClick (e) { 		
		changeEnable = !changeEnable;
		if (!changeEnable) {
			loop = 0;
			box.restoreShape();
		}
	}	
	//doTorsada
	function doTorsada() { 
		loop++;
		var speed=.2;max = max = 300 / (speed * 10) ; 			
		var val = speed;
		//
		if (loop > 2 * max) {
			val = -speed;
			onChangeMeshClick (null);
		} else if (loop < max) {
			val = speed;
		} else {
			val = -speed;
		}
		var haut:SurFace = new SurFace(box,[16, 17, 18, 19],"haut"); // n° 4 (5th)
		var bas:SurFace = new SurFace(box, [20, 21, 22, 23], "bas"); //n° 5 (6th)
		
		haut.getEdge(1).move(new Vector3(val,0, 0));
		haut.getEdge(3).move(new Vector3( -val, 0, 0));
		
		haut.getEdge(0).move(new Vector3(0,0,-val));
		haut.getEdge(2).move(new Vector3(0,0,val));
		
		bas.getEdge(1).move(new Vector3(-val,0,0));
		bas.getEdge(3).move(new Vector3(val, 0, 0));
		
		bas.getEdge(0).move(new Vector3(0,0, -val));
		bas.getEdge(2).move(new Vector3(0, 0, val));
		box.updateShape();			
	}
	//function onClock (e) { 
	function onClock () { 
		var e=null;
		//translations
		if (goCamEnable) {
			onGoCamDoIt(e);
		}	
		if (backCamEnable) {
			onBackCamDoIt(e);
		}			
		if (leftCamEnable) {
			onLeftCamDoIt (e);
		}
		if (rightCamEnable) {
			onRightCamDoIt (e);
		}
		if (upCamEnable) {
			onUpCamDoIt (e);
		}
		if (downCamEnable) {
			onDownCamDoIt (e);
		}
		// rotations
		if (leftRotEnable) {
			onLeftRotDoIt (e);
		}	
		if (rightRotEnable) {
			onRightRotDoIt (e);
		}	
		if (upRotEnable) {
			onUpRotDoIt (e);
		}
		if (downRotEnable) {
			onDownRotDoIt (e);
		}
		if (rightZRotEnable) {
			onRightZRotDoIt(e);
		}
		if (leftZRotEnable) {
			onLeftZRotDoIt(e);
		}
		if (changeEnable) {	
			doTorsada();
		}
	}
	//listeners 
	/// translations
	function onGoCamMouseDown (e) { 
		goCamEnable = true;		
	}
	function onGoCamMouseUp (e) { 
		goCamEnable = false;		
	}
	function onBackCamMouseDown (e) { 
		backCamEnable = true;		
	}
	function onBackCamMouseUp (e) { 
		backCamEnable = false;		
	}
	function onLeftCamMouseDown (e) { 
		leftCamEnable = true;		
	}
	function onLeftCamMouseUp (e) { 
		leftCamEnable = false;		
	}
	function onRightCamMouseDown (e) { 
		rightCamEnable = true;		
	}
	function onRightCamMouseUp (e) { 
		rightCamEnable = false;		
	}
	function onUpCamMouseDown (e) { 
		upCamEnable = true;		
	}
	function onUpCamMouseUp (e) { 
		upCamEnable = false;		
	}
	function onDownCamMouseDown (e) { 
		downCamEnable = true;		
	}
	function onDownCamMouseUp (e) { 
		downCamEnable = false;		
	}
	/// rotations
	function onLeftRotMouseDown (e) { 
		leftRotEnable = !leftRotEnable;		
		if (leftRotEnable) rightRotEnable = false;
	}
	function onRightRotMouseDown (e) { 
		rightRotEnable = !rightRotEnable;		
		if (rightRotEnable) leftRotEnable = false;	
	}
	function onUpRotMouseDown (e) { 
		upRotEnable = !upRotEnable;		
		if (upRotEnable) downRotEnable = false;
	}
	function onDownRotMouseDown (e) { 
		downRotEnable = !downRotEnable;		
		if (downRotEnable) upRotEnable = false;		
	}
	function onRightZRotMouseDown (e) { 
		rightZRotEnable = !rightZRotEnable;		
		if (rightZRotEnable) leftZRotEnable = false;		
	}
	function onLeftZRotMouseDown (e) { 
		leftZRotEnable = !leftZRotEnable;		
		if (leftZRotEnable) rightZRotEnable = false;		
	}
	//
	// actions
	/// translations
	function onGoCamDoIt (e) { 
		translate(new Vector3(0, 0, 0.2));
	}
	function onBackCamDoIt (e) { 
		translate(new Vector3(0, 0, -0.2));		
	}
	function onLeftCamDoIt (e) { 
		translate(new Vector3( -0.2, 0, 0) );		
	}
	function onRightCamDoIt (e) { 
		translate(new Vector3(0.2,0, 0 ));
	}
	function onUpCamDoIt (e) { 
		translate(new Vector3(0,0.2, 0 ));
	}
	function onDownCamDoIt (e) { 
		translate(new Vector3(0,-0.2, 0 ));
	}
	//look // translations
	function translate (v3:Vector3) {
		 localDirection.copyFromFloats(v3.x,v3.y,v3.z); 
		 Matrix.RotationYawPitchRollToRef(camera.rotation.y, camera.rotation.x, 0, cameraTransformMatrix);
         Vector3.TransformCoordinatesToRef(localDirection, cameraTransformMatrix,transformedDirection);
         camera.cameraDirection.addInPlace(transformedDirection);
	}
	/// rotations
	function onLeftRotDoIt (e) { 
		box.rotation.y += Math.PI / 128 ;// -0.025 radians // -1,41°
		//box.rotation.y += Math.PI*2;//360° // Math.PI;//180° //Math.PI/2;//90°  //Math.PI/4;//45°  //Math.PI/8;//22,5°  //Math.PI/16;//11,25°  // ;
	}
	function onRightRotDoIt (e) { 
		box.rotation.y +=-Math.PI / 128 ;// 0.025 radians // 1,41°
	}
	function onUpRotDoIt (e) { 
		box.rotation.x += 0.01;
	}
	function onDownRotDoIt (e) { 
		box.rotation.x += -0.01;
	}
	function onRightZRotDoIt (e) { 
		box.rotation.z += -0.01;
	}
	function onLeftZRotDoIt (e) { 
		box.rotation.z += 0.01;
	}
	
 /**/
    static function main() {  
		new MeshTransform();
	}
}