
local xml = require( "xml" ).newParser()

local SpecialBitmapFont = {}


function SpecialBitmapFont.new(filename)
	local instance = {}
	local metricsFilename = string.sub(filename,1,-4)
	--print(metricsFilename)
	local fontMetrics = xml:loadFile( metricsFilename.."xml")

	function instance.buildFrames()
		local frames = {}
		local character = {}

		for i=1,#fontMetrics.child do

			character[i] = fontMetrics.child[i]
		end
		for i=1,#character do
			local optionsForFrame = {}
			optionsForFrame.x  =character[i].child[1].value
			optionsForFrame.y  = character[i].child[2].value
			optionsForFrame.width   = character[i].child[3].value
			optionsForFrame.height  = character[i].child[4].value
			table.insert(frames, optionsForFrame)
		end
		return frames
	end
	local options =
	{
		frames = instance.buildFrames( )
	}
	-- Create a sprite sheet
	instance.spriteSheet = graphics.newImageSheet( filename, options )

	

	function instance:getLetter(asciiCode)

		local frameNum = asciiCode - 31
		--print(frameNum)
		return display.newImage(self.spriteSheet, frameNum)
	end

	function instance:newBitmapString(x,y,theString)
		-- An object we are creating that contains all the images
		-- This object can make visible/invisible and remove its objects
		local imagesForString = {}
		local cursorPosition = x
		local rightOffset = 6
		local myString = theString:upper()
		local myGroup = display.newGroup()
		for i=1, #myString do
			local letter = myString:sub(i,i)
			local ascii = string.byte(letter)
			local letterImage = self:getLetter(ascii)
			--print("letterImage.contentWidth ="..letterImage.contentWidth)
			letterImage.anchorX=0
			letterImage.anchorY=0.5
			letterImage.x = cursorPosition
			--print("letterImage.x ="..letterImage.x)
			letterImage.y = y

			myGroup:insert( letterImage )
			
			cursorPosition = cursorPosition + (letterImage.contentWidth - rightOffset)
		end
		myGroup.x=-myGroup.contentWidth/2
		--print(myGroup.contentWidth.." "..myGroup.x)
		--table.insert(imagesForString, myGroup)
		function imagesForString:isVisible(isIt)
			for i=1, #self do
				self[i].isVisible = isIt   
			end
		end

		function myGroup:removeSelf( )
			for i=1, #self do
				self[i]:removeSelf()
			end
		end

		return myGroup
	end
	return instance
end


return SpecialBitmapFont