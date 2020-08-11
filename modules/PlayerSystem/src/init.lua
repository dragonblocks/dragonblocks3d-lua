PlayerSystem.Player = PlayerSystem:run("player")

function PlayerSystem:init(gametype)
	if gametype == "client" then
		PlayerSystem.LocalPlayer = PlayerSystem:run("localplayer")
	elseif gametype == "server" then
		PlayerSystem.RemotePlayer = PlayerSystem:run("remoteplayer")
	end
end
