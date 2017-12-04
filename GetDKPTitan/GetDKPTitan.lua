-------------------------------------------------------------------
---- GetDKP Plus																----
---- Copyright (C) 2006-2018 EQdkp-Plus Developer Team			----
---- You should have received a copy of the GNU Affero			----
---- General Public License along with this program. If not,	----
---- see http://www.gnu.org/licenses/.									----
-------------------------------------------------------------------

TITAN_GETDKP_ID = "GETDKP";
TITAN_GETDKP_FREQUENCY = 1;

TITAN_GETDKP_THRESHOLD_TABLE = {
	Values = { 200, 1200 },
	Colors = { RED_FONT_COLOR, NORMAL_FONT_COLOR, GREEN_FONT_COLOR },
}

function TitanPanelGETDKPButton_OnLoad(this)
	
	this.registry = {
		id = TITAN_GETDKP_ID,
		version = "1.0",
		menuText = TITAN_GETDKP_MENU_TEXT,
		buttonTextFunction = "TitanPanelGETDKPButton_GetButtonText", 
		tooltipTitle = TITAN_GETDKP_TOOLTIP, 
		tooltipTextFunction = "TitanPanelGETDKPButton_GetTooltipText", 
		icon = "Interface\\Icons\\INV_Misc_Head_Dragon_Black",	
		iconWidth = 16,
		savedVariables = {
			Konto = "dkp",
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowColoredText = 1,
			displayclass = {},
			displaykonto = {},
		}
	};
	TITAN_GETDKP_GETN_TITAN_GETDKP_CLASSES = getn(TITAN_GETDKP_CLASSES);
	for j = 1,getn(multiTable),1 do
	tinsert(TITAN_GETDKP_CLASSES,{class = table.foreach(multiTable[j], VarReturn), name = table.foreach(multiTable[j], VarReturn), format = "+%d",	short = table.foreach(multiTable[j], VarReturn), cat = "ACCOUNT"});
	end;
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
end

function TitanPanelGETDKPButton_OnEvent() 
	if (event == "PLAYER_ENTERING_WORLD") then
		Titan_GETDKP_active = 1;
	end
	--TitanPanelButton_UpdateButton(TITAN_GETDKP_ID);
end
function TitanPanelGETDKP_Update()
	TitanPanelGETDKPButton_GetButtonText()
end
function TitanPanelGETDKPButton_GetButtonText()
	if (multiTable and not getdkp_list_load_empfang) then
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
		
		if (gdkp.players[_name] ~= nil and TitanGetVar(TITAN_GETDKP_ID,"displayclass") == nil) then
				konto = TitanGetVar(TITAN_GETDKP_ID,"Konto").."_current";
				if (gdkp.players[_name][konto] == nil) then
					konto = table.foreach(multiTable[1], VarReturn).."_current";
					TitanSetVar(TITAN_GETDKP_ID,"Konto",table.foreach(multiTable[1], VarReturn));
				end;
				settext = TitanGetVar(TITAN_GETDKP_ID,"Konto");
		elseif (gdkp.players[_name] ~= nil and TitanGetVar(TITAN_GETDKP_ID,"displayclass")) then
			local db = TitanGetVar(TITAN_GETDKP_ID, "displayclass");
			for i,d in pairs(db) do
				if(d >= TITAN_GETDKP_GETN_TITAN_GETDKP_CLASSES+1) then
					TitanSetVar(TITAN_GETDKP_ID,"Konto",table.foreach(multiTable[d-TITAN_GETDKP_GETN_TITAN_GETDKP_CLASSES], VarReturn));
					settext = TitanGetVar(TITAN_GETDKP_ID,"Konto");
					konto = table.foreach(multiTable[d-TITAN_GETDKP_GETN_TITAN_GETDKP_CLASSES], VarReturn).."_current";
				end;
			end;
		end;
		
		if (settext == "") then
			settext = "No Data";
			GetDKP_text = "GetDKP : "..settext;
			return GetDKP_text;
		else
			GetDKP_text = "GetDKP : "..settext.." ";
			color = TitanUtils_GetThresholdColor(TITAN_GETDKP_THRESHOLD_TABLE, gdkp.players[_name][konto]);
			GetDKPRichText = TitanUtils_GetColoredText(gdkp.players[_name][konto], color);
			return GetDKP_text, GetDKPRichText;
		end
	end;
end;

function TitanPanelGETDKPButton_GetTooltipText()
	local db = TitanGetVar(TITAN_GETDKP_ID, "displayclass");
	local i,d,_class,found,titan_getdkp_rubric,titan_getdkp_rubric_chars;
	titan_getdkp_rubric = "\n";
	table.sort(db,function(a,b) return a<b end);
	
	for e,d in pairs(db) do
		local found = 0;
		local db_found = {};
		
		if (d < TITAN_GETDKP_GETN_TITAN_GETDKP_CLASSES+1) then 
			for key, val in pairs(gdkp.players) do
				_class = GDKP_GetArgs(TITAN_GETDKP_CLASS_TRANS[d],",");
				
				for i = 1 ,getn(_class),1 do
					
					if (_class[i] == val.class and found == 0) then 
						if (GDKPvar_save.ShowOnlyInRaid == "true" and GetDKP_List_CheckifPlayerIsInRaid(key) == true) then
							found = 1;
							tinsert (db_found, {color = TitanPanelGETDKPButton_FormatShortText(0,0,val.class), name = key , class = val.class , dkp = gdkp.players[key][TitanGetVar(TITAN_GETDKP_ID,"Konto").."_current"]});
						elseif (GDKPvar_save.ShowOnlyInRaid == "false") then
							found = 1;
							tinsert (db_found, {color = TitanPanelGETDKPButton_FormatShortText(0,0,val.class), name = key , class = val.class , dkp = gdkp.players[key][TitanGetVar(TITAN_GETDKP_ID,"Konto").."_current"]});
						end;
					end;
				end;
				found = 0;
			end;
			if getn(db_found) > 0 then
				titan_getdkp_rubric = titan_getdkp_rubric..TitanUtils_GetHighlightText(TITAN_GETDKP_CLASS[d]).."\n";
				TitanPanelGETDKP_Sort(db_found);
				for i = 1 , getn(db_found),1 do
					titan_getdkp_rubric = titan_getdkp_rubric..db_found[i].color..db_found[i].name..FONT_COLOR_CODE_CLOSE.."\t"..TitanUtils_GetHighlightText(db_found[i].dkp).."\n";
				end;	
				titan_getdkp_rubric = titan_getdkp_rubric.."\n";
			end;
			
		end;
	end;
	GetDKP_text = "by Charla/Antonidas";
	return ""..titan_getdkp_rubric..TitanUtils_GetGreenText(GetDKP_text);
