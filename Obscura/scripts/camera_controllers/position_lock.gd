class_name PositionLock
extends CameraControllerBase

@export var crosshair_width: float = 5.0
@export var crosshair_height: float = 5.0


func _ready() -> void:
	super()
	position = target.position


func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
		
	global_position = target.position
	
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var adjusted_width = crosshair_width / 2.0
	var adjusted_height = crosshair_height / 2.0
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(adjusted_width, 0.0, 0.0))
	immediate_mesh.surface_add_vertex(Vector3(-adjusted_width, 0.0, 0.0))
	
	immediate_mesh.surface_add_vertex(Vector3(0.0, 0.0, adjusted_height))
	immediate_mesh.surface_add_vertex(Vector3(0.0, 0.0, -adjusted_height))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	# mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
