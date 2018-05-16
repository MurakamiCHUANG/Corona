--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:da82fb0d6b8b6fa39f5c6ed2f69831a3:81140d7253e66b543dcee1f0b545d627:e55c3466f34ae94df7c09248e5f5d300$
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
            -- n1
            x=2,
            y=2,
            width=262,
            height=157,

        },
        {
            -- n2
            x=266,
            y=2,
            width=262,
            height=157,

        },
        {
            -- n3
            x=530,
            y=2,
            width=262,
            height=160,

        },
        {
            -- n4
            x=2,
            y=164,
            width=262,
            height=156,

        },
        {
            -- n5
            x=2,
            y=164,
            width=262,
            height=156,

        },
        {
            -- n6
            x=266,
            y=164,
            width=262,
            height=160,

        },
        {
            -- n7
            x=530,
            y=164,
            width=262,
            height=155,

        },
        {
            -- n8
            x=2,
            y=326,
            width=262,
            height=151,

        },
    },
    
    sheetContentWidth = 794,
    sheetContentHeight = 479
}

SheetInfo.frameIndex =
{

    ["n1"] = 1,
    ["n2"] = 2,
    ["n3"] = 3,
    ["n4"] = 4,
    ["n5"] = 5,
    ["n6"] = 6,
    ["n7"] = 7,
    ["n8"] = 8,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
