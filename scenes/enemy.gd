extends CharacterBody2D
@onready var sprite_2d = $Sprite2D
@onready var player = get_node("../../Player")
var death = false


var in_range = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var SPEED = 200
var JUMP = 1000

func _physics_process(delta):
		
	if not is_on_floor():
		velocity.y += gravity * delta
	if in_range:
		var direction = (player.position - self.position).normalized()
		velocity.x = direction.x * SPEED
		if is_on_floor():
			velocity.y = direction.y * JUMP
	else:
		velocity.x = 0
	if death == true:
		sprite_2d.play("death")
		get_node("PlayerCollision").monitoring = false
		get_node("CollisionShape2D").disabled = true
		await(sprite_2d.animation_finished)
		queue_free()
		
	
	move_and_slide()
	Animations(velocity)
	
func Animations(velocity):
	if velocity.y <0:
		sprite_2d.play("jump")
	elif velocity.y >0:
		sprite_2d.play("fall")
	elif velocity.x >0:
		sprite_2d.flip_h = false
		sprite_2d.play("run")
	elif velocity.x < 0:
		sprite_2d.flip_h = true
		sprite_2d.play("run")
	else:
		sprite_2d.play("default")

func DeathAnimation():
	sprite_2d.play("death")

func _on_detection_body_entered(body):
	if(body.name == "Player"):
		in_range = true
		

func _on_detection_body_exited(body):
	if(body.name == "Player"):
		in_range = false


func _on_death_detection_body_entered(body):
	if(body.name == "Player"):
		death = true
		

func _on_player_collision_body_entered(body):
	if(body.name == "Player"):
		get_tree().change_scene_to_file("res://death.tscn")
