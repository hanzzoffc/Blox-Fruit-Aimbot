-- ================================================================
--                      МОДУЛЬ GUI (GUI.lua)
-- ================================================================

local GUI = {}
GUI.__index = GUI

function GUI:Initialize(core, utils)
    local self = setmetatable({}, GUI)
    self.Core = core
    self.Utils = utils
    
    self:LoadLibrary()
    self:CreateInterface()
    self:SetupEventHandlers()
    
    print("✅ GUI инициализирован")
    return self
end

function GUI:LoadLibrary()
    -- Загрузка Rayfield
    local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
    
    -- Инициализация Rayfield
    self.Library = Rayfield:CreateWindow({
        Name = 'Blox Fruits AimBot Hub',
        LoadingTitle = "Blox Fruits AimBot Hub",
        LoadingSubtitle = "by YourName",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "BloxFruitsAimBot",
            FileName = "Config"
        },
        Discord = {
            Enabled = false,
            Invite = "noinvitelink",
            RememberJoins = true
        },
        KeySystem = false,
    })
end

function GUI:CreateInterface()
    -- === MAIN TAB ===
    self.MainTab = self.Library:CreateTab("Main", 4483362458)
    
    -- === AIM GROUP ===
    local AimGroup = self.MainTab:CreateSection("Aim Bot")
    
    self.Library:CreateToggle({
        Name = "Enable Aim Bot",
        CurrentValue = self.Core.Config.AimBot.Enabled,
        Flag = "AimBotEnabled",
        Callback = function(Value)
            self.Core.Config.AimBot.Enabled = Value
        end,
    })
    
    self.Library:CreateDropdown({
        Name = "Aim Bot Method",
        Options = {"Ray", "FireServer"},
        CurrentOption = self.Core.Config.AimBot.Method,
        Flag = "AimBotMethod",
        Callback = function(Option)
            self.Core.Config.AimBot.Method = Option
        end,
    })
    
    self.Library:CreateToggle({
        Name = "Show FOV Circle",
        CurrentValue = self.Core.Config.AimBot.ShowFOV,
        Flag = "ShowFOV",
        Callback = function(Value)
            self.Core.Config.AimBot.ShowFOV = Value
        end,
    })
    
    self.Library:CreateToggle({
        Name = "Target NPCs",
        CurrentValue = self.Core.Config.AimBot.CheckNPC,
        Flag = "CheckNPC",
        Callback = function(Value)
            self.Core.Config.AimBot.CheckNPC = Value
        end,
    })
    
    self.Library:CreateToggle({
        Name = "Gun Aimbot",
        CurrentValue = self.Core.Config.AimBot.Gun,
        Flag = "Gun",
        Callback = function(Value)
            self.Core.Config.AimBot.Gun = Value
        end,
    })
    
    self.Library:CreateSlider({
        Name = "FOV Size",
        Range = {50, 700},
        Increment = 1,
        Suffix = "px",
        CurrentValue = self.Core.Config.AimBot.FOVRadius,
        Flag = "FOVRadius",
        Callback = function(Value)
            self.Core.Config.AimBot.FOVRadius = Value
        end,
    })
    
    -- === SORU GROUP ===
    local SoruGroup = self.MainTab:CreateSection("Soru Enhancement")
    
    self.Library:CreateToggle({
        Name = "Enhanced Soru",
        CurrentValue = self.Core.Config.Soru.Enabled,
        Flag = "SoruEnabled",
        Callback = function(Value)
            self.Core.Config.Soru.Enabled = Value
        end,
    })
    
    -- === ESP GROUP ===
    local ESPGroup = self.MainTab:CreateSection("ESP System")
    
    self.Library:CreateToggle({
        Name = "Enable ESP",
        CurrentValue = self.Core.Config.ESP.Enabled,
        Flag = "ESPEnabled",
        Callback = function(Value)
            self.Core.Config.ESP.Enabled = Value
        end,
    })
    
    self.Library:CreateToggle({
        Name = "Show Boxes",
        CurrentValue = self.Core.Config.ESP.ShowBoxes,
        Flag = "ShowBoxes",
        Callback = function(Value)
            self.Core.Config.ESP.ShowBoxes = Value
        end,
    })
    
    self.Library:CreateToggle({
        Name = "Show Names",
        CurrentValue = self.Core.Config.ESP.ShowName,
        Flag = "ShowNames",
        Callback = function(Value)
            self.Core.Config.ESP.ShowName = Value
        end,
    })
    
    self.Library:CreateToggle({
        Name = "Show Health",
        CurrentValue = self.Core.Config.ESP.ShowHealth,
        Flag = "ShowHealth",
        Callback = function(Value)
            self.Core.Config.ESP.ShowHealth = Value
        end,
    })
    
    self.Library:CreateToggle({
        Name = "Show Distance",
        CurrentValue = self.Core.Config.ESP.ShowDistance,
        Flag = "ShowDistance",
        Callback = function(Value)
            self.Core.Config.ESP.ShowDistance = Value
        end,
    })
    
    -- === SERVER TOOLS ===
    local ServerGroup = self.MainTab:CreateSection("Server Tools")
    
    self.Library:CreateButton({
        Name = "Copy Job ID",
        Callback = function()
            if setclipboard then
                setclipboard(game.JobId)
                self.Library:Notify({
                    Title = "Success",
                    Content = "Job ID copied to clipboard!",
                    Duration = 3,
                    Image = 4483362458,
                })
            else
                self.Library:Notify({
                    Title = "Error",
                    Content = "Clipboard not supported",
                    Duration = 3,
                    Image = 4483362458,
                })
            end
        end,
    })
    
    self.JobIdInput = self.Library:CreateInput({
        Name = "Job ID",
        PlaceholderText = "Paste Job ID here...",
        RemoveTextAfterFocusLost = false,
        Callback = function(Text)
            self.JobIdValue = Text
        end,
    })
    
    self.Library:CreateButton({
        Name = "Join by Job ID",
        Callback = function()
            if self.JobIdValue and self.JobIdValue ~= '' then
                pcall(function()
                    self.Core.Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, self.JobIdValue, self.Core.LocalPlayer)
                end)
            end
        end,
    })
    
    self.Library:CreateButton({
        Name = "Rejoin Server",
        Callback = function()
            pcall(function()
                self.Core.Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, self.Core.LocalPlayer)
            end)
        end,
    })
    
    -- === SETTINGS GROUP ===
    local SettingsGroup = self.MainTab:CreateSection("Settings")
    
    self.Library:CreateToggle({
        Name = "Aim At Cursor",
        CurrentValue = self.Core.Config.AimBot.AimAtCursor,
        Flag = "AimAtCursor",
        Callback = function(Value)
            self.Core.Config.AimBot.AimAtCursor = Value
        end,
    })
    
    self.Library:CreateToggle({
        Name = "Prediction",
        CurrentValue = self.Core.Config.AimBot.Prediction.Enabled,
        Flag = "PredictionEnabled",
        Callback = function(Value)
            self.Core.Config.AimBot.Prediction.Enabled = Value
        end,
    })
    
    self.Library:CreateSlider({
        Name = "Prediction Strength",
        Range = {0, 0.5},
        Increment = 0.001,
        Suffix = "",
        CurrentValue = self.Core.Config.AimBot.Prediction.Strength,
        Flag = "PredictionStrength",
        Callback = function(Value)
            self.Core.Config.AimBot.Prediction.Strength = Value
        end,
    })
    
    self.Library:CreateSlider({
        Name = "Max Distance",
        Range = {500, 10000},
        Increment = 50,
        Suffix = "studs",
        CurrentValue = self.Core.Config.AimBot.Filtering.MaxDistance,
        Flag = "MaxDistance",
        Callback = function(Value)
            self.Core.Config.AimBot.Filtering.MaxDistance = Value
        end,
    })
    
    self.Library:CreateButton({
        Name = "Destroy GUI",
        Callback = function()
            Rayfield:Destroy()
        end,
    })
