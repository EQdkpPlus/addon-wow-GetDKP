--------------------------------------------------------------------
---- GetDKP Plus												----
---- Copyright (c) 2006-2019 EQdkp-Plus Developer Team			----
---- You should have received a copy of the GNU Affero			----
---- General Public License along with this program. If not,	----
---- see http://www.gnu.org/licenses/.							----
--------------------------------------------------------------------

	GDL_UpdateInterval = 0.01;
	GDL_ItemList_UpdateInterval = 6;
	if (multiTable) then
		if (table.foreach(multiTable[1], VarReturn) == "DKP") then
			if (multiTable[1].DKP.disc == "Raid DKP") then
				multiTable = {};
				multiTable = {
							[1]= {
								["dkp"] = {
										["name"] = "dkp",
										["disc"] = "Raid DKP",
										["events"] = " "
											}
								}
							} ;
			end;
		end;
	end;
	GDL_Class = {};
	GDL_Players = {};
	GDL_Class[1] = {};
	GDL_Class[2] = {};
	i = 1;
	GDL_Class[1][i] = "Alle";
	GDL_Class[2][i] = "All";
	i = i + 1;
	for key, val in pairs(GDKP_Search_SETS) do

			GDL_Class[1][i] = val["Class_DE"];

			GDL_Class[2][i] = val["Class_ENG"];

		i = i + 1;
	end;
	GDL_Class[1][i] = "Unbekannt";
	GDL_Class[2][i] = "Unknown";
	GDL_NonSetItems = {};
	GDL_SetQuestItems = {};
	GDL_SetNonSetItems = {};
	GDL_S1 = "up";
	GDL_S2 = "up";
	GDL_S3 = "up";
	GDL_S4 = "up";
	GDL_NonSetS1 = "up";
	GDL_NonSetS2 = "up";
	if ( GetLocale() == "deDE" ) then
		GDL_CLASS_ID = "Alle";
	else
		GDL_CLASS_ID = "All";
	end;
	GDL_CLASS_ID_NUM = 1;
	i=1;
	kontofound = 1;
	if multiTable~=nil then
		for i=1,table.getn(multiTable),1 do
			if table.foreach(multiTable[i], VarReturn) == GDKPvar_save["konto"] then
				kontofound = i;
			end;
		end;
	end;
	GDL_TO_DISPLAY = 18;
	GDL_NonSet_TO_DISPLAY = 10;
	if (multiTable) then
		GDL_DKP_LIST = table.foreach(multiTable[kontofound], VarReturn) ;
	end;
	GDL_DKP_LIST_Atrib = "current";
	GDL_Konto_Atrib = {"current","earned","spend","adjust","current"};
	GDL_Setitem_tabelname ={"T6","T5","T4","T3","T2","T1","ZG","AQ20","AQ40"};

	GDL_Itemlist_SetID = 1;
	if ( GetLocale() == "deDE" ) then
		GDL_Itemlist_Locale = 4;
	else
		GDL_Itemlist_Locale = 3;
	end;
	-- Colors see http://wowwiki.wikia.com/wiki/Class_colors --
	GDL_Classes = {
						{"J\195\164ger",	"Hunter",							0.67,	0.83,	0.45},
						{"Priester",		"Priest",							1.00,	1.00,	1.00},
						{"Paladin",			"Paladin",							0.96,	0.55,	0.73},
						{"Schurke",			"Rogue",							1.00,	0.96,	0.41},
						{"Magier", 			"Mage",								0.41,	0.80,	0.94},
						{"Krieger", 		"Warrior",							0.78,	0.61,	0.43},
						{"Druide", 			"Druid",							1.00,	0.49,	0.04},
						{"Hexenmeister", 	"Warlock",							0.58,	0.51,	0.79},
						{"Schamane", 		"Shaman", 							0.00,	0.44,	0.87},
						{"Todesritter", 	"Death Knight",						0.77,	0.12,	0.23},
						{"M\195\182nch", 	"Monk",								0.33,	0.54,	0.52},
						{"D\195\164monenj\195\164ger", 	"Demonhunter",			0.64,	0.19,	0.79},
						{"Unbekannt", 		"Unknown", 							0.00,	1.00,	0.00}
						};

-----------------------------
-- GetDKP Plus List OnLoad --
-----------------------------
function GetDKP_List_OnLoad(this)

		this:RegisterEvent("VARIABLES_LOADED");
		-- Slash Commands
		SlashCmdList["GETDKPLIST"] = GetDKP_List_SlashHandler;
		SLASH_GETDKPLIST1 = "/gdl";
		-- ALLREADY LOAD
		GETDKP_LISTLOAD = true;

end;

------------------------------------
-- GetDKP Plus List Slash Handler --
------------------------------------
function GetDKP_List_SlashHandler(msg)
	GetDKP_List_Toggle();
end;

------------------------------------
-- GetDKP Plus List Event Handler --
------------------------------------
function GetDKP_List_OnEvent(event)
	if (event == "VARIABLES_LOADED") then
		GetDKP_List_VarLoad();
		return;
	else
		return;
	end;
end;

------------------------------
-- GetDKP Plus List VarLoad --
------------------------------
function GetDKP_List_VarLoad()
	if (DKP_ITEMS == nil) then
		DKP_ITEMS = {};
		--return
	end;
	if ( GetLocale() == "deDE" ) then
		GDL_CLASS_ID = "Alle";
	else
		GDL_CLASS_ID = "All";
	end;
	GDKP_Player_NoItems = {};
	if (gdkp == nil) then
		return;
	else
		for key,val in pairs(gdkp.players) do
			if (DKP_ITEMS[key] == nil) then
				tinsert(GDKP_Player_NoItems, {name = key , class = GDL_SetClass(gdkp.players[key].class), dkp= gdkp["players"][key][GDKPvar_save.konto.."_current"]});
			end;
		end;
		GDL_CLASS_ID_NUM = 1;
		GDLFrameTitleText:SetText("Get DKP Plus List");
		if (GDKP_LiveChanged_status == true) then
			GDLFrameDateText:SetText(GDL_Data..GDKP_LiveChanged_date.."|cffff0000".." - changed from LiveDKP !");
		else
			GDLFrameDateText:SetText(GDL_Data..DKPInfo["date"]);
		end;
		GDLFrameTotalPlayerText:SetText(GDL_TPlayers..DKPInfo["total_players"]);
		GDLFrameTotalItemText:SetText(GDL_TItems..DKPInfo["total_items"]);
		GDLFrameTotalPointsText:SetText(GDL_TPoints..DKPInfo["total_points"]);
		GDLFrameKontoText:SetText(GDL_DKP_LIST..GDL_Events);
		kontofound = 1;
		for i=1,table.getn(multiTable),1 do
			if table.foreach(multiTable[i], VarReturn) == GDKPvar_save["konto"] then
				kontofound = i;
				GDL_DKP_LIST = GDKPvar_save["konto"];
			end;
		end;
		if ( strlen(multiTable[kontofound][GDL_DKP_LIST].events) >= 40) then
			text = string.sub(multiTable[kontofound][GDL_DKP_LIST].events ,0,40).." ...";
		else
			text = multiTable[kontofound][GDL_DKP_LIST].events;
		end;
		GDLFrameKontoEvent:SetText(text);
		GDL_Playerlist_FrameKontoDropDown_SetSelectedID(GDL_Playerlist_FrameKontoDropDown, kontofound, GDL_DKP_LIST);
		--getglobal("GDL_Playerlist_ShowItemButton").status = "set";
		if (GDKPvar_save["ShowOnlyInRaid"] == "true") then
			getglobal("GDL_Playerlist_InRaidButton").status = "inraid";
			GDL_Playerlist_InRaidButton:SetText(GDL_INRAID);
		else
			getglobal("GDL_Playerlist_InRaidButton").status = "notinraid";
			GDL_Playerlist_InRaidButton:SetText(GDL_NOTINRAID);

		end;
		GDL_NonSetItems = {};
		GDL_SetNonSetItems = {};
		GDL_SetQuestItems = {};
		if (DKP_ITEMS ~= nil) then
			for key, val in pairs(DKP_ITEMS) do
				for gdkpkey,gdkpval in pairs (gdkp.players) do
					if (string.lower(key) == string.lower(gdkpkey)) then
						class = GDL_SetClass (gdkpval.class);
					end;
				end;

				-- for item, itemval in pairs(DKP_ITEMS[key]["Items"]) do
				for k = 1, getn(DKP_ITEMS[key]["Items"]),1 do
				getnonset = 0;
				id = 0;
					for j=2,table.getn(GDL_Class[2])-1,1 do
					for i=1,table.getn(GDL_Setitem_tabelname),1 do
						if (GDL_Setitem_tabelname[i] ~= "T4" and GDL_Setitem_tabelname[i] ~= "T5" and GDL_Setitem_tabelname[i] ~= "T6") then
							for itempos,setitemval in pairs(GDL_Sets[GDL_Class[2][j]][GDL_Setitem_tabelname[i]]) do
								if (itempos ~= "setname") then

									if (GDL_Setitem_tabelname[i] == "T1" or GDL_Setitem_tabelname[i] == "T2") then
										if (DKP_ITEMS[key]["Items"][k].name == setitemval[3] or DKP_ITEMS[key]["Items"][k].name == setitemval[4]) then
											if (class == GDL_Class[2][j]) then
												getnonset = 3;
											else
												getnonset = 2;
											end;
										end;
									elseif (GDL_Setitem_tabelname[i] == "T3") then
										if (itempos ~= "finger1") then
											if (DKP_ITEMS[key]["Items"][k].name == setitemval[6] or DKP_ITEMS[key]["Items"][k].name == setitemval[7]) then
												if (class == GDL_Class[2][j]) then
													getnonset = 1;
												end;
											end;

										else
											if (DKP_ITEMS[key]["Items"][k].name == setitemval[3] or DKP_ITEMS[key]["Items"][k].name == setitemval[4]) then
												if (class == GDL_Class[2][j]) then
													getnonset = 3;
												else
													getnonset = 2;
												end;
											end;
										end;
									elseif (GDL_Setitem_tabelname[i] == "ZG" or GDL_Setitem_tabelname[i] == "AQ20" or GDL_Setitem_tabelname[i] == "AQ40") then
										if (DKP_ITEMS[key]["Items"][k].name == setitemval[6] or DKP_ITEMS[key]["Items"][k].name == setitemval[7]) then
											if (class == GDL_Class[2][j]) then
												getnonset = 1;
											end;
										end;
									end;
								end;
							end;
						elseif (GDL_Setitem_tabelname[i] == "T4" ) then
							for l=29753, 29767 ,1 do
								if (DKP_ITEMS[key]["Items"][k].name == GDL_T4[l][3] or DKP_ITEMS[key]["Items"][k].name == GDL_T4[l][2]) then
									getnonset = 2;
									id = l;

								end;
							end;
						elseif (GDL_Setitem_tabelname[i] == "T5" ) then
							for l=30236, 30250 ,1 do
								if (DKP_ITEMS[key]["Items"][k].name == GDL_T5[l][3] or DKP_ITEMS[key]["Items"][k].name == GDL_T5[l][2]) then
									getnonset = 2;
									id = l;
								end;
							end;
						elseif (GDL_Setitem_tabelname[i] == "T6" ) then
							for l=31089, 31103 ,1 do
								if (DKP_ITEMS[key]["Items"][k].name == GDL_T6[l][3] or DKP_ITEMS[key]["Items"][k].name == GDL_T6[l][2]) then
									getnonset = 2;
									id = l;
								end;
							end;
						end;
					end;
					end;
					if (id == 0 and getnonset ~= 2) then
						if (getdkp_itemids) then
							if (getdkp_itemids[DKP_ITEMS[key]["Items"][k].name] ~= nil) then
								id = getdkp_itemids[DKP_ITEMS[key]["Items"][k].name];

							end;
						end;
						if (ItemLinks and id == 0) then
							if	(ItemLinks[DKP_ITEMS[key]["Items"][k].name] ~= nil) then
								id = strsplit(":",ItemLinks[DKP_ITEMS[key]["Items"][k].name].i);

							end;
						end;
						if (id == 0) then
							if(GetItemInfo(DKP_ITEMS[key]["Items"][k].name))then
								itemName, itemLink = GetItemInfo(DKP_ITEMS[key]["Items"][k].name);
								local found, _, itemString = string.find(itemLink, "^|c%x+|H(.+)|h%[.+%]")
								local linkType, itemId = strsplit(":", itemString)
								id = itemId;
							end;
						end;
					end;

					if (id ~= nil) then
						if(GetItemInfo(id))then
							itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTexture = GetItemInfo(id);
							texture = itemTexture;

							quality = itemQuality;
							_, _, _, itemColor = GetItemQualityColor(itemQuality);
							color = itemColor;
						else
							texture = "Interface\\Icons\\INV_Misc_QuestionMark";
							color= "|cffffffff";
							qualitiy= 0;
						end;
					end;
					if (getnonset == 0) then
						tinsert(GDL_NonSetItems, {name = key; class = class; nonsetitem = DKP_ITEMS[key]["Items"][k].name; nonsetitemdkp = DKP_ITEMS[key]["Items"][k].dkp; nonsetitemid = id; nonsetitemquality = quality; nonsetitemcolor= color; nonsetitemtexture = texture;});
					elseif(getnonset == 1) then
						tinsert(GDL_SetQuestItems, {name = key; class = class; questitem = DKP_ITEMS[key]["Items"][k].name; questitemdkp = DKP_ITEMS[key]["Items"][k].dkp; questitemid = id; questitemquality = quality; questitemcolor= color; questitemtexture = texture;});
					elseif(getnonset == 2) then

						tinsert(GDL_SetNonSetItems, {name = key; class = class; questitem = DKP_ITEMS[key]["Items"][k].name; setnonsetitemdkp = DKP_ITEMS[key]["Items"][k].dkp; setnonsetitenid = id; setnonsetitemquality = quality; setnonsetitemcolor= color; setnonsetitemtexture = texture;});
					end;
				end;
			end;
		end;
		GetDKP_List_VarUpdate();
	end;
