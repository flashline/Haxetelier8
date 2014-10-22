//
package babylonx.cameras ;
//
import babylonx.Scene;
import babylonx.tools.math.Vector3;
import js.html.CanvasElement;
import babylonx.tools.math.Matrix;
// Créer pour pour chaque classe native, une classe standard haxe
//
//1-écrire devant "class"
//	@:native (“<nom réel de la classe en JS ou autre langage>”) 
//		facultatif si le nom et package natifs sont les mêmes que ceux de la classe Haxe (nom doit commencer par une majuscule en haxe) 
//		ce qui n'est pas le cas ici.
// 	puis "extern"
//	
// 
@:native("BABYLON.Camera") // ou juste @:native("BABYLON.") 
extern class Camera {
	// On ne met que les membres public
	//
	// Constantes (ou variables static)
	static public var PERSPECTIVE_CAMERA (default,null) : Float; // =0
	static public var ORTHOGRAPHIC_CAMERA (default,null) : Float; // =1
	// propriétés d'instance.
	public var name : String;
	public var id : String;
	public var position : Vector3;
	public var fov : Float;
	public var orthoLeft : Float;
	public var orthoRight : Float;
	public var orthoBottom : Float;
	public var orthoTop : Float;
	public var minZ : Float;
	public var maxZ : Float;
	public var intertia : Float;
	public var mode : Float;
	//Les méthodes n'ont pas de corps donc pas de {} car le code est dans le .js
    public function new(name:String, position:Vector3, scene:Scene);
	//mais doivent être correctement typées ; sinon aucun intérêt !
	public function attachControl (canvas:CanvasElement, ?noPreventDefault:Bool ):Void ;
	public function detachControl (canvas:CanvasElement ):Void ;
	public function _update() : Dynamic;
	public function getViewMatrix(  ) : Matrix;
	public function getProjectionMatrix(  ) : Matrix;
	//
	//
	// NOTES: 	
	//			
	//			Si on ne souhaite pas ajouter de commentaires, ni avoir des classes bien packagées, on peut mettre toutes les classes dans le même fichier.
	// 			Voir : haxelier 8/samples/extern/src/ByGenerator.hx
	//			on aura pas besoin de faire plusieurs "import" !
	//
	// 			Bien qu’il y ait des tentatives d’automatisation (buildhx de joshua granick sur github),
	//			une extern doit être terminées à la main : 
	//				- au moins pour qu’elle passe la compilation.
	//				- au mieux pour qu’elle soit correctement typée puisque c’est le but recherché !
	//
	//			Certaines APIs se prêtent mieux que d’autres à l’extern 'alisation :
	//
	//			soit parce qu’elles sont bien écrites  :
	//				// voir js/babylon/mesh.js avec ses propiétés, méthodes, méthodes statics bien visibles et séparés.
	//
	//			Soit parce qu’elles sont fiables et possèdent une parfaite documentation (style javaDoc). 
	//
	//			Une extern peut-être étendu par une classe haxe standard (testé by myself !)
	//			Pas besoin de modifier le JS.
	//
	//			Contrairement à ce que j'ai fait,
	//			Il faut éviter de faire une extern sur une api trop jeune et non stabilisée.
	//			on n'est pas obligé de faire toutes les classes et tous les membres d'un coup. 
	//			Mais uniquement ce qu'on utilise. (ça évite de trop en faire et d'(inclure des private)
	//
	// SUITE :	Astuces et problèmes concrets
	// 			voir Scene.hx pour les typDef . 
	// 			voir Mesh.hx : MeshMaterial interface dans Material.hx et MultiMaterial.hx + var material:MeshMaterial; dans Mesh.hx  -pour problème de double typage dans native.
	// 			voir BoundingBox.hx pour la var se nommant extends dans l'api native
	// 			voir Mesh.hx inline public function getVertexBuffer  (kind:String) : VertexBuffer { return untyped _vertexBuffers[kind] ; } pour problème tableau associatif (arr["toto"])
	//
	// Utilisation de Babylon 	
	//		source	: 	extern/src/MeshTransform.hx ou Test.hx
	// 		exe 	:   http://localhost/__HAXE/haxelier%208/samples/extern/bin/ ou http://www.pixaline.net/intra/3djs/
}
