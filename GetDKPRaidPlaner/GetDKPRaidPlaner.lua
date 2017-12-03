--------------------------------------------------------------------
----                  GetDKP Plus RaidPlaner                    ----
---- GetDKP Plus Admin is written by Charla/Antonidas           ----
---- Additional Authors: Sylna, Corgan, WalleniuM               ----
---- GetDKP Plus Admin ist unter der Creative Common Licence: 	----
---- Namensnennung , Keine kommerzielle Nutzung , Weitergabe    ----
---- unter gleichen Bedingungen 2.0 Deutschland verfügbar       ----
---- http://www.eqdkp-plus.com/page.php?21                      ---
---- $Id: GetDKPRaidPlaner.lua 14162 2014-04-23 17:48:27Z cnypher $	
--------------------------------------------------------------------

function GetDKPRaidPlaner_OnLoad(this)
		SlashCmdList["GETDKPRAIDPLANER"] = GetDKPRaidPlaner_SlashHandler;
		SLASH_GETDKPRAIDPLANER1 = "/gdr";
		GETDKP_GETDKPRAIDPLANER = true;
		this:RegisterEvent("CHAT_MSG_SYSTEM");
		this:RegisterEvent("GROUP_ROSTER_UPDATE");
		GDR_Hybride = 40;
		GDR_Start_All_Invite = 0;
		
		GDR_Start_All_Invite_Counter = 1;
		GDR_All_Invite_TMP_Player = {};
		GDR_Singel_Invite = 0;
end;

function GetDKPRaidPlaner_OnEvent(event, arg1, arg2, arg3, arg4)
	
	if (event == "CHAT_MSG_SYSTEM" and GDR_Start_All_Invite == 1) then
		
		for i = 1,GDR_Start_All_Invite_Counter_max,1 do
			if (string.format(ERR_BAD_PLAYER_NAME_S ,GDR_All_Invite_TMP_Player[i].name) == arg1) then
				GDR_All_Invite_TMP_Player[i].invite = 3;
				
			elseif (string.format(ERR_ALREADY_IN_GROUP_S ,GDR_All_Invite_TMP_Player[i].name) == arg1) then
				if(GetDKP_CheckifPlayerIsInRaid(GDR_All_Invite_TMP_Player[i].name)) then
					GDR_All_Invite_TMP_Player[i].invite = 5;
				else
					GDR_All_Invite_TMP_Player[i].invite = 4;
				end;
				
			elseif (string.format(ERR_JOINED_GROUP_S ,GDR_All_Invite_TMP_Player[i].name) == arg1 or string.format(ERR_RAID_MEMBER_ADDED_S ,GDR_All_Invite_TMP_Player[i].name) == arg1) then
				GDR_All_Invite_TMP_Player[i].invite = 5;
				
			elseif (string.format(ERR_DECLINE_GROUP_S ,GDR_All_Invite_TMP_Player[i].name) == arg1) then
				GDR_All_Invite_TMP_Player[i].invite = 6;
			
			elseif (string.format(ERR_RAID_MEMBER_REMOVED_S,GDR_All_Invite_TMP_Player[i].name) == arg1) then	
				GDR_All_Invite_TMP_Player[i].invite = 7;
			end;
		end;
		
	end;
	if (event == "GROUP_ROSTER_UPDATE" and GDR_Start_All_Invite_Counter_max ) then
		if  GetNumGroupMembers()  > 0 then
			for j = 1,GetNumGroupMembers() do 
				name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML = GetRaidRosterInfo(j);	
				if (not online) then
					for i = 1,GDR_Start_All_Invite_Counter_max,1 do
						if (GDR_All_Invite_TMP_Player[i].name == name) then
							GDR_All_Invite_TMP_Player[i].invite = 8;
						end;
					end;				
				else
					for i = 1,GDR_Start_All_Invite_Counter_max,1 do
						if (GDR_All_Invite_TMP_Player[i].name == name) then
							GDR_All_Invite_TMP_Player[i].invite = 5;
						end;
					end;
				end;
			end;
		end;
	end;
end;

function GetDKPRaidPlaner_OnUpdate(this, elapsed)
	this.TimeSinceLastUpdate = this.TimeSinceLastUpdate + elapsed;
	if (GDR_Start_All_Invite == 1 and GDR_Start_All_Invite_Counter <= GDR_Start_All_Invite_Counter_max and this.TimeSinceLastUpdate > 1) then
		if (UnitName("player") == GDR_All_Invite_TMP_Player[GDR_Start_All_Invite_Counter].name) then
			GDR_All_Invite_TMP_Player[GDR_Start_All_Invite_Counter].invite = 5;
			GDR_Start_All_Invite_Counter = GDR_Start_All_Invite_Counter + 1;
		else
			if (GDR_All_Invite_TMP_Player[GDR_Start_All_Invite_Counter].invite ~= 8) then 
				InviteUnit(GDR_All_Invite_TMP_Player[GDR_Start_All_Invite_Counter].name);
				GDR_All_Invite_TMP_Player[GDR_Start_All_Invite_Counter].invite = 2;
				GDR_Start_All_Invite_Counter = GDR_Start_All_Invite_Counter + 1;
			else
				GDR_Start_All_Invite_Counter = GDR_Start_All_Invite_Counter + 1;
			end;
		end;
		if (GDR_Start_All_Invite_Counter <= GDR_Start_All_Invite_Counter_max) then
			GDR_Singel_Invite = 1;
			GetDKPRaidPlaner_Invitewindow();
		end;
		this.TimeSinceLastUpdate = 0;
	end;
	if (GDR_Singel_Invite == 1 and this.TimeSinceLastUpdate > 1) then
		this.TimeSinceLastUpdate = 0;
		GetDKPRaidPlaner_Invitewindow();
	end;
