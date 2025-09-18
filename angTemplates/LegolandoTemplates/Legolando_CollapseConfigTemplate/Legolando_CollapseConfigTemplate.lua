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
