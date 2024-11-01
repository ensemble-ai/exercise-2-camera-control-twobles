class_name SpeedUp
extends CameraControllerBase

@export var push_ratio: float = target.BASE_SPEED * 0.5
@export var pushbox_top_left := Vector2(-7.0, -7.0)
@export var pushbox_bottom_right := Vector2(7.0, 7.0)
@export var speedup_zone_top_left := Vector2(-4.0, -4.0)
@export var speedup_zone_bottom_right := Vector2(4.0, 4.0)

@onready var box_width: float =  pushbox_bottom_right.x - pushbox_top_left.x
@onready var box_height: float = pushbox_bottom_right.y - pushbox_top_left.y

var _reposition: bool = true

func _ready() -> void:
	super()
	
	position = target.position


func _process(delta: float) -> void:
	if !current:
		_reposition = true
		return
		
	if _reposition:
		position = target.position
		_reposition = false
	
	if draw_camera_logic:
		draw_logic()
			
	var cpos = global_transform.origin
	
	var pushbox_min_x = cpos.x + pushbox_top_left[0]
	var pushbox_max_x = cpos.x + pushbox_bottom_right[0]
	var pushbox_min_z = cpos.z + pushbox_top_left[1]
	var pushbox_max_z = cpos.z + pushbox_bottom_right[1]
	
	var speedup_min_x = cpos.x + speedup_zone_top_left[0]
	var speedup_max_x = cpos.x + speedup_zone_bottom_right[0]
	var speedup_min_z = cpos.z + speedup_zone_top_left[1]
	var speedup_max_z = cpos.z + speedup_zone_bottom_right[1]
	
	var tpos = target.global_transform.origin
	
	var target_left = tpos.x + target.WIDTH / 2.0
	var target_right = tpos.x - target.WIDTH / 2.0
	var target_top = tpos.z + target.WIDTH / 2.0
	var target_bottom = tpos.z - target.WIDTH / 2.0
	
	var moving_left: bool = target.velocity.x < 0
	var moving_right: bool = target.velocity.x > 0
	var moving_up: bool = target.velocity.z < 0
	var moving_down: bool = target.velocity.z > 0
	
	if target_left < speedup_min_x:
		if (moving_left):
			cpos.x -= push_ratio * delta
	elif target_right > speedup_max_x:
		if (moving_right):
			cpos.x += push_ratio * delta
	
	if target_top < speedup_min_z:
		if (moving_up):
			cpos.z -= push_ratio * delta
	elif target_bottom > speedup_max_z:
		if (moving_down):
			cpos.z += push_ratio * delta
		
	if target_left < pushbox_min_x:
		cpos.x -= target.BASE_SPEED * delta
	elif target_right > pushbox_max_x:
		cpos.x += target.BASE_SPEED * delta
	
	if target_top < pushbox_min_z:
		cpos.z -= target.BASE_SPEED * delta
	elif target_bottom > pushbox_max_z:
		cpos.z += target.BASE_SPEED * delta
		
	global_transform.origin = cpos
			
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var pushbox_left: float = pushbox_top_left[0]
	var pushbox_right: float = pushbox_bottom_right[0]
	var pushbox_top: float = pushbox_top_left[1]
	var pushbox_bottom: float = pushbox_bottom_right[1]
	
	var speedup_left: float = speedup_zone_top_left[0]
	var speedup_right: float = speedup_zone_bottom_right[0]
	var speedup_top: float = speedup_zone_top_left[1]
	var speedup_bottom: float = speedup_zone_bottom_right[1]
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(pushbox_right, 0.0, pushbox_top))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_right, 0.0, pushbox_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(pushbox_right, 0.0, pushbox_bottom))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_left, 0.0, pushbox_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(pushbox_left, 0.0, pushbox_bottom))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_left, 0.0, pushbox_top))
	
	immediate_mesh.surface_add_vertex(Vector3(pushbox_left, 0.0, pushbox_top))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_right, 0.0, pushbox_top))
	
	
	immediate_mesh.surface_add_vertex(Vector3(speedup_right, 0.0, speedup_top))
	immediate_mesh.surface_add_vertex(Vector3(speedup_right, 0.0, speedup_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(speedup_right, 0.0, speedup_bottom))
	immediate_mesh.surface_add_vertex(Vector3(speedup_left, 0.0, speedup_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(speedup_left, 0.0, speedup_bottom))
	immediate_mesh.surface_add_vertex(Vector3(speedup_left, 0.0, speedup_top))
	
	immediate_mesh.surface_add_vertex(Vector3(speedup_left, 0.0, speedup_top))
	immediate_mesh.surface_add_vertex(Vector3(speedup_right, 0.0, speedup_top))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	# mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
