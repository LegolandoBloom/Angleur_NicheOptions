local T = AngleurNicheOptions_Translate

local tabNames = {
    [1] = "Accessibility",
    [2] = "Fun",
}
local completed = false
function AngleurNicheOptions_SetupUI(self)
    if completed then return end
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
    completed = true
end