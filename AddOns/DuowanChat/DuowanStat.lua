﻿-------------------------------------------------------------------------------
-- Duowan Stat - ver 1.0
-- 日期: 2011-01-05
-- 作者: dugu@wowbox
-- 描述: 统计并发送玩家的属性, 便于组队
-- 版权所有(c)多玩游戏网
-------------------------------------------------------------------------------
local DWChat = LibStub('AceAddon-3.0'):GetAddon('DuowanChat');
local L = LibStub("AceLocale-3.0"):GetLocale("DuowanChat", true); 
local MODNAME = "DUOWANSTAT";
DuowanStat = DWChat:NewModule(MODNAME, "AceEvent-3.0");
local D = DuowanStat;

local _

function D:OnInitialize()
	self.data = {};
end

function D:OnEnable()
	
end

function D:OnDisable()
	
end

-- DOTO: 更新属性数据
function D:UpdateStat()
	self.data = {};

	self.data["CLASS"], self.data["CLASS_EN"] = UnitClass("player");
	self.data["LV"] = UnitLevel("player");
	self.data["HP"] = UnitHealthMax("player");
	self.data["MP"] = UnitManaMax("player");
	self.data["TALENT"] = self:GetTalent(); 
	self.data["ILV"] = self:GetINVLevel();
	self.data["GS"] = self:GetGS();
	if (self.data["LV"] >= 80) then
		self.data["MST"] = GetCombatRating(CR_MASTERY);
	end	
	
	--基础属性
	self.data["STR"] = UnitStat("player", 1);					--力量
	self.data["AGI"] = UnitStat("player", 2);					--敏捷
	self.data["STA"] = UnitStat("player", 3);					--耐力
	self.data["INT"] = UnitStat("player", 4);					--智力
	self.data["SPI"] = UnitStat("player", 5);					--精神
	--近战
	self.data["MAP"] = self:UnitAttackPower();				--强度
	self.data["MHIT"] = GetCombatRating(6);					--命中等级
	self.data["MCRIT"] = GetCritChance();					--爆击率%
	self.data["MEXPER"] = GetExpertise();					--精准
	self.data["MHASTE"] = GetMeleeHaste();					--急速%
	--远程
	self.data["RAP"] = self:UnitRangedAttackPower();			--强度
	self.data["RHIT"] = GetCombatRating(7);					--命中等级
	self.data["RCRIT"] = GetRangedCritChance();				--爆击率%
	self.data["RHASTE"] = GetRangedHaste();					--急速%
	--self.data["MRPEN"] = GetArmorPenetration();				--护甲穿透%
	--法术
	self.data["SSP"] = self:GetSpellBonusDamage();				--伤害加成
	self.data["SHP"] = GetSpellBonusHealing();				--治疗加成
	self.data["SHIT"] = GetCombatRating(8);					--命中等级
	self.data["SCRIT"] = self:GetSpellCritChance();				--爆击率
	self.data["SHASTE"] = UnitSpellHaste("player");				--急速%
	self.data["SMR"] = floor(GetManaRegen()*5);				--法力回复（每5秒）
	self.data["SPEN"] = GetSpellPenetration();				--法术穿透

	--防御
	_,_,self.data["ARMOR"] = UnitArmor("player");				--护甲
	self.data["DEF"] = self:GetUnitDefense();					--防御
	self.data["DODGE"] = GetDodgeChance();					--躲闪%
	self.data["PARRY"] = GetParryChance();					--招架%
	self.data["BLOCK"] = GetBlockChance();					--格挡%
	self.data["CRDEF"] = GetCombatRating(15);				--韧性

	if self.data["CRDEF"] > (200*(self.data["LV"]/70)) then		--是否为PvP属性
		self.data["PvPSET"] = true;
	else
		self.data["PvPSET"] = false;
	end
end

