class_name AutoScroll
extends CameraControllerBase

@export var top_left := Vector2(-7.5, -7.5)
@export var bottom_right := Vector2(7.5, 7.5)
@export var autoscroll_speed := Vector3(15.0, 0.0, 0.0)

func _ready() -> void:
	super()
	position = target.position
	

func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
		
	var camera_movement = autoscroll_speed * delta
	
	global_transform.origin += camera_movement
	target.global_transform.origin += camera_movement
		
	var cpos = global_transform.origin
	
	var rect_min_x = cpos.x + top_left[0]
	var rect_max_x = cpos.x + bottom_right[0]
	var rect_min_z = cpos.z + top_left[1]
	var rect_max_z = cpos.z + bottom_right[1]
	
	var tpos = target.global_transform.origin
	
	if tpos.x < rect_min_x:
		tpos.x = rect_min_x
	elif tpos.x > rect_max_x:
		tpos.x = rect_max_x
	
	if tpos.z < rect_min_z:
		tpos.z = rect_min_z
	elif tpos.z > rect_max_z:
		tpos.z = rect_max_z
	
	target.global_transform.origin = tpos
		
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left: float = top_left[0]
	var right: float = bottom_right[0]
	var top: float = top_left[1]
	var bottom: float = bottom_right[1]
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right, 0.0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0.0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(right, 0.0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0.0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0.0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0.0, top))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0.0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0.0, top))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	# mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
