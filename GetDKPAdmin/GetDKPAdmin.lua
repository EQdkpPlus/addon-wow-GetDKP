-------------------------------------------------------------------
---- GetDKP Plus																----
---- Copyright (C) 2006-2018 EQdkp-Plus Developer Team			----
---- You should have received a copy of the GNU Affero			----
---- General Public License along with this program. If not,	----
---- see http://www.gnu.org/licenses/.									----
-------------------------------------------------------------------

GDA_Sort_Rule2 = 3;
GDA_PAAR = 0;
GDA_PAAR_ENT = {};
GDA_PAAR_NAME = {};
GDA_UpdateInterval = 0.01;
GDA_CD_Time = GDKPvar_save.GDA_Countdown_Time;
GDA_CD_Alert = GDKPvar_save.GDA_Countdown_Alert;
GDA_CD_Alert_Cont = 1;
GDA_CD_StartTime = nil;
GDA_CD_Stop = true;
GDA_CD_MSG_Start = false;
GDA_CD_MSG_Alert = false;
GDA_CD_MSG_IIIsec = false;
GDA_CD_MSG_IIsec = false;
GDA_CD_MSG_Isec = false;
GDA_LOOTLISTUPDATE = 0;
GDA_LOOTLIST = nil;

GDA_Msg = {
			[1] = "GUILD",
			[2] = "SAY",
			[3] = "PARTY",
			[4] = "RAID",
			[5] = "OFFICER",
			[6] = "RAID_WARNING",
		  };
 
function GetDKPAdmin_OnLoad(this)
		this:RegisterEvent("VARIABLES_LOADED");
		this:RegisterEvent("CHAT_MSG_WHISPER");
		this:RegisterEvent("CHAT_MSG_RAID");
		this:RegisterEvent("CHAT_MSG_RAID_LEADER");
		this:RegisterEvent("CHAT_MSG_GUILD");
		this:RegisterEvent("CHAT_MSG_SYSTEM");
		this:RegisterEvent("LOOT_OPENED");
		this:RegisterEvent("CHAT_MSG_ADDON");
		-- Slash Commands --
		SlashCmdList["GETDKPADMIN"] = GetDKPAdmin_SlashHandler;
		SLASH_GETDKPADMIN1 = "/gda";
		SLASH_GETDKPADMIN2 = "/gdb";
		GETDKP_ADMINLOAD = true;
	
end;

function GetDKPAdmin_OnUpdate(this, elapsed)
	this.TimeSinceLastUpdate = this.TimeSinceLastUpdate + elapsed; 	
	 
	if(this.TimeSinceLastUpdate > GDA_UpdateInterval and GDA_CD_StartTime ~= nil and GDA_CD_Stop == false) then
	GDA_CD_Time = GDKPvar_save.GDA_Countdown_Time;
	GDA_CD_Alert = GDKPvar_save.GDA_Countdown_Alert;
		_time = time();
		if (_time == GDA_CD_StartTime and GDA_CD_MSG_Start == false)then
			GDA_CD_MSG_Start = true;
			msg = GDA_CD_MSG_TEXT_1..GDA_CD_Time..GDA_CD_MSG_TEXT_2;
			SendChatMessage(msg, GDA_Msg[GDKPvar_save.GDA_Chatoutput]);
		end;
		if (_time == (GDA_CD_StartTime + GDA_CD_Time)) then
			GDA_CD_StartTime = nil;
			GDA_CD_Stop = true;
			GDA_CD_MSG_Start = false;
			GDA_CD_MSG_Alert = false;
			GDA_CD_MSG_IIIsec = false;
			GDA_CD_MSG_IIsec = false;
			GDA_CD_MSG_Isec = false;
			GetDKPAdmin_CD_Button:SetText(GDA_CD_ON);
			msg = GDA_CD_MSG_TEXT_3;
			SendChatMessage(msg, GDA_Msg[GDKPvar_save.GDA_Chatoutput]);
			return
		end;
		if(_time == (GDA_CD_StartTime +(GDA_CD_Time-GDA_CD_Alert)) and GDA_CD_MSG_Alert == false) then
			GDA_CD_MSG_Alert = true;
			msg = GDA_CD_MSG_TEXT_4..GDA_CD_Alert..GDA_CD_MSG_TEXT_2;
			SendChatMessage(msg, GDA_Msg[GDKPvar_save.GDA_Chatoutput]);
		end;
		if (_time >= (GDA_CD_StartTime +(GDA_CD_Time-3))) then
			if (_time == (GDA_CD_StartTime +(GDA_CD_Time-3)) and GDA_CD_MSG_IIIsec == false) then
				GDA_CD_MSG_IIIsec = true;
				msg = GDA_CD_MSG_TEXT_5;
				SendChatMessage(msg, GDA_Msg[GDKPvar_save.GDA_Chatoutput]);
			elseif (_time == (GDA_CD_StartTime +(GDA_CD_Time-2)) and GDA_CD_MSG_IIsec == false) then
				GDA_CD_MSG_IIsec = true;
				msg = GDA_CD_MSG_TEXT_6;
				SendChatMessage(msg, GDA_Msg[GDKPvar_save.GDA_Chatoutput]);
			elseif (_time == (GDA_CD_StartTime +(GDA_CD_Time-1)) and GDA_CD_MSG_Isec == false) then
				GDA_CD_MSG_Isec = true;
				msg = GDA_CD_MSG_TEXT_7;
				SendChatMessage(msg, GDA_Msg[GDKPvar_save.GDA_Chatoutput]);
			end;
		end;
		this.TimeSinceLastUpdate = 0;
	end;
	
end;

