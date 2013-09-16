local MAJOR, MINOR = "LibPetBreedInfo-1.0", 9
local lib, oldminor = LibStub:NewLibrary(MAJOR, MINOR)

if not lib then return end
lib.breedData = {}
--
-- GLOBALS:
--

local _G = _G
local hooksecurefunc, tinsert, pairs, wipe = _G.hooksecurefunc, _G.table.insert, _G.pairs, _G.wipe
local ipairs = _G.ipairs
local C_PetJournal,C_PetBattles = _G.C_PetJournal, _G.C_PetBattles
local _
local EMPTY_PET = "0x0000000000000000"
local epsilion = .005
local STATE_Mod_SpeedPrecent = 25
local STATE_MaxHealthBonus = 2
local STATE_Mod_MaxHealthPrercent = 99
local HEALTH,POWER,SPEED = 1,2,3
local BASE_HEALTH = 100
local HEALTH_PER_STAMINA = 5
local FALLBACK_BREEDS = {1,2,3,4,5,6,7,8,9,10}
local WILD_PET_HEALTH_MULTIPLIER = 1.2
local MAX_PETS_PER_TEAM = 3
--
-- Non Lib helper functions
--
local function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

local function clamp(num,minVal,maxVal)
	return math.min(math.max(num,minVal),maxVal)
end

local function inverseStats(num)
	return num ~= 0 and 100/(num+100) or 1
end


--Gets the breed index for the given pet
--Returns arg1: petIndex that can be used by GetBreedName to return the breeds name. arg2: a confidence indicator, lower numbers are better. A good cutoff for high confidence is .15
--Returns nil if the species cannot battle or does not have a base stats profile or if the petID is not valid
function lib:GetBreedByPetID(petID)
	local speciesID, _, level, _, _, _,_ ,_, _, _, _, _, _, _, canBattle = C_PetJournal.GetPetInfoByPetID(petID)
	if not canBattle then return end
	local _, maxHealth, power, speed, rarity = C_PetJournal.GetPetStats(petID)
	
	return self:GetBreedByStats(speciesID,level,rarity,maxHealth,power,speed)
end


--Gets the breed index for the given hypothetical pet
--Returns arg1: petIndex that can be used by GetBreedName to return the breeds name. arg2: a confidence indicator, lower numbers are better. A good cutoff for high confidence is .15
--Returns nil if the species cannot battle or does not have a base stats profile or if level, health power and speed are not numbers and rarity is not between 1 and 4
function lib:GetBreedByStats(speciesID,level,rarity,health,power,speed)
	
	if not self.breedData.speciesToBaseStatProfile[speciesID] or not self.breedData.qualityMultiplier[rarity] or  
		type(level) ~= "number" or type(health) ~= "number" or type(power) ~= "number" or type(speed) ~= "number" then 
		
		return 
	end
	
	local canBattle      = select(8,C_PetJournal.GetPetInfoBySpeciesID(speciesID))
	local baseStatsIndex = self.breedData.speciesToBaseStatProfile[speciesID]
	
	if not baseStatsIndex and not canBattle then return end
	
	local baseStats         = self.breedData.baseStatsProfiles[baseStatsIndex]
	local qualityMultiplier = self.breedData.qualityMultiplier[rarity]

	health = clamp(round(( ((health-BASE_HEALTH)/HEALTH_PER_STAMINA) / qualityMultiplier) - level * baseStats[HEALTH],1) / level,0,2)
	power  = clamp(round((									  power  / qualityMultiplier) - level * baseStats[POWER] ,1) / level,0,2)
	speed  = clamp(round((                                    speed  / qualityMultiplier) - level * baseStats[SPEED] ,1) / level,0,2)
	
	local breeds = self:GetAvailableBreeds(speciesID)
	breeds = breeds and breeds or FALLBACK_BREEDS
	
	local leastDiff = 100
	local leastDiff2 = 100
	local breedID = 0
	
	for i=1,#breeds do
		local breedIndex = breeds[i]
		local breedData = self.breedData.breeds[breedIndex]
		local diff = round(math.abs(health - breedData[HEALTH]) + math.abs(power - breedData[POWER]) + math.abs(speed - breedData[SPEED]),2) + epsilion
		
		if diff < leastDiff then
			leastDiff2 = leastDiff
			leastDiff  = diff
			breedID    = breedIndex
		elseif diff < leastDiff2 then
			leastDiff2 = diff
		end
		
	end
	return breedID, round(leastDiff2 / leastDiff ,2)
end



--Gets the breed index for the given pet
--!!!Results are not valid if computed while a round play back is happening!!!
--Returns arg1: petIndex that can be used by GetBreedName to return the breeds name. arg2: a confidence indicator, lower numbers are better. A good cutoff for high confidence is .15
--Returns nil if the species cannot battle or does not have a base stats profile, or an invalid petOwner/petID is used, or if the player is not in a pet battle

