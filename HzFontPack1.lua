
--[[
Name: HzFontPack1
Author: Hizuro (Der Mithrilorden|EU)
]]

--[[
Known bugs:
 - Interface-Addons content display after second choose. Solving problem...
]]

HzFontPack1DB = {}
local addon, ns = ...
local panel = nil
local locale = GetLocale()
local SOL, SML = LibStub("LibSimpleOptions-1.0-be_mod"), LibStub("LibSharedMedia-3.0")
local filepath = "Interface\\Addons\\"..addon.."\\fonts\\"
local fonts = {
	["7days"]				= "7days.ttf",
	["Agency FB"]			= "Agency_FB.ttf",
	["Alcohole"]			= "Alcohole.ttf",
	["Antartic"]			= "ANTARG__.TTF",
	["Architext"]			= "architxt.ttf",
	["AtomicSushi"]			= "AtomicSushi.ttf",
	["Avocado"]				= "avocado_.ttf",
	["BTSE + PS2"]			= "btseps2.TTF",
	["Brush Script MT"]		= "BRUSHSCI.TTF",
	["Californian"]			= "CALIFR.TTF",
	["Chiller"]				= "CHILLER.TTF",
	["Comic Script Shaded"]	= "SF Comic Script Shaded.ttf",
	["Comic Script"]		= "SF Comic Script.ttf",
	["CreepyGirl"]			= "CREERG__.TTF",
	["Dali"]				= "dali____.ttf",
	["Dark Horse"]			= "Darkh4.ttf",
	["DragonFly"]			= "dragonfly.ttf",
	["Dreamerone"]			= "dfdrone.ttf",
	["Expressway"]			= "Expressway_Free.ttf",
	["Facelift"]			= "facerg__.ttf",
	["Fette Fraktur"]		= "ff______.ttf",
	["Gizmo"]				= "gizmo___.ttf",
	["Gushing meadow"]		= "sf gushing meadow.ttf",
	["Headhunter regular"]	= "he______.ttf",
	["Japan"]				= "japan.ttf",
	["Klingondagger"]		= "klingondagger.ttf",
	["Liquidcrystal"]		= "liquidn.ttf",
	["Loki cola"]			= "lokicola.ttf",
	["Lucida Console"]		= "lucon.ttf",
	["Lucida Sans"]			= "lsans.ttf",
	["Neurochrome"]			= "neurochr.ttf",
	["New brilliant"]		= "newbrill.ttf",
	["Old english text"]	= "oldengl.ttf",
	["Sony Sketch"]			= "Sony_Sketch_EF.ttf",
	["Telegraphic"]			= "sf telegraphic.ttf",
	["Typographerfraktur"]	= "typographerfraktur-medium.ttf",
	["Visitor1"]			= "visitor1.ttf",
	["Visitor2"]			= "visitor2.ttf",
}

local L = setmetatable({}, {
	__index = function(t, k)
		local v=tostring(k)
		rawset(t, k, v)
		return v
	end
})

if locale=="deDE" then
	L["Thank you for choosing this fontpacks.\nThis frame provide the option to disable fonts from this pack."] = "Danke, dass Sie sich für dieses Paket an Zeichensätzen entschieden haben.\nDieses Fenster bietet Ihnen die Möglichkeit Zeichensätze dieses Pakets zu deaktivieren."
	L["Enable/Disable %s"] = "Aktiviere/Deaktiviere %s"
	L["Select all"] = "Alle"
	L["Select none"] = "Keinen"
	L["Reload UI"] = "UI neuladen"
--	L["-"] = ""
--	L["-"] = ""
--	L["-"] = ""
end

-- -------------------------------------------------- --
-- Function to Sort a table by the keys               --
-- Sort function fom http://www.lua.org/pil/19.3.html --
-- -------------------------------------------------- --
local function pairsByKeys(t, f)
	local a = {}
	for n in pairs(t) do
		table.insert(a, n)
	end
	table.sort(a, f)
	local i = 0      -- iterator variable
	local iter = function ()   -- iterator function
		i = i + 1
		if a[i] == nil then
			return nil
		else
			return a[i], t[a[i]]
		end
	end
	return iter
end

