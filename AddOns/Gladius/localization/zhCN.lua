-- zhCN.lua by 血煞天魂@愤怒使者

do
   if (GetLocale() == "zhCN") then
      Gladius.L = setmetatable({
         ["Gladius Anchor - click to move"] = "竞技场头像 - 按住拖动, 右键设置, 中键隐藏",
         ["Frame"] = "框体",
         ["Welcome to Gladius!"] = "欢迎使用Gladius!",
         ["First run has been detected, displaying test frame."] = "侦测到为第一次使用，显示测试框架。",
         ["Valid slash commands are:"] = "有效的斜线+指令是:",
         ["/gladius ui"] = "/gladius ui",
         ["/gladius test 2-5"] = "/gladius test 2-5",
         ["/gladius hide"] = "/gladius hide",
         ["/gladius reset"] = "/gladius reset",
         ["If this is not your first run please lock or move the frame to prevent this from happening."] = "如果您不是第一次使用，请锁定或者移动此框架以防止这类情况发生。",
         ["LEFT"] = "左",
         ["CENTER"] = "中",
         ["RIGHT"] = "右",
         ["Top Left"] = "左上",
         ["Top Right"] = "右上",
         ["Center Left"] = "左中",
         ["Center Right"] = "右中",
         ["Bottom Left"] = "左下",
         ["Bottom Right"] = "右下",
         ["Enable Module"] = "启用模块",
         ["Reset Module"] = "重置模块",
         ["Module Templates"] = "模块的样板",
         ["General"] = "一般",
         ["General settings"] = "一般设定",
         ["Lock frame"] = "锁定框架",
         ["Toggle if the frame can be moved"] = "勾选后框架就不能被移动了",
         ["Grow frame upwards"] = "框架向上延伸",
         ["If this is toggled the frame will grow upwards instead of downwards."] = "勾选后框架将向上延伸而不是向下。",
         ["Group Buttons"] = "队伍按钮",
         ["If this is toggle buttons can be moved separately"] = "勾选后按钮可以分别移动",
         ["Advanced Options"] = "进阶选项",
         ["Toggle advanced options"] = "切换进阶选项",
         ["Frame settings"] = "框架设定",
         ["Background Color"] = "背景颜色",
         ["Color of the frame background"] = "框架背景的颜色",
         ["Background Padding"] = "背景间距",
         ["Padding of the background"] = "背景的间距",
         ["Bottom Margin"] = "按钮间隔",
         ["Margin between each button"] = "按钮的间隔",
         ["Size"] = "大小",
         ["Size settings"] = "大小设定",
         ["Bar width"] = "状态条宽",
         ["Width of the module bars"] = "模块状态条的宽度",
         ["Frame scale"] = "框架比例",
         ["Scale of the frame"] = "框架的比例",
         ["Font"] = "字型",
         ["Font settings"] = "字型设定",
         ["Global Font"] = "整体字型",
         ["Global font, used by the modules"] = "使用于模块的整体字型",
         ["Global Font Size"] = "整体字号",
         ["Text size of the power info text"] = "动能条信息文字的大小",
         ["Use Global Font Size"] = "使用整体字号",
         ["Toggle if you want to use the global font size"] = "勾选后将使用整体字号",
         ["Global Templates"] = "整体样板",
         ["Global templates"] = "整体的样板",
         ["Arms"] = "武器",
         ["Fury"] = "狂怒",
         ["Protection"] = "防护",
         ["Holy"] = "神圣",
         ["Retribution"] = "惩戒",
         ["Assassination"] = "刺杀",
         ["Combat"] = "战斗",
         ["Subtlety"] = "敏锐",
         ["Discipline"] = "戒律",
         ["Shadow"] = "暗影",
         ["Blood"] = "血魄",
         ["Frost"] = "冰霜",
         ["Unholy"] = "秽邪",
         ["Arcane"] = "秘法",
         ["Fire"] = "火焰",
         ["Affliction"] = "痛苦",
         ["Demonology"] = "恶魔学识",
         ["Destruction"] = "毁灭",
         ["Elemental"] = "元素",
         ["Enhancement"] = "增强",
         ["Restoration"] = "恢复",
         ["Beast Mastery"] = "野兽控制",
         ["Marksmanship"] = "射击",
         ["Survival"] = "生存",
         ["Balance"] = "平衡",
         ["Feral"] = "野性战斗",
         ["%s - %s"] = "%s - %s",
         ["SPEC DETECTED: %s (%s)"] = "侦测到天赋: %s (%s)",
         ["LOW HEALTH: %s (%s)"] = "低生命值: %s (%s)",
         ["DRINKING: %s (%s)"] = "喝水: %s (%s)",
         ["RESURRECTING: %s (%s)"] = "复活中: %s (%s)",
         ["Self"] = "自身",
         ["Party"] = "队伍",
         ["Say"] = "说",
         ["Raid Warning"] = "团队警告",
         ["Scrolling Combat Text"] = "SCT",
         ["MikScrollingBattleText"] = "MSCT",
         ["Blizzard's Floating Combat Text"] = "暴雪的FCT",
         ["Parrot"] = "Parrot",
         ["Options"] = "选项",
         ["Destination"] = "通告方式",
         ["Choose how your announcements are displayed."] = "选择您想要的显示通告方式。",
         ["Low health threshold"] = "低生命值门坎",
         ["Choose how low an enemy must be before low health is announced."] = "选择敌人低于多少生命值时通告。",
         ["Announcement toggles"] = "切换通告",
         ["New enemies"] = "新敌人",
         ["Announces when new enemies are discovered."] = "当发现新敌人时通告。",
         ["Drinking"] = "喝水",
         ["Announces when enemies sit down to drink."] = "当敌人坐下喝水时通告。",
         ["Low health"] = "低生命值",
         ["Announces when an enemy drops below a certain health threshold."] = "当敌人的生命值低于门坎时通告。",
         ["Resurrection"] = "复活",
         ["Announces when an enemy tries to resurrect a teammate."] = "当敌人试图复活队友时通告。",
         ["Spec Detection"] = "侦测天赋",
         ["Announces when the spec of an enemy was detected."] = "当侦测到敌人的天赋时通告。",
         ["Buffs"] = "增益",
         ["Widget"] = "小工具",
         ["Widget settings"] = "小工具设定",
         ["Auras Buffs"] = "增益光环",
         ["Toggle aura buffs"] = "切换增益光环",
         ["Auras Column Grow"] = "光环列延伸",
         ["Grow direction of the auras"] = "光环的延伸方向",
         ["Up Left"] = "左上",
         ["Up Right"] = "右上",
         ["Down Left"] = "左下",
         ["Down Right"] = "右下",
         ["Aura Icons Per Column"] = "每列光环图示",
         ["Number of aura icons per column"] = "每列光环图示的数量",
         ["Aura Icons Max"] = "最大光环图示",
         ["Number of max buffs"] = "增益的最大数量",
         ["Auras Gloss"] = "覆盖光环",
         ["Toggle gloss on the auras icon"] = "选择覆盖的光环图示",
         ["Auras Gloss Color"] = "覆盖光环颜色",
         ["Color of the auras icon gloss"] = "覆盖光环图示的颜色",
         ["Aura Icon Width"] = "光环图示宽",
         ["Width of the aura icons"] = "光环图示的宽度",
         ["Aura Icon Height"] = "光环图示高",
         ["Height of the aura icon"] = "光环图示的高度",
         ["Auras Spacing Vertical"] = "光环垂直间距",
         ["Vertical spacing of the auras"] = "光环的垂直间距",
         ["Auras Spacing Horizontal"] = "光环水平间距",
         ["Horizontal spacing of the auras"] = "光环的水平间距",
         ["Position"] = "位置",
         ["Position settings"] = "位置设定",
         ["Auras Attach To"] = "光环附加到",
         ["Attach auras to the given frame"] = "附加光环到选定的框架",
         ["Auras Anchor"] = "光环锚点",
         ["Anchor of the auras"] = "光环的锚点",
         ["Auras Relative Point"] = "光环相对定位点",
         ["Relative point of the auras"] = "光环的相对定位点",
         ["Auras Offset X"] = "光环位移 X",
         ["X offset of the auras"] = "光环的位移 X",
         ["Auras Offset Y"] = "光环位移 Y",
         ["Y  offset of the auras"] = "光环的位移 Y",
         ["Filter"] = "筛选",
         ["Whitelist"] = "白名单",
         ["Blacklist"] = "黑名单",
         ["Filter Function"] = "筛选功能",
         ["Debuffs"] = "减益",
         ["Auras Debuffs"] = "减益光环",
         ["Toggle aura debuffs"] = "切换减益光环",
         ["Number of max Debuffs"] = "减益的最大数量",
         ["Auras"] = "光环",
         ["New Aura"] = "新光环",
         ["Name"] = "名称",
         ["Name of the aura"] = "光环的名称",
         ["Priority"] = "优先级",
         ["Select what priority the aura should have - higher equals more priority"] = "选择光环的优先级，数字越大优先级越高",
         ["Add new Aura"] = "新增新光环",
         ["Delete"] = "删除",
         ["Example Spell Name"] = "正在施放的法术",
         ["Bar"] = "状态条",
         ["Bar settings"] = "状态条设定",
         ["Cast Bar Color"] = "施法条颜色",
         ["Color of the cast bar"] = "施法条的颜色",
         ["Cast Bar Background Color"] = "施法条背景颜色",
         ["Color of the cast bar background"] = "施法条背景的颜色",
         ["Cast Bar Inverse"] = "施法条反向",
         ["Inverse the cast bar"] = "施法条反向",
         ["Cast Bar Texture"] = "施法条材质",
         ["Texture of the cast bar"] = "施法条的材质",
         ["Cast Bar Icon"] = "施法条图示",
         ["Toggle the cast icon"] = "切换施法条图示",
         ["Cast Bar Icon Position"] = "施法条图标位置",
         ["Position of the cast bar icon"] = "施法条图标的位置",
         ["Cast Bar Adjust Width"] = "调整施法条宽度",
         ["Adjust cast bar width to the frame width"] = "调整施法条宽跟框架一样宽",
         ["Cast Bar Width"] = "施法条宽",
         ["Width of the cast bar"] = "施法条的宽度",
         ["Cast Bar Height"] = "施法条高",
         ["Height of the cast bar"] = "施法条的高度",
         ["Cast Bar Attach To"] = "施法条附加到",
         ["Attach cast bar to the given frame"] = "附加施法条到选定的框架",
         ["Cast Bar Anchor"] = "施法条锚点",
         ["Anchor of the cast bar"] = "施法条的锚点",
         ["Cast Bar Relative Point"] = "施法条相对定位点",
         ["Relative point of the cast bar"] = "施法条的相对定位点",
         ["Cast Bar Offset X"] = "施法条位移 X",
         ["X offset of the cast bar"] = "施法条的位移 X",
         ["Cast Bar Offset Y"] = "施法条位移 Y",
         ["Y offset of the castbar"] = "施法条的位移 Y",
         ["Cast Text"] = "施法文字",
         ["Text"] = "文字",
         ["Text settings"] = "文字设定",
         ["Toggle cast text"] = "切换施法文字",
         ["Cast Text Color"] = "施法文字颜色",
         ["Text color of the cast text"] = "施法文字的颜色",
         ["Cast Text Size"] = "施法文字大小",
         ["Text size of the cast text"] = "施法文字的大小",
         ["Cast Text Align"] = "施法文字对齐",
         ["Text align of the cast text"] = "施法文字的对齐",
         ["Cast Text Offset X"] = "施法文字位移 X",
         ["X offset of the cast text"] = "施法文字的位移 X",
         ["Cast Text Offset Y"] = "施法文字位移 Y",
         ["Y offset of the cast text"] = "施法文字的位移 Y",
         ["Cast Time Text"] = "施法时间文字",
         ["Toggle cast time text"] = "切换施法时间文字",
         ["Cast Time Text Color"] = "施法时间文字颜色",
         ["Text color of the cast time text"] = "施法时间文字的颜色",
         ["Cast Time Text Size"] = "施法时间文字大小",
         ["Text size of the cast time text"] = "施法时间文字的大小",
         ["Cast Time Text Align"] = "施法时间文字对齐",
         ["Text align of the cast time text"] = "施法时间文字的对齐",
         ["Cast Time Offset X"] = "施法时间文字位移 X",
         ["X Offset of the cast time text"] = "施法时间文字的位移 X",
         ["Cast Time Offset Y"] = "施法时间文字位移 Y",
         ["Y Offset of the cast time text"] = "施法时间文字的位移 Y",
         ["Class Icon Important Auras"] = "职业图示里的重要光环",
         ["Show important auras instead of the class icon"] = "在职业图标里显示重要光环",
         ["Class Icon Crop Borders"] = "裁剪职业图示边框",
         ["Toggle if the class icon borders should be cropped or not."] = "是否需要裁剪职业图示边框。",
         ["Class Icon Cooldown Spiral"] = "职业图示里的冷却倒数",
         ["Display the cooldown spiral for important auras"] = "为重要光环显示冷却倒数",
         ["Class Icon Cooldown Reverse"] = "职业图示里的冷却反转",
         ["Invert the dark/bright part of the cooldown spiral"] = "冷却倒数中的明暗反向",
         ["Class Icon Gloss"] = "覆盖职业图示",
         ["Toggle gloss on the class icon"] = "切换覆盖的职业图示",
         ["Class Icon Gloss Color"] = "覆盖职业图示颜色",
         ["Color of the class icon gloss"] = "覆盖职业图示的颜色",
         ["Class Icon Frame Level"] = "职业图示框架层级",
         ["Frame level of the class icon"] = "职业图示的框架层级",
         ["Class Icon Adjust Size"] = "调整职业图示大小",
         ["Adjust class icon size to the frame size"] = "调整职业图示的大小",
         ["Class Icon Size"] = "职业图示大小",
         ["Size of the class icon"] = "职业图示的大小",
         ["Class Icon Attach To"] = "职业图示附加到",
         ["Attach class icon to given frame"] = "附加职业图示到选定的框架",
         ["Class Icon Position"] = "职业图标位置",
         ["Position of the class icon"] = "职业图标的位置",
         ["Left"] = "左",
         ["Right"] = "右",
         ["Class Icon Anchor"] = "职业图示锚点",
         ["Anchor of the class icon"] = "职业图示的锚点",
         ["Class Icon Relative Point"] = "职业图示相对定位点",
         ["Relative point of the class icon"] = "职业图示的相对定位点",
         ["Class Icon Offset X"] = "职业图示位移 X",
         ["X offset of the class icon"] = "职业图示的位移 X",
         ["Class Icon Offset Y"] = "职业图示位移 Y",
         ["Y offset of the class icon"] = "职业图示的位移 Y",
         ["Middle"] = "中键",
         ["Button 4"] = "按钮 4",
         ["Button 5"] = "按钮 5",
         ["None"] = "无",
         ["ctrl-"] = "ctrl-",
         ["shift-"] = "shift-",
         ["alt-"] = "alt-",
         ["Click Actions"] = "点击执行",
         ["Add click action"] = "新增点击执行",
         ["Mouse button"] = "鼠标按钮",
         ["Select which mouse button this click action uses"] = "选择哪个鼠标按钮来点击执行",
         ["Modifier"] = "附加主键",
         ["Select a modifier for this click action"] = "选择修改此点击执行",
         ["Add"] = "新增",
         ["Delete Click Action"] = "删除点击执行",
         ["Action"] = "执行",
         ["Select what this Click Action does"] = "选择点击执行该做甚么指令",
         ["Cast Spell"] = "施放法术",
         ["Spell Name / Macro Text"] = "法术名称 / 宏指令",
         ["DRTracker Space"] = "控场追踪间隔",
         ["Space between the icons"] = "图示之间的间隔",
         ["DRTracker Cooldown Spiral"] = "控场追踪冷却倒数",
         ["DRTracker Cooldown Reverse"] = "控场追踪冷却反转",
         ["DRTracker Gloss"] = "覆盖控场追踪",
         ["Toggle gloss on the drTracker icon"] = "切换覆盖控场追踪图示",
         ["DRTracker Gloss Color"] = "覆盖控场追踪颜色",
         ["Color of the drTracker icon gloss"] = "覆盖控场追踪的颜色",
         ["DRTracker Frame Level"] = "控场追踪框架层级",
         ["Frame level of the drTracker"] = "控场追踪框架的层级",
         ["DRTracker Adjust Size"] = "调整控场追踪大小",
         ["Adjust drTracker size to the frame size"] = "调整控场追踪大小跟框架一样大",
         ["DRTracker Size"] = "控场追踪大小",
         ["Size of the drTracker"] = "控场追踪的大小",
         ["DR Text Color"] = "控场文字颜色",
         ["Text color of the DR text"] = "控场文字的颜色",
         ["DR Text Size"] = "控场文字大小",
         ["Text size of the DR text"] = "控场文字的大小",
         ["DRTracker Attach To"] = "控场追踪附加到",
         ["Attach drTracker to the given frame"] = "附加控场追踪到选定的框架",
         ["DRTracker Position"] = "控场追踪位置",
         ["DRTracker Anchor"] = "控场追踪锚点",
         ["Anchor of the drTracker"] = "控场追踪的锚点",
         ["DRTracker Relative Point"] = "控场追踪相对定位点",
         ["Relative point of the drTracker"] = "控场追踪的相对定位点",
         ["DRTracker Offset X"] = "控场追踪位移 X",
         ["X offset of the drTracker"] = "控场追踪的位移 X",
         ["DRTracker Offset Y"] = "控场追踪位移 Y",
         ["Y  offset of the drTracker"] = "控场追踪的位移 Y",
         ["Categories"] = "类别",
         ["Category settings"] = "类别设定",
         ["Health bar class color"] = "生命条职业颜色",
         ["Toggle health bar class color"] = "切换生命条的职业颜色",
         ["Health bar color"] = "生命条颜色",
         ["Color of the health bar"] = "生命条的颜色",
         ["Health bar background color"] = "生命条背景颜色",
         ["Color of the health bar background"] = "生命条背景的颜色",
         ["Health bar inverse"] = "生命条反向",
         ["Inverse the health bar"] = "生命条的反向",
         ["Health bar texture"] = "生命条材质",
         ["Texture of the health bar"] = "生命条的材质",
         ["Health bar adjust width"] = "调整生命条宽",
         ["Adjust health bar width to the frame width"] = "调整生命条宽跟框架一样宽",
         ["Health bar width"] = "生命条宽",
         ["Width of the health bar"] = "生命条的宽度",
         ["Health bar height"] = "生命条高",
         ["Height of the health bar"] = "生命条的高度",
         ["Health Bar Attach To"] = "生命条附加到",
         ["Attach health bar to the given frame"] = "附加生命条到选定的框架",
         ["Health Bar Anchor"] = "生命条锚点",
         ["Anchor of the health bar"] = "生命条的锚点",
         ["Health Bar Relative Point"] = "生命条相对定位点",
         ["Relative point of the health bar"] = "生命条的相对定位点",
         ["Health bar offset X"] = "生命条位移 X",
         ["X offset of the health bar"] = "生命条的位移 X",
         ["Health bar offset Y"] = "生命条位移 Y",
         ["Y offset of the health bar"] = "生命条的位移 Y",
         ["Health colors"] = "生命条颜色",
         ["Default priest color"] = "预设的牧师颜色",
         ["Toggle default priest color"] = "切换预设的牧师颜色",
         ["Priest color"] = "牧师颜色",
         ["Default paladin color"] = "预设的圣骑士颜色",
         ["Toggle default paladin color"] = "切换预设的圣骑士颜色",
         ["Paladin color"] = "圣骑士颜色",
         ["Default shaman color"] = "预设的萨满颜色",
         ["Toggle default shaman color"] = "切换预设的萨满颜色",
         ["Shaman color"] = "萨满颜色",
         ["Default druid color"] = "预设的德鲁伊颜色",
         ["Toggle default druid color"] = "切换预设的德鲁伊颜色",
         ["Druid color"] = "德鲁伊颜色",
         ["Default mage color"] = "预设的法师颜色",
         ["Toggle default mage color"] = "切换预设的法师颜色",
         ["Mage color"] = "法师颜色",
         ["Default warlock color"] = "预设的术士颜色",
         ["Toggle default warlock color"] = "切换预设的术士颜色",
         ["Warlock color"] = "术士颜色",
         ["Default hunter color"] = "预设的猎人颜色",
         ["Toggle default hunter color"] = "切换预设的猎人颜色",
         ["Hunter color"] = "猎人颜色",
         ["Default warrior color"] = "预设的战士颜色",
         ["Toggle default warrior color"] = "切换预设的战士颜色",
         ["Warrior color"] = "战士颜色",
         ["Default rogue color"] = "预设的盗贼颜色",
         ["Toggle default eogue color"] = "切换预设的盗贼颜色",
         ["Rogue color"] = "盗贼颜色",
         ["Default death knight color"] = "预设的死亡骑士颜色",
         ["Toggle default death knight color"] = "切换预设的死亡骑士颜色",
         ["Death knight color"] = "死亡骑士颜色",
         ["Hover"] = "悬停",
         ["Hover settings"] = "悬停设定",
         ["Highlight On Mouseover"] = "高亮游标悬停",
         ["Highlight frame on mouseover"] = "高亮游标悬停的框架",
         ["Highlight Color"] = "高亮颜色",
         ["Color of the highlight frame"] = "高亮框架的颜色",
         ["Player Target"] = "玩家目标",
         ["Player target settings"] = "玩家目标设定",
         ["Highlight Target"] = "高亮目标",
         ["Show border around player target"] = "显示玩家目标周围边框",
         ["Highlight Target Color"] = "高亮目标颜色",
         ["Color of the target border"] = "目标边框的颜色",
         ["Highlight Target Priority"] = "高亮目标优先权",
         ["Priority of the target border"] = "目标边框的优先权",
         ["Player Focus Target"] = "玩家专注目标",
         ["Player focus target settings"] = "玩家专注目标设定",
         ["Highlight Focus Target"] = "高亮专注目标",
         ["Highlight Focus Target Color"] = "高亮专注目标颜色",
         ["Color of the focus target border"] = "专注目标边框的颜色",
         ["Highlight Focus Target Priority"] = "高亮专注目目标优先权",
         ["Priority of the focus target border"] = "专注目标边框的优先权",
         ["Raid Assist Target"] = "团队助攻目标",
         ["Raid assist settings"] = "团队助攻设定",
         ["Highlight Raid Assist"] = "高亮团队助攻",
         ["Show border around raid assist"] = "显示团队助攻周围边框",
         ["Highlight Raid Assist Color"] = "高亮团队助攻颜色",
         ["Color of the raid assist border"] = "团队助攻边框的颜色",
         ["Highlight Raid Assist Priority"] = "高亮团队助攻优先权",
         ["Priority of the raid assist border"] = "团队助攻边框的优先权",
         ["Raid Icon Targets"] = "团队目标图标",
         ["Raid Icon target 1 settings"] = "团队目标图标 1 设定",
         ["Raid Icon target 2 settings"] = "团队目标图标 2 设定",
         ["Raid Icon target 3 settings"] = "团队目标图标 3 设定",
         ["Raid Icon target 4 settings"] = "团队目标图标 4 设定",
         ["Raid Icon target 5 settings"] = "团队目标图标 5 设定",
         ["Raid Icon target 6 settings"] = "团队目标图标 6 设定",
         ["Raid Icon target 7 settings"] = "团队目标图标 7 设定",
         ["Raid Icon target 8 settings"] = "团队目标图标 8 设定",
		 ["Announcements"] = "通告",            
         ["Announcements settings"] = "通告设定",
         ["CastBar"] = "施法条",
         ["CastBar settings"] = "施法条设定",
         ["ClassIcon"] = "职业图示",
         ["ClassIcon settings"] = "职业图示设定",
         ["Clicks"] = "点击",
         ["Clicks settings"] = "点击设定",
         ["DRTracker"] = "控场追踪",
         ["DRTracker settings"] = "控场追踪设定",
         ["HealthBar"] = "生命条",      
         ["HealthBar settings"] = "生命条设定",
         ["Highlight"] = "高亮",         
         ["Highlight settings"] = "高亮设定",
         ["Layout"] = "编排",
         ["Layout settings"] = "编排设定",
         ["PowerBar"] = "动能条",   
         ["PowerBar settings"] = "动能条设定",
         ["TargetBar"] = "目标条",
         ["TargetBar settings"] = "目标条设定",      
         ["Timer"] = "计时条",                  
         ["Timer settings"] = "计时条设定",
         ["Layout Code"] = "编排代码",
         ["Code of your layout."] = "你的编排代码。",
         ["Import layout"] = "汇入编排",
         ["Import your layout code."] = "汇入你的编排代码。",
         ["Error while importing layout: %s"] = "汇入编排代码错误: %s",
         ["Power Bar Default Color"] = "动能条预设颜色",
         ["Toggle power bar default color"] = "切换动能条预设的颜色",
         ["Power Bar Color"] = "动能条颜色",
         ["Color of the power bar"] = "动能条的颜色",
         ["Power Bar Background Color"] = "动能条背景颜色",
         ["Color of the power bar background"] = "动能条背景的颜色",
         ["Power Bar Inverse"] = "动能条反向",
         ["Inverse the power bar"] = "动能条的反向",
         ["Power Bar Texture"] = "动能条材质",
         ["Texture of the power bar"] = "动能条的材质",
         ["Power Bar Adjust Width"] = "调整动能条宽",
         ["Adjust power bar width to the frame width"] = "调整动能条宽跟框架一样宽",
         ["Power Bar Width"] = "动能条宽",
         ["Width of the power bar"] = "动能条的宽度",
         ["Power Bar Height"] = "动能条高",
         ["Height of the power bar"] = "动能条的高度",
         ["Power Bar Attach To"] = "动能条附加到",
         ["Attach power bar to the given frame"] = "附加动能条到选定的框架",
         ["Power Bar Anchor"] = "动能条锚点",
         ["Anchor of the power bar"] = "动能条的锚点",
         ["Power Bar Relative Point"] = "动能条相对定位点",
         ["Relative point of the power bar"] = "动能条的相对定位点",
         ["Power Bar Offset X"] = "动能条位移 X",
         ["X offset of the power bar"] = "动能条的位移 X",
         ["Power Bar Offset Y"] = "动能条位移 Y",
         ["Y offset of the power bar"] = "动能条的位移 Y",
         ["Power colors"] = "动能颜色",
         ["Default Power Mana Color"] = "预设的法力颜色",
         ["Toggle default power mana color"] = "切换预设的法力颜色",
         ["Power Mana Color"] = "法力颜色",
         ["Default Power Rage Color"] = "预设的怒气颜色",
         ["Toggle default power rage color"] = "切换预设的怒气颜色",
         ["Power Rage Color"] = "怒气颜色",
         ["Default Power Focus Color"] = "预设的集中颜色",
         ["Toggle default power focus color"] = "切换预设的集中颜色",
         ["Power Focus Color"] = "集中颜色",
         ["Default Power Energy Color"] = "预设的能量颜色",
         ["Toggle default power energy color"] = "切换预设的能量颜色",
         ["Power Energy Color"] = "能量颜色",
         ["Default Power Runic Power Color"] = "预设的符能颜色",
         ["Toggle default power runic power color"] = "切换预设的符能颜色",
         ["Power Runic Power Color"] = "符能颜色",
         ["Texts"] = "文字选项",
         ["Add text"] = "新增文字",
         ["Name of the text element"] = "文字要素名称",
         ["Text Attach To"] = "文字附加到",
         ["Attach text to module bar"] = "附加文字到模块条",
         ["Add Text"] = "新增文字",
         ["Tags"] = "标签",
         ["Tags settings"] = "标签设定",
         ["Add tag"] = "新增标签",
         ["Name of the tag"] = "标签的名称",
         ["Add Tag"] = "新增标签",
         ["Tag: %s"] = "标签: %s",
         ["Text to be displayed"] = "要显示的文字",
         ["Delete Text"] = "删除文字",
         ["Tag"] = "标签",
         ["Tag settings"] = "标签设定",
         ["Text Color"] = "文字颜色",
         ["Text color of the text"] = "文字的颜色",
         ["Text Size"] = "文字大小",
         ["Text size of the text"] = "文字的大小",
         ["Text Align"] = "文字对齐",
         ["Text align of the text"] = "文字的对齐",
         ["Text Offset X"] = "文字位移 X",
         ["X offset of the text"] = "文字的位移 X",
         ["Text Offset Y"] = "文字位移 Y",
         ["Y offset of the text"] = "文字的位移 Y",
         ["Delete Tag"] = "删除标签",
         ["Events"] = "事件",
         ["Events which update the tag"] = "标签随着事件更新",
         ["Function"] = "功能",
         ["DEAD"] = "死亡",
         ["Target bar health bar"] = "目标生命条",
         ["Toggle health bar display"] = "切换显示为生命条",
         ["Target bar class color"] = "目标条职业颜色",
         ["Target bar color"] = "目标条颜色",
         ["Target bar background color"] = "目标条的背景颜色",
         ["Target bar inverse"] = "目标条反向",
         ["Target bar texture"] = "目标条材质",
         ["Target bar class icon"] = "目标条职业图标",
         ["Toggle the target bar class icon"] = "切换目标条的职业图标",
         ["Target bar icon position"] = "目标条图标位置",
         ["Position of the target bar class icon"] = "目标条的职业图标位置",
         ["Target bar adjust width"] = "调整目标条宽",
         ["Target bar width"] = "目标条宽",
         ["Target bar height"] = "目标条高",
         ["Target Bar Attach To"] = "目标条附加到",
         ["Target Bar Anchor"] = "目标条锚点",
         ["Target Bar Relative Point"] = "目标条相对定位点",
         ["Target bar offset X"] = "目标条位移 X",
         ["Target bar offset Y"] = "目标条位移 Y",
         ["Timer Soon Color"] = "临时定时器颜色",
         ["Color of the timer when timeleft is less than 5 seconds."] = "当计时低于5秒时的定时器颜色。",
         ["Timer Soon Size"] = "临时定时器大小",
         ["Text size of the timer when timeleft is less than 5 seconds."] = "当计时低于5秒时的定时器文字颜色。",
         ["Timer Seconds Color"] = "定时器秒数颜色",
         ["Color of the timer when timeleft is less than 60 seconds."] = "当计时低于60秒时的定时器颜色。",
         ["Timer Seconds Size"] = "定时器秒数大小",
         ["Text size of the timer when timeleft is less than 60 seconds."] = "当计时低于60秒时的定时器文字颜色。",
         ["Timer Minutes Color"] = "定时器分钟颜色",
         ["Color of the timer when timeleft is greater than 60 seconds."] = "当计时高于60秒时的定时器颜色。",
         ["Timer Minutes Size"] = "定时器分钟大小",
         ["Text size of the timer when timeleft is greater than 60 seconds."] = "当计时高于60秒时的定时器文字颜色。",
         ["TRINKET USED: %s (%s)"] = "已使用饰品: %s (%s)",
         ["TRINKET READY: %s (%s)"] = "饰品准备完毕: %s (%s)",
         ["Trinket"] = "饰品",
         ["Announces when an enemy uses a PvP trinket."] = "当一个敌人使用了PvP饰品时通告。",
         ["Trinket Grid Style Icon"] = "Grid风格饰品图示",
         ["Toggle trinket grid style icon"] = "切换Grid风格的饰品图示",
         ["Trinket Grid Style Icon Color"] = "Grid风格饰品图示颜色",
         ["Color of the trinket grid style icon"] = "Grid风格的饰品图示颜色",
         ["Trinket Grid Style Icon Used Color"] = "Grid风格的饰品图示已使用的颜色",
         ["Color of the trinket grid style icon when it's on cooldown"] = "Grid风格的饰品图示冷却中的颜色",
         ["Trinket Cooldown Spiral"] = "饰品冷却倒数",
         ["Trinket Cooldown Reverse"] = "饰品冷却反转",
         ["Trinket Gloss"] = "饰品覆盖",
         ["Toggle gloss on the trinket icon"] = "切换覆盖的饰品图示",
         ["Trinket Gloss Color"] = "饰品覆盖颜色",
         ["Color of the trinket icon gloss"] = "饰品图示覆盖的颜色",
         ["Trinket Icon Border Crop"] = "裁剪饰品图示边框",
         ["Toggle if the borders of the trinket icon should be cropped"] = "是否需要裁剪职业图示边框",
         ["Trinket Icon Faction"] = "阵营饰品图示",
         ["Toggle if the trinket icon should be changing based on the opponents faction"] = "若要切换饰品图示需在对方阵营的基础上变更才行",
         ["Trinket Frame Level"] = "饰品框架层级",
         ["Frame level of the trinket"] = "饰品框架的层级",
         ["Trinket Adjust Size"] = "调整饰品大小",
         ["Adjust trinket size to the frame size"] = "调整饰品大小跟框架一样大",
         ["Trinket Size"] = "饰品大小",
         ["Size of the trinket"] = "饰品的大小",
         ["Trinket Attach To"] = "饰品附加到",
         ["Attach trinket to the given frame"] = "附加饰品到选定的框架",
         ["Trinket Position"] = "饰品位置",
         ["Position of the trinket"] = "饰品的位置",
         ["Trinket Anchor"] = "饰品锚点",
         ["Anchor of the trinket"] = "饰品的锚点",
         ["Trinket Relative Point"] = "饰品相对定位点",
         ["Relative point of the trinket"] = "饰品的相对定位点",
         ["Trinket Offset X"] = "饰品位移 X",
         ["X offset of the trinket"] = "饰品的位移 X",
         ["Trinket Offset Y"] = "饰品位移 Y",
         ["Y  offset of the trinket"] = "饰品的位移 Y",
         ["Export layout"] = "汇出编排",
         ["Export your layout code."] = "汇出你的编排代码。",
         ["Target Bar Icon Crop Borders"] = "裁剪目标条图标边框",
         ["Toggle if the target bar icon borders should be cropped or not."] = "是否需要裁剪目标条的图标边框。",
         ["Timer Use OmniCC"] = "仿OmniCC定时器",
         ["The timer module will use OmniCC for text display"] = "定时器模块将使用OmniCC方式来显示计时",

         ["maxhealthTag"] = "最大生命值",
         ["maxpower:shortTag"] = "最大动能值 (简短)",
         ["powerTag"] = "动能值",
         ["health:shortTag"] = "生命值 (简短)",
         ["classTag"] = "单位职业",
         ["power:percentageTag"] = "动能值 (百分比)",
         ["power:shortTag"] = "动能值 (简短)",
         ["raceTag"] = "单位种族",
         ["nameTag"] = "单位名称",
         ["name:statusTag"] = "单位名称/状态",  
         ["specTag"] = "单位天赋",
         ["health:percentageTag"] = "生命值 (百分比)",
         ["healthTag"] = "生命值",
         ["maxhealth:shortTag"] = "最大生命值 (简短)",
         ["maxpowerTag"] = "最大动能值",

          -- Specs, sup?
          ["Unholy:short"] = "邪",
          ["Frost:short"] = "冰",
          ["Blood:short"] = "血",
          ["Fire:short"] = "火",
          ["Arcane:short"] = "奥",
          ["Marksmanship:short"] = "射击",
          ["Survival:short"] = "生存",
          ["Beast Mastery:short"] = "兽王",
          ["Elemental:short"] = "元素",
          ["Enhancement:short"] = "增强",
          ["Restoration:short"] = "恢复",
          ["Feral:short"] = "野性",
          ["Balance:short"] = "平衡",
          ["Demonology:short"] = "恶魔",
          ["Destruction:short"] = "毁灭",
          ["Affliction:short"] = "痛苦",
          ["Subletly:short"] = "敏锐",
          ["Combat:short"] = "战斗",
          ["Assassination:short"] = "刺杀",
          ["Shadow:short"] = "暗",
          ["Discipline:short"] = "戒",
          ["Holy:short"] = "神",
          ["Retribution:short"] = "惩",
          ["Protection:short"] = "防",
          ["Arms:short"] = "武器",
          ["Fury:short"] = "狂暴",

          ["邪恶:short"] = "邪",
          ["冰霜:short"] = "冰",
          ["鲜血:short"] = "血",
          ["火焰:short"] = "火",
          ["奥术:short"] = "奥",
          ["射击:short"] = "射击",
          ["生存:short"] = "生存",
          ["野兽控制:short"] = "兽王",
          ["元素战斗:short"] = "元素",
          ["增强:short"] = "增强",
          ["恢复:short"] = "恢复",
          ["野性战斗:short"] = "野性",
          ["平衡:short"] = "平衡",
          ["恶魔学识:short"] = "恶魔",
          ["毁灭:short"] = "毁灭",
          ["痛苦:short"] = "痛苦",
          ["敏锐:short"] = "敏锐",
          ["战斗:short"] = "战斗",
          ["刺杀:short"] = "刺杀",
          ["暗影:short"] = "暗影",
          ["戒律:short"] = "戒律",
          ["神圣:short"] = "神圣",
          ["惩戒:short"] = "惩戒",
          ["防护:short"] = "防",
          ["武器:short"] = "武器",
          ["狂暴:short"] = "狂暴",

          ["Warrior:short"] = "战",
          ["Death Knight:short"] = "死骑",
          ["Warlock:short"] = "术",
          ["Priest:short"] = "牧",
          ["Hunter:short"] = "猎",
          ["Rogue:short"] = "贼",
          ["Shaman:short"] = "萨",
          ["Druid:short"] = "德",
          ["Paladin:short"] = "圣",
          ["Mage:short"] = "法",

          ["战士:short"] = "战",
          ["死亡骑士:short"] = "死骑",
          ["术士:short"] = "术",
          ["牧师:short"] = "牧",
          ["猎人:short"] = "猎",
          ["潜行者:short"] = "贼",
          ["萨满祭司:short"] = "萨",
          ["德鲁伊:short"] = "德",
          ["圣骑士:short"] = "圣",
          ["法师:short"] = "法",

          ["arena1"] = "竞技场对手甲",
          ["arena2"] = "竞技场对手乙",
          ["arena3"] = "竞技场对手丙",
          ["arena4"] = "竞技场对手丁",
          ["arena5"] = "竞技场对手戊",
      }, {
         __index = function(t, index) return index end
      })
   end
end
