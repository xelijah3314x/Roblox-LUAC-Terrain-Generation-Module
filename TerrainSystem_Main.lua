local Workspace = game:GetService("Workspace")

local TerrainSystem_Main = {}
TerrainSystem_Main.__index = TerrainSystem_Main

function TerrainSystem_Main.CreateTerrainTemplate(Arguments)
	local TerrainTable = {
		Rows = Arguments.Rows or 15,
		Columns = Arguments.Columns or 51,
		Amplitude = Arguments.Amplitude or 5,
		Frequency = Arguments.Frequency or 10,
		Size = Arguments.Size or Vector3.new(4, 30, 4),
		Grid = {},
		Terrain = {},
		ConsoleNotifications = Arguments.ConsoleNotifications or true
	}
	setmetatable(TerrainTable, TerrainSystem_Main)
	
	if not Workspace:FindFirstChild("_Terrain") then
		local TerrianFolder = Instance.new("Folder", Workspace)
		TerrianFolder.Name = "_Terrain"
		TerrainTable.TerrainFolder = TerrianFolder
	end
	
	return TerrainTable
end

function TerrainSystem_Main:GenerateTerrain()
	local Start = tick()
	
	--Create the terrain grid
	for X = 1, self.Rows do
		self.Grid[X] = {}
		
		for Z = 1, self.Columns do
			local Noise = math.noise(X / self.Frequency, Z / self.Frequency) * self.Amplitude
			
			self.Grid[X][Z] = Noise
		end
	end
	
	--Spawn parts on the grid
	for X = 1, self.Rows do
		for Z = 1, self.Columns do
			local Terrain = Instance.new("Part", self.TerrainFolder)
			Terrain.Anchored = true
			Terrain.Size = self.Size
			Terrain.Position = Vector3.new(X * self.Size.X, self.Grid[X][Z], Z * self.Size.Z)
			
			table.insert(self.Terrain, Terrain)
		end
	end
	
	if self.ConsoleNotifications then
		print("Generated terrain in: " .. tick() - Start)
	end
	
	return
end

function TerrainSystem_Main:DestroyTerrain()
	local Start = tick()
	
	for Index, Terrain in pairs(self.Terrain) do
		Terrain:Destroy()
	end
	
	if self.ConsoleNotifications then
		print("Destroyed terrain in: " .. tick() - Start)
	end
	
	return
end

return TerrainSystem_Main