function D:GenerateStatText(detail)
	self:UpdateStat();
	local text = L["HEAD"];
	-- 简约
	text = text .. self.data["CLASS"];
	-- text = text .. " GS=" .. self.data["GS"];
	if (self.data["TALENT"]) then
		text = text .. "，" .. self.data["TALENT"];
	end
	text = text .. ("，"..STAT_AVERAGE_ITEM_LEVEL.."%d".." (已装备%d"):format(GetAverageItemLevel())..(GearScoreL and ",ＧＳ="..GearScoreL:GetPlayerInfo("player")..")" or ")"); --"物品等级%d（已装备%d）"
	if (detail) then
		local talentName = self:GetMainTalentName();
		if (UnitPowerType("player") == 0) then
			text = text..(", %d%s，%d%s"):format(self.data["HP"], L["HP"], self.data["MP"], L["MP"]);
		else
			text = text..(", %d%s"):format(self.data["HP"], L["HP"]);
		end
		if self.data["CLASS_EN"] == "MAGE" or self.data["CLASS_EN"] == "WARLOCK" then
			text = text..self:GetSpellText();
		end
		if self.data["CLASS_EN"] == "ROGUE" then
			text = text..self:GetMeleeText();
		end
		if self.data["CLASS_EN"] == "HUNTER" then
			text = text..self:GetRangedText();
		end
		if self.data["CLASS_EN"] == "DRUID" then
			if talentName == select(2, GetSpecializationInfo(1)) then
				text = text..self:GetSpellText();
			elseif talentName == select(2, GetSpecializationInfo(2)) then
				if self.data["DODGE"] > 30 then
					text = text..self:GetTankText();
				else
					text = text..self:GetMeleeText();
				end
			elseif talentName == select(2, GetSpecializationInfo(3)) then
				text = text..self:GetHealText();
			else
				text = text..self:GetMeleeText();
			end
		end
		if self.data["CLASS_EN"] == "SHAMAN" then
			if talentName == select(2, GetSpecializationInfo(1)) then
				text = text..self:GetSpellText();
			elseif talentName == select(2, GetSpecializationInfo(2)) then
				text = text..self:GetMeleeText();
			elseif talentName == select(2, GetSpecializationInfo(3)) then
				text = text..self:GetHealText();
			else
				text = text..self:GetMeleeText();
			end
		end
		if self.data["CLASS_EN"] == "PALADIN" then
			if talentName == select(2, GetSpecializationInfo(1)) then
				text = text..self:GetHealText();
			elseif talentName == select(2, GetSpecializationInfo(2)) then
				text = text..self:GetTankText();
			elseif talentName == select(2, GetSpecializationInfo(3)) then
				text = text..self:GetMeleeText();
			else
				text = text..self:GetMeleeText();
			end
		end
		if self.data["CLASS_EN"] == "PRIEST" then
			if talentName == select(2, GetSpecializationInfo(1)) then
				text = text..self:GetSpellAndHealText();
			elseif talentName == select(2, GetSpecializationInfo(2)) then
				text = text..self:GetHealText();
			elseif talentName == select(2, GetSpecializationInfo(3)) then
				text = text..self:GetSpellText();
			else
				text = text..self:GetSpellText();
			end
		end
		if self.data["CLASS_EN"] == "WARRIOR" then
			if talentName == select(2, GetSpecializationInfo(1)) then
				text = text..self:GetMeleeText();
			elseif talentName == select(2, GetSpecializationInfo(2)) then
				text = text..self:GetMeleeText();
			elseif talentName == select(2, GetSpecializationInfo(3)) then
				text = text..self:GetTankText();
			else
				text = text..self:GetMeleeText();
			end
		end
		if self.data["CLASS_EN"] == "DEATHKNIGHT" then
			if talentName == select(2, GetSpecializationInfo(1)) then
				text = text..self:GetTankText();
			else
				text = text..self:GetMeleeText();
			end
		end
	end

	return text;
end

function D:GetPvPSpecText()
	local text = "";
	
	if (self.data["PvPSET"]) then
		text = text..(", %d%s"):format(self.data["CRDEF"], L["CRDEF"]);
	end
	return text;
end

function D:GetSpellText()
	local text = "";
	text = text..self:GetPvPSpecText();
	text = text..(", %d%s"):format(self.data["SSP"], L["SSP"]);
	text = text..(", %d%s"):format(self.data["SHIT"], L["HIT"]);
	text = text..(", %.1f%%%s"):format(self.data["SCRIT"], L["CRIT"]);
	text = text..(", %.1f%%%s"):format(self.data["SHASTE"], STAT_HASTE);
	if (self.data["MST"]) then
		text = text..(", %d%s"):format(self.data["MST"], ITEM_MOD_MASTERY_RATING_SHORT);
	end
	if self.data["PvPSET"] then
		text = text..(", %d%s"):format(self.data["SPEN"], L["SPEN"]);
	end
	return text;
end