end;
function GetDKPRaidPlaner_SlashHandler(msg)
	GetDKPRaidPlaner_Toggle();
end;
function GetDKPRaidPlaner_Toggle()
	local GDR_FirstDayMonth1,GDR_FirstDayMonth2,GDR_Day_Start,GDR_getdate
	if (not GetDKPRaidPlaner) then
		return
	end;
	if (GetDKPRaidPlanerFrame:IsVisible()) then
		GetDKPRaidPlanerFrame:Hide();
	else
		GetDKPRaidPlanerTabTitleBackground:SetWidth(GetDKPRaidPlanerTabTitle:GetWidth()+20);
		GDR_DATE = GetDKPRaidPlaner_TakeCurrentFormatDate();
		GetDKPRaidPlanerTabTitleMo1:SetText(GDR_DATE[2].." "..GDR_DATE[3]);
		GetDKPRaidPlanerTabTitleMonth1:SetWidth(GetDKPRaidPlanerTabTitleMo1:GetWidth()+20);
		GDR_DATE = GetDKPRaidPlaner_TakeCurrentFormatDate(true);
		GetDKPRaidPlanerTabTitleMo2:SetText(GDR_DATE[2].." "..GDR_DATE[3]);
		GetDKPRaidPlanerTabTitleMonth2:SetWidth(GetDKPRaidPlanerTabTitleMo2:GetWidth()+20);
		GDR_FirstDayMonth1 = GetDKPRaidPlaner_TakeFirstDay();
		GDR_FirstDayMonth2 = GetDKPRaidPlaner_TakeCurrentFormatDate(true);
		GDR_FirstDayMonth2 = GetDKPRaidPlaner_TakeFirstDay(GDR_FirstDayMonth2[1]);
		if (GDR_FirstDayMonth1 == 0) then
			GDR_Day_Start = 7;
		else
			GDR_Day_Start = GDR_FirstDayMonth1;
		end;
		GDR_DATE = GetDKPRaidPlaner_TakeCurrentFormatDate();
		for i = 1,GetDRaidPlaner_TakeDayOfMonth(tonumber(date("%m",time()))),1 do
		--debug(GDR_Day_Start);
			prefix = "GetDKPRaidPlaner_Month1_Days"..GDR_Day_Start+i-1;
			getglobal(prefix.."_Dayname"):SetText(i);
			for key,val in pairs(GetDKPRaidPlaner.raid) do
				
				if (i == GetDRaidPlaner_TakeDay(GetDKPRaidPlaner.raid[key].raid_date) and GDR_DATE[1] == tonumber(date("%m",GetDKPRaidPlaner.raid[key].raid_date))) then
					getglobal(prefix.."_raid_name"):SetText(GetDKPRaidPlaner.raid[key].raid_name);
					getglobal(prefix.."_raid_icon"):SetTexture(GetDKPRaidPlaner.raid[key].raid_icon);
					getglobal(prefix.."_raid_name").month = GDR_DATE[1];
					getglobal(prefix.."_raid_name").timestamp = GetDKPRaidPlaner.raid[key].raid_date;
				end;
			end;
			button = getglobal(prefix);
			button:SetID(i);
			button:SetText(prefix);
			button:Show();
		end;
		if (GDR_FirstDayMonth2 == 0) then
			GDR_Day_Start = 7;
		else
			GDR_Day_Start = GDR_FirstDayMonth2;
		end;
		GDR_DATE = GetDKPRaidPlaner_TakeCurrentFormatDate(true);
		
		for i = 1,GetDRaidPlaner_TakeDayOfMonth(GDR_DATE[1]),1 do
		
			prefix = "GetDKPRaidPlaner_Month2_Days"..GDR_Day_Start+i-1;
			getglobal(prefix.."_Dayname"):SetText(i);
			for key,val in pairs(GetDKPRaidPlaner.raid) do
				
				if (i == GetDRaidPlaner_TakeDay(GetDKPRaidPlaner.raid[key].raid_date) and GDR_DATE[1] == tonumber(date("%m",GetDKPRaidPlaner.raid[key].raid_date))) then
					getglobal(prefix.."_raid_name"):SetText(GetDKPRaidPlaner.raid[key].raid_name);
					getglobal(prefix.."_raid_icon"):SetTexture(GetDKPRaidPlaner.raid[key].raid_icon);
					getglobal(prefix.."_raid_name").month = GDR_DATE[1];
					getglobal(prefix.."_raid_name").timestamp = GetDKPRaidPlaner.raid[key].raid_date;
				end;
			end;
			button = getglobal(prefix);
			button:SetID(i);
			button:SetText(prefix);
			button:Show();
		end;
		
		GetDKPRaidPlanerFrame:Show()
	end;
end;

function GetDKPRaidPlaner_TakeCurrentFormatDate(ne)
	local monthname,year
	monthname = tonumber(date("%m",time()));
	year = tonumber(date("%Y",time()))
	
	if (ne) then
		if (monthname == 12) then
			monthname = 1;
			year = year + 1;
		else
			monthname = monthname +1;
		end;
	end;
	monthnameasc = GDR_Month[monthname];
	GDR_DATE = {};
	GDR_DATE[1] = monthname;
	GDR_DATE[2] = monthnameasc;
	GDR_DATE[3] = year;
	return GDR_DATE
end;

function GetDKPRaidPlaner_TakeFirstDay(ne)
	local firstday,month,year,datetable
	if (ne) then
		datetable= {};
		datetable["month"] = ne;
		datetable["year"] = tonumber(date("%Y",time()))
		datetable["day"] = 1;
		firstday = time(datetable);
		firstday = tonumber(date("%w",firstday));
	else
		datetable= {};
		datetable["month"] = tonumber(date("%m",time()));
		datetable["year"] = tonumber(date("%Y",time()))
		datetable["day"] = 1;
		firstday = time(datetable);
		firstday = tonumber(date("%w",firstday));
	end;
	return firstday