function GetDKPAdmin_OnEvent(self, event, ...)
	local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = ...;
	local numArgs, result;
	-----------------------------------------------------------------------------------------
	----------------------------------- Load Variables---------------------------------------
	if (event == "VARIABLES_LOADED") then
		GetDKPAdmin_VarLoad();
		return;
	end;
	-----------------------------------------------------------------------------------------
	--------------------------------- Build GDALootlist--------------------------------------
	if (event == "CHAT_MSG_ADDON" and arg1 == "GDALootlist" and arg2 == "start") then
		GDA_LOOTLIST = {};
		GDA_LOOTLISTUPDATE = 1;
		GDA_LOOTLISTUPDATE_Name = arg4;
	elseif (event == "CHAT_MSG_ADDON" and arg1 == "GDALootlist" and arg2 == "end") then
		GDA_LOOTLISTUPDATE = 0;
		GDA_LOOTLISTUPDATE_Name = "";
		if (GDKPvar_save.GDA_OnOff) then
			GDA_LootList_Update(GDA_LOOTLIST);
			if (GDKPvar_save.GDA_Loot_GDA) then
				GetDKPAdmin_Show();
			end;
		end;
	elseif (event == "CHAT_MSG_ADDON" and arg1 == "GDALootlist" and GDA_LOOTLISTUPDATE == 1 and GDA_LOOTLISTUPDATE_Name == arg4) then
		_args = GDKP_GetArgs(arg2, ";");
		_args[2] = tonumber(_args[2]);
		GDA_LOOTLIST[_args[2]] = {_args[1],_args[3]};
	end;
	--------------------------------------------------------------------------------------
	----------------------------------- Loot Find-----------------------------------------
	if (event == "LOOT_OPENED") then
		if (GetNumGroupMembers() > 0 )then
			j = 0;
			lootmethod, masterlooterPartyID, masterlooterRaidID = GetLootMethod()
			if (lootmethod == "master") then
				masterlootername = GetRaidRosterInfo(masterlooterRaidID)
				if (lootmethod == "master" and UnitName("player") == masterlootername) then 
					anz = GetNumLootItems();
					if anz>6 then
						anz = 6;
					end;
					for slot = 1,anz,1 do
						texture, item, quantity, quality = GetLootSlotInfo(slot);
						if (LootSlotHasItem(slot) and quality >= GDKPvar_save.LOOTLEVEL) then
							j = j + 1;
							if (j == 1) then 
								C_ChatInfo.SendAddonMessage("GDALootlist","start","RAID");
							end
							if (GDKPvar_save.GDA_Loot) and (quality >= GDKPvar_save.LOOTLEVEL)then
								SendChatMessage(j..". "..GetLootSlotLink(slot), GDA_Msg[GDKPvar_save.GDA_Chatoutput]);
							end;
							C_ChatInfo.SendAddonMessage("GDALootlist",GetLootSlotLink(slot)..";"..j..";"..texture,"RAID");
						end;
					end;
					if (j ~= 0) then
						C_ChatInfo.SendAddonMessage("GDALootlist","end","RAID");
					end;
				end;
			end;
		end;
	end;
	-----------------------------------------------------------------------------------
	-------------------------------- Roll Find ----------------------------------------
	if  (event == "CHAT_MSG_SYSTEM" and GDA_PAAR ==1 and arg1~=nil) then
		local _pos1,_posX,_name = string.find(arg1, "(%w+)");
		local _pos1,_posX,_wurf = string.find(arg1, "(%d+)");
		for i = 1, table.getn(GDA_PAAR_NAME) do
			if (GDA_PAAR_NAME[i].name == _name) then
				if (table.getn(GDA_PAAR_ENT) > 0) then
					GDA_PAAR_FOUND = 0;
					for j = 1, table.getn(GDA_PAAR_ENT),1 do
						if (GDA_PAAR_ENT[j].name == _name) then 
							GDA_PAAR_FOUND = 1;
							msg = _name;
							msg = msg..GDA_PAAR_1ROLL;
							SendChatMessage(msg,GDA_Msg[GDKPvar_save.GDA_Chatoutput]);
						end;
					end;
					if (GDA_PAAR_FOUND == 0) then
						tinsert (GDA_PAAR_ENT, {name = _name,punkte = GDA_PAAR_NAME[i].punkte,wurf = _wurf,twink = GDA_PAAR_NAME[i].twink});
					end;
				else 
					tinsert (GDA_PAAR_ENT, {name = _name,punkte = GDA_PAAR_NAME[i].punkte,wurf = _wurf,twink = GDA_PAAR_NAME[i].twink});
				end;
			end;
		end;
		if (table.getn(GDA_PAAR_NAME) == table.getn(GDA_PAAR_ENT))then
			for i = 1, table.getn (GDA_PAAR_ENT) ,1 do
				for j = 1, table.getn (GDA_PAAR_ENT) ,1 do
					if (GDA_PAAR_ENT[j]["wurf"] < GDA_PAAR_ENT[i]["wurf"]) then
						test = GDA_PAAR_ENT[j];
						GDA_PAAR_ENT[j] = GDA_PAAR_ENT[i];
						GDA_PAAR_ENT[i] = test;
					end;
				end;
			end;
			msg = GDA_PAAR_ENT[1].name;
			if (GDA_PAAR_ENT[1].twink ~= nil) then
				msg = msg.."->"..GDA_PAAR_ENT[1].twink;
			end;
			msg = msg..GDA_PAAR_A..GDA_PAAR_ENT[1].wurf..GDA_PAAR_B..GDA_PAAR_ENT[1].punkte..GDA_PAAR_C;
			SendChatMessage(msg, GDA_Msg[GDKPvar_save.GDA_Chatoutput]);
			GDA_PAAR = 0;
			GDA_PAAR_ENT = {};
			GDA_PAAR_NAME = {};
		end;
	end;
	-----------------------------------------------------------------------------------
	-------------------------------- Rules 1+3-----------------------------------------
	if (arg1 ~= nil and arg2 ~= nil) and ((GDKPvar_save.GDA_Rule == 1 and ((event == "CHAT_MSG_WHISPER" and GDKPvar_save.GDA_Chatlook == 1 ) or (event == "CHAT_MSG_GUILD" and GDKPvar_save.GDA_Chatlook == 3 ) or (event =="CHAT_MSG_RAID" and GDKPvar_save.GDA_Chatlook == 2 ) or ( event =="CHAT_MSG_RAID_LEADER" and GDKPvar_save.GDA_Chatlook == 2))) or (GDKPvar_save.GDA_Rule == 3 and ((event == "CHAT_MSG_WHISPER" and GDKPvar_save.GDA_Chatlook_Rule3 == 1 ) or (event == "CHAT_MSG_GUILD" and GDKPvar_save.GDA_Chatlook_Rule3 == 3 ) or (event =="CHAT_MSG_RAID" and GDKPvar_save.GDA_Chatlook_Rule3 == 2 ) or ( event =="CHAT_MSG_RAID_LEADER" and GDKPvar_save.GDA_Chatlook_Rule3 == 2)))) then
		
		
		local Username, Userrealm = strsplit("-", arg2, 2);		
		if (gdkp == nil) or (tonumber(arg1) == nil) then
				return;
		end
		
		if (GetDKPAdmin_List ~= nil and gdkp.players ~= nil and GDKPvar_save.GDA_OnOff and IsPromoted() and GDA_CD_Stop == false) then
				if (GDA_Countdown == 1 and GDA_CD_StartTime == nil) then
					GDA_CD_StartTime = time();
					GetDKPAdmin_CD_Button:SetText(GDA_CD_OFF)
				end;
				
				if (Username == UnitName("player")) then
				--debug (arg2);
				
					if (string.find(arg1,GDA_CD_MSG_TEXT_1) ~= nil or string.find(arg1,GDA_CD_MSG_TEXT_4)~= nil or string.find(arg1,GDA_CD_MSG_TEXT_5)~= nil or string.find(arg1,GDA_CD_MSG_TEXT_6)~= nil or string.find(arg1,GDA_CD_MSG_TEXT_7)~= nil) then
						arg1 = "";
					elseif (string.find(arg1,GDA_ROLL)~= nil or string.find(arg1,GDA_PAAR_A)~= nil) then
						arg1 = "";
					end;
				end;
				
				if (GetDKPAdmin_Frame:IsVisible()) then 
					arg1 = findpattern(arg1 ,"%d*%d");
				end;
				if (gdkp.players[Username] == nil and gdkp_alliases ~= nil and tonumber(DKPInfo.process_dkp_ver) > 2.60 and tonumber(arg1) ~= nil) then
					--debug (arg2);
					for key,val in pairs(gdkp_alliases) do
						for i=1,table.getn(gdkp_alliases[key]),1 do
							if (gdkp_alliases[key][i] ==  Username) then
								find = 0;
								for i = 1 , table.getn(GetDKPAdmin_List) do
									if (GetDKPAdmin_List[i].name == Username) then
										GetDKPAdmin_List[i].points = tonumber(arg1);
										find = 1;
									end;
								end;

								if (find ~= 1) then
									if ( GDKPvar_save.GDA_MinDKP_Rule3 <= tonumber(arg1)) then
										tinsert(GetDKPAdmin_List, {name = Username; class = gdkp.players[Username].class; points = tonumber(arg1); dkp = gdkp.players[Username][GDKPvar_save.konto.."_current"]});
									else
											SendChatMessage("Bid is too low", "WHISPER", "Common", arg2);								
									end;
									find = 0;
								end;
								if (GetDKPAdmin_Frame:IsVisible()) then
									GetDKPAdmin_Rule1();
									if (type(GDKPvar_save) == "table") then
										GDA_Scale = (GDKPvar_save.Scaling_GDA / 100);
									else 
										GDA_Scale = 1;
									end;
									unsavedscale = 1 - UIParent:GetEffectiveScale() + GDA_Scale;	
									GetDKPAdmin_Frame:SetScale(unsavedscale);
								else
									GetDKPAdmin_Frame:Show();
									GetDKPAdmin_Rule1();
									if (type(GDKPvar_save) == "table") then
										GDA_Scale = (GDKPvar_save.Scaling_GDA / 100);
									else 
										GDA_Scale = 1;
									end;
									unsavedscale = 1 - UIParent:GetEffectiveScale() + GDA_Scale;	
									GetDKPAdmin_Frame:SetScale(unsavedscale);
								end;		
							else
								
							end;
						end;
					end;
				elseif (tonumber(arg1) ~= nil and gdkp.players[Username] ~= nil) then
					find = 0;
					current_highest_bid = 0;
					for i = 1 , table.getn(GetDKPAdmin_List) do
						
						if ( current_highest_bid < GetDKPAdmin_List[i].points ) then
						current_highest_bid = GetDKPAdmin_List[i].points;
						end;
					end;
						for i = 1 , table.getn(GetDKPAdmin_List) do
							if (GetDKPAdmin_List[i].name == Username) then
							
								if ( GDKPvar_save.GDA_MinDKP_Rule3 <= tonumber(arg1)) then
								
								
									if ( GetDKPAdmin_List[i].points > tonumber(arg1)) then
											if (( GDKPvar_save.GDA_Rule == 1 and GDKPvar_save.GDA_announce_highest_bid1 )) or (( GDKPvar_save.GDA_Rule == 3 and  GDKPvar_save.GDA_announce_highest_bid2 )) then
											SendChatMessage(GDA_bid_lowering, "WHISPER", "Common", arg2);
											end;
									elseif (GetDKPAdmin_List[i].points == tonumber(arg1)) then
											SendChatMessage(GDA_same_bid_as_before..tonumber(arg1).."DKP", "WHISPER", "Common", arg2);
									else
											if ( current_highest_bid < tonumber(arg1)) then
													if (( GDKPvar_save.GDA_Rule == 1 and GDKPvar_save.GDA_announce_highest_bid1 )) or (( GDKPvar_save.GDA_Rule == 3 and  GDKPvar_save.GDA_announce_highest_bid2 )) then
													SendChatMessage(GDA_new_highest_bid..tonumber(arg1).."DKP", "RAID", "Common");
													end;
													GetDKPAdmin_List[i].points = tonumber(arg1);
											end;
											
											if ( current_highest_bid == tonumber(arg1)) then
													if (( GDKPvar_save.GDA_Rule == 1 and GDKPvar_save.GDA_announce_highest_bid1 )) or (( GDKPvar_save.GDA_Rule == 3 and  GDKPvar_save.GDA_announce_highest_bid2 )) then
													SendChatMessage(GDA_equal_highest_bid..tonumber(arg1).."DKP", "RAID", "Common");
													end;
													GetDKPAdmin_List[i].points = tonumber(arg1);
											end;
											if ( current_highest_bid > tonumber(arg1)) then
													if (( GDKPvar_save.GDA_Rule == 1 and GDKPvar_save.GDA_announce_highest_bid1 )) or (( GDKPvar_save.GDA_Rule == 3 and  GDKPvar_save.GDA_announce_highest_bid2 )) then
													SendChatMessage(GDA_low_highest_bid..tonumber(arg1).."DKP", "WHISPER", "Common", arg2);
													end;
													GetDKPAdmin_List[i].points = tonumber(arg1);
											end;
									end;
									
								else
									SendChatMessage(GDA_bid_too_low, "WHISPER", "Common", arg2);								
								end;
								
								find = 1;
							end;
						end;
						
						if (find ~= 1) then
						
							if ( GDKPvar_save.GDA_MinDKP_Rule3 < tonumber(arg1)) then										
									if ( current_highest_bid < tonumber(arg1)) then
											if (( GDKPvar_save.GDA_Rule == 1 and GDKPvar_save.GDA_announce_highest_bid1 )) or (( GDKPvar_save.GDA_Rule == 3 and  GDKPvar_save.GDA_announce_highest_bid2 )) then
											SendChatMessage(GDA_new_highest_bid..tonumber(arg1).."DKP", "RAID", "Common");
											end;
									end;
									
									if ( current_highest_bid == tonumber(arg1)) then
											if (( GDKPvar_save.GDA_Rule == 1 and GDKPvar_save.GDA_announce_highest_bid1 )) or (( GDKPvar_save.GDA_Rule == 3 and  GDKPvar_save.GDA_announce_highest_bid2 )) then
											SendChatMessage(GDA_equal_highest_bid..tonumber(arg1).."DKP", "RAID", "Common");
											end;
									end;
									if ( current_highest_bid > tonumber(arg1)) then
											if (( GDKPvar_save.GDA_Rule == 1 and GDKPvar_save.GDA_announce_highest_bid1 )) or (( GDKPvar_save.GDA_Rule == 3 and  GDKPvar_save.GDA_announce_highest_bid2 )) then
											SendChatMessage(GDA_low_highest_bid..tonumber(arg1).."DKP", "WHISPER", "Common", arg2);
											end;
									end;
									tinsert(GetDKPAdmin_List, {name = Username; class = gdkp.players[Username].class; points = tonumber(arg1); dkp = gdkp.players[Username][GDKPvar_save.konto.."_current"]});
							else
									SendChatMessage(GDA_bid_too_low, "WHISPER", "Common", arg2);								
							end;
							find = 0;
						end;
						if (GetDKPAdmin_Frame:IsVisible()) then
							GetDKPAdmin_Rule1();
							if (type(GDKPvar_save) == "table") then
								GDA_Scale = (GDKPvar_save.Scaling_GDA / 100);
							else 
								GDA_Scale = 1;
							end;
							unsavedscale = 1 - UIParent:GetEffectiveScale() + GDA_Scale;	
							GetDKPAdmin_Frame:SetScale(unsavedscale);
						else
							GetDKPAdmin_Frame:Show();
							GetDKPAdmin_Rule1();
							if (type(GDKPvar_save) == "table") then
								GDA_Scale = (GDKPvar_save.Scaling_GDA / 100);
							else 
								GDA_Scale = 1;
							end;
							unsavedscale = 1 - UIParent:GetEffectiveScale() + GDA_Scale;	
							GetDKPAdmin_Frame:SetScale(unsavedscale);
						end;
				elseif (gdkp.players[Username] == nil and gdkp_alliases == nil and tonumber(DKPInfo.process_dkp_ver) > 2.60 ) then
						StaticPopupDialogs["no_dkp_user-"..Username] = {
							text = Username.."(No DKP-User) bids "..tonumber(arg1).."DKP",
							button1 = "OK",
							timeout = 0
							}
						StaticPopup_Show("no_dkp_user-"..Username);
				end;
			end;	
	-----------------------------------------------------------------------------------
	-------------------------------- Rule 2 ------------------------------------------
	elseif (arg1 ~= nil and arg2 ~= nil) and (GDKPvar_save.GDA_Rule == 2) then
		local Username, Userrealm = strsplit("-", arg2, 2);
		if (gdkp == nil) then
				return;
		end;
		if (arg1 ~= nil) and (((event == "CHAT_MSG_WHISPER" and GDKPvar_save.GDA_Chatlook_Rule2 == 1 ) or (event == "CHAT_MSG_GUILD" and GDKPvar_save.GDA_Chatlook_Rule2 == 3 ) or (event =="CHAT_MSG_RAID" and GDKPvar_save.GDA_Chatlook_Rule2 == 2 ) or ( event =="CHAT_MSG_RAID_LEADER" and GDKPvar_save.GDA_Chatlook_Rule2 == 2))  ) then
			if (GetDKPAdmin_List ~= nil and gdkp.players ~= nil and GDKPvar_save.GDA_OnOff and ((string.upper(arg1) == string.upper(GDKPvar_save.GDA_BetWord)) or (string.upper(arg1) == string.upper(GDKPvar_save.GDA_GreedWord))) and IsPromoted() and GDA_CD_Stop == false) then
				if (string.upper(arg1) == string.upper(GDKPvar_save.GDA_GreedWord)) then
					greedroll = true;
				else
					greedroll = false;
				end;
				find = 0;
				if (GDA_Countdown == 1 and GDA_CD_StartTime == nil) then
					GDA_CD_StartTime = time();
					GetDKPAdmin_CD_Button:SetText(GDA_CD_OFF)
				end;
				
				if (gdkp.players[Username] == nil and gdkp_alliases ~= nil and tonumber(DKPInfo.process_dkp_ver) > 2.60 ) then
					local foundtwink = false;
					for key,val in pairs(gdkp_alliases) do
						for i=1,table.getn(gdkp_alliases[key]),1 do
							if (gdkp_alliases[key][i] ==  arg2) then
								foundtwink = true;
								find = 0;
								for i = 1 , table.getn(GetDKPAdmin_List) do
									if (GetDKPAdmin_List[i].name == arg2) then
										find = 1;
									end;
								end;
								if (find ~= 1) then
									if greedroll then
										tinsert(GetDKPAdmin_List, {name = arg2; class = gdkp.players[key].class; points = GDKPvar_save.GDA_GreedWord.." ("..GDKPvar_save.GDA_GreedDKP..")"; dkp = gdkp.players[key][GDKPvar_save.konto.."_current"]; twink = key});
									else
										tinsert(GetDKPAdmin_List, {name = arg2; class = gdkp.players[key].class; points = GDKPvar_save.GDA_BetWord.." ("..GDKPvar_save.GDA_MinDKP_Rule2..")"; dkp = gdkp.players[key][GDKPvar_save.konto.."_current"]; twink = key});
									end;
									find = 0;
								end;
								if (GetDKPAdmin_Frame:IsVisible()) then
									GetDKPAdmin_Rule2();
									if (type(GDKPvar_save) == "table") then
										GDA_Scale = (GDKPvar_save.Scaling_GDA / 100);
									else 
										GDA_Scale = 1;
									end;
									unsavedscale = 1 - UIParent:GetEffectiveScale() + GDA_Scale;	
									GetDKPAdmin_Frame:SetScale(unsavedscale);
								else
									GetDKPAdmin_Frame:Show();
									GetDKPAdmin_Rule2();
									if (type(GDKPvar_save) == "table") then
										GDA_Scale = (GDKPvar_save.Scaling_GDA / 100);
									else 
										GDA_Scale = 1;
									end;
									unsavedscale = 1 - UIParent:GetEffectiveScale() + GDA_Scale;	
									GetDKPAdmin_Frame:SetScale(unsavedscale);
								end;		
							end;
						end;
					end;
					if not foundtwink then
						find = 0;
						for i = 1 , table.getn(GetDKPAdmin_List) do
							if (GetDKPAdmin_List[i].name == arg2) then
								find = 1;
							end;
						end;
						
						if (find ~= 1) then
							if greedroll then
								tinsert(GetDKPAdmin_List, {name = "[G] "..arg2; class = "unknown"; points = GDKPvar_save.GDA_GreedWord.." ("..GDKPvar_save.GDA_GreedDKP..")"; dkp = 0});
							else
								tinsert(GetDKPAdmin_List, {name = "[G] "..arg2; class = "unknown"; points = GDKPvar_save.GDA_BetWord.." ("..GDKPvar_save.GDA_MinDKP_Rule2..")"; dkp = 0});
							end;
							find = 0;
						end;
						if (GetDKPAdmin_Frame:IsVisible()) then
							GetDKPAdmin_Rule2();
							if (type(GDKPvar_save) == "table") then
								GDA_Scale = (GDKPvar_save.Scaling_GDA / 100);
							else 
								GDA_Scale = 1;
							end;
							unsavedscale = 1 - UIParent:GetEffectiveScale() + GDA_Scale;
							GetDKPAdmin_Frame:SetScale(unsavedscale);
						else
							GetDKPAdmin_Frame:Show();
							GetDKPAdmin_Rule2();
							if (type(GDKPvar_save) == "table") then
								GDA_Scale = (GDKPvar_save.Scaling_GDA / 100);
							else 
								GDA_Scale = 1;
							end;
							unsavedscale = 1 - UIParent:GetEffectiveScale() + GDA_Scale;
							GetDKPAdmin_Frame:SetScale(unsavedscale);
						end;
					end;
				elseif (gdkp.players[Username] == nil and gdkp_alliases == nil and tonumber(DKPInfo.process_dkp_ver) > 2.60 ) then
					find = 0;
					for i = 1 , table.getn(GetDKPAdmin_List) do
						if (GetDKPAdmin_List[i].name == Username) then
							find = 1;
						end;
					end;
					
					if (find ~= 1) then
						if greedroll then
							tinsert(GetDKPAdmin_List, {name = "[G] "..Username; class = "unknown"; points = GDKPvar_save.GDA_GreedWord.." ("..GDKPvar_save.GDA_GreedDKP..")"; dkp = 0});
						else
							tinsert(GetDKPAdmin_List, {name = "[G] "..Username; class = "unknown"; points = GDKPvar_save.GDA_BetWord.." ("..GDKPvar_save.GDA_MinDKP_Rule2..")"; dkp = 0});
						end;
						find = 0;
					end;
					if (GetDKPAdmin_Frame:IsVisible()) then
						GetDKPAdmin_Rule2();
						if (type(GDKPvar_save) == "table") then
							GDA_Scale = (GDKPvar_save.Scaling_GDA / 100);
						else 
							GDA_Scale = 1;
						end;
						unsavedscale = 1 - UIParent:GetEffectiveScale() + GDA_Scale;
						GetDKPAdmin_Frame:SetScale(unsavedscale);
					else
						GetDKPAdmin_Frame:Show();
						GetDKPAdmin_Rule2();
						if (type(GDKPvar_save) == "table") then
							GDA_Scale = (GDKPvar_save.Scaling_GDA / 100);
						else 
							GDA_Scale = 1;
						end;
						unsavedscale = 1 - UIParent:GetEffectiveScale() + GDA_Scale;
						GetDKPAdmin_Frame:SetScale(unsavedscale);
					end;
				elseif (gdkp.players[Username] ~= nil) then
					find = 0;
					for i = 1 , table.getn(GetDKPAdmin_List) do
						if (GetDKPAdmin_List[i].name == Username) then
							find = 1;
						end;
					end;
					
					if (find ~= 1) then
						if greedroll then
							tinsert(GetDKPAdmin_List, {name = Username; class = gdkp.players[Username].class; points = GDKPvar_save.GDA_GreedWord.." ("..GDKPvar_save.GDA_GreedDKP..")"; dkp = gdkp.players[Username][GDKPvar_save.konto.."_current"]});
						else
							tinsert(GetDKPAdmin_List, {name = Username; class = gdkp.players[Username].class; points = GDKPvar_save.GDA_BetWord.." ("..GDKPvar_save.GDA_MinDKP_Rule2..")"; dkp = gdkp.players[Username][GDKPvar_save.konto.."_current"]});
						end;
							
						find = 0;
					end;
					if (GetDKPAdmin_Frame:IsVisible()) then
						GetDKPAdmin_Rule2();
						if (type(GDKPvar_save) == "table") then
							GDA_Scale = (GDKPvar_save.Scaling_GDA / 100);
						else 
							GDA_Scale = 1;
						end;
						unsavedscale = 1 - UIParent:GetEffectiveScale() + GDA_Scale;	
						GetDKPAdmin_Frame:SetScale(unsavedscale);
					else
						GetDKPAdmin_Frame:Show();
						GetDKPAdmin_Rule2();
						if (type(GDKPvar_save) == "table") then
							GDA_Scale = (GDKPvar_save.Scaling_GDA / 100);
						else 
							GDA_Scale = 1;
						end;
						unsavedscale = 1 - UIParent:GetEffectiveScale() + GDA_Scale;	
						GetDKPAdmin_Frame:SetScale(unsavedscale);
					end;
				end;
				if (GetDKPAdmin_Frame:IsVisible()) then
					GetDKPAdmin_Rule2();
					if (type(GDKPvar_save) == "table") then
						GDA_Scale = (GDKPvar_save.Scaling_GDA / 100);
					else 
						GDA_Scale = 1;
					end;
					unsavedscale = 1 - UIParent:GetEffectiveScale() + GDA_Scale;	
					GetDKPAdmin_Frame:SetScale(unsavedscale);
				else
					GetDKPAdmin_Frame:Show();
					GetDKPAdmin_Rule2();
					if (type(GDKPvar_save) == "table") then
						GDA_Scale = (GDKPvar_save.Scaling_GDA / 100);
					else 
						GDA_Scale = 1;
					end;
					unsavedscale = 1 - UIParent:GetEffectiveScale() + GDA_Scale;	
					GetDKPAdmin_Frame:SetScale(unsavedscale);
				end;
			end;
		end;
	end;