local function OptionPanel(self)
	local panel = self
	local title, subText = self:MakeTitleTextAndSubText(addon,L["Thank you for choosing this fontpacks.\nThis frame provide the option to disable fonts from this pack."])

	local scroll = CreateFrame("ScrollFrame", panel:GetName().."_Scroll", self, "UIPanelScrollFrameTemplate")
	local child = CreateFrame("Frame", panel:GetName().."_ScrollChild", scroll)
	scroll:SetFrameLevel(scroll:GetFrameLevel() + 1)
	scroll:SetScrollChild(child)
	child:SetWidth(1) child:SetHeight(1)

	local bg = CreateFrame("Frame", nil, self)
	bg:SetPoint("TOPLEFT",scroll,"TOPLEFT",-5,3)
	bg:SetPoint("BOTTOMRIGHT",scroll,"BOTTOMRIGHT",25,-3)
	bg:SetBackdrop({ bgFile=[[Interface\COMMON\Common-Input-Border-M]], tile=false })

	scroll:ClearAllPoints()
	scroll:SetPoint("TOPLEFT",panel,"TOPLEFT",10,-80)
	scroll:SetPoint("BOTTOMRIGHT",panel,"BOTTOMRIGHT",-29,60)

	child.controls = {}
	for k, v in pairs(SOL.panelMeta) do
		child[k] = v
	end

	local entry,last,count,row = {},10,0,"odd"
	for fontName, fontFile in pairsByKeys(fonts) do
		entry[count] = child:MakeToggle(
			'name', fontName,
			'description', string.format(L["Enable/Disable %s"],fontName),
			'default', true,
			'getFunc', function() return HzFontPack1DB[fontName] ~= false end,
			'setFunc', function(value) HzFontPack1DB[fontName] = value end
		)
		entry[count]:SetParent(child)
		entry[count]:SetPoint("TOPLEFT", entry[count-1] or child, "BOTTOMLEFT", count~=0 and 0 or 10, -6)
		entry[count].example = entry[count]:CreateFontString(nil,"ARTWORK")
		entry[count].example:SetFont(filepath..fontFile,15)
		entry[count].example:SetText("a b c A B C 0 1 2 3")
		entry[count].example:SetJustifyV("CENTER")
		entry[count].example:SetPoint("TOPLEFT",entry[count],"TOPLEFT",200,-7)

		count = count + 1
	end

	local footSpacer = CreateFrame("Frame",nil,entry[count-1])
	footSpacer:SetWidth(1)
	footSpacer:SetHeight(6)
	footSpacer:SetPoint("TOPLEFT",entry[count-1], "BOTTOMLEFT",0,-6)

	local btSelAll = self:MakeButton(
		'name', L["Select all"],
		'description', '',
		'func', function()
			for fontName, Value in pairs(HzFontPack1DB) do
				HzFontPack1DB[fontName] = true
			end
			child:Refresh()
		end
	)
	local btSelNone = self:MakeButton(
		'name', L["Select none"],
		'description', '',
		'func', function()
			for fontName, Value in pairs(HzFontPack1DB) do
				HzFontPack1DB[fontName] = false
			end
			child:Refresh()
		end
	)
	local btReload = self:MakeButton(
		'name', L["Reload UI"],
		'description', '',
		'func', function() ReloadUI() end
	)

	btSelAll:SetPoint("TOPLEFT",scroll,"BOTTOMLEFT",0,-10)
	btSelNone:SetPoint("TOPLEFT",btSelAll,"TOPRIGHT",10,0)
	btReload:SetPoint("TOPRIGHT",scroll,"BOTTOMRIGHT",0,-10)

	local footer = panel:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
	footer:SetText("|cff00aaffAuthor: Hizuro (Der Mithrilorden|EU)|r")
	footer:SetJustifyH("CENTER")
	footer:SetPoint("BOTTOMRIGHT",-10,10)
end
local panel = SOL.AddOptionsPanel(addon, OptionPanel)
SOL.AddSlashCommand(addon,"/hz","/hzfp","/hzfontpack")


local f = CreateFrame("frame")
f:SetScript("OnEvent",function(self, event, name)
	if event=="ADDON_LOADED" then
		if name ~= addon then return end

		print("|cffff4444"..addon.."|r: |cff44ff44Addon loaded...|r")

		for fontName, fontFile in pairsByKeys(fonts) do
			if type(fontName) == "string" and fontName ~= "" and type(fontFile) == "string" and fontFile ~= "" and HzFontPack1DB[fontName] ~= false then
				SML:Register("font", fontName, filepath..fontFile, 255)
			end
		end

		panel:Refresh()

		self:UnregisterEvent("ADDON_LOADED")
	elseif event=="PLAYER_ENTERING_WORLD" then
		--[[
		> Push MikScrollingBattleText to reinitialize LibSharedMedia support
		MSBT looking too early at SharedMedia files for
		addons that add files depending on there own SavedVariables.
		]]
		--if MikSBT~=nil then
		--	MikSBT.Media.OnVariablesInitialized()
		--end
	end
end)

f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_ENTERING_WORLD")