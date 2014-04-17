﻿-- zhTW.lua by 血煞天魂@愤怒使者

do
	if (GetLocale() == "zhTW") then
		Gladius.L = setmetatable({
			["Frame"] = "框體",
			["Welcome to Gladius!"] = "歡迎使用Gladius!",
			["First run has been detected, displaying test frame."] = "偵測到為第一次使用，顯示測試框架。",
			["Valid slash commands are:"] = "有效的斜線+指令是:",
			["/gladius ui"] = "/gladius ui",
			["/gladius test 2-5"] = "/gladius test 2-5",
			["/gladius hide"] = "/gladius hide",
			["/gladius reset"] = "/gladius reset",
			["If this is not your first run please lock or move the frame to prevent this from happening."] = "如果您不是第一次使用，請鎖定或者移動此框架以防止這類情況發生。",
			["LEFT"] = "左",
			["CENTER"] = "中",
			["RIGHT"] = "右",
			["Top Left"] = "左上",
			["Top Right"] = "右上",
			["Center Left"] = "左中",
			["Center Right"] = "右中",
			["Bottom Left"] = "左下",
			["Bottom Right"] = "右下",
			["Enable Module"] = "啟用模組",
			["Reset Module"] = "重置模組",
			["Module Templates"] = "模組的樣板",
			["General"] = "一般",
			["General settings"] = "一般設定",
			["Lock frame"] = "鎖定框架",
			["Toggle if the frame can be moved"] = "勾選後框架就不能被移動了",
			["Grow frame upwards"] = "框架向上延伸",
			["If this is toggled the frame will grow upwards instead of downwards."] = "勾選後框架將向上延伸而不是向下。",
			["Group Buttons"] = "隊伍按鈕",
			["If this is toggle buttons can be moved separately"] = "勾選後按鈕可以分別移動",
			["Advanced Options"] = "進階選項",
			["Toggle advanced options"] = "切換進階選項",
			["Frame settings"] = "框架設定",
			["Background Color"] = "背景顏色",
			["Color of the frame background"] = "框架背景的顏色",
			["Background Padding"] = "背景間距",
			["Padding of the background"] = "背景的間距",
			["Bottom Margin"] = "按鈕間隔",
			["Margin between each button"] = "按鈕的間隔",
			["Size"] = "大小",
			["Size settings"] = "大小設定",
			["Bar width"] = "狀態條寬",
			["Width of the module bars"] = "模組狀態條的寬度",
			["Frame scale"] = "框架比例",
			["Scale of the frame"] = "框架的比例",
			["Font"] = "字型",
			["Font settings"] = "字型設定",
			["Global Font"] = "整體字型",
			["Global font, used by the modules"] = "使用於模組的整體字型",
			["Global Font Size"] = "整體字型大小",
			["Text size of the power info text"] = "動能條資訊文字的大小",
			["Use Global Font Size"] = "使用整體字型大小",
			["Toggle if you want to use the global font size"] = "勾選後將使用整體字型大小",
			["Arms"] = "武器",
			["Fury"] = "狂怒",
			["Protection"] = "防護",
			["Holy"] = "神聖",
			["Retribution"] = "懲戒",
			["Assassination"] = "刺殺",
			["Combat"] = "戰鬥",
			["Subtlety"] = "敏銳",
			["Discipline"] = "戒律",
			["Shadow"] = "暗影",
			["Blood"] = "血魄",
			["Frost"] = "冰霜",
			["Unholy"] = "穢邪",
			["Arcane"] = "秘法",
			["Fire"] = "火焰",
			["Affliction"] = "痛苦",
			["Demonology"] = "惡魔學識",
			["Destruction"] = "毀滅",
			["Elemental"] = "元素",
			["Enhancement"] = "增強",
			["Restoration"] = "恢復",
			["Beast Mastery"] = "野獸控制",
			["Marksmanship"] = "射擊",
			["Survival"] = "生存",
			["Balance"] = "平衡",
			["Feral"] = "野性戰鬥",
			["%s - %s"] = "%s - %s",
			["SPEC DETECTED: %s (%s)"] = "偵測到天賦: %s (%s)",
			["LOW HEALTH: %s (%s)"] = "低生命值: %s (%s)",
			["DRINKING: %s (%s)"] = "喝水: %s (%s)",
			["RESURRECTING: %s (%s)"] = "復活中: %s (%s)",
			["Self"] = "自身",
			["Party"] = "隊伍",
			["Say"] = "說",
			["Raid Warning"] = "團隊警告",
			["Scrolling Combat Text"] = "SCT",
			["MikScrollingBattleText"] = "MSCT",
			["Blizzard's Floating Combat Text"] = "暴雪的FCT",
			["Parrot"] = "Parrot",
			["Options"] = "選項",
			["Destination"] = "通告方式",
			["Choose how your announcements are displayed."] = "選擇您想要的顯示通告方式。",
			["Low health threshold"] = "低生命值門檻",
			["Choose how low an enemy must be before low health is announced."] = "選擇敵人低於多少生命值時通告。",
			["Announcement toggles"] = "切換通告",
			["New enemies"] = "新敵人",
			["Announces when new enemies are discovered."] = "當發現新敵人時通告。",
			["Drinking"] = "喝水",
			["Announces when enemies sit down to drink."] = "當敵人坐下喝水時通告。",
			["Low health"] = "低生命值",
			["Announces when an enemy drops below a certain health threshold."] = "當敵人的生命值低於門檻時通告。",
			["Resurrection"] = "復活",
			["Announces when an enemy tries to resurrect a teammate."] = "當敵人試圖復活隊友時通告。",
			["Spec Detection"] = "偵測天賦",
			["Announces when the spec of an enemy was detected."] = "當偵測到敵人的天賦時通告。",
			["Buffs"] = "增益",
			["Widget"] = "小工具",
			["Widget settings"] = "小工具設定",
			["Auras Buffs"] = "增益光環",
			["Toggle aura buffs"] = "切換增益光環",
			["Auras Column Grow"] = "光環列延伸",
			["Grow direction of the auras"] = "光環的延伸方向",
			["Up Left"] = "左上",
			["Up Right"] = "右上",
			["Down Left"] = "左下",
			["Down Right"] = "右下",
			["Aura Icons Per Column"] = "每列光環圖示",
			["Number of aura icons per column"] = "每列光環圖示的數量",
			["Aura Icons Max"] = "最大光環圖示",
			["Number of max buffs"] = "增益的最大數量",
			["Auras Gloss"] = "覆蓋光環",
			["Toggle gloss on the auras icon"] = "選擇覆蓋的光環圖示",
			["Auras Gloss Color"] = "覆蓋光環顏色",
			["Color of the auras icon gloss"] = "覆蓋光環圖示的顏色",
			["Aura Icon Width"] = "光環圖示寬",
			["Width of the aura icons"] = "光環圖示的寬度",
			["Aura Icon Height"] = "光環圖示高",
			["Height of the aura icon"] = "光環圖示的高度",
			["Auras Spacing Vertical"] = "光環垂直間距",
			["Vertical spacing of the auras"] = "光環的垂直間距",
			["Auras Spacing Horizontal"] = "光環水平間距",
			["Horizontal spacing of the auras"] = "光環的水平間距",
			["Position"] = "位置",
			["Position settings"] = "位置設定",
			["Auras Attach To"] = "光環附加到",
			["Attach auras to the given frame"] = "附加光環到選定的框架",
			["Auras Anchor"] = "光環錨點",
			["Anchor of the auras"] = "光環的錨點",
			["Auras Relative Point"] = "光環相對定位點",
			["Relative point of the auras"] = "光環的相對定位點",
			["Auras Offset X"] = "光環位移 X",
			["X offset of the auras"] = "光環的位移 X",
			["Auras Offset Y"] = "光環位移 Y",
			["Y offset of the auras"] = "光環的位移 Y",
			["Filter"] = "篩選",
			["Whitelist"] = "白名單",
			["Blacklist"] = "黑名單",
			["Filter Function"] = "篩選功能",
			["Debuffs"] = "減益",
			["Auras Debuffs"] = "減益光環",
			["Toggle aura debuffs"] = "切換減益光環",
			["Number of max Debuffs"] = "減益的最大數量",
			["Auras"] = "光環",
			["New Aura"] = "新光環",
			["Name"] = "名稱",
			["Name of the aura"] = "光環的名稱",
			["Priority"] = "優先順序",
			["Select what priority the aura should have - higher equals more priority"] = "選擇光環的優先順序，數字越大優先順序越高",
			["Add new Aura"] = "新增新光環",
			["Delete"] = "刪除",
			["Example Spell Name"] = "法術名稱範例",
			["Bar"] = "狀態條",
			["Bar settings"] = "狀態條設定",
			["Cast Bar Color"] = "施法條顏色",
			["Color of the cast bar"] = "施法條的顏色",
			["Cast Bar Background Color"] = "施法條背景顏色",
			["Color of the cast bar background"] = "施法條背景的顏色",
			["Cast Bar Inverse"] = "施法條反向",
			["Inverse the cast bar"] = "施法條反向",
			["Cast Bar Texture"] = "施法條材質",
			["Texture of the cast bar"] = "施法條的材質",
			["Cast Bar Icon"] = "施法條圖示",
			["Toggle the cast icon"] = "切換施法條圖示",
			["Cast Bar Icon Position"] = "施法條圖示位置",
			["Position of the cast bar icon"] = "施法條圖示的位置",
			["Cast Bar Adjust Width"] = "調整施法條寬度",
			["Adjust cast bar width to the frame width"] = "調整施法條寬跟框架一樣寬",
			["Cast Bar Width"] = "施法條寬",
			["Width of the cast bar"] = "施法條的寬度",
			["Cast Bar Height"] = "施法條高",
			["Height of the cast bar"] = "施法條的高度",
			["Cast Bar Attach To"] = "施法條附加到",
			["Attach cast bar to the given frame"] = "附加施法條到選定的框架",
			["Cast Bar Anchor"] = "施法條錨點",
			["Anchor of the cast bar"] = "施法條的錨點",
			["Cast Bar Relative Point"] = "施法條相對定位點",
			["Relative point of the cast bar"] = "施法條的相對定位點",
			["Cast Bar Offset X"] = "施法條位移 X",
			["X offset of the cast bar"] = "施法條的位移 X",
			["Cast Bar Offset Y"] = "施法條位移 Y",
			["Y offset of the castbar"] = "施法條的位移 Y",
			["Cast Text"] = "施法文字",
			["Text"] = "文字",
			["Text settings"] = "文字設定",
			["Toggle cast text"] = "切換施法文字",
			["Cast Text Color"] = "施法文字顏色",
			["Text color of the cast text"] = "施法文字的顏色",
			["Cast Text Size"] = "施法文字大小",
			["Text size of the cast text"] = "施法文字的大小",
			["Cast Text Align"] = "施法文字對齊",
			["Text align of the cast text"] = "施法文字的對齊",
			["Cast Text Offset X"] = "施法文字位移 X",
			["X offset of the cast text"] = "施法文字的位移 X",
			["Cast Text Offset Y"] = "施法文字位移 Y",
			["Y offset of the cast text"] = "施法文字的位移 Y",
			["Cast Time Text"] = "施法時間文字",
			["Toggle cast time text"] = "切換施法時間文字",
			["Cast Time Text Color"] = "施法時間文字顏色",
			["Text color of the cast time text"] = "施法時間文字的顏色",
			["Cast Time Text Size"] = "施法時間文字大小",
			["Text size of the cast time text"] = "施法時間文字的大小",
			["Cast Time Text Align"] = "施法時間文字對齊",
			["Text align of the cast time text"] = "施法時間文字的對齊",
			["Cast Time Offset X"] = "施法時間文字位移 X",
			["X Offset of the cast time text"] = "施法時間文字的位移 X",
			["Cast Time Offset Y"] = "施法時間文字位移 Y",
			["Y Offset of the cast time text"] = "施法時間文字的位移 Y",
			["Class Icon Important Auras"] = "職業圖示裡的重要光環",
			["Show important auras instead of the class icon"] = "在職業圖示裡顯示重要光環",
			["Class Icon Crop Borders"] = "裁剪職業圖示邊框",
			["Toggle if the class icon borders should be cropped or not."] = "是否需要裁剪職業圖示邊框。",
			["Class Icon Cooldown Spiral"] = "職業圖示裡的冷卻倒數",
			["Display the cooldown spiral for important auras"] = "為重要光環顯示冷卻倒數",
			["Class Icon Cooldown Reverse"] = "職業圖示裡的冷卻反轉",
			["Invert the dark/bright part of the cooldown spiral"] = "冷卻倒數中的明暗反向",
			["Class Icon Gloss"] = "覆蓋職業圖示",
			["Toggle gloss on the class icon"] = "切換覆蓋的職業圖示",
			["Class Icon Gloss Color"] = "覆蓋職業圖示顏色",
			["Color of the class icon gloss"] = "覆蓋職業圖示的顏色",
			["Class Icon Frame Level"] = "職業圖示框架層級",
			["Frame level of the class icon"] = "職業圖示的框架層級",
			["Class Icon Adjust Size"] = "調整職業圖示大小",
			["Adjust class icon size to the frame size"] = "調整職業圖示的大小",
			["Class Icon Size"] = "職業圖示大小",
			["Size of the class icon"] = "職業圖示的大小",
			["Class Icon Attach To"] = "職業圖示附加到",
			["Attach class icon to given frame"] = "附加職業圖示到選定的框架",
			["Class Icon Position"] = "職業圖示位置",
			["Position of the class icon"] = "職業圖示的位置",
			["Left"] = "左",
			["Right"] = "右",
			["Class Icon Anchor"] = "職業圖示錨點",
			["Anchor of the class icon"] = "職業圖示的錨點",
			["Class Icon Relative Point"] = "職業圖示相對定位點",
			["Relative point of the class icon"] = "職業圖示的相對定位點",
			["Class Icon Offset X"] = "職業圖示位移 X",
			["X offset of the class icon"] = "職業圖示的位移 X",
			["Class Icon Offset Y"] = "職業圖示位移 Y",
			["Y offset of the class icon"] = "職業圖示的位移 Y",
			["Middle"] = "中鍵",
			["Button 4"] = "按鈕 4",
			["Button 5"] = "按鈕 5",
			["None"] = "無",
			["ctrl-"] = "ctrl-",
			["shift-"] = "shift-",
			["alt-"] = "alt-",
			["Click Actions"] = "點擊執行",
			["Add click action"] = "新增點擊執行",
			["Mouse button"] = "滑鼠按鈕",
			["Select which mouse button this click action uses"] = "選擇哪個滑鼠按鈕來點擊執行",
			["Modifier"] = "附加主鍵",
			["Select a modifier for this click action"] = "選擇修改此點擊執行",
			["Add"] = "新增",
			["Delete Click Action"] = "刪除點擊執行",
			["Action"] = "執行",
			["Select what this Click Action does"] = "選擇點擊執行該做甚麼指令",
			["Cast Spell"] = "施放法術",
			["Spell Name / Macro Text"] = "法術名稱 / 巨集指令",
			["DRTracker Space"] = "控場追蹤間隔",
			["Space between the icons"] = "圖示之間的間隔",
			["DRTracker Cooldown Spiral"] = "控場追蹤冷卻倒數",
			["DRTracker Cooldown Reverse"] = "控場追蹤冷卻反轉",
			["DRTracker Gloss"] = "覆蓋控場追蹤",
			["Toggle gloss on the drTracker icon"] = "切換覆蓋控場追蹤圖示",
			["DRTracker Gloss Color"] = "覆蓋控場追蹤顏色",
			["Color of the drTracker icon gloss"] = "覆蓋控場追蹤的顏色",
			["DRTracker Frame Level"] = "控場追蹤框架層級",
			["Frame level of the drTracker"] = "控場追蹤框架的層級",
			["DRTracker Adjust Size"] = "調整控場追蹤大小",
			["Adjust drTracker size to the frame size"] = "調整控場追蹤大小跟框架一樣大",
			["DRTracker Size"] = "控場追蹤大小",
			["Size of the drTracker"] = "控場追蹤的大小",
			["DR Text Color"] = "控場文字顏色",
			["Text color of the DR text"] = "控場文字的顏色",
			["DR Text Size"] = "控場文字大小",
			["Text size of the DR text"] = "控場文字的大小",
			["DRTracker Attach To"] = "控場追蹤附加到",
			["Attach drTracker to the given frame"] = "附加控場追蹤到選定的框架",
			["DRTracker Position"] = "控場追蹤位置",
			["DRTracker Anchor"] = "控場追蹤錨點",
			["Anchor of the drTracker"] = "控場追蹤的錨點",
			["DRTracker Relative Point"] = "控場追蹤相對定位點",
			["Relative point of the drTracker"] = "控場追蹤的相對定位點",
			["DRTracker Offset X"] = "控場追蹤位移 X",
			["X offset of the drTracker"] = "控場追蹤的位移 X",
			["DRTracker Offset Y"] = "控場追蹤位移 Y",
			["Y offset of the drTracker"] = "控場追蹤的位移 Y",
			["Categories"] = "類別",
			["Category settings"] = "類別設定",
			["Health bar class color"] = "生命條職業顏色",
			["Toggle health bar class color"] = "切換生命條的職業顏色",
			["Health bar color"] = "生命條顏色",
			["Color of the health bar"] = "生命條的顏色",
			["Health bar background color"] = "生命條背景顏色",
			["Color of the health bar background"] = "生命條背景的顏色",
			["Health bar inverse"] = "生命條反向",
			["Inverse the health bar"] = "生命條的反向",
			["Health bar texture"] = "生命條材質",
			["Texture of the health bar"] = "生命條的材質",
			["Health bar adjust width"] = "調整生命條寬",
			["Adjust health bar width to the frame width"] = "調整生命條寬跟框架一樣寬",
			["Health bar width"] = "生命條寬",
			["Width of the health bar"] = "生命條的寬度",
			["Health bar height"] = "生命條高",
			["Height of the health bar"] = "生命條的高度",
			["Health Bar Attach To"] = "生命條附加到",
			["Attach health bar to the given frame"] = "附加生命條到選定的框架",
			["Health Bar Anchor"] = "生命條錨點",
			["Anchor of the health bar"] = "生命條的錨點",
			["Health Bar Relative Point"] = "生命條相對定位點",
			["Relative point of the health bar"] = "生命條的相對定位點",
			["Health bar offset X"] = "生命條位移 X",
			["X offset of the health bar"] = "生命條的位移 X",
			["Health bar offset Y"] = "生命條位移 Y",
			["Y offset of the health bar"] = "生命條的位移 Y",
			["Health colors"] = "生命條顏色",
			["Default priest color"] = "預設的牧師顏色",
			["Toggle default priest color"] = "切換預設的牧師顏色",
			["Priest color"] = "牧師顏色",
			["Default paladin color"] = "預設的聖騎士顏色",
			["Toggle default paladin color"] = "切換預設的聖騎士顏色",
			["Paladin color"] = "聖騎士顏色",
			["Default shaman color"] = "預設的薩滿顏色",
			["Toggle default shaman color"] = "切換預設的薩滿顏色",
			["Shaman color"] = "薩滿顏色",
			["Default druid color"] = "預設的德魯伊顏色",
			["Toggle default druid color"] = "切換預設的德魯伊顏色",
			["Druid color"] = "德魯伊顏色",
			["Default mage color"] = "預設的法師顏色",
			["Toggle default mage color"] = "切換預設的法師顏色",
			["Mage color"] = "法師顏色",
			["Default warlock color"] = "預設的術士顏色",
			["Toggle default warlock color"] = "切換預設的術士顏色",
			["Warlock color"] = "術士顏色",
			["Default hunter color"] = "預設的獵人顏色",
			["Toggle default hunter color"] = "切換預設的獵人顏色",
			["Hunter color"] = "獵人顏色",
			["Default warrior color"] = "預設的戰士顏色",
			["Toggle default warrior color"] = "切換預設的戰士顏色",
			["Warrior color"] = "戰士顏色",
			["Default rogue color"] = "預設的盜賊顏色",
			["Toggle default eogue color"] = "切換預設的盜賊顏色",
			["Rogue color"] = "盜賊顏色",
			["Default death knight color"] = "預設的死亡騎士顏色",
			["Toggle default death knight color"] = "切換預設的死亡騎士顏色",
			["Death knight color"] = "死亡騎士顏色",
			["Hover"] = "懸停",
			["Hover settings"] = "懸停設定",
			["Highlight On Mouseover"] = "高亮游標懸停",
			["Highlight frame on mouseover"] = "高亮游標懸停的框架",
			["Highlight Color"] = "高亮顏色",
			["Color of the highlight frame"] = "高亮框架的顏色",
			["Player Target"] = "玩家目標",
			["Player target settings"] = "玩家目標設定",
			["Highlight Target"] = "高亮目標",
			["Show border around player target"] = "顯示玩家目標周圍邊框",
			["Highlight Target Color"] = "高亮目標顏色",
			["Color of the target border"] = "目標邊框的顏色",
			["Highlight Target Priority"] = "高亮目標優先權",
			["Priority of the target border"] = "目標邊框的優先權",
			["Player Focus Target"] = "玩家專注目標",
			["Player focus target settings"] = "玩家專注目標設定",
			["Highlight Focus Target"] = "高亮專注目標",
			["Highlight Focus Target Color"] = "高亮專注目標顏色",
			["Color of the focus target border"] = "專注目標邊框的顏色",
			["Highlight Focus Target Priority"] = "高亮專注目標的優先權",
			["Priority of the focus target border"] = "專注目標邊框的優先權",
			["Raid Assist Target"] = "團隊助攻目標",
			["Raid assist settings"] = "團隊助攻設定",
			["Highlight Raid Assist"] = "高亮團隊助攻",
			["Show border around raid assist"] = "顯示團隊助攻周圍邊框",
			["Highlight Raid Assist Color"] = "高亮團隊助攻顏色",
			["Color of the raid assist border"] = "團隊助攻邊框的顏色",
			["Highlight Raid Assist Priority"] = "高亮團隊助攻優先權",
			["Priority of the raid assist border"] = "團隊助攻邊框的優先權",
			["Raid Icon Targets"] = "團隊目標圖示",
			["Raid Icon target 1 settings"] = "團隊目標圖示 1 設定",
			["Raid Icon target 2 settings"] = "團隊目標圖示 2 設定",
			["Raid Icon target 3 settings"] = "團隊目標圖示 3 設定",
			["Raid Icon target 4 settings"] = "團隊目標圖示 4 設定",
			["Raid Icon target 5 settings"] = "團隊目標圖示 5 設定",
			["Raid Icon target 6 settings"] = "團隊目標圖示 6 設定",
			["Raid Icon target 7 settings"] = "團隊目標圖示 7 設定",
			["Raid Icon target 8 settings"] = "團隊目標圖示 8 設定",
			["Layout Code"] = "編排代碼",
			["Code of your layout."] = "你的編排代碼。",
			["Import layout"] = "匯入編排",
			["Import your layout code."] = "匯入你的編排代碼。",
			["Error while importing layout: %s"] = "匯入編排代碼錯誤: %s",
			["Power Bar Default Color"] = "動能條預設顏色",
			["Toggle power bar default color"] = "切換動能條預設的顏色",
			["Power Bar Color"] = "動能條顏色",
			["Color of the power bar"] = "動能條的顏色",
			["Power Bar Background Color"] = "動能條背景顏色",
			["Color of the power bar background"] = "動能條背景的顏色",
			["Power Bar Inverse"] = "動能條反向",
			["Inverse the power bar"] = "動能條的反向",
			["Power Bar Texture"] = "動能條材質",
			["Texture of the power bar"] = "動能條的材質",
			["Power Bar Adjust Width"] = "調整動能條寬",
			["Adjust power bar width to the frame width"] = "調整動能條寬跟框架一樣寬",
			["Power Bar Width"] = "動能條寬",
			["Width of the power bar"] = "動能條的寬度",
			["Power Bar Height"] = "動能條高",
			["Height of the power bar"] = "動能條的高度",
			["Power Bar Attach To"] = "動能條附加到",
			["Attach power bar to the given frame"] = "附加動能條到選定的框架",
			["Power Bar Anchor"] = "動能條錨點",
			["Anchor of the power bar"] = "動能條的錨點",
			["Power Bar Relative Point"] = "動能條相對定位點",
			["Relative point of the power bar"] = "動能條的相對定位點",
			["Power Bar Offset X"] = "動能條位移 X",
			["X offset of the power bar"] = "動能條的位移 X",
			["Power Bar Offset Y"] = "動能條位移 Y",
			["Power colors"] = "動能顏色",
			["Default Power Mana Color"] = "預設的法力顏色",
			["Toggle default power mana color"] = "切換預設的法力顏色",
			["Power Mana Color"] = "法力顏色",
			["Default Power Rage Color"] = "預設的怒氣顏色",
			["Toggle default power rage color"] = "切換預設的怒氣顏色",
			["Power Rage Color"] = "怒氣顏色",
			["Default Power Focus Color"] = "預設的集中顏色",
			["Toggle default power focus color"] = "切換預設的集中顏色",
			["Power Focus Color"] = "集中顏色",
			["Default Power Energy Color"] = "預設的動能顏色",
			["Toggle default power energy color"] = "切換預設的動能顏色",
			["Power Energy Color"] = "動能顏色",
			["Default Power Runic Power Color"] = "預設的符能顏色",
			["Toggle default power runic power color"] = "切換預設的符能顏色",
			["Power Runic Power Color"] = "符能顏色",
			["Texts"] = "文字選項",
			["Add text"] = "新增文字",
			["Name of the text element"] = "文字要素名稱",
			["Text Attach To"] = "文字附加到",
			["Attach text to module bar"] = "附加文字到模組條",
			["Add Text"] = "新增文字",
			["Tags"] = "標籤",
			["Add tag"] = "新增標籤",
			["Name of the tag"] = "標籤的名稱",
			["Add Tag"] = "新增標籤",
			["Tag: %s"] = "標籤: %s",
			["Text to be displayed"] = "要顯示的文字",
			["Delete Text"] = "刪除文字",
			["Tag"] = "標籤",
			["Tag settings"] = "標籤設定",
			["Text Color"] = "文字顏色",
			["Text color of the text"] = "文字的顏色",
			["Text Size"] = "文字大小",
			["Text size of the text"] = "文字的大小",
			["Text Align"] = "文字對齊",
			["Text align of the text"] = "文字的對齊",
			["Text Offset X"] = "文字位移 X",
			["X offset of the text"] = "文字的位移 X",
			["Text Offset Y"] = "文字位移 Y",
			["Y offset of the text"] = "文字的位移 Y",
			["Delete Tag"] = "刪除標籤",
			["Events"] = "事件",
			["Events which update the tag"] = "標籤隨著事件更新",
			["Function"] = "功能",
			["DEAD"] = "死亡",
			["Target bar health bar"] = "目標生命條",
			["Toggle health bar display"] = "切換顯示為生命條",
			["Target bar class color"] = "目標條職業顏色",
			["Target bar color"] = "目標條顏色",
			["Target bar background color"] = "目標條的背景顏色",
			["Target bar inverse"] = "目標條反向",
			["Target bar texture"] = "目標條材質",
			["Target bar class icon"] = "目標條職業圖示",
			["Toggle the target bar class icon"] = "切換目標條的職業圖示",
			["Target bar icon position"] = "目標條圖示位置",
			["Position of the target bar class icon"] = "目標條的職業圖示位置",
			["Target bar adjust width"] = "調整目標條寬",
			["Target bar width"] = "目標條寬",
			["Target bar height"] = "目標條高",
			["Target Bar Attach To"] = "目標條附加到",
			["Target Bar Anchor"] = "目標條錨點",
			["Target Bar Relative Point"] = "目標條相對定位點",
			["Target bar offset X"] = "目標條位移 X",
			["Target bar offset Y"] = "目標條位移 Y",
			["Timer Soon Color"] = "臨時計時器顏色",
			["Color of the timer when timeleft is less than 5 seconds."] = "當計時低於5秒時的計時器顏色。",
			["Timer Soon Size"] = "臨時計時器大小",
			["Text size of the timer when timeleft is less than 5 seconds."] = "當計時低於5秒時的計時器文字顏色。",
			["Timer Seconds Color"] = "計時器秒數顏色",
			["Color of the timer when timeleft is less than 60 seconds."] = "當計時低於60秒時的計時器顏色。",
			["Timer Seconds Size"] = "計時器秒數大小",
			["Text size of the timer when timeleft is less than 60 seconds."] = "當計時低於60秒時的計時器文字顏色。",
			["Timer Minutes Color"] = "計時器分鐘顏色",
			["Color of the timer when timeleft is greater than 60 seconds."] = "當計時高於60秒時的計時器顏色。",
			["Timer Minutes Size"] = "計時器分鐘大小",
			["Text size of the timer when timeleft is greater than 60 seconds."] = "當計時高於60秒時的計時器文字顏色。",
			["TRINKET USED: %s (%s)"] = "已使用飾品: %s (%s)",
			["TRINKET READY: %s (%s)"] = "飾品準備完畢: %s (%s)",
			["Trinket"] = "飾品",
			["Announces when an enemy uses a PvP trinket."] = "當一個敵人使用了PvP飾品時通告。",
			["Trinket Grid Style Icon"] = "Grid風格飾品圖示",
			["Toggle trinket grid style icon"] = "切換Grid風格的飾品圖示",
			["Trinket Grid Style Icon Color"] = "Grid風格飾品圖示顏色",
			["Color of the trinket grid style icon"] = "Grid風格的飾品圖示顏色",
			["Trinket Grid Style Icon Used Color"] = "Grid風格的飾品圖示已使用的顏色",
			["Color of the trinket grid style icon when it's on cooldown"] = "Grid風格的飾品圖示冷卻中的顏色",
			["Trinket Cooldown Spiral"] = "飾品冷卻倒數",
			["Trinket Cooldown Reverse"] = "飾品冷卻反轉",
			["Trinket Gloss"] = "飾品覆蓋",
			["Toggle gloss on the trinket icon"] = "切換覆蓋的飾品圖示",
			["Trinket Gloss Color"] = "飾品覆蓋顏色",
			["Color of the trinket icon gloss"] = "飾品圖示覆蓋的顏色",
			["Trinket Icon Border Crop"] = "裁剪飾品圖示邊框",
			["Toggle if the borders of the trinket icon should be cropped"] = "是否需要裁剪職業圖示邊框",
			["Trinket Icon Faction"] = "陣營飾品圖示",
			["Toggle if the trinket icon should be changing based on the opponents faction"] = "若要切換飾品圖示需在對方陣營的基礎上變更才行",
			["Trinket Frame Level"] = "飾品框架層級",
			["Frame level of the trinket"] = "飾品框架的層級",
			["Trinket Adjust Size"] = "調整飾品大小",
			["Adjust trinket size to the frame size"] = "調整飾品大小跟框架一樣大",
			["Trinket Size"] = "飾品大小",
			["Size of the trinket"] = "飾品的大小",
			["Trinket Attach To"] = "飾品附加到",
			["Attach trinket to the given frame"] = "附加飾品到選定的框架",
			["Trinket Position"] = "飾品位置",
			["Position of the trinket"] = "飾品的位置",
			["Trinket Anchor"] = "飾品錨點",
			["Anchor of the trinket"] = "飾品的錨點",
			["Trinket Relative Point"] = "飾品相對定位點",
			["Relative point of the trinket"] = "飾品的相對定位點",
			["Trinket Offset X"] = "飾品位移 X",
			["X offset of the trinket"] = "飾品的位移 X",
			["Trinket Offset Y"] = "飾品位移 Y",
			["Y offset of the trinket"] = "飾品的位移 Y",
			["Export layout"] = "匯出編排",
			["Export your layout code."] = "匯出你的編排代碼。",
			["Target Bar Icon Crop Borders"] = "裁剪目標條圖示邊框",
			["Toggle if the target bar icon borders should be cropped or not."] = "是否需要裁剪目標條的圖示邊框。",
			["Timer Use OmniCC"] = "仿OmniCC計時器",
			["The timer module will use OmniCC for text display"] = "計時器模組將使用OmniCC方式來顯示計時",
			["maxhealthTag"] = "最大生命值",
			["maxpower:shortTag"] = "最大動能值 (簡短)",
			["powerTag"] = "動能值",
			["health:shortTag"] = "生命值 (簡短)",
			["classTag"] = "單位職業",
			["power:percentageTag"] = "動能值 (百分比)",
			["power:shortTag"] = "動能值 (簡短)",
			["raceTag"] = "單位種族",
			["nameTag"] = "單位名稱",
			["name:statusTag"] = "單位名稱/狀態",
			["specTag"] = "單位天賦",
			["health:percentageTag"] = "生命值 (百分比)",
			["healthTag"] = "生命值",
			["maxhealth:shortTag"] = "最大生命值 (簡短)",
			["maxpowerTag"] = "最大動能值",
			["Unholy:short"] = "邪",
			["Frost:short"] = "冰",
			["Blood:short"] = "血",
			["Fire:short"] = "火",
			["Arcane:short"] = "秘",
			["Marksmanship:short"] = "射",
			["Survival:short"] = "生",
			["Beast Mastery:short"] = "獸",
			["Elemental:short"] = "元",
			["Enhancement:short"] = "增",
			["Restoration:short"] = "恢",
			["Feral:short"] = "野",
			["Balance:short"] = "平",
			["Demonology:short"] = "惡",
			["Destruction:short"] = "毀",
			["Affliction:short"] = "痛",
			["Subletly:short"] = "敏",
			["Combat:short"] = "戰",
			["Assassination:short"] = "刺",
			["Shadow:short"] = "暗",
			["Discipline:short"] = "戒",
			["Holy:short"] = "神",
			["Retribution:short"] = "懲",
			["Protection:short"] = "防",
			["Arms:short"] = "武",
			["Fury:short"] = "狂",
			["Brewmaster:short"] = "酒",
			["Mistweaver:short"] = "霧",
			["Windwalker:short"] = "風",
			["Warrior:short"] = "戰",
			["Death Knight:short"] = "死騎",
			["Warlock:short"] = "術",
			["Priest:short"] = "牧",
			["Hunter:short"] = "獵",
			["Rogue:short"] = "賊",
			["Shaman:short"] = "薩",
			["Druid:short"] = "德",
			["Paladin:short"] = "聖",
			["Mage:short"] = "法",
			["Monk:short"] = "僧",
		},
		{
			__index = function(t, index)
				return index
			end
		})
	end
end