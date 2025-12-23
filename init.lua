local T = AngleurNicheOptions_Translate

AngleurNicheOptions_Config = {

}

AngleurNicheOptions_Character ={

}

AngleurNicheOptions_UI = {
    checkboxes = {

    },
}

AngleurNicheOptions_SavedCVars = {
    clickToMove,
}

function AngleurNicheOptions_SavedVariables()
    if not AngleurNicheOptions_Config then
        AngleurNicheOptions_Config = {}
    end

    if not AngleurNicheOptions_Character then
        AngleurNicheOptions_Character = {}
    end
    
    if not AngleurNicheOptions_UI then
        AngleurNicheOptions_UI = {}
    end
    if not AngleurNicheOptions_UI.checkboxes then
        AngleurNicheOptions_UI.checkboxes = {}
    end
    if not AngleurNicheOptions_UI.checkboxes[1] then
        AngleurNicheOptions_UI.checkboxes[1] = {}
    end
    if not AngleurNicheOptions_UI.checkboxes[1].disableClickMove then
        AngleurNicheOptions_UI.checkboxes[1].disableClickMove = false
    end
    if not AngleurNicheOptions_UI.checkboxes[1].moreItems then
        AngleurNicheOptions_UI.checkboxes[1].moreItems = false
    end
    -- if not AngleurNicheOptions_UI.checkboxes[1].blep then
    --     AngleurNicheOptions_UI.checkboxes[1].blep = falseg
    -- end

    if not AngleurNicheOptions_UI.checkboxes[2] then
        AngleurNicheOptions_UI.checkboxes[2] = {}
    end
    if not AngleurNicheOptions_UI.checkboxes[2].sitWhileFishing then
        AngleurNicheOptions_UI.checkboxes[2].sitWhileFishing = false
    end
    -- if not AngleurNicheOptions_UI.checkboxes[2].glep then
    --     AngleurNicheOptions_UI.checkboxes[2].glep = false
    -- end
end

function AngleurNicheOptions_OnLoad(self)
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("ADDON_LOADED")
    self:SetScript("OnEvent", AngleurNicheOptions_EventLoader)
    -- Thievery_SetupConfigPanel(self)
    -- self.pickpocketButton:RegisterForClicks("AnyUp", "AnyDown")
    -- self.pickpocketButton:RegisterEvent("PLAYER_SOFT_INTERACT_CHANGED")
    -- self.pickpocketButton:RegisterEvent("PLAYER_SOFT_ENEMY_CHANGED")
end

function AngleurNicheOptions_EventLoader(self, event, unit, ...)
    local arg4, arg5 = ...
    if event == "ADDON_LOADED" and unit == "Angleur_NicheOptions" then
        AngleurNicheOptions_SavedVariables()
        AngleurNicheOptions_SetupUI(self)
    elseif event == "PLAYER_ENTERING_WORLD" then
        if unit == false and arg4 == false then return end

    end
end