
--[[
Name: HzFontPack1
Author: Hizuro (Der Mithrilorden|EU)
]]

--[[
Known bugs:
 - Interface-Addons content display after second choose. Solving problem...
]]

HzFontPack1DB = {}
local addon,ns,panel = ...;
ns.debugMode = "@project-version@"=="@".."project-version".."@";
LibStub("HizurosSharedTools").RegisterPrint(ns,addon,"HzFP");

--local SOL = LibStub("LibSimpleOptions-1.0-be_mod");
local SML = LibStub("LibSharedMedia-3.0");
local AC = LibStub("AceConfig-3.0");
local ACD = LibStub("AceConfigDialog-3.0");
local filepath = "Interface\\Addons\\"..addon.."\\fonts\\"
local fonts = {
	{"7days",				"7days.ttf",					1},
	{"Agency FB",			"Agency_FB.ttf",				2},
	{"Alcohole",			"Alcohole.ttf",					3},
	{"Antartic",			"ANTARG__.TTF",					4},
	{"Architext",			"architxt.ttf",					5},
	{"AtomicSushi",			"AtomicSushi.ttf",				6},
	{"Avocado",				"avocado_.ttf",					7},
	{"BTSE + PS2",			"btseps2.TTF",					8},
	{"Brush Script MT",		"BRUSHSCI.TTF",					9},
	{"Californian",			"CALIFR.TTF",					10},
	{"Chiller",				"CHILLER.TTF",					11},
	{"Comic Script Shaded",	"SF Comic Script Shaded.ttf",	12},
	{"Comic Script",		"SF Comic Script.ttf",			13},
	{"CreepyGirl",			"CREERG__.TTF",					14},
	{"Dali",				"dali____.ttf",					15},
	{"Dark Horse",			"Darkh4.ttf",					16},
	{"DragonFly",			"dragonfly.ttf",				17},
	{"Dreamerone",			"dfdrone.ttf",					18},
	{"Expressway",			"Expressway_Free.ttf",			19},
	{"Facelift",			"facerg__.ttf",					20},
	{"Fette Fraktur",		"ff______.ttf",					21},
	{"Gizmo",				"gizmo___.ttf",					22},
	{"Gushing meadow",		"sf gushing meadow.ttf",		23},
	{"Headhunter regular",	"he______.ttf",					24},
	{"Japan",				"japan.ttf",					25},
	{"Klingondagger",		"klingondagger.ttf",			26},
	{"Liquidcrystal",		"liquidn.ttf",					27},
	{"Loki cola",			"lokicola.ttf",					28},
	{"Lucida Console",		"lucon.ttf",					29},
	{"Lucida Sans",			"lsans.ttf",					30},
	{"Neurochrome",			"neurochr.ttf",					31},
	{"New brilliant",		"newbrill.ttf",					32},
	{"Old english text",	"oldengl.ttf",					33},
	{"Sony Sketch",			"Sony_Sketch_EF.ttf",			34},
	{"Telegraphic",			"sf telegraphic.ttf",			35},
	{"Typographerfraktur",	"typographerfraktur-medium.ttf",36},
	{"Visitor1",			"visitor1.ttf",					37},
	{"Visitor2",			"visitor2.ttf",					38},
}

local L = setmetatable({}, {
	__index = function(t, k)
		local v=tostring(k);
		rawset(t, k, v);
		return v;
	end
})

--@do-not-package@
L["Thanks"] = "Thank you for choosing this fontpacks.\nThis frame provide the option to disable fonts from this pack.";
L["AddOnLoaded"] = "AddOn loaded..."
L["AddOnLoadedShow"] = "Show 'AddOn loaded...' message on login"
L["EnableDisable"] = "Enable/Disable %s"
L["ReloadUI"] = "Reload UI"
L["Fonts"] = "Fonts"
--@end-do-not-package@
--@localization(locale="enUS", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@

if LOCALE_deDE then
--@do-not-package@
L["Thanks"] = "Danke, dass Sie sich für dieses Paket an Zeichensätzen entschieden haben.\nDieses Fenster bietet Ihnen die Möglichkeit Zeichensätze dieses Pakets zu deaktivieren."
L["AddOnLoaded"] = "AddOn geladen..."
L["AddOnLoadedShow"] = "Zeige 'AddOn geladen...' Nachricht beim Login"
L["EnableDisable"] = "Aktiviere/Deaktiviere %s"
L["ReloadUI"] = "UI neuladen"
L["Fonts"] = "Zeichensätze"
--@end-do-not-package@
--@localization(locale="deDE", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
end

if LOCALE_esES then
--@localization(locale="esES", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
end

if LOCALE_esMX then
--@localization(locale="esMX", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
end

if LOCALE_frFR then
--@localization(locale="frFR", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
end

if LOCALE_itIT then
--@localization(locale="itIT", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
end

if LOCALE_koKR then
--@localization(locale="koKR", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
end

if LOCALE_ptBR or LOCALE_ptPT then
--@localization(locale="ptBR", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
end

if LOCALE_ruRU then
--@localization(locale="ruRU", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
end

if LOCALE_zhCN then
--@localization(locale="zhCN", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
end

if LOCALE_zhTW then
--@localization(locale="zhTW", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
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

local function getSetOption(info,value)
	local key=info[#info];
	if value~=nil then
		HzFontPack1DB[key]=value;
	end
	return HzFontPack1DB[key];
end

local function enableDisableAllFonts(info)
	local state = info[#info]=="enable_all";
	for i=1,#fonts do
		HzFontPack1DB[fonts[i][1]] = state;
	end
end

local options = {
	type = "group",
	name = addon,
	childGroups="tab",
	args = {
		header2 = { type="description", order=1, name=L.Thanks },
		showAddOnLoaded = { type="toggle", order=2, width="double", name=L.AddOnLoadedShow, get=getSetOption, set=getSetOption },
		reload = { type="execute", order=3, name=RELOADUI, func=function() ReloadUI(); end },
		fonts_label = { type="header", order=4, name=L["Fonts"] },
		enable = { type="description", order=5, fontSize="medium", width="half", name=ENABLE..HEADER_COLON },
		enable_all  = { type="execute", order=6, width="half", name=ALL, func=enableDisableAllFonts },
		enable_none = { type="execute", order=7, width="half", name=NONE, func=enableDisableAllFonts },
		fonts = { type="group", order=8, name=L.Fonts, get=getSetOption,set=getSetOption, args={} }
	}
}

local texHeight=26/1024;
local function addFontToOptions(i)
	options.args.fonts.args["font"..i] = {
		type="group", order=i, inline=true, name="",
		args={
			[fonts[i][1]] = { type="toggle", order=1, name=fonts[i][1], desc=L.EnableDisable:format(fonts[i][1]) },
			image = {
				type="description", order=2, name="",
				image="Interface\\Addons\\"..addon.."\\font_examples",
				imageCoords={0,1,(fonts[i][3]-1)*texHeight,fonts[i][3]*texHeight},
				imageWidth=512, imageHeight=26
			}
		}
	}
end

local f = CreateFrame("frame");

f:SetScript("OnEvent",function(self, event, name)
	if event=="ADDON_LOADED" and name==addon then

		if HzFontPack1DB==nil then
			HzFontPack1DB = {};
		end

		if HzFontPack1DB.showAddOnLoaded==nil then
			HzFontPack1DB.showAddOnLoaded=true;
		end

		for i=1, #fonts do
			if HzFontPack1DB[fonts[i][1]]==nil then
				HzFontPack1DB[fonts[i][1]] = true;
			end
			if HzFontPack1DB[fonts[i][1]] then
				SML:Register("font", fonts[i][1], filepath .. fonts[i][2], 128);
			end
			addFontToOptions(i);
		end

		if HzFontPack1DB.showAddOnLoaded or IsShiftKeyDown() then
			ns:print(L.AddOnLoaded);
		end

		AC:RegisterOptionsTable(addon, options);
		local opts = ACD:AddToBlizOptions(addon);
		LibStub("HizurosSharedTools").BlizzOptions_ExpandOnShow(opts);
		LibStub("HizurosSharedTools").AddCredit(addon);

		self:UnregisterEvent("ADDON_LOADED");
	elseif event=="PLAYER_LOGIN" then
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
--f:RegisterEvent("PLAYER_LOGIN")