end;

function GetDRaidPlaner_TakeDayOfMonth(str)
	local monthname,year
	if (str) then
		monthname = tonumber(str);
	else
		monthname = tonumber(date("%m",time()));
	end;
	
	return GDR_DaysOfMonth[monthname]
end;

function GetDRaidPlaner_TakeDay(str)
	local day
	if (str) then
		day = tonumber(date("%d",str));
	else
		day = tonumber(date("%d",time()));
	end;
	return day;
end;

function GDR_ToolTip()
	local prefix,timestamp,memberattendees
		memberattendees = 0;
		prefix = this:GetText();
		timestamp = tostring(getglobal(prefix.."_raid_name").timestamp);
		GDRGameTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");
		GDRGameTooltip:SetText(getglobal(prefix.."_raid_name"):GetText(),1.0,0.0,0.0,1);
		GDRGameTooltip:AddLine(GDR_raid_note..": "..GetDKPRaidPlaner.raid[timestamp].raid_note,1.0,1.0,1.0,1);
		GDRGameTooltip:AddLine(GDR_raid_value.." = "..GetDKPRaidPlaner.raid[timestamp].raid_value,1.0,1.0,1.0,1);
		GDRGameTooltip:AddLine(GDR_raid_raidleader..": "..GetDKPRaidPlaner.raid[timestamp].raid_raidleader,1.0,1.0,1.0,1);
		GDRGameTooltip:AddLine(GDR_raid_date..": "..date("%d.%m.%Y %H:%M:%S", GetDKPRaidPlaner.raid[timestamp].raid_date),1.0,1.0,1.0,1);
		GDRGameTooltip:AddLine(GDR_raid_date_finish..": "..date("%d.%m.%Y %H:%M:%S", GetDKPRaidPlaner.raid[timestamp].raid_date_finish),1.0,1.0,1.0,1);
		GDRGameTooltip:AddLine(GDR_raid_date_invite..": "..date("%d.%m.%Y %H:%M:%S", GetDKPRaidPlaner.raid[timestamp].raid_date_invite),1.0,1.0,1.0,1);
		GDRGameTooltip:AddLine(GDR_raid_distribution..": "..GDR_raid_distribution_verteilung[GetDKPRaidPlaner.raid[timestamp].raid_distribution]);
		for i = 1,getn(GetDKPRaidPlaner.raid[timestamp].raid_members),1 do
			if (GetDKPRaidPlaner.raid[timestamp].raid_members[i].subscribed == 0 or GetDKPRaidPlaner.raid[timestamp].raid_members[i].subscribed == 1) then
				memberattendees = memberattendees + 1;
			end;
		end
		GDRGameTooltip:AddLine(GDR_raid_attendees.." "..memberattendees.."/"..GetDKPRaidPlaner.raid[timestamp].raid_attendees,1.0,1.0,1.0,1);
		GDRGameTooltip:Show();
end;

function GDR_ToolTip2()
	GDRGameTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");
	prefix = getglobal(this:GetName());
	GDRGameTooltipName = prefix.name;
	timestamp = prefix.timestamp
	
	if (GDRGameTooltipName ~= nil and timestamp ~= nil) then
		for k = 1,getn(GetDKPRaidPlaner.raid[timestamp].raid_members),1 do
			if ( GetDKPRaidPlaner.raid[timestamp].raid_members[k].player == GDRGameTooltipName) then
				GDRGameTooltip:SetText(GDRGameTooltipName,1.0,0.0,0.0,1);
				GDRGameTooltip:AddLine(GDR_raid_note..": "..GetDKPRaidPlaner.raid[timestamp].raid_members[k].note,1.0,1.0,1.0,1);
				if (GetDKPRaidPlaner.raid[timestamp].raid_members[k].skill_1) then
					GDRGameTooltip:AddLine(" ");
					GDRGameTooltip:AddLine(GDR_skill);
					
					if (GetDKPRaidPlaner.raid[timestamp].raid_members[k].skill_1 > 39 ) then 
					GDRGameTooltip:AddLine(GDR_Skill[GetDKPRaidPlaner.raid[timestamp].raid_members[k].class][1],1.0,0.0,0.0,1);
					elseif (GetDKPRaidPlaner.raid[timestamp].raid_members[k].skill_2 > 39 ) then
					GDRGameTooltip:AddLine(GDR_Skill[GetDKPRaidPlaner.raid[timestamp].raid_members[k].class][2],1.0,0.0,0.0,1);
					elseif (GetDKPRaidPlaner.raid[timestamp].raid_members[k].skill_3 > 39 ) then
					GDRGameTooltip:AddLine(GDR_Skill[GetDKPRaidPlaner.raid[timestamp].raid_members[k].class][3],1.0,0.0,0.0,1);
					else
					GDRGameTooltip:AddLine(GDR_Hybride_text,1.0,0.0,0.0,1);
					end;
					GDRGameTooltip:AddLine(GDR_Skill[GetDKPRaidPlaner.raid[timestamp].raid_members[k].class][1].." = "..GetDKPRaidPlaner.raid[timestamp].raid_members[k].skill_1,1.0,1.0,1.0,1);
					GDRGameTooltip:AddLine(GDR_Skill[GetDKPRaidPlaner.raid[timestamp].raid_members[k].class][2].." = "..GetDKPRaidPlaner.raid[timestamp].raid_members[k].skill_2,1.0,1.0,1.0,1);
					GDRGameTooltip:AddLine(GDR_Skill[GetDKPRaidPlaner.raid[timestamp].raid_members[k].class][3].." = "..GetDKPRaidPlaner.raid[timestamp].raid_members[k].skill_3,1.0,1.0,1.0,1);
				else
					GDRGameTooltip:AddLine(" ");
					GDRGameTooltip:AddLine(GDR_noskill);
				end;
				GDRGameTooltip:Show();
			end;
		end;
	end;
