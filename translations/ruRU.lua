if (GAME_LOCALE or GetLocale()) ~= "ruRU" then
  return
end

local T = AngleurNicheOptions_Translate
-- Translator ZamestoTV
local colorNicheOptions = CreateColor(1, 0.48, 0.96)
local colorUnderlight = CreateColor(0.9, 0.8, 0.5)
local colorYello = CreateColor(1.0, 0.82, 0.0)
local colorBlu = CreateColor(0.61, 0.85, 0.92)
local colorWhite = CreateColor(1, 1, 1)
local colorDarkBlu = CreateColor(0.35, 0.45, 0.92)
local colorGrae = CreateColor(0.85, 0.85, 0.85)
local colorGreen = CreateColor(0, 1, 0)

T["Angleur_NicheOptions Config"] = colorNicheOptions:WrapTextInColorCode("Настройки Angleur_NicheOptions")
T["Disable Click-to-Move"] = "Отключить движение по клику"
T["Sit While Fishing"] = "Сидеть во время рыбалки"

T["When enabled, Angleur will temporarily turn off the \'Click-to-Move\' feature "
.. "while it's in \'Awake\' mode if you are using Double-Click fishing, so you don't accidentaly move when you try to fish. If you are "
.. "using OneKey fishing, \'Click-to-Move\' won't be changed."] = "Когда " .. colorGreen:WrapTextInColorCode("включено, ") 
.. colorBlu:WrapTextInColorCode("Angleur ") .. "временно отключит функцию " .. colorYello:WrapTextInColorCode("\'Движение по клику\' ") 
.. "в режиме " .. "\'Пробуждение\' " .. ", если вы используете " 
.. colorBlu:WrapTextInColorCode("двойной клик ") .. "для рыбалки,\n\nчтобы вы случайно не двигались при попытке рыбачить.\n\nЕсли вы "
.. "используете " .. colorBlu:WrapTextInColorCode("одну клавишу ") .. "для рыбалки, " .. colorYello:WrapTextInColorCode("\'Движение по клику\' ") .. "не изменится."

T["Cast the /sit emote when cast your fishing rod. Fish in comfort!"] = "Выполнить команду " .. colorYello:WrapTextInColorCode("/sit ") 
.. "при забросе удочки. Рыбачьте с комфортом!"
