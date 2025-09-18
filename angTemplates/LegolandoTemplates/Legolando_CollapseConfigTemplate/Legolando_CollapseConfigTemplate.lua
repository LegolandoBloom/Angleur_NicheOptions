-- ____________________________________[1]______________________________________________
--       Templates Ported directly from Blizzard's FrameXML, for classic parity
-- ____________________________________[1]______________________________________________
local TabSideExtraSpacing = 20;
Legolando_PortedTabSystemButtonArtMixin_AngleurNicheOptions = {};
function Legolando_PortedTabSystemButtonArtMixin_AngleurNicheOptions:HandleRotation()
	if self.isTabOnTop then
		for _, texture in ipairs(self.RotatedTextures) do
			texture:ClearAllPoints();
			texture:SetRotation(math.pi);
		end
		self.RightActive:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", -7, 0);
		self.LeftActive:SetPoint("BOTTOMRIGHT");
		self.MiddleActive:SetPoint("LEFT", self.RightActive, "RIGHT");
		self.MiddleActive:SetPoint("RIGHT", self.LeftActive, "LEFT");
		self.Right:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", -6, 0);
		self.Left:SetPoint("BOTTOMRIGHT");
		self.Middle:SetPoint("LEFT", self.Right, "RIGHT");
		self.Middle:SetPoint("RIGHT", self.Left, "LEFT");
		self.LeftHighlight:SetPoint("TOPRIGHT", self.Left);
		self.RightHighlight:SetPoint("TOPLEFT", self.Right);
		self.MiddleHighlight:SetPoint("LEFT", self.Middle, "LEFT");
		self.MiddleHighlight:SetPoint("RIGHT", self.Middle, "RIGHT");
	end
end
function Legolando_PortedTabSystemButtonArtMixin_AngleurNicheOptions:GetTextYOffset(isSelected)
	if self.isTabOnTop then
		return isSelected and 0 or -3;
	else
		return isSelected and -3 or 2;
	end
end
function Legolando_PortedTabSystemButtonArtMixin_AngleurNicheOptions:SetTabSelected(isSelected)
	self.isSelected = isSelected;
	self.Left:SetShown(not isSelected);
	self.Middle:SetShown(not isSelected);
	self.Right:SetShown(not isSelected);
	self.LeftActive:SetShown(isSelected);
	self.MiddleActive:SetShown(isSelected);
	self.RightActive:SetShown(isSelected);
	local selectedFontObject = self.selectedFontObject or GameFontHighlightSmall;
	local unselectedFontObject = self.unselectedFontObject or GameFontNormalSmall;
	self:SetNormalFontObject(isSelected and selectedFontObject or unselectedFontObject);
	self:SetEnabled(not isSelected and not self.forceDisabled);
	self.Text:SetPoint("CENTER", self, "CENTER", 0, self:GetTextYOffset(isSelected));
	local tooltip = GetAppropriateTooltip();
	if tooltip:IsOwned(self) then
		tooltip:Hide();
	end
end
function Legolando_PortedTabSystemButtonArtMixin_AngleurNicheOptions:SetTabWidth(width)
	self:SetWidth(width);
end

Legolando_PortedTabSystemButtonMixin_AngleurNicheOptions = {};
function Legolando_PortedTabSystemButtonMixin_AngleurNicheOptions:OnEnter()
	if not self:IsEnabled() and self.errorReason ~= nil then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -12, -6);
		GameTooltip_AddErrorLine(GameTooltip, self.errorReason);
		if self.tooltipText then
			GameTooltip_AddBlankLineToTooltip(GameTooltip);
			GameTooltip_AddNormalLine(GameTooltip, self.tooltipText);
		end
		GameTooltip:Show();
	elseif self.tooltipText then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -12, -6);
		GameTooltip_AddNormalLine(GameTooltip, self.tooltipText);
		GameTooltip:Show();
	elseif self.Text:IsTruncated() then
		local text = self.Text:GetText();
		if text then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -12, -6);
			GameTooltip_AddNormalLine(GameTooltip, text);
			GameTooltip:Show();
		end
	end
end
function Legolando_PortedTabSystemButtonMixin_AngleurNicheOptions:OnLeave()
	GameTooltip_Hide();
end
function Legolando_PortedTabSystemButtonMixin_AngleurNicheOptions:OnClick()
	local tabSystem = self:GetTabSystem();
	tabSystem:PlayTabSelectSound();
	tabSystem:SetTab(self:GetTabID());
end
function Legolando_PortedTabSystemButtonMixin_AngleurNicheOptions:Init(tabID, tabText)
	self.tabID = tabID;
	self:HandleRotation();
	self.tabText = tabText;
	self:SetText(tabText);
	self:UpdateTabWidth();
	self:SetTabSelected(false);
end
function Legolando_PortedTabSystemButtonMixin_AngleurNicheOptions:SetTooltipText(tooltipText)
	self.tooltipText = tooltipText;
end
function Legolando_PortedTabSystemButtonMixin_AngleurNicheOptions:SetTabEnabled(enabled, errorReason)
	self.forceDisabled = not enabled;
	self:SetEnabled(enabled and not self.isSelected);
	local text = enabled and self.tabText or DISABLED_FONT_COLOR:WrapTextInColorCode(self.tabText);
	self.Text:SetText(text);
	self.errorReason = errorReason;
end
function Legolando_PortedTabSystemButtonMixin_AngleurNicheOptions:UpdateTabWidth()
	local sidesWidth = self.Left:GetWidth() + self.Right:GetWidth();
	local width = sidesWidth + TabSideExtraSpacing;
	local minTabWidth, maxTabWidth = self:GetTabSystem():GetTabWidthConstraints();
	local textWidth;
	if maxTabWidth and width > maxTabWidth then
		width = maxTabWidth;
		textWidth = width - 10;
	end
	if minTabWidth and width < minTabWidth then
		width = minTabWidth;
		textWidth = width - 10;
	end
	self.Text:SetWidth(textWidth or 0);
	self:SetTabWidth(width);
end
function Legolando_PortedTabSystemButtonMixin_AngleurNicheOptions:GetTabID()
	return self.tabID;
end
function Legolando_PortedTabSystemButtonMixin_AngleurNicheOptions:GetTabSystem()
	return self:GetParent();
end

Legolando_PortedTabSystemMixin_AngleurNicheOptions = {};
function Legolando_PortedTabSystemMixin_AngleurNicheOptions:OnLoad()
	self.tabs = {};
	self.tabPool = CreateFramePool("BUTTON", self, self.tabTemplate);
end
function Legolando_PortedTabSystemMixin_AngleurNicheOptions:AddTab(tabText)
	local tabID = #self.tabs + 1;
	local newTab = self.tabPool:Acquire();
	table.insert(self.tabs, newTab);
	newTab.layoutIndex = tabID;
	newTab:Init(tabID, tabText);
	newTab:Show();
	self:MarkDirty();
	return tabID;
end
function Legolando_PortedTabSystemMixin_AngleurNicheOptions:SetTabSelectedCallback(tabSelectedCallback)
	self.tabSelectedCallback = tabSelectedCallback;
end
function Legolando_PortedTabSystemMixin_AngleurNicheOptions:SetTab(tabID)
	if not self.tabSelectedCallback(tabID) then
		self:SetTabVisuallySelected(tabID);
	end
end
function Legolando_PortedTabSystemMixin_AngleurNicheOptions:SetTabVisuallySelected(tabID)
	self.selectedTabID = tabID;
	for i, tab in ipairs(self.tabs) do
		tab:SetTabSelected(tab:GetTabID() == tabID);
	end
end
function Legolando_PortedTabSystemMixin_AngleurNicheOptions:SetTabShown(tabID, isShown)
	self.tabs[tabID]:SetShown(isShown);
	self:MarkDirty();
end
function Legolando_PortedTabSystemMixin_AngleurNicheOptions:SetTabEnabled(tabID, enabled, errorReason)
	self.tabs[tabID]:SetTabEnabled(enabled, errorReason);
	self:MarkDirty();
end
function Legolando_PortedTabSystemMixin_AngleurNicheOptions:GetTabWidthConstraints()
	return self.minTabWidth, self.maxTabWidth;
end
function Legolando_PortedTabSystemMixin_AngleurNicheOptions:GetTabButton(tabID)
	return self.tabs[tabID];
end
function Legolando_PortedTabSystemMixin_AngleurNicheOptions:PlayTabSelectSound()
	if self.tabSelectSound then
		PlaySound(self.tabSelectSound);
	end
end
-- ____________________________________[1]______________________________________________
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


-- ____________________________________[2]______________________________________________
--                          Templates made by Legolando                                 
-- ____________________________________[2]______________________________________________
Legolando_CollapseConfigMixin_AngleurNicheOptions = {}

function Legolando_CollapseConfigMixin_AngleurNicheOptions:Init(tabNames)
    if tabNames and next(tabNames) ~= nil then
        local tabs = self.popup.tabs
        for i, name in ipairs(tabNames) do
            tabs:AddTab(name)
        end
        local function tabSelectedCallback(tabID)
            local children = {self.popup:GetChildren()}
            for i, v in pairs(children) do
                local id = v:GetID()
                if id and id ~= 0 then
                    if id == tabID then
                        v:Show()
                    else
                        v:Hide()
                    end
                end
            end
            -- if tabID == 1 then
            --     print("this is tab 1")
            -- elseif tabID == 2 then
            --     print("this is tab 2")
            -- elseif tabID == 3 then
            --     print("this is tab 3")
            -- end
        end
        tabs:SetTabSelectedCallback(tabSelectedCallback)
        tabs:SetTab(1)
    end
end

function Legolando_CollapseConfigMixin_AngleurNicheOptions:Update()
    local teeburu = self.savedVarTable
    if not teeburu then
        print("checkbox parent doesn't have a saved variable table attached")
        return
    end
    local children = {self.popup:GetChildren()}
    for i, child in pairs(children) do
        if child:GetObjectType() == "CheckButton" and child.reference then
            local savedVar = teeburu[child.reference]
            if savedVar then
                if savedVar == true then
                    child:SetChecked(true)
                elseif savedVar == false then
                    child:SetChecked(false)
                end
            end
        end
    end
end
-- ____________________________________[2]______________________________________________
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
