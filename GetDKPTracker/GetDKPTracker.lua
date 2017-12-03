-------------------------------------------------------------------------------------------------
---- 					GetDKP Tracker       		          
---- GetDKP Plus Admin is written by Charla/Antonidas		
---- Additional Authors: Sylna, Corgan, WalleniuM             		 
---- GetDKP Trackerative Common Licence: 				
---- Namensnennung , Keine kommerzielle Nutzung , Weitergabe  
---- unter gleichen Bedingungen 2.0 Deutschland verf�gbar        
---- http://www.eqdkp-plus.com/page.php?21                   			
---- $Id: GetDKPTracker.lua 23 2009-10-30 15:56:50Z briades $	
-------------------------------------------------------------------------------------------------
UIPanelWindows["GetDKPTracker_Frame"] = { area = "left", pushable = 1, whileDead = 1 };






-----------------------------
-- GetDKP Tracker OnLoad --
-----------------------------
function GetDKP_Tracker_OnLoad(self)

		this:RegisterEvent("VARIABLES_LOADED");
		this:RegisterEvent("CHAT_MSG_LOOT");
		this:RegisterEvent("CHAT_MSG_SYSTEM");
		this:RegisterEvent("CHAT_MSG_WHISPER");
		this:RegisterEvent("CHAT_MSG_ADDON");
		this:RegisterEvent("GROUP_ROSTER_UPDATE");
		this:RegisterEvent("RAID_INSTANCE_WELCOME");
		this:RegisterEvent("PLAYER_ENTERING_WORLD");
		-- Slash Commands
		SlashCmdList["GETDKPTRACKER"] = GetDKPTracker_SlashHandler;
		SLASH_GETDKPTRACKER1 = "/gdt";
		-- Set Tabs
		PanelTemplates_SetNumTabs(self, 4);
		self.selectedTab = 1;
		PanelTemplates_UpdateTabs(self);
		
		-- ALLREADY LOAD 
		GETDKP_TrackerLOAD = true;
	
end;



-------------------------------------
-- GetDKP Tracker Variables_Loaded --
-------------------------------------
function GetDKP_Tracker_Variables_Loaded()
	if not GetDKP_Tracker_Raids then
		GetDKP_Tracker_Raids ={};
	end;
	
	GetDKP_Tacker_Raid_Time = nil;
	
	if (GetDKP_Tracker_Raids == nil or GetDKP_Tracker_Raids == {}) then
		GetDKP_Tracker_Raids = {};
		getglobal("GetDKPTracker_FrameHeaderTitleSide"):SetText("Options");
		GetDKPTracker_Frame.selectedTab = 4;
		PanelTemplates_UpdateTabs(GetDKPTracker_Frame);
	end;
end;

------------------------------------
-- GetDKP Tracker Handler --
------------------------------------
function GetDKPTracker_SlashHandler(msg)
	if (GetDKPTracker_Frame:IsVisible()) then
		GetDKPTracker_Frame:Hide();
	else
		GetDKPTracker_Frame:Show();
	end;
end;
------------------------------------
-- GetDKP Tracker Event Handler --
------------------------------------
function GetDKP_Tracker_OnEvent(event)
	if (event == "VARIABLES_LOADED") then
		GetDKP_Tracker_Variables_Loaded();
		return;
	elseif (event == "CHAT_MSG_LOOT" or event == "CHAT_MSG_SYSTEM" or event == "CHAT_MSG_WHISPER") then
	
		return;
	elseif (event == "CHAT_MSG_ADDON") then
	
	elseif (event == "GROUP_ROSTER_UPDATE" or event == "PLAYER_ENTERING_WORLD") then
		
		GetDKP_Tracker_Raid_Update (event);
	end;
end;

-----------------------------------
-- GetDKP Tracker Tab Handler --
-----------------------------------

function GetDKP_Tracker_Tab_Onclick(id)
	PanelTemplates_Tab_OnClick(_G["GetDKPTracker_FrameTab"..id], GetDKPTracker_Frame);
end;

-----------------------------------------------
-- GetDKP Tracker GetDKP_Tracker_Raid_Update --
-----------------------------------------------

function GetDKP_Tracker_Raid_Update (event)

	--debug(event.." "..GetNumGroupMembers());
	if (event == "GROUP_ROSTER_UPDATE" and GetNumGroupMembers() >0 ) then
		if not GetDKP_Tacker_Raid_Time then
			GetDKP_Tacker_Raid_Time = time(); --test
		end;
		if not GetDKP_Tracker_Raids[GetDKP_Tacker_Raid_Time] then
			GetDKP_Tracker_NewRaid(GetDKP_Tacker_Raid_Time);
		end;
		--GetDKP_Tracker_Raids[GetDKP_Tacker_Raid_Time].Player={};
		--GetDKP_Tracker_Raids[GetDKP_Tacker_Raid_Time].Boss={};
		--GetDKP_Tracker_Raids[GetDKP_Tacker_Raid_Time].Items={};
		--debug(time());
	elseif (event == "PLAYER_ENTERING_WORLD") then
	
	end;
	
--UnitName("player");

end;
function GetDKP_Tracker_NewRaid(misc)
	if (GetDKP_Tracker_NewRaid_Frame:IsVisible()) then
		GetDKP_Tracker_NewRaid_Frame:Hide();
		if misc == "Yes" then
			GetDKP_Tracker_Raids[GetDKP_Tacker_Raid_Time]={};
		else
	
		end;
	else
		GetDKP_Tracker_NewRaid_Frame:Show();
	end;
	

end;