end;

-----------------------------
-- GetDKP Plus List Update --
-----------------------------
function GetDKP_List_VarUpdate()
	if (GDKP_VERSION >= "2.4" and gdkp ~= nil) then
		if (table.getn (multiTable) == 1) then
			getglobal("GDL_Playerlist_FrameColumnHeader4"):Hide();
			getglobal("GDL_Playerlist_FrameColumnHeader3"):Hide();
			getglobal("GDL_Playerlist_FrameColumnHeader5"):Show();
			getglobal("GDL_Playerlist_FrameColumnHeader5"):SetText("DKP");
			for i = 1,GDL_TO_DISPLAY,1 do
				getglobal("GDL_Playerlist_FrameButton"..i.."DKP_Atrib"):Hide();
			end;
		end;
		GDL_Players = {};
		for key, val in pairs(gdkp.players) do
			if (table.getn (multiTable) > 1) then
				if (GDL_Playerlist_EditBox:GetText() == "") then
					if (GDKPvar_save.ShowOnlyInRaid == "true" and GetDKP_List_CheckifPlayerIsInRaid(key) == true) then
						if (GDL_CLASS_ID_NUM < 12) then
							if (GDL_CLASS_ID == "Alle" or GDL_CLASS_ID == "All" or GDL_SetClass(GDL_CLASS_ID) == GDL_SetClass(val.class)) then
								tinsert (GDL_Players, {name = key; class = val.class; dkp = val.DKP; current = val[GDL_DKP_LIST.."_current"]; current2 = val[GDL_DKP_LIST.."_"..GDL_DKP_LIST_Atrib]; adjust = val[GDL_DKP_LIST.."_adjust"]; spend = val[GDL_DKP_LIST.."_spend"]; earned = val[GDL_DKP_LIST.."_earned"];});
							end;
						else
							i = GDL_CLASS_ID_NUM - 11;
							for j = 1,table.getn(GDKP_Special_Class[i]),1 do

								if ( GDL_SetClass(GDKP_Special_Class[i][j]) ==  GDL_SetClass(val.class)) then
									tinsert (GDL_Players, {name = key; class = val.class; dkp = val.DKP; current = val[GDL_DKP_LIST.."_current"]; current2 = val[GDL_DKP_LIST.."_"..GDL_DKP_LIST_Atrib]; adjust = val[GDL_DKP_LIST.."_adjust"]; spend = val[GDL_DKP_LIST.."_spend"]; earned = val[GDL_DKP_LIST.."_earned"];});
								end;
							end;
						end;
					elseif (GDKPvar_save.ShowOnlyInRaid == "false") then
						if (GDL_CLASS_ID_NUM < 12) then
							if (GDL_CLASS_ID == "Alle" or GDL_CLASS_ID == "All" or GDL_SetClass(GDL_CLASS_ID) == GDL_SetClass(val.class)) then
								tinsert (GDL_Players, {name = key; class = val.class; dkp = val.DKP; current = val[GDL_DKP_LIST.."_current"]; current2 = val[GDL_DKP_LIST.."_"..GDL_DKP_LIST_Atrib]; adjust = val[GDL_DKP_LIST.."_adjust"]; spend = val[GDL_DKP_LIST.."_spend"]; earned = val[GDL_DKP_LIST.."_earned"];});
							end;
						else
							i = GDL_CLASS_ID_NUM - 11;
							for j = 1,table.getn(GDKP_Special_Class[i]),1 do

								if ( GDL_SetClass(GDKP_Special_Class[i][j]) ==  GDL_SetClass(val.class)) then
									tinsert (GDL_Players, {name = key; class = val.class; dkp = val.DKP; current = val[GDL_DKP_LIST.."_current"]; current2 = val[GDL_DKP_LIST.."_"..GDL_DKP_LIST_Atrib]; adjust = val[GDL_DKP_LIST.."_adjust"]; spend = val[GDL_DKP_LIST.."_spend"]; earned = val[GDL_DKP_LIST.."_earned"];});
								end;
							end;
						end;
					end;
				else
					local _args = GDKP_GetArgs(GDL_Playerlist_EditBox:GetText(),",");
					for j = 1,table.getn(_args),1 do
						if ( string.lower(_args[j]) == string.lower(key)) then
							tinsert (GDL_Players, {name = key; class = val.class; dkp = val.DKP; current = val[GDL_DKP_LIST.."_current"]; current2 = val[GDL_DKP_LIST.."_"..GDL_DKP_LIST_Atrib]; adjust = val[GDL_DKP_LIST.."_adjust"]; spend = val[GDL_DKP_LIST.."_spend"]; earned = val[GDL_DKP_LIST.."_earned"];});
						end;
					end;
				end;
			else
				GDL_DKP_LIST = table.foreach(multiTable[1], VarReturn) ;
				if (GDL_Playerlist_EditBox:GetText() == "") then
					if (GDKPvar_save.ShowOnlyInRaid == "true" and GetDKP_List_CheckifPlayerIsInRaid(key) == true) then
						if (GDL_CLASS_ID_NUM < 12) then
							if (GDL_CLASS_ID == "Alle" or GDL_CLASS_ID == "All" or GDL_SetClass(GDL_CLASS_ID) == GDL_SetClass(val.class)) then
								tinsert (GDL_Players, {name = key; class = val.class; dkp = val.DKP; current = val[GDL_DKP_LIST.."_current"]; current2 = val[GDL_DKP_LIST.."_"..GDL_DKP_LIST_Atrib]; adjust = val[GDL_DKP_LIST.."_adjust"]; spend = val[GDL_DKP_LIST.."_spend"]; earned = val[GDL_DKP_LIST.."_earned"];});
							end;
						else
							i = GDL_CLASS_ID_NUM - 11;
							for j = 1,table.getn(GDKP_Special_Class[i]),1 do
								if ( GDL_SetClass(GDKP_Special_Class[i][j]) ==  GDL_SetClass(val.class)) then
									tinsert (GDL_Players, {name = key; class = val.class; dkp = val.DKP; current = val[GDL_DKP_LIST.."_current"]; current2 = val[GDL_DKP_LIST.."_"..GDL_DKP_LIST_Atrib]; adjust = val[GDL_DKP_LIST.."_adjust"]; spend = val[GDL_DKP_LIST.."_spend"]; earned = val[GDL_DKP_LIST.."_earned"];});
								end;
							end;
						end;
					elseif (GDKPvar_save.ShowOnlyInRaid == "false") then
						if (GDL_CLASS_ID_NUM < 12) then
							if (GDL_CLASS_ID == "Alle" or GDL_CLASS_ID == "All" or GDL_SetClass(GDL_CLASS_ID) == GDL_SetClass(val.class)) then
								tinsert (GDL_Players, {name = key; class = val.class; dkp = val.DKP; current = val[GDL_DKP_LIST.."_current"]; current2 = val[GDL_DKP_LIST.."_"..GDL_DKP_LIST_Atrib]; adjust = val[GDL_DKP_LIST.."_adjust"]; spend = val[GDL_DKP_LIST.."_spend"]; earned = val[GDL_DKP_LIST.."_earned"];});
							end;
						else
							i = GDL_CLASS_ID_NUM - 11;
							for j = 1,table.getn(GDKP_Special_Class[i]),1 do
								if ( GDL_SetClass(GDKP_Special_Class[i][j]) ==  GDL_SetClass(val.class)) then
									tinsert (GDL_Players, {name = key; class = val.class; dkp = val.DKP; current = val[GDL_DKP_LIST.."_current"]; current2 = val[GDL_DKP_LIST.."_"..GDL_DKP_LIST_Atrib]; adjust = val[GDL_DKP_LIST.."_adjust"]; spend = val[GDL_DKP_LIST.."_spend"]; earned = val[GDL_DKP_LIST.."_earned"];});
								end;
							end;
						end;
					end;
				else
					local _args = GDKP_GetArgs(GDL_Playerlist_EditBox:GetText(),",");
					for j = 1,table.getn(_args),1 do
						if ( string.lower(_args[j]) == string.lower(key)) then
							tinsert (GDL_Players, {name = key; class = val.class; dkp = val.DKP; current = val[GDL_DKP_LIST.."_current"]; current2 = val[GDL_DKP_LIST.."_"..GDL_DKP_LIST_Atrib]; adjust = val[GDL_DKP_LIST.."_adjust"]; spend = val[GDL_DKP_LIST.."_spend"]; earned = val[GDL_DKP_LIST.."_earned"];});
						end;
					end;
				end;
			end;

		end;
	end;

end;

-----------------------------
-- GetDKP Plus List Toggle --
-----------------------------
function GetDKP_List_Toggle()
	if (type(GDKPvar_save) == "table") then
		GDL_Scale = (GDKPvar_save.Scaling_GDL / 100);
	end;

		if (GetDKP_List_Frame:IsVisible()) then
			GetDKP_List_Frame:Hide();
		else
			GetDKP_List_Frame:SetAlpha(0.0);
			GDL_Playerlist_Frame:SetAlpha(0.0);
			GetDKP_List_Frame:Show();
			GDL_Playerlist_Frame:Show();
			GetDKP_List_Frame_Show = 1;
			unsavedscale = 1 - UIParent:GetEffectiveScale() + GDL_Scale;
			GetDKP_List_Frame:SetScale(unsavedscale);
			GDL_Playerlist_Refresh();
			GDLFrameTitleText:SetFont("Interface\\AddOns\\GetDKP\\Font\\MORPHEUS.TTF", 18,"OUTLINE, MONOCHROME");
		end;

