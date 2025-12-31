-- Only for Mists of Pandaria


-- 88535 --> Sharpened Tuskarr Spear itemID

-- 43656 --> Tome of Kings itemID(For testing)


-- _____________________________ EVENT for AngleurMists _____________________________
--                             PAYLOAD: spearStatus        
--          "equipping" | "equipped" | "unequipping" | "unequipped"
--                  so it knows not go to sleep during juggling
local lastStatus
function AngleurNicheOptions_UpdateSpearStatus(spearStatus)
    lastStatus = spearStatus
    EventRegistry:TriggerEvent("AngleurNicheOptions_UpdateSpearStatus", spearStatus)
end
-- __________________________________________________________________________________



local function isValid(itemID, slot)
    if not C_Item.IsEquippableItem(43656) then return false end
    if C_Item.GetItemCount(43656) < 1 then return false end
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
-- Don't confuse unequipping(bool) with spearStatus = "unequipping" which is just used as a payload for informing Angleur
local unequipping = false
function AngleurNicheOptions_UnequipSpear_SetDelayer()
    if unequipping then return end
    if next(AngleurNicheOptions_Character.unequippedItems) == nil then
        Angleur_BetaPrint(0, "unequip list empty, returning")
        return     
    end
    unequipping = true
    unequipSpear()
    Angleur_BetaPrint(0, "Starting unequip delayer for:")
    Angleur_BetaDump(0, AngleurNicheOptions_Character.unequippedItems)
    Angleur_PoolDelayer(5, 0, 0.2, angleurDelayers, function()
        if next(AngleurNicheOptions_Character.unequippedItems) == nil then
            -- releases the delayer
            unequipping = false
            Angleur_BetaPrint(0, "Successfully unequipped")
            AngleurNicheOptions_UpdateSpearStatus("unequipped")
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
    if not C_Item.IsEquippableItem(43656) then return end
    if C_Item.GetItemCount(43656) < 1 then return end
    if IsInventoryItemLocked(INVSLOT_MAINHAND) then return end

    local equipped = C_Item.IsEquippedItem(43656)
    local startTime, duration = C_Container.GetItemCooldown(43656)
    local onCooldown = false
    if startTime == 0 then
        -- stay false
    else
        --__________________________________________________________________________________________________________
        -- Keep this bit commented - used for testing on Lego's account with the 30 sec equip cooldown Tome of Kings
        -- local cooldown = (startTime + duration) - GetTime()
        -- onCooldown = cooldown > 35
        -- print(onCooldown, cooldown)
        --__________________________________________________________________________________________________________

        onCooldown = true
    end
    
    -- Force Unequip Spear
    if forceUnequip and equipped then
        AngleurNicheOptions_UpdateSpearStatus("unequipping")
        AngleurNicheOptions_UnequipSpear_SetDelayer()
    end

    -- Keep Spear Unequipped
    if not equipped and onCooldown then
        if lastStatus and lastStatus ~= "equipping" then
            AngleurNicheOptions_UpdateSpearStatus("unequipped")
        end
        return false
    end

    -- Equip Spear
    if not equipped and not onCooldown then
        AngleurNicheOptions_UpdateSpearStatus("equipping")
        AngleurNicheOptions_Character.unequippedItems = {}
        AngleurNicheOptions_Character.unequippedItems[INVSLOT_MAINHAND] = GetInventoryItemID("player", INVSLOT_MAINHAND)
        AngleurNicheOptions_Character.unequippedItems[INVSLOT_OFFHAND] = GetInventoryItemID("player", INVSLOT_OFFHAND)
        Angleur_BetaPrint(0, "Spear off cooldown, equipping")
        Angleur_BetaPrint(0, "UNEQUIPS:")
        Angleur_BetaDump(0, AngleurNicheOptions_Character.unequippedItems)
        C_Item.EquipItemByName(43656)
        return false
    end

    -- Keep Spear Equipped
    if equipped and not onCooldown then
        if lastStatus and lastStatus ~= "unequipping" then
            AngleurNicheOptions_UpdateSpearStatus("equipped")
        end
        Angleur_BetaPrint(0, "waiting - use spear")
        return true
    end

    -- Unequip Spear
    if equipped and onCooldown then
        AngleurNicheOptions_UpdateSpearStatus("unequipping")
        AngleurNicheOptions_UnequipSpear_SetDelayer()
    end
end

-- If Angleur is put to sleep with the Tuskarr Spear NicheOption checked ON, forcibly UNEQUIP the Spear
EventRegistry:RegisterCallback("Angleur_Sleep", function()
    if AngleurNicheOptions_UI.checkboxes[1].tuskarrSpear then
        AngleurNicheOptions_JuggleSpear(true)
    end
end)

