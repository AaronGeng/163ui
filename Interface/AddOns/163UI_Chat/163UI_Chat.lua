--[[------------------------------------------------------------
清除聊天窗口
---------------------------------------------------------------]]
StaticPopupDialogs["163UI_CHAT_CLEAR"] = {preferredIndex = 3,
    text = "即将|cffff0000清除|r聊天窗口|cffffff00[%1$s]|r的全部信息，你确定要这么做吗？",
    button1 = TEXT(YES),
    button2 = TEXT(CANCEL),
    OnAccept = function(self, data)
        local lines = CoreGetParaParam("Gamma", 17, 4);
        if lines ~= 0 then
            lines = normalize(lines, 50, 5000);
            (data or SELECTED_CHAT_FRAME):SetMaxLines(lines);
            U1Message("本聊天框记录行数设置为|cffffd100"..lines.."|r", nil, nil, nil, (data or SELECTED_CHAT_FRAME));
        else
            (data or SELECTED_CHAT_FRAME):Clear();
        end
    end,
    timeout = 0,
    hideOnEscape = 1,
    whileDead = 1,
    exclusive = 1,
}

--[[------------------------------------------------------------
左上角的缩放按钮
---------------------------------------------------------------]]
function U1Chat_ChatFrameResizeOnShow(self)
    self:GetParent().resizeButton2:Show();
end
local function chatFrameResizeOnShow(self)
    U1Chat_ChatFrameResizeOnShow(self);
end
local function chatFrameResizeOnHide(self)
    self:GetParent().resizeButton2:Hide();
end
local function chatFrameResizeOnMouseUp(self)
    self:SetButtonState("NORMAL", false);
    SetCursor(nil); --Show the cursor again

    self:GetHighlightTexture():Show();

    self:GetParent():StopMovingOrSizing();
    FCF_SavePositionAndDimensions(self:GetParent());
end
local function chatFrameResizeOnMouseDown(self)
    local chatFrame = self:GetParent();
    if chatFrame:IsResizable() then
        self:SetButtonState("PUSHED", true);
        SetCursor("Interface\\CURSOR\\openhandglow");

        self:GetHighlightTexture():Hide();

        chatFrame:StartSizing("TOPLEFT");
    end
end
local function CreateResizeButton(cf)
    local btn = CreateFrame("Button", "$parentResizeButtonTopLeft", cf);
    cf.resizeButton2 = btn;
    btn:SetSize(16, 16);
    btn:SetFrameStrata("LOW");
    btn:SetPoint("TOPLEFT", "$parentBackground");
    btn:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up");
    btn:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight");
    btn:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down");
    btn:GetNormalTexture():SetTexCoord(1,1,1,0,0,1,0,0)
    btn:GetHighlightTexture():SetTexCoord(1,1,1,0,0,1,0,0)
    btn:GetPushedTexture():SetTexCoord(1,1,1,0,0,1,0,0)
    btn:SetScript("OnMouseDown", chatFrameResizeOnMouseDown);
    btn:SetScript("OnMouseUp", chatFrameResizeOnMouseUp);
    hooksecurefunc(cf.resizeButton, "Show", chatFrameResizeOnShow);
    hooksecurefunc(cf.resizeButton, "Hide", chatFrameResizeOnHide);
end
WithAllChatFrame(CreateResizeButton);

--[[------------------------------------------------------------
鼠标滚轮增强
---------------------------------------------------------------]]
local chatFrameOnMouseWheel = function(chatframe, value)
    U1Chat_ChatFrame_OnMouseWheel(chatframe, value);
    GameTooltip:Hide()
end

function U1Chat_ChatFrame_OnMouseWheel(chatframe, value)
    if ( IsShiftKeyDown() ) then
        if ( value > 0 ) then
            chatframe:ScrollToTop()
        elseif ( value < 0 ) then
            chatframe:ScrollToBottom()
        end
    elseif ( IsControlKeyDown() ) then
        if ( value > 0 ) then
            chatframe:PageUp();
        elseif ( value < 0 ) then
            chatframe:PageDown();
        end
    end
end

SetCVar("chatMouseScroll", 1)

