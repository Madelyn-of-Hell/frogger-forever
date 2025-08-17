extends Control

func _set_score(score:int):
	$Panel/Score.set_text("%s" % score)
