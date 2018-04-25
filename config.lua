--
-- For more information on config.lua see the Project Configuration Guide at:
-- https://docs.coronalabs.com/guide/basics/configSettings
--

application =
{
	content =
	{
		width = 320,
		height = 480, 
		--scale = "letterbox",
		--把縮放模式改成zoomStretch
		scale = "zoomStretch",
		fps = 60,
		
		--啟用imageSuffix
		--這會讓模擬器自動抓取最適合硬體設備的解析度
		--不過圖片名稱必須＝圖片名＠nx
		imageSuffix =
		{
			    ["@2x"] = 2,
			    ["@4x"] = 4,
		},
		
	},
}