--/run print(C_PetBattles.GetName(1,1),LibStub("LibPetBreedInfo-1.0"):GetBreedByPetBattleSlot(1,1))
function lib:GetBreedByPetBattleSlot(petOwner,id)
	if not C_PetBattles.IsInBattle() then return end
	if petOwner ~= LE_BATTLE_PET_ALLY and petOwner ~= LE_BATTLE_PET_ENEMY then return end
	if id <= 0 or id > MAX_PETS_PER_TEAM then return end
	
	local speedMultiplier  = inverseStats(C_PetBattles.GetStateValue(petOwner,id,STATE_Mod_SpeedPrecent))
	local healthMultiplier = inverseStats(C_PetBattles.GetStateValue(petOwner,id,STATE_Mod_MaxHealthPrercent))
	local healthModifier   = C_PetBattles.GetStateValue(petOwner,id,STATE_MaxHealthBonus)
	
	if C_PetBattles.IsWildBattle() and petOwner == LE_BATTLE_PET_ENEMY then
		healthMultiplier = healthMultiplier * WILD_PET_HEALTH_MULTIPLIER
	end
	
	local speciesID = C_PetBattles.GetPetSpeciesID(petOwner,id)
	local speed     = round(C_PetBattles.GetSpeed(petOwner,id) * speedMultiplier)
	local power     = C_PetBattles.GetPower(petOwner,id)
	local health    = (C_PetBattles.GetMaxHealth(petOwner,id) * healthMultiplier) - healthModifier
	local rarity    = C_PetBattles.GetBreedQuality(petOwner,id)
	local level     = C_PetBattles.GetLevel(petOwner,id)
	
	return self:GetBreedByStats(speciesID,level,rarity,health,power,speed)
end


--Gets the predicted stats for a species at a given level
--returns health,power,speed
--returns nil if the pet does not have a base stats profile, or if an invalid... breedID, rarity, or non numeric level is given.
function lib:GetPetPredictedStats(speciesID, breedID, rarity, level)
	if not self.breedData.breeds[breedID] or not self.breedData.speciesToBaseStatProfile[speciesID] or type(level) ~= "number" or not self.breedData.qualityMultiplier[rarity] then return end
	
	local baseStatsIndex = self.breedData.speciesToBaseStatProfile[speciesID]
	local baseStats      = self.breedData.baseStatsProfiles[baseStatsIndex]
	local multiplier     = self.breedData.qualityMultiplier[rarity]
	local breedStats     = self.breedData.breeds[breedID]
	
	local health = round((baseStats[HEALTH] + breedStats[HEALTH]) * multiplier * level * HEALTH_PER_STAMINA + BASE_HEALTH)
	local power  = round((baseStats[POWER]  + breedStats[POWER])  * multiplier * level) 
	local speed  = round((baseStats[SPEED]  + breedStats[SPEED])  * multiplier * level)
	
	return health, power , speed
end

--Gets a table containing the possible BreedID's for a given species
--Returns nil if no data is present for the given speciesID
--[[
function lib:GetAvailableBreeds(speciesID)
end]]

--Gets an iterator for all of the possible breed names
function lib:IterateBreedNames()
	return ipairs(self.breedData.breedNames)
end

--Gets the string representation of a BreedID
--BreedIDs are from 1-10 and not 3-22
--Returns nil for invalid breedID's
function lib:GetBreedName(breedID)
	return self.breedData.breedNames[breedID]
end


--Gets a table of possible breedId's for a given species
--BreedIDs are from 1-10
--Returns nil for invalid speciesID's
function lib:GetAvailableBreeds(speciesID)
	return self.breedData.speciesToAvailableBreeds[speciesID]
end

--/lb code LibStub("LibPetBreedInfo-1.0"):GetSpeciesWithoutProfiles()
--Gets a table of speciesIDs which are present in game but do not have a base stats profile
--This is a dev function to make updating this library easier
--Returns a table
--[[
function lib:GetSpeciesWithoutProfiles()
	local missingPets = {}
	for i=1,2000 do --2000 to catch new pet IDs
		name = C_PetJournal.GetPetInfoBySpeciesID(i)
		if name and not self.breedData.speciesToBaseStatProfile[i] then
			tinsert(missingPets,i)
		end
	end
	return missingPets
end]]

--/run LibStub("LibPetBreedInfo-1.0"):FindMissingSpeciesBreeds()
--[[function lib:FindMissingSpeciesBreeds()
	local lpj = LibStub("LibPetJournal-2.0")
	local availableBreeds = self.breedData.speciesToAvailableBreeds
	for _,v in lpj:IterateSpeciesIDs() do
		if not availableBreeds[v] then
			print(v,C_PetJournal.GetPetInfoBySpeciesID(v))
		end
	end
end]]




lib.breedData.breeds = {
	{.5,.5,.5}, --1
	{0,2,0}, --2
	{0,0,2}, --3
	{2,0,0}, --4 
	{.9,.9,0},--5
	{0,.9,.9},--6
	{.9,0,.9},--7
	{.4,.9,.4},--8
	{.4,.4,.9},--9
	{.9,.4,.4}--10
}

lib.breedData.breedNames = {
	"B/B", --1
	"P/P", --2
	"S/S", --3
	"H/H", --4 
	"H/P",--5
	"P/S",--6
	"H/S",--7
	"P/B",--8
	"S/B",--9
	"H/B"--10
}

lib.breedData.qualityMultiplier = {1,1.1,1.2,1.3,1.4}


--stam,power,speed
lib.breedData.baseStatsProfiles = {
	{8.5, 7.5, 8}, --1
	{7, 8.5, 8.5},--2
	{6.5, 9, 8.5},--3
	{7, 9, 8},--4
	{7.5, 7.5, 9},--5
	{8, 7.5, 8.5},--6
	{9, 7, 8},--7
	{9, 8, 7},--8
	{8.5, 8, 7.5},--9
	{8, 8, 8},--10
	{8.5, 7, 8.5},--11
	{8.5, 9, 6.5},--12
	{8, 7, 9},--13
	{7.5, 8.5, 8},--14
	{8, 8.5, 7.5},--15
	{7, 7, 10},--16
	{8.5, 8.5, 7},--17
	{7.5, 8, 8.5},--18
	{7.5, 7, 9.5},--19
	{9, 7.5, 7.5},--20
	{9, 9, 6},--21
	{9, 7.5, 7.5},--22
	{7.5, 9, 7.5},--23
	{8, 9, 7},--24
	{9.5, 8, 6.5},--24
	{9.5, 8.5, 6},--25
	{8, 9.5, 6.5},--26
	{8, 8.75, 7.25},--27
	{7, 8, 9},--28
	{9, 6.5, 8.5},--29
	{6, 8, 10},--30
	{9, 6.5, 8.5},--31
	{8, 6.5, 9.5},--32
	{9, 8.5, 6.5},--33
	{9.5, 7.5, 7},--34
	{6.5, 8, 9.5},--35
	{8.5, 8.5, 8.5},--36
	{9, 9, 9},--37
	{6.75, 10.5, 6.75}--38
}