end;
function GetDKP_List_OnUpdate(this, elapsed)
	this.TimeSinceLastUpdate = this.TimeSinceLastUpdate + elapsed;

  if (this.TimeSinceLastUpdate > GDL_UpdateInterval and GetDKP_List_Frame:GetAlpha() < 1 ) then
	a = GetDKP_List_Frame:GetAlpha();
	a = a + 0.1;
	GetDKP_List_Frame:SetAlpha(a);
	GDL_Playerlist_Frame:SetAlpha(a);
	this.TimeSinceLastUpdate = 0;
  end
end;

function GetDKP_List_ButtonToggle()
	if 	(GDL_Playerlist_ShowItemButton["status"] == "set") then
		getglobal("GDL_Playerlist_ShowItemButton").status = "nonset";
		GDL_Playerlist_ShowItemButton:SetText(GDL_SHOWITEM);
		GDL_Itemlist_Frame:Hide();
		GDL_NonsetItemlist_Frame:Hide();
		GDL_Itemlist_Frame_Show = hide;

	else
		getglobal("GDL_Playerlist_ShowItemButton").status = "set";
		GDL_Playerlist_ShowItemButton:SetText(GDL_NONSETITEM);
		GDL_Itemlist_Frame:Hide();
		GDL_NonsetItemlist_Frame:Hide();
		GDL_Itemlist_Frame_Show = hide;

	end;
end;
function GetDKP_List_InRaidButtonToggle()
	if 	(GDL_Playerlist_InRaidButton["status"] == "notinraid") then
		getglobal("GDL_Playerlist_InRaidButton").status = "inraid";
		GDL_Playerlist_InRaidButton:SetText(GDL_INRAID);
		GDKPvar_save["ShowOnlyInRaid"] = "true";
		GetDKP_List_VarLoad();
		GDL_Playerlist_Update();
	else
		getglobal("GDL_Playerlist_InRaidButton").status = "notinraid";
		GDL_Playerlist_InRaidButton:SetText(GDL_NOTINRAID);
		GDKPvar_save["ShowOnlyInRaid"] = "false";
		GetDKP_List_VarLoad();
		GDL_Playerlist_Update();
	end;
end;

------------------------------
-- GetDKP Plus List Refresh --
------------------------------
function GDL_Playerlist_Refresh()
	GDL_Players = nil;
	GDL_NonSetItems = nil;
	GDL_SetNonSetItems = nil;
	GDL_SetQuestItems = nil;
	GDL_NonSetItems = {};
	GDL_SetNonSetItems = {};
	GDL_SetQuestItems = {};
	GDL_Players = {};
	--GDL_Playerlist_FrameClassDropDown_OnLoad();
	--GDL_Playerlist_FrameKontoDropDown_OnLoad();
	--GDL_Playerlist_FrameKontoAtribDropDown_OnLoad();
	GetDKP_List_VarLoad();
	GDL_Playerlist_Update();

end;

-----------------------------
-- GetDKP Plus List Column --
-----------------------------
function GDL_Playerlist_FrameColumn_SetWidth(width, frame)
	if ( not frame ) then
		frame = this;
	end;
	frame:SetWidth(width);
	getglobal(frame:GetName().."Middle"):SetWidth(width - 9);
end;

--------------------------------
-- GetDKP Plus List RaidCheck --
--------------------------------
function GetDKP_List_CheckifPlayerIsInRaid(msg)
local areturn = false ;

	if msg == nil or msg == "" then
		return areturn
	else
		if  GetNumGroupMembers()  > 0 then		--Raid exists
			for i = 1,GetNumGroupMembers() do

								local LocalUsername, LocalUserrealm = strsplit("-", msg, 2);

				if GetRaidRosterInfo(i) ~= nil then
					if string.lower(msg) == string.lower(GetRaidRosterInfo(i)) then
						areturn = true ;
					end;
					if string.lower(LocalUsername) == string.lower(GetRaidRosterInfo(i)) then
						areturn = true ;
					end;
				end;
			end;
		else
			areturn = true ;					--display everything when not in a raid
		end;
	end;

return areturn
end;

------------------------------------------------
-- GetDKP Plus List Playerlist Dropdown Class --
------------------------------------------------
function GDL_Playerlist_FrameClassDropDown_Initialize()
	local info;
	---------- All ---------------------------
	if ( GetLocale() == "deDE" ) then
		info = {
			text = "Alle";

			func = GDL_Playerlist_FrameClassDropDown_OnClick;
		};
	else
		info = {
			text = "All";

			func = GDL_Playerlist_FrameClassDropDown_OnClick;
		};
	end;
	UIDropDownMenu_AddButton(info);
	---------- Singel Class -----------------
	for key, val in pairs(GDKP_Search_SETS) do
		if ( GetLocale() == "deDE" ) then
			info = {
			text = val["Class_DE"];

			func = GDL_Playerlist_FrameClassDropDown_OnClick;
			};
			UIDropDownMenu_AddButton(info);
		else
			info = {
			text = val["Class_ENG"];

			func = GDL_Playerlist_FrameClassDropDown_OnClick;
			};
			UIDropDownMenu_AddButton(info);
		end;
	end;
	--------Special Class Grp --------------
	spclass = "";
	for i = 1,table.getn(GDKP_Special_Class),1 do
		for j = 1,table.getn(GDKP_Special_Class[i]),1 do
			if ( GetLocale() == "deDE" ) then
				class = GDKP_Special_Class[i][j];
			else
				class = GDL_SetClass(GDKP_Special_Class[i][j]);
			end;
			spclass = spclass..class..",";
		end;

		info = {
			text = spclass;

			func = GDL_Playerlist_FrameClassDropDown_OnClick;
			};
			UIDropDownMenu_AddButton(info);
		spclass = "";
	end;
end;

function GDL_Playerlist_FrameClassDropDown_OnLoad(this)
	UIDropDownMenu_Initialize(this, GDL_Playerlist_FrameClassDropDown_Initialize);
	if ( GetLocale() == "deDE" ) then
		GDL_Playerlist_FrameClassDropDown_SetSelectedID(GDL_Playerlist_FrameClassDropDown, 1, GDL_Class [1][1]);
	else
		GDL_Playerlist_FrameClassDropDown_SetSelectedID(GDL_Playerlist_FrameClassDropDown, 1, GDL_Class [2][1]);
	end;
	UIDropDownMenu_SetWidth(GDL_Playerlist_FrameClassDropDown,100);
	UIDropDownMenu_SetButtonWidth(GDL_Playerlist_FrameClassDropDown,24);
	UIDropDownMenu_JustifyText(GDL_Playerlist_FrameClassDropDown,"LEFT")
end;

function GDL_Playerlist_FrameClassDropDown_OnClick(this, button)
	GDL_Playerlist_FrameClassDropDown_DDID = this:GetID();

	if ( GetLocale() == "deDE" ) then
		if (GDL_Playerlist_FrameClassDropDown_DDID < 12) then
			GDL_Playerlist_FrameClassDropDown_SetSelectedID(GDL_Playerlist_FrameClassDropDown, GDL_Playerlist_FrameClassDropDown_DDID, GDL_Class [1][GDL_Playerlist_FrameClassDropDown_DDID]);
			GDL_CLASS_ID = GDL_Class [1][GDL_Playerlist_FrameClassDropDown_DDID];
			GDL_CLASS_ID_NUM = 1;
		else
			spclass = "";
			i = GDL_Playerlist_FrameClassDropDown_DDID - 11;
			for j = 1,table.getn(GDKP_Special_Class[i]),1 do
				class = GDKP_Special_Class[i][j];
				spclass = spclass..class..",";
			end;
			GDL_Playerlist_FrameClassDropDown_SetSelectedID(GDL_Playerlist_FrameClassDropDown, GDL_Playerlist_FrameClassDropDown_DDID, spclass);
			GDL_CLASS_ID_NUM = GDL_Playerlist_FrameClassDropDown_DDID;
		end;
	else
		if (GDL_Playerlist_FrameClassDropDown_DDID < 12) then
			GDL_Playerlist_FrameClassDropDown_SetSelectedID(GDL_Playerlist_FrameClassDropDown, GDL_Playerlist_FrameClassDropDown_DDID, GDL_Class [2][GDL_Playerlist_FrameClassDropDown_DDID]);
			GDL_CLASS_ID = GDL_Class [2][GDL_Playerlist_FrameClassDropDown_DDID];
			GDL_CLASS_ID_NUM = 1;
		else
			spclass = "";
			i = GDL_Playerlist_FrameClassDropDown_DDID - 11;
			for j = 1,table.getn(GDKP_Special_Class[i]),1 do
				class = GDL_SetClass(GDKP_Special_Class[i][j]);
				spclass = spclass..class..",";
			end;
			GDL_Playerlist_FrameClassDropDown_SetSelectedID(GDL_Playerlist_FrameClassDropDown, GDL_Playerlist_FrameClassDropDown_DDID, spclass);
			GDL_CLASS_ID_NUM = GDL_Playerlist_FrameClassDropDown_DDID;
		end;
	end;
	FauxScrollFrame_SetOffset(GDL_Playerlist_ScrollFrame, 0);
	GetDKP_List_VarUpdate();
	GDL_Playerlist_Update();

end;

function GDL_Playerlist_FrameClassDropDown_SetSelectedID(frame, id, names)
	UIDropDownMenu_SetSelectedID(frame, id);
	if( not frame ) then
		frame = this;
	end;
	UIDropDownMenu_SetText(frame, names);
end;

------------------------------------------------
-- GetDKP Plus List Playerlist Dropdown Konto --
------------------------------------------------
function GDL_Playerlist_FrameKontoDropDown_Initialize()
	local info, tmpvarname;
	if (multiTable) then
		for i=1,table.getn(multiTable),1 do
			tmpvarname = table.foreach(multiTable[i], VarReturn);
			info = {
				value	= tmpvarname;
				text	= multiTable[i][tmpvarname]["name"];
				func	= GDL_Playerlist_FrameKontoDropDown_OnClick;
				};
			UIDropDownMenu_AddButton(info);
		end;
	end;
end;

function GDL_Playerlist_FrameKontoDropDown_OnLoad(this)
	if (multiTable) then
		i = 1 ;
		UIDropDownMenu_Initialize(this, GDL_Playerlist_FrameKontoDropDown_Initialize);
		if (table.getn(multiTable) == 1) then
			GDL_Playerlist_FrameKontoDropDown_SetSelectedID(GDL_Playerlist_FrameKontoDropDown, 1, table.foreach(multiTable[i], VarReturn));
			GDL_Playerlist_FrameKontoDropDown_DDID = 1;
			GDL_DKP_LIST = table.foreach(multiTable[GDL_Playerlist_FrameKontoDropDown_DDID], VarReturn);
		else
			kontofound = 1;
			for i=1,table.getn(multiTable),1 do
				if table.foreach(multiTable[i], VarReturn) == GDKPvar_save["konto"] then
					kontofound = i;
				end;
			end;
			GDL_Playerlist_FrameKontoDropDown_SetSelectedID(GDL_Playerlist_FrameKontoDropDown, kontofound, table.foreach(multiTable[kontofound], VarReturn));
			GDL_Playerlist_FrameKontoDropDown_DDID = kontofound;
		end;
		GDL_DKP_LIST = table.foreach(multiTable[GDL_Playerlist_FrameKontoDropDown_DDID], VarReturn);
		GDLFrameKontoText:SetText(GDL_DKP_LIST..GDL_Events);
		if ( strlen(multiTable[GDL_Playerlist_FrameKontoDropDown_DDID][GDL_DKP_LIST].events) >= 40) then
			text = string.sub(multiTable[GDL_Playerlist_FrameKontoDropDown_DDID][GDL_DKP_LIST].events ,0,40).." ...";
		else
			text = multiTable[GDL_Playerlist_FrameKontoDropDown_DDID][GDL_DKP_LIST].events;
		end;
		GDLFrameKontoEvent:SetText(text);
		--FauxScrollFrame_SetOffset(GDL_Playerlist_ScrollFrame, 0)
		--GetDKP_List_VarUpdate();
		--GDL_Playerlist_Update();
	end;

		UIDropDownMenu_SetWidth(GDL_Playerlist_FrameKontoDropDown,60);
		UIDropDownMenu_SetButtonWidth(GDL_Playerlist_FrameKontoDropDown,24);
		UIDropDownMenu_JustifyText(GDL_Playerlist_FrameKontoDropDown,"LEFT")
