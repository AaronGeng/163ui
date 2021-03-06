﻿local mod	= DBM:NewMod(654, "DBM-Party-MoP", 8, 311)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)

mod:SetRevision(("$Revision: 9469 $"):sub(12, -3))
mod:SetCreatureID(58632)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_REMOVED",
	"RAID_BOSS_EMOTE"
)

--All data confirmed and accurate for normal mode scarlet halls. heroic data should be quite similar but with diff spellids, will wait for logs to assume anything there.
local warnDragonsReach			= mod:NewSpellAnnounce(111217, 2)
local warnCallReinforcements	= mod:NewSpellAnnounce("ej5378", 3)--triggers only found in emote
local warnBladesofLight			= mod:NewCastAnnounce(111216, 4)

local specWarnBladesofLight		= mod:NewSpecialWarningSpell(111216, nil, nil, nil, true)

local timerDragonsReachCD		= mod:NewCDTimer(7, 111217)--12 on normal, 7 on heroic, OR, 7 in both and it was buffed on normal since i've run it. For time being i'll make it 7 but change it from next to CD
local timerCallReinforcementsCD	= mod:NewCDTimer(20, "ej5378")--adjusted in build 15799?
local timerBladesofLightCD		= mod:NewNextTimer(30, 111216)

--CallReinforcementsCD DATA
--"<1789.8> RAID_BOSS_EMOTE#|TInterface\\Icons\\ability_warrior_battleshout.blp:20|tArmsmaster Harlan calls on two of his allies to join the fight!#0#false", -- [19]
--"<1810.3> RAID_BOSS_EMOTE#|TInterface\\Icons\\inv_weapon_halberd_05.blp:20|tArmsmaster Harlan casts |cFFFF0000|Hspell:111216|h[Blades of Light]|h|r!#2#false", -- [20]
--"<1819.8> RAID_BOSS_EMOTE#|TInterface\\Icons\\ability_warrior_battleshout.blp:20|tArmsmaster Harlan calls on two of his allies to join the fight!#0#false", -- [21]
--"<1844.1> RAID_BOSS_EMOTE#|TInterface\\Icons\\ability_warrior_battleshout.blp:20|tArmsmaster Harlan calls on two of his allies to join the fight!#0#false", -- [22]

function mod:OnCombatStart(delay)
	timerDragonsReachCD:Start(-delay)
	timerCallReinforcementsCD:Start(-delay)
	sndWOP:Schedule(20, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\mobsoon.mp3")--準備小怪
	timerBladesofLightCD:Start(40-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 111217 then
		warnDragonsReach:Show()
		timerDragonsReachCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 111216 then
		warnBladesofLight:Show()
		specWarnBladesofLight:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\wwsoon.mp3")--準備旋風
		sndWOP:Schedule(1.5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
		sndWOP:Schedule(2.5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
		sndWOP:Schedule(3.5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Schedule(4.5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Schedule(5.5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		timerDragonsReachCD:Cancel()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 111216 then
		timerBladesofLightCD:Start()
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Call or msg:find(L.Call) then
		warnCallReinforcements:Show()
		timerCallReinforcementsCD:Start()
		sndWOP:Schedule(20, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\mobsoon.mp3")--準備小怪
	end
end