lib.breedData.speciesToBaseStatProfile = {
	[39] = 1,
	[40] = 2,
	[41] = 2,
	[42] = 3,
	[43] = 4,
	[44] = 2,
	[45] = 2,
	[46] = 5,
	[47] = 6,
	[49] = 7,
	[50] = 8,
	[51] = 9,
	[52] = 10,
	[55] = 11,
	[56] = 12,
	[57] = 1,
	[58] = 4,
	[59] = 9,
	[64] = 1,
	[65] = 1,
	[67] = 10,
	[68] = 10,
	[69] = 5,
	[70] = 6,
	[71] = 10,
	[72] = 13,
	[73] = 10,
	[74] = 5,
	[75] = 14,
	[77] = 10,
	[78] = 14,
	[83] = 1,
	[84] = 10,
	[85] = 1,
	[86] = 1,
	[87] = 15,
	[89] = 10,
	[90] = 2,
	[92] = 10,
	[93] = 3,
	[94] = 16,
	[95] = 10,
	[106] = 1,
	[107] = 10,
	[111] = 10,
	[114] = 17,
	[115] = 10,
	[116] = 10,
	[117] = 10,
	[118] = 10,
	[119] = 10,
	[120] = 10,
	[121] = 10,
	[122] = 10,
	[124] = 10,
	[125] = 10,
	[126] = 10,
	[127] = 6,
	[128] = 10,
	[130] = 10,
	[131] = 6,
	[132] = 8,
	[136] = 10,
	[137] = 13,
	[138] = 1,
	[139] = 14,
	[140] = 15,
	[141] = 5,
	[142] = 15,
	[143] = 14,
	[144] = 5,
	[145] = 1,
	[146] = 18,
	[149] = 19,
	[153] = 10,
	[155] = 10,
	[156] = 10,
	[157] = 10,
	[158] = 10,
	[159] = 10,
	[160] = 10,
	[162] = 15,
	[163] = 15,
	[164] = 15,
	[165] = 1,
	[166] = 17,
	[167] = 22,
	[168] = 1,
	[169] = 10,
	[170] = 10,
	[171] = 10,
	[172] = 14,
	[173] = 15,
	[174] = 15,
	[175] = 14,
	[179] = 9,
	[180] = 9,
	[183] = 10,
	[186] = 14,
	[187] = 17,
	[188] = 17,
	[189] = 10,
	[190] = 17,
	[191] = 1,
	[192] = 10,
	[193] = 15,
	[194] = 10,
	[195] = 5,
	[196] = 9,
	[197] = 18,
	[198] = 10,
	[199] = 10,
	[200] = 13,
	[201] = 10,
	[202] = 10,
	[203] = 13,
	[204] = 10,
	[205] = 10,
	[206] = 17,
	[207] = 10,
	[209] = 10,
	[210] = 10,
	[211] = 9,
	[212] = 10,
	[213] = 10,
	[214] = 10,
	[215] = 1,
	[216] = 10,
	[217] = 10,
	[218] = 1,
	[220] = 10,
	[224] = 2,
	[225] = 10,
	[226] = 10,
	[227] = 10,
	[228] = 10,
	[229] = 10,
	[231] = 9,
	[232] = 2,
	[233] = 2,
	[234] = 2,
	[235] = 2,
	[236] = 14,
	[237] = 2,
	[238] = 2,
	[239] = 10,
	[240] = 17,
	[241] = 10,
	[242] = 14,
	[243] = 21,
	[244] = 12,
	[245] = 10,
	[246] = 10,
	[247] = 10,
	[248] = 10,
	[249] = 17,
	[250] = 23,
	[251] = 17,
	[253] = 10,
	[254] = 10,
	[255] = 23,
	[256] = 24,
	[257] = 10,
	[258] = 12,
	[259] = 1,
	[260] = 15,
	[261] = 1,
	[262] = 1,
	[264] = 17,
	[265] = 25,
	[266] = 17,
	[267] = 10,
	[268] = 12,
	[270] = 17,
	[271] = 6,
	[272] = 22,
	[277] = 1,
	[278] = 10,
	[279] = 10,
	[280] = 10,
	[281] = 10,
	[282] = 10,
	[283] = 10,
	[285] = 24,
	[286] = 8,
	[287] = 6,
	[289] = 26,
	[291] = 22,
	[292] = 10,
	[293] = 10,
	[294] = 10,
	[296] = 10,
	[297] = 27,
	[298] = 10,
	[301] = 2,
	[302] = 17,
	[303] = 2,
	[306] = 2,
	[307] = 10,
	[308] = 10,
	[309] = 3,
	[310] = 10,
	[311] = 9,
	[316] = 1,
	[317] = 17,
	[318] = 14,
	[319] = 3,
	[320] = 1,
	[321] = 10,
	[323] = 10,
	[325] = 23,
	[328] = 10,
	[329] = 10,
	[330] = 10,
	[331] = 10,
	[332] = 10,
	[333] = 10,
	[335] = 22,
	[336] = 10,
	[337] = 10,
	[338] = 1,
	[339] = 10,
	[340] = 10,
	[341] = 10,
	[342] = 10,
	[343] = 2,
	[344] = 9,
	[345] = 15,
	[346] = 10,
	[347] = 28,
	[348] = 17,
	[354] = 10,
	[374] = 10,
	[375] = 10,
	[378] = 13,
	[379] = 6,
	[380] = 10,
	[381] = 10,
	[382] = 10,
	[383] = 6,
	[384] = 10,
	[385] = 6,
	[386] = 6,
	[387] = 18,
	[388] = 9,
	[389] = 1,
	[390] = 6,
	[391] = 13,
	[392] = 6,
	[393] = 11,
	[394] = 10,
	[395] = 9,
	[396] = 2,
	[397] = 10,
	[398] = 6,
	[399] = 18,
	[400] = 2,
	[401] = 9,
	[402] = 9,
	[403] = 18,
	[404] = 6,
	[405] = 18,
	[406] = 1,
	[407] = 2,
	[408] = 18,
	[409] = 29,
	[410] = 6,
	[411] = 10,
	[412] = 2,
	[414] = 10,
	[415] = 14,
	[416] = 10,
	[417] = 6,
	[418] = 18,
	[419] = 1,
	[420] = 1,
	[421] = 15,
	[422] = 14,
	[423] = 17,
	[424] = 11,
	[425] = 18,
	[427] = 2,
	[428] = 2,
	[429] = 14,
	[430] = 15,
	[431] = 18,
	[432] = 10,
	[433] = 18,
	[434] = 10,
	[437] = 10,
	[438] = 18,
	[439] = 9,
	[440] = 10,
	[441] = 13,
	[442] = 32,
	[443] = 10,
	[444] = 10,
	[445] = 10,
	[446] = 9,
	[447] = 6,
	[448] = 13,
	[449] = 10,
	[450] = 8,
	[452] = 10,
	[453] = 8,
	[454] = 6,
	[455] = 10,
	[456] = 15,
	[457] = 8,
	[458] = 17,
	[459] = 2,
	[460] = 14,
	[461] = 8,
	[462] = 10,
	[463] = 21,
	[464] = 10,
	[465] = 2,
	[466] = 18,
	[467] = 14,
	[468] = 14,
	[469] = 2,
	[470] = 2,
	[471] = 1,
	[472] = 1,
	[473] = 22,
	[474] = 31,
	[475] = 11,
	[476] = 5,
	[477] = 5,
	[478] = 9,
	[479] = 33,
	[480] = 15,
	[482] = 18,
	[483] = 1,
	[484] = 2,
	[485] = 22,
	[486] = 6,
	[487] = 10,
	[488] = 18,
	[489] = 15,
	[491] = 4,
	[492] = 15,
	[493] = 26,
	[494] = 10,
	[495] = 1,
	[496] = 26,
	[497] = 11,
	[498] = 9,
	[499] = 6,
	[500] = 10,
	[502] = 1,
	[503] = 5,
	[504] = 15,
	[505] = 18,
	[506] = 2,
	[507] = 14,
	[508] = 10,
	[509] = 10,
	[510] = 1,
	[511] = 18,
	[512] = 14,
	[513] = 10,
	[514] = 10,
	[515] = 10,
	[517] = 10,
	[518] = 34,
	[519] = 9,
	[521] = 4,
	[523] = 8,
	[525] = 10,
	[528] = 18,
	[529] = 10,
	[530] = 10,
	[532] = 12,
	[534] = 14,
	[535] = 10,
	[536] = 9,
	[537] = 9,
	[538] = 17,
	[539] = 6,
	[540] = 6,
	[541] = 11,
	[542] = 1,
	[543] = 14,
	[544] = 17,
	[545] = 10,
	[546] = 14,
	[547] = 13,
	[548] = 14,
	[549] = 10,
	[550] = 6,
	[552] = 14,
	[553] = 6,
	[554] = 14,
	[555] = 11,
	[556] = 14,
	[557] = 14,
	[558] = 10,
	[559] = 23,
	[560] = 1,
	[562] = 18,
	[564] = 35,
	[565] = 1,
	[566] = 5,
	[567] = 18,
	[568] = 26,
	[569] = 1,
	[570] = 10,
	[571] = 18,
	[572] = 9,
	[573] = 7,
	[626] = 18,
	[627] = 17,
	[628] = 9,
	[629] = 9,
	[630] = 10,
	[631] = 18,
	[632] = 18,
	[633] = 10,
	[634] = 2,
	[635] = 18,
	[637] = 10,
	[638] = 11,
	[639] = 6,
	[640] = 13,
	[641] = 13,
	[644] = 6,
	[645] = 10,
	[646] = 10,
	[647] = 10,
	[648] = 22,
	[649] = 22,
	[650] = 9,
	[652] = 10,
	[665] = 14,
	[666] = 10,
	[671] = 10,
	[675] = 6,
	[677] = 10,
	[678] = 10,
	[679] = 10,
	[680] = 10,
	[699] = 2,
	[702] = 1,
	[703] = 10,
	[705] = 15,
	[706] = 10,
	[707] = 10,
	[708] = 6,
	[709] = 6,
	[710] = 10,
	[711] = 10,
	[712] = 10,
	[713] = 22,
	[714] = 2,
	[715] = 10,
	[716] = 2,
	[717] = 14,
	[718] = 10,
	[722] = 14,
	[723] = 22,
	[724] = 10,
	[725] = 10,
	[726] = 2,
	[727] = 10,
	[728] = 10,
	[729] = 13,
	[730] = 13,
	[731] = 2,
	[732] = 15,
	[733] = 10,
	[737] = 36,
	[739] = 29,
	[740] = 6,
	[741] = 10,
	[742] = 10,
	[743] = 26,
	[744] = 11,
	[745] = 10,
	[746] = 12,
	[747] = 14,
	[748] = 15,
	[749] = 10,
	[750] = 10,
	[751] = 6,
	[752] = 22,
	[753] = 14,
	[754] = 10,
	[755] = 32,
	[756] = 11,
	[757] = 9,
	[758] = 14,
	[792] = 15,
	[800] = 10,
	[802] = 17,
	[817] = 9,
	[818] = 15,
	[819] = 14,
	[820] = 10,
	[821] = 10,
	[823] = 10,
	[824] = 10,
	[825] = 10,
	[826] = 10,
	[827] = 10,
	[828] = 10,
	[829] = 10,
	[830] = 10,
	[831] = 10,
	[832] = 10,
	[833] = 10,
	[834] = 9,
	[835] = 10,
	[836] = 19,
	[837] = 9,
	[838] = 10,
	[844] = 15,
	[845] = 10,
	[846] = 31,
	[847] = 10,
	[848] = 13,
	[849] = 10,
	[850] = 10,
	[851] = 18,
	[855] = 14,
	[856] = 10,
	[868] = 10,
	[872] = 10,
	[873] = 10,
	[874] = 10,
	[875] = 10,
	[876] = 10,
	[877] = 10,
	[878] = 10,
	[879] = 10,
	[880] = 10,
	[881] = 10,
	[882] = 10,
	[883] = 10,
	[884] = 10,
	[885] = 10,
	[886] = 10,
	[887] = 10,
	[888] = 10,
	[889] = 10,
	[890] = 10,
	[891] = 10,
	[892] = 10,
	[893] = 10,
	[894] = 10,
	[895] = 10,
	[896] = 10,
	[897] = 10,
	[898] = 10,
	[899] = 10,
	[900] = 10,
	[901] = 10,
	[902] = 10,
	[903] = 23,
	[904] = 10,
	[905] = 10,
	[906] = 10,
	[907] = 10,
	[908] = 10,
	[909] = 10,
	[911] = 15,
	[912] = 15,
	[913] = 15,
	[915] = 10,
	[916] = 10,
	[917] = 10,
	[921] = 10,
	[922] = 10,
	[923] = 1,
	[924] = 10,
	[925] = 10,
	[926] = 10,
	[927] = 10,
	[928] = 10,
	[929] = 10,
	[931] = 10,
	[932] = 10,
	[933] = 10,
	[934] = 10,
	[935] = 10,
	[936] = 10,
	[937] = 10,
	[938] = 10,
	[939] = 10,
	[941] = 10,
	[942] = 10,
	[943] = 10,
	[944] = 10,
	[945] = 10,
	[946] = 10,
	[947] = 10,
	[948] = 10,
	[949] = 10,
	[950] = 10,
	[951] = 10,
	[952] = 10,
	[953] = 10,
	[954] = 10,
	[955] = 10,
	[956] = 10,
	[957] = 10,
	[958] = 10,
	[959] = 10,
	[960] = 10,
	[961] = 10,
	[962] = 10,
	[963] = 10,
	[964] = 10,
	[965] = 10,
	[966] = 10,
	[967] = 10,
	[968] = 10,
	[969] = 10,
	[970] = 10,
	[971] = 10,
	[972] = 10,
	[973] = 10,
	[974] = 10,
	[975] = 10,
	[976] = 10,
	[977] = 37,
	[978] = 37,
	[979] = 37,
	[980] = 37,
	[981] = 37,
	[982] = 37,
	[983] = 37,
	[984] = 37,
	[985] = 37,
	[986] = 37,
	[987] = 37,
	[988] = 37,
	[989] = 10,
	[990] = 10,
	[991] = 10,
	[992] = 10,
	[993] = 10,
	[994] = 10,
	[995] = 10,
	[996] = 10,
	[997] = 10,
	[998] = 10,
	[999] = 10,
	[1000] = 10,
	[1001] = 10,
	[1002] = 38,
	[1003] = 38,
	[1004] = 10,
	[1005] = 10,
	[1006] = 10,
	[1007] = 10,
	[1008] = 10,
	[1009] = 10,
	[1010] = 10,
	[1011] = 10,
	[1012] = 10,
	[1013] = 22,
	[1039] = 5,
	[1040] = 10,
	[1042] = 39,
	[1061] = 10,
	[1062] = 6,
	[1063] = 17,
	[1065] = 17,
	[1066] = 10,
	[1067] = 1,
	[1068] = 10,
	[1073] = 10,
	[1117] = 2,
	[1124] = 10,
	[1125] = 10,
	[1126] = 10,
	[1127] = 14,
	[1128] = 10,
	[1129] = 10,
	[1130] = 10,
	[1131] = 10,
	[1132] = 10,
	[1133] = 10,
	[1134] = 10,
	[1135] = 10,
	[1136] = 10,
	[1137] = 10,
	[1138] = 10,
	[1139] = 10,
	[1140] = 10,
	[1141] = 10,
	[1142] = 1,
	[1143] = 10,
	[1144] = 10,
	[1145] = 10,
	[1146] = 10,
	[1147] = 10,
	[1149] = 10,
	[1150] = 10,
	[1151] = 10,
	[1152] = 14,
	[1153] = 10,
	[1154] = 10,
	[1155] = 15,
	[1156] = 10,
	[1157] = 10,
	[1158] = 10,
	[1159] = 14,
	[1160] = 9,
	[1161] = 15,
	[1162] = 4,
	[1163] = 8,
	[1164] = 18,
	[1165] = 15,
	[1166] = 15,
	[1167] = 15,
	[1168] = 10
}

