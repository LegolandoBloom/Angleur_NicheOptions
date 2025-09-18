AngleurNicheOptions_Translate = {}
local T = AngleurNicheOptions_Translate

local colorNicheOptions = CreateColor(1, 0.48, 0.96)
local colorUnderlight = CreateColor(0.9, 0.8, 0.5)
local colorYello = CreateColor(1.0, 0.82, 0.0)
local colorBlu = CreateColor(0.61, 0.85, 0.92)
local colorWhite = CreateColor(1, 1, 1)
local colorDarkBlu = CreateColor(0.35, 0.45, 0.92)
local colorGrae = CreateColor(0.85, 0.85, 0.85)
local colorGreen = CreateColor(0, 1, 0)

T["Angleur_NicheOptions Config"] = colorNicheOptions:WrapTextInColorCode("Angleur_NicheOptions Config")
T["Disable Click-to-Move"] = "Disable Click-to-Move"
T["Sit While Fishing"] = "Sit While Fishing"

T["When enabled, Angleur will temporarily turn off the \'Click-to-Move\' feature "
.. "while it's in \'Awake\' mode if you are using Double-Click fishing, so you don't accidentaly move when you try to fish. If you are "
.. "using OneKey fishing, \'Click-to-Move\' won't be changed."] = "When " .. colorGreen:WrapTextInColorCode("enabled, ") 
.. colorBlu:WrapTextInColorCode("Angleur ") .. "will temporarily turn off the " .. colorYello:WrapTextInColorCode("\'Click-to-Move\' ") 
.. "feature " .. "while it's in " .. "\'Awake\' " .. "mode if you are using " 
.. colorBlu:WrapTextInColorCode("Double-Click ") .. "fishing,\n\nso you don't accidentaly move when you try to fish.\n\nIf you are " 
.. "using " .. colorBlu:WrapTextInColorCode("OneKey ") .. "fishing, " .. colorYello:WrapTextInColorCode("\'Click-to-Move\' ") .. "won't be changed."

T["Cast the /sit emote when cast your fishing rod. Fish in comfort!"] = "Cast the " .. colorYello:WrapTextInColorCode("/sit ") 
.. "emote when cast your fishing rod. Fish in comfort!"
