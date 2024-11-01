class_name CatchUp
extends CameraControllerBase

@export var follow_speed: float = target.BASE_SPEED * 0.5
@export var catchup_speed: float = target.BASE_SPEED
@export var leash_distance: float = 5.0

@export var crosshair_width: float = 5.0
@export var crosshair_height: float = 5.0

var _reposition: bool = true

func _ready() -> void:
	super()
	position = target.position


func _physics_process(delta: float) -> void:
	var tpos = target.global_transform.origin
	var cpos = global_transform.origin
	
	var tpos_2d = Vector2(tpos.x, tpos.z)
	var cpos_2d = Vector2(cpos.x, cpos.z)
	
	var distance_to_target = cpos_2d.distance_to(tpos_2d)
	var leash_pos = tpos + target.velocity.normalized() * leash_distance
	
	if is_zero_approx(target.velocity.length()):
		global_transform.origin = _linear_interpolate(tpos, catchup_speed * delta)
	elif distance_to_target < leash_distance:
		global_transform.origin = _linear_interpolate(tpos, follow_speed * delta)
	else:
		global_transform.origin = _linear_interpolate(leash_pos, catchup_speed * delta)
				

func _process(delta: float) -> void:
	if !current:
		_reposition = true
		return
		
	if _reposition:
		position = target.position
		_reposition = false
	
	if draw_camera_logic:
		draw_logic()
	
	super(delta)
	
	
func _linear_interpolate(final_position: Vector3, interval: float) -> Vector3:
	var adjusted_final_position = Vector3(final_position.x, position.y, final_position.z)
	var direction = (adjusted_final_position - global_transform.origin).normalized()
	
	var new_position = global_transform.origin + direction * interval
	
	if (new_position - adjusted_final_position).length() < interval:
		return final_position
	else:
		return new_position


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
