Legolando_CheckboxFrameMixin_AngleurNicheOptions = {};

function Legolando_CheckboxFrameMixin_AngleurNicheOptions:greyOut()
    self.checkbox:SetChecked(false)
    self.checkbox:Disable()
    self.text:SetTextColor(0.9, 0.9, 0.9)
    self.disabledText:Show()
    if self.dropDown then
        self.dropDown:Hide()
    end
end

Legolando_CheckboxMixin_AngleurNicheOptions = {}

function Legolando_CheckboxMixin_AngleurNicheOptions:OnClick()
    local parent = self:GetParent()
    local grandParent = parent:GetParent()
    local teeburu = grandParent.savedVarTable
    if not parent.reference then 
        print("no checkbox reference string")
        return
    end
    if not teeburu then 
        print("no saved variable table attached")
        return 
    end
    if teeburu[parent.reference] == nil then
        print("checkbox reference not found in saved variable table")
        return
    end
    if self:GetChecked() then
        teeburu[parent.reference] = true
    elseif self:GetChecked() == false then
        teeburu[parent.reference] = false
    end
    if parent.onClickCallback then
        parent.onClickCallback(self, self:GetChecked())
    end
end

Legolando_CheckboxesMixin_AngleurNicheOptions = {}

function Legolando_CheckboxesMixin_AngleurNicheOptions:Update()
    local teeburu = self.savedVarTable
    if not teeburu then
        print("checkbox parent doesn't have a saved variable table attached")
        return
    end
    local children = {self:GetChildren()}
    for i, child in pairs(children) do
        if child.checkbox and child.reference then
            local savedVar = teeburu[child.reference]
            if savedVar then
                if savedVar == true then
                    child.checkbox:SetChecked(true)
                elseif savedVar == false then
                    child.checkbox:SetChecked(false)
                end
            end
        end
    end
end