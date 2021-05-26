extends Camera2D

var shake_power = 12 #how hard is type 1 shake
var shake_time = 0.5 #how long is type 1 shake
var isShake = false #is type 1 shaking
var curPos #current position
var elapsedtime = 0 #how long has passed since shaking started for type 1
var shake_power2 = 5 #how hard is type 2 shake
var shake_time2 = 0.2  #how long type 2 shake
var isShake2 = false # is type 2 shaking
var elapsedtime2 = 0 # how long has passed since shaking started for type 2

func _ready():
	randomize()
	global.shake = 0
	curPos = offset

func _process(delta):
	if isShake:
		shake(delta)
	if isShake2:
		shake2(delta)

	if global.shake == 1: #start type 1 shake
		global.shake = 0 
		if not isShake:
			elapsedtime = 0
			isShake = true
	if global.shake == 2:#start type 2 shake
		global.shake = 0 
		if not isShake2:
			elapsedtime2 = 0
			isShake2 = true

func shake(delta): #type 1 shake
	if elapsedtime<shake_time:
		offset =  Vector2(randf(), randf()) * shake_power
		elapsedtime += delta
	else:
		isShake = false
		elapsedtime = 0
		offset = curPos  

func shake2(delta): #type 2 shake
	if elapsedtime2<shake_time2:
		offset =  Vector2(randf(), randf()) * shake_power2
		elapsedtime2 += delta
	else:
		isShake2 = false
		elapsedtime2 = 0
		offset = curPos  
