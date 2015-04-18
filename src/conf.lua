local debug = true

function love.conf(t)
	t.identity = "grand-theft-papercut"
	t.version = "0.9.1"
	if debug then t.console = true end

	t.window = {}
	t.window.title = "Grand Theft Papercut"
	t.window.width = 480
	t.window.height = 320
	t.window.fullscreen = false
	--t.window.borderless = true
	t.window.resizable = false --look into auto resize lib and possibly use that

	--t.modules = {}
	t.modules.joystick = false
	t.modules.physics = false
end

return debug
