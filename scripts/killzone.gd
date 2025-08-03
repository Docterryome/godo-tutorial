extends Area2D


@onready var timer: Timer = $Timer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D



func _on_body_entered(body: Node2D) -> void:
	Engine.time_scale = 0.5
	var player: AnimatedSprite2D = body.get_node("AnimatedSprite2D")
	player.animation = "death"
	timer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