end;

function GDR_OnClick(this, arg1)
	local prefix;
	prefix = getglobal(this:GetName());
	GDRGameTooltipName = prefix.name;
	timestamp = prefix.timestamp
	getglobal("GDR_RaidPlanerPopup_Popup_button4"):Hide();
	getglobal("GDR_RaidPlanerPopup_Popup_button5"):Hide();
	getglobal("GDR_RaidPlanerPopup_Popup_button6"):Hide();
	getglobal("GDR_RaidPlanerPopup_Popup_button7"):Hide();
	if (GDRGameTooltipName ~= nil and timestamp ~= nil) then
		for k = 1,getn(GetDKPRaidPlaner.raid[timestamp].raid_members),1 do
			if ( GetDKPRaidPlaner.raid[timestamp].raid_members[k].player == GDRGameTooltipName) then
				PlaySound("igMainMenuOptionCheckBoxOn");
				if (arg1 == "LeftButton") then
					InviteUnit(GDRGameTooltipName);
				end;
				if (arg1 == "RightButton") then
					getglobal("GDR_RaidPlanerPopup"):SetHeight(90);
					if (UnitName("player") == GDRGameTooltipName or UnitName("player") == GetDKPRaidPlaner.raid[timestamp].raid_raidleader) then
						j = 4;
						for i = 1,4,1 do 
							if (GetDKPRaidPlaner.raid[timestamp].raid_members[k].subscribed ~= i ) then
								
								getglobal ("GDR_RaidPlanerPopup_Popup_button"..j):SetText(GDR_subscribed[i]);
								getglobal ("GDR_RaidPlanerPopup_Popup_button"..j).subscribed = i;
								getglobal ("GDR_RaidPlanerPopup_Popup_button"..j).name = GDRGameTooltipName;
								getglobal ("GDR_RaidPlanerPopup_Popup_button"..j).timestamp = timestamp;
								if (prefix.class_group) then
									getglobal ("GDR_RaidPlanerPopup_Popup_button"..j).class_group = prefix.class_group;
								end;
								
								getglobal ("GDR_RaidPlanerPopup_Popup_button"..j):Show();
								j = j + 1;
							end;
						end;
						getglobal("GDR_RaidPlanerPopup"):SetHeight(145);
					end;
					getglobal("GDR_RaidPlanerPopup_Name_text"):SetText(GDRGameTooltipName);
					getglobal("GDR_RaidPlanerPopup"):ClearAllPoints();
					getglobal("GDR_RaidPlanerPopup"):SetPoint("TOPRIGHT",prefix,"TOPRIGHT",80,0);
					getglobal("GDR_RaidPlanerPopup"):Show();
				end;	
			end;
		end;
	end;
end;

function GDR_OnClick2(this, argl)
	if (argl == "Invite") then
		name = getglobal("GDR_RaidPlanerPopup_Name_text"):GetText();
		InviteUnit(name);
	elseif (argl == "Whisper") then
		name = getglobal("GDR_RaidPlanerPopup_Name_text"):GetText();
		local ChatFrameEditBox = ChatEdit_GetActiveWindow();
		if ( not ChatFrameEditBox) then
			ChatFrame_OpenChat("/w "..name.." ");
		else
			ChatFrameEditBox:SetText("/w "..name.." ");
		end
		ChatEdit_ParseText(ChatFrame1.editBox, 0);
	end;
end;

function GDR_OnClick3(this, argl)
	local prefix;
	prefix = getglobal(this:GetName());
	GDRGameTooltipName = prefix.name;
	timestamp = prefix.timestamp
	if (GDRGameTooltipName ~= nil and timestamp ~= nil) then
		for k = 1,getn(GetDKPRaidPlaner.raid[timestamp].raid_members),1 do
			if ( GetDKPRaidPlaner.raid[timestamp].raid_members[k].player == GDRGameTooltipName) then
				GetDKPRaidPlaner.raid[timestamp].raid_members[k].subscribed = prefix.subscribed;
				if (prefix.class_group) then
					GetDKPRaidPlaner.raid[timestamp].raid_members[k].role = GDR_class_groups[prefix.class_group];
				end;
			end;
		end;
	end;
	getglobal("GDR_RaidPlanerPopup"):Hide();
	GDR_Scroll_DB(timestamp);
end;
function GDR_OnClick_AllInvite()
	GDR_Start_All_Invite_Counter = 1;
	GDR_All_Invite_TMP_Player = nil;
	GDR_All_Invite_TMP_Player = {};
	GDR_All_Invite_TMP_Player_found = 1;
	if (GDR_All_Invite_timestamp ~= nil) then
		for k = 1,getn(GetDKPRaidPlaner.raid[GDR_All_Invite_timestamp].raid_members),1 do
			if (GetDKPRaidPlaner.raid[GDR_All_Invite_timestamp].raid_members[k].subscribed == 1) then
				tinsert(GDR_All_Invite_TMP_Player,{name = GetDKPRaidPlaner.raid[GDR_All_Invite_timestamp].raid_members[k].player; class = GetDKPRaidPlaner.raid[GDR_All_Invite_timestamp].raid_members[k].class; invite = 1});
			end;
		end;
	end;
	GDR_Start_All_Invite_Counter_max = getn(GDR_All_Invite_TMP_Player);
	if  GetNumGroupMembers()  > 0 then
		for j = 1,GetNumGroupMembers() do 
			name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML = GetRaidRosterInfo(j);	
			if (not online) then
				for i = 1,GDR_Start_All_Invite_Counter_max,1 do
					if (GDR_All_Invite_TMP_Player[i].name == name) then
						GDR_All_Invite_TMP_Player[i].invite = 8;
					end;
				end;				
			else
				for i = 1,GDR_Start_All_Invite_Counter_max,1 do
					if (GDR_All_Invite_TMP_Player[i].name == name) then
						GDR_All_Invite_TMP_Player[i].invite = 5;
					end;
				end;
			end;
		end;
	end;
	GDR_Start_All_Invite_Counter = 1;
	
	GDR_Start_All_Invite = 1;