end;

function GetDKPAdmin_SlashHandler(msg)
	GetDKPAdmin_Toggle();
end;

function GetDKPAdmin_VarLoad()
	if (GDKPvar_save.GDA_OnOff) then
		GetDKPAdmin_OnOff_Button:SetText(GDC_GDA_Off);
	else
		GetDKPAdmin_OnOff_Button:SetText(GDC_GDA_On);
	end;
	GetDKPAdmin_CD_Button:SetText(GDA_CD_ON);
	GDAKonto:SetText(GDAKontoName..GDKPvar_save.konto);
	GetDKPAdmin_List = {};
	GDA_S1 = "up";
	GDA_S2 = "up";
	GDA_S3 = "up";
end;

function GetDKPAdmin_Show()
	GetDKPAdmin_Frame:Hide();
	GetDKPAdminLoot_Frame:Hide();
	GetDKPAdmin_Toggle();
end;

function GetDKPAdmin_Toggle()
	if (type(GDKPvar_save) == "table") then
		GDA_Scale = (GDKPvar_save.Scaling_GDA / 100);
	else 
		GDA_Scale = 100;
	end;
	if (GetDKPAdmin_Frame:IsVisible()) then
		GetDKPAdmin_Frame:Hide();
		GetDKPAdminLoot_Frame:Hide();
	else
		GetDKPAdmin_VarLoad();
		GetDKPAdmin_Frame:Show();
		if (GDA_LOOTLIST ~= nil) then
			GetDKPAdminLoot_Frame:Show();
		end;
	end;
	GDA_PAAR = 0;
	GDA_PAAR_ENT = {};
	GDA_PAAR_NAME = {};
	unsavedscale = 1 - UIParent:GetEffectiveScale() + GDA_Scale;	
	GetDKPAdmin_Frame:SetScale(unsavedscale);
	GetDKPAdminLoot_Frame:SetScale(unsavedscale);
end;

function GetDKPAdmin_Rule1()
	if (table.getn(GetDKPAdmin_List) == 2) then
		if (GetDKPAdmin_List[2]["points"] > GetDKPAdmin_List[1]["points"]) then
			test = GetDKPAdmin_List[1];
			GetDKPAdmin_List[1] = GetDKPAdmin_List[2];
			GetDKPAdmin_List[2] = test;
		end;
	else	
		for i = table.getn (GetDKPAdmin_List),2,-1 do
			if (GetDKPAdmin_List[i]["points"] > GetDKPAdmin_List[i-1]["points"]) then
				test = GetDKPAdmin_List[i-1];
				GetDKPAdmin_List[i-1] = GetDKPAdmin_List[i];
				GetDKPAdmin_List[i] = test;
			end;
		end; 
	end;
	GetDKPAdmin_BuildList();
end;

function GetDKPAdmin_Rule2()
	GDA_Sorting(GDA_Sort_Rule2);
	GetDKPAdmin_BuildList();
end;

function GetDKPAdmin_BuildList()
	i = 1;
	j = 1;
	
	while (i <= 17) do
		local prefix = "GDAPlayer"..i;
		local button = getglobal(prefix);
		getglobal(prefix.."Name"):SetText("");
		getglobal(prefix.."Name"):SetTextColor(1, 1, 1);
		getglobal(prefix.."Order"):SetText("");
		getglobal(prefix.."Order"):SetTextColor(1, 1, 1);
		getglobal(prefix.."Set"):SetText("");
		getglobal(prefix.."Set"):SetTextColor(1, 1, 1);
		getglobal(prefix.."NonSet"):SetText("");
		getglobal(prefix.."NonSet"):SetTextColor(1, 1, 1);
		getglobal(prefix.."Mix"):SetText("");
		getglobal(prefix.."Mix"):SetTextColor(1, 1, 1);
		button:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight");
		button:Show();
		i = i + 1;
	end;
	local line; 
	local lineplusoffset; 
	FauxScrollFrame_Update(GDA_ListScrollFrame,table.getn(GetDKPAdmin_List),17,8);
	for line = 1, 17 do
		local prefix = "GDAPlayer"..line;
		local button = getglobal(prefix);
		lineplusoffset = line + FauxScrollFrame_GetOffset(GDA_ListScrollFrame);
		if lineplusoffset <= table.getn(GetDKPAdmin_List) then
			local prefix = "GDAPlayer"..line;
			key = GetDKPAdmin_List[lineplusoffset].name;
			key2 = GetDKPAdmin_List[lineplusoffset].points;
			keytext = key;
			if (GetDKPAdmin_List[lineplusoffset].twink) then
				key4 = GetDKPAdmin_List[lineplusoffset].twink;
				keytext = keytext..","..key4;
			end;
			
			if (GDKPvar_save.GDA_Rule == 1 or GDKPvar_save.GDA_Rule == 3) then
				if (key2 > (GetDKPAdmin_List[lineplusoffset].dkp)) then
					getglobal(prefix.."Set"):SetTextColor(1, 0, 0);
				end;
				
			elseif (GDKPvar_save.GDA_Rule == 2) then
				if (GDA_Sort_Rule2 == 3) then
					getglobal(prefix.."Set"):SetTextColor(1, 0, 0);
				end;
			end;
			getglobal(prefix.."Name"):SetText(keytext);
			if (GetDKPAdmin_List[lineplusoffset].class == "Warrior" or GetDKPAdmin_List[lineplusoffset].class == "Krieger") then
					getglobal(prefix.."Name"):SetTextColor(0.78, 0.61, 0.43);					
			elseif (GetDKPAdmin_List[lineplusoffset].class == "Mage" or GetDKPAdmin_List[lineplusoffset].class == "Magier") then
					getglobal(prefix.."Name"):SetTextColor(0.41, 0.8, 0.94);					
			elseif (GetDKPAdmin_List[lineplusoffset].class == "Rogue" or GetDKPAdmin_List[lineplusoffset].class == "Schurke") then
					getglobal(prefix.."Name"):SetTextColor(1, 0.96, 0.41);					
			elseif (GetDKPAdmin_List[lineplusoffset].class == "Druid" or GetDKPAdmin_List[lineplusoffset].class == "Druide") then
					getglobal(prefix.."Name"):SetTextColor(1, 0.49, 0.04);					
			elseif (GetDKPAdmin_List[lineplusoffset].class == "Hunter" or GetDKPAdmin_List[lineplusoffset].class == "J\195\164ger") then
					getglobal(prefix.."Name"):SetTextColor(0.67, 0.83, 0.45);					
			elseif (GetDKPAdmin_List[lineplusoffset].class == "Shaman" or GetDKPAdmin_List[lineplusoffset].class == "Schamane") then
					getglobal(prefix.."Name"):SetTextColor(0.58,0.51,0.79);					
			elseif (GetDKPAdmin_List[lineplusoffset].class == "Priest" or GetDKPAdmin_List[lineplusoffset].class == "Priester") then
					getglobal(prefix.."Name"):SetTextColor(1, 1, 1);
			elseif (GetDKPAdmin_List[lineplusoffset].class == "Warlock" or GetDKPAdmin_List[lineplusoffset].class == "Hexenmeister") then
					getglobal(prefix.."Name"):SetTextColor(0.58, 0.51, 0.79);
			elseif (GetDKPAdmin_List[lineplusoffset].class == "Paladin" or GetDKPAdmin_List[lineplusoffset].class == "Paladin") then
					getglobal(prefix.."Name"):SetTextColor(0.96, 0.55, 0.73);
			elseif (GetDKPAdmin_List[lineplusoffset].class == "DeathKnight" or GetDKPAdmin_List[lineplusoffset].class == "Todesritter") then
					getglobal(prefix.."Name"):SetTextColor(0.77, 0.12, 0.23);
			elseif (GetDKPAdmin_List[lineplusoffset].class == "Monk" or GetDKPAdmin_List[lineplusoffset].class == "M\195\182nch") then
					getglobal(prefix.."Name"):SetTextColor(0.77, 0.12, 0.23);
			elseif (GetDKPAdmin_List[lineplusoffset].class == "Demonhunter" or GetDKPAdmin_List[lineplusoffset].class == "D\195\164monenj\195\164ger") then
					getglobal(prefix.."Name"):SetTextColor(0.77, 0.12, 0.23);
			else		
					getglobal(prefix.."Name"):SetTextColor(1, 1, 1);
			end;
			getglobal(prefix.."Order"):SetText(key2);
			getglobal(prefix.."Set"):SetText(GetDKPAdmin_List[lineplusoffset].dkp);
			if (GDKPvar_save.GDA_Rule == 1 or GDKPvar_save.GDA_Rule == 3) then
				if (key2 == GetDKPAdmin_List[1].points) then
					button:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
				end;
			elseif (GDKPvar_save.GDA_Rule == 2) then
				if (GDA_Sort_Rule2 == 3) then
					if (key3 == GetDKPAdmin_List[1].setpoints) then
						button:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
					end;
				end;
			end;
			getglobal("GDAPlayer"..line):Show();
		else
			getglobal("GDAPlayer"..line):Hide();
		end;
	end;
end;

function PlayersOrder(var,button)
	
	if (button == "RightButton") then
		GDAList = {};
		for i = 1 , table.getn(GetDKPAdmin_List) do
			if (i ~= var+FauxScrollFrame_GetOffset(GDA_ListScrollFrame)) then
				tinsert(GDAList, {name = GetDKPAdmin_List[i].name; points = GetDKPAdmin_List[i].points; dkp = GetDKPAdmin_List[i].dkp; });
			end;
		end;
		GetDKPAdmin_List = {};
		GetDKPAdmin_List = GDAList;
		GDAList = nil;
		GetDKPAdmin_BuildList ();
	--------------------  Rule 1  --------------------------
	elseif (button == "LeftButton" and GDKPvar_save.GDA_Rule == 1) then
		GDA_PAAR_NAME = {};
		gdapaar = 0;
		for i = 2 , table.getn(GetDKPAdmin_List) do
			if (GetDKPAdmin_List[i].points == GetDKPAdmin_List[1].points) then
				if (gdapaar ~= 1) then
					msg = GetDKPAdmin_List[1].name;
					if (GetDKPAdmin_List[1].twink ~= nil) then
						msg = msg.."->"..GetDKPAdmin_List[1].twink;
					end;
					tinsert(GDA_PAAR_NAME, {name = GetDKPAdmin_List[1].name , punkte = GetDKPAdmin_List[1].points, twink = GetDKPAdmin_List[1].twink});
				end;
				msg = msg..", "..(GetDKPAdmin_List[i].name);
				if ( GetDKPAdmin_List[i].twink ~= nil) then
					msg = msg.."->"..GetDKPAdmin_List[i].twink;
				end;
				tinsert(GDA_PAAR_NAME, {name = GetDKPAdmin_List[i].name , punkte = GetDKPAdmin_List[i].points, twink = GetDKPAdmin_List[1].twink});
				gdapaar = 1;
			end;
		end;
		if (gdapaar == 1) then
			msg = msg..GDA_ROLL..GetDKPAdmin_List[1].points.." DKP";
			SendChatMessage(msg, GDA_Msg[GDKPvar_save.GDA_Chatoutput]);
			GDA_PAAR = 1;
		else
			if (table.getn(GetDKPAdmin_List) == 1) then
				msg = GetDKPAdmin_List[1].name
				if ( GetDKPAdmin_List[1].twink ~= nil) then
						msg = msg.."->"..GetDKPAdmin_List[1].twink;
				end;
				msg = msg..GDA_WINS..GDKPvar_save.GDA_MinDKP.." DKP";
			else
				if (table.getn(GetDKPAdmin_List) == var+FauxScrollFrame_GetOffset(GDA_ListScrollFrame)) then
					msg = GetDKPAdmin_List[var+FauxScrollFrame_GetOffset(GDA_ListScrollFrame)].name
					if ( GetDKPAdmin_List[var+FauxScrollFrame_GetOffset(GDA_ListScrollFrame)].twink ~= nil)then
						msg = msg.."->"..GetDKPAdmin_List[var+FauxScrollFrame_GetOffset(GDA_ListScrollFrame)].twink;
					end;
					msg = msg..GDA_WINS..GDKPvar_save.GDA_MinDKP.." DKP";
				else
					if (GetDKPAdmin_List[var+FauxScrollFrame_GetOffset(GDA_ListScrollFrame)+1].points+1 > GDKPvar_save.GDA_MinDKP) then
						msg = GetDKPAdmin_List[var+FauxScrollFrame_GetOffset(GDA_ListScrollFrame)].name
						if ( GetDKPAdmin_List[var+FauxScrollFrame_GetOffset(GDA_ListScrollFrame)].twink ~= nil)then
							msg = msg.."->"..GetDKPAdmin_List[var+FauxScrollFrame_GetOffset(GDA_ListScrollFrame)].twink;
						end;
						msg = msg..GDA_WINS..(GetDKPAdmin_List[var+FauxScrollFrame_GetOffset(GDA_ListScrollFrame)+1].points+1).." DKP";
					else
						msg = GetDKPAdmin_List[var+FauxScrollFrame_GetOffset(GDA_ListScrollFrame)].name
						if ( GetDKPAdmin_List[var+FauxScrollFrame_GetOffset(GDA_ListScrollFrame)].twink ~= nil) then
							msg = msg.."->"..GetDKPAdmin_List[var+FauxScrollFrame_GetOffset(GDA_ListScrollFrame)].twink;
						end;
						msg = msg..GDA_WINS..GDKPvar_save.GDA_MinDKP.." DKP";
					end;
				end;
			end;
			SendChatMessage(msg, GDA_Msg[GDKPvar_save.GDA_Chatoutput]);
		end;	
	--------------------  Rule 2  --------------------------
	elseif (button == "LeftButton" and GDKPvar_save.GDA_Rule == 2) then
		GDA_PAAR_NAME = {};
		gdapaar = 0;
		for i = 2 , table.getn(GetDKPAdmin_List) do
			if (GDA_Sort_Rule2 == 3) then
				if (GetDKPAdmin_List[i].dkp == GetDKPAdmin_List[1].dkp) then
					if (gdapaar ~= 1) then
						msg = GetDKPAdmin_List[1].name;
						if ( GetDKPAdmin_List[1].twink ~= nil) then
							msg = msg.."->"..GetDKPAdmin_List[1].twink;
						end;
						tinsert(GDA_PAAR_NAME, {name = GetDKPAdmin_List[1].name , punkte = GetDKPAdmin_List[1].points});
					end;
					msg = msg..", "..(GetDKPAdmin_List[i].name);
					if ( GetDKPAdmin_List[i].twink ~= nil) then
						msg = msg.."->"..GetDKPAdmin_List[i].twink;
					end;
					tinsert(GDA_PAAR_NAME, {name = GetDKPAdmin_List[i].name , punkte = GetDKPAdmin_List[i].points});
					gdapaar = 1;
				end;
			end;
		end;
		if (gdapaar == 1) then
			if (GDA_Sort_Rule2 == 3) then
				msg = msg..GDA_ROLL..GetDKPAdmin_List[1].dkp.." DKP";
			end;
			SendChatMessage(msg, GDA_Msg[GDKPvar_save.GDA_Chatoutput_Rule2]);
			GDA_PAAR = 1;
		else
			if (table.getn(GetDKPAdmin_List) == 1) then
				msg = GetDKPAdmin_List[1].name
				if ( GetDKPAdmin_List[1].twink ~= nil) then
					msg = msg.."->"..GetDKPAdmin_List[1].twink;
				end;
				if string.find(GetDKPAdmin_List[1].points, GDKPvar_save.GDA_GreedWord) then
					msg = msg..GDA_WINS2..GDKPvar_save.GDA_GreedDKP.." DKP"
				else
					msg = msg..GDA_WINS2..GDKPvar_save.GDA_MinDKP_Rule2.." DKP"
				end;
			else
				msg = GetDKPAdmin_List[var+FauxScrollFrame_GetOffset(GDA_ListScrollFrame)].name
				if ( GetDKPAdmin_List[var+FauxScrollFrame_GetOffset(GDA_ListScrollFrame)].twink ~= nil) then
					msg = msg.."->"..GetDKPAdmin_List[var+FauxScrollFrame_GetOffset(GDA_ListScrollFrame)].twink;
				end;
				if string.find(GetDKPAdmin_List[var+FauxScrollFrame_GetOffset(GDA_ListScrollFrame)].points, GDKPvar_save.GDA_GreedWord) then
					msg = msg..GDA_WINS2..GDKPvar_save.GDA_GreedDKP.." DKP"
				else
					msg = msg..GDA_WINS2..GDKPvar_save.GDA_MinDKP_Rule2.." DKP"
				end;
				
			end;
		end;
		SendChatMessage(msg, GDA_Msg[GDKPvar_save.GDA_Chatoutput_Rule2]);
	--------------------  Rule 3  --------------------------
	elseif (button == "LeftButton" and GDKPvar_save.GDA_Rule == 3) then
		GDA_PAAR_NAME = {};
		gdapaar = 0;
		for i = 2 , table.getn(GetDKPAdmin_List) do
			if (GetDKPAdmin_List[i].points == GetDKPAdmin_List[1].points) then
				if (gdapaar ~= 1) then
					msg = GetDKPAdmin_List[1].name;
					if ( GetDKPAdmin_List[1].twink ~= nil) then
						msg = msg.."->"..GetDKPAdmin_List[1].twink;
					end;
					tinsert(GDA_PAAR_NAME, {name = GetDKPAdmin_List[1].name , punkte = GetDKPAdmin_List[1].points});
				end;
				msg = msg..", "..(GetDKPAdmin_List[i].name);
				if ( GetDKPAdmin_List[i].twink ~= nil) then
					msg = msg.."->"..GetDKPAdmin_List[i].twink;
				end;
				tinsert(GDA_PAAR_NAME, {name = GetDKPAdmin_List[i].name , punkte = GetDKPAdmin_List[i].points});
				gdapaar = 1;
			end;
		end;
		if (gdapaar == 1) then
			msg = msg..GDA_ROLL..GetDKPAdmin_List[1].points.." DKP";
			SendChatMessage(msg, GDA_Msg[GDKPvar_save.GDA_Chatoutput]);
			GDA_PAAR = 1;
		else
			if (GetDKPAdmin_List[var+FauxScrollFrame_GetOffset(GDA_ListScrollFrame)].points > GDKPvar_save.GDA_MinDKP_Rule3) then
				msg = GetDKPAdmin_List[var+FauxScrollFrame_GetOffset(GDA_ListScrollFrame)].name
				if ( GetDKPAdmin_List[var+FauxScrollFrame_GetOffset(GDA_ListScrollFrame)].twink ~= nil) then
					msg = msg.."->"..GetDKPAdmin_List[var+FauxScrollFrame_GetOffset(GDA_ListScrollFrame)].twink;
				end;
				msg = msg..GDA_WINS..(GetDKPAdmin_List[var+FauxScrollFrame_GetOffset(GDA_ListScrollFrame)].points).." DKP";
			else
				msg = GetDKPAdmin_List[var+FauxScrollFrame_GetOffset(GDA_ListScrollFrame)].name
				if ( GetDKPAdmin_List[var+FauxScrollFrame_GetOffset(GDA_ListScrollFrame)].twink ~= nil) then
					msg = msg.."->"..GetDKPAdmin_List[var+FauxScrollFrame_GetOffset(GDA_ListScrollFrame)].twink;
				end;
				msg = msg..GDA_WINS..GDKPvar_save.GDA_MinDKP_Rule3.." DKP";
			end;
		end;
		SendChatMessage(msg, GDA_Msg[GDKPvar_save.GDA_Chatoutput_Rule3]);
	end;
end;

function GDA_Sorting(value)
	function smGreed(a1, a2, b1, b2)
		if (a2<b2) then
			return true;
		elseif (a1<b1) and (a2==b2) then
			return true;
		else
			return false;
		end;
	end;	
	GDA_Sort = value;
	if (table.getn(GetDKPAdmin_List) > 0) then
		-- sort by DKP
		if (GDA_Sort == 3) then
			for i = 1, table.getn (GetDKPAdmin_List) ,1 do
				for j = i, table.getn (GetDKPAdmin_List) ,1 do
					if string.find(GetDKPAdmin_List[i].points, GDKPvar_save.GDA_GreedWord) then
						a2=0
					else
						a2=1
					end;
					if string.find(GetDKPAdmin_List[j].points, GDKPvar_save.GDA_GreedWord) then
						b2=0
					else
						b2=1
					end;
					a1=GetDKPAdmin_List[i]["dkp"];
					b1=GetDKPAdmin_List[j]["dkp"];
					if smGreed(a1, a2, b1, b2) then
						test = GetDKPAdmin_List[j];
						GetDKPAdmin_List[j] = GetDKPAdmin_List[i];
						GetDKPAdmin_List[i] = test;
					end;
				end;
			end;
		end;
	end;
end;

function GetDKPAdmin_Close()
	GetDKPAdmin_Clear();
	GetDKPAdmin_Toggle();
