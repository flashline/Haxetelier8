typedef WebGLProgram = { };
typedef WebGLShader = { };
typedef WebGLUniformLocation = { };
typedef WebGLRenderingContext = { };
typedef VertexBuffer = { };
typedef IndexBuffer = { };
 
typedef Capabilities = { public var maxTexturesImageUnits : Float; public var maxTextureSize : Float; public var maxCubemapTextureSize : Float; public var maxRenderTextureSize : Float; };
@:native("BABYLON.Engine") extern class Engine {
	public function new (canvas : HTMLCanvasElement, antialias : Bool ) : Void;
	public var forceWireframe : Bool;
	public var cullBackFaces : Bool;
	public var scenes : Array<Scene>;
	public var isPointerLock : Bool;
	public function getAspectRatio(  ) : Float;
	public function getRenderWidth(  ) : Float;
	public function getRenderHeight(  ) : Float;
	public function getRenderingCanvas(  ) : HTMLCanvasElement;
	public function setHardwareScalingLevel( level : Float ) : Void;
	public function getLoadedTexturesCache(  ) : Array<Texture>;
	public function getCaps(  ) : Capabilities;
	public function stopRenderLoop(  ) : Void;
	public function runRenderLoop( renderFunction : Function ) : Void;
	public function switchFullscreen( element : HTMLElement ) : Void;
	public function clear( color : IColor3, backBuffer : Bool, depthStencil : Bool ) : Void;
	public function beginFrame(  ) : Void;
	public function endFrame(  ) : Void;
	public function resize(  ) : Void;
	public function bindFramebuffer( texture : Texture ) : Void;
	public function unBindFramebuffer( texture : Texture ) : Void;
	public function flushFramebuffer(  ) : Void;
	public function restoreDefaultFramebuffer(  ) : Void;
	@:overload(function ( vertices : ArrayBuffer ) : VertexBuffer {
	}) @:overload(function ( vertices : ArrayBufferView ) : VertexBuffer {
	}) public function createVertexBuffer( vertices : Array<Float> ) : VertexBuffer;
	public function createDynamicVertexBuffer( capacity : Float ) : VertexBuffer;
	@:overload(function ( vertexBuffer : VertexBuffer, vertices : ArrayBuffer ) : Void {
	}) @:overload(function ( vertexBuffer : VertexBuffer, vertices : ArrayBufferView ) : Void {
	}) public function updateDynamicVertexBuffer( vertexBuffer : VertexBuffer, vertices : Array<Float> ) : Void;
	public function createIndexBuffer( indices : Dynamic, is32Bits : Dynamic ) : IndexBuffer;
	public function bindBuffers( vb : VertexBuffer, ib : IndexBuffer, vdecl : Array<Float>, strideSize : Float, effect : Effect ) : Void;
	public function bindMultiBuffers( vertexBuffers : Array<VertexBuffer>, indexBuffer : IndexBuffer, effect : Effect ) : Void;
	public function _releaseBuffer( vb : VertexBuffer ) : Void;
	public function draw( useTriangles : Bool, indexStart : Float, indexCount : Float ) : Void;
	public function createEffect( baseName : String, attributesNames : String, uniformsNames : Array<String>, samplers : Array<WebGLUniformLocation>, defines : String ) : Effect;
	public function createShaderProgram( vertexCode : String, fragmentCode : String, defines : String ) : WebGLProgram;
	public function getUniforms( shaderProgram : WebGLProgram, uniformsNames : Array<String> ) : Array<WebGLUniformLocation>;
	public function getAttributes( shaderProgram : WebGLProgram, attributesNames : Array<String> ) : Array<Float>;
	public function enableEffect( effect : Effect ) : Void;
	public function setMatrices( uniform : String, matrices : Array<Matrix> ) : Void;
	public function setMatrix( uniform : String, matrix : Matrix ) : Void;
	public function setVector2( uniform : String, x : Float, y : Float ) : Void;
	public function setVector3( uniform : String, v : Vector3 ) : Void;
	public function setFloat2( uniform : String, x : Float, y : Float ) : Void;
	public function setFloat3( uniform : String, x : Float, y : Float, z : Float ) : Void;
	public function setBool( uniform : String, val : Bool ) : Void;
	public function setFloat4( uniform : String, x : Float, y : Float, z : Float, w : Float ) : Void;
	public function setColor3( uniform : String, color : Color3 ) : Void;
	public function setColor4( uniform : String, color : Color3, alpha : Float ) : Void;
	public function setState( cullingMode : Float ) : Void;
	public function setDepthBuffer( enable : Bool ) : Void;
	public function setDepthWrite( enable : Bool ) : Void;
	public function setColorWrite( enable : Bool ) : Void;
	public function setAlphaMode( mode : Float ) : Void;
	public function setAlphaTesting( enable : Bool ) : Void;
	public function getAlphaTesting(  ) : Bool;
	public function wipeCaches(  ) : Void;
	public function getExponantOfTwo( value : Float, max : Float ) : Float;
	public function createTexture( url : String, noMipmap : Bool, invertY : Bool, scene : Scene ) : Texture;
	public function createDynamicTexture( size : Float, noMipmap : Bool ) : Texture;
	public function updateDynamicTexture( texture : Texture, canvas : HTMLCanvasElement, invertY : Bool ) : Void;
	public function updateVideoTexture( texture : Texture, video : HTMLVideoElement ) : Void;
	public function createRenderTargetTexture( size : Float, generateMipMaps : Bool ) : Texture;
	public function createCubeTexture( rootUrl : String, scene : Scene ) : Texture;
	public function _releaseTexture( tex : Texture ) : Void;
	public function bindSamplers( effect : Effect ) : Void;
	public function setTexture( channel : Float, texture : Texture ) : Void;
	public function dispose(  ) : Void;
	public var ShadersRepository : String;
	public var ALPHA_DISABLE : Float;
	public var ALPHA_ADD : Float;
	public var ALPHA_COMBINE : Float;
	public var DELAYLOADSTATE_NONE : Float;
	public var DELAYLOADSTATE_LOADED : Float;
	public var DELAYLOADSTATE_LOADING : Float;
	public var DELAYLOADSTATE_NOTLOADED : Float;
	public var epsilon : Float;
	public var collisionEpsilon : Float;
	public function isSupported(  ) : Bool;
}
typedef ScenePickResult = { public var hit : Bool; public var distance : Float; public var pickedMesh : Mesh; public var pickedPoint : Vector3; };
@:native("BABYLON.") extern class Scene {
	public function new (engine : Engine ) : Void;
	public var autoClear : Bool;
	public var clearColor : Color3;
	public var ambientColor : Color3;
	public var fogMode : Float;
	public var fogColor : Color3;
	public var fogDensity : Float;
	public var fogStart : Float;
	public var fogEnd : Float;
	public var lights : Array<Light>;
	public var cameras : Array<Camera>;
	public var activeCamera : Camera;
	public var meshes : Array<Mesh>;
	public var materials : Array<Material>;
	public var multiMaterials : Array<MultiMaterial>;
	public var defaultMaterial : StandardMaterial;
	public var textures : Array<Texture>;
	public var particlesEnabled : Bool;
	public var particleSystems : Array<ParticleSystem>;
	public var spriteManagers : Array<SpriteManager>;
	public var layers : Array<Layer>;
	public var skeletons : Array<Skeleton>;
	public var collisionsEnabled : Bool;
	public var gravity : Vector3;
	public var postProcessManager : PostProcessManager;
	public function getEngine(  ) : Engine;
	public function getTotalVertices(  ) : Float;
	public function getActiveVertices(  ) : Float;
	public function getActiveParticles(  ) : Float;
	public function getLastFrameDuration(  ) : Float;
	public function getEvaluateActiveMeshesDuration(  ) : Float;
	public function getRenderTargetsDuration(  ) : Float;
	public function getRenderDuration(  ) : Float;
	public function getParticlesDuration(  ) : Float;
	public function getSpritesDuration(  ) : Float;
	public function getAnimationRatio(  ) : Float;
	public var getRenderId : Float;
	public function isReady(  ) : Bool;
	public function registerBeforeRender( func : Function ) : Void;
	public function unregisterBeforeRender( func : Function ) : Void;
	public function executeWhenReady( func : Function ) : Void;
	public function getWaitingItemsCount(  ) : Float;
	public function beginAnimation( target : String, from : Float, to : Float, loop : Bool, speedRatio : Float, onAnimationEnd : Function ) : Void;
	public function stopAnimation( target : String ) : Void;
	public function getViewMatrix(  ) : Matrix;
	public function getProjectionMatrix(  ) : Matrix;
	public function getTransformMatrix(  ) : Matrix;
	public function setTransformMatrix( view : Matrix, projection : Matrix ) : Void;
	public function activeCameraByID( id : Float ) : Void;
	public function getMaterialByID( id : Float ) : Material;
	public function getLightByID( id : Float ) : Light;
	public function getMeshByID( id : Float ) : Mesh;
	public function getLastMeshByID( id : Float ) : Mesh;
	public function getMeshByName( name : String ) : Mesh;
	public function isActiveMesh( mesh : Mesh ) : Bool;
	public function getLastSkeletonByID( id : Float ) : Skeleton;
	public function getSkeletonByID( id : Float ) : Skeleton;
	public function getSkeletonByName( name : String ) : Skeleton;
	public function _evaluateActiveMeshes(  ) : Void;
	public function _localRender( opaqueSubMeshes : Dynamic, alphaTestSubMeshes : Dynamic, transparentSubMeshes : Dynamic, activeMeshes : Dynamic ) : Void;
	public function render(  ) : Void;
	public function dispose(  ) : Void;
	public function _getNewPosition( position : Vector3, velocity : Vector3, collider : Sphere, maximumRetries : Float ) : Vector3;
	public function _collideWithWorld( position : Vector3, velocity : Vector3, collider : Sphere, maximumRetries : Float ) : Vector3;
	public function createOrUpdateSelectionOctree(  ) : Void;
	public function createPickingRay( x : Float, y : Float, world : Matrix ) : Ray;
	public function pick( x : Float, y : Float ) : ScenePickResult;
	public var FOGMODE_NONE : Float;
	public var FOGMODE_EXP : Float;
	public var FOGMODE_EXP2 : Float;
	public var FOGMODE_LINEAR : Float;
}
typedef RayTriangleIntersection = { public var hit : Bool; public var distance : Float; public var bu : Float; public var bv : Float; };
typedef IColor3 = { public var r : Float; public var g : Float; public var b : Float; };
typedef Size2D = { public var width : Float; public var height : Float; };
typedef Sphere = { public var center : Vector3; public var radius : Float; };
@:native("BABYLON.") extern class Ray {
	public var origin : Vector3;
	public var direction : Vector3;
	public function new (origin : Vector3, direction : Vector3 ) : Void;
	public function intersectsBox( box : BoundingBox ) : Bool;
	public function intersectsSphere( sphere : Sphere ) : Bool;
	public function intersectsTriangle( vertex0 : Vector3, vertex1 : Vector3, vertex2 : Vector3 ) : RayTriangleIntersection;
	public function CreateNew( x : Float, y : Float, viewportWidth : Float, viewportHeight : Float, world : Matrix, view : Matrix, projection : Matrix ) : Ray;
}
@:native("BABYLON.") extern class Color3 {
	public var r : Float;
	public var g : Float;
	public var b : Float;
	public function new (intialR : Float, initialG : Float, initialB : Float ) : Void;
	@:overload(function ( otherColor : Color4 ) : Bool {
	}) public function equals( otherColor : Color3 ) : Bool;
	public function toString(  ) : String;
	public function clone(  ) : Color3;
	public function multiply( otherColor : Color3 ) : Color3;
	public function mutilplyToRef( otherColor : Color3, result : Color3 ) : Void;
	public function scale( scale : Float ) : Color3;
	public function scaleToRef( scale : Float, result : Color3 ) : Void;
	public function copyFrom( source : Color3 ) : Void;
	public function copyFromFloats( r : Float, g : Float, b : Float ) : Void;
	public function FromArray( array : Array<Float> ) : Color3;
}
@:native("BABYLON.") extern class Color4 {
	public var r : Float;
	public var g : Float;
	public var b : Float;
	public var a : Float;
	public function new (initialR : Float, initialG : Float, initialB : Float, initialA : Float ) : Void;
	public function addInPlace( right : Color4 ) : Void;
	public function add( right : Color4 ) : Color4;
	public function subtract( right : Color4 ) : Color4;
	public function subtractToRef( right : Color4, result : Color4 ) : Void;
	@:overload(function ( factor : Float, result : Color4 ) : Void {
	}) public function scale( factor : Float ) : Color4;
	public function toString(  ) : String;
	public function clone(  ) : Color4;
	public function Lerp( left : Float, right : Float, amount : Float ) : Color4;
	public function FromArray( array : Array<Float> ) : Color4;
}
@:native("BABYLON.") extern class Vector2 {
	public var x : Float;
	public var y : Float;
	public function new (x : Float, y : Float ) : Void;
	public function toString(  ) : String;
	public function add( other : Vector2 ) : Vector2;
	public function subtract( other : Vector2 ) : Vector2;
	public function negate(  ) : Vector2;
	public function scaleInPlace( scale : Float ) : Void;
	public function scale( scale : Float ) : Vector2;
	public function equals( other : Vector2 ) : Bool;
	public function length(  ) : Float;
	public function lengthSquared(  ) : Float;
	public function normalize(  ) : Void;
	public function clone(  ) : Vector2;
	public function Zero(  ) : Vector2;
	public function CatmullRom( value1 : Vector2, value2 : Vector2, value3 : Vector2, value4 : Vector2, amount : Float ) : Vector2;
	public function Clamp( value : Vector2, min : Vector2, max : Vector2 ) : Vector2;
	public function Hermite( value1 : Vector2, tangent1 : Vector2, value2 : Vector2, tangent2 : Vector2, amount : Float ) : Vector2;
	public function Lerp( start : Vector2, end : Vector2, amount : Float ) : Vector2;
	public function Dot( left : Vector2, right : Vector2 ) : Float;
	public function Normalize( vector : Vector2 ) : Vector2;
	public function Minimize( left : Vector2, right : Vector2 ) : Vector2;
	public function Maximize( left : Vector2, right : Vector2 ) : Vector2;
	public function Transform( vector : Vector2, transformation : Array<Float> ) : Vector2;
	public function Distance( value1 : Vector2, value2 : Vector2 ) : Float;
	public function DistanceSquared( value1 : Vector2, value2 : Vector2 ) : Float;
}
@:native("BABYLON.") extern class Vector3 {
	public var x : Float;
	public var y : Float;
	public var z : Float;
	public function new (x : Float, y : Float, z : Float ) : Void;
	public function toString(  ) : String;
	public function addInPlace( otherVector : Vector3 ) : Void;
	public function add( other : Vector3 ) : Vector3;
	public function addToRef( otherVector : Vector3, result : Vector3 ) : Void;
	public function suntractInPlace( otherVector : Vector3 ) : Void;
	public function subtract( other : Vector3 ) : Vector3;
	public function subtractToRef( otherVector : Vector3, result : Vector3 ) : Void;
	public function subtractFromFloatsTo( x : Float, y : Float, z : Float ) : Vector3;
	public function subtractFromFloatsToRef( x : Float, y : Float, z : Float, result : Vector3 ) : Void;
	public function negate(  ) : Vector3;
	public function scaleInPlace( scale : Float ) : Void;
	public function scale( scale : Float ) : Vector3;
	public function scaleToRef( scale : Float, result : Vector3 ) : Void;
	public function equals( other : Vector3 ) : Bool;
	public function equalsToFloats( x : Float, y : Float, z : Float ) : Bool;
	public function multiplyInPlace( other : Vector3 ) : Void;
	public function multiply( other : Vector3 ) : Vector3;
	public function multiplyToRef( otherVector : Vector3, result : Vector3 ) : Void;
	public function multiplyByFloats( x : Float, y : Float, z : Float ) : Vector3;
	public function divide( other : Vector3 ) : Vector3;
	public function divideToRef( otherVector : Vector3, result : Vector3 ) : Void;
	public function length(  ) : Float;
	public function lengthSquared(  ) : Float;
	public function normalize(  ) : Void;
	public function clone(  ) : Vector3;
	public function copyFrom( source : Vector3 ) : Void;
	public function copyFromFloats( x : Float, y : Float, z : Float ) : Void;
	public function FromArray( array : Array<Float>, offset : Float ) : Void;
	public function FromArrayToRef( array : Array<Float>, offset : Float, result : Vector3 ) : Void;
	public function FromFloatsToRef( x : Float, y : Float, z : Float, result : Vector3 ) : Void;
	public function Zero(  ) : Vector3;
	public function Up(  ) : Vector3;
	public function TransformCoordinates( vector : Vector3, transformation : Matrix ) : Vector3;
	public function TransformCoordinatesToRef( vector : Vector3, transformation : Matrix, result : Vector3 ) : Void;
	public function TransformCoordinatesFromFloatsToRef( x : Float, y : Float, z : Float, transformation : Matrix, result : Vector3 ) : Void;
	public function TransformNormal( vector : Vector3, transformation : Matrix ) : Vector3;
	public function TransformNormalToRef( vector : Vector3, transformation : Matrix, result : Vector3 ) : Void;
	public function TransformNormalFromFloatsToRef( x : Float, y : Float, z : Float, transformation : Matrix, result : Vector3 ) : Void;
	public function CatmullRom( value1 : Vector3, value2 : Vector3, value3 : Vector3, value4 : Vector3, amount : Float ) : Vector3;
	public function Clamp( value : Vector3, min : Vector3, max : Vector3 ) : Vector3;
	public function Hermite( value1 : Vector3, tangent1 : Vector3, value2 : Vector3, tangent2 : Vector3, amount : Float ) : Vector3;
	public function Lerp( start : Vector3, end : Vector3, amount : Float ) : Vector3;
	public function Dot( left : Vector3, right : Vector3 ) : Float;
	public function Cross( left : Vector3, right : Vector3 ) : Vector3;
	public function CrossToRef( left : Vector3, right : Vector3, result : Vector3 ) : Void;
	public function Normalize( vector : Vector3 ) : Vector3;
	public function NormalizeToRef( vector : Vector3, result : Vector3 ) : Void;
	public function Unproject( source : Vector3, viewportWidth : Float, viewportHeight : Float, world : Matrix, view : Matrix, projection : Matrix ) : Vector3;
	public function Minimize( left : Vector3, right : Vector3 ) : Vector3;
	public function Maximize( left : Vector3, right : Vector3 ) : Vector3;
	public function Distance( value1 : Vector3, value2 : Vector3 ) : Float;
	public function DistanceSquared( value1 : Vector3, value2 : Vector3 ) : Float;
}
@:native("BABYLON.") extern class Quaternion {
	public var x : Float;
	public var y : Float;
	public var z : Float;
	public var w : Float;
	public function toString(  ) : String;
	public function new (x : Float, y : Float, z : Float, w : Float ) : Void;
	public function equals( otherQuaternion : Quaternion ) : Bool;
	public function clone(  ) : Quaternion;
	public function copyFrom( other : Quaternion ) : Void;
	public function add( other : Quaternion ) : Quaternion;
	public function scale( factor : Float ) : Quaternion;
	public function multiply( q1 : Quaternion ) : Quaternion;
	public function multiplyToRef( q1 : Quaternion, result : Quaternion ) : Void;
	public function length(  ) : Float;
	public function normalize(  ) : Void;
	public function toEulerAngles(  ) : Vector3;
	public function toRotationMatrix( result : Quaternion ) : Void;
	public function FromArray( array : Array<Float>, offset : Float ) : Quaternion;
	public function RotationYawPitchRoll( yaw : Float, pitch : Float, roll : Float ) : Quaternion;
	public function RotationYawPitchRollToRef( yaw : Float, pitch : Float, roll : Float, result : Quaternion ) : Void;
	public function Slerp( left : Quaternion, right : Quaternion, amount : Float ) : Quaternion;
}
@:native("BABYLON.") extern class Matrix {
	public var m : Array<Float>;
	public function new ( ) : Void;
	public function isIdentity(  ) : Bool;
	public function determinant(  ) : Float;
	public function toArray(  ) : Array<Float>;
	public function invert(  ) : Void;
	public function invertToRef( other : Matrix ) : Void;
	public function setTranslations( vector3 : Vector3 ) : Void;
	public function multiply( other : Matrix ) : Matrix;
	public function copyFrom( other : Matrix ) : Void;
	public function multiplyToRef( other : Matrix, result : Matrix ) : Void;
	public function multiplyToArray( other : Matrix, result : Array<Float>, offset : Float ) : Void;
	public function equals( other : Matrix ) : Bool;
	public function clone(  ) : Matrix;
	public function FromArray( array : Array<Float>, offset : Float ) : Matrix;
	public function FromArrayToRef( array : Array<Float>, offset : Float, result : Matrix ) : Void;
	public function FromValues( m11 : Float, m12 : Float, m13 : Float, m14 : Float, m21 : Float, m22 : Float, m23 : Float, m24 : Float, m31 : Float, m32 : Float, m33 : Float, m34 : Float, m41 : Float, m42 : Float, m43 : Float, m44 : Float ) : Matrix;
	public function FromValuesToRef( m11 : Float, m12 : Float, m13 : Float, m14 : Float, m21 : Float, m22 : Float, m23 : Float, m24 : Float, m31 : Float, m32 : Float, m33 : Float, m34 : Float, m41 : Float, m42 : Float, m43 : Float, m44 : Float, result : Matrix ) : Void;
	public function Identity(  ) : Matrix;
	public function IdentityToRef( result : Matrix ) : Void;
	public function Zero(  ) : Matrix;
	public function RotationX( angle : Float ) : Matrix;
	public function RotationXToRef( angle : Float, result : Matrix ) : Void;
	public function RotationY( angle : Float ) : Matrix;
	public function RotationYToRef( angle : Float, result : Matrix ) : Void;
	public function RotationZ( angle : Float ) : Matrix;
	public function RotationZToRef( angle : Float, result : Matrix ) : Void;
	public function RotationAxis( axis : Vector3, angle : Float ) : Matrix;
	public function RotationYawPitchRoll( yaw : Float, pitch : Float, roll : Float ) : Matrix;
	public function Scaling( scaleX : Float, scaleY : Float, scaleZ : Float ) : Matrix;
	public function ScalingToRef( scaleX : Float, scaleY : Float, scaleZ : Float, result : Matrix ) : Void;
	public function Translation( x : Float, y : Float, z : Float ) : Matrix;
	public function TranslationToRef( x : Float, y : Float, z : Float, result : Matrix ) : Void;
	public function LookAtLH( eye : Vector3, target : Vector3, up : Vector3 ) : Matrix;
	public function LookAtLHToRef( eye : Vector3, target : Vector3, up : Vector3, result : Matrix ) : Void;
	public function OrthoLH( width : Float, height : Float, znear : Float, zfar : Float ) : Matrix;
	public function OrthoOffCenterLH( left : Float, right : Float, bottom : Float, top : Float, znear : Float, zfar : Float ) : Matrix;
	public function OrthoOffCenterLHToRef( left : Float, right : Float, bottom : Float, top : Float, znear : Float, zfar : Float, result : Matrix ) : Void;
	public function PerspectiveLH( width : Float, height : Float, znear : Float, zfar : Float ) : Matrix;
	public function PerspectiveFovLH( fov : Float, aspect : Float, znear : Float, zfar : Float ) : Matrix;
	public function PerspectiveFovLHToRef( fov : Float, aspect : Float, znear : Float, zfar : Float, result : Matrix ) : Void;
	public function AffineTransformation( scaling : Float, rotationCenter : Vector3, rotation : Quaternion, translation : Vector3 ) : Matrix;
	public function GetFinalMatrix( viewport : Size2D, world : Matrix, view : Matrix, projection : Matrix ) : Matrix;
	public function Transpose( matrix : Matrix ) : Matrix;
	public function Reflection( plane : Plane ) : Matrix;
	public function ReflectionToRef( plane : Plane, result : Matrix ) : Void;
}
@:native("BABYLON.") extern class Plane {
	public var normal : Vector3;
	public var d : Float;
	public function new (a : Float, b : Float, c : Float, d : Float ) : Void;
	public function normalize(  ) : Void;
	public function transform( transformation : Matrix ) : Plane;
	public function dotCoordinate( point : Vector3 ) : Float;
	public function copyFromPoints( point1 : Vector3, point2 : Vector3, point3 : Vector3 ) : Void;
	public function isFrontFacingTo( direction : Vector3, epsilon : Vector3 ) : Bool;
	public function signedDistanceTo( point : Vector3 ) : Float;
	public function FromArray( array : Array<Float> ) : Plane;
	public function FromPoints( point1 : Vector3, point2 : Vector3, point3 : Vector3 ) : Plane;
	public function FromPositionAndNormal( origin : Vector3, normal : Vector2 ) : Plane;
	public function SignedDistanceToPlaneFromPositionAndNormal( origin : Vector3, normal : Vector3, point : Dynamic ) : Float;
}
@:native("BABYLON.") extern class Frustum {
	public var frustrumPlanes : Array<Plane>;
	public function new (transform : Matrix ) : Void;
	public function GetPlanes( transform : Matrix ) : Array<Plane>;
}
@:native("BABYLON.") extern class Tools {
	public var function : Dynamic;
	public function ExtractMinAndMax( positions : Array<Float>, start : Float, count : Float ) : Object;
	public function GetPointerPrefix(  ) : String;
	public function QueueNewFrame( func : Function ) : Void;
	public function RequestFullscreen( element : HTMLElement ) : Void;
	public function ExitFullscreen(  ) : Void;
	public var var : Dynamic;
	public var BaseUrl : String;
	public function LoadImage( url : String, onload : Function, onerror : Function, database : Database ) : HTMLImageElement;
	public function LoadFile( url : String, callback : Function, progressCallback : Function ) : Void;
	public function isIE(  ) : Bool;
	public function WithinEpsilon( a : Float, b : Float ) : Void;
	public function cloneValue( source : Object, destinationObject : Object ) : Void;
	public function DeepCopy( source : Object, destination : Object, doNotCopyList : Array<String>, mustCopyList : Array<String> ) : Void;
	public var fpsRange : Float;
	public var previousFramesDuration : Array<Float>;
	public function GetFps(  ) : Float;
	public function GetDeltaTime(  ) : Float;
	public function _MeasureFps(  ) : Void;
}
@:native("BABYLON.") extern class SmartArray {
	public var data : Array;
	public var length : Float;
	public function new (capacity : Float ) : Void;
	public function push( value : Object ) : Void;
	public function pushNoDuplicate( value : Object ) : Void;
	public function reset(  ) : Void;
	public function concat( array : SmartArray ) : Void;
	public function concatWithNoDuplicate( array : SmartArray ) : Void;
	public function indexOf( value : Object ) : Float;
}
@:native("BABYLON.") extern class SceneLoader {
	public function _ImportGeometry( parsedGeometry : Dynamic, mesh : Dynamic ) : Void;
	public function ImportMesh( meshName : String, rootUrl : String, sceneFilename : String, scene : Scene, then : Function ) : Void;
	public function Load( rootUrl : String, sceneFilename : String, engine : Engine, then : Function, progressCallback : Function ) : Void;
}
@:native("BABYLON.") extern class Database {
	public var currentSceneUrl : String;
	public var db : Database;
	public var enableSceneOffline : Bool;
	public var enableTexturesOffline : Bool;
	public var manifestVersionFound : Float;
	public var mustUpdateRessources : Bool;
	public var hasReachedQuota : Bool;
	public function new (urlToScene : String ) : Void;
	public var isUASupportingBlobStorage : Bool;
	public function parseURL( url : String ) : String;
	public function ReturnFullUrlLocation( url : String ) : String;
	public function checkManifestFile(  ) : Void;
	public function openAsync( successCallback : Function, errorCallback : Function ) : Void;
	public function loadImageFromDB( url : String, image : HTMLImageElement ) : Void;
	public function _loadImageFromDBAsync( url : String, image : HTMLImageElement, notInDBCallback : Function ) : Void;
	public function _saveImageIntoDBAsync( url : String, image : HTMLImageElement ) : Void;
	public function _checkVersionFromDB( url : String, versionLoaded : Float ) : Void;
	public function _loadVersionFromDBAsync( url : String, callback : Dynamic, updateInDBCallback : Function ) : Void;
	public function _saveVersionIntoDBAsync( url : String, callback : Function ) : Void;
	public function loadSceneFromDB( url : String, sceneLoaded : Scene, progressCallBack : Function ) : Void;
	public function _loadSceneFromDBAsync( url : String, callback : Function, notInDBCallback : Function ) : Void;
	public function _saveSceneFromDBAsync( url : String, callback : Function, progressCallback : Function ) : Void;
}
@:native("BABYLON.") extern class Animation {
	public var name : String;
	public var targetProperty : String;
	public var targetPropertyPath : Array<String>;
	public var framePerSecond : Float;
	public var dataType : String;
	public var loopMode : Float;
	public var _keys : Array<Float>;
	public var _offsetCache : Object;
	public var _highLimitsCache : Object;
	public function new (name : String, targetProperty : String, framePerSecond : Float, dataType : String, loopMode : Float ) : Void;
	public function clone(  ) : Animation;
	public function setKeys( values : Array<Float> ) : Void;
	public function _interpolate( currentFrame : Float, repeatCount : Float, loopMode : Float, offsetValue : Float, highLimitValue : Float ) : Void;
	public function animate( target : Object, delay : Float, from : Float, to : Float, loop : Bool, speedRatio : Float ) : Bool;
	public var ANIMATIONTYPE_FLOAT : Float;
	public var ANIMATIONTYPE_VECTOR3 : Float;
	public var ANIMATIONTYPE_QUATERNION : Float;
	public var ANIMATIONTYPE_MATRIX : Float;
	public var ANIMATIONLOOPMODE_RELATIVE : Float;
	public var ANIMATIONLOOPMODE_CYCLE : Float;
	public var ANIMATIONLOOPMODE_CONSTANT : Float;
}
@:native("BABYLON.") extern class _Animatable {
	public var target : Object;
	public var fromFrame : Float;
	public var toFrame : Float;
	public var loopAnimation : Bool;
	public var animationStartDate : Date;
	public var speedRatio : Float;
	public var onAnimationEnd : Function;
	public function new (target : Object, from : Float, to : Float, loop : Bool, speedRatio : Float, onAnimationEnd : Function ) : Void;
	public var animationStarted : Bool;
	public function _animate( delay : Float ) : Bool;
}
@:native("BABYLON.") extern class Bone {
	public var name : String;
	public var _skeleton : Skeleton;
	public var _matrix : Matrix;
	public var _baseMatrix : Matrix;
	public var _worldTransform : Matrix;
	public var _absoluteTransform : Matrix;
	public var _invertedAbsoluteTransform : Matrix;
	public var children : Array<Bone>;
	public var animation : Array<Animation>;
	public function new (name : String, skeleton : Skeleton, parentBone : Bone, matrix : Matrix ) : Void;
	public function getParent(  ) : Bone;
	public var getLocalMatrix : Matrix;
	public var getAbsoluteMatrix : Matrix;
	public function _updateDifferenceMatrix(  ) : Void;
	public function updateMatrix( matrix : Matrix ) : Void;
	public function markAsDirty(  ) : Void;
}
@:native("BABYLON.") extern class Skeleton {
	public var id : Float;
	public var name : String;
	public var bones : Array<Bone>;
	public var _scene : Scene;
	public var _isDirty : Bool;
	public function new (name : String, id : Float, scene : Scene ) : Void;
	public function getTransformMatrices(  ) : Array<Matrix>;
	public function prepare(  ) : Void;
	public function getAnimatables(  ) : Array<Animation>;
	public function clone( name : String, id : Float ) : Skeleton;
}
@:native("BABYLON.") extern class Camera {
	public var name : String;
	public var id : String;
	public var position : Vector3;
	public var _scene : Scene;
	public function new (name : String, position : Vector3, scene : Scene ) : Void;
	public var PERSPECTIVE_CAMERA : Float;
	public var ORTHOGRAPHIC_CAMERA : Float;
	public var fov : Float;
	public var orthoLeft : Float;
	public var orthoRight : Float;
	public var orthoBottom : Float;
	public var orthoTop : Float;
	public var minZ : Float;
	public var maxZ : Float;
	public var intertia : Float;
	public var mode : Float;
	public function attachControl( canvas : HTMLCanvasElement ) : Void;
	public function detachControl( canvas : HTMLCanvasElement ) : Void;
	public function _update(  ) : Void;
	public function getViewMatrix(  ) : Matrix;
	public function getProjectionMatrix(  ) : Matrix;
}
@:native("BABYLON.") extern class FreeCamera extends Camera {
	public var cameraDirection : Vector3;
	public var cameraRotation : Vector2;
	public var rotation : Vector3;
	public var ellipsoid : Vector3;
	public var _keys : Array<Float>;
	public var keysUp : Array<Float>;
	public var keysDown : Array<Float>;
	public var keysLeft : Array<Float>;
	public var keysRight : Array<Float>;
	public var _collider : Collider;
	public var _needsMoveForGravity : Bool;
	public var animations : Array<Animation>;
	public function new (name : String, position : Vector3, scene : Scene ) : Void;
	public var speed : Float;
	public var checkCollisions : Bool;
	public var applyGravity : Bool;
	public function _computeLocalCameraSpeed(  ) : Float;
	public function setTarget( target : Vector3 ) : Void;
	public function _collideWithWorld( velocity : Vector3 ) : Void;
	public function _checkInputs(  ) : Void;
}
@:native("BABYLON.") extern class ArcRotateCamera extends Camera {
	public var alpha : Float;
	public var beta : Float;
	public var radius : Float;
	public var target : Vector3;
	public var _keys : Array<Float>;
	public var keysUp : Array<Float>;
	public var keysDown : Array<Float>;
	public var keysLeft : Array<Float>;
	public var keysRight : Array<Float>;
	public var _viewMatrix : Matrix;
	public function new (name : String, alpha : Float, beta : Float, radius : Float, target : Vector3, scene : Scene ) : Void;
	public var inertialAlphaOffset : Float;
	public var interialBetaOffset : Float;
	public var lowerAlphaLimit : Float;
	public var upperAlphaLimit : Float;
	public var lowerBetaLimit : Float;
	public var upperBetaLimit : Float;
	public var lowerRadiusLimit : Float;
	public var upperRadiusLimit : Float;
	public function setPosition( position : Vector3 ) : Void;
}
@:native("BABYLON.") extern class DeviceOrientationCamera extends FreeCamera {
	public var angularSensibility : Float;
	public var moveSensibility : Float;
	public function new (name : String, position : Vector3, scene : Scene ) : Void;
	public var _offsetX : Float;
	public var _offsetY : Float;
	public var _orientationGamma : Float;
	public var _orientationBeta : Float;
	public var _initialOrientationGamma : Float;
	public var _initialOrientationBeta : Float;
}
@:native("BABYLON.") extern class TouchCamera extends FreeCamera {
	public var _offsetX : Float;
	public var _offsetY : Float;
	public var _pointerCount : Float;
	public var _pointerPressed : Array<Float>;
	public var angularSensibility : Float;
	public var moveSensibility : Float;
	public function new (name : String, position : Vector3, scene : Scene ) : Void;
}
typedef CollisionResponse = { public var position : Vector3; public var velocity : Vector3; };
@:native("BABYLON.") extern class Collider {
	public var radius : Vector3;
	public var retry : Float;
	public var basePointWorld : Vector3;
	public var velocityWorld : Vector3;
	public var normalizedVelocity : Vector3;
	public function new ( ) : Void;
	public function _initialize( source : Vector3, dir : Vector3, e : Float ) : Void;
	public function _checkPontInTriangle( point : Vector3, pa : Vector3, pb : Vector3, pc : Vector3, n : Vector3 ) : Bool;
	public function intersectBoxAASphere( boxMin : Vector3, boxMax : Vector3, sphereCenter : Vector3, sphereRadius : Float ) : Bool;
	public function getLowestRoot( a : Float, b : Float, c : Float, maxR : Float ) : Object;
	public function _canDoCollision( sphereCenter : Vector3, sphereRadius : Float, vecMin : Vector3, vecMax : Vector3 ) : Bool;
	public function _testTriangle( subMesh : SubMesh, p1 : Vector3, p2 : Vector3, p3 : Vector3 ) : Void;
	public function _collide( subMesh : SubMesh, pts : VertexBuffer, indices : IndexBuffer, indexStart : Float, indexEnd : Float, decal : Float ) : Void;
	public function _getResponse( pos : Vector3, vel : Vector3 ) : CollisionResponse;
}
@:native("BABYLON.") extern class CollisionPlane {
	public var normal : Vector3;
	public var origin : Vector3;
	public var equation : Array<Float>;
	public function new (origin : Vector3, normal : Vector3 ) : Void;
	public function isFrontFactingTo( direction : Vector3, epsilon : Float ) : Bool;
	public function signedDistanceTo( point : Vector3 ) : Float;
	public function CreateFromPoints( p1 : Vector3, p2 : Vector3, p3 : Vector3 ) : CollisionPlane;
}
@:native("BABYLON.") extern class BoundingBox {
	public var minimum : Vector3;
	public var maximum : Vector3;
	public var vectors : Array<Vector3>;
	public var center : Vector3;
	public var extends : Vector3;
	public var directions : Array<Vector3>;
	public var vectorsWorld : Array<Vector3>;
	public var minimumWorld : Vector3;
	public var maximumWorld : Vector3;
	public function new (minimum : Vector3, maximum : Vector3 ) : Void;
	public function _update( world : Matrix ) : Void;
	public function isInFrustrum( frustrumPlanes : Array<Plane> ) : Bool;
	public function intersectsPoint( point : Vector3 ) : Bool;
	public function intersectsSphere( sphere : Sphere ) : Bool;
	public function intersectsMinMax( min : Vector3, max : Vector3 ) : Bool;
	public function IsInFrustrum( boundingVectors : Array<Vector3>, frustrumPlanes : Array<Plane> ) : Bool;
	public function intersects( box0 : BoundingBox, box1 : BoundingBox ) : Bool;
}
@:native("BABYLON.") extern class BoundingInfo {
	public var boundingBox : BoundingBox;
	public var boundingSphere : BoundingSphere;
	public function new (minimum : Vector3, maximum : Dynamic, Vector3 : Dynamic ) : Void;
	public function _update( world : Matrix, scale : Float ) : Void;
	public function extentsOverlap( min0 : Dynamic, max0 : Dynamic, min1 : Dynamic, max1 : Dynamic ) : Bool;
	public function computeBoxExtents( axis : Vector3, box : BoundingBox ) : Object;
	public function axisOverlap( axis : Vector3, box0 : BoundingBox, box1 : BoundingBox ) : Bool;
	public function isInFrustrum( frustrumPlanes : Array<Plane> ) : Bool;
	public function _checkCollision( collider : Collider ) : Bool;
	public function intersectsPoint( point : Vector3 ) : Bool;
	public function intersects( boundingInfo : BoundingInfo, precise : Bool ) : Bool;
}
@:native("BABYLON.") extern class BoundingSphere {
	public var minimum : Vector3;
	public var maximum : Vector3;
	public var center : Vector3;
	public var radius : Float;
	public var distance : Float;
	public var centerWorld : Vector3;
	public function new (minimum : Vector3, maximum : Vector3 ) : Void;
	public function _update( world : Matrix, scale : Float ) : Void;
	public function isInFrustrum( frustrumPlanes : Array<Plane> ) : Bool;
	public function intersectsPoint( point : Vector3 ) : Bool;
	public function intersects( sphere0 : BoundingSphere, sphere1 : BoundingSphere ) : Bool;
}
@:native("BABYLON.") extern class Octree {
	public var blocks : Array<OctreeBlock>;
	public var _maxBlockCapacity : Float;
	public var _selection : Tools.SmartArray;
	public function new (maxBlockCapacity : Float ) : Void;
	public function update( worldMin : Vector3, worldMax : Vector3, meshes : Array<Mesh> ) : Void;
	public function addMesh( mesh : Mesh ) : Void;
	public function select( frustrumPlanes : Array<Plane> ) : Void;
	public function _CreateBlocks( worldMin : Vector3, worldMax : Vector3, meshes : Array<Mesh>, maxBlockCapacity : Float, target : OctreeBlock ) : Void;
}
@:native("BABYLON.") extern class OctreeBlock {
	public var subMeshes : Array<Mesh>;
	public var meshes : Array<Mesh>;
	public var _capacity : Float;
	public var _minPoint : Vector3;
	public var _maxPoint : Vector3;
	public var _boundingVector : Array<Vector3>;
	public function new (minPoint : Vector3, maxPoint : Vector3, capacity : Float ) : Void;
	public function addMesh( mesh : Mesh ) : Void;
	public function addEntries( meshes : Array<Mesh> ) : Void;
	public function select( frustrumPlanes : Array<Plane>, selection : Tools.SmartArray ) : Void;
}
@:native("BABYLON.") extern class Layer {
	public var name : String;
	public var texture : Texture;
	public var isBackground : Bool;
	public var color : Color4;
	public var _scene : Scene;
	public var vertices : Array<Float>;
	public var indicies : Array<Float>;
	public var _indexBuffer : IndexBuffer;
	public var _effect : Effect;
	public function new (name : String, imgUrl : String, scene : Scene, isBackground : Bool, color : Color4 ) : Void;
	public var onDispose : Void -> Void;
	public function render(  ) : Void;
	public function dispose(  ) : Void;
}
@:native("BABYLON.") extern class Light {
	public var name : String;
	public var id : String;
	public function new (name : String, scene : Scene ) : Void;
	public var intensity : Float;
	public var isEnabled : Bool;
	public function getScene(  ) : Scene;
	public var getShadowGenerator : ShadowGenerator;
	public function dispose(  ) : Void;
}
@:native("BABYLON.") extern class PointLight extends Light {
	public var position : Vector3;
	public var diffuse : Color3;
	public var specular : Color3;
	public var animations : Array<Animation>;
	public function new (name : String, position : Vector3, scene : Scene ) : Void;
}
@:native("BABYLON.") extern class SpotLight {
	public var position : Vector3;
	public var direction : Vector3;
	public var angle : Float;
	public var exponent : Float;
	public var diffuse : Color3;
	public var specular : Color3;
	public var animations : Array<Animation>;
	public function new (name : String, position : Vector3, direction : Vector3, angle : Float, exponsent : Float, scene : Scene ) : Void;
}
@:native("BABYLON.") extern class HemisphericLight {
	public var direction : Vector3;
	public var diffuse : Color3;
	public var specular : Color3;
	public var groundColor : Color3;
	public var animations : Array<Animation>;
	public function new (name : String, direction : Vector3, scene : Scene ) : Void;
	public function getShadowGenerator(  ) : Void;
}
@:native("BABYLON.") extern class DirectionalLight extends Light {
	public var direction : Vector3;
	public var animations : Array<Animation>;
	public var position : Vector3;
	public var diffuse : Color3;
	public var specular : Color3;
	public function new (name : String, direction : Vector3, scene : Scene ) : Void;
}
@:native("BABYLON.") extern class ShadowGenerator {
	public var _light : Light;
	public var _scene : Scene;
	public var _shadowMap : RenderTargetTexture;
	public function new (mapSize : Float, light : Light ) : Void;
	public function renderSubMesh( subMesh : Mesh ) : Void;
	public var useVarianceShadowMap : Bool;
	public function isReady( mesh : Mesh ) : Bool;
	public function getShadowMap(  ) : RenderTargetTexture;
	public function getLight(  ) : Light;
	public function getTransformMatrix(  ) : Matrix;
	public function dispose(  ) : Void;
}
@:native("BABYLON.") extern class Effect {
	public var name : String;
	public var defines : String;
	public function new (baseName : String, attributesNames : Array<String>, uniformsNames : Array<String>, samplers : Array<WebGLUniformLocation>, engine : Engine, defines : String ) : Void;
	public function isReady(  ) : Bool;
	public function getProgram(  ) : WebGLProgram;
	public function getAttribute( index : Float ) : String;
	public function getAttributesNames(  ) : String;
	public function getAttributesCount(  ) : Float;
	public function getUniformIndex( uniformName : String ) : Float;
	public function getUniform( uniformName : String ) : String;
	public function getSamplers(  ) : Array<WebGLUniformLocation>;
	public function getCompilationError(  ) : String;
	public function _prepareEffect( vertexSourceCode : String, fragmentSourceCode : String, attributeNames : Array<String>, defines : String ) : Void;
	public function setTexture( channel : String, texture : Texture ) : Void;
	public function setMatrices( uniformName : String, matrices : Array<Matrix> ) : Void;
	public function setMatrix( uniformName : String, matrix : Matrix ) : Void;
	public function setBool( uniformName : String, val : Bool ) : Void;
	public function setVector3( uniformName : String, val : Vector3 ) : Void;
	public function setFloat2( uniformName : String, x : Float, y : Float ) : Void;
	public function setFloat3( uniformName : String, x : Float, y : Float, z : Float ) : Void;
	public function setFloat4( uniformName : String, x : Float, y : Float, z : Float, w : Float ) : Void;
	public function setColor3( uniformName : String, color : Color3 ) : Void;
	public function setColor4( uniformName : String, color : Color4 ) : Void;
	public var ShadersStore : Object;
}
@:native("BABYLON.") extern class Material {
	public var name : String;
	public var id : String;
	public function new (name : String, scene : Scene ) : Void;
	public var checkReadyOnEveryCall : Bool;
	public var alpha : Float;
	public var wireframe : Bool;
	public var backFaceCulling : Bool;
	public var _effect : Effect;
	public var onDispose : Void -> Void;
	public function isReady(  ) : Bool;
	public function getEffect(  ) : Effect;
	public function needAlphaBlending(  ) : Bool;
	public function needAlphaTesting(  ) : Bool;
	public function _preBind(  ) : Void;
	public function bind( world : Matrix, mesh : Mesh ) : Void;
	public function unbind(  ) : Void;
	public function baseDispose(  ) : Void;
	public function dispose(  ) : Void;
}
@:native("BABYLON.") extern class MultiMaterial extends Material {
	public var subMaterials : Array<Material>;
	public function new (name : String, scene : Scene ) : Void;
	public function getSubMaterial( index : Float ) : Material;
}
@:native("BABYLON.") extern class StandardMaterial extends Material {
	public var diffuseTexture : Texture;
	public var ambientTexture : Texture;
	public var opacityTexture : Texture;
	public var reflectionTexture : Texture;
	public var emissiveTexture : Texture;
	public var specularTexture : Texture;
	public var bumpTexture : Texture;
	public var ambientColor : Color3;
	public var diffuseColor : Color3;
	public var specularColor : Color3;
	public var specularPower : Float;
	public var emissiveColor : Color3;
	public function getRenderTargetTextures(  ) : Array<Texture>;
	public function getAnimatables(  ) : Array<Texture>;
	public function clone( name : String ) : StandardMaterial;
}
@:native("BABYLON.") extern class BaseTexture {
	public var _scene : Scene;
	public function new (url : String, scene : Scene ) : Void;
	public var delayLoadState : Float;
	public var hasAlpha : Bool;
	public var level : Float;
	public var onDispose : Void -> Void;
	public function getInternalTexture(  ) : BaseTexture;
	public function isReady(  ) : Bool;
	public function getSize(  ) : Size2D;
	public function getBaseSize(  ) : Size2D;
	public function _getFromCache( url : String, noMipmap : Bool ) : BaseTexture;
	public function delayLoad(  ) : Void;
	public function releaseInternalTexture(  ) : Void;
	public function dispose(  ) : Void;
}
@:native("BABYLON.") extern class Texture extends BaseTexture {
	public var name : String;
	public var url : String;
	public var animations : Array<Animation>;
	public function new (url : String, scene : Scene, noMipmap : Bool, invertY : Bool ) : Void;
	public var EXPLICIT_MODE : Float;
	public var SPHERICAL_MODE : Float;
	public var PLANAR_MODE : Float;
	public var CUBIC_MODE : Float;
	public var PROJECTION_MODE : Float;
	public var SKYBOX_MODE : Float;
	public var CLAMP_ADDRESSMODE : Float;
	public var WRAP_ADDRESSMODE : Float;
	public var MIRROR_ADDRESSMODE : Float;
	public var uOffset : Float;
	public var vOffset : Float;
	public var uScale : Float;
	public var vScale : Float;
	public var uAng : Float;
	public var vAng : Float;
	public var wAng : Float;
	public var wrapU : Float;
	public var wrapV : Float;
	public var coordinatesIndex : Float;
	public var coordinatesMode : Float;
	public function _prepareRowForTextureGeneration( t : Vector3 ) : Vector3;
	public function _computeTextureMatrix(  ) : Matrix;
	public var _computeReflectionTextureMatrix : Matrix;
	public function clone(  ) : Texture;
}
@:native("BABYLON.") extern class CubeTexture extends BaseTexture {
	public function new (rootUrl : String, scene : Scene ) : Void;
	public var isCube : Bool;
	public function _computeReflectionTextureMatrix(  ) : Matrix;
}
@:native("BABYLON.") extern class DynamicTexture extends Texture {
	public var _canvas : HTMLCanvasElement;
	public var _context : CanvasRenderingContext2D;
	public function new (name : String, size : Size2D, scene : Scene, generateMipMaps : Bool ) : Void;
	public function getContext(  ) : CanvasRenderingContext2D;
	public function drawText( text : String, x : Float, y : Float, font : String, color : String, clearColor : String, invertY : Bool ) : Void;
	public function update(  ) : Void;
}
@:native("BABYLON.") extern class RenderTargetTexture extends Texture {
	public function new (name : String, size : Size2D, scene : Scene, generateMipMaps : Bool ) : Void;
	public var renderList : Array<Dynamic>;
	public var isRenderTarget : Bool;
	public var coordinatesMode : Float;
	public var renderParticles : Bool;
	public var _onBeforeRender : Void -> Void;
	public var _onAfterRender : Void -> Void;
	public function resize( size : Size2D, generateMipMaps : Bool ) : Void;
	public function render(  ) : Void;
}
@:native("BABYLON.") extern class MirrorTexture extends RenderTargetTexture {
	public function new (name : String, size : Size2D, scene : Scene, generateMipMaps : Bool ) : Void;
	public var mirrorPlane : Plane;
	public function onBeforeRender(  ) : Void;
	public function onAfterRender(  ) : Void;
}
@:native("BABYLON.") extern class VideoTexture extends Texture {
	public function new (name : String, urls : Array<String>, size : Size2D, scene : Scene, generateMipMaps : Bool ) : Void;
	public var video : HTMLVideoElement;
	public var _autoLaunch : Bool;
	public var textureSize : Size2D;
	public function _update(  ) : Bool;
}
typedef MeshRayHitTest = { public var hit : Bool; public var distance : Float; };
@:native("BABYLON.") extern class Mesh {
	public var name : String;
	public var id : String;
	public var position : Vector3;
	public var rotation : Vector3;
	public var scaling : Vector3;
	public var rotationQuaternion : Quaternion;
	public var subMeshes : Array<SubMesh>;
	public var animations : Array<Animation>;
	public function new (name : String, vertexDeclaration : Array<Float>, scene : Scene ) : Void;
	public var BILLBOARDMODE_NONE : Float;
	public var BILLBOARDMODE_X : Float;
	public var BILLBOARDMODE_Y : Float;
	public var BILLBOARDMODE_Z : Float;
	public var BILLBOARDMODE_ALL : Float;
	public var delayLoadState : Bool;
	public var material : Material;
	public var parent : Mesh;
	public var _isReady : Bool;
	public var _isEnabled : Bool;
	public var isVisible : Bool;
	public var isPickable : Bool;
	public var visibility : Float;
	public var billboardMode : Float;
	public var checkCollisions : Bool;
	public var receiveShadows : Bool;
	public var isDisposed : Bool;
	public var onDispose : Void -> Void;
	public var skeleton : Skeleton;
	public var renderingGroupId : Float;
	public function getBoundingInfo(  ) : BoundingInfo;
	public function getScene(  ) : Scene;
	public var getWorldMatrix : Matrix;
	public var getTotalVertices : Float;
	public function getVerticesData( kind : String ) : Array<Dynamic>;
	public function isVerticesDataPresent( kind : String ) : Bool;
	public function getTotalIndicies(  ) : Float;
	public function getIndices(  ) : Array<Float>;
	public function getVertexStrideSize(  ) : Float;
	public function _needToSynchronizeChildren(  ) : Bool;
	public function setPivotMatrix( matrix : Matrix ) : Void;
	public function getPivotMatrix(  ) : Matrix;
	public function isSynchronized(  ) : Bool;
	public function isReady(  ) : Bool;
	public function isEnabled(  ) : Bool;
	public function setEnabled( value : Bool ) : Void;
	public function isAnimated(  ) : Bool;
	public function markAsDirty( property : String ) : Void;
	public function refreshBoudningInfo(  ) : Void;
	public function computeWorldMatrix(  ) : Matrix;
	public function _createGlobalSubMesh(  ) : SubMesh;
	public function subdivide( count : Float ) : Void;
	public function setVerticesData( data : Array<Dynamic>, kind : String, updatable : Bool ) : Void;
	public function updateVerticesData( kind : String, data : Array<Dynamic> ) : Void;
	public function setIndices( indices : Array<Float> ) : Void;
	public function bindAndDraw( subMesh : SubMesh, effect : Effect, wireframe : Bool ) : Void;
	public function registerBeforeRender( func : Function ) : Void;
	public function unregisterBeforeRender( func : Function ) : Void;
	public function render( subMesh : SubMesh ) : Void;
	public function isDescendantOf( ancestor : Mesh ) : Bool;
	public function getDescendants(  ) : Array<Mesh>;
	public function getEmittedParticleSystems(  ) : Array<ParticleSystem>;
	public function getHierarchyEmittedParticleSystems(  ) : Array<ParticleSystem>;
	public function getChildren(  ) : Array<Mesh>;
	public function isInFrustrum( frustumPlanes : Array<Plane> ) : Bool;
	public function setMaterialByID( id : String ) : Void;
	public function getAnimatables(  ) : Material;
	public function setLocalTranslation( vector3 : Vector3 ) : Void;
	public function getLocalTranslation(  ) : Vector3;
	public function bakeTransformIntoVertices( transform : Matrix ) : Void;
	public function intersectsMesh( mesh : Mesh, precise : Bool ) : Bool;
	public function intersectsPoint( point : Vector3 ) : Bool;
	public function intersects( ray : Ray ) : MeshRayHitTest;
	public function clone( name : String, newParent : Mesh ) : Mesh;
	public function dispose(  ) : Void;
	public function CreateBox( name : String, size : Float, scene : Scene ) : Mesh;
	public function CreateCylinder( name : String, height : Float, diameterTop : Float, diameterBottom : Float, tessellation : Float, scene : Scene, updatable : Bool ) : Mesh;
	public function CreateTorus( name : String, diameter : Float, thickness : Float, tessellation : Float, scene : Scene, updatable : Bool ) : Mesh;
	public function CreateSphere( name : String, segments : Float, diameter : Float, scene : Scene ) : Mesh;
	public function CreatePlane( name : String, size : Float, scene : Scene ) : Mesh;
	public function CreateGround( name : String, width : Float, height : Float, subdivisions : Float, scene : Scene, updatable : Bool ) : Mesh;
	public function CreateGroundFromHeightMap( name : String, url : String, width : Float, height : Float, subdivisions : Float, minHeight : Float, maxHeight : Float, scene : Scene, updatable : Bool ) : Mesh;
	public function ComputeNormal( positions : Array<Float>, normals : Array<Float>, indices : Array<Float> ) : Void;
}
@:native("BABYLON.") extern class SubMesh {
	public var materialIndex : Float;
	public var verticesStart : Float;
	public var verticesCount : Float;
	public var indexStart : Float;
	public var indexCount : Float;
	public function new (materialIndex : Float, verticesStart : Float, verticesCount : Float, indexStart : Float, indexCount : Float, mesh : Mesh ) : Void;
	public function getBoundingInfo(  ) : BoundingInfo;
	public function getMaterial(  ) : Material;
	public function refreshBoundingInfo(  ) : Void;
	public function updateBoundingInfo( world : Matrix, scale : Vector3 ) : Void;
	public function isInFrustrum( frustumPlanes : Array<Plane> ) : Bool;
	public function render(  ) : Void;
	public function getLinesIndexBuffer( indices : Array<Float>, engine : Engine ) : IndexBuffer;
	public function canIntersects( ray : Ray ) : Bool;
	public function intersects( ray : Ray, positions : Array<Vector3>, indices : Array<Float> ) : MeshRayHitTest;
	public function clone( newMesh : Mesh ) : SubMesh;
	public function CreateFromIndices( materialIndex : Float, startIndex : Float, indexCount : Float, mesh : Mesh ) : SubMesh;
}
@:native("BABYLON.") extern class VertexBuffer {
	public function new (mesh : Mesh, data : Array<Dynamic>, kind : String, updatable : Bool ) : Void;
	public function isUpdatable(  ) : Bool;
	public function getData(  ) : Array<Dynamic>;
	public function getStrideSize(  ) : Float;
	public function update( data : Array<Dynamic> ) : Void;
	public function dispose(  ) : Void;
	public var PositionKind : String;
	public var NormalKind : String;
	public var UVKind : String;
	public var UV2Kind : String;
	public var ColorKind : String;
	public var MatricesIndicesKind : String;
	public var MatricesWeightsKind : String;
}
@:native("BABYLON.") extern class Particle {
	public var position : Vector3;
	public var direction : Vector3;
	public var lifetime : Float;
	public var age : Float;
	public var size : Float;
	public var angle : Float;
	public var angularSpeed : Float;
	public var color : Color4;
	public var colorStep : Color4;
	public function new ( ) : Void;
}
@:native("BABYLON.") extern class ParticleSystem {
	public var name : String;
	public var id : String;
	public var gravity : Vector3;
	public var direction1 : Vector3;
	public var direction2 : Vector3;
	public var minEmitBox : Vector3;
	public var maxEmitBox : Vector3;
	public var color1 : Color4;
	public var color2 : Color4;
	public var colorDead : Color4;
	public var deadAlpha : Float;
	public var textureMask : Color4;
	public var particles : Array<Particle>;
	public var indices : Array<Float>;
	public var renderingGroupId : Float;
	public var emitter : Dynamic;
	public var emitRate : Float;
	public var manualEmitCount : Float;
	public var updateSpeed : Float;
	public var targetStopDuration : Float;
	public var disposeOnStop : Bool;
	public var minEmitPower : Float;
	public var maxEmitPower : Float;
	public var minLifeTime : Float;
	public var maxLifeTime : Float;
	public var minSize : Float;
	public var maxSize : Float;
	public var minAngularSpeed : Float;
	public var maxAngularSpeed : Float;
	public var particleTexture : Texture;
	public var onDispose : Void -> Void;
	public var blendMode : Float;
	public function new (name : String, capacity : Float, scene : Scene ) : Void;
	public function isAlive(  ) : Bool;
	public function start(  ) : Void;
	public function stop(  ) : Void;
	public function animate(  ) : Void;
	public function render(  ) : Float;
	public function dispose(  ) : Void;
	public function clone( name : String, newEmitter : Dynamic ) : ParticleSystem;
	public var BLENDMODE_ONEONE : Float;
	public var BLENDMODE_STANDARD : Float;
}
@:native("BABYLON.") extern class PostProcess {
 
}
@:native("BABYLON.") extern class PostProcessManager {
	public function new ( ) : Void;
	public var postProcesses : Array<Dynamic>;
}
@:native("BABYLON.Sprite") extern class Sprite {
	public var name : String;
	public var color : Color4;
	public var position : Vector3;
	public var size : Float;
	public var angle : Float;
	public var cellIndex : Float;
	public var invertU : Float;
	public var invertV : Float;
	public var disposeWhenFinishedAnimating : Bool;
	public function new (name : String, manager : SpriteManager ) : Void;
	public function playAnimation( from : Float, to : Float, loop : Bool, delay : Float ) : Void;
	public function stopAnimation(  ) : Void;
	public function dispose(  ) : Void;
}
@:native("BABYLON.") extern class SpriteManager {
	public var name : String;
	public var cellSize : Float;
	public function new (name : String, imgUrl : String, capacity : Float, cellSize : Float, scene : Scene, epsilon : Float ) : Void;
	public var indicies : Array<Float>;
	public var index : Float;
	public var sprites : Array<Sprite>;
	public var onDispose : Void -> Void;
	public function render(  ) : Void;
	public function dispose(  ) : Void;
}