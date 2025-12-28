local T = AngleurNicheOptions_Translate

-- 'angNiche' is the NicheOptions namespace
local addonName, angNiche = ...

local tabNames = {
    [1] = "Accessibility",
    [2] = "Fun",
}
local completed = false
function AngleurNicheOptions_SetupUI(self)
    if completed then return end
    
    local gameVersion = angNiche.gameVersion

    self.icon:SetTexture("Interface/Addons/Angleur_NicheOptions/images/buttonart.png")
    self.icon:SetSize(30, 30)
    self.popup:AdjustPointsOffset(5, 0)
    self:Init(tabNames)

    self.popup.title:SetText(T["Angleur_NicheOptions Config"])

    self.popup.checkboxes1.disableClickMove.text:SetText(T["Disable Click-to-Move"])
    self.popup.checkboxes1.disableClickMove.text.tooltip = T["When enabled, Angleur will temporarily turn off the \'Click-to-Move\' feature "
    .. "while it's in \'Awake\' mode if you are using Double-Click fishing, so you don't accidentaly move when you try to fish. If you are "
    .. "using OneKey fishing, \'Click-to-Move\' won't be changed."]
    self.popup.checkboxes1.disableClickMove:reposition()
    self.popup.checkboxes1.disableClickMove.reference = "disableClickMove"
    self.popup.checkboxes1.disableClickMove:HookScript("OnClick", function(self)
        if self:GetChecked() then
            if AngleurConfig.chosenMethod == "oneKey" then return end
            if AngleurNicheOptions_Sleeping == false then
                AngleurNicheOptions_HandleClickToMove(true)
            end
        elseif self:GetChecked() == false then
            AngleurNicheOptions_HandleClickToMove(false)
        end
    end)

    self.popup.checkboxes1.moreItems.text:SetText(T["More \'Extra Items\'"])
    self.popup.checkboxes1.moreItems.text.tooltip = T["When enabled, will increase Angleur's \'Extra Items\' slots from 3 to 6"]
    self.popup.checkboxes1.moreItems:reposition()
    self.popup.checkboxes1.moreItems.reference = "moreItems"
    self.popup.checkboxes1.moreItems:HookScript("OnClick", function(self)
        if self:GetChecked() then
            AngleurNicheOptions_ReloadWarning:Show()
        elseif self:GetChecked() == false then
            AngleurNicheOptions_ReloadWarning:Show()
        end
    end)


    if gameVersion == 2 then
        self.popup.checkboxes1.tuskarrSpear.text:SetText(T["Use The Tuskarr Spear"])
        self.popup.checkboxes1.tuskarrSpear.text.tooltip = T["When enabled, Angleur will have you equip -> use -> unequip the Tuskarr Spear whenever it's off cooldown."]
        self.popup.checkboxes1.tuskarrSpear:reposition()
        self.popup.checkboxes1.tuskarrSpear.reference = "tuskarrSpear"
        self.popup.checkboxes1.tuskarrSpear:HookScript("OnClick", function(self)
            if self:GetChecked() then

            elseif self:GetChecked() == false then
                local equipped = C_Item.IsEquippedItem(88535)
                if equipped and not InCombatLockdown() then 
                    AngleurNicheOptions_UnequipSpear_SetDelayer()
                end
            end
        end)
    else
        self.popup.checkboxes1.tuskarrSpear:Hide()
    end

    -- self.popup.checkboxes1.blep.text:SetText("Blep")
    -- self.popup.checkboxes1.blep:reposition()
    -- self.popup.checkboxes1.blep.reference = "blep"

    self.popup.checkboxes1.savedVarTable = AngleurNicheOptions_UI.checkboxes[1]
    self.popup.checkboxes1:Update()

    
    self.popup.checkboxes2.sitWhileFishing.text:SetText(T["Sit While Fishing"])
    self.popup.checkboxes2.sitWhileFishing.text.tooltip = T["Cast the /sit emote after your first cast. Fish in comfort!"]
    self.popup.checkboxes2.sitWhileFishing:reposition()
    self.popup.checkboxes2.sitWhileFishing.reference = "sitWhileFishing"


    self.popup.checkboxes2.savedVarTable = AngleurNicheOptions_UI.checkboxes[2]
    self.popup.checkboxes2:Update()

    
    AngleurNicheOptions_ReloadWarning.TitleText:SetText(T["Angleur_NicheOptions Warning"])
    AngleurNicheOptions_ReloadWarning.mainText:SetText(T["You need to reload the UI for the changes to take effect."])
    AngleurNicheOptions_ReloadWarning.reloadButton:SetText(T["Reload"])
    
    completed = true
end