extends Node

@onready var points_label = $"../UI/PointsPanel/PointsLabel"


var point = 0

func add_points():
	point += 1
	points_label.text = "Points: " + str(point)
	
func get_point():
	return point


