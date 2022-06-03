local TerrainSystem_Main = require(script.TerrainSystem_Main)

local TerrainTemplate = TerrainSystem_Main.CreateTerrainTemplate({
	--NOTE: THE ARGUMENTS CAN BE IN ANY ORDER AS LONG AS THE NAME IS CORRECT
	--NOTE: IF NO ARGUMENTS ARE PROVIDE IT WILL DEFAULT
	Rows = 15,
	Columns = 15,
	Amplitude = 5,--Height Scale
	Frequency = 10,--More/Less Hills
	Size = Vector3.new(4, 30, 4),--Terrain Part Size
	ConsoleNotifications = false--Generate/Destroy tick notifications
})

while true do
	TerrainTemplate:GenerateTerrain()
	wait(5)
	TerrainTemplate:DestroyTerrain()
	wait(5)
end
