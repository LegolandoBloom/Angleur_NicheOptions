local T = AngleurNicheOptions_Translate

-- Disable Click-to-Move
function AngleurNicheOptions_HandleClickToMove(disable)
    if disable == true then
        AngleurNicheOptions_TempCVarHandler:Set("autoInteract")
    elseif disable == false then
        AngleurNicheOptions_TempCVarHandler:Release("autoInteract")
    end
end
AngleurNicheOptions_Sleeping = nil
EventRegistry:RegisterCallback("Angleur_Sleep", function()
    AngleurNicheOptions_Sleeping = true
    if AngleurNicheOptions_UI.checkboxes[1].disableClickMove == true then
        AngleurNicheOptions_HandleClickToMove(false)
    end
end)

EventRegistry:RegisterCallback("Angleur_Wake", function()
    AngleurNicheOptions_Sleeping = false
    if AngleurConfig.chosenMethod == "oneKey" then return end
    if AngleurNicheOptions_UI.checkboxes[1].disableClickMove == true then
        AngleurNicheOptions_HandleClickToMove(true)
    end
end)
EventRegistry:RegisterCallback("Angleur_StartFishing", function()
end)
EventRegistry:RegisterCallback("Angleur_StopFishing", function()
end)



-- Sit While Fishing
EventRegistry:RegisterCallback("Angleur_StopFishing", function()
    if AngleurNicheOptions_UI.checkboxes[2].sitWhileFishing == true then
        DoEmote("SIT")
    end
end)