CoreOnEvent("PLAYER_LOGIN", function()
    WithAllChatFrame(function(cf)
        CoreHookScript(cf, "OnMouseWheel", chatFrameOnMouseWheel, true)
        cf:SetMaxResize((UIParent:GetWidth() or 1024)-100, "800");
        cf.editBox:SetAltArrowKeyMode(false)

        --5.4聊天框历史记录
        cf.editBox["historyIndex"] = 1;
        hooksecurefunc(cf.editBox, "AddHistoryLine", U1_Chat_AddHistoryLine);
        hooksecurefunc(cf.editBox, "ClearHistory", U1_Chat_ClearHistory);
        cf.editBox:SetScript("OnArrowPressed", U1_Chat_OnArrowPressed);
    end);
    return true;
end, true);

ChatTypeInfo["WHISPER"].sticky = 0
ChatTypeInfo["BN_WHISPER"].sticky = 0
ChatTypeInfo["CHANNEL"].sticky = 1;
ChatTypeInfo["OFFICER"].sticky = 1;

local CHAT_FONT_HEIGHTS = { 9, 20, 22, 26 }
WithAllChatFrame(function(f)
    local a,b,c,d = f:GetClampRectInsets()
    d = -2
    f:SetClampRectInsets(a,b,c,d)
    hooksecurefunc(_G[f:GetName().."TabDropDown"], "initialize", function(dropDown)
        if UIDROPDOWNMENU_MENU_LEVEL == 1 then
            local info = UIDropDownMenu_CreateInfo();
            info.text = "清除此窗口";
            info.func = function(self, arg1) StaticPopup_Show("163UI_CHAT_CLEAR", _G[arg1:GetName().."Tab"]:GetText(), nil, arg1); end;
            info.arg1 = FCF_GetCurrentChatFrame(dropDown);
            info.notCheckable = 1;
            UIDropDownMenu_AddButton(info);
        elseif ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then
            -- If this is the font size menu then create dropdown
            if ( UIDROPDOWNMENU_MENU_VALUE == FONT_SIZE ) then
                -- Add the font heights from the font height table
                local value, info;
                for i=1, #CHAT_FONT_HEIGHTS do
                    value = CHAT_FONT_HEIGHTS[i];
                    info = UIDropDownMenu_CreateInfo();
                    info.text = format(FONT_SIZE_TEMPLATE, value);
                    info.value = value;
                    info.func = FCF_SetChatWindowFontSize;

                    local fontFile, fontHeight, fontFlags = FCF_GetCurrentChatFrame():GetFont();
                    if ( value == floor(fontHeight+0.5) ) then
                        info.checked = 1;
                    end

                    UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
                end
                return;
            end
            return;
        end
    end)
end)

function U1_Chat_EnableChatColorNamesByClassGroup(toggle)
    if(toggle) then
        for k, v in pairs(CHAT_CONFIG_CHAT_LEFT) do
            ToggleChatColorNamesByClassGroup(true, v.type)
        end
        for i = 1, 10 do
            ToggleChatColorNamesByClassGroup(true, 'CHANNEL' .. i)
        end
    end
end

--5.4聊天框历史记录
local U1_ChatHistory = {}

function U1_Chat_AddHistoryLine(self, text)
    if not text or text == "" then
        return;
    end

    local history = U1_ChatHistory;
    local maxlines = self:GetHistoryLines() or 1;
    local x = self["historyIndex"];

    if ( x >= maxlines ) then
        x = maxlines;
        self["historyIndex"] = 1;
    elseif ( x < 1 ) then
        x = 1;
        self["historyIndex"] = 2;
    else
        self["historyIndex"] = x + 1;
    end
    if (#history < maxlines) then
        if (history[x] ~= text) then
            tinsert(history, x, text);
        end
    else
        history[x] = text;
    end
end

function U1_Chat_ClearHistory(self)
    U1_ChatHistory = {}
end

function U1_Chat_OnArrowPressed(self, key)
	if ( key == "UP" ) then
		return ChatHistory_FetchNext(self, true);
	elseif ( key == "DOWN" ) then
		return ChatHistory_FetchNext(self, false);
	end
end

function ChatHistory_FetchNext(self, prev)
    local history = U1_ChatHistory;
    if ( (history == nil) or (#history == 0) ) then
        return;
    end

    local maxlines = self:GetHistoryLines() or 1;
    maxlines = #history < maxlines and #history or maxlines;
    local i = self["historyIndex"] or (prev and 1 or maxlines);
    if prev then
        i = i - 2;
    end
    i = (i % maxlines) + 1;

    self["historyIndex"] = i;

    local s = history[i];
    if ( s ) then
        self:SetText(s);
    end
end
