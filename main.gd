extends Node

@export var mob_scene: PackedScene
var score


func game_over():
	$score_timer.stop()
	$mob_timer.stop()
	
	$HUD.show_game_over()
	print("tester")
	
func new_game():
	
	score = 0
	$player.start($start_position.position)
	$start_timer.start()
	
	$HUD.update_score(score)
	$HUD.show_message("Get ready!")
	get_tree().call_group("mobs", "queue_free")
	

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)
	
func _on_start_timer_timeout():
	$mob_timer.start()
	$score_timer.start()
	
func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	var mob_spawn_location = get_node("mob_path/mob_spawn_location")
	mob_spawn_location.progress_ratio = randf()
	
	var direction = mob_spawn_location.rotation + PI / 2
	
	mob.position = mob_spawn_location.position
	
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
	
	
