--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:a915a47b336ac78ae77e208a0660ff14:81140d7253e66b543dcee1f0b545d627:021b39c5aa5fe07995ddacd17f829d10$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- saturn1
            x=530,
            y=2,
            width=262,
            height=157,

        },
        {
            -- saturn2
            x=794,
            y=2,
            width=262,
            height=157,

        },
        {
            -- saturn3
            x=2,
            y=2,
            width=262,
            height=160,

        },
        {
            -- saturn4
            x=1058,
            y=2,
            width=262,
            height=156,

        },
        {
            -- saturn5
            x=1058,
            y=2,
            width=262,
            height=156,

        },
        {
            -- saturn6
            x=266,
            y=2,
            width=262,
            height=160,

        },
        {
            -- saturn7
            x=1322,
            y=2,
            width=262,
            height=155,

        },
        {
            -- saturn8
            x=1586,
            y=2,
            width=262,
            height=151,

        },
    },
    
    sheetContentWidth = 1850,
    sheetContentHeight = 164
}

SheetInfo.frameIndex =
{

    ["saturn1"] = 1,
    ["saturn2"] = 2,
    ["saturn3"] = 3,
    ["saturn4"] = 4,
    ["saturn5"] = 5,
    ["saturn6"] = 6,
    ["saturn7"] = 7,
    ["saturn8"] = 8,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
