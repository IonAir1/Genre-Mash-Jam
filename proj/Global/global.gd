extends Node

var speed = 4 #scrolling speed
var shoot = 2 #number of balls/bullets
var enemy_count = 0 #enemy count
var score = 0 #score
var highscore = 0 #highscore
var enemypos = [0, 0, 0, 0, 0, 0, 0 , 0, 0, 0, 0] #enemy grid positions available
var lives = 3 #lives
var hurt = 0 #is player respawning
var shake = 0 #to activate screen shake
var enemysound = 0 #to activate enemy sound probably
var playerpos = Vector2(0, 0) #player position
var multiplier = 0 #multiplier
var mpupdate = 0 #shoud multiplier reset or start
var sound = true #is there sound
var music = true #is there music
var tutorial = true #should tutorial start (true)
var tutolevel = -1 #tutorial stage
var spawn = false #should enemy spawn activate manually
var control = Vector3(0, 0, 0)