end;
function GDR_OnClick_MonthOverview()
	RaidPlanerCalendar:Show();
	GetDKPRaidPlanerRaidFrame:Hide();
end;

function GDR_Scroll_DB(timestamp)
		print "Scroll";
	local zeile,GDR_Scroll_TMP_CLASSe,GDR_Scroll_TMP_CLASS_NUMBERe;
	GDR_Scroll_TMP_DB = nil;
	GDR_Scroll_TMP_CLASS_NUMBER = nil;
	GDR_Scroll_TMP_CLASS = nil;
	GDR_Scroll_TMP_DB = {};
	GDR_Scroll_TMP_CLASS_NUMBER = {};
	GDR_Rubric_TMP_DB = {};
	GDR_Rubric_TMP_DB[1] = 0;
	GDR_Rubric_TMP_DB[2] = 0;
	GDR_Rubric_TMP_DB[3] = 0;
	GDR_Rubric_TMP_DB[4] = 0;
	GDR_Scroll_TMP_timestamp = timestamp;
	GDR_All_Invite_timestamp = timestamp;
	for i = 0,16,1 do
		for j = 1,9,1 do
			prefix = "GetDKPRaidPlanerRaidFrame_Class"..i;
			getglobal(prefix.."_Button"..j.."_Button_text"):SetText();
			getglobal(prefix.."_Button"..j.."_Class_Background"):Hide();
			getglobal(prefix.."_Button"..j).name = nil
			getglobal(prefix.."_Button"..j).timestamp = nil
			getglobal(prefix.."_Button"..j).rubric = nil;
		end;
	end;
	
	if ( GetLocale() == "deDE" ) then
		GDR_Scroll_TMP_CLASS={	["Druide"] = 1,
								["Hexenmeister"] = 1,
								["J\195\164ger"] = 1,
								["Krieger"] = 1,
								["Magier"] = 1,
								["Paladin"] = 1,
								["Priester"] = 1,
								["Schamane"] = 1,
								["Schurke"] = 1
							};
	else
		GDR_Scroll_TMP_CLASS={	["Druid"] = 1,
								["Warlock"] = 1,
								["Hunter"] = 1,
								["Warrior"] = 1,
								["Mage"] = 1,
								["Paladin"] = 1,
								["Priest"] = 1,
								["Shaman"] = 1,
								["Rogue"] = 1
							};
	end;
	
	prefix1 = "GetDKPRaidPlanerRaidFrame_Class";
	prefix2 = "_Button";
	GDR_Scroll_TMP_Rubric = {};
	GDR_Scroll_TMP_Rubric2 = {};
	GDR_Scroll_TMP_CLASS_COLOR1 = {};
	GDR_Scroll_TMP_CLASS_COLOR2 = {};
	GDR_Scroll_TMP_CLASS_COLOR3 = {};
	zeile = 0;
	rubric = 1;
	if (GetDKPRaidPlaner.raid[timestamp].raid_distribution == 0 or GetDKPRaidPlaner.raid[timestamp].raid_distribution == 2) then
		for i = 1,9,1 do
			if ( GetLocale() == "deDE" ) then
				GetDKPRaidPlaner.raid[timestamp].raid_classes[i].class_name = GDL_SetClass(GetDKPRaidPlaner.raid[timestamp].raid_classes[i].class_name,"de");
			
			else	
				GetDKPRaidPlaner.raid[timestamp].raid_classes[i].class_name = GDL_SetClass(GetDKPRaidPlaner.raid[timestamp].raid_classes[i].class_name);
			end;
		end;
		for j = 1,5,1 do
			
			if( not GDR_Scroll_TMP_DB[zeile]) then
				GDR_Scroll_TMP_DB[zeile] = {};
			end;
			GDR_Scroll_TMP_DB[zeile][5] = GDR_subscribed[rubric];
			GDR_Scroll_TMP_Rubric[zeile] = 1;
			rubric = rubric + 1;
			zeile = zeile + 1;
			for i = 1,9,1 do
				if( not GDR_Scroll_TMP_DB[zeile]) then
					GDR_Scroll_TMP_DB[zeile] = {};
				end;
				GDR_Scroll_TMP_DB[zeile][i] = GetDKPRaidPlaner.raid[timestamp].raid_classes[i].class_name.." ("..GetDKPRaidPlaner.raid[timestamp].raid_classes[i].class_count..")";
				GDR_Scroll_TMP_Rubric2[zeile] = 1;
				GDR_Scroll_TMP_CLASS[GetDKPRaidPlaner.raid[timestamp].raid_classes[i].class_name] = zeile;
				GDR_Scroll_TMP_CLASS_NUMBER[GetDKPRaidPlaner.raid[timestamp].raid_classes[i].class_name] = i ;
				for l = 1,9,1 do
					if (GetDKPRaidPlaner.raid[timestamp].raid_classes[i].class_name == GDL_Classes[l][1] or GetDKPRaidPlaner.raid[timestamp].raid_classes[i].class_name == GDL_Classes[l][2]) then
						GDR_Scroll_TMP_CLASS_COLOR1[i] = GDL_Classes[l][3];
						GDR_Scroll_TMP_CLASS_COLOR2[i] = GDL_Classes[l][4];
						GDR_Scroll_TMP_CLASS_COLOR3[i] = GDL_Classes[l][5];
					end;
				end;
			end;
			
			for k = 1,getn(GetDKPRaidPlaner.raid[timestamp].raid_members),1 do
				if ( GetDKPRaidPlaner.raid[timestamp].raid_members[k].subscribed == j) then
					GDR_Scroll_TMP_CLASS[GetDKPRaidPlaner.raid[timestamp].raid_members[k].class] = GDR_Scroll_TMP_CLASS[GetDKPRaidPlaner.raid[timestamp].raid_members[k].class] + 1;
					if( not GDR_Scroll_TMP_DB[GDR_Scroll_TMP_CLASS[GetDKPRaidPlaner.raid[timestamp].raid_members[k].class]]) then
						GDR_Scroll_TMP_DB[GDR_Scroll_TMP_CLASS[GetDKPRaidPlaner.raid[timestamp].raid_members[k].class]] = {};
					end;
					
					GDR_Scroll_TMP_DB[GDR_Scroll_TMP_CLASS[GetDKPRaidPlaner.raid[timestamp].raid_members[k].class]][GDR_Scroll_TMP_CLASS_NUMBER[GetDKPRaidPlaner.raid[timestamp].raid_members[k].class]] = GetDKPRaidPlaner.raid[timestamp].raid_members[k].player;
				end;
			end;
			GDR_Test_Class = GDR_Scroll_TMP_CLASS[GetDKPRaidPlaner.raid[timestamp].raid_classes[1].class_name]
			for i = 2,9,1 do
				if (GDR_Test_Class < GDR_Scroll_TMP_CLASS[GetDKPRaidPlaner.raid[timestamp].raid_classes[i].class_name]) then
					GDR_Test_Class = GDR_Scroll_TMP_CLASS[GetDKPRaidPlaner.raid[timestamp].raid_classes[i].class_name];
				end;
			end;
			zeile = GDR_Test_Class+1;
			
		end;
	 	GDR_Scroll_Update(timestamp)
		
	--------------------------------------------------- Rollen Verteilung --------------------------------------------------------	
	elseif (GetDKPRaidPlaner.raid[timestamp].raid_distribution == 1) then
		for i= 1,4,1 do
			if( not GDR_Scroll_TMP_DB[zeile]) then
				GDR_Scroll_TMP_DB[zeile] = {};
			end;
			GDR_Scroll_TMP_DB[zeile][2] = GDR_subscribed[rubric];
			GDR_Scroll_TMP_Rubric[zeile] = 1;
			rubric = rubric + 1;
			zeile = zeile + 1;
			for j = 1,4,1 do
				if( not GDR_Scroll_TMP_DB[zeile]) then
					GDR_Scroll_TMP_DB[zeile] = {};
				end;
				GDR_Scroll_TMP_DB[zeile][j] = GDR_class_groups[j];
				GDR_Rubric_TMP_DB[j] = zeile;
				GDR_Scroll_TMP_Rubric2[zeile] = 1;
			end;
			for j = 1 ,getn(GetDKPRaidPlaner.raid[timestamp].raid_members),1 do
				if (GetDKPRaidPlaner.raid[timestamp].raid_members[j].role) then
					for k = 1,4,1 do
						if (GetDKPRaidPlaner.raid[timestamp].raid_members[j].role == GDR_class_groups[k] and GetDKPRaidPlaner.raid[timestamp].raid_members[j].subscribed == i) then
							GDR_Rubric_TMP_DB[k] = GDR_Rubric_TMP_DB[k] + 1;
							if( not GDR_Scroll_TMP_DB[GDR_Rubric_TMP_DB[k]]) then
								GDR_Scroll_TMP_DB[GDR_Rubric_TMP_DB[k]] = {};
							end;
							GDR_Scroll_TMP_DB[GDR_Rubric_TMP_DB[k]][k] = GetDKPRaidPlaner.raid[timestamp].raid_members[j].player;
							for l = 1,9,1 do
								if (GetDKPRaidPlaner.raid[timestamp].raid_members[j].class == GDL_Classes[l][1] or GetDKPRaidPlaner.raid[timestamp].raid_classes[i].class_name == GDL_Classes[l][2]) then
									if( not GDR_Scroll_TMP_CLASS_COLOR1[GDR_Rubric_TMP_DB[k]]) then
										GDR_Scroll_TMP_CLASS_COLOR1[GDR_Rubric_TMP_DB[k]] = {};
										GDR_Scroll_TMP_CLASS_COLOR2[GDR_Rubric_TMP_DB[k]] = {};
										GDR_Scroll_TMP_CLASS_COLOR3[GDR_Rubric_TMP_DB[k]] = {};
									end;
									GDR_Scroll_TMP_CLASS_COLOR1[GDR_Rubric_TMP_DB[k]][k] = GDL_Classes[l][3];
									GDR_Scroll_TMP_CLASS_COLOR2[GDR_Rubric_TMP_DB[k]][k] = GDL_Classes[l][4];
									GDR_Scroll_TMP_CLASS_COLOR3[GDR_Rubric_TMP_DB[k]][k] = GDL_Classes[l][5];
								end;
							end;
						end;
					end;
				end;
			end;
			GDR_Test_Group = GDR_Rubric_TMP_DB[1];
			for j = 1,4,1 do
				if (GDR_Rubric_TMP_DB[j] > GDR_Test_Group) then
					GDR_Test_Group = GDR_Rubric_TMP_DB[j];
				end;
			end;
			zeile = GDR_Test_Group + 1;
		end;
		if( not GDR_Scroll_TMP_DB[zeile]) then
				GDR_Scroll_TMP_DB[zeile] = {};
			end;
			GDR_Scroll_TMP_DB[zeile][2] = GDR_subscribed[rubric];
			GDR_Scroll_TMP_Rubric[zeile] = 1;
			rubric = rubric + 1;
			zeile = zeile + 1;
		for j = 1,4,1 do
			if( not GDR_Scroll_TMP_DB[zeile]) then
				GDR_Scroll_TMP_DB[zeile] = {};
			end;
			GDR_Scroll_TMP_DB[zeile][j] = GDR_class_groups[j];
			GDR_Rubric_TMP_DB[j] = zeile;
			GDR_Scroll_TMP_Rubric2[zeile] = 1;
		end;
		for j = 1 ,getn(GetDKPRaidPlaner.raid[timestamp].raid_members),1 do
			if (GetDKPRaidPlaner.raid[timestamp].raid_members[j].subscribed == 5) then
				for i = 1,4,1 do
					for k = 1,getn(GetDKPRaidPlaner.raid[timestamp].raid_classes_role[i]),1 do
						if (GetDKPRaidPlaner.raid[timestamp].raid_classes_role[i][k].class_name == GetDKPRaidPlaner.raid[timestamp].raid_members[j].class) then
							GDR_Rubric_TMP_DB[i] = GDR_Rubric_TMP_DB[i] + 1;
							if( not GDR_Scroll_TMP_DB[GDR_Rubric_TMP_DB[i]]) then
								GDR_Scroll_TMP_DB[GDR_Rubric_TMP_DB[i]] = {};
							end;
							GDR_Scroll_TMP_DB[GDR_Rubric_TMP_DB[i]][i] = GetDKPRaidPlaner.raid[timestamp].raid_members[j].player;
							for l = 1,9,1 do
								if (GetDKPRaidPlaner.raid[timestamp].raid_members[j].class == GDL_Classes[l][1] or GetDKPRaidPlaner.raid[timestamp].raid_classes[i].class_name == GDL_Classes[l][2]) then
									if( not GDR_Scroll_TMP_CLASS_COLOR1[GDR_Rubric_TMP_DB[i]]) then
										GDR_Scroll_TMP_CLASS_COLOR1[GDR_Rubric_TMP_DB[i]] = {};
										GDR_Scroll_TMP_CLASS_COLOR2[GDR_Rubric_TMP_DB[i]] = {};
										GDR_Scroll_TMP_CLASS_COLOR3[GDR_Rubric_TMP_DB[i]] = {};
									end
									GDR_Scroll_TMP_CLASS_COLOR1[GDR_Rubric_TMP_DB[i]][i] = GDL_Classes[l][3];
									GDR_Scroll_TMP_CLASS_COLOR2[GDR_Rubric_TMP_DB[i]][i] = GDL_Classes[l][4];
									GDR_Scroll_TMP_CLASS_COLOR3[GDR_Rubric_TMP_DB[i]][i] = GDL_Classes[l][5];
								end;
							end;
						end;
					end;
				end;
			end;
		end;
		GDR_Scroll_Update(timestamp)
	end;