end;

function GetDKPAdmin_Clear()
	GetDKPAdmin_List = {};
	GDA_LOOTLIST = nil;
	GDA_LootList_Update(GDA_LOOTLIST);
	GetDKPAdmin_BuildList();
	GetDKPAdminLoot_Frame:Hide();

	if (GetDKPAdmin_CD_Button:GetText() ~= GDA_CD_ON) then
		GetDKPAdmin_CD_OnOff();
	end;
end;

function GetDKPAdmin_OnOff()
	if (getglobal("GetDKP_Config_Frame_CheckButton51"):GetChecked()) then 
		GetDKP_Config_Frame_CheckButton51:SetChecked(nil);
		GetDKPAdmin_OnOff_Button:SetText(GDC_GDA_On);
		GDKPvar_save.GDA_OnOff = false;
	else
		GetDKP_Config_Frame_CheckButton51:SetChecked(true);
		GetDKPAdmin_OnOff_Button:SetText(GDC_GDA_Off);
		GDKPvar_save.GDA_OnOff = true;
	end;
	
end;

function GetDKPAdmin_CD_OnOff()
	if (GetDKPAdmin_CD_Button:GetText() == GDA_CD_ON) then
		GDA_LootList_StartCD(nil);
	else
		GetDKPAdmin_CD_Button:SetText(GDA_CD_ON);
		GDA_CD_Stop = true;
		msg = GDA_CD_MSG_TEXT_8;
		SendChatMessage(msg, GDA_Msg[GDKPvar_save.GDA_Chatoutput]);
	end;