end;

function GDL_Playerlist_FrameKontoDropDown_OnClick(this, button)
	GDL_Playerlist_FrameKontoDropDown_DDID = this:GetID();
	GDL_Playerlist_FrameKontoDropDown_SetSelectedID(GDL_Playerlist_FrameKontoDropDown, GDL_Playerlist_FrameKontoDropDown_DDID, table.foreach(multiTable[GDL_Playerlist_FrameKontoDropDown_DDID], VarReturn));
	GDL_DKP_LIST = table.foreach(multiTable[GDL_Playerlist_FrameKontoDropDown_DDID], VarReturn);
	GDLFrameKontoText:SetText(GDL_DKP_LIST..GDL_Events);
	if ( strlen(multiTable[GDL_Playerlist_FrameKontoDropDown_DDID][GDL_DKP_LIST].events) >= 40) then
		text = string.sub(multiTable[GDL_Playerlist_FrameKontoDropDown_DDID][GDL_DKP_LIST].events ,0,40).." ...";
	else
		text = multiTable[GDL_Playerlist_FrameKontoDropDown_DDID][GDL_DKP_LIST].events;
	end;
	GDLFrameKontoEvent:SetText(text);
	FauxScrollFrame_SetOffset(GDL_Playerlist_ScrollFrame, 0)
	GetDKP_List_VarUpdate();
	GDL_Playerlist_Update();
end;

function GDL_Playerlist_FrameKontoDropDown_SetSelectedID(frame, id, names)
	UIDropDownMenu_SetSelectedID(frame, id);
	if( not frame ) then
		frame = this;
	end;
	UIDropDownMenu_SetText(frame, names);
end;

-----------------------------------------------------
-- GetDKP Plus List Playerlist Dropdown KontoAtrib --
-----------------------------------------------------
function GDL_Playerlist_FrameKontoAtribDropDown_Initialize()
	local info;

	for i=1,4,1 do
		info = {
			text = GDL_Konto_Atrib[i];
			func = GDL_Playerlist_FrameKontoAtribDropDown_OnClick;
			};
		UIDropDownMenu_AddButton(info);
	end;
end;

function GDL_Playerlist_FrameKontoAtribDropDown_OnLoad(this)
	i = 1 ;
	UIDropDownMenu_Initialize(this, GDL_Playerlist_FrameKontoAtribDropDown_Initialize);
	GDL_Playerlist_FrameKontoAtribDropDown_SetSelectedID(GDL_Playerlist_FrameKontoAtribDropDown, 1, GDL_Konto_Atrib[i]);
	UIDropDownMenu_SetWidth(GDL_Playerlist_FrameKontoAtribDropDown,65);
	UIDropDownMenu_SetButtonWidth(GDL_Playerlist_FrameKontoAtribDropDown,24);
	UIDropDownMenu_JustifyText(GDL_Playerlist_FrameKontoAtribDropDown,"LEFT")
end;

function GDL_Playerlist_FrameKontoAtribDropDown_OnClick(this, button)
	GDL_Playerlist_FrameKontoAtribDropDown_DDID = this:GetID();
	GDL_Playerlist_FrameKontoAtribDropDown_SetSelectedID(GDL_Playerlist_FrameKontoAtribDropDown, GDL_Playerlist_FrameKontoAtribDropDown_DDID, GDL_Konto_Atrib[GDL_Playerlist_FrameKontoAtribDropDown_DDID]);
	GDL_DKP_LIST_Atrib = GDL_Konto_Atrib[GDL_Playerlist_FrameKontoAtribDropDown_DDID];
	FauxScrollFrame_SetOffset(GDL_Playerlist_ScrollFrame, 0)
	GetDKP_List_VarUpdate();
	GDL_Playerlist_Update();
end;

function GDL_Playerlist_FrameKontoAtribDropDown_SetSelectedID(frame, id, names)
	UIDropDownMenu_SetSelectedID(frame, id);
	if( not frame ) then
		frame = this;
	end;
	UIDropDownMenu_SetText(frame, names);
end;

-----------------------------------------
-- GetDKP Plus List Playerlist EditBox --
-----------------------------------------
function GDL_Playerlist_EditBox_OnEnterPressed()
	GetDKP_List_VarUpdate();
	GDL_Playerlist_Update();
end;

----------------------------------------------
-- GetDKP Plus List Playerlist Scrollframe --
----------------------------------------------
function GDL_Playerlist_Update(spclassid)

	local GDL_Playerlist_Offset = FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame);
	local GDL_Playerlist_Index;
	GDL_Count = table.getn (GDL_Players);

	for i=1, GDL_TO_DISPLAY, 1 do

		GDL_Playerlist_Index = GDL_Playerlist_Offset + i;
		prefix = "GDL_Playerlist_FrameButton"..i;
		button = getglobal(prefix);
		button.GDL_Playerlist_Index = GDL_Playerlist_Index;
		if ( i <= GDL_Count ) then
			for j = 1,13,1 do
				if (GDL_Players[GDL_Playerlist_Index].class == GDL_Classes[j][1] or GDL_Players[GDL_Playerlist_Index].class == GDL_Classes[j][2]) then
					getglobal(prefix.."Name"):SetTextColor(GDL_Classes[j][3], GDL_Classes[j][4], GDL_Classes[j][5]);
					getglobal(prefix.."Class"):SetTextColor(GDL_Classes[j][3], GDL_Classes[j][4], GDL_Classes[j][5]);
					getglobal(prefix.."DKP"):SetTextColor(GDL_Classes[j][3], GDL_Classes[j][4], GDL_Classes[j][5]);
					getglobal(prefix.."DKP_Atrib"):SetTextColor(GDL_Classes[j][3], GDL_Classes[j][4], GDL_Classes[j][5]);
					break;
				end;
			end;
				getglobal(prefix.."Name"):SetText(GDL_Players[GDL_Playerlist_Index].name);
				if ( GetLocale() == "deDE" ) then
					getglobal(prefix.."Class"):SetText(GDL_Players[GDL_Playerlist_Index].class);
				else
					getglobal(prefix.."Class"):SetText(GDL_SetClass(GDL_Players[GDL_Playerlist_Index].class));
				end;
				getglobal(prefix.."DKP"):SetText(GDL_Players[GDL_Playerlist_Index].current);
				getglobal(prefix.."DKP_Atrib"):SetText(GDL_Players[GDL_Playerlist_Index].current2);
		end;
		if ( GDL_Playerlist_Index > GDL_Count ) then
			button:LockHighlight();
			button:Hide();
		else
			button:UnlockHighlight();
			button:Show();
		end
	end;
	FauxScrollFrame_Update(GDL_Playerlist_ScrollFrame,GDL_Count,GDL_TO_DISPLAY,8);
end;

--------------------------------------
-- GetDKP Plus List Playerlist SORT --
--------------------------------------
function GDL_Sort (value,button)

	if (button == "RightButton") then
		for i = 1, table.getn (GDL_Players) ,1 do
			if (GDKPvar_save.reportChannel == "lokal") then
				print("<GetDKP> "..GDL_Players[i]["name"].." "..GDL_Players[i]["class"].." "..GDL_Players[i]["current"]);
			else
				SendChatMessage("<GetDKP> "..GDL_Players[i]["name"].." "..GDL_Players[i]["class"].." "..GDL_Players[i]["current"],GDKPvar_save.reportChannel);
			end;
		end;
	elseif (button == "LeftButton") then
		if (value == 1) then
			if (GDL_S1 == "down") then
				GDL_S1 = "up";
				for i = 1, table.getn (GDL_Players) ,1 do
					for j = 1, table.getn (GDL_Players) ,1 do
						if (GDL_Players[j]["name"] > GDL_Players[i]["name"]) then
							test = GDL_Players[j];
							GDL_Players[j] = GDL_Players[i];
							GDL_Players[i] = test;
						end;

					end;
				end;
			elseif (GDL_S1 == "up") then
				GDL_S1 = "down";
				for i = 1, table.getn (GDL_Players) ,1 do
					for j = 1, table.getn (GDL_Players) ,1 do
						if (GDL_Players[j]["name"] < GDL_Players[i]["name"]) then
							test = GDL_Players[j];
							GDL_Players[j] = GDL_Players[i];
							GDL_Players[i] = test;
						end;

					end;
				end;
			end;
		end;
		if (value == 2) then
			if (GDL_S2 == "down") then
				GDL_S2 = "up";
				for i = 1, table.getn (GDL_Players) ,1 do
					for j = 1, table.getn (GDL_Players) ,1 do
						if (GDL_Players[j]["class"] > GDL_Players[i]["class"]) then
							test = GDL_Players[j];
							GDL_Players[j] = GDL_Players[i];
							GDL_Players[i] = test;
						end;

					end;
				end;
			elseif (GDL_S2 == "up") then
				GDL_S2 = "down";
				for i = 1, table.getn (GDL_Players) ,1 do
					for j = 1, table.getn (GDL_Players) ,1 do
						if (GDL_Players[j]["class"] < GDL_Players[i]["class"]) then
							test = GDL_Players[j];
							GDL_Players[j] = GDL_Players[i];
							GDL_Players[i] = test;
						end;

					end;
				end;
			end;
		end;
		if (value == 3) then
			if (GDL_S3 == "down") then
				GDL_S3 = "up";
				for i = 1, table.getn (GDL_Players) ,1 do
					for j = 1, table.getn (GDL_Players) ,1 do
						if (GDL_Players[j]["current"] > GDL_Players[i]["current"]) then
							test = GDL_Players[j];
							GDL_Players[j] = GDL_Players[i];
							GDL_Players[i] = test;
						end;

					end;
				end;
			elseif (GDL_S3 == "up") then
				GDL_S3 = "down";
				for i = 1, table.getn (GDL_Players) ,1 do
					for j = 1, table.getn (GDL_Players) ,1 do
						if (GDL_Players[j]["current"] < GDL_Players[i]["current"]) then
							test = GDL_Players[j];
							GDL_Players[j] = GDL_Players[i];
							GDL_Players[i] = test;
						end;

					end;
				end;
			end;
		end;
		if (value == 4) then
			if (GDL_S4 == "down") then
				GDL_S4 = "up";
				for i = 1, table.getn (GDL_Players) ,1 do
					for j = 1, table.getn (GDL_Players) ,1 do
						if (GDL_Players[j]["current2"] > GDL_Players[i]["current2"]) then
							test = GDL_Players[j];
							GDL_Players[j] = GDL_Players[i];
							GDL_Players[i] = test;
						end;

					end;
				end;
			elseif (GDL_S4 == "up") then
				GDL_S4 = "down";
				for i = 1, table.getn (GDL_Players) ,1 do
					for j = 1, table.getn (GDL_Players) ,1 do
						if (GDL_Players[j]["current2"] < GDL_Players[i]["current2"]) then
							test = GDL_Players[j];
							GDL_Players[j] = GDL_Players[i];
							GDL_Players[i] = test;
						end;

					end;
				end;
			end;
		end;

	end;
	GDL_Playerlist_Update();
end;