lib.breedData.speciesToAvailableBreeds = {
	[39] = {9},
    [40] = {6},
    [41] = {2},
    [42] = {5},
    [43] = {1},
    [44] = {3},
    [45] = {1},
    [46] = {10},
    [47] = {1, 3},
    [49] = {1},
    [50] = {9},
    [51] = {1, 3},
    [52] = {1, 8, 9, 10},
    [55] = {1, 3, 4, 7},
    [56] = {6},
    [57] = {2},
    [58] = {6},
    [59] = {7},
    [64] = {7},
    [65] = {10},
    [67] = {1, 6, 8},
    [68] = {1, 4, 5},
    [69] = {1, 8, 9},
    [70] = {1, 3, 10},
    [72] = {1, 3, 9},
    [74] = {9},
    [75] = {3},
    [77] = {1},
    [78] = {10},
    [83] = {6},
    [84] = {1, 8, 9, 10},
    [85] = {7},
    [86] = {5},
    [87] = {3},
    [89] = {4},
    [90] = {5},
    [92] = {1},
    [93] = {2},
    [94] = {3},
    [95] = {1},
    [106] = {8},
    [107] = {1},
    [111] = {10},
    [114] = {10},
    [116] = {10},
    [117] = {1},
    [118] = {1},
    [119] = {1},
    [120] = {1},
    [121] = {1},
    [122] = {3},
    [124] = {1},
    [125] = {3},
    [126] = {8},
    [127] = {5},
    [128] = {1},
    [130] = {1},
    [131] = {6},
    [132] = {4},
    [136] = {1, 5, 8, 10},
    [137] = {1, 3, 9},
    [138] = {1, 10},
    [139] = {1, 6, 10},
    [140] = {1, 2, 10},
    [141] = {1, 4, 10},
    [142] = {1, 3},
    [143] = {1, 3, 6},
    [144] = {1, 3, 9},
    [145] = {1, 3, 4, 6},
    [146] = {1, 3, 7, 10},
    [149] = {7},
    [153] = {5},
    [156] = {1},
    [157] = {1},
    [158] = {1},
    [159] = {4},
    [160] = {2},
    [162] = {8},
    [163] = {6},
    [164] = {1},
    [165] = {7},
    [166] = {5},
    [167] = {1, 4, 7},
    [168] = {3},
    [169] = {1},
    [170] = {5},
    [171] = {5},
    [172] = {8},
    [173] = {5},
    [174] = {1},
    [175] = {3},
    [179] = {5},
    [180] = {5},
    [183] = {1},
    [186] = {1, 2, 3, 6},
    [187] = {6},
    [188] = {4},
    [189] = {1},
    [190] = {4, 5, 10},
    [191] = {1},
    [192] = {7},
    [193] = {2},
    [194] = {1, 3, 6, 7, 9},
    [195] = {3, 6, 7, 9},
    [196] = {5},
    [197] = {6},
    [198] = {9},
    [199] = {8},
    [200] = {3},
    [201] = {5},
    [202] = {5},
    [203] = {10},
    [204] = {1},
    [205] = {5},
    [206] = {1, 7, 9},
    [207] = {6},
    [209] = {1},
    [210] = {3},
    [211] = {4},
    [212] = {1},
    [213] = {3},
    [214] = {1},
    [215] = {8},
    [216] = {1},
    [217] = {5},
    [218] = {2},
    [220] = {7},
    [224] = {8},
    [225] = {1},
    [226] = {2},
    [227] = {2},
    [228] = {5},
    [229] = {1},
    [231] = {1},
    [232] = {6},
    [233] = {6},
    [234] = {8},
    [235] = {8},
    [236] = {4},
    [237] = {1},
    [238] = {9},
    [239] = {2},
    [240] = {1},
    [241] = {1},
    [242] = {6},
    [243] = {8},
    [244] = {5},
    [245] = {6},
    [246] = {1},
    [247] = {4},
    [248] = {6},
    [249] = {5},
    [250] = {6},
    [251] = {1},
    [253] = {1},
    [254] = {1, 3, 6},
    [255] = {4},
    [256] = {5},
    [258] = {4},
    [259] = {10},
    [260] = {6},
    [261] = {2},
    [262] = {3},
    [264] = {6},
    [265] = {4},
    [266] = {6},
    [267] = {1},
    [268] = {2},
    [270] = {7},
    [271] = {1, 7, 8},
    [272] = {4, 7},
    [277] = {9},
    [278] = {7},
    [279] = {6},
    [280] = {1},
    [281] = {1},
    [282] = {1},
    [283] = {1},
    [285] = {8},
    [286] = {5},
    [287] = {1},
    [289] = {4},
    [291] = {10},
    [292] = {1},
    [293] = {7},
    [294] = {6},
    [296] = {1},
    [297] = {2},
    [298] = {1},
    [301] = {9},
    [302] = {5},
    [303] = {3},
    [306] = {9},
    [307] = {1},
    [308] = {1},
    [309] = {6},
    [310] = {6},
    [311] = {1},
    [316] = {1},
    [317] = {1},
    [318] = {1},
    [319] = {8},
    [320] = {5},
    [321] = {4},
    [323] = {6},
    [325] = {3, 6, 8},
    [328] = {2},
    [329] = {6},
    [330] = {8},
    [331] = {1},
    [332] = {1},
    [333] = {9},
    [335] = {10},
    [336] = {1},
    [337] = {10},
    [338] = {5},
    [339] = {10},
    [340] = {1},
    [341] = {1},
    [342] = {1},
    [343] = {1, 6},
    [346] = {1},
    [347] = {1},
    [348] = {6},
    [374] = {5, 6, 7, 8, 9, 10},
    [378] = {1, 3, 5, 7, 9, 10},
    [379] = {1, 3, 8, 9, 10},
    [380] = {1, 10},
    [381] = {7},
    [383] = {6, 9},
    [385] = {1, 3, 6, 9, 10},
    [386] = {1, 3, 9},
    [387] = {1, 3},
    [388] = {1, 4, 5},
    [389] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
    [391] = {1, 3, 7},
    [392] = {1, 3, 7, 9},
    [393] = {3, 4, 5, 7, 9, 10},
    [395] = {1, 4, 5},
    [396] = {6, 9},
    [397] = {1, 7, 9, 10},
    [398] = {1, 3, 7, 9},
    [399] = {1, 3, 6},
    [400] = {1, 2, 7, 9},
    [401] = {1, 4, 5},
    [402] = {1, 7, 10},
    [403] = {1, 3, 6, 8},
    [404] = {1, 10},
    [405] = {1, 2, 5},
    [406] = {1, 4, 5, 7},
    [407] = {1, 3, 6, 9},
    [408] = {1, 3, 9},
    [409] = {3, 6, 8},
    [410] = {1, 3, 7, 9},
    [411] = {1, 2},
    [412] = {1, 3, 9},
    [414] = {1, 6},
    [415] = {4, 5, 7},
    [416] = {1, 3, 6},
    [417] = {1, 3, 7, 9},
    [418] = {1, 9},
    [419] = {1, 9},
    [420] = {1, 5, 10},
    [421] = {1, 7, 10},
    [422] = {1, 3, 6},
    [423] = {1, 4, 7},
    [424] = {3, 4, 5, 7, 9, 10},
    [425] = {1, 6, 8},
    [427] = {1, 7},
    [428] = {1, 3, 6, 9},
    [429] = {2, 4, 5, 7},
    [430] = {3},
    [431] = {6, 7},
    [432] = {1, 6},
    [433] = {1, 3, 5},
    [437] = {1, 8},
    [438] = {4, 7},
    [439] = {4, 7},
    [440] = {1, 2, 6},
    [441] = {3, 5, 7},
    [442] = {4, 5, 7, 10},
    [443] = {1, 3, 5, 7, 9, 10},
    [445] = {4, 5, 7, 8},
    [446] = {1, 2, 4, 7},
    [447] = {1, 3, 7, 9, 10},
    [448] = {1, 3, 5, 7, 9, 10},
    [449] = {1, 3, 9},
    [450] = {1, 4},
    [452] = {1, 3, 8, 9, 10},
    [453] = {4, 5},
    [454] = {1, 3, 7, 9},
    [455] = {5, 6, 8},
    [456] = {1, 4, 5, 6},
    [457] = {4, 7},
    [458] = {1, 4},
    [459] = {1, 3, 6, 9},
    [460] = {1, 4, 7},
    [461] = {1},
    [463] = {4, 7},
    [464] = {1, 3, 7},
    [465] = {1, 2, 6},
    [466] = {1, 3, 5},
    [467] = {1, 4, 5, 7},
    [468] = {1, 4, 5, 7},
    [469] = {1, 2, 4, 5, 7},
    [470] = {1, 2, 5, 9},
    [471] = {1, 3, 4, 6, 7, 8},
    [472] = {1, 2, 3, 4, 5, 6, 8, 9},
    [473] = {1, 7},
    [474] = {3},
    [475] = {1, 10},
    [477] = {1, 9},
    [478] = {1, 7, 9, 10},
    [479] = {1, 9},
    [480] = {1, 4, 7},
    [482] = {1, 3},
    [483] = {1, 10},
    [484] = {1, 3, 6, 9},
    [485] = {4, 5, 7},
    [487] = {1, 3, 5, 8, 9, 10},
    [488] = {10},
    [489] = {2, 6, 8},
    [491] = {3, 6},
    [492] = {1, 4, 7},
    [493] = {1, 4, 5},
    [494] = {1, 4, 5},
    [495] = {1, 10},
    [496] = {1, 7, 10},
    [497] = {4, 5, 7, 10},
    [498] = {1, 6, 7},
    [499] = {5},
    [500] = {1, 2, 4, 5, 6, 8},
    [502] = {1, 10},
    [503] = {1, 3, 9},
    [504] = {1, 2, 8},
    [505] = {1, 3, 5, 9},
    [506] = {1, 4, 7, 9},
    [507] = {1, 7, 10},
    [508] = {1, 2, 5},
    [509] = {4, 5, 7},
    [511] = {1, 3, 9},
    [512] = {2, 4, 7, 10},
    [514] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
    [515] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
    [517] = {1, 6},
    [518] = {1, 4},
    [519] = {4, 5, 7},
    [521] = {8},
    [523] = {4, 7},
    [525] = {1, 3, 10},
    [528] = {7, 10},
    [529] = {2, 5},
    [530] = {1, 4, 5, 7},
    [532] = {2, 4},
    [534] = {1, 2, 3, 6, 8},
    [535] = {1, 7},
    [536] = {5, 7},
    [537] = {1, 2, 4, 5},
    [538] = {4, 6},
    [539] = {1, 3, 8, 9, 10},
    [540] = {1, 3, 8, 9, 10},
    [541] = {3, 4, 5, 7},
    [542] = {1, 10},
    [543] = {1, 3, 7},
    [544] = {3, 9, 10},
    [545] = {1, 3, 6},
    [546] = {4, 7, 10},
    [547] = {1, 3, 5, 7, 8, 9},
    [548] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
    [549] = {1, 3, 8, 9, 10},
    [550] = {1, 3, 8, 9, 10},
    [552] = {1, 2, 4, 5, 9},
    [553] = {1, 3, 8, 9, 10},
    [554] = {1, 5, 7},
    [555] = {3, 4, 5, 7},
    [556] = {4, 7, 10},
    [557] = {2, 3, 5, 8, 9},
    [558] = {6},
    [559] = {2, 4, 5, 7},
    [560] = {1, 3, 8},
    [562] = {1, 3, 6},
    [564] = {1, 4, 10},
    [565] = {1, 10},
    [566] = {1, 7, 10},
    [567] = {3, 8},
    [568] = {1, 7},
    [569] = {1, 10},
    [570] = {1, 8},
    [571] = {1, 3},
    [572] = {2, 4},
    [573] = {1, 3, 8, 9},
    [626] = {2, 3, 5, 6, 8, 9},
    [627] = {5, 8},
    [628] = {1, 8},
    [629] = {1, 2, 5},
    [630] = {1, 3, 6, 8},
    [631] = {5, 7},
    [632] = {1, 8},
    [633] = {1, 5, 7, 10},
    [634] = {1, 7},
    [635] = {1, 6, 8},
    [637] = {1, 3, 9},
    [638] = {3, 4, 5, 7},
    [639] = {1, 3, 8, 9, 10},
    [640] = {1, 3, 5, 7, 9, 10},
    [641] = {1, 3, 5, 7, 9, 10},
    [644] = {1, 3, 8, 9, 10},
    [645] = {1, 6, 7},
    [646] = {1, 3, 9, 10},
    [647] = {1, 3, 6, 8, 9},
    [648] = {1, 4, 5, 10},
    [649] = {1, 5, 6},
    [650] = {6},
    [652] = {9},
    [665] = {9},
    [671] = {6},
    [675] = {1, 3, 8, 9, 10},
    [677] = {1, 3, 6},
    [678] = {4, 7},
    [679] = {3, 9},
    [680] = {3, 9},
    [699] = {1, 7, 9, 10},
    [702] = {1, 3, 10},
    [703] = {1, 9},
    [706] = {1, 3, 6},
    [707] = {1, 3},
    [708] = {1, 3, 8, 9, 10},
    [709] = {1, 3, 9, 10},
    [710] = {1, 7, 9},
    [711] = {1, 3, 9},
    [712] = {1, 3, 9},
    [713] = {1, 7},
    [714] = {1, 2, 8, 9},
    [716] = {5, 7},
    [717] = {3, 4, 7, 10},
    [718] = {1, 6, 7},
    [722] = {1, 7, 8, 10},
    [723] = {1, 4, 7},
    [724] = {3, 8},
    [725] = {1, 9},
    [726] = {1, 3, 5},
    [727] = {1, 3, 6, 9, 10},
    [728] = {1, 3, 9, 10},
    [729] = {1, 3, 5, 7, 9, 10},
    [730] = {1, 3, 7, 9, 10},
    [731] = {5, 7},
    [732] = {6, 7},
    [733] = {1, 3, 9},
    [737] = {3, 6},
    [739] = {3, 6},
    [740] = {1, 7, 8, 9, 10},
    [741] = {1, 10},
    [742] = {1, 3},
    [743] = {1, 3, 10},
    [744] = {3, 4, 5, 7, 9, 10},
    [745] = {1, 7},
    [746] = {2, 4},
    [747] = {1, 7, 8, 10},
    [748] = {1, 3, 5, 6, 7, 8, 9, 10},
    [749] = {3, 9},
    [750] = {1, 3, 9},
    [751] = {1, 7, 9, 10},
    [752] = {1, 2, 10},
    [753] = {1, 7},
    [754] = {1, 3, 5, 6, 7, 9, 10},
    [755] = {6, 8},
    [756] = {1, 3, 7},
    [757] = {3},
    [758] = {6},
    [792] = {1, 10},
    [802] = {2},
    [817] = {5},
    [818] = {6},
    [819] = {3},
    [820] = {10},
    [821] = {9},
    [823] = {1, 3, 7, 10},
    [834] = {5},
    [835] = {3},
    [836] = {3},
    [837] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
    [838] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
    [844] = {3},
    [845] = {1, 6, 8},
    [846] = {3},
    [847] = {10},
    [848] = {1, 3, 7},
    [849] = {1},
    [850] = {1},
    [851] = {1, 3, 5},
    [855] = {1},
    [856] = {7, 10},
    [868] = {7},
    [903] = {8},
    [1013] = {1, 4, 7},
    [1039] = {4},
    [1040] = {4},
    [1042] = {6},
    [1061] = {3},
    [1062] = {1, 7, 8, 10},
    [1063] = {6},
    [1068] = {1, 3, 6, 8},
    [1073] = {10},
    [1117] = {1},
    [1124] = {6},
    [1125] = {1},
    [1126] = {5},
    [1127] = {6},
    [1128] = {1, 10},
    [1142] = {9},
    [1143] = {6},
    [1144] = {7},
    [1145] = {3},
    [1146] = {5},
    [1147] = {2},
    [1149] = {6},
    [1150] = {7},
    [1151] = {5},
    [1152] = {4},
    [1153] = {2},
    [1154] = {7},
    [1155] = {4},
    [1156] = {6},
    [1157] = {1, 10},
    [1158] = {10},
    [1159] = {10},
    [1160] = {6},
    [1161] = {2, 6, 8},
    [1162] = {3, 6},
    [1163] = {4, 5},
    [1164] = {1, 3, 9},
    [1165] = {2, 6, 8},
    [1166] = {2, 6, 8},
    [1167] = {2, 6, 8},
}

--[[
local a,b = 0,0
for k,v in pairs(lib.breedData.speciesToAvailableBreeds) do a = a+1 end
for k,v in pairs(lib.breedData.speciesToBaseStatProfile) do b = b+1 end

missingPets = ""
for k,v in pairs(lib.breedData.speciesToBaseStatProfile) do 
	if not lib.breedData.speciesToAvailableBreeds[k] then
		missingPets = missingPets..k..", "
		print(k)
	end
end


print(a,b)]]