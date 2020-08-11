Client.graphics = Client:run("graphics")

Client.graphics:init()

Client.map = WorldSystem.Map()

RenderEngine:render_loop()