----------------------
-- GDL_Setitem_List --
----------------------
function GDL_Itemlist_NextSet()
	if (GDL_Itemlist_SetID < getn(GDL_Setitem_tabelname)) then
		GDL_Itemlist_SetID = GDL_Itemlist_SetID + 1;
	end;
	if (GDL_Itemlist_SetID == 9) then
		GDL_Itemlist_FrameHelpToggleButtonNext:Disable();
	else
		GDL_Itemlist_FrameHelpToggleButtonNext:Enable();
	end;
	GDL_Itemlist_FrameHelpToggleButtonPrev:Enable();
	for i=1,19,1 do
		getglobal("GDL_Itemlist_FrameItem"..i.."_Icon"):SetTexture();
	end;
	GDL_Itemlist_Toggle(0,GDL_Itemlist_FrameTitleText.id,GDL_Itemlist_FrameTitleText.class);
end;
function GDL_Itemlist_PrevSet()
	if (GDL_Itemlist_SetID > 1) then
		GDL_Itemlist_SetID = GDL_Itemlist_SetID - 1;
	end;
	if (GDL_Itemlist_SetID == 1) then
		GDL_Itemlist_FrameHelpToggleButtonPrev:Disable();
	else
		GDL_Itemlist_FrameHelpToggleButtonPrev:Enable();
	end;
	for i=1,19,1 do
		getglobal("GDL_Itemlist_FrameItem"..i.."_Icon"):SetTexture();
	end;
	GDL_Itemlist_FrameHelpToggleButtonNext:Enable();
	GDL_Itemlist_Toggle(0,GDL_Itemlist_FrameTitleText.id,GDL_Itemlist_FrameTitleText.class);
end;
function GDL_Model_Scale ()
	if (GDL_Itemlist_Frame:IsVisible()) then
		GDL_Itemlist_Frame:Hide();
		GDL_Itemlist_Frame:Show();
	end;
end;

-- function GDL_Itemlist_Toggle(button,var,class,item)
	-- if (button == "RightButton" or GDKPvar_save["ShowItems"] == "false") then
		-- class = GDL_SetClass (GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].class);
		-- name = GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name;
		-- current = GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].current;
		-- if (GDKPvar_save.reportChannel == "lokal") then
			-- print("<GetDKP> "..name.." "..class.." "..current);
		-- else
			-- SendChatMessage("<GetDKP> "..name.." "..class.." "..current,GDKPvar_save.reportChannel);
		-- end;
	-- else
		-- if 	(GDL_Playerlist_ShowItemButton["status"] == "set") then
				-- if ( not GDL_Itemlist_Frame:IsVisible() ) then
					-- GDL_Itemlist_Frame:Show();
					-- GDL_NonsetItemlist_Frame:Hide();
					-- GDL_Itemlist_SetID = 1;
				-- end;
				-- if (not var) then
					-- var = 1;
				-- end;
				-- class = GDL_SetClass (GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].class);
				-- GDL_POS = 16;

				-- if (GDL_Setitem_tabelname[GDL_Itemlist_SetID] ~= "T4" and GDL_Setitem_tabelname[GDL_Itemlist_SetID] ~= "T5" and GDL_Setitem_tabelname[GDL_Itemlist_SetID] ~= "T6") then
					-- GDL_Itemlist_Tooken_Frame:Hide();
					-- GDL_Itemlist_TookenButton:Hide();
					-- GDL_Itemlist_Setname:SetText(GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]].setname[GDL_Itemlist_Locale]);
					-- GDL_Itemlist_Setname.name = GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]].setname[GDL_Itemlist_Locale];
					-- GDL_Itemlist_Setname2:SetText(GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]].setname[5].." Set");
					-- GDL_Itemlist_FrameTitleText:SetText(GDL_HEADER_SET.." "..GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name);
					-- getglobal("GDL_Itemlist_FrameTitleText").id = var;
					-- getglobal("GDL_Itemlist_FrameTitleText").class = class;
					-- getglobal("GDL_Itemlist_FrameTitleText").name = GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name;
					-- GDL_Itemlist_Model:SetUnit("player");
					-- GDL_Itemlist_Model:Undress();
					-- for i=1,19,1 do
						-- getglobal("GDL_Itemlist_FrameItem"..i.."_Tex1"):Hide();
						-- getglobal("GDL_Itemlist_FrameItem"..i.."_Tex2"):Hide();
						-- getglobal("GDL_Itemlist_FrameItem"..i.."_Extra"):SetText("");
						-- getglobal("GDL_Itemlist_FrameItem"..i.."_Icon"):SetAlpha(0.5);
						-- getglobal("GDL_Itemlist_FrameItem"..i.."_Icon").itemid  = nil;
					-- end;
					-- for itempos, itemval in pairs(GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]]) do
					-- GDL_Itemset = nil;
						-- if (itempos ~= "setname" and itempos ~= "wapponmainhand" and itempos ~= "shildhand" and itempos ~= "diztans") then
							-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon"):SetTexture("Interface\\Icons\\"..itemval[2]);
							-- --getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Name"):SetText(itemval[GDL_Itemlist_Locale]);
							-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").itemid = itemval[1];
							-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").itemname = itemval[GDL_Itemlist_Locale];
							-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").itemdkp = nil;
							-- if (DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name] ~= nil) then
								-- --------------------------------------  Tier1 und Tier2 --------------------------------------------
								-- if (GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]].setname[5] == "T1" or GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]].setname[5] == "T2") then
									-- for j = 1,getn(DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"]),1 do
										-- if (DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][j].name == itemval[GDL_Itemlist_Locale] ) then
											-- GDL_Itemset = j;
										-- end;
									-- end;
									-- if (GDL_Itemset ~= nil) then
										-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").itemdkp = DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][GDL_Itemset].dkp;
										-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon"):SetAlpha(1.0);
										-- GDL_Itemlist_Model:TryOn(itemval[1]);
										-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Extra"):SetText(DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][GDL_Itemset].dkp.." DKP");
										-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Tex1"):Show();
										-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Tex2"):Show();
									-- else
										-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Extra"):SetText("");
										-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon"):SetAlpha(0.5);
										-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").questitemid = itemval[5];
									-- end;
								-- ---------------------------------------------------Tier 3 -----------------------------------------------
								-- elseif (GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]].setname[5] == "T3") then
									-- if (itempos ~= "finger1") then
										-- for j = 1,getn(DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"]),1 do
											-- if (DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][j].name == itemval[GDL_Itemlist_Locale+3] ) then
												-- GDL_Itemset = j;
											-- end;
										-- end;
										-- if (GDL_Itemset ~= nil) then
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").itemdkp = DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][GDL_Itemset].dkp;
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon"):SetAlpha(1.0);
											-- GDL_Itemlist_Model:TryOn(itemval[1]);
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Extra"):SetText(DKP_ITEMS[DL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][GDL_Itemset].dkp.." DKP");
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Tex1"):Show();
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Tex2"):Show();
										-- else
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Extra"):SetText("");
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon"):SetAlpha(0.5);
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").questitemid = itemval[5];
										-- end;
									-- else
										-- for j = 1,getn(DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"]),1 do
											-- if (DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][j].name == itemval[GDL_Itemlist_Locale] ) then
												-- GDL_Itemset = j;
											-- end;
										-- end;
										-- if (GDL_Itemset ~= nil) then
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").itemdkp = DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][GDL_Itemset].dkp;
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon"):SetAlpha(1.0);
											-- GDL_Itemlist_Model:TryOn(itemval[1]);
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Extra"):SetText(DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][GDL_Itemset].dkp.." DKP");
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Tex1"):Show();
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Tex2"):Show();
										-- else
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Extra"):SetText("");
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon"):SetAlpha(0.5);
										-- end;
									-- end;
								-- ------------------------------------------------ Zul Gurub ---------------------------------------------------
								-- elseif (GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]].setname[5] == "Zul Gurub") then
									-- if (itempos ~= "trinket1") then
										-- for j = 1,getn(DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"]),1 do
											-- if (DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][j].name == itemval[GDL_Itemlist_Locale+3] ) then
												-- GDL_Itemset = j;
											-- end;
										-- end;
										-- if (GDL_Itemset ~= nil) then
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").itemdkp = DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][GDL_Itemset].dkp;
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon"):SetAlpha(1.0);
											-- GDL_Itemlist_Model:TryOn(itemval[1]);
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Extra"):SetText(DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][GDL_Itemset].dkp.." DKP");
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Tex1"):Show();
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Tex2"):Show();
										-- else
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Extra"):SetText("");
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon"):SetAlpha(0.5);
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").questitemid = itemval[5];
										-- end;
									-- else
										-- for j = 1,getn(DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"]),1 do
											-- if (DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][j].name == itemval[GDL_Itemlist_Locale] ) then
												-- GDL_Itemset = j;
											-- end;
										-- end;
										-- if (GDL_Itemset ~= nil) then
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").itemdkp = DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][GDL_Itemset].dkp;
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon"):SetAlpha(1.0);
											-- GDL_Itemlist_Model:TryOn(itemval[1]);
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Extra"):SetText(DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][GDL_Itemset].dkp.." DKP");
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Tex1"):Show();
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Tex2"):Show();
										-- else
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Extra"):SetText("");
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon"):SetAlpha(0.5);
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").questitemid = itemval[5];
										-- end;
									-- end;
								-- ------------------------------------------------------- AQ 20 ----------------------------------------------
								-- elseif (GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]].setname[5] == "AQ20") then
										-- for j = 1,getn(DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"]),1 do
											-- if (DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][j].name == itemval[GDL_Itemlist_Locale+3] ) then
												-- GDL_Itemset = j;
											-- end;
										-- end;
										-- if (GDL_Itemset ~= nil) then
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").itemdkp = DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"].dkp;
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon"):SetAlpha(1.0);
											-- GDL_Itemlist_Model:TryOn(itemval[1]);
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Extra"):SetText(DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"].dkp.." DKP");
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Tex1"):Show();
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Tex2"):Show();
										-- else
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Extra"):SetText("");
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon"):SetAlpha(0.5);
											-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").questitemid = itemval[5];
										-- end;
								-- ------------------------------------------------------- AQ 40 ----------------------------------------------
								-- elseif (GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]].setname[5] == "AQ40") then
										-- if (itempos == "robe" or itempos == "head" or itempos == "legs") then
											-- for j = 1,getn(DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"]),1 do
												-- if (DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][j].name == itemval[GDL_Itemlist_Locale+3] ) then
													-- GDL_Itemset = j;
												-- end;
											-- end;
											-- if (GDL_Itemset ~= nil) then
												-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").itemdkp = DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"].dkp;
												-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon"):SetAlpha(1.0);
												-- GDL_Itemlist_Model:TryOn(itemval[1]);
												-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Extra"):SetText(DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"].dkp.." DKP");
												-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Tex1"):Show();
												-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Tex2"):Show();
											-- else
												-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Extra"):SetText("");
												-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon"):SetAlpha(0.5);
												-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").questitemid = itemval[5];
											-- end;
										-- elseif (itempos == "shoulder") then
											-- i = 0;

											-- --for questval,questitem in pairs (DKP_ITEMS[string.lower(GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name)]["Items"]) do
											-- for j = 1,getn(DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"]),1 do
												-- if (DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][j].name == itemval[GDL_Itemlist_Locale+3] ) then
													-- i=i+1;
													-- if (i == 1) then
														-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").itemdkp = DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][j].dkp;
														-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon"):SetAlpha(1.0);
														-- GDL_Itemlist_Model:TryOn(itemval[1]);
														-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Extra"):SetText(DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][j].dkp.." DKP");
														-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Tex1"):Show();
														-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Tex2"):Show();
													-- end;
												-- end;
											-- end;
											-- if (i == 0) then
												-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Extra"):SetText("");
												-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon"):SetAlpha(0.5);
												-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").questitemid = itemval[5];
											-- end;
										-- elseif (itempos == "feet") then
											-- i=0;
											-- --for questval,questitem in pairs (DKP_ITEMS[string.lower(GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name)]["Items"]) do
											-- for j = 1,getn(DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"]),1 do
												-- if (DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][j].name == itemval[GDL_Itemlist_Locale+3]) then
													-- i=i+1;
													-- if (i == 2) then
														-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").itemdkp = DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][j].dkp;
														-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon"):SetAlpha(1.0);
														-- GDL_Itemlist_Model:TryOn(itemval[1]);
														-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Extra"):SetText(DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][j].dkp.." DKP");
														-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Tex1"):Show();
														-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Tex2"):Show();
													-- end;
												-- end;
											-- end;

											-- if (i ~= 2) then
												-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Extra"):SetText("");
												-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon"):SetAlpha(0.5);
												-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").questitemid = itemval[5];
											-- end;
										-- end;
								-- end;
							-- end;
						-- elseif (itempos == "wapponmainhand" or itempos == "shildhand" or itempos == "diztans") then
							-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon"):SetTexture("Interface\\Icons\\"..itemval[2]);
							-- --getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Name"):SetText(itemval[GDL_Itemlist_Locale]);
							-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").itemid = itemval[1];
							-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").itemname = itemval[GDL_Itemlist_Locale];
							-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").itemdkp = nil;
							-- for j = 1,getn(DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"]),1 do
								-- if (DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][j].name == itemval[GDL_Itemlist_Locale+3] ) then
									-- GDL_Itemset = j;
								-- end;
							-- end;
							-- if (GDL_Itemset ~= nil) then
								-- GDL_POS = GDL_POS + 1;
								-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").itemdkp = DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][GDL_Itemset].dkp;
								-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon"):SetAlpha(1.0);
								-- GDL_Itemlist_Model:TryOn(itemval[1]);
								-- getglobal("GDL_Itemlist_FrameItem"..GDL_POS.."_Extra"):SetText(GDL_WapponSide[itempos]..":"..DKP_ITEMS[GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name]["Items"][GDL_Itemset].dkp.." DKP");
								-- getglobal("GDL_Itemlist_FrameItem"..GDL_POS.."_Tex1"):Show();
								-- getglobal("GDL_Itemlist_FrameItem"..GDL_POS.."_Tex2"):Show();
							-- else
								-- getglobal("GDL_Itemlist_FrameItem"..GDL_POS.."_Extra"):SetText("");
								-- getglobal("GDL_Itemlist_FrameItem"..GDL_POS.."_Icon"):SetAlpha(0.5);
								-- getglobal("GDL_Itemlist_FrameItem"..GDL_POS.."_Icon").questitemid = itemval[5];
							-- end;

						-- end;
					-- end;
				-- elseif (GDL_Setitem_tabelname[GDL_Itemlist_SetID] == "T4" or GDL_Setitem_tabelname[GDL_Itemlist_SetID] == "T5" or GDL_Setitem_tabelname[GDL_Itemlist_SetID] == "T6") then
					-- GDL_Itemlist_Tooken_Frame:Show();
					-- GDL_Itemlist_TookenButton:Show();
					-- GDL_Itemlist_FrameTitleText:SetText(GDL_HEADER_SET.." "..GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name);
					-- getglobal("GDL_Itemlist_FrameTitleText").id = var;
					-- getglobal("GDL_Itemlist_FrameTitleText").class = class;
					-- getglobal("GDL_Itemlist_FrameTitleText").name = GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name;
					-- GDL_Itemlist_Model:SetUnit("player");
					-- GDL_Itemlist_Model:Undress();
					-- for i=1,19,1 do
						-- getglobal("GDL_Itemlist_FrameItem"..i.."_Tex1"):Hide();
						-- getglobal("GDL_Itemlist_FrameItem"..i.."_Tex2"):Hide();
						-- getglobal("GDL_Itemlist_FrameItem"..i.."_Extra"):SetText("");
						-- getglobal("GDL_Itemlist_FrameItem"..i.."_Icon"):SetAlpha(0.5);
						-- getglobal("GDL_Itemlist_FrameItem"..i.."_Icon").itemid  = nil;
					-- end;
					-- GDL_Itemlist_SetFrame_SetShow(1);
				-- end;
		-- else
			-- if ( not GDL_NonsetItemlist_Frame:IsVisible() ) then
				-- GDL_Itemlist_Frame:Hide();
				-- getglobal("GDL_NonsetItemlist_FrameTitleText").name = GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name;
				-- GDL_NonsetItemlist_Frame:Show();
			-- else
				-- getglobal("GDL_NonsetItemlist_FrameTitleText").name = GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name;
			-- end;
			-- GDL_NonsetItemlist_FrameTitleText:SetText(GDL_HEADER_NONSET.." "..GDL_Players[var+FauxScrollFrame_GetOffset(GDL_Playerlist_ScrollFrame)].name);
			-- GDL_NonsetItemlist_Upate();
		-- end;
	-- end;
-- end;

function GDL_Itemlist_SetFrameSetHeight()
class = GDL_Itemlist_Setname.class;
GDL_Itemlist_SetID = GDL_Itemlist_Setname.setid;

	local high ;
	test = table.getn(GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]]);
	high = (test * 20) + 20;
	GDL_Itemlist_SetFrame:SetHeight(high);
	GDL_Itemlist_SetFrame:SetWidth(240);
	GDL_Itemlist_SetFrameBackdrop:SetHeight(high);
	GDL_Itemlist_SetFrameBackdrop:SetWidth(240);
end;

function GDL_ItemList_OnUpdate(this, elapsed, GDL_ItemList_Stop)

	this.TimeSinceLastUpdate = this.TimeSinceLastUpdate + elapsed;
	if (this.TimeSinceLastUpdate > GDL_ItemList_UpdateInterval) then
		GDL_Itemlist_SetFrame:Hide();
		this.TimeSinceLastUpdate = 0;
	end
end;

function GDL_ItemList_SetFrameSetLink()
	for i = 1,4,1 do
		getglobal("GDL_Itemlist_SetFrameButton"..i):Hide();
	end;
	for i = 1,table.getn(GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]]),1 do
		if ( GetLocale() == "deDE" ) then
			getglobal("GDL_Itemlist_SetFrameButton"..i):SetText(GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]][i].setname[4]);
			getglobal("GDL_Itemlist_SetFrameButton"..i).name = GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]][i].setname[4];
			getglobal("GDL_Itemlist_SetFrameButton"..i):Show();
		else
			getglobal("GDL_Itemlist_SetFrameButton"..i):SetText(GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]][i].setname[3]);
			getglobal("GDL_Itemlist_SetFrameButton"..i).name = GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]][i].setname[3];
			getglobal("GDL_Itemlist_SetFrameButton"..i):Show();
		end;
	end;
end;

-- function GDL_Itemlist_SetFrame_SetShow(id)
	-- class = GDL_Itemlist_FrameTitleText.class;
	-- if (GDL_Setitem_tabelname[GDL_Itemlist_SetID] == "T4") then
		-- if ( GetLocale() == "deDE" ) then
			-- GDL_Itemlist_Setname:SetText(GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]][id].setname[4]);
			-- GDL_Itemlist_Setname.name = GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]][id].setname[4];
			-- GDL_Itemlist_Setname.class = class;
			-- GDL_Itemlist_Setname.setid = GDL_Itemlist_SetID;
		-- else
			-- GDL_Itemlist_Setname:SetText(GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]][id].setname[3]);
			-- GDL_Itemlist_Setname.name = GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]][id].setname[3];
			-- GDL_Itemlist_Setname.class = class;
			-- GDL_Itemlist_Setname.setid = GDL_Itemlist_SetID;
		-- end;
		-- GDL_Itemlist_Setname2:SetText("T4 Set");

	-- elseif (GDL_Setitem_tabelname[GDL_Itemlist_SetID] == "T5") then
		-- if ( GetLocale() == "deDE" ) then
			-- GDL_Itemlist_Setname:SetText(GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]][id].setname[4]);
			-- GDL_Itemlist_Setname.name = GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]][id].setname[4];
			-- GDL_Itemlist_Setname.class = class;
			-- GDL_Itemlist_Setname.setid = GDL_Itemlist_SetID;
		-- else
			-- GDL_Itemlist_Setname:SetText(GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]][id].setname[3]);
			-- GDL_Itemlist_Setname.name = GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]][id].setname[3];
			-- GDL_Itemlist_Setname.class = class;
			-- GDL_Itemlist_Setname.setid = GDL_Itemlist_SetID;
		-- end;
		-- GDL_Itemlist_Setname2:SetText("T5 Set");
	-- elseif (GDL_Setitem_tabelname[GDL_Itemlist_SetID] == "T6") then
		-- if ( GetLocale() == "deDE" ) then
			-- GDL_Itemlist_Setname:SetText(GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]][id].setname[4]);
			-- GDL_Itemlist_Setname.name = GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]][id].setname[4];
			-- GDL_Itemlist_Setname.class = class;
			-- GDL_Itemlist_Setname.setid = GDL_Itemlist_SetID;
		-- else
			-- GDL_Itemlist_Setname:SetText(GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]][id].setname[3]);
			-- GDL_Itemlist_Setname.name = GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]][id].setname[3];
			-- GDL_Itemlist_Setname.class = class;
			-- GDL_Itemlist_Setname.setid = GDL_Itemlist_SetID;
		-- end;
		-- GDL_Itemlist_Setname2:SetText("T6 Set");
	-- end;
	-- GDL_Itemlist_SetFrame:Hide();
		-- for itempos, itemval in pairs(GDL_Sets[class][GDL_Setitem_tabelname[GDL_Itemlist_SetID]][id]) do
			-- if (itempos ~= "setname") then
				-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon"):SetTexture("Interface\\Icons\\"..itemval[2]);
				-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").itemid = itemval[1];
				-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon").itemname = itemval[GDL_Itemlist_Locale];
				-- getglobal("GDL_Itemlist_FrameItem"..GDL_Set_Position[itempos].."_Icon"):SetAlpha(1.0);
				-- if(GetItemInfo(itemval[1]))then
					-- GDL_Itemlist_Model:TryOn(itemval[1]);
				-- end;
			-- end;
		-- end;
	-- GDL_Itemlist_Tooken_Upate();
-- end;

function GDL_ToolTip(this,set,iconid,name,prefix)

	if (prefix) then
		prefix= prefix..iconid.."ItemName";

		itemid = getglobal(prefix).itemid;
		itemname = getglobal(prefix).itemname;
	else
		itemid = getglobal("GDL_Itemlist_FrameItem"..iconid.."_Icon").itemid;
		questitemid = getglobal("GDL_Itemlist_FrameItem"..iconid.."_Icon").questitemid;
		itemname = getglobal("GDL_Itemlist_FrameItem"..iconid.."_Icon").itemname;
	end;

	if (set == "sets") then
		--ItemRefTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");
		--ItemRefTooltip:SetText(name);
		--ItemRefTooltip:Show();
		--GetDKP_Tooltip_Update(itemname,"ItemRefTooltip");
	elseif (itemid) then

		if(GetItemInfo(itemid))then
			itemName, itemLink, itemQuality, itemLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTexture = GetItemInfo(itemid);
			ItemRefTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");
			ItemRefTooltip:SetHyperlink(itemLink);
			ItemRefTooltip:Show();
		elseif (LootLink_SetTooltip) then

			if (ItemLinks[itemname]) then
				ItemRefTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
				LootLink_SetTooltip(ItemRefTooltip,itemname);

			else
				ItemRefTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");
				ItemRefTooltip:SetText(itemname.."\n"..GDL_NO_ATRIBUDES);
				ItemRefTooltip:Show();
			end;
		else
			ItemRefTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");
			ItemRefTooltip:SetText(itemname.."\n"..GDL_NO_ATRIBUDES);
			ItemRefTooltip:Show();
		end;
	end;
end;

