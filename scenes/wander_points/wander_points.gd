extends Node

var currentTarget:Node2D = null
var previousTarget:Node2D = null

func getNextTarget():
	previousTarget = currentTarget
	while currentTarget == previousTarget:
		var target =  randi_range(0, get_child_count() - 1)
		currentTarget = get_child(target)
	print("Next target found: ", currentTarget, " previous target: ", previousTarget)
	return currentTarget
