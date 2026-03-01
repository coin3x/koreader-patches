local CreDocument = require("document/credocument")
local setupDefaultView = CreDocument.setupDefaultView

function CreDocument:setupDefaultView()
	setupDefaultView(self)
	--[[
		["cre_cjk_width_adjustment_table_override"] = {
			{ "", "" }, -- sc
			[2] = {
				-- horizontal
	            [1] = "8,0,8,8,8,8,8,8,8,8,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-6,0,-6,-6,-6,-6,-6,-6,-6,-6,-6,-6,4,0,-4,4,-6,4,4,4,4,4,-6,0,4,-4,-6,4,4,4,4,4,-4,-6,0,-6,-6,-6,-6,-6,-6,-6,-6,-6,-6,0,-6,-6,-6,-6,-6,-6,-6,-6,-6,-6,0,-6,-6,-6,-6,-6,-6,-6,-6,-6,-6,0,-6,-6,-6,-6,-6,-6,-6,-6,-6,8,0,8,8,8,8,8,8,8,8,8",
            	-- vertical
            	[2] = "8,0,8,8,8,8,8,8,8,8,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-6,0,-6,-6,-6,-6,-6,-6,-6,-6,-6,-6,4,0,-4,4,-6,4,4,4,4,4,-6,0,4,-4,-6,4,4,4,4,4,-4,8,0,8,8,8,8,8,8,8,8,8,8,0,8,8,8,8,8,8,8,8,8,-6,0,-6,-6,-6,-6,-6,-6,-6,-6,-6,-6,0,-6,-6,-6,-6,-6,-6,-6,-6,-6,8,0,8,8,8,8,8,8,8,8,8"
			}, -- tc
			{ "", "" }, -- ja
		},
	]]
	if G_reader_settings:has("cre_cjk_width_adjustment_table_override") then
		local override = G_reader_settings:readSetting("cre_cjk_width_adjustment_table_override")
		local cre = self:engineInit()
		for lang = 1, 3 do
			if override[lang] then
				if override[lang][1] then
					cre.setCJKWidthAdjustmentTableOverride(lang - 1, false, override[lang][1])
				end
				if override[lang][2] then
					cre.setCJKWidthAdjustmentTableOverride(lang - 1, true, override[lang][2])
				end
			end
		end
    end
end