function GDL_Itemlist_ItemLink(button,iconid)
	if (button == "LeftButton" ) then
		local ChatFrameEditBox = ChatEdit_GetActiveWindow();
		if( IsShiftKeyDown() and ChatFrameEditBox) then
			prefix= getglobal("GDL_Itemlist_FrameItem"..iconid.."_Icon");
			itemid = prefix.itemid;
			if (itemid) then
				if(GetItemInfo(itemid))then
					itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTexture = GetItemInfo(itemid);

					if (prefix.itemdkp ~= nil) then
						if (GetLocale() == "deDE") then
							ChatFrameEditBox:Insert(GDL_Itemlist_FrameTitleText.name.." hat f\195\188r "..itemLink.." "..prefix.itemdkp.." DKP bezahlt");
						else
							ChatFrameEditBox:Insert(GDL_Itemlist_FrameTitleText.name.." had payed for "..itemLink.." "..prefix.itemdkp.." DKP");
						end;
					else
						ChatFrameEditBox:Insert(itemLink);
					end;
				end;
			end;
		else
			if ( not iconid ) then
				return;
			end
			itemid = getglobal("GDL_Itemlist_FrameItem"..iconid.."_Icon").itemid;
			if (itemid) then
				if(GetItemInfo(itemid))then
					GDL_Itemlist_Model:TryOn(itemid);
				end;
			end;
		end;
	end;
end;

function GDL_Itemlist_TexturePath()

	local race, fileName = UnitRace("player");
	if ( strupper(fileName) == "GNOME" ) then
		fileName = "Dwarf";
	elseif ( strupper(fileName) == "TROLL" ) then
		fileName = "Orc";
	end;
	if ( not fileName ) then
		fileName = "Orc";
	end;


	return "Interface\\DressUpFrame\\DressUpBackground-"..fileName;
end;

function SetGDL_Itemlist_Background()
	local texture = GDL_Itemlist_TexturePath();
	GDL_Itemlist_BackgroundTopLeft:SetTexture(texture..1);
	GDL_Itemlist_BackgroundTopRight:SetTexture(texture..2);
	GDL_Itemlist_BackgroundBotLeft:SetTexture(texture..3);
	GDL_Itemlist_BackgroundBotRight:SetTexture(texture..4);
end;

function GDL_Itemlist_Model_OnLoad(this)
	this.rotation = 0.61;
	this:SetRotation(this.rotation);
end;
function GDL_Itemlist_Model_RotateLeft(model, rotationIncrement)
	if ( not rotationIncrement ) then
		rotationIncrement = 0.03;
	end;
	model.rotation = model.rotation - rotationIncrement;
	model:SetRotation(model.rotation);
	PlaySound(PlaySoundKitID and "igInventoryRotateCharacter" or 861);
end;

function GDL_Itemlist_Model_RotateRight(model, rotationIncrement)
	if ( not rotationIncrement ) then
		rotationIncrement = 0.03;
	end;
	model.rotation = model.rotation + rotationIncrement;
	model:SetRotation(model.rotation);
	PlaySound(PlaySoundKitID and "igInventoryRotateCharacter" or 861);
end;

function GDL_Itemlist_Model_OnUpdate(this, elapsedTime, model, rotationsPerSecond)
	if ( not rotationsPerSecond ) then
		rotationsPerSecond = ROTATIONS_PER_SECOND;
	end;

	if ( getglobal(model:GetName().."RotateLeftButton"):GetButtonState() == "PUSHED" ) then
		model.rotation = model.rotation + (elapsedTime * 2 * PI * rotationsPerSecond);
		if ( model.rotation < 0 ) then
			model.rotation = model.rotation + (2 * PI);
		end;
		model:SetRotation(model.rotation);
	end;
	if ( getglobal(model:GetName().."RotateRightButton"):GetButtonState() == "PUSHED" ) then
		model.rotation = model.rotation - (elapsedTime * 2 * PI * rotationsPerSecond);
		if ( model.rotation > (2 * PI) ) then
			model.rotation = model.rotation - (2 * PI);
		end;
		model:SetRotation(model.rotation);
	end;
end;

--------------------
-- NonsetItemlist --
--------------------
function GDL_NonsetItemlist_Upate()
	local GDL_NonSetItemlist_Offset = FauxScrollFrame_GetOffset(GDL_NonsetItemlist_Frame_ScrollFrame);
	local GDL_NonSetItem_Index;
	i=1;
	count = 0;
	for j=1,table.getn (GDL_NonSetItems),1 do

		if (string.lower(GDL_NonSetItems[j].name) == string.lower(GDL_NonsetItemlist_FrameTitleText.name)) then
			if (count >= GDL_NonSetItemlist_Offset) then
				if (i >= 1 and i <= GDL_NonSet_TO_DISPLAY) then
					--GDL_NonSetItem_Index = GDL_NonSetItemlist_Offset + count;
					local itemid = GDL_NonSetItems[j].nonsetitemid;
					if(not GetItemInfo(itemid))then
						itemid = 0;
					end;
					prefix = "GDL_NonsetItemlist_FrameButton"..i;
					button = getglobal(prefix);
					button.GDL_NonSetItem_Index = j;
					button:Show();
					getglobal(prefix.."_Icon"):SetTexture(GDL_NonSetItems[j].nonsetitemtexture);
					getglobal(prefix.."ItemName"):SetText(GDL_NonSetItems[j].nonsetitemcolor..GDL_NonSetItems[j].nonsetitem);
					getglobal(prefix.."ItemDKP"):SetText(GDL_NonSetItems[j].nonsetitemdkp);
					getglobal(prefix.."ItemName").itemid = itemid;
					getglobal(prefix.."ItemName").itemcolor = GDL_NonSetItems[j].nonsetitemcolor;
					getglobal(prefix.."ItemName").itemname = GDL_NonSetItems[j].nonsetitem;
					getglobal(prefix.."ItemName").itemdkp = GDL_NonSetItems[j].nonsetitemdkp;
					i=i+1
				end;
			end;
			count = count + 1;
		end;
	end;
	for k = i,GDL_NonSet_TO_DISPLAY,1 do
		prefix = "GDL_NonsetItemlist_FrameButton"..k;
		button = getglobal(prefix);
		button:Hide();
	end;
	GDL_NonsetItemlist_Count = count;
	FauxScrollFrame_Update(GDL_NonsetItemlist_Frame_ScrollFrame,GDL_NonsetItemlist_Count,GDL_NonSet_TO_DISPLAY,8);
end;
function GDL_NonSet_Sort (value)
	if (value == 1) then
		if (GDL_NonSetS1 == "down") then
			GDL_NonSetS1 = "up";
			for i = 1, table.getn (GDL_NonSetItems) ,1 do
				for j = 1, table.getn (GDL_NonSetItems) ,1 do
					if (GDL_NonSetItems[j]["nonsetitem"] > GDL_NonSetItems[i]["nonsetitem"]) then
						test = GDL_NonSetItems[j];
						GDL_NonSetItems[j] = GDL_NonSetItems[i];
						GDL_NonSetItems[i] = test;
					end;

				end;
			end;
		elseif (GDL_NonSetS1 == "up") then
			GDL_NonSetS1 = "down";
			for i = 1, table.getn (GDL_NonSetItems) ,1 do
				for j = 1, table.getn (GDL_NonSetItems) ,1 do
					if (GDL_NonSetItems[j]["nonsetitem"] < GDL_NonSetItems[i]["nonsetitem"]) then
						test = GDL_NonSetItems[j];
						GDL_NonSetItems[j] = GDL_NonSetItems[i];
						GDL_NonSetItems[i] = test;
					end;

				end;
			end;
		end;
	end;
	if (value == 2) then
		if (GDL_NonSetS2 == "down") then
			GDL_NonSetS2 = "up";
			for i = 1, table.getn (GDL_NonSetItems) ,1 do
				for j = 1, table.getn (GDL_NonSetItems) ,1 do
					if (GDL_NonSetItems[j]["nonsetitemdkp"] > GDL_NonSetItems[i]["nonsetitemdkp"]) then
						test = GDL_NonSetItems[j];
						GDL_NonSetItems[j] = GDL_NonSetItems[i];
						GDL_NonSetItems[i] = test;
					end;

				end;
			end;
		elseif (GDL_NonSetS2 == "up") then
			GDL_NonSetS2 = "down";
			for i = 1, table.getn (GDL_NonSetItems) ,1 do
				for j = 1, table.getn (GDL_NonSetItems) ,1 do
					if (GDL_NonSetItems[j]["nonsetitemdkp"] < GDL_NonSetItems[i]["nonsetitemdkp"]) then
						test = GDL_NonSetItems[j];
						GDL_NonSetItems[j] = GDL_NonSetItems[i];
						GDL_NonSetItems[i] = test;
					end;

				end;
			end;
		end;
	end;
	GDL_NonsetItemlist_Upate();
end;
function GDL_NonSetItem_Link (button)
	if (button == "LeftButton" ) then
		local ChatFrameEditBox = ChatEdit_GetActiveWindow();
		if( IsShiftKeyDown() and ChatFrameEditBox) then
			GDL_NonItemID = this:GetID();
			prefix = getglobal("GDL_NonsetItemlist_FrameButton"..GDL_NonItemID.."ItemName");
			if (prefix.itemid ~= 0 and GetItemInfo(prefix.itemid)) then
				if (GetLocale() == "deDE") then
					ChatFrameEditBox:Insert(GDL_Itemlist_FrameTitleText.name.." hat f\195\188r "..prefix.itemcolor.."|Hitem:"..prefix.itemid..":0:0:0:0:0:0:0".."|h["..prefix.itemname.."]|h|r "..prefix.itemdkp.." DKP bezahlt");
				else
					ChatFrameEditBox:Insert(GDL_Itemlist_FrameTitleText.name.." had payed for "..prefix.itemcolor.."|Hitem:"..prefix.itemid..":0:0:0:0:0:0:0".."|h["..prefix.itemname.."]|h|r "..prefix.itemdkp.." DKP");
				end;
			else
				if (GetLocale() == "deDE") then
					ChatFrameEditBox:Insert(GDL_Itemlist_FrameTitleText.name.." hat f\195\188r "..prefix.itemname.." "..prefix.itemdkp.." DKP bezahlt");
				else
					ChatFrameEditBox:Insert(GDL_Itemlist_FrameTitleText.name.." had payed for "..prefix.itemname.." "..prefix.itemdkp.." DKP");
				end;
			end;
		end;
	end;
end;

