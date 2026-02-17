local T = AngleurNicheOptions_Translate

-- 'angNiche' is the NicheOptions namespace
local addonName, angNiche = ...

AngleurNicheOptions_Config = {

}

AngleurNicheOptions_Character ={

}

AngleurNicheOptions_UI = {
    checkboxes = {

    },
}

AngleurNicheOptions_SavedCVars = {
    -- clickToMove,
}

function AngleurNicheOptions_SavedVariables()
    if not AngleurNicheOptions_Config then
        AngleurNicheOptions_Config = {}
    end

    if not AngleurNicheOptions_Character then
        AngleurNicheOptions_Character = {}
    end
    if not AngleurNicheOptions_Character.unequippedItems then
        AngleurNicheOptions_Character.unequippedItems = {}
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
    if not AngleurNicheOptions_UI.checkboxes[1].tuskarrSpear then
        AngleurNicheOptions_UI.checkboxes[1].tuskarrSpear = false
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
    self:RegisterEvent("PLAYER_LOGOUT")
    self:SetScript("OnEvent", AngleurNicheOptions_EventLoader)
    -- 1 : Retail | 2 : MoP(Or Cata) | 3 : Vanilla | (0: None, fail)
    angNiche.gameVersion = Angleur_CheckVersion()
    -- self.pickpocketButton:RegisterForClicks("AnyUp", "AnyDown")
    -- self.pickpocketButton:RegisterEvent("PLAYER_SOFT_INTERACT_CHANGED")
    -- self.pickpocketButton:RegisterEvent("PLAYER_SOFT_ENEMY_CHANGED")
end


AngleurNicheOptions_TempCVars = {
    autoInteract = {
        active = false, cached = nil, setTo = "0", updating = false,
    },
}
AngleurNicheOptions_TempCVarHandler = CreateFrame("Frame", "Example_CVarHandler", UIParent, "Legolando_TempCVarHandlerTemplate_AngleurNicheOptions")
AngleurNicheOptions_TempCVarHandler.tempCVarsTable = AngleurNicheOptions_TempCVars
AngleurNicheOptions_TempCVarHandler:Init()

function AngleurNicheOptions_EventLoader(self, event, unit, ...)
    local arg4, arg5 = ...
    if event == "ADDON_LOADED" and unit == "Angleur_NicheOptions" then
        AngleurNicheOptions_SavedVariables()
        AngleurNicheOptions_SetupUI(self)
    elseif event == "PLAYER_ENTERING_WORLD" then
        if unit == false and arg4 == false then return end
    elseif event == "PLAYER_LOGOUT" then
        AngleurNicheOptions_TempCVarHandler:ReleaseAll()
    end
end