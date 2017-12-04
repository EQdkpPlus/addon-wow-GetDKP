-------------------------------------------------------------------
---- GetDKP Plus																----
---- Copyright (C) 2006-2018 EQdkp-Plus Developer Team			----
---- You should have received a copy of the GNU Affero			----
---- General Public License along with this program. If not,	----
---- see http://www.gnu.org/licenses/.									----
-------------------------------------------------------------------

if not FuBar then
	return
end;


	local L = LibStub("AceLocale-3.0"):GetLocale("GetDKP", true)
	Dewdrop = LibStub("Dewdrop-2.0")
	Tablet = LibStub("Tablet-2.0")
	local defaults = {
		global = {
			showdkp = "",
			showWarlock = false,
			showDruid = false,
			showMage = false,
			showHunter = false,
			showRogue = false,
			showPriest= false,
			showWarrior = false,
			showShaman = false,
			showPaladin = false,
			showDK = false,
			showSpecialClass1 = false,
			showSpecialClass2 = false,
			showSpecialClass3 = false,
			showSpecialClass4 = false,
			showSpecialClass5 = false,
			showSpecialClass6 = false,
			showSpecialClass7 = false,
			showSpecialClass8 = false,
			showSpecialClass9 = false,
			showSpecialClass10 = false
		}
	}
	
	GetDKPFu = LibStub("AceAddon-3.0"):NewAddon("GetDKPFu", "AceEvent-3.0", "AceConsole-3.0", "AceTimer-3.0", "LibFuBarPlugin-3.0")
	
	GetDKPFu.version = "3.3";
	
	--GetDKPFu.date = string.sub("$Id: GetDKPFu.lua 8882 2010-10-25 21:52:40Z Sylna $", 16, 39)
	
	GetDKPFu:SetFuBarOption("hasIcon", true)
	GetDKPFu:SetFuBarOption("iconPath", "Interface\\Icons\\INV_Misc_Head_Dragon_Black" )
	GetDKPFu:SetFuBarOption("defaultPosition", "LEFT")
	GetDKPFu:SetFuBarOption("tooltipType", "Tablet-2.0")
	GetDKPFu:SetFuBarOption("clickableTooltip", true )
	GetDKPFu:SetFuBarOption("tooltipHiddenWhenEmpty", true)
	GetDKPFu:SetFuBarOption("copyright", "Fubar [GetDkp] v"..GetDKPFu.version.."\n".."GETDKP "..GDKP_VERSION.."\n".."by Charla @ EU Antonidas")
	GetDKPFu:SetFuBarOption("version", GetDKPFu.version)
	GetDKPFu:SetFuBarOption("configType", "Dewdrop-2.0")
	GetDKPFu:SetFuBarOption("overrideMenu", true)

function GetDKPFu:OnMenuRequest(level, value)
	if (multiTable) then
	if (level == 1) then	
		Dewdrop:AddLine('text' , "|cffff0000"..L["Konto"].."|r");
		if table.getn(multiTable) == 1  then		
			Dewdrop:AddLine(
				'text', 'dkp',
				'func', function()
						self.db.global.showdkp = table.foreach(multiTable[1], VarReturn)
						self:UpdateFuBarPlugin()
				end
				
				)		
		
			
		else
			for i = 1,table.getn(multiTable),1 do
				
				Dewdrop:AddLine(
					'text', table.foreach(multiTable[i], VarReturn),
					'func', function()
						self.db.global.showdkp = table.foreach(multiTable[i], VarReturn)
						self:UpdateFuBarPlugin()
					end
					
				)
				
			end;
		end;
				
		Dewdrop:AddLine()
		
		-- Open Config + B&W
			Dewdrop:AddLine(
				'text', L["Config"],
				'func', function()
					GetDKP_Config_Toggle();
				end
			)
			if (GDKPvar_save.GDA_OnOff) then
				Dewdrop:AddLine(
					'text', L["BW"],
					'func', function()
						GetDKPAdmin_Toggle();
					end
				)
			end
		
		Dewdrop:AddLine()
		-- Class menu
		Dewdrop:AddLine('text' , L["Klasse"] , 'value' , L["Klasse"] , 'hasArrow' , true);
		Dewdrop:AddLine('text' , L["SpKlasse"] , 'value' , L["SpKlasse"] , 'hasArrow' , true);				
		
		Dewdrop:AddLine()
		local inraid
		if GDKPvar_save.ShowOnlyInRaid == "true" then
			inraid = true
		elseif GDKPvar_save.ShowOnlyInRaid == "false" then
			inraid = false
		end;

		Dewdrop:AddLine(
			'text', L["OnlyRaid"],
			'arg1', self,
			'func', function()
				if inraid then
					GDKP_SetOptionValue("ShowOnlyInRaid","false" )
					inraid = false
				else 
					GDKP_SetOptionValue("ShowOnlyInRaid","true" )
					inraid = true
				end;
				self:UpdateFuBarPlugin()
			end,
			'checked', inraid
		)
		
		Dewdrop:AddLine()
	elseif (level == 2) then
		if (value == L["Klasse"]) then
			Dewdrop:AddLine('text' , "|cffff0000"..L["Klasse"].."|r");
			Dewdrop:AddLine(
					'text' , L["Warlock"] ,
					'arg1' , Self ,
					'func' , function ()
							if (self.db.global.showWarlock == true) then
								self.db.global.showWarlock = false;
							else
								self.db.global.showWarlock = true;
							end;
					end,
					'checked' , self.db.global.showWarlock
			)
			Dewdrop:AddLine(
					'text' , L["Druid"] ,
					'arg1' , Self ,
					'func' , function ()
							if (self.db.global.showDruid == true) then
								self.db.global.showDruid = false;
							else
								self.db.global.showDruid = true;
							end;
					end,
					'checked' , self.db.global.showDruid
			)
			Dewdrop:AddLine(
					'text' , L["Mage"] ,
					'arg1' , Self ,
					'func' , function ()
							if (self.db.global.showMage == true) then
								self.db.global.showMage = false;
							else
								self.db.global.showMage = true;
							end;
					end,
					'checked' , self.db.global.showMage
			)
			Dewdrop:AddLine(
					'text' , L["Hunter"] ,
					'arg1' , Self ,
					'func' , function ()
							if (self.db.global.showHunter == true) then
								self.db.global.showHunter = false;
							else
								self.db.global.showHunter = true;
							end;
					end,
					'checked' , self.db.global.showHunter
			)
			Dewdrop:AddLine(
					'text' , L["Rogue"] ,
					'arg1' , Self ,
					'func' , function ()
							if (self.db.global.showRogue == true) then
								self.db.global.showRogue = false;
							else
								self.db.global.showRogue = true;
							end;
					end,
					'checked' , self.db.global.showRogue
			)
			Dewdrop:AddLine(
					'text' , L["Priest"] ,
					'arg1' , Self ,
					'func' , function ()
							if (self.db.global.showPriest == true) then
								self.db.global.showPriest = false;
							else
								self.db.global.showPriest = true;
							end;
					end,
					'checked' , self.db.global.showPriest
			)
			Dewdrop:AddLine(
					'text' , L["Warrior"] ,
					'arg1' , Self ,
					'func' , function ()
							if (self.db.global.showWarrior == true) then
								self.db.global.showWarrior = false;
							else
								self.db.global.showWarrior = true;
							end;
					end,
					'checked' , self.db.global.showWarrior
			)
			Dewdrop:AddLine(
					'text' , L["Shaman"] ,
					'arg1' , Self ,
					'func' , function ()
							if (self.db.global.showShaman == true) then
								self.db.global.showShaman = false;
							else
								self.db.global.showShaman = true;
							end;
					end,
					'checked' , self.db.global.showShaman
			)
			Dewdrop:AddLine(
					'text' , L["Paladin"] ,
					'arg1' , Self ,
					'func' , function ()
							if (self.db.global.showPaladin == true) then
								self.db.global.showPaladin = false;
							else
								self.db.global.showPaladin = true;
							end;
					end,
					'checked' , self.db.global.showPaladin
			)
						Dewdrop:AddLine(
					'text' , L["DK"] ,
					'arg1' , Self ,
					'func' , function ()
							if (self.db.global.showDK == true) then
								self.db.global.showDK = false;
							else
								self.db.global.showDK = true;
							end;
					end,
					'checked' , self.db.global.showDK
			)
		elseif (value == L["SpKlasse"]) then
			Dewdrop:AddLine('text' , "|cffff0000"..L["SpKlasse"].."|r");
			Dewdrop:AddLine(
					'text' , L["SpecialClass1"] ,
					'arg1' , Self ,
					'func' , function ()
							if (self.db.global.showSpecialClass1 == true) then
								self.db.global.showSpecialClass1 = false;
							else
								self.db.global.showSpecialClass1 = true;
							end;
					end,
					'checked' , self.db.global.showSpecialClass1
			)
			Dewdrop:AddLine(
					'text' , L["SpecialClass2"] ,
					'arg1' , Self ,
					'func' , function ()
							if (self.db.global.showSpecialClass2 == true) then
								self.db.global.showSpecialClass2 = false;
							else
								self.db.global.showSpecialClass2 = true;
							end;
					end,
					'checked' , self.db.global.showSpecialClass2
			)
			Dewdrop:AddLine(
					'text' , L["SpecialClass3"] ,
					'arg1' , Self ,
					'func' , function ()
							if (self.db.global.showSpecialClass3 == true) then
								self.db.global.showSpecialClass3 = false;
							else
								self.db.global.showSpecialClass3 = true;
							end;
					end,
					'checked' , self.db.global.showSpecialClass3
			)
			Dewdrop:AddLine(
					'text' , L["SpecialClass4"] ,
					'arg1' , Self ,
					'func' , function ()
							if (self.db.global.showSpecialClass4 == true) then
								self.db.global.showSpecialClass4 = false;
							else
								self.db.global.showSpecialClass4 = true;
							end;
					end,
					'checked' , self.db.global.showSpecialClass4
			)
			Dewdrop:AddLine(
					'text' , L["SpecialClass5"] ,
					'arg1' , Self ,
					'func' , function ()
							if (self.db.global.showSpecialClass5 == true) then
								self.db.global.showSpecialClass5 = false;
							else
								self.db.global.showSpecialClass5 = true;
							end;
					end,
					'checked' , self.db.global.showSpecialClass5
			)
			Dewdrop:AddLine(
					'text' , L["SpecialClass6"] ,
					'arg1' , Self ,
					'func' , function ()
							if (self.db.global.showSpecialClass6 == true) then
								self.db.global.showSpecialClass6 = false;
							else
								self.db.global.showSpecialClass6 = true;
							end;
					end,
					'checked' , self.db.global.showSpecialClass6
			)
			Dewdrop:AddLine(
					'text' , L["SpecialClass7"] ,
					'arg1' , Self ,
					'func' , function ()
							if (self.db.global.showSpecialClass7 == true) then
								self.db.global.showSpecialClass7 = false;
							else
								self.db.global.showSpecialClass7 = true;
							end;
					end,
					'checked' , self.db.global.showSpecialClass7
			)
			Dewdrop:AddLine(
					'text' , L["SpecialClass8"] ,
					'arg1' , Self ,
					'func' , function ()
							if (self.db.global.showSpecialClass8 == true) then
								self.db.global.showSpecialClass8 = false;
							else
								self.db.global.showSpecialClass8 = true;
							end;
					end,
					'checked' , self.db.global.showSpecialClass8
			)
			Dewdrop:AddLine(
					'text' , L["SpecialClass9"] ,
					'arg1' , Self ,
					'func' , function ()
							if (self.db.global.showSpecialClass9 == true) then
								self.db.global.showSpecialClass9 = false;
							else
								self.db.global.showSpecialClass9 = true;
							end;
					end,
					'checked' , self.db.global.showSpecialClass9
			)
			Dewdrop:AddLine(
					'text' , L["SpecialClass10"] ,
					'arg1' , Self ,
					'func' , function ()
							if (self.db.global.showSpecialClass10 == true) then
								self.db.global.showSpecialClass10 = false;
							else
								self.db.global.showSpecialClass10 = true;
							end;
					end,
					'checked' , self.db.global.showSpecialClass10
			)
		end;
	end;
	end;
end;

function GetDKPFu:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("GetDKPFuDB", defaults);
end

function GetDKPFu:OnEnable()
	self:UpdateFuBarPlugin();
	local UpdTimer = self:ScheduleRepeatingTimer(self.OnUpdateFuBarText, 1, self);
end

function GetDKPFu:OnDisable()
	self:CancelTimer(UpdTimer, true)
end

function GetDKPFu:OnUpdateFuBarText()
	if (multiTable and not getdkp_list_load_empfang) then
	if ( self.db.global.showdkp == "" or self.db.global.showdkp == nil) then
		self.db.global.showdkp = table.foreach(multiTable[1], VarReturn);
	end;
	
	
	settext = "";
	_name = UnitName("player");
	if (gdkp_alliases ~= nil) then
		for key,val in pairs(gdkp_alliases) do
			for i=1,table.getn(gdkp_alliases[key]),1 do
				if (gdkp_alliases[key][i] ==  _name) then 
					_name = key;
				end;
			end;
		end;
	end;
	if (gdkp.players[_name] ~= nil) then
			konto = self.db.global.showdkp.."_current";
			if (gdkp.players[_name][konto] == nil) then
				konto = table.foreach(multiTable[1], VarReturn).."_current";
				self.db.global.showdkp = table.foreach(multiTable[1], VarReturn);
			end;
			settext = settext.." "..self.db.global.showdkp.."|cff00ff00 "..gdkp.players[_name][konto].."|r";
	end;
	
	if (settext == "") then
		settext = "No Data";
	end;
	self:SetFuBarText(settext) 
	end;
end

function GetDKPFu:OnUpdate()
self:OnUpdateFuBarText()
end

function GetDKPFu:AddTTLine(player, class, dkporg ,dkplive)
		if (multiTable) then
		--color = "00ff00"
		local color = self:GetClassColor(class)
			
		_cat:AddLine(
				'text',   " |cff" .. color .. player .. "|r",
				--'text2', dkplive .. " [|cffffffff" .. dkporg .. "|r]",
				'text2', " [|cffffffff" .. dkporg .. "|r]",
				'text2R', r2,
				'text2G', g2,
				'text2B', b2,
				'hasCheck', true,
				'func', 'OnClickName',
				'arg1', self,
				'arg2', player,
				'arg3', dkporg
				)	
		end;
end;

function GetDKPFu:OnUpdateFuBarTooltip()
	if (multiTable and not getdkp_list_load_empfang) then
		_name = UnitName("player");
		if (gdkp_alliases ~= nil) then
			for key,val in pairs(gdkp_alliases) do
				for i=1,table.getn(gdkp_alliases[key]),1 do
					if (gdkp_alliases[key][i] ==  _name) then 
						_name = key;
					end;
				end;
			end;
		end;
		
		if (gdkp.players[_name] ~= nil) then	
			for i = 1, table.getn(multiTable),1 do
				_cat = Tablet:AddCategory(
				'text', table.foreach(multiTable[i], VarReturn),
				'columns', 2
				
				)
				
				_cat:AddLine('text'," ")
				_cat:AddLine(
						'text', L["Current"],
						'text2', "[|cff00ff00"..gdkp.players[_name][table.foreach(multiTable[i], VarReturn).."_current"].."|r]",
						'text2R', 0,
						'text2G', 1,
						'text2B', 0
					)
				_cat:AddLine(
						'text', L["Adjust"],
						'text2', "[|cff00ff00"..gdkp.players[_name][table.foreach(multiTable[i], VarReturn).."_adjust"].."|r]",
						'text2R', 0,
						'text2G', 1,
						'text2B', 0
					)	
				_cat:AddLine(
						'text', L["Earned"],
						'text2', "[|cff00ff00"..gdkp.players[_name][table.foreach(multiTable[i], VarReturn).."_earned"].."|r]",
						'text2R', 0,
						'text2G', 1,
						'text2B', 0
					)
				_cat:AddLine(
						'text', L["Spend"],
						'text2', "|cff00ff00["..gdkp.players[_name][table.foreach(multiTable[i], VarReturn).."_spend"].."|r]",
						'text2R', 0,
						'text2G', 1,
						'text2B', 0
					)
				
			end;
			_cat:AddLine('text'," ")
			if (GDKP_LiveChanged_status == true) then
				_cat:AddLine('text', L["DKPLIVE"]..GDKP_LiveChanged_date.."|cffff0000".." - changed from LiveDKP !",'textR', 1,'textG', 0,'textB', 0)
			else
				_cat:AddLine('text', GDL_Data..DKPInfo["date"])
			end;
			
			_cat:AddLine('text'," ")
			_cat = Tablet:AddCategory('text',L["KlassenDkp"],'columns', 2,'hideBlankLine', true)
			_cat:AddLine('text'," ")
			GetDKP_Fubar_Class = {};
			if (self.db.global.showWarlock == true) then
				for key, val in pairs(gdkp.players) do
					if (val.class == "Warlock" or val.class == "Hexenmeister") then
						if (GDKPvar_save.ShowOnlyInRaid == "true" and GetDKP_List_CheckifPlayerIsInRaid(key) == true) then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						elseif (GDKPvar_save.ShowOnlyInRaid == "false") then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						end;
					end;
				end;
				if (GetDKP_Fubar_Class ~= nil) then
					GetDKP_Fubar_Class = self:Sort(GetDKP_Fubar_Class);
					for i = 1, table.getn(GetDKP_Fubar_Class),1 do
						self:AddTTLine(GetDKP_Fubar_Class[i].name,GetDKP_Fubar_Class[i].class,GetDKP_Fubar_Class[i].dkp);
					end;
					_cat:AddLine('text'," ")
				end;
			end;
			GetDKP_Fubar_Class = {};
			if (self.db.global.showDruid == true) then
				for key, val in pairs(gdkp.players) do
					if (val.class == "Druid" or val.class == "Druide") then
						if (GDKPvar_save.ShowOnlyInRaid == "true" and GetDKP_List_CheckifPlayerIsInRaid(key) == true) then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						elseif (GDKPvar_save.ShowOnlyInRaid == "false") then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						end;
					end;
				end;
				if (GetDKP_Fubar_Class ~= nil) then
					GetDKP_Fubar_Class = self:Sort(GetDKP_Fubar_Class);
					for i = 1, table.getn(GetDKP_Fubar_Class),1 do
						self:AddTTLine(GetDKP_Fubar_Class[i].name,GetDKP_Fubar_Class[i].class,GetDKP_Fubar_Class[i].dkp);
					end;
					_cat:AddLine('text'," ")
				end;
			end;
			GetDKP_Fubar_Class = {};
			if (self.db.global.showMage == true) then
				for key, val in pairs(gdkp.players) do
					if (val.class == "Mage" or val.class == "Magier") then
						if (GDKPvar_save.ShowOnlyInRaid == "true" and GetDKP_List_CheckifPlayerIsInRaid(key) == true) then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						elseif (GDKPvar_save.ShowOnlyInRaid == "false") then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						end;
					end;
				end;
				if (GetDKP_Fubar_Class ~= nil) then
					GetDKP_Fubar_Class = self:Sort(GetDKP_Fubar_Class);
					for i = 1, table.getn(GetDKP_Fubar_Class),1 do
						self:AddTTLine(GetDKP_Fubar_Class[i].name,GetDKP_Fubar_Class[i].class,GetDKP_Fubar_Class[i].dkp);
					end;
					_cat:AddLine('text'," ")
				end;
			end;
			GetDKP_Fubar_Class = {};
			if (self.db.global.showHunter == true) then
				for key, val in pairs(gdkp.players) do
					if (val.class == "Hunter" or val.class == "J\195\164ger") then
						if (GDKPvar_save.ShowOnlyInRaid == "true" and GetDKP_List_CheckifPlayerIsInRaid(key) == true) then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						elseif (GDKPvar_save.ShowOnlyInRaid == "false") then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						end;
					end;
				end;
				if (GetDKP_Fubar_Class ~= nil) then
					GetDKP_Fubar_Class = self:Sort(GetDKP_Fubar_Class);
					for i = 1, table.getn(GetDKP_Fubar_Class),1 do
						self:AddTTLine(GetDKP_Fubar_Class[i].name,GetDKP_Fubar_Class[i].class,GetDKP_Fubar_Class[i].dkp);
					end;
					_cat:AddLine('text'," ")
				end;
			end;
			GetDKP_Fubar_Class = {};
			if (self.db.global.showRogue == true) then
				for key, val in pairs(gdkp.players) do
					if (val.class == "Rogue" or val.class == "Schurke") then
						if (GDKPvar_save.ShowOnlyInRaid == "true" and GetDKP_List_CheckifPlayerIsInRaid(key) == true) then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						elseif (GDKPvar_save.ShowOnlyInRaid == "false") then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						end;
					end;
				end;
				if (GetDKP_Fubar_Class ~= nil) then
					GetDKP_Fubar_Class = self:Sort(GetDKP_Fubar_Class);
					for i = 1, table.getn(GetDKP_Fubar_Class),1 do
						self:AddTTLine(GetDKP_Fubar_Class[i].name,GetDKP_Fubar_Class[i].class,GetDKP_Fubar_Class[i].dkp);
					end;
					_cat:AddLine('text'," ")
				end;
			end;
			GetDKP_Fubar_Class = {};
			if (self.db.global.showPriest == true) then
				for key, val in pairs(gdkp.players) do
					if (val.class == "Priest" or val.class == "Priester") then
						if (GDKPvar_save.ShowOnlyInRaid == "true" and GetDKP_List_CheckifPlayerIsInRaid(key) == true) then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						elseif (GDKPvar_save.ShowOnlyInRaid == "false") then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						end;
					end;
				end;
				if (GetDKP_Fubar_Class ~= nil) then
					GetDKP_Fubar_Class = self:Sort(GetDKP_Fubar_Class);
					for i = 1, table.getn(GetDKP_Fubar_Class),1 do
						self:AddTTLine(GetDKP_Fubar_Class[i].name,GetDKP_Fubar_Class[i].class,GetDKP_Fubar_Class[i].dkp);
					end;
					_cat:AddLine('text'," ")
				end;
			end;
			GetDKP_Fubar_Class = {};
			if (self.db.global.showWarrior == true) then
				for key, val in pairs(gdkp.players) do
					if (val.class == "Warrior" or val.class == "Krieger") then
						if (GDKPvar_save.ShowOnlyInRaid == "true" and GetDKP_List_CheckifPlayerIsInRaid(key) == true) then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						elseif (GDKPvar_save.ShowOnlyInRaid == "false") then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						end;
					end;
				end;
				if (GetDKP_Fubar_Class ~= nil) then
					GetDKP_Fubar_Class = self:Sort(GetDKP_Fubar_Class);
					for i = 1, table.getn(GetDKP_Fubar_Class),1 do
						self:AddTTLine(GetDKP_Fubar_Class[i].name,GetDKP_Fubar_Class[i].class,GetDKP_Fubar_Class[i].dkp);
					end;
					_cat:AddLine('text'," ")
				end;
			end;
			GetDKP_Fubar_Class = {};
			if (self.db.global.showShaman == true) then
				for key, val in pairs(gdkp.players) do
					if (val.class == "Shaman" or val.class == "Schamane") then
						if (GDKPvar_save.ShowOnlyInRaid == "true" and GetDKP_List_CheckifPlayerIsInRaid(key) == true) then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						elseif (GDKPvar_save.ShowOnlyInRaid == "false") then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						end;
					end;
				end;
				if (GetDKP_Fubar_Class ~= nil) then
					GetDKP_Fubar_Class = self:Sort(GetDKP_Fubar_Class);
					for i = 1, table.getn(GetDKP_Fubar_Class),1 do
						self:AddTTLine(GetDKP_Fubar_Class[i].name,GetDKP_Fubar_Class[i].class,GetDKP_Fubar_Class[i].dkp);
					end;
					_cat:AddLine('text'," ")
				end;
			end;
			GetDKP_Fubar_Class = {};
			if (self.db.global.showPaladin == true) then
				for key, val in pairs(gdkp.players) do
					if (val.class == "Paladin" or val.class == "Paladin") then
						if (GDKPvar_save.ShowOnlyInRaid == "true" and GetDKP_List_CheckifPlayerIsInRaid(key) == true) then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						elseif (GDKPvar_save.ShowOnlyInRaid == "false") then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						end;
					end;
				end;
				if (GetDKP_Fubar_Class ~= nil) then
					GetDKP_Fubar_Class = self:Sort(GetDKP_Fubar_Class);
					for i = 1, table.getn(GetDKP_Fubar_Class),1 do
						self:AddTTLine(GetDKP_Fubar_Class[i].name,GetDKP_Fubar_Class[i].class,GetDKP_Fubar_Class[i].dkp);
					end;
					_cat:AddLine('text'," ")
				end;
			end;
			GetDKP_Fubar_Class = {};
			if (self.db.global.showDK == true) then
				for key, val in pairs(gdkp.players) do
					if (val.class == "Death Knight" or val.class == "Todesritter") then
						if (GDKPvar_save.ShowOnlyInRaid == "true" and GetDKP_List_CheckifPlayerIsInRaid(key) == true) then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						elseif (GDKPvar_save.ShowOnlyInRaid == "false") then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						end;
					end;
				end;
				if (GetDKP_Fubar_Class ~= nil) then
					GetDKP_Fubar_Class = self:Sort(GetDKP_Fubar_Class);
					for i = 1, table.getn(GetDKP_Fubar_Class),1 do
						self:AddTTLine(GetDKP_Fubar_Class[i].name,GetDKP_Fubar_Class[i].class,GetDKP_Fubar_Class[i].dkp);
					end;
					_cat:AddLine('text'," ")
				end;
			end;
			
			-----------------Special Classes --------------------------------------
			
			_cat:AddLine('text'," ")
			_cat = Tablet:AddCategory('text',L["SpKlassenDkp"],'columns', 2,'hideBlankLine', true)
			_cat:AddLine('text'," ")
			GetDKP_Fubar_Class = {};
			if (self.db.global.showSpecialClass1 == true) then
				_cat:AddLine('text',L["SpecialClass1"])
				for key, val in pairs(gdkp.players) do
					if (val.class == "Paladin" or val.class == "Paladin" or val.class == "Shaman" or val.class == "Schamane" or val.class == "Rogue" or val.class == "Schurke") then
						if (GDKPvar_save.ShowOnlyInRaid == "true" and GetDKP_List_CheckifPlayerIsInRaid(key) == true) then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						elseif (GDKPvar_save.ShowOnlyInRaid == "false") then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						end;
					end;
				end;
				if (GetDKP_Fubar_Class ~= nil) then
					GetDKP_Fubar_Class = self:Sort(GetDKP_Fubar_Class);
					for i = 1, table.getn(GetDKP_Fubar_Class),1 do
						self:AddTTLine(GetDKP_Fubar_Class[i].name,GetDKP_Fubar_Class[i].class,GetDKP_Fubar_Class[i].dkp);
					end;
					_cat:AddLine('text'," ")
				end;
			end;
			GetDKP_Fubar_Class = {};
			if (self.db.global.showSpecialClass2 == true) then
				_cat:AddLine('text',L["SpecialClass2"])
				for key, val in pairs(gdkp.players) do
					if (val.class == "Warrior" or val.class == "Krieger" or val.class == "Priest" or val.class == "Priester" or val.class == "Druid" or val.class == "Druide") then
						if (GDKPvar_save.ShowOnlyInRaid == "true" and GetDKP_List_CheckifPlayerIsInRaid(key) == true) then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						elseif (GDKPvar_save.ShowOnlyInRaid == "false") then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						end;
					end;
				end;
				if (GetDKP_Fubar_Class ~= nil) then
					GetDKP_Fubar_Class = self:Sort(GetDKP_Fubar_Class);
					for i = 1, table.getn(GetDKP_Fubar_Class),1 do
						self:AddTTLine(GetDKP_Fubar_Class[i].name,GetDKP_Fubar_Class[i].class,GetDKP_Fubar_Class[i].dkp);
					end;
					_cat:AddLine('text'," ")
				end;
			end;
			GetDKP_Fubar_Class = {};
			if (self.db.global.showSpecialClass3 == true) then
				_cat:AddLine('text',L["SpecialClass3"])
				for key, val in pairs(gdkp.players) do
					if (val.class == "Hunter" or val.class == "J\195\164ger" or val.class == "Warlock" or val.class == "Hexenmeister" or val.class == "Mage" or val.class == "Magier") then
						if (GDKPvar_save.ShowOnlyInRaid == "true" and GetDKP_List_CheckifPlayerIsInRaid(key) == true) then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						elseif (GDKPvar_save.ShowOnlyInRaid == "false") then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						end;
					end;
				end;
				if (GetDKP_Fubar_Class ~= nil) then
					GetDKP_Fubar_Class = self:Sort(GetDKP_Fubar_Class);
					for i = 1, table.getn(GetDKP_Fubar_Class),1 do
						self:AddTTLine(GetDKP_Fubar_Class[i].name,GetDKP_Fubar_Class[i].class,GetDKP_Fubar_Class[i].dkp);
					end;
					_cat:AddLine('text'," ")
				end;
			end;
			GetDKP_Fubar_Class = {};
			if (self.db.global.showSpecialClass4 == true) then
				_cat:AddLine('text',L["SpecialClass4"])
				for key, val in pairs(gdkp.players) do
					if (val.class == "Paladin" or val.class == "Paladin" or val.class == "Warlock" or val.class == "Hexenmeister" or val.class == "Priest" or val.class == "Priester") then
						if (GDKPvar_save.ShowOnlyInRaid == "true" and GetDKP_List_CheckifPlayerIsInRaid(key) == true) then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						elseif (GDKPvar_save.ShowOnlyInRaid == "false") then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						end;
					end;
				end;
				if (GetDKP_Fubar_Class ~= nil) then
					GetDKP_Fubar_Class = self:Sort(GetDKP_Fubar_Class);
					for i = 1, table.getn(GetDKP_Fubar_Class),1 do
						self:AddTTLine(GetDKP_Fubar_Class[i].name,GetDKP_Fubar_Class[i].class,GetDKP_Fubar_Class[i].dkp);
					end;
					_cat:AddLine('text'," ")
				end;
			end;
			GetDKP_Fubar_Class = {};
			if (self.db.global.showSpecialClass5 == true) then
				_cat:AddLine('text',L["SpecialClass5"])
				for key, val in pairs(gdkp.players) do
					if (val.class == "Warrior" or val.class == "Krieger" or val.class == "Hunter" or val.class == "J\195\164ger" or val.class == "Shaman" or val.class == "Schamane") then
						if (GDKPvar_save.ShowOnlyInRaid == "true" and GetDKP_List_CheckifPlayerIsInRaid(key) == true) then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						elseif (GDKPvar_save.ShowOnlyInRaid == "false") then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						end;
					end;
				end;
				if (GetDKP_Fubar_Class ~= nil) then
					GetDKP_Fubar_Class = self:Sort(GetDKP_Fubar_Class);
					for i = 1, table.getn(GetDKP_Fubar_Class),1 do
						self:AddTTLine(GetDKP_Fubar_Class[i].name,GetDKP_Fubar_Class[i].class,GetDKP_Fubar_Class[i].dkp);
					end;
					_cat:AddLine('text'," ")
				end;
			end;
			GetDKP_Fubar_Class = {};
			if (self.db.global.showSpecialClass6 == true) then
				_cat:AddLine('text',L["SpecialClass6"])
				for key, val in pairs(gdkp.players) do
					if (val.class == "Druid" or val.class == "Druide" or val.class == "Rogue" or val.class == "Schurke" or val.class == "Mage" or val.class == "Magier" or val.class == "Death Knight" or val.class == "Todesritter") then
						if (GDKPvar_save.ShowOnlyInRaid == "true" and GetDKP_List_CheckifPlayerIsInRaid(key) == true) then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						elseif (GDKPvar_save.ShowOnlyInRaid == "false") then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						end;
					end;
				end;
				if (GetDKP_Fubar_Class ~= nil) then
					GetDKP_Fubar_Class = self:Sort(GetDKP_Fubar_Class);
					for i = 1, table.getn(GetDKP_Fubar_Class),1 do
						self:AddTTLine(GetDKP_Fubar_Class[i].name,GetDKP_Fubar_Class[i].class,GetDKP_Fubar_Class[i].dkp);
					end;
					_cat:AddLine('text'," ")
				end;
			end;
			
			GetDKP_Fubar_Class = {};
			if (self.db.global.showSpecialClass7 == true) then
				_cat:AddLine('text',L["SpecialClass7"])
				for key, val in pairs(gdkp.players) do
					if (val.class == "Priest" or val.class == "Priester" or val.class == "Warlock" or val.class == "Hexenmeister" or val.class == "Mage" or val.class == "Magier") then
						if (GDKPvar_save.ShowOnlyInRaid == "true" and GetDKP_List_CheckifPlayerIsInRaid(key) == true) then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						elseif (GDKPvar_save.ShowOnlyInRaid == "false") then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						end;
					end;
				end;
				if (GetDKP_Fubar_Class ~= nil) then
					GetDKP_Fubar_Class = self:Sort(GetDKP_Fubar_Class);
					for i = 1, table.getn(GetDKP_Fubar_Class),1 do
						self:AddTTLine(GetDKP_Fubar_Class[i].name,GetDKP_Fubar_Class[i].class,GetDKP_Fubar_Class[i].dkp);
					end;
					_cat:AddLine('text'," ")
				end;
			end;
			GetDKP_Fubar_Class = {};
			if (self.db.global.showSpecialClass8 == true) then
				_cat:AddLine('text',L["SpecialClass8"])
				for key, val in pairs(gdkp.players) do
					if (val.class == "Druid" or val.class == "Druide" or val.class == "Rogue" or val.class == "Schurke" ) then
						if (GDKPvar_save.ShowOnlyInRaid == "true" and GetDKP_List_CheckifPlayerIsInRaid(key) == true) then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						elseif (GDKPvar_save.ShowOnlyInRaid == "false") then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						end;
					end;
				end;
				if (GetDKP_Fubar_Class ~= nil) then
					GetDKP_Fubar_Class = self:Sort(GetDKP_Fubar_Class);
					for i = 1, table.getn(GetDKP_Fubar_Class),1 do
						self:AddTTLine(GetDKP_Fubar_Class[i].name,GetDKP_Fubar_Class[i].class,GetDKP_Fubar_Class[i].dkp);
					end;
					_cat:AddLine('text'," ")
				end;
			end;
			GetDKP_Fubar_Class = {};
			if (self.db.global.showSpecialClass9 == true) then
				_cat:AddLine('text',L["SpecialClass9"])
				for key, val in pairs(gdkp.players) do
					if (val.class == "Hunter" or val.class == "J\195\164ger" or val.class == "Shaman" or val.class == "Schamane" ) then
						if (GDKPvar_save.ShowOnlyInRaid == "true" and GetDKP_List_CheckifPlayerIsInRaid(key) == true) then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						elseif (GDKPvar_save.ShowOnlyInRaid == "false") then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						end;
					end;
				end;
				if (GetDKP_Fubar_Class ~= nil) then
					GetDKP_Fubar_Class = self:Sort(GetDKP_Fubar_Class);
					for i = 1, table.getn(GetDKP_Fubar_Class),1 do
						self:AddTTLine(GetDKP_Fubar_Class[i].name,GetDKP_Fubar_Class[i].class,GetDKP_Fubar_Class[i].dkp);
					end;
					_cat:AddLine('text'," ")
				end;
			end;
			GetDKP_Fubar_Class = {};
			if (self.db.global.showSpecialClass10 == true) then
				_cat:AddLine('text',L["SpecialClass10"])
				for key, val in pairs(gdkp.players) do
					if (val.class == "Warrior" or val.class == "Krieger" or val.class == "Paladin" or val.class == "Paladin" or val.class == "Death Knight" or val.class == "Todesritter") then
						if (GDKPvar_save.ShowOnlyInRaid == "true" and GetDKP_List_CheckifPlayerIsInRaid(key) == true) then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						elseif (GDKPvar_save.ShowOnlyInRaid == "false") then
							tinsert(GetDKP_Fubar_Class, {name = key , class = val.class , dkp = gdkp.players[key][self.db.global.showdkp.."_current"]});
						end;
					end;
				end;
				if (GetDKP_Fubar_Class ~= nil) then
					GetDKP_Fubar_Class = self:Sort(GetDKP_Fubar_Class);
					for i = 1, table.getn(GetDKP_Fubar_Class),1 do
						self:AddTTLine(GetDKP_Fubar_Class[i].name,GetDKP_Fubar_Class[i].class,GetDKP_Fubar_Class[i].dkp);
					end;
				end;
			end;
		end;
	end;
end

function GetDKPFu:GetClassColor(class)

	if (class == "Warrior" or class == "Krieger") then
		return 'c79c6e';
	elseif (class == "Mage" or class == "Magier") then
		return '69ccf0';					
	elseif (class == "Rogue" or class == "Schurke") then
		return 'fff569';					
	elseif (class == "Druid" or class == "Druide") then
		return 'ff7d0a';					
	elseif (class == "Hunter" or class == "J\195\164ger") then
		return 'abd473';					
	elseif (class == "Shaman" or class == "Schamane") then
		return '1049ff';					
	elseif (class == "Priest" or class == "Priester") then
		return 'ffffff';					
	elseif (class == "Warlock" or class == "Hexenmeister") then
		return '9482ca';					
	elseif (class == "Paladin" or class == "Paladin") then
		return 'f58cba';	
	elseif (class == "Death Knight" or class == "Todesritter") then
		return '9C0000';	
	elseif (class == "Demonhunter" or class == "Demonhunter") then
		return '00ff92';	
	else 
		return 'ffffff';
	end;
end

function GetDKPFu:OnFuBarClick()
	GetDKP_List_Toggle()
end

function GetDKPFu:Sort(desc)
	for i = 1, table.getn (desc) ,1 do
		for j = 1, table.getn (desc) ,1 do
			if (desc[j]["dkp"] < desc[i]["dkp"]) then
				test = desc[j];
				desc[j] = desc[i];
				desc[i] = test;
			end;
		end;
	end;
	return desc
end;	

function GetDKPFu:OnClickName(name,dkp)
	local ChatFrameEditBox = ChatEdit_GetActiveWindow();
	if ChatFrameEditBox then
		ChatFrameEditBox:Insert(name.." : "..dkp);
	end;
	
end;