end;

function GDA_ToolTip(self, id)
	GDA_LootList_ItemLink = getglobal("GDA_LootList_FrameButton"..id.."_Icon").ItemLink;
	if GDA_LootList_ItemLink ~= nil then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		GameTooltip:SetHyperlink(GDA_LootList_ItemLink);
		GameTooltip:Show();
	end;
end;

function GDA_LootList_StartCD(id)
	local self = GetDKP;
	GetDKPAdmin_List = {};
	GetDKPAdmin_BuildList();
	GDA_CD_Time = GDKPvar_save.GDA_Countdown_Time;
	GDA_CD_Alert = GDKPvar_save.GDA_Countdown_Alert;
	self.TimeSinceLastUpdate = 0;
	GDA_CD_Alert_Cont = 1;
	GDA_CD_StartTime = nil;
	GDA_CD_Stop = false;
	GDA_CD_MSG_Start = false;
	GDA_CD_MSG_Alert = false;
	GDA_CD_MSG_IIIsec = false;
	GDA_CD_MSG_IIsec = false;
	GDA_CD_MSG_Isec = false;
	if (GDKPvar_save.GDA_Countdown and GDA_CD_StartTime == nil) then
		GDA_CD_StartTime = time();
		GetDKPAdmin_CD_Button:SetText(GDA_CD_OFF)
	end;
	if (id ~= nil) then
		if ((GDKPvar_save.GDA_Loot_GDA_RW) and IsPromoted()) then
			SendChatMessage(GDA_LOOT_TEXT_1..getglobal("GDA_LootList_FrameButton"..id.."_Icon").ItemLink, GDA_Msg[6]);
		else
			SendChatMessage(GDA_LOOT_TEXT_1..getglobal("GDA_LootList_FrameButton"..id.."_Icon").ItemLink, GDA_Msg[GDKPvar_save.GDA_Chatoutput]);
		end;
	end;
end;

function GDA_LootList_Update(list)
	if list == nil then
		for i = 1,6,1 do 
			getglobal("GDA_LootList_FrameButton"..i.."_Icon"):SetTexture();
			getglobal("GDA_LootList_FrameButton"..i.."_Icon").ItemLink = nil;
		end;
	else
		for i = 1,getn(list),1 do 
			getglobal("GDA_LootList_FrameButton"..i.."_Icon"):SetTexture(list[i][2]);
			getglobal("GDA_LootList_FrameButton"..i.."_Icon").ItemLink = list[i][1];
		end;
	end;
end;