end

function GUI:SetupEventHandlers()
    -- Все обработчики событий уже настроены через колбэки в создании элементов
    -- Дополнительная логика может быть добавлена здесь при необходимости
end

function GUI:GetToggleValue(name)
    -- Rayfield хранит значения в конфигурации, но для совместимости
    -- мы будем использовать значения из конфига Core
    if name == "AimBotEnabled" then return self.Core.Config.AimBot.Enabled end
    if name == "ShowFOV" then return self.Core.Config.AimBot.ShowFOV end
    if name == "CheckNPC" then return self.Core.Config.AimBot.CheckNPC end
    if name == "Gun" then return self.Core.Config.AimBot.Gun end
    if name == "SoruEnabled" then return self.Core.Config.Soru.Enabled end
    if name == "ESPEnabled" then return self.Core.Config.ESP.Enabled end
    if name == "ShowBoxes" then return self.Core.Config.ESP.ShowBoxes end
    if name == "ShowNames" then return self.Core.Config.ESP.ShowName end
    if name == "ShowHealth" then return self.Core.Config.ESP.ShowHealth end
    if name == "ShowDistance" then return self.Core.Config.ESP.ShowDistance end
    if name == "AimAtCursor" then return self.Core.Config.AimBot.AimAtCursor end
    if name == "PredictionEnabled" then return self.Core.Config.AimBot.Prediction.Enabled end
    return false
end

function GUI:GetOptionValue(name)
    -- Rayfield хранит значения в конфигурации, но для совместимости
    -- мы будем использовать значения из конфига Core
    if name == "AimBotMethod" then return self.Core.Config.AimBot.Method end
    if name == "FOVRadius" then return self.Core.Config.AimBot.FOVRadius end
    if name == "PredictionStrength" then return self.Core.Config.AimBot.Prediction.Strength end
    if name == "MaxDistance" then return self.Core.Config.AimBot.Filtering.MaxDistance end
    return nil
end

return GUI