--------------------
-- TookenItemlist --
--------------------
function GDL_Itemlist_Tooken_Upate()
	if (table.getn(GDL_SetNonSetItems) > 0 and GDL_Itemlist_FrameTitleText.name ~= nil) then
		for k = 1,GDL_NonSet_TO_DISPLAY,1 do
			prefix = "GDL_Itemlist_Tooken_FrameButton"..k;
			button = getglobal(prefix);
			button:Hide();
		end;

			local GDL_Itemlist_Tooken_Offset = FauxScrollFrame_GetOffset(GDL_Itemlist_Tooken_Frame_ScrollFrame);
			local GDL_TookenItem_Index;
			i=1;
			count = 0;
			for j=1,table.getn (GDL_SetNonSetItems),1 do
			local itemid = GDL_SetNonSetItems[j].setnonsetitenid;
			--debug(j.."-"..GDL_Itemlist_FrameTitleText.name);
				if (GDKPvar_save.TokenItems == "true") then
					if (string.lower(GDL_SetNonSetItems[j].name) == string.lower(GDL_Itemlist_FrameTitleText.name) and GDL_Setitem_tabelname[GDL_Itemlist_SetID] == "T4" and GDL_T4[itemid] ~= nil) then

						if (count >= GDL_Itemlist_Tooken_Offset) then
							if (i >= 1 and i <= GDL_NonSet_TO_DISPLAY) then
								prefix = "GDL_Itemlist_Tooken_FrameButton"..i;
								button = getglobal(prefix);
								button.GDL_TookenItem_Index = j;
								button:Show()
								getglobal(prefix.."_Icon"):SetTexture("Interface\\Icons\\"..GDL_T4[itemid][1]);
								getglobal(prefix.."ItemName"):SetText("|cffa335ee"..GDL_SetNonSetItems[j].questitem);
								getglobal(prefix.."ItemDKP"):SetText(GDL_SetNonSetItems[j].setnonsetitemdkp);
								getglobal(prefix.."ItemName").itemid = itemid;
								getglobal(prefix.."ItemName").itemcolor = "|cffa335ee";
								getglobal(prefix.."ItemName").itemname = GDL_SetNonSetItems[j].questitem;
								getglobal(prefix.."ItemName").itemdkp = GDL_SetNonSetItems[j].setnonsetitemdkp;
								i=i+1;
							end;
						end;
						count = count + 1;
					elseif (string.lower(GDL_SetNonSetItems[j].name) == string.lower(GDL_Itemlist_FrameTitleText.name) and GDL_Setitem_tabelname[GDL_Itemlist_SetID] == "T5" and GDL_T5[itemid]) then
						if (count >= GDL_Itemlist_Tooken_Offset) then
							if (i >= 1 and i <= GDL_NonSet_TO_DISPLAY) then
								prefix = "GDL_Itemlist_Tooken_FrameButton"..i;
								button = getglobal(prefix);
								button.GDL_TookenItem_Index = j;
								button:Show()
								getglobal(prefix.."_Icon"):SetTexture("Interface\\Icons\\"..GDL_T5[itemid][1]);
								getglobal(prefix.."ItemName"):SetText("|cffa335ee"..GDL_SetNonSetItems[j].questitem);
								getglobal(prefix.."ItemDKP"):SetText(GDL_SetNonSetItems[j].setnonsetitemdkp);
								getglobal(prefix.."ItemName").itemid = itemid;
								getglobal(prefix.."ItemName").itemcolor = "|cffa335ee";
								getglobal(prefix.."ItemName").itemname = GDL_SetNonSetItems[j].questitem;
								getglobal(prefix.."ItemName").itemdkp = GDL_SetNonSetItems[j].setnonsetitemdkp;
								i=i+1;
							end;
						end;
						count = count + 1;
					elseif (string.lower(GDL_SetNonSetItems[j].name) == string.lower(GDL_Itemlist_FrameTitleText.name) and GDL_Setitem_tabelname[GDL_Itemlist_SetID] == "T6" and GDL_T6[itemid]) then
						if (count >= GDL_Itemlist_Tooken_Offset) then
							if (i >= 1 and i <= GDL_NonSet_TO_DISPLAY) then
								prefix = "GDL_Itemlist_Tooken_FrameButton"..i;
								button = getglobal(prefix);
								button.GDL_TookenItem_Index = j;
								button:Show()
								getglobal(prefix.."_Icon"):SetTexture("Interface\\Icons\\"..GDL_T6[itemid][1]);
								getglobal(prefix.."ItemName"):SetText("|cffa335ee"..GDL_SetNonSetItems[j].questitem);
								getglobal(prefix.."ItemDKP"):SetText(GDL_SetNonSetItems[j].setnonsetitemdkp);
								getglobal(prefix.."ItemName").itemid = itemid;
								getglobal(prefix.."ItemName").itemcolor = "|cffa335ee";
								getglobal(prefix.."ItemName").itemname = GDL_SetNonSetItems[j].questitem;
								getglobal(prefix.."ItemName").itemdkp = GDL_SetNonSetItems[j].setnonsetitemdkp;
								i=i+1;
							end;
						end;
						count = count + 1;
					end;
				else
					if (string.lower(GDL_SetNonSetItems[j].name) == string.lower(GDL_Itemlist_FrameTitleText.name) ) then
						if (count >= GDL_Itemlist_Tooken_Offset) then
							if (i >= 1 and i <= GDL_NonSet_TO_DISPLAY) then
								prefix = "GDL_Itemlist_Tooken_FrameButton"..i;
								button = getglobal(prefix);
								button.GDL_TookenItem_Index = j;
								button:Show()
								getglobal(prefix.."_Icon"):SetTexture(GDL_SetNonSetItems[j].setnonsetitemtexture);
								getglobal(prefix.."ItemName"):SetText("|cffa335ee"..GDL_SetNonSetItems[j].questitem);
								getglobal(prefix.."ItemDKP"):SetText(GDL_SetNonSetItems[j].setnonsetitemdkp);
								getglobal(prefix.."ItemName").itemid = itemid;
								getglobal(prefix.."ItemName").itemcolor = "|cffa335ee";
								getglobal(prefix.."ItemName").itemname = GDL_SetNonSetItems[j].questitem;
								getglobal(prefix.."ItemName").itemdkp = GDL_SetNonSetItems[j].setnonsetitemdkp;
								i=i+1;
							end;
						end;
						count = count + 1;
					end;
				end;
			end;

		for k = i,GDL_NonSet_TO_DISPLAY,1 do
			prefix = "GDL_Itemlist_Tooken_FrameButton"..k;
			button = getglobal(prefix);
			button:Hide();
		end;
		GDL_Itemlist_Tooken_Count = count;
		FauxScrollFrame_Update(GDL_Itemlist_Tooken_Frame_ScrollFrame,GDL_Itemlist_Tooken_Count,GDL_NonSet_TO_DISPLAY,8);
	else
		getglobal("GDL_Itemlist_TookenButton"):Hide();
		getglobal("GDL_Itemlist_Tooken_Frame"):Hide();
	end;
end;

function GDL_Itemlist_Tooken_Sort (value)
	if (value == 1) then
		if (GDL_NonSetS1 == "down") then
			GDL_NonSetS1 = "up";
			for i = 1, table.getn (GDL_SetNonSetItems) ,1 do
				for j = 1, table.getn (GDL_SetNonSetItems) ,1 do
					if (GDL_SetNonSetItems[j]["questitem"] > GDL_SetNonSetItems[i]["questitem"]) then
						test = GDL_SetNonSetItems[j];
						GDL_SetNonSetItems[j] = GDL_SetNonSetItems[i];
						GDL_SetNonSetItems[i] = test;
					end;

				end;
			end;
		elseif (GDL_NonSetS1 == "up") then
			GDL_NonSetS1 = "down";
			for i = 1, table.getn (GDL_SetNonSetItems) ,1 do
				for j = 1, table.getn (GDL_SetNonSetItems) ,1 do
					if (GDL_SetNonSetItems[j]["questitem"] < GDL_SetNonSetItems[i]["questitem"]) then
						test = GDL_SetNonSetItems[j];
						GDL_SetNonSetItems[j] = GDL_SetNonSetItems[i];
						GDL_SetNonSetItems[i] = test;
					end;

				end;
			end;
		end;
	end;
	if (value == 2) then
		if (GDL_NonSetS2 == "down") then
			GDL_NonSetS2 = "up";
			for i = 1, table.getn (GDL_SetNonSetItems) ,1 do
				for j = 1, table.getn (GDL_SetNonSetItems) ,1 do
					if (GDL_SetNonSetItems[j]["setnonsetitemdkp"] > GDL_SetNonSetItems[i]["setnonsetitemdkp"]) then
						test = GDL_SetNonSetItems[j];
						GDL_SetNonSetItems[j] = GDL_SetNonSetItems[i];
						GDL_SetNonSetItems[i] = test;
					end;

				end;
			end;
		elseif (GDL_NonSetS2 == "up") then
			GDL_NonSetS2 = "down";
			for i = 1, table.getn (GDL_SetNonSetItems) ,1 do
				for j = 1, table.getn (GDL_SetNonSetItems) ,1 do
					if (GDL_SetNonSetItems[j]["setnonsetitemdkp"] < GDL_SetNonSetItems[i]["setnonsetitemdkp"]) then
						test = GDL_SetNonSetItems[j];
						GDL_SetNonSetItems[j] = GDL_SetNonSetItems[i];
						GDL_SetNonSetItems[i] = test;
					end;

				end;
			end;
		end;
	end;
	GDL_Itemlist_Tooken_Upate();
end;

function GDL_Itemlist_Tooken_Link (button)

	if (button == "LeftButton" ) then
		local ChatFrameEditBox = ChatEdit_GetActiveWindow();
		if( IsShiftKeyDown() and ChatFrameEditBox) then
			GDL_NonItemID = this:GetID();
			prefix = getglobal("GDL_Itemlist_Tooken_FrameButton"..GDL_NonItemID.."ItemName");

			if (prefix.itemid ~= 0) then
				if (GetLocale() == "deDE") then
					ChatFrameEditBox:Insert(GDL_Itemlist_FrameTitleText.name.." hat f\195\188r "..prefix.itemcolor.."|Hitem:"..prefix.itemid..":0:0:0:0:0:0:0".."|h["..prefix.itemname.."]|h|r "..prefix.itemdkp.." DKP bezahlt");
				else
					ChatFrameEditBox:Insert(GDL_Itemlist_FrameTitleText.name.." had payed for "..prefix.itemcolor.."|Hitem:"..prefix.itemid..":0:0:0:0:0:0:0".."|h["..prefix.itemname.."]|h|r "..prefix.itemdkp.." DKP");
				end;
			else
				if (GetLocale() == "deDE") then
					ChatFrameEditBox:Insert(GDL_Itemlist_FrameTitleText.name.." hat f\195\188r "..prefix.itemname.." "..prefix.itemdkp.." DKP bezahlt");
				else
					ChatFrameEditBox:Insert(GDL_Itemlist_FrameTitleText.name.." had payed for "..prefix.itemname.." "..prefix.itemdkp.." DKP");
				end;
			end;
		end;
	end;
end;
------------------------------------------------------------------------------------------
function GDL_SetClass (class,lang)

	if (class == "Mage" or class == "Magier") then
			if (lang ~= "de") then
				class = "Mage";
			else
				class = "Magier";
			end;
	elseif (class == "Warlock" or class == "Hexenmeister") then
			if (lang ~= "de") then
				class = "Warlock";
			else
				class = "Hexenmeister";
			end;
	elseif (class == "Priest" or class == "Priester") then
			if (lang ~= "de") then
				class = "Priest";
			else
				class = "Priester";
			end;
	elseif (class == "Rogue" or class == "Schurke") then
			if (lang ~= "de") then
				class = "Rogue";
			else
				class = "Schurke";
			end;
	elseif (class == "Druid" or class == "Druide") then
			if (lang ~= "de") then
				class = "Druid";
			else
				class = "Druide";
			end;
	elseif (class == "Hunter" or class == "J\195\164ger") then
			if (lang ~= "de") then
				class = "Hunter";
			else
				class = "J\195\164ger";
			end;
	elseif (class == "Shaman" or class == "Schamane") then
			if (lang ~= "de") then
				class = "Shaman";
			else
				class = "Schamane";
			end;
	elseif (class == "Warrior" or class == "Krieger") then
			if (lang ~= "de") then
				class = "Warrior";
			else
				class = "Krieger";
			end;
	elseif (class == "Paladin" or class == "Paladin") then
			if (lang ~= "de") then
				class = "Paladin";
			else
				class = "Paladin";
			end;
	elseif (class == "Death Knight" or class == "Todesritter") then
			if (lang ~= "de") then
				class = "Death Knight";
			else
				class = "Todesritter";
			end;
	elseif (class == "Monk" or class == "M\195\182nch") then
			if (lang ~= "de") then
				class = "Monk";
			else
				class = "M\195\182nch";
			end;
	elseif (class == "Demonhunter" or class == "D\195\164monenj\195\164ger") then
			if (lang ~= "de") then
				class = "Demonhunter";
			else
				class = "Demonhunter";
			end;
	else
			if (lang ~= "de") then
				class = "Unknown";
			else
				class = "Unbekannt";
			end;
	end;

		return class;
end;