function D:GetHealText()
	local text = "";
	text = text..self:GetPvPSpecText();
	text = text..(", %d%s"):format(self.data["SHP"], L["SHP"]);	
	text = text..(", %.1f%%%s"):format(self.data["SCRIT"], L["CRIT"]);
	text = text..(", %.1f%%%s"):format(self.data["SHASTE"], STAT_HASTE);
	text = text..(", %d/%s"):format(self.data["SMR"], L["SMR"]);
	if (self.data["MST"]) then
		text = text..(", %d%s"):format(self.data["MST"], ITEM_MOD_MASTERY_RATING_SHORT);
	end
	return text;
end

function D:GetSpellAndHealText()
	local text = "";
	text = text..self:GetPvPSpecText();
	text = text..(", %d%s"):format(self.data["SSP"], L["SSP"]);	
	text = text..(", %d%s"):format(self.data["SHP"], L["SHP"]);	
	text = text..(", %d%s"):format(self.data["SHIT"], L["HIT"]);	
	text = text..(", %.1f%%%s"):format(self.data["SCRIT"], L["CRIT"]);
	text = text..(", %.1f%%%s"):format(self.data["SHASTE"], STAT_HASTE);
	text = text..(", %d/%s"):format(self.data["SMR"], L["SMR"]);
	if (self.data["MST"]) then
		text = text..(", %d%s"):format(self.data["MST"], ITEM_MOD_MASTERY_RATING_SHORT);
	end

	if self.data["PvPSET"] then
		text = text..(", %d%s"):format(self.data["SPEN"], L["SPEN"]);
	end
	return text;
end

function D:GetMeleeText()
	local text = "";
	text = text..self:GetPvPSpecText();
	text = text..(", %d%s"):format(self.data["MAP"], L["AP"]);	
	text = text..(", %d%s"):format(self.data["MHIT"], L["HIT"]);	
	text = text..(", %.1f%%%s"):format(self.data["MCRIT"], L["CRIT"]);
	text = text..(", %.1f%%%s"):format(self.data["MEXPER"], L["EXPER"]);
	text = text..(", %.1f%%%s"):format(self.data["MHASTE"], STAT_HASTE);
	if (self.data["MST"]) then
		text = text..(", %d%s"):format(self.data["MST"], ITEM_MOD_MASTERY_RATING_SHORT);
	end
	--text = text..(", %.1f%%%s"):format(self.data["MRPEN"], L["MRPEN"]);

	return text;
end

function D:GetRangedText()
	local text = "";
	text = text..self:GetPvPSpecText();
	text = text..(", %d%s"):format(self.data["RAP"], L["AP"]);
	text = text..(", %d%s"):format(self.data["RHIT"], L["HIT"]);
	text = text..(", %.1f%%%s"):format(self.data["RCRIT"], L["CRIT"]);
    text = text..(", %.1f%%%s"):format(self.data["RHASTE"], STAT_HASTE);
	if (self.data["MST"]) then
		text = text..(", %d%s"):format(self.data["MST"], ITEM_MOD_MASTERY_RATING_SHORT);
	end
	--text = text..(", %.1f%%%s"):format(self.data["MRPEN"], L["MRPEN"]);

	return text;
end

function D:GetTankText()
	local text = "";
	text = text..self:GetPvPSpecText();
	text = text..(", %d%s"):format(self.data["DEF"], L["DEF"]);
	text = text..(", %.1f%%%s"):format(self.data["DODGE"], L["DODGE"]);
	text = text..(", %.1f%%%s"):format(self.data["PARRY"], L["PARRY"]);
	text = text..(", %.1f%%%s"):format(self.data["BLOCK"], L["BLOCK"]);
	text = text..(", %d%s"):format(self.data["ARMOR"], L["ARMOR"]);
	if (self.data["MST"]) then
		text = text..(", %d%s"):format(self.data["MST"], ITEM_MOD_MASTERY_RATING_SHORT);
	end

	return text;
end

function D:UnitTalent(names, points)
	local index = 1;

	if (points[3] > points[1] and points[3] > points[2]) then
		index = 3;
	elseif (points[2] > points[1]) then
		index = 2;
	end

	local point = ("(%d/%d/%d)"):format(points[1], points[2], points[3]);

	return names[index]..point, names[index], point;
end

