extends Node

var speed = 4 #scrolling speed
var shoot = 2 #is shoot allowed?
var enemy_count = 0 #enemy count
var score = 0 #score
var highscore = 0 #highscore
var enemypos = [0, 0, 0, 0, 0, 0, 0 , 0, 0, 0, 0] #enemy grid positions available
var lives = 3 #lives
var hurt = 0 #is player respawning
var shake = 0
var enemysound = 0
var playerpos = Vector2(0, 0)
var multiplier = 0
var mpupdate = 0
