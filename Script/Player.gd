extends CharacterBody2D
@onready var animation = $Animations


const SPEED = 400.0
const JUMP_VELOCITY = -900.0

#make all variable at top (var)
var start_position = Vector2(600,780)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#playing walking animations
func _ready():
	animation.play("Walking")
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		animation.play('Walking')



#respawn
	if position.y > 900:
		position = start_position
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation.play('Jumping')


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if(direction >0):
		animation.flip_h = true
	elif(direction <0):
		animation.flip_h = false
	move_and_slide()


  
