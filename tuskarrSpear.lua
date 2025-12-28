-- Only for Mists of Pandaria

    -- C_Item.IsEquippableItem(itemInfo)
    -- C_Item.GetItemCount(itemInfo) < 1
    -- C_Item.IsEquippedItem(itemID)
    -- IsInventoryItemLocked(location)
    -- C_Item.EquipItemByName(itemID)
    -- local startTime, duration = C_Container.GetItemCooldown(itemID)

    -- 88535 --> Tuskarr Spear itemID



local function isValid(itemID, slot)
    if not C_Item.IsEquippableItem(88535) then return false end
    if C_Item.GetItemCount(88535) < 1 then return false end
    if IsInventoryItemLocked(slot) then return false end
    return true
end

local function unequipSpear()
    local offHand = AngleurNicheOptions_Character.unequippedItems[INVSLOT_OFFHAND]
    if offHand and not isValid(offHand, INVSLOT_OFFHAND) then
        AngleurNicheOptions_Character.unequippedItems[INVSLOT_OFFHAND] = nil
        offHand = nil
    end
    if offHand then
        if C_Item.IsEquippedItem(offHand) then
            AngleurNicheOptions_Character.unequippedItems[INVSLOT_OFFHAND] = nil
        else
            C_Item.EquipItemByName(AngleurNicheOptions_Character.unequippedItems[INVSLOT_OFFHAND])
        end
    end
    local mainHand = AngleurNicheOptions_Character.unequippedItems[INVSLOT_MAINHAND]
    if mainHand and not isValid(mainHand, INVSLOT_MAINHAND) then
        AngleurNicheOptions_Character.unequippedItems[INVSLOT_MAINHAND] = nil
        mainHand = nil
    end
    if mainHand then
        if C_Item.IsEquippedItem(mainHand) then
            AngleurNicheOptions_Character.unequippedItems[INVSLOT_MAINHAND] = nil
        else
            C_Item.EquipItemByName(mainHand)
        end
    end
end
local unequipping = false
function AngleurNicheOptions_UnequipSpear_SetDelayer()
    if unequipping then return end
    if next(AngleurNicheOptions_Character.unequippedItems) == nil then return end
    unequipping = true
    unequipSpear()
    Angleur_PoolDelayer(5, 0, 0.2, angleurDelayers, function()
        if next(AngleurNicheOptions_Character.unequippedItems) == nil then
            -- releases the delayer
            unequipping = false
            return true
        end
        if not InCombatLockdown() then
            unequipSpear()
        end
    end, function()
        print("Spear unequip timed out")
        unequipping = false
        -- If player is in combat, don't empty the unequipTable so that we can try later through ActionHandler() --> JuggleSpear() 
        if not InCombatLockdown() then
            AngleurNicheOptions_Character.unequippedItems = {}
        end
    end, "tuskarrSpear_Unequip")
end

function AngleurNicheOptions_JuggleSpear(forceUnequip)
    if InCombatLockdown() then return end
    if not C_Item.IsEquippableItem(88535) then return end
    if C_Item.GetItemCount(88535) < 1 then return end
    if IsInventoryItemLocked(INVSLOT_MAINHAND) then return end

    local equipped = C_Item.IsEquippedItem(88535)
    local onCooldown = C_Container.GetItemCooldown(88535) > 0

    if forceUnequip and equipped then
        AngleurNicheOptions_UnequipSpear_SetDelayer()
    end

    if not equipped and onCooldown then
        AngleurNicheOptions_Character.unequippedItems = {}
        return false
    end
    if not equipped and not onCooldown then
        AngleurNicheOptions_Character.unequippedItems[INVSLOT_MAINHAND] = GetInventoryItemID("player", INVSLOT_MAINHAND)
        AngleurNicheOptions_Character.unequippedItems[INVSLOT_OFFHAND] = GetInventoryItemID("player", INVSLOT_OFFHAND)
        C_Item.EquipItemByName(88535)
        return false
    end
    if equipped and not onCooldown then
        return true
    end
    if equipped and onCooldown then
        AngleurNicheOptions_UnequipSpear_SetDelayer()
    end
end


EventRegistry:RegisterCallback("Angleur_Sleep", function()
	print("Angleur Sleepy")
    AngleurNicheOptions_JuggleSpear(true)
end)