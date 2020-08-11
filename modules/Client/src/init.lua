Client.graphics = Client:run("graphics")

Client.graphics:init()
PlayerSystem:init("client")

Client.map = WorldSystem.Map()
Client.player = PlayerSystem.LocalPlayer()

Client.player:set_position(glm.vec3(8, 20, 8))

Dragonblocks:add_task(function()
	repeat
		coroutine.yield("FPS:" .. math.floor(Dragonblocks.tps or 0))
	until false
end)
