@tool

extends Node3D
class_name CarMover

@onready var path : Path3D = %ExportPath
@onready var car_proxy: Node3D = %car_proxy

var animation_speed : float = 0.25
var preview_car_interp : float = 0.0
var curve : Curve3D = null
var length : float
var track_transform : Transform3D

func _ready() -> void:
	curve = path.curve
	length = curve.get_baked_length()

func _process(delta: float) -> void:
	preview_car_interp += animation_speed * delta
	if preview_car_interp > 1.0:
		preview_car_interp = 0.0
	move_car()

func move_car() -> void:
	var car_t : Transform3D = curve.sample_baked_with_rotation(preview_car_interp * length, false, false)
	
	car_proxy.global_transform = global_transform * car_t