end;

function GDR_Scroll_Update(timestamp)
	timestamp = GDR_Scroll_TMP_timestamp;
	local GetDKPRaidPlaner_Offset = FauxScrollFrame_GetOffset(GetDKPRaidPlaner_ScrollFrame) , rubric;
	FauxScrollFrame_Update(GetDKPRaidPlaner_ScrollFrame,getn(GDR_Scroll_TMP_DB),16,8);
	for i = 0,16,1 do
		for j = 1,9,1 do
			prefix = "GetDKPRaidPlanerRaidFrame_Class"..i;
			getglobal(prefix.."_Button"..j.."_Button_text"):SetText();
			getglobal(prefix.."_Button"..j.."_Class_Background"):SetTexture(1,1,1);
			getglobal(prefix.."_Button"..j.."_Button_text"):SetTextColor(1,1,1);
			getglobal(prefix.."_Button"..j.."_Class_Background"):Hide();
			getglobal(prefix.."_Button"..j).name = nil;
			getglobal(prefix.."_Button"..j).timestamp = nil;
			getglobal(prefix.."_Button"..j).rubric = nil;
		end;
	end;
	k=0;
	rubric = 0;
	if (GetDKPRaidPlaner.raid[timestamp].raid_distribution == 0 or GetDKPRaidPlaner.raid[timestamp].raid_distribution == 2) then
		for i = 0,getn (GDR_Scroll_TMP_DB) do
			if (i >= GetDKPRaidPlaner_Offset and i <= GetDKPRaidPlaner_Offset+16) then
				prefix = "GetDKPRaidPlanerRaidFrame_Class"..k;
				for j = 1,9,1 do
					if (GDR_Scroll_TMP_Rubric[i]) then
						getglobal(prefix.."_Button"..j.."_Class_Background"):SetTexture(0.44 ,0.37,0.31);
						getglobal(prefix.."_Button"..j.."_Class_Background"):Show();
						
					end;
					if (GDR_Scroll_TMP_Rubric2[i]) then
						getglobal(prefix.."_Button"..j.."_Class_Background"):SetTexture(0.56 ,0.54,0.48);
						getglobal(prefix.."_Button"..j.."_Class_Background"):Show();
					end;
					if (GDR_Scroll_TMP_DB[i][j]) then
						if (GDR_Scroll_TMP_Rubric2[i] or GDR_Scroll_TMP_Rubric[i]) then
							getglobal(prefix.."_Button"..j.."_Button_text"):SetText(GDR_Scroll_TMP_DB[i][j]);
						else
							getglobal(prefix.."_Button"..j.."_Button_text"):SetText(GDR_Scroll_TMP_DB[i][j]);
						end;
						if (not GDR_Scroll_TMP_Rubric[i]) then
							getglobal(prefix.."_Button"..j.."_Button_text"):SetTextColor(GDR_Scroll_TMP_CLASS_COLOR1[j],GDR_Scroll_TMP_CLASS_COLOR2[j],GDR_Scroll_TMP_CLASS_COLOR3[j]);
						end;
						getglobal(prefix.."_Button"..j).name = GDR_Scroll_TMP_DB[i][j];
						getglobal(prefix.."_Button"..j).timestamp = timestamp;
						
					end;
				end;
				k=k+1;
			end;
		end;
	elseif (GetDKPRaidPlaner.raid[timestamp].raid_distribution == 1) then
		for i = 0,getn (GDR_Scroll_TMP_DB) do
			if (i >= GetDKPRaidPlaner_Offset and i <= GetDKPRaidPlaner_Offset+16) then
				prefix = "GetDKPRaidPlanerRaidFrame_Class"..k;
				l = 0
				for j = 1,4,1 do
					if (GDR_Scroll_TMP_Rubric[i]) then
						for m = 1,7,1 do
							getglobal(prefix.."_Button"..m.."_Class_Background"):SetTexture(0.44 ,0.37,0.31);
							getglobal(prefix.."_Button"..m.."_Class_Background"):Show();
							
						end;
					end;
					if (GDR_Scroll_TMP_Rubric2[i]) then
						for m = 1,7,1 do
							getglobal(prefix.."_Button"..m.."_Class_Background"):SetTexture(0.56 ,0.54,0.48);
							getglobal(prefix.."_Button"..m.."_Class_Background"):Show();
						end;
					end;
					if (GDR_Scroll_TMP_DB[i][j]) then
						getglobal(prefix.."_Button"..j+l.."_Button_text"):SetText(GDR_Scroll_TMP_DB[i][j]);
						getglobal(prefix.."_Button"..j+l).name = GDR_Scroll_TMP_DB[i][j];
						getglobal(prefix.."_Button"..j+l).timestamp = timestamp;
						getglobal(prefix.."_Button"..j+l).class_group = j;
					end;
					if (not GDR_Scroll_TMP_Rubric[i] and not GDR_Scroll_TMP_Rubric2[i]) then
						getglobal(prefix.."_Button"..j+l.."_Button_text"):SetTextColor(GDR_Scroll_TMP_CLASS_COLOR1[i][j],GDR_Scroll_TMP_CLASS_COLOR2[i][j],GDR_Scroll_TMP_CLASS_COLOR3[i][j]);	
					end;
					l=l+1;
				end;
				k=k+1;
			end;
		end;
	end;
