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
            -- StarLight1
            x=530,
            y=2,
            width=152,
            height=100,

        },
        {
            -- StarLight2
            x=794,
            y=2,
            width=152,
            height=100,

        },
        {
            -- StarLight3
            x=2,
            y=2,
            width=152,
            height=100,

        },
        {
            -- StarLight4
            x=1058,
            y=2,
            width=152,
            height=100,

        },
        {
            -- StarLight5
            x=1058,
            y=2,
            width=152,
            height=100,

        },
        {
            -- StarLight6
            x=266,
            y=2,
            width=152,
            height=100,

        },
        {
            -- StarLight7
            x=1322,
            y=2,
            width=152,
            height=100,

        },
        {
            -- StarLight8
            x=1586,
            y=2,
            width=152,
            height=100,

        },
    },
    
    sheetContentWidth = 1850,
    sheetContentHeight = 100
}

SheetInfo.frameIndex =
{

    ["StarLight1"] = 1,
    ["StarLight2"] = 2,
    ["StarLight3"] = 3,
    ["StarLight4"] = 4,
    ["StarLight5"] = 5,
    ["StarLight6"] = 6,
    ["StarLight7"] = 7,
    ["StarLight8"] = 8,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
