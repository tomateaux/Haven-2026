extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
var remaining_lives: int = 5
var is_dead: bool = false

@export var Corpse : PackedScene
@export var lives_container : HBoxContainer
@onready var init_position: Vector2 = global_position


func _ready() -> void:
	$SpawnSound.play()


func die() -> void:
	$DieSound.play(0.21)
	remaining_lives -= 1
	lives_container.update_health(remaining_lives)
	hide()
	
	# Game over when no lives remain, otherwise respawn.
	if remaining_lives == 0:
		print("Game over")
		set_physics_process(false)
		$"../CanvasLayer/GameOverLabel".show()
	else:
		await get_tree().create_timer(0.4).timeout
		global_position = init_position
		show()
		$SpawnSound.play()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$JumpSound.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		#$WalkSound.play()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Animation
	if Input.is_action_pressed("ui_left"):
		$Fill.play("walk_left")
		$Outline.play("walk_left")
	elif Input.is_action_pressed("ui_right"):
		$Fill.play("walk_right")
		$Outline.play("walk_right")
	else:
		$Fill.stop()
		$Outline.stop()
	
	# Die.
	if Input.is_action_just_pressed("die"):
		#print("Player died.")
		var c = Corpse.instantiate()
		owner.add_child(c)
		c.global_position = global_position
		die()
	
	if global_position.y > 1000 and not is_dead:
		is_dead = true
		die()
		await get_tree().create_timer(0.5).timeout
		is_dead = false
	
	var was_on_floor := is_on_floor()

	move_and_slide()

	if not was_on_floor and is_on_floor():
		$FallSound.play(0.58)
