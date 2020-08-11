local RemotePlayer = Dragonblocks.create_class()
table.assign(RemotePlayer, PlayerSystem.Player)

function RemotePlayer:constructor()
	self:init()
end

return RemotePlayer
