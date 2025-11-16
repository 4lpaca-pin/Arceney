# Fisch Lua API
## Using API
```lua
repeat task.wait() until _G.ArceneyAPI
local ArceneyAPI = _G.ArceneyAPI;
```

## Safe Hook Function
```lua
ArceneyAPI:HookFunction(old , new)
```

## Get Current Config
```lua
ArceneyAPI:GetConfig()
```
### Return
```lua
{
    FarmingFunctions_IDE = ({
        Selected_Locations = "Moosewood";
        Saved_Locations = ({
            X = 0;
            Y = 0;
            Z = 0;

            Rotation_Pitch = 0;
            Rotation_Yaw = 0;
            Rotation_Roll = 0;
        });
        Farm_Methods = "Selected Location";
    });

    InputMode = "Internal",
    FreezeCharacter = false,

    ZoneCasting = ({ 
        Toggles = false; 
        Zone_Selected = {"Whale Shark"};
    });

    AutoFishingLocation = false;
    AutoCast = false;
    AutoShake = false; 
    AutoReel = false; 
    AutoPerfectCatch = false;

    Players = ({
        WalkSpeed = 16;
        Toggles = false;
    });

    Kncrypt_InfJump = false;

    LightingFucked = ({
        Brightness = 0.3;
        Toggles = false;
    });

    InstantReelSpeed = 0.62;
    InstantReelTypical = "stable";
    InstantReel = false;
    EquipInstantReel = false;
    AutoFixInstantReel = false;

    AutoBalanceNuker = false;
    FastBobber = false; 
    FishUnderWater = false;
    AutoSellAll = false;

    LockedEnchantTarget = "Blessed Song";
    AutoEnchants = false;

    OverWeight = 0;
    LockedMutation = {"Mythical"};
    
    WhenOverWeight = false;
    WhenLockedMutation = false;

    WhenShiny = false;
    WhenSparkling = false;

    AutoAppraiser = false;

    Drills_Type = "Lava Crystals";
    Enabled_AutoDrills = false; 

    AutoOpenCrates = false;
    StreamerMode = false;
    LavaRemoval = false;
    AutoMeteorItems = false; 

    WalkOWATER = false;
    NoFog = false;
    AutoRejoin = true;
    HiddenIdentify = false;

    Brightness = ({ 
        Location = false;
        Ocean =  false;
    });
    Character_Resources = ({
        Oxygen = false; 
        Oxygen_Peak = false; 
        Temperature = false; 
        Temperature_Peak = false;
    });
    AutoEquipBaits = ({
        Selected = "";
        Toggles = false;
    });

    DeleteParticleEmitter = false;
    DeleteCaughtedFishModel = false;

    BuyAuroraIfCoinsOver = false;

    Rendering = ({ 
        _3rdRendering = false;
    })
}
```

## Get Interface
```lua
_G:GetInterface()
```

## Custom Language
```lua
ArceneyAPI:SetCustomLanguage({table})
```

### Example
```lua
ArceneyAPI:SetCustomLanguage({
    FarmLocation = "ตำแหน่งการฟาร์ม",
    FarmMethod = "ตำแหน่งการฟาร์มที่ใช้",
    FarmEnabledLocation = "ล็อคตำแหน่ง",
    LockCharacter = "ล็อคตัว (ขยับไม่ได้)",
    InputMode = "โหมดการกด",
    CastAssist = "ตกปลาออโต้",
    ShakeAssist = "กดปุ่มออโต้",
    ReelAssist = "Reel ออโต้ (กูไม่รุ้ว่าจะเขียนยังไง)",
    AlwayPerfectCatch = "จับปลาแบบ Perfect ตลอด",
    AutoBalanceNuke = "ออโต้คุม Nuke",
    BobberBoost = "ล็อคทุ่นตกปลา",
    UnderwaterFishing = "ตกปลาใต้น้ำ",
    AutoSell = "ขายออโต้",
    QuickSpeed = "ความเร็ว (Instant Reel)",
    QuickType = "รูปแบบ Instant Reel",
    QuickReel = "Instant Reel (กูไม่รุ้ว่าจะเขียนยังไง)",
    QuickReelEquip = "Instant Reel Equip",
    ZoneEnabled = "ตกปลาในโซนอีเว้นท์",
    zonelocation = "โซนอีเว้นท์",
    WalkOnWater = "เดินบนน้ำ",
    NoFog = "ลบหมอก",
    AutoRJ = "ออโต้รีเกม",
    Protection = "ปิดชื่อ",
    WorldBrightness = "ความสว่าง",
    OceanBrightness = "ความสว่างในทะเล",
    OxygenRemoval = "ออกซิเจนไม่จำกัด",
    Oxygenremovals = "ออกซิเจนไม่จำกัด (สักอย่าง)",
    TemperRemoval = "ล็อคอุณหภูมิ",
    TemperRemovalS = "ล็อคอุณหภูมิ (สักอย่าง)",
    CoinOver = "มากกว่า (จำนวนเงิน)",
    BuyAurora = "ซื้อ Aurora ถ้าเงินครบ",
    EnableEnchant = "ออโต้เอนชานท์",
    EnahchantDD = "Mutations (สักอย่าง)",
    AutoAppraiserEna = "ออโต้เอนชานท์ (ปลา)",
    Mutation = "Mutation ของปลา",
    AppraiserWeigth = "น้ำหนักที่ต้องการ",
    StopIsOvERwEIGTH = "หยุดถ้ามีน้ำหนักเกิน",
    StopIsMatchLocked = "หยุดถ้า Mutation ตรงกัน",
    StopIsSparkling = "หยุดถ้าปลาเป็น Sparkling",
    StopWhenShiny = "หยุดถ้าปลาเป็น Shiny",
    DrillEnabled = "เจาะออโต้ (สักอย่าง)",
    DrillObjects = "ของที่จะเจาะ",
    BaitEnabled = "ออโต้ใช้เหยื่อ",
    Baits = "เหยื่อที่จะใช้",
    AutoOpenCrate = "เปิด Crate ออโต้",
    StreamerMode = "ปิดชื่อ (ทั้งเกม)",
    LavaRemoval = "ลบลาวา",
    AutoMeteorItems = "ออโต้ Meteor Items (สักอย่างกูไม่รุ้)",
    player_speed = "ความเร็วในการเดิน",
    EnableWalkSpeed = "เปิดใช้ ความเร็วในการเดิน",
    InfJump = "กระโดดกลางอากาศ",
    CaughtedFishModel = "ลบโมเดลปลา",
    ParticleEmitier = "ลบ Effect (สักอย่าง)",
    BrightnessValue = "ความสว่าง",
    SetBrightness = "ใช้ความสว่างตัวนี้",
    ['3drendering'] = "จอขาว",
});
```
