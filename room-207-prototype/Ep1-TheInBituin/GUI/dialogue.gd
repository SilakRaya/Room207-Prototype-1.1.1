extends Control

# Encapsulation
var _Jolina_Lines:Array[String] = [
	"Dialogue One",
	"Dialogue Two"
]

var _full_text:String = ""
var index:int = 0
var scene:int = 0
var typing:bool = false
var _typing_speed:float = 0.1

@onready var _typing_timer: Timer = $TypingTimer

func _ready() -> void:
	displayText(_Jolina_Lines[scene])

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("switch"):
		switchText()

# Abstraction
func displayText(new_text: String) -> void:
	_full_text = new_text
	
	# Reset typing
	index = 0
	%Text.visible_characters = 0
	
	_typing_timer.wait_time = _typing_speed
	_typing_timer.start()
	
	%Text.text = _full_text

func switchText() -> void:
	scene += 1
	
	# Prevent going out of bounds
	if scene >= _Jolina_Lines.size():
		scene = 0
	
	displayText(_Jolina_Lines[scene])

# Timer signal
func _on_typing_timer_timeout() -> void:
	index += 1
	%Text.visible_characters = index
	
	# Stop timer when done
	if index >= _full_text.length():
		_typing_timer.stop()
