extends Camera2D

var shake_power = 12
var shake_time = 0.5
var isShake = false
var curPos
var elapsedtime = 0
var shake_power2 = 5
var shake_time2 = 0.2
var isShake2 = false
var elapsedtime2 = 0

func _ready():
	randomize()
	global.shake = 0
	curPos = offset

func _process(delta):
	if isShake:
		shake(delta)
	if isShake2:
		shake2(delta)
	if global.shake == 1:
		global.shake = 0 
		if not isShake:
			elapsedtime = 0
			isShake = true
	if global.shake == 2:
		global.shake = 0 
		if not isShake2:
			elapsedtime2 = 0
			isShake2 = true


func shake(delta):
	if elapsedtime<shake_time:
		offset =  Vector2(randf(), randf()) * shake_power
		elapsedtime += delta
	else:
		isShake = false
		elapsedtime = 0
		offset = curPos  

func shake2(delta):
	if elapsedtime2<shake_time2:
		offset =  Vector2(randf(), randf()) * shake_power2
		elapsedtime2 += delta
	else:
		isShake2 = false
		elapsedtime2 = 0
		offset = curPos  
