--Translator: ZamestoTV
if (GAME_LOCALE or GetLocale()) ~= "ruRU" then
  return
end

local T = AngleurNicheOptions_Translate

local colorNicheOptions = CreateColor(1, 0.48, 0.96)
local colorUnderlight = CreateColor(0.9, 0.8, 0.5)
local colorYello = CreateColor(1.0, 0.82, 0.0)
local colorBlu = CreateColor(0.61, 0.85, 0.92)
local colorWhite = CreateColor(1, 1, 1)
local colorDarkBlu = CreateColor(0.35, 0.45, 0.92)
local colorGrae = CreateColor(0.85, 0.85, 0.85)
local colorGreen = CreateColor(0, 1, 0)

T["Angleur_NicheOptions Config"] = colorNicheOptions:WrapTextInColorCode("Настройки Angleur_NicheOptions")
T["Disable Click-to-Move"] = "Отключить движение по щелчку"
T["Sit While Fishing"] = "Садиться во время рыбалки"

T["When enabled, Angleur will temporarily turn off the \'Click-to-Move\' feature "
.. "while it's in \'Awake\' mode if you are using Double-Click fishing, so you don't accidentaly move when you try to fish. If you are "
.. "using OneKey fishing, \'Click-to-Move\' won't be changed."] = "Если " .. colorGreen:WrapTextInColorCode("включено, ") 
.. colorBlu:WrapTextInColorCode("Angleur ") .. "будет временно отключать функцию " .. colorYello:WrapTextInColorCode("\'Движение по щелчку\' ") 
.. ", пока " .. "он находится в " .. "\'активном\' " .. "режиме, если вы используете рыбалку по " 
.. colorBlu:WrapTextInColorCode("двойному клику ") .. ",\n\nчтобы вы случайно не сдвинулись с места при попытке забросить удочку.\n\nЕсли вы " 
.. "используете рыбалку " .. colorBlu:WrapTextInColorCode("OneKey ") .. ", то функция " .. colorYello:WrapTextInColorCode("\'Движения по щелчку\' ") .. "изменяться не будет."

T["Cast the /sit emote after your first cast. Fish in comfort!"] = "Использовать эмоцию  " .. colorYello:WrapTextInColorCode("/сесть ") 
.. "после первого заброса. Рыбачьте с комфортом!"


-- moreItems
T["More \'Extra Items\'"] = "Больше \'Дополнительных предметов\'"
T["When enabled, will increase Angleur's \'Extra Items\' slots from 3 to 6"] = "Если " .. colorGreen:WrapTextInColorCode("включено, ") .. "увеличит " 
.. colorBlu:WrapTextInColorCode("Angleur ") .. "слоты \'Дополнительных предметов\' с 3 до 6"

T["Angleur_NicheOptions Warning"] = "Предупреждение Angleur_NicheOptions"
T["You need to reload the UI for the changes to take effect."] = "Вам необходимо " .. colorYello:WrapTextInColorCode("перезагрузить интерфейс, ") .. "чтобы изменения\nвступили в силу."
T["Reload now?"] = "Перезагрузить сейчас?"
T["Reload"] = "Перезагрузить"


-- tuskarrSpear(for MoP)
T["Use The Tuskarr Spear"] = "Использовать Заостренное копье клыкарра (БЕТА)"
T["When enabled, Angleur will have you equip -> use -> unequip the Tuskarr Spear whenever it's off cooldown."] = "Если " .. colorGreen:WrapTextInColorCode("включено, ") .. "Angleur заставит вас экипировать -> использовать -> снять Заостренное копье клыкарра, как только завершится его перезарядка." 
.. colorGrae:WrapTextInColorCode("\n\n(В режиме БЕТА, пожалуйста, сообщайте о любых ошибках/странном поведении.)")