end;
function TitanPanelGETDKPButton_isdisp(val)
	local disp = TitanGetVar(TITAN_GETDKP_ID, "displayclass");
	local i,d;
	for i,d in pairs(disp) do
		if(d==val) then
			return 1;
		end
	end
	return nil;
end
function TitanPanelGETDKPButton_hasdisp()
	local disp = TitanGetVar(TITAN_GETDKP_ID, "displayclass");
	if(not disp) then
		return nil;
	end
	return table.getn(disp) > 0;
end
function TitanPanelGETDKP_SetDisplayClass()
	local db = TitanGetVar(TITAN_GETDKP_ID, "displayclass");
	local i,d,found;
	
	
	if(this.value == 0) then
		TitanSetVar(TITAN_GETDKP_ID, "displayclass", {});
	elseif (this.value >= TITAN_GETDKP_GETN_TITAN_GETDKP_CLASSES+1) then
	
		db = {};
		table.insert(db,this.value);
		TitanSetVar(TITAN_GETDKP_ID, "displayclass", db);
	
	elseif (this.value < TITAN_GETDKP_GETN_TITAN_GETDKP_CLASSES+1) then
		found = 0;
		for i,d in pairs(db) do
			if(d == this.value)then
				found = i;
			end
		end
		if(found > 0) then
			table.remove(db,found)
		else
			if table.getn(db)<5 then
				table.insert(db,this.value);
			end;
		end;
		TitanSetVar(TITAN_GETDKP_ID, "displayclass", db);
	end;
	TitanPanelButton_UpdateButton(TITAN_GETDKP_ID);
end;


function TitanPanelGETDKPButton_FormatShortText(short,val,class)
	if ( class == nil ) then	
		local color = 'FFFFFF';
		local text = string.sub(short,2);
		local colorcode = string.sub(short,1,1);
		if(TitanGETDKP_colors[colorcode]) then
			color = TitanGETDKP_colors[colorcode];
		end;
		if(val) then
			return '|cff'.. color .. val .. FONT_COLOR_CODE_CLOSE
		else 
			return '|cff'.. color .. text .. FONT_COLOR_CODE_CLOSE
		end;
	else
		if (class == "Warrior" or class == "Krieger") then
			return '|cffc79c6e';
		elseif (class == "Mage" or class == "Magier") then
			return '|cff69ccf0';					
		elseif (class == "Rogue" or class == "Schurke") then
			return '|cfffff569';					
		elseif (class == "Druid" or class == "Druide") then
			return '|cffff7d0a';					
		elseif (class == "Hunter" or class == "J\195\164ger") then
			return '|cffabd473';					
		elseif (class == "Shaman" or class == "Schamane") then
			return '|cff00dbba';					
		elseif (class == "Priest" or class == "Priester") then
			return '|cffffffff';					
		elseif (class == "Warlock" or class == "Hexenmeister") then
			return '|cff9482ca';					
		elseif (class == "Paladin" or class == "Paladin") then
			return '|cfff58cba';	
		else 
			return '|cff'
		end
	end;
end

function TitanPanelRightClickMenu_PrepareGETDKPMenu()
	local info = {};
	local i,cat,disp,val;
	if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then
			for i,e in pairs(TITAN_GETDKP_CLASSES) do
				if(e.cat == this.value) then
					info = {};
					info.text = '[' .. TitanPanelGETDKPButton_FormatShortText(e.short,e.name) .. ']';
					info.value = i;
					info.func = TitanPanelGETDKP_SetDisplayClass;
					info.checked = TitanPanelGETDKPButton_isdisp(i);
					--info.keepShownOnClick = 1;
					UIDropDownMenu_AddButton(info,UIDROPDOWNMENU_MENU_LEVEL);
				end
			end
		
	else
		TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_GETDKP_ID].menuText);
		TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL);
				
			for i,cat in pairs(TITAN_GETDKP_CATEGORIES) do
				info = {};
				info.text = getglobal('TITAN_GETDKP_CAT_'..cat);
				info.hasArrow = 1;
				info.value = cat;
				UIDropDownMenu_AddButton(info);
			end;
			TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL);
			TitanPanelRightClickMenu_AddToggleIcon(TITAN_GETDKP_ID);
			TitanPanelRightClickMenu_AddToggleVar(TITAN_GETDKP_SHORTDISPLAY, TITAN_GETDKP_ID,'shortdisplay');
			TitanPanelRightClickMenu_AddToggleLabelText(TITAN_GETDKP_ID);
			TitanPanelRightClickMenu_AddToggleColoredText(TITAN_GETDKP_ID);
			TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, id, TITAN_PANEL_MENU_FUNC_HIDE);
	end;
end;
function TitanPanelGETDKPButton_OnClick()


end;
function TitanPanelGETDKP_Sort(desc)
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