end;

function GetDKPRaidPlaner_Invitewindow()
	local GetDKPRaidPlaner_Offset = FauxScrollFrame_GetOffset(GDR_RaidPlanerInvite_ScrollFrame) ;
	FauxScrollFrame_Update(GDR_RaidPlanerInvite_ScrollFrame,getn(GDR_All_Invite_TMP_Player),19,8);
	
	getglobal("GDR_RaidPlaner_Invite"):Show();
	prefix = "GDR_RaidPlanerInvite_button";
	for i = 1,5,1 do
		getglobal(prefix..i.."_name"):SetText();
		getglobal(prefix..i.."_status"):SetText();
		getglobal(prefix..i.."_Background"):Hide();
		getglobal(prefix..i).name = nil;
	end;
	zeile = 0;
	local scrollcountet = 0
	GDR_Invite_background = 1;
	for i = 1,8,1 do
		
		for j = 1,getn(GDR_All_Invite_TMP_Player),1 do
			if (GDR_All_Invite_TMP_Player[j].invite == i) then
				if (scrollcountet >= GetDKPRaidPlaner_Offset and scrollcountet <= GetDKPRaidPlaner_Offset+19) then
					getglobal(prefix..zeile.."_name"):SetText(GDR_All_Invite_TMP_Player[j].name);
					getglobal(prefix..zeile.."_status"):SetText(GDR_invite_text[GDR_All_Invite_TMP_Player[j].invite]);
					for l = 1,9,1 do
						if (GDR_All_Invite_TMP_Player[j].class == GDL_Classes[l][1] or GDR_All_Invite_TMP_Player[j].class == GDL_Classes[l][2]) then
							getglobal(prefix..zeile.."_name"):SetTextColor(GDL_Classes[l][3],GDL_Classes[l][4],GDL_Classes[l][5]);
						end;
					end;
					if (GDR_Invite_background == 1) then
						getglobal(prefix..zeile.."_Background"):SetTexture(0.44 ,0.37,0.31);
						getglobal(prefix..zeile.."_Background"):Show();
						GDR_Invite_background = 2;
					elseif (GDR_Invite_background == 2) then
						getglobal(prefix..zeile.."_Background"):SetTexture(0.56 ,0.54,0.48);
						getglobal(prefix..zeile.."_Background"):Show();
						GDR_Invite_background = 1;
					end;
					getglobal(prefix..zeile).name = GDR_All_Invite_TMP_Player[j].name;
					getglobal(prefix..zeile).invite = GDR_All_Invite_TMP_Player[j].invite;
					zeile = zeile + 1;
				end;
				scrollcountet = scrollcountet + 1;
			end;
		end;
		
	end;
end;
function GetDKPRaidPlaner_Invitewindow_singel()
	local prefix,name,invite;
	prefix = getglobal(this:GetName());
	name = prefix.name;
	invite = prefix.invite;
	debug(invite,prefix);
	if (invite ~= 4 and invite ~= 5) then
		InviteUnit(name);
	end;
end;
