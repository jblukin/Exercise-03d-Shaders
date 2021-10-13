extends Node2D

export (String) var color
var VP = null
var is_matched
var is_counted
var selected = false
var target_position = Vector2.ZERO

var Effects = null
var dying = false
var wiggle = 0.0
export var wiggle_amount = 3

export var transparent_time = 1.0
export var scale_time = 1.5
export var rot_time = 1.5



func _ready():
	VP = get_viewport().size
	$Select.texture = $Sprite.texture
	$Select.scale = $Sprite.scale	

func _physics_process(_delta):
	if dying and not $Tween.is_active():
		queue_free()
	elif position != target_position and not $Tween.is_active():
		position = target_position
	if selected:
		$Select.show()
		$Selected.emitting = true
	else:
		$Select.hide()
		$Selected.emitting = false

func generate(pos):
	target_position = pos

func move_piece(change):
	target_position = target_position + change

func die():
	dying = true;
	if Effects == null:
		Effects = get_node_or_null("/root/Game/Effects")
	if Effects != null:
		get_parent().remove_child(self)
		Effects.add_child(self)
		var new_position = Vector2(target_position.x,VP.y + 100)
		$Tween.interpolate_property(self, "position",target_position,new_position,randf()*2.0,Tween.TRANS_EXPO,Tween.EASE_IN,randf()*0.2)
		$Tween.start()
		$Dying.show()
