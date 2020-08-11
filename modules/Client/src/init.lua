Client.graphics = Client:run("graphics")

Client.graphics:init()
PlayerSystem:init("client")

Client.map = WorldSystem.Map()
Client.player = PlayerSystem.LocalPlayer()

Client.player:set_position(glm.vec3(8, 18, 40))

RenderEngine:render_loop()
