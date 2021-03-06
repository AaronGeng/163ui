
U1RegisterAddon("tdCore", {
    title = "太多插件",
    -- defaultEnable  = 1,
    hide = 1,
    -- load = 'DEMAND',
    -- load = "LOGIN", --LATER会导致屏幕大闪
})


U1RegisterAddon('tdPack', {
    title = '背包整理',
    defaultEnable = 1,
    deps = { 'tdcore' },
    tags = {TAG_ITEM},
    desc = "在背包窗口上显示背包整理按钮，可以按照预订顺序快速整理物品。`ctrl或shift右键点击整理按钮可以设置正序或逆序（背包的空格在前还是在后），下次整理只需要左键单击就能使用之前设置的顺序。",
    icon = [[Interface\Icons\INV_Misc_Bag_10_Green]],

    {
        text="配置选项",
        callback = function(cfg, v, loading)
            if(tdCore) then
                tdCore('tdPack'):ToggleOption()
            end
        end,
    },

})

if(DEBUG_MODE) then
    U1RegisterAddon("tdCC", {
        title = '技能冷却',
        defaultEnable = 1,
        deps = { 'tdcore' },
        tags = {TAG_COMBATINFO,},
        icon = [[Interface\Icons\INV_Qiraj_JewelGlyphed]],
        desc = "给所有的技能冷却动画添加文字显示及冷却后的效果，同时可以将超出范围的技能图标设置为暗红色。",

        {
            text="配置选项",
            callback = function(cfg, v, loading)
                if(tdCore) then
                    tdCore('tdCC'):ToggleOption()
                end
            end,
        },
    })
end