function D:GetTalent()
    if(UnitLevel'player' < 10) then return end
    local text = ''
    local activeSpec = GetActiveSpecGroup()
    local numSpecs = GetNumSpecGroups()

    local spec = GetSpecialization()
    if(spec) then
        local _, name = GetSpecializationInfo(spec)
        text = text .. L.MTALENT .. name
    end

    if(numSpecs > 1) then
        local spec = GetSpecialization(3 - activeSpec)
        if(spec) then
            local _, name = GetSpecializationInfo(spec)
            text = text .. ', ' ..L.STALENT .. name
        end
    end
    return text

--     -- 主天赋
--     local names, points = {}, {};
--     for i = 1, 3 do
--         _, names[i], _, _, points[i] = GetSpecializationInfo(i, false, nil, activeTalent)
--     end

--     text = L["MTALENT"] .. self:UnitTalent(names, points);

--     -- 副天赋
--     if(GetNumSpecGroups() == 2) then
--         local has_points = false
--         for i = 1, 3 do
--             _, names[i], _, _, points[i] = GetSpecializationInfo(i, false, nil, 3 - activeTalent)
--             if(points[i] > 0) then
--                 has_points = true
--             end
--         end

--         if(has_points) then
--             local _, tmp = self:UnitTalent(names, points);
--             text = text .. ", " .. L["STALENT"] .. tmp;
--         end
--     end

--     return text;
end

function D:GetMainTalentName()
    local spec = GetSpecialization()
    return spec and GetSpecializationInfo(spec) or NONE
	-- local name;
	-- if (UnitLevel("player") >= 10) then		
	-- 	local activeTalent = GetActiveSpecGroup();
        -- GetSpecialization()
	-- 	local names, points = {}, {};
	-- 	for i=1, 3 do
	-- 		_, names[i], _, _, points[i] = GetSpecializationInfo(i, false, nil, activeTalent);
	-- 	end
	-- 	local index = 1;
	-- 	if (points[3] > points[1] and points[3] > points[2]) then
	-- 		index = 3;
	-- 	elseif (points[2] > points[1]) then
	-- 		index = 2;
	-- 	end

	-- 	name = names[index];
	-- end

	-- return name;
end

function D:GetINVLevel()
	return math.floor(GetAverageItemLevel());
end

function D:GetGS()
	local score = 0;
	if (GearScore_GetScore) then
		score = GearScore_GetScore(UnitName("player"), "player") or 0;
	end
	
	return score;
end

function D:UnitAttackPower()
	local base, posBuff, negBuff = UnitAttackPower("player");
	return floor(base + posBuff + negBuff);
end

function D:UnitRangedAttackPower()
	local base, posBuff, negBuff = UnitRangedAttackPower("player");
	return floor(base + posBuff + negBuff);
end

function D:GetSpellBonusDamage()
	local SSP = GetSpellBonusDamage(2);
	for i=3, 7 do
		SSP = max(SSP, GetSpellBonusDamage(i));
	end
	return floor(SSP);
end

function D:GetSpellCritChance()
	local SCRIT = GetSpellCritChance(2);
	for i=3, 7 do
		SCRIT = max(SCRIT, GetSpellCritChance(i));
	end
	return SCRIT;
end

function D:GetUnitDefense()
	local baseDEF, posDEF = UnitDefense("player");
	return floor(baseDEF + posDEF);
end


function D:InsertStat(detail)
	local text = self:GenerateStatText(detail);
    local chatFrame = GetCVar("chatStyle")=="im" and SELECTED_CHAT_FRAME or DEFAULT_CHAT_FRAME

    chatFrame.editBox:Show();
    chatFrame.editBox:Insert(text);
    --chatFrame.editBox:HighlightText()
    chatFrame.editBox:SetFocus()
end

function D:ReplyStat(name)
    local chatFrame = GetCVar("chatStyle")=="im" and SELECTED_CHAT_FRAME or DEFAULT_CHAT_FRAME
	
	if ( name ~= "" ) then
		chatFrame.editBox:SetAttribute("chatType", "WHISPER");
		chatFrame.editBox:SetAttribute("tellTarget", name);
		ChatEdit_UpdateHeader(chatFrame.editBox);
		
		self:InsertStat();
	end
end

function DuowanStat_Toggle(switch)
	if (switch) then
		DWCReportStatButton:Show();
		DWCRandomButton:Show();
		dwChannelMuteButton:Show();
	else
		DWCReportStatButton:Hide();
		DWCRandomButton:Hide();
		dwChannelMuteButton:Hide();
	end
end
