--------------------------------------------------------------------
---- GetDKP Plus												----
---- Copyright (c) 2006-2019 EQdkp-Plus Developer Team			----
---- You should have received a copy of the GNU Affero			----
---- General Public License along with this program. If not,	----
---- see http://www.gnu.org/licenses/.							----
--------------------------------------------------------------------

----------------------------------
-- GetDKP Plus Config Variables --
----------------------------------
GetDKPfont								= "Interface\\AddOns\\GetDKP\\MORPHEUS.TTF";
getdkp_list_load_statusbar_values		= 1;
GDLConfigFrame_send_Show_alpha			= 0;
GDLConfigFrame_send_Show_alpha2			= 0;
getdkp_list_load_char_overvlow			= "";
GDKPvar_save							= {};


local getdkp_list_load_multitable		= false;
local getdkp_list_load_dkpinfo			= false;
local getdkp_list_load_gdkp				= false;
local getdkp_list_load_dkpitems			= false;
local getdkp_list_load_issend			= 0;
local getdkp_list_load_updateinterval	= 5;
local minimapbuttonposy					= 0;	-- default minimap button position
local minimapbuttonposx					= 0;	-- default minimap button position
local Scaling_GDC						= 70;	-- default Addon scaling
local Scaling_GDL						= 80;	-- default Addon scaling
local Scaling_GDA						= 60;	-- default Addon scaling
local GDC_Scale							= 1.0;	-- default scaling faktor
GDAConfigFrameHelpSide					= 1;
GDLConfigFrame_send_Show_alpha			= 0;

---------------------------
-- GetDKP Plus Variables --
---------------------------
function GetDKP_Reset_Data()
	multiTable = nil;
	DKPInfo = nil;
	gdkp = nil;
	DKP_ITEMS = nil;

end;
	
------------------------
-- GetDKP Plus OnLoad --
------------------------
function GetDKPConfig_OnLoad(this)
		-- Set the script as workaround for newer UI versions problem with onEvent function
		this:SetScript("OnEvent", GetDKP_Config_OnEvent);
		-- Registers an addon message prefix, allowing messages sent over addon channels with that prefix to be received by the client.
		C_ChatInfo.RegisterAddonMessagePrefix("getdkp_list_load");
		PanelTemplates_SetNumTabs(this, 4);
		GetDKP_Config_Frame.selectedTab = 1;
		PanelTemplates_UpdateTabs(this);
		this:RegisterEvent("VARIABLES_LOADED");
		this:RegisterEvent("CHAT_MSG_RAID");
		this:RegisterEvent("CHAT_MSG_ADDON");
		this:RegisterEvent("CHAT_MSG_RAID_LEADER");
		this:RegisterEvent("CHAT_MSG_RAID_WARNING");
		this:RegisterEvent("CHAT_MSG_CHANNEL");	
		this:RegisterEvent("CHAT_MSG_WHISPER");
		this:RegisterEvent("PLAYER_REGEN_DISABLED");
		this:RegisterEvent("PLAYER_REGEN_ENABLED");
		this:RegisterEvent("ZONE_CHANGED");
		this:RegisterEvent("ZONE_CHANGED_NEW_AREA");

		-- Slash Commands
		SlashCmdList["GETDKPCONFIG"] = GetDKP_Config_SlashHandler;
		SLASH_GETDKPCONFIG1 = "/gdc";
		GETDKP_CONFIGLOAD = true;
end;
-------------------------
-- GetDKP Plus VarLoad --
-------------------------
function GetDKP_VarLoad()
		if (type(GDKPvar_save) == "table") then
		GDKP_CheckConfig()
		GDL_send_Show:SetAlpha(0);
		GDL_send_Show2:SetAlpha(0);
		GetDKP_Config_All_Set_MiniMap_Positionx(GDKPvar_save.MiniMapButtonPosx);
		GetDKP_Config_All_Set_MiniMap_Positiony(GDKPvar_save.MiniMapButtonPosy);
		GetDKP_Config_Frame_CheckButton50:SetChecked(GDKPvar_save.ShowMiniMapButton);
		GetDKP_Config_Frame_CheckButtonepgp:SetChecked(GDKPvar_save.epgp);
		GetDKP_Config_Set_MiniMap_Button(GDKPvar_save.ShowMiniMapButton);
		GetDKP_Config_Frame_Slider6:SetValue(GDKPvar_save.Scaling_GDL);
		GetDKP_Config_Frame_Slider7:SetValue(GDKPvar_save.Scaling_GDA);
		GetDKP_Config_Frame_CheckButton51:SetChecked(GDKPvar_save.GDA_OnOff);
		GetDKP_Config_Frame_CheckButton89:SetChecked(GDKPvar_save.GDA_Countdown);
		GetDKP_Config_Frame_CheckButton90:SetChecked(GDKPvar_save.GDA_Loot);
		GetDKP_Config_Frame_CheckButton91:SetChecked(GDKPvar_save.GDA_Loot_GDA);
		GetDKP_Config_Frame_CheckButton92:SetChecked(GDKPvar_save.GDA_Loot_GDA_RW);
		GetDKP_Config_Frame_CheckButton1001:SetChecked(GDKPvar_save.GDA_announce_highest_bid1);
		GetDKP_Config_Frame_CheckButton1002:SetChecked(GDKPvar_save.GDA_announce_highest_bid2);
		GDC_GDA_EditBox1:SetText(GDKPvar_save.GDA_MinDKP);
		GDC_GDA_EditBox2:SetText(GDKPvar_save.GDA_BetWord);
		GDC_GDA_EditBox3:SetText(GDKPvar_save.GDA_MinDKP_Rule2);
		GDC_GDA_EditBox4:SetText(GDKPvar_save.GDA_MinDKP_Rule3);
		GDC_GDA_EditBox5:SetText(GDKPvar_save.GDA_Countdown_Time);
		GDC_GDA_EditBox6:SetText(GDKPvar_save.GDA_Countdown_Alert);
		GDC_GDA_EditBoxGWord:SetText(GDKPvar_save.GDA_GreedWord);
		--print("Debug: "..GDKPvar_save.GDA_GreedWord);
		GDC_GDA_EditBoxGDKP:SetText(GDKPvar_save.GDA_GreedDKP);
		for i=1,3,1 do 
			getglobal("GetDKP_Config_Frame_CheckButton"..(i+70)):SetChecked(nil);
			if ( i == GDKPvar_save.GDA_Rule) then
				getglobal("GetDKP_Config_Frame_CheckButton"..(i+70)):SetChecked(true);
			end;
		end;
		if (multiTable) then
			for i=1, table.getn(multiTable),1 do
				if (table.foreach(multiTable[i], VarReturn) == GDKPvar_save.konto ) then
					GDC_FrameKontoDropDown_SetSelectedID(GDC_FrameKontoDropDown, 1, table.foreach(multiTable[i], VarReturn));
				end;
			end;
		end;
		for i=1,3,1 do
			getglobal("GetDKP_Config_Frame_CheckButton"..i+31):SetChecked(nil);
			if (GDKPvar_save.GDA_Chatlook == i) then 
				getglobal("GetDKP_Config_Frame_CheckButton"..i+31):SetChecked(true);
			end;
		end;
		for i=1,5,1 do
			getglobal("GetDKP_Config_Frame_CheckButton"..i+34):SetChecked(nil);
			if (GDKPvar_save.GDA_Chatoutput == i) then 
				getglobal("GetDKP_Config_Frame_CheckButton"..i+34):SetChecked(true);
			end;
		end;
		for i = 1,3,1 do 
			getglobal("GetDKP_Config_Frame_CheckButton"..(39+i)):SetChecked(nil)
			if (GDKPvar_save.GDA_Chatlook_Rule2 == i) then
				getglobal("GetDKP_Config_Frame_CheckButton"..(39+i)):SetChecked(true);
			end;
		end;
		for i = 1,5,1 do 
			getglobal("GetDKP_Config_Frame_CheckButton"..(42+i)):SetChecked(nil)
			if (GDKPvar_save.GDA_Chatoutput_Rule2 == i) then
				getglobal("GetDKP_Config_Frame_CheckButton"..(42+i)):SetChecked(true);
			end;
		end;
		for i = 1,3,1 do 
			getglobal("GetDKP_Config_Frame_CheckButton"..(80+i)):SetChecked(nil)
			if (GDKPvar_save.GDA_Chatlook_Rule3 == i) then
				getglobal("GetDKP_Config_Frame_CheckButton"..(80+i)):SetChecked(true);
			end;
		end;
		for i = 1,5,1 do 
			getglobal("GetDKP_Config_Frame_CheckButton"..(83+i)):SetChecked(nil)
			if (GDKPvar_save.GDA_Chatoutput_Rule3 == i) then
				getglobal("GetDKP_Config_Frame_CheckButton"..(83+i)):SetChecked(true);
			end;
		end;
		GetDKP_Config_Frame_CheckButton1:SetChecked(GDKPvar_save.ShowOnlyInRaid);
		GetDKP_Config_Frame_CheckButton2:SetChecked(GDKPvar_save.requestRP);
		--GetDKP_Config_Frame_CheckButton3:SetChecked(GDKPvar_save.requestItems);
		GetDKP_Config_Frame_CheckButton4:SetChecked(GDKPvar_save.HideOutGoingWhisper);
		--GetDKP_Config_Frame_CheckButton21:SetChecked(GDKPvar_save.ShowItems);
		--GetDKP_Config_Frame_CheckButton22:SetChecked(GDKPvar_save.TokenItems);
		GetDKP_Config_Frame_CheckButton100:SetChecked(GDKPvar_save.GetDKPASK);
		if (GDKPvar_save.reportChannel == "GUILD") then
			GetDKP_Config_Frame_CheckButton5:SetChecked(true);
		else
			GetDKP_Config_Frame_CheckButton5:SetChecked(false);
		end;
		if (GDKPvar_save.reportChannel == "SAY") then
			GetDKP_Config_Frame_CheckButton6:SetChecked(true);
		else
			GetDKP_Config_Frame_CheckButton6:SetChecked(false);
		end;
		if (GDKPvar_save.reportChannel == PARTY) then
			GetDKP_Config_Frame_CheckButton7:SetChecked(true);
		else
			GetDKP_Config_Frame_CheckButton7:SetChecked(false);
		end;
		if (GDKPvar_save["reportChannel"] == "RAID") then
			GetDKP_Config_Frame_CheckButton8:SetChecked(true);
		else
			GetDKP_Config_Frame_CheckButton8:SetChecked(false);
		end;
		if (GDKPvar_save.reportChannel == "lokal") then
			GetDKP_Config_Frame_CheckButton9:SetChecked(true);
		else
			GetDKP_Config_Frame_CheckButton9:SetChecked(false);
		end;
		if (GDKPvar_save.reportChannel == "Officer") then
			GetDKP_Config_Frame_CheckButton10:SetChecked(true);
		else
			GetDKP_Config_Frame_CheckButton10:SetChecked(false);
		end;
		if (GDKPvar_save.posi_tooltip == "top") then
			GetDKP_Config_Frame_CheckButton16:SetChecked(true);
		else
			GetDKP_Config_Frame_CheckButton16:SetChecked(false);
		end;
		if (GDKPvar_save.posi_tooltip == "buttom") then
			GetDKP_Config_Frame_CheckButton17:SetChecked(true);
		else
			GetDKP_Config_Frame_CheckButton17:SetChecked(false);
		end;
		if (GDKPvar_save.posi_tooltip == "left") then
			GetDKP_Config_Frame_CheckButton18:SetChecked(true);
		else
			GetDKP_Config_Frame_CheckButton18:SetChecked(false);
		end;
		if (GDKPvar_save.posi_tooltip == "right") then
			GetDKP_Config_Frame_CheckButton19:SetChecked(true);
		else
			GetDKP_Config_Frame_CheckButton19:SetChecked(false);
		end;
		GetDKP_Config_Frame_CheckButtonMRT:SetChecked(GDKPvar_save.MRT);
		GetDKP_Config_Frame_CheckButton11:SetChecked(GDKPvar_save.showtooltip);
		GetDKP_Config_Frame_CheckButton61:SetChecked(GDKPvar_save.showtooltipraid);
		GetDKP_Config_Frame_CheckButton12:SetChecked(GDKPvar_save.minmax);
		GetDKP_Config_Frame_CheckButton13:SetChecked(GDKPvar_save.dkp);
		GetDKP_Config_Frame_CheckButton14:SetChecked(GDKPvar_save.listowner);
		GetDKP_Config_Frame_CheckButton15:SetChecked(GDKPvar_save.reportowner);
		GetDKP_Config_Frame_CheckButton20:SetChecked(GDKPvar_save.LiveDKP);
		GetDKP_Config_Frame_Slider1:SetValue(GDKPvar_save.BuyersLimit);
		GetDKP_Config_Frame_Slider2:SetValue(GDKPvar_save.NeedLimit);
	else
		GDKPvar_save.epgp = false;
		GDKPvar_save.ShowMiniMapButton = true;
		GDKPvar_save.MiniMapButtonPosx = 0;
		GDKPvar_save.MiniMapButtonPosy = 0;
		GDKPvar_save.Scaling_GDL = 65;
		GDKPvar_save.Scaling_GDC = 65;
		GDKPvar_save.Scaling_GDA = 60;
		GDKPvar_save.GDA_Rule = 1;
		GDKPvar_save.GDA_Chatlook = 1;
		GDKPvar_save.GDA_Chatoutput = 4;
		GDKPvar_save.GDA_MinDKP = 20;
		GDKPvar_save.GDA_OnOff = 1;
		GDKPvar_save.GDA_BetWord = "bet";
		GDKPvar_save.GDA_GreedWord = "greed";
		GDKPvar_save.GDA_GreedDKP = 50;
		GDKPvar_save.GDA_MinDKP_Rule2 = 50;
		GDKPvar_save.GDA_Chatlook_Rule2 = 1;
		GDKPvar_save.GDA_Chatoutput_Rule2 = 4;
		GDKPvar_save.GDA_MinDKP_Rule3 = 50;
		GDKPvar_save.GDA_Chatlook_Rule3 = 1;
		GDKPvar_save.GDA_Chatoutput_Rule3 = 4;
		GDKPvar_save.GDA_Countdown_Time = 60;
		GDKPvar_save.GDA_Countdown_Alert = 10;
		GDKPvar_save.GDA_Countdown = true;
		GDKPvar_save.GDA_Loot = true;
		GDKPvar_save.GDA_Loot_GDA = true;
		GDKPvar_save.GDA_Loot_GDA_RW = true;
		GDKPvar_save.konto = "dkp";
		GDKPvar_save.requestRP = true;
		GDKPvar_save.requestItems = true;
		GDKPvar_save.requestItem = true;
		GDKPvar_save.showtooltip = true;
		GDKPvar_save.showtooltipraid = true;
		GDKPvar_save.posi_tooltip = "top";
		GDKPvar_save.minmax = true;
		GDKPvar_save.dkp = true;
		GDKPvar_save.ignoreValue = 0;
		GDKPvar_save.listowner = true;
		GDKPvar_save.reportowner = true;
		GDKPvar_save.reportChannel = true;
		GDKPvar_save.TierDrop = true;
		GDKPvar_save.ShowOnlyInRaid = false;
		GDKPvar_save.ShowItems = true;
		GDKPvar_save.TokenItems = true;
		GDKPvar_save.GetDKPASK = true;
		GDKPvar_save.HideOutGoingWhisper = true;
		GDKPvar_save.IncomigWhisper = false;
		GDKPvar_save.NeedLimit = -1;
		GDKPvar_save.BuyersLimit = -1;
		GDKPvar_save.client = false;
		GDKPvar_save.LOOTLEVEL = 2;
		GDKPvar_save.LiveDKP = true;
		GDKPvar_save.MRT = true;
		
		GetDKP_VarLoad();
		return
	end;
	Initialized = 1;
end;	

----------------------------------
-- GetDKP Plus Check ConfigVars --
----------------------------------
function GDKP_CheckConfig()
	if GDKPvar_save.MRT == nil then
		GDKPvar_save.MRT = true;
	end
	if GDKPvar_save.epgp == nil then
		GDKPvar_save.epgp = false;
	end;
	if GDKPvar_save.GDA_announce_highest_bid1 == nil then
		GDKPvar_save.GDA_announce_highest_bid1 = false;
	end;
	if GDKPvar_save.GDA_announce_highest_bid2 == nil then
		GDKPvar_save.GDA_announce_highest_bid2 = false;
	end;
	if GDKPvar_save.ShowMiniMapButton == nil then
		GDKPvar_save.ShowMiniMapButton = true;
	end;
	if GDKPvar_save.MiniMapButtonPosx == nil then
		GDKPvar_save.MiniMapButtonPosx = 0;
	end;
	if GDKPvar_save.MiniMapButtonPosy == nil then
		GDKPvar_save.MiniMapButtonPosy = 0;
	end;
	if GDKPvar_save.Scaling_GDL == nil then
		GDKPvar_save.Scaling_GDL = 65;
	end;
	if GDKPvar_save.Scaling_GDC == nil then
		GDKPvar_save.Scaling_GDC = 65;
	end;
	if GDKPvar_save.Scaling_GDA == nil then
		GDKPvar_save.Scaling_GDA = 60;
	end;
	if GDKPvar_save.GDA_Rule == nil then
		GDKPvar_save.GDA_Rule = 1;
	end;
	if GDKPvar_save.GDA_Chatlook == nil then
		GDKPvar_save.GDA_Chatlook = 1;
	end;
	if GDKPvar_save.GDA_Chatoutput == nil then
		GDKPvar_save.GDA_Chatoutput = 4;
	end;
	if GDKPvar_save.GDA_MinDKP == nil then
		GDKPvar_save.GDA_MinDKP = 20;
	end;
	if GDKPvar_save.GDA_OnOff == nil then
		GDKPvar_save.GDA_OnOff = false;
	end;
	if GDKPvar_save.GDA_BetWord == nil then
		GDKPvar_save.GDA_BetWord = "bet";
	end;
	if GDKPvar_save.GDA_GreedWord == nil then
		GDKPvar_save.GDA_GreedWord = "greed";
	end;
	if GDKPvar_save.GDA_GreedDKP == nil then
		GDKPvar_save.GDA_GreedDKP = "50";
	end;
	if GDKPvar_save.GDA_MinDKP_Rule2 == nil then
		GDKPvar_save.GDA_MinDKP_Rule2 = 50;
	end;
	if GDKPvar_save.GDA_Chatlook_Rule2 == nil then
		GDKPvar_save.GDA_Chatlook_Rule2 = 1;
	end;
	if GDKPvar_save.GDA_Chatoutput_Rule2 == nil then
		GDKPvar_save.GDA_Chatoutput_Rule2 = 4;
	end;
	if GDKPvar_save.GDA_MinDKP_Rule3 == nil then
		GDKPvar_save.GDA_MinDKP_Rule3 = 50;
	end;
	if GDKPvar_save.GDA_Chatlook_Rule3 == nil then
		GDKPvar_save.GDA_Chatlook_Rule3 = 1;
	end;
	if GDKPvar_save.GDA_Chatoutput_Rule3 == nil then
		GDKPvar_save.GDA_Chatoutput_Rule3 = 4;
	end;
	if GDKPvar_save.GDA_Countdown_Time == nil then
		GDKPvar_save.GDA_Countdown_Time = 60;
	end;
	if GDKPvar_save.GDA_Countdown_Alert == nil then
		GDKPvar_save.GDA_Countdown_Alert = 10;
	end;
	if GDKPvar_save.GDA_Countdown == nil then
		GDKPvar_save.GDA_Countdown = true;
	end;
	if GDKPvar_save.konto == nil then
		if (multiTable) then
			GDKPvar_save.konto = table.foreach(multiTable[1], VarReturn);
		end;
	else
		if (multiTable) then
			j = 0;
			if (table.getn(multiTable) == 1) then
				GDKPvar_save.konto = table.foreach(multiTable[1], VarReturn);
			else
				for i=1,table.getn(multiTable),1 do
					if  (table.foreach(multiTable[i], VarReturn) == GDKPvar_save.konto) then
						j = 1 ;
					end;
				end;
				if (j == 0) then
					GDKPvar_save.konto = table.foreach(multiTable[1], VarReturn);
				end;
			end;
		end;
	end;

	if GDKPvar_save.requestRP == nil then
		GDKPvar_save.requestRP = true ;
	end;
	
	if GDKPvar_save.requestItems == nil then 
		GDKPvar_save.requestItems = true ;
	end;
		
	if GDKPvar_save.requestItem == nil then 
		GDKPvar_save.requestItem = true ;
	end;	
	if GDKPvar_save.showtooltip == nil then 
		GDKPvar_save.showtooltip = true ;
	end;
	if GDKPvar_save.showtooltipraid == nil then 
		GDKPvar_save.showtooltipraid = true ;
	end;
	if GDKPvar_save.posi_tooltip == nil then 
		GDKPvar_save.posi_tooltip = "top" ;
	end;
	
	if GDKPvar_save.minmax == nil then 
		GDKPvar_save.minmax = true ;
	end;
	
	if GDKPvar_save.dkp == nil then 
		GDKPvar_save.dkp = true
	end;
	
	if GDKPvar_save.ignoreValue == nil then 
		GDKPvar_save.ignoreValue = 0 ;
	end;
	
	if GDKPvar_save.listowner == nil then 
		GDKPvar_save.listowner = true;
	end;
	
	if GDKPvar_save.reportowner == nil then 
		GDKPvar_save.reportowner = true ;
	end;
	
	if GDKPvar_save.reportChannel == nil then 
		GDKPvar_save.reportChannel = "lokal" ;
	end;
	
	if GDKPvar_save.TierDrop == nil then 
		GDKPvar_save.TierDrop = true ;
	end;
	
	if GDKPvar_save.ShowOnlyInRaid == nil then 
		GDKPvar_save.ShowOnlyInRaid = false;
	end;
	
	if GDKPvar_save.ShowItems == nil then 
		GDKPvar_save.ShowItems = true
	end;
	
	if GDKPvar_save.TokenItems == nil then 
		GDKPvar_save.TokenItems = true
	end;
	
	if GDKPvar_save.GetDKPASK == nil then 
		GDKPvar_save.GetDKPASK = true
	end;
	
	if GDKPvar_save.HideOutGoingWhisper == nil then 
		GDKPvar_save.HideOutGoingWhisper = true
	end
	
	if GDKPvar_save.IncomingWhisper == nil then
		GDKPvar_save.IncomingWhisper = false
	end;	
	
	if GDKPvar_save.NeedLimit == nil then
		GDKPvar_save.NeedLimit = 0 ;
	end;

	if GDKPvar_save.BuyersLimit == nil then
		GDKPvar_save.BuyersLimit = 0 ;
	end;

	if GDKPvar_save.client == nil then
		GDKPvar_save.client = false;
	end;
	if GDKPvar_save.LOOTLEVEL == nil then
		GDKPvar_save.LOOTLEVEL = 2;
	end;
	
	if GDKPvar_save.LiveDKP == nil then
		GDKPvar_save.LiveDKP = true;
	end;
	
	if GDKPvar_save.GDA_Loot_GDA == nil then
		GDKPvar_save.GDA_Loot_GDA = true;
	end;
end;




-------------------
-- Slash Handler --
-------------------
function GetDKP_Config_SlashHandler(msg)
	local numArgs, result, _args;
	--debug(msg);
	if (msg == "") then
		GetDKP_Config_Toggle();
	else
		if string.lower(msg) == "whisperitems off" then
			GDKP_SetOptionValue("requestItems",false);
			return  ;
		elseif 	string.lower(msg) == "whisperitems on" then
			GDKP_SetOptionValue("requestItems",true);
			return  ;	
		elseif 	string.lower(msg) == "whisperdkp off" then
			GDKP_SetOptionValue("requestRP",false);
			return  ;	
		elseif 	string.lower(msg) == "whisperdkp on" then
			GDKP_SetOptionValue("requestRP",true);
			return  ;	
		elseif 	(string.lower(msg) == "tooltip on") or (string.lower(msg) == "tooltip an") then
			GDKP_SetOptionValue("showtooltip",true);
			return  ;			
		elseif 	(string.lower(msg) == "tooltip off") or (string.lower(msg) == "tooltip aus") then
			GDKP_SetOptionValue("showtooltip",false);
			return  ;
		elseif 	string.lower(msg) == "status" then
			GDKP_show("GetDKP Plus "..GDKP_VERSION.." Status");
			GDKP_show("Raidonly:  "..GDKPvar_save.ShowOnlyInRaid) ;				
			GDKP_show(TEXT_DKP_REQ_ITEMS..": "..GDKPvar_save.requestItems) ;
			GDKP_show(TEXT_DKP_REQ_DKP..": "..GDKPvar_save.requestRP) ;
			GDKP_show(TEXT_DKP_REQ_SHOW..": "..GDKPvar_save.HideOutGoingWhisper) ;
			GDKP_show(TEXT_DKP_OUTPUT_CHAN..": "..GDKPvar_save.reportChannel) ;	
			GDKP_show(TEXT_DKP_Tooltip..": "..GDKPvar_save.showtooltip  ) ;
			GDKP_show(TEXT_DKP_Tooltip_Raid..": "..GDKPvar_save.showtooltipraid  ) ;
			GDKP_show(TEXT_DKP_Tooltip..":  "..GDKPvar_save.posi_tooltip ) ;
			GDKP_show(TEXT_DKP_Tooltip.." Min/Max: "..GDKPvar_save.minmax ) ;	
			GDKP_show(TEXT_DKP_Tooltip.." DKP:  "..GDKPvar_save.dkp ) ;			
			GDKP_show(TEXT_DKP_Tooltip.." List Buyers:  "..GDKPvar_save.listowner ) ;	
			GDKP_show(TEXT_DKP_Tooltip.." Report Buyers:  "..GDKPvar_save.reportowner) ;
			GDKP_show("Live DKP: "..GDKPvar_save.LiveDKP) ;
			return  ;	
		elseif 	string.lower(msg) == "help" then
			GDKP_Display_Help();
			return  ;			
		elseif 	(string.lower(msg) == "tooltip top") or (string.lower(msg) == "tooltip oben") then
			GDKP_SetOptionValue("posi_tooltip","top");
			return  ;		
		elseif 	(string.lower(msg) == "tooltip left") or (string.lower(msg) == "tooltip links") then
			GDKP_SetOptionValue("posi_tooltip","left");
			return  ;		
		elseif 	(string.lower(msg) == "tooltip right") or (string.lower(msg) == "tooltip rechts") then
			GDKP_SetOptionValue("posi_tooltip","right");
			return  ;		
		elseif 	(string.lower(msg) == "tooltip bottom") or (string.lower(msg) == "tooltip unten") then
			GDKP_SetOptionValue("posi_tooltip","buttom");
			return  ;			
		elseif 	(string.lower(msg) == "tooltip minmax on") or (string.lower(msg) == "tooltip minmax an") then
			GDKP_SetOptionValue("minmax",true);
			return  ;		
		elseif 	(string.lower(msg) == "tooltip minmax off") or (string.lower(msg) == "tooltip minmax aus") then
			GDKP_SetOptionValue("minmax",false);
			return  ;		
		elseif 	(string.lower(msg) == "tooltip dkp off") or (string.lower(msg) == "tooltip dkp aus") then
			GDKP_SetOptionValue("dkp",false);
			return  ;		
		elseif 	(string.lower(msg) == "tooltip dkp an") or (string.lower(msg) == "tooltip dkp on") then
			GDKP_SetOptionValue("dkp",true);
			return  ;		
		elseif 	(string.lower(msg) == "tooltip listbuyers an") or (string.lower(msg) == "tooltip listbuyers on") then
			GDKP_SetOptionValue("listowner",true);
			return  ;		
		elseif 	(string.lower(msg) == "tooltip listbuyers aus") or (string.lower(msg) == "tooltip listbuyers off") then
			GDKP_SetOptionValue("listowner",false);
			return  ;		
		elseif 	(string.lower(msg) == "tooltip reportbuyers an") or (string.lower(msg) == "tooltip reportbuyers on") then
			GDKP_SetOptionValue("reportowner",true);
			return  ;		
		elseif 	(string.lower(msg) == "tooltip reportbuyers aus") or (string.lower(msg) == "tooltip reportbuyers off") then
			GDKP_SetOptionValue("reportowner",false);
			return  ;		
		elseif 	(string.lower(msg) == "raidonly aus") or (string.lower(msg) == "raidonly off") then
			GDKP_SetOptionValue("ShowOnlyInRaid",false);
			return  ;
		elseif 	(string.lower(msg) == "raidonly an") or (string.lower(msg) == "raidonly on") then
			GDKP_SetOptionValue("ShowOnlyInRaid",true);
			return  ;		
		elseif 	(string.lower(msg) == "reset")  then
			GDKP_ResetConfig();
			return  ;
		elseif 	(string.lower(msg) == "whisperhide an") or  (string.lower(msg) == "whisperhide on")  then	
			GDKP_SetOptionValue("HideOutGoingWhisper",true);
			return
		elseif 	(string.lower(msg) == "whisperhide aus") or  (string.lower(msg) == "whisperhide off")  then	
			GDKP_SetOptionValue("HideOutGoingWhisper",false);
			return
		elseif string.sub(string.lower(msg),1,9) == "needlimit" then	
			GDKP_SetOptionValue("NeedLimit",string.sub(msg, 11 ,-1) );
			return	
		elseif string.sub(string.lower(msg),1,11) == "buyerslimit" then	
			GDKP_SetOptionValue("BuyersLimit",string.sub(msg, 13 ,-1) );
			return	
		elseif 	(string.lower(msg) == "livedkp on") or (string.lower(msg) == "livedkp an") then
			GDKP_SetOptionValue("LiveDKP",true);
			return;
		elseif 	(string.lower(msg) == "livedkp off") or (string.lower(msg) == "livedkp aus") then
			GDKP_SetOptionValue("LiveDKP",false);
			return;
		end;
		_args = GDKP_GetArgs(msg, " ");
		if (string.lower(_args[1]) == string.lower(TEXT_DKP_SETACCOUNT)) then
			GDKP_SetOptionValue(_args[1],_args[2]);
		elseif (string.lower(_args[1]) == "outputchannel") then
			GDKP_DKPO(_args[2]);
		elseif (string.lower(_args[1]) == "info") then
			GDKP_Info(_args[2]);
		end;
	end;
end

-------------------
-- Event Handler --
-------------------
function GetDKP_Config_OnEvent(self, event, ... )
	local arg1, arg2, arg3, arg4 = ...;
	if (event == "VARIABLES_LOADED") then
		GetDKP_VarLoad();
		return;
	elseif (event == "ZONE_CHANGED" or event =="ZONE_CHANGED_NEW_AREA") then
		GetDKP_Zone();
	elseif (event =="CHAT_MSG_ADDON") then
		
		if (arg1 == "getdkp_list_load" and arg4 ~= UnitName("player")) then 
			GetDKP_List_Load_Resiv(arg1,arg2,arg3,arg4);
		end;
	else
		return;
	end;
end;
-------------------- 
-- List Handler --
--------------------
function GetDKP_List_Load_Resiv(arg1,arg2,arg3,arg4)
	_args = GDKP_GetArgs(arg2, ",");
	
	if(not IsPromoted()) then
		print("You are not promoted");
	end;

	if (_args[1] == "ASK" and GetDKP_CheckifPlayerIsInRaid(UnitName("player")) and IsPromoted() and GDKPvar_save.GetDKPASK) then
		GDC_GDL_ASK_SEND:Show();
	end;
	
	if (_args[1] == "StartUI") then
		print(GDC_RESIV1..arg4);
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
		i= 1;
		if (multiTable) then
			GDL_DKP_LIST = table.foreach(multiTable[i], VarReturn) ;
		end;
		getdkp_list_load_empfang = nil;
		getdkp_itemids = {};
		GDKP_CheckConfig() ;
		GetDKP_VarLoad();
		GetDKP_List_VarLoad();
		GetDKPAdmin_VarLoad()
		GetDKP_Zone();
		
		
	end;
	if (_args[1] == "time") then
		if (DKPInfo) then
			if (DKPInfo.timestamp == nil) then
				DKPInfo["timestamp"] = 0;
			end;
		end;
		if (not DKPInfo ) then
			getdkp_list_load_empfang = true;
			gdkp = nil;
			multiTable = {};
			DKPInfo = {};
			gdkp = {};
			gdkp.players = {};
			DKP_ITEMS = {} ;
		elseif(tonumber(DKPInfo["timestamp"]) < tonumber(_args[2])) then
			getdkp_list_load_empfang = true;
			gdkp = nil ;
			multiTable = {};
			DKPInfo = {};
			gdkp = {};
			gdkp.players = {};
			DKP_ITEMS = {} ;
		end;
	end;
	if (getdkp_list_load_empfang == true ) then
		if (_args[1] == "multiTable" and _args[2] ~= "start" and _args[2] ~= "end") then
			print(GDC_RESIV2..arg4);
			_args[2] = tonumber(_args[2]);
			multiTable[_args[2]] = {};
			multiTable[_args[2]][_args[3]] = {};
			multiTable[_args[2]][_args[3]]["name"] = _args[4];
			multiTable[_args[2]][_args[3]]["disc"] = _args[5];
			multiTable[_args[2]][_args[3]]["events"] = _args[6];
		end;
		if (_args[1] == "DKPInfo" and _args[2] ~= "start" and _args[2] ~= "end") then
		
			DKPInfo[_args[2]] = _args[3];
		end;
		if (_args[1] == "gdkp" and _args[2] ~= "start" and _args[2] ~= "end") then
				if( not gdkp.players[_args[2]]) then
					gdkp.players[_args[2]] = {};
				end;
				gdkp.players[_args[2]]["class"] = _args[8];
				gdkp.players[_args[2]]["rcount"] = tonumber(_args[9]);
				gdkp.players[_args[2]][_args[3].."_earned"] = tonumber(_args[7]);
				gdkp.players[_args[2]][_args[3].."_spend"] = tonumber(_args[5]);
				gdkp.players[_args[2]][_args[3].."_adjust"] = tonumber(_args[6]);
				gdkp.players[_args[2]][_args[3].."_current"] = tonumber(_args[4]);
		end;
		if (_args[1] == "DKP_ITEMS" and _args[2] ~= "start" and _args[2] ~= "end") then
				_args[3] = tonumber(_args[3]);
				if (not DKP_ITEMS[_args[2]]) then
					DKP_ITEMS[_args[2]] = {};
				end;
				if (not DKP_ITEMS[_args[2]]["Items"]) then
					DKP_ITEMS[_args[2]]["Items"] = {};
				end;
				if (not DKP_ITEMS[_args[2]]["Items"][_args[3]]) then
					DKP_ITEMS[_args[2]]["Items"][_args[3]] = {};
				end;
				DKP_ITEMS[_args[2]]["Items"][_args[3]]["name"] = _args[4];
				DKP_ITEMS[_args[2]]["Items"][_args[3]]["dkp"] = tonumber(_args[5]);
		end;
	end;
end;

function GetDKP_List_Load_Send()
local konto , dkpchars ;
dkpcharlen = {};
	if (DKPInfo) then
		if (DKPInfo.timestamp == nil ) then
			print("no timestamp wrong getdkp.php");
			return;
		end;
	end;
	
	if (DKPInfo and multiTable and GetDKP_CheckifPlayerIsInRaid(UnitName("player")) and IsPromoted() and not getdkp_list_load_empfang) then
		getdkp_list_load_issend = 1;
		
		if (getdkp_list_load_multitable == true and getdkp_list_load_dkpinfo == false and getdkp_list_load_gdkp == false and getdkp_list_load_dkpitems == false) then
			a = 0;
			for key, val in pairs(DKP_ITEMS) do
				for i=1,getn(DKP_ITEMS[key]["Items"]),1 do 
					a = a + 1;
				end;
			end;
			for key, val in pairs(gdkp.players) do
				for i=1,getn(multiTable),1 do 
					a = a + 1;
				end;
			end;
			getdkp_list_load_statusbarlen = getn(multiTable) + a + 7;
			getdkp_list_load_statusbar_values = 1;
			
			GetDKP_Config_Frame_Send_StatusBar:SetMinMaxValues(0,getdkp_list_load_statusbarlen);
			GetDKP_Config_Frame_Send_StatusBar:SetValue(getdkp_list_load_statusbar_values);
			GetDKP_Config_Frame_Send_StatusBar2:SetMinMaxValues(0,getdkp_list_load_statusbarlen);
			GetDKP_Config_Frame_Send_StatusBar2:SetValue(getdkp_list_load_statusbar_values);
			GDL_send_Show:Show();
			GDL_send_Show2:Show();
			getdkpcharlen = 0;
			C_ChatInfo.SendAddonMessage("getdkp_list_load","time,"..DKPInfo["timestamp"],"RAID");
			C_ChatInfo.SendAddonMessage("getdkp_list_load","multiTable,start","RAID");
			for i=1,getn(multiTable),1 do 
				konto = table.foreach(multiTable[i], VarReturn);
				dkpchars = "multiTable,"..i..","..konto..","..multiTable[i][konto].name..","..multiTable[i][konto].disc..","..multiTable[i][konto].events;
				
				if ( strlen(dkpchars) < 244 ) then
					C_ChatInfo.SendAddonMessage("getdkp_list_load",dkpchars,"RAID");
					getdkp_list_load_statusbar_values = getdkp_list_load_statusbar_values + 1
					
				else
					--debug (dkpchars);
					return
				end;
			end;
			C_ChatInfo.SendAddonMessage("getdkp_list_load","multiTable,end","RAID");
			
		end;
		if (getdkp_list_load_multitable == true and getdkp_list_load_dkpinfo == true and getdkp_list_load_gdkp == false and getdkp_list_load_dkpitems == false) then
		
			C_ChatInfo.SendAddonMessage("getdkp_list_load","DKPInfo,start","RAID");
			C_ChatInfo.SendAddonMessage("getdkp_list_load","DKPInfo,".."date,"..DKPInfo["date"],"RAID");
			C_ChatInfo.SendAddonMessage("getdkp_list_load","DKPInfo,".."timestamp,"..DKPInfo["timestamp"],"RAID");
			C_ChatInfo.SendAddonMessage("getdkp_list_load","DKPInfo,".."process_dkp_ver,"..DKPInfo["process_dkp_ver"],"RAID");
			C_ChatInfo.SendAddonMessage("getdkp_list_load","DKPInfo,".."total_players,"..DKPInfo["total_players"],"RAID");
			C_ChatInfo.SendAddonMessage("getdkp_list_load","DKPInfo,".."total_items,"..DKPInfo["total_items"],"RAID");
			C_ChatInfo.SendAddonMessage("getdkp_list_load","DKPInfo,".."total_points,"..DKPInfo["total_points"],"RAID");
			C_ChatInfo.SendAddonMessage("getdkp_list_load","DKPInfo,end","RAID");
			getdkp_list_load_statusbar_values = getdkp_list_load_statusbar_values + 7
			
		end;
		if (getdkp_list_load_multitable == true and getdkp_list_load_dkpinfo == true and getdkp_list_load_gdkp == true and getdkp_list_load_dkpitems == false) then
			getdkpcharlen = 0;
			C_ChatInfo.SendAddonMessage("getdkp_list_load","gdkp,start","RAID");
			for key, val in pairs(gdkp.players) do
				for i=1,getn(multiTable),1 do 
					konto = table.foreach(multiTable[i], VarReturn);
					dkpchars = "gdkp,"..key..","..konto..","..val[konto.."_current"]..","..val[konto.."_spend"]..","..val[konto.."_adjust"]..","..val[konto.."_earned"]..","..val.class..","..val.rcount;
					getdkpcharlen = getdkpcharlen + strlen(dkpchars);
					if (getdkpcharlen > 4000) then
						
						for j=1,150000000,1 do
						end;
						getdkpcharlen = 0;
					end;
					if ( strlen(dkpchars) < 244 ) then
						C_ChatInfo.SendAddonMessage("getdkp_list_load",dkpchars,"RAID");	
						getdkp_list_load_statusbar_values = getdkp_list_load_statusbar_values + 1;
					else
						--debug (dkpchars);
						return
					end;
				end;
			end;
			C_ChatInfo.SendAddonMessage("getdkp_list_load","gdkp,end","RAID");
		end;
		
		if (getdkp_list_load_multitable == true and getdkp_list_load_dkpinfo == true and getdkp_list_load_gdkp == true and getdkp_list_load_dkpitems == true) then
			C_ChatInfo.SendAddonMessage("getdkp_list_load","DKP_ITEMS,start","RAID");
			for key, val in pairs(DKP_ITEMS) do
				if (getdkp_list_load_char_overvlow == "" or getdkp_list_load_char_overvlow == key) then
					if (getdkp_list_load_char_overvlow == key) then
						getdkp_list_load_char_overvlow = "";
					end;
					for i=1,getn(DKP_ITEMS[key]["Items"]),1 do 
						dkpchars = "DKP_ITEMS,"..key..","..i..","..DKP_ITEMS[key]["Items"][i].name..","..DKP_ITEMS[key]["Items"][i].dkp
						
						getdkpcharlen = getdkpcharlen + strlen(dkpchars);
						if (getdkpcharlen > 4000) then
							getdkp_list_load_char_overvlow = key;
							getdkpcharlen = 0;
							
							return;
						end;
						if ( strlen(dkpchars) < 244 and getdkp_list_load_char_overvlow == "") then
							C_ChatInfo.SendAddonMessage("getdkp_list_load",dkpchars,"RAID");
							getdkp_list_load_statusbar_values = getdkp_list_load_statusbar_values + 1;
						else
							--debug (dkpchars);
							return
						end;
						
					end;
				end;
			end;
		
			C_ChatInfo.SendAddonMessage("getdkp_list_load","DKP_ITEMS,end","RAID");
			
			getdkp_list_load_issend = 0;
			getdkp_list_load_multitable = false;
			getdkp_list_load_dkpinfo = false;
			getdkp_list_load_gdkp = false;
			getdkp_list_load_dkpitems = false;
			GDL_send_Show:Hide();
			GDL_send_Show2:Hide();
			GDC_GDL_ASK_SEND_BUTTON2:Show();
			GDC_GDL_ASK_SEND_BUTTON1:Show();
			GDC_GDL_ASK_SEND:Hide();
			GetDKP_Config_Frame_Send_StatusBar:SetMinMaxValues(0,0);
			GetDKP_Config_Frame_Send_StatusBar:SetValue(0);
			C_ChatInfo.SendAddonMessage("getdkp_list_load","StartUI","RAID");
		end;
	else
		print("Sending of data failed");
	end;
end;
function GetDKP_List_Load_Ask()
	C_ChatInfo.SendAddonMessage("getdkp_list_load","ASK","RAID");
end;
--------------------
-- UpDate Handler --
--------------------

function GetDKP_Config_OnUpdate(this, elapsed)
	this.TimeSinceLastUpdate = this.TimeSinceLastUpdate + elapsed; 	
	if (this.TimeSinceLastUpdate > GDL_UpdateInterval and getdkp_list_load_issend == 1 and GDLConfigFrame_send_Show_alpha == 0 ) then
		a = GDL_send_Show:GetAlpha();
		a = a + 0.03;
		GDL_send_Show:SetAlpha(a);
		this.TimeSinceLastUpdate = 0;
		if (a > 0.9) then
			GDLConfigFrame_send_Show_alpha = 1;
			
		end;
	elseif (this.TimeSinceLastUpdate > GDL_UpdateInterval and getdkp_list_load_issend == 1 and GDLConfigFrame_send_Show_alpha == 1 ) then
		a = GDL_send_Show:GetAlpha();
		a = a - 0.03;
		GDL_send_Show:SetAlpha(a);
		this.TimeSinceLastUpdate = 0;
		if (a < 0.1) then
			GDLConfigFrame_send_Show_alpha = 0;
		end;
	end
	if (this.TimeSinceLastUpdate > GDL_UpdateInterval and GetDKP_Config_Frame:GetAlpha() < 1 ) then
		a = GetDKP_Config_Frame:GetAlpha();
		a = a + 0.1;
		GetDKP_Config_Frame:SetAlpha(a);
		this.TimeSinceLastUpdate = 0;
	end
end;
function GetDKP_Config_OnUpdate2(this, elapsed)
	this.TimeSinceLastUpdate2 = this.TimeSinceLastUpdate2 + elapsed;
	GetDKP_Config_Frame_Send_StatusBar:SetValue(getdkp_list_load_statusbar_values);
	GetDKP_Config_Frame_Send_StatusBar2:SetValue(getdkp_list_load_statusbar_values);
	if (this.TimeSinceLastUpdate2 > getdkp_list_load_updateinterval and getdkp_list_load_issend == 1) then
		
		if (getdkp_list_load_multitable == false) then
			getdkp_list_load_multitable = true;
		elseif (getdkp_list_load_multitable == true and getdkp_list_load_dkpinfo == false) then
			getdkp_list_load_dkpinfo = true;
			
		elseif (getdkp_list_load_multitable == true and getdkp_list_load_dkpinfo == true and getdkp_list_load_gdkp == false) then
			getdkp_list_load_gdkp = true;
		elseif (getdkp_list_load_multitable == true and getdkp_list_load_dkpinfo == true and getdkp_list_load_gdkp == true and getdkp_list_load_dkpitems == false) then
			getdkp_list_load_dkpitems = true;
		end;
		GetDKP_List_Load_Send();
		this.TimeSinceLastUpdate2 = 0;
	end;
end;
function GetDKP_Config_OnUpdate3(this, elapsed)
	this.TimeSinceLastUpdate3 = this.TimeSinceLastUpdate3 + elapsed; 	
	if (this.TimeSinceLastUpdate3 > GDL_UpdateInterval and getdkp_list_load_issend == 1 and GDLConfigFrame_send_Show_alpha2 == 0 ) then
		a = GDL_send_Show2:GetAlpha();
		a = a + 0.03;
		GDL_send_Show2:SetAlpha(a);
		this.TimeSinceLastUpdate3 = 0;
		if (a > 0.9) then
			GDLConfigFrame_send_Show_alpha2 = 1;
			
		end;
	elseif (this.TimeSinceLastUpdate3 > GDL_UpdateInterval and getdkp_list_load_issend == 1 and GDLConfigFrame_send_Show_alpha2 == 1 ) then
		a = GDL_send_Show2:GetAlpha();
		a = a - 0.03;
		GDL_send_Show2:SetAlpha(a);
		this.TimeSinceLastUpdate3 = 0;
		if (a < 0.1) then
			GDLConfigFrame_send_Show_alpha2 = 0;
		end;
	end
end;
-----------------------------
-- GetDKP Plus Check Zone  --
-----------------------------
function GetDKP_Zone()
	if (multiTable) then
	ZoneName = GetZoneText();
	for i= 1,table.getn(multiTable),1 do
		konto = table.foreach(multiTable[i], VarReturn);
		if (ZoneName == multiTable[i][konto].events) then
			GDKPvar_save.konto = table.foreach(multiTable[i], VarReturn);
			GDC_FrameKontoDropDown_SetSelectedID(GDC_FrameKontoDropDown, 1, table.foreach(multiTable[i], VarReturn));
			--debug(ZoneName);
		end;
	end;
	end;
end;
-----------------------------
-- GetDKP Plus List Column --
-----------------------------
function GDC_FrameColumn_SetWidth(width, frame)
	if ( not frame ) then
		frame = this;
	end;
	frame:SetWidth(width);
	getglobal(frame:GetName().."Middle"):SetWidth(width - 9);
end;
---------------------------------------
-- GetDKP Plus Config Dropdown Konto --
---------------------------------------
function GDC_FrameKontoDropDown_Initialize()
	local info, tmpvarname;
	if (multiTable) then
		if (table.getn(multiTable) == 1) then
			tmpvarname = table.foreach(multiTable[1], VarReturn);
			info = {
				value	= tmpvarname;
				text	= multiTable[1][tmpvarname]["name"];
				func = GDC_FrameKontoDropDown_OnClick;
			};
			UIDropDownMenu_AddButton(info);
		else
			for i=1,table.getn(multiTable),1 do
				tmpvarname = table.foreach(multiTable[i], VarReturn);
				--print("DEBUG: "..tmpvarname.." / "..multiTable[i][tmpvarname]["name"]);
				info = {
					value	= tmpvarname;
					text	= multiTable[i][tmpvarname]["name"];
					func	= GDC_FrameKontoDropDown_OnClick;
				};
				UIDropDownMenu_AddButton(info);
			end;
		end;
	else
	
	end;
end;

function GDC_FrameKontoDropDown_OnLoad(this)
	if (multiTable) then
		i=1;
		UIDropDownMenu_Initialize(this, GDC_FrameKontoDropDown_Initialize);
		if (table.getn(multiTable) == 1) then
			GDC_FrameKontoDropDown_SetSelectedID(GDC_FrameKontoDropDown, 1, table.foreach(multiTable[1], VarReturn));
		else
			if (GDKPvar_save.konto == nil) then
				GDC_FrameKontoDropDown_SetSelectedID(GDC_FrameKontoDropDown, 1, table.foreach(multiTable[1], VarReturn));
			else
				kontofound = 0;
				for i=1,table.getn(multiTable),1 do
					if table.foreach(multiTable[i], VarReturn) == GDKPvar_save.konto then
						kontofound = i;
					end;
				end;
				if kontofound > 0 then
					GDC_FrameKontoDropDown_SetSelectedID(GDC_FrameKontoDropDown, kontofound, table.foreach(multiTable[kontofound], VarReturn));
				else
					GDC_FrameKontoDropDown_SetSelectedID(GDC_FrameKontoDropDown, 1, table.foreach(multiTable[1], VarReturn));
					GDKPvar_save.konto = table.foreach(multiTable[1], VarReturn);
				end;
			end;
		end;
		UIDropDownMenu_SetWidth(GDC_FrameKontoDropDown,60);
		UIDropDownMenu_SetButtonWidth(GDC_FrameKontoDropDown,24);
		UIDropDownMenu_JustifyText(GDC_FrameKontoDropDown,"LEFT")
	end;
end;

function GDC_FrameKontoDropDown_OnClick(this, button)
	GDC_FrameKontoDropDown_DDID = this:GetID();
	if (table.getn(multiTable) == 1) then
		GDC_FrameKontoDropDown_SetSelectedID(GDC_FrameKontoDropDown, GDC_FrameKontoDropDown_DDID, table.foreach(multiTable[1], VarReturn));
		GDKPvar_save.konto = table.foreach(multiTable[1], VarReturn);
	else	
		GDC_FrameKontoDropDown_SetSelectedID(GDC_FrameKontoDropDown, GDC_FrameKontoDropDown_DDID, table.foreach(multiTable[GDC_FrameKontoDropDown_DDID], VarReturn));
		GDKPvar_save.konto = table.foreach(multiTable[GDC_FrameKontoDropDown_DDID], VarReturn);
	end;
end;
function GDC_FrameKontoDropDown_SetSelectedID(frame, id, names)
	UIDropDownMenu_SetSelectedID(frame, id);
	if( not frame ) then
		frame = this;
	end;
	UIDropDownMenu_SetText(frame , names);
end;
-------------------------------------------
-- GetDKP Plus Config Dropdown LOOTLEVEL --
-------------------------------------------
function GDC_FrameLOOTLEVELDropDown_Initialize()
	local info;
	
		info = {
				text = GDC_LOOTLEVEL2;
				func = GDC_FrameLOOTLEVELDropDown_OnClick;
				};
		UIDropDownMenu_AddButton(info);
		info = {
				text = GDC_LOOTLEVEL3;
				func = GDC_FrameLOOTLEVELDropDown_OnClick;
				};
		UIDropDownMenu_AddButton(info);
		info = {
				text = GDC_LOOTLEVEL4;
				func = GDC_FrameLOOTLEVELDropDown_OnClick;
				};
		UIDropDownMenu_AddButton(info);
end;

function GDC_FrameLOOTLEVELDropDown_OnLoad(this)
	--GetDKP_VarLoad();
	UIDropDownMenu_Initialize(this, GDC_FrameLOOTLEVELDropDown_Initialize);
	if	(GDKPvar_save.LOOTLEVEL == nil) then
		GDC_FrameLOOTLEVELDropDown_SetSelectedID(GDC_FrameLOOTLEVELDropDown, 1, GDC_LOOTLEVEL2);
		GDCTEST = 1;
	else
		if (GDKPvar_save.LOOTLEVEL-1 == 1) then
			GDCDDNAME = GDC_LOOTLEVEL2
		elseif (GDKPvar_save.LOOTLEVEL-1 == 2) then
			GDCDDNAME = GDC_LOOTLEVEL3
		elseif (GDKPvar_save.LOOTLEVEL-1 == 3) then
			GDCDDNAME = GDC_LOOTLEVEL4
		else
			GDCDDNAME = GDC_LOOTLEVEL2
		end;
		GDC_FrameLOOTLEVELDropDown_SetSelectedID(GDC_FrameLOOTLEVELDropDown, GDKPvar_save.LOOTLEVEL-1, GDCDDNAME);
	end;
	UIDropDownMenu_SetWidth(GDC_FrameLOOTLEVELDropDown,60);
	UIDropDownMenu_SetButtonWidth(GDC_FrameLOOTLEVELDropDown,24);
	UIDropDownMenu_JustifyText(GDC_FrameLOOTLEVELDropDown, "LEFT")
end;

function GDC_FrameLOOTLEVELDropDown_OnClick(this, button)
	GDC_FrameLOOTLEVELDropDown_DDID = this:GetID();
	if (GDC_FrameLOOTLEVELDropDown_DDID == 1) then
		GDCDDNAME = GDC_LOOTLEVEL2
	elseif (GDC_FrameLOOTLEVELDropDown_DDID == 2) then
		GDCDDNAME = GDC_LOOTLEVEL3
	elseif (GDC_FrameLOOTLEVELDropDown_DDID == 3) then
		GDCDDNAME = GDC_LOOTLEVEL4
	else
		GDCDDNAME = GDC_LOOTLEVEL2
	end;
	GDC_FrameLOOTLEVELDropDown_SetSelectedID(GDC_FrameLOOTLEVELDropDown, GDC_FrameKontoDropDown_DDID,GDCDDNAME);
	GDKPvar_save.LOOTLEVEL = GDC_FrameLOOTLEVELDropDown_DDID + 1;
end;

function GDC_FrameLOOTLEVELDropDown_SetSelectedID(frame, id, names)
	UIDropDownMenu_SetSelectedID(frame, id);
	if( not frame ) then
		frame = this;
	end;
	UIDropDownMenu_SetText(frame, names);
	UIDropDownMenu_SetText(frame, names);
end;

----------------------------------
-- GetDKP Plus Config Functions --
----------------------------------
function GDC_Close()
	--debug ("test");
end;

function GetDKP_Config_OnShow()
	if ( GetDKP_Config_Frame.selectedTab == 1 ) then
		GDPConfig();
	end;
	if ( GetDKP_Config_Frame.selectedTab == 2 ) then
		GDAConfig();
	end;
	if ( GetDKP_Config_Frame.selectedTab == 3 ) then
		GDLConfig();
	end;
	if ( GetDKP_Config_Frame.selectedTab == 4 ) then
		SCALEConfig();
	end;
end;

function GetDKP_Config_Bindings(id)
	if (id == 1) then
		GetDKP_Config_Frame.selectedTab = id;
		PanelTemplates_UpdateTabs(this);
		GDPConfig();
	end;
	if (id == 2) then
		GetDKP_Config_Frame.selectedTab = id;
		PanelTemplates_UpdateTabs(this);
		GDAConfig();
	end;
	if (id == 3) then
		GetDKP_Config_Frame.selectedTab = id;
		PanelTemplates_UpdateTabs(this);
		GDLConfig();
	end;
	if (id == 4) then
		GetDKP_Config_Frame.selectedTab = id;
		PanelTemplates_UpdateTabs(this);
		SCALEConfig();
	end;
end;

function GetDKP_Config_ShowHide_MiniMap_Button()
	if (GDKPvar_save.ShowMiniMapButton) then
		GetDKP_Config_ButtonFrame:Show();
	else
		GetDKP_Config_ButtonFrame:Hide();
	end
end

function GetDKP_Config_Toggle()
	if (GetDKP_Config_Frame:IsVisible()) then
		GetDKP_Config_Frame:Hide();
	else
		GetDKP_Config_Frame:SetAlpha(0.0);
		GetDKP_VarLoad();
		GetDKP_Config_Frame:Show();
		GetDKP_Config_OnShow();
		GDCFrameTitleText:SetFont("Interface\\AddOns\\GetDKP\\Font\\MORPHEUS.TTF", 12,"OUTLINE, MONOCHROME");
		GDCFrameTitleText:SetText(GDC_Title);
		
	end;
end;


function GetDKP_Config_Raidonly()
	if (GetDKP_Config_Frame_CheckButton1:GetChecked()) then
		GDKPvar_save.ShowOnlyInRaid = true;
	else
		GDKPvar_save.ShowOnlyInRaid = false;
	end
end
function GetDKP_Config_ShowItems()
	if (GetDKP_Config_Frame_CheckButton21:GetChecked()) then
		GDKPvar_save.ShowItems = true;
	else
		GDKPvar_save.ShowItems = false;
	end
end
function GetDKP_Config_Whisperdkp()
	if (GetDKP_Config_Frame_CheckButton2:GetChecked()) then
		GDKPvar_save.requestRP = true ;
	else
		GDKPvar_save.requestRP = false ;
	end
end
function GetDKP_Config_TokenItems()
	if (GetDKP_Config_Frame_CheckButton22:GetChecked()) then
		GDKPvar_save.TokenItems = true;
	else
		GDKPvar_save.TokenItems = false;
	end
end
function GetDKP_Config_epgp()
	if (GetDKP_Config_Frame_CheckButtonepgp:GetChecked()) then
		GDKPvar_save.epgp = true;
	else
		GDKPvar_save.epgp = false;
	end
end
function GetDKP_Config_MRT()
	if (GetDKP_Config_Frame_CheckButtonMRT:GetChecked()) then
		GDKPvar_save.MRT = true;
		GetDKP_RegisterMRTNotify();
	else
		GDKPvar_save.MRT = false;
		GetDKP_UnregisterMRTNotify();
	end
end
function GetDKP_Config_GetDKPASK()
	if (GetDKP_Config_Frame_CheckButton100:GetChecked()) then
		GDKPvar_save.GetDKPASK = true;
	else
		GDKPvar_save.GetDKPASK = false;
	end
end
function GetDKP_Config_Whisperitem()
	if (GetDKP_Config_Frame_CheckButton3:GetChecked()) then
		GDKPvar_save.requestItems = true;
	else
		GDKPvar_save.requestItems= false;
	end
end
function GetDKP_Config_Whisperhide()
	if (GetDKP_Config_Frame_CheckButton4:GetChecked()) then
		GDKPvar_save.HideOutGoingWhisper = true;
	else
		GDKPvar_save.HideOutGoingWhisper = false;
	end
end
function GetDKP_Config_Chat()
	if (GetDKP_Config_Frame_CheckButton5:GetChecked()) then
		GDKPvar_save.reportChannel = "GUILD";
	end
	if (GetDKP_Config_Frame_CheckButton6:GetChecked()) then
		GDKPvar_save.reportChannel = "SAY";
	end
	if (GetDKP_Config_Frame_CheckButton7:GetChecked()) then
		GDKPvar_save.reportChannel = "PARTY";
	end
	if (GetDKP_Config_Frame_CheckButton8:GetChecked()) then
		GDKPvar_save.reportChannel = "RAID";
	end
	if (GetDKP_Config_Frame_CheckButton9:GetChecked()) then
		GDKPvar_save.reportChannel = "lokal";
	end
	if (GetDKP_Config_Frame_CheckButton10:GetChecked()) then
		GDKPvar_save.reportChannel = "Officer";
	end
	
end
function GetDKP_Config_Tooltip()
	if (GetDKP_Config_Frame_CheckButton11:GetChecked()) then
		GDKPvar_save.showtooltip = true;
	else
		GDKPvar_save.showtooltip = false;
	end
end
function GetDKP_Config_Tooltip_Raid()
	if (GetDKP_Config_Frame_CheckButton61:GetChecked()) then
		GDKPvar_save.showtooltipraid = true;
	else
		GDKPvar_save.showtooltipraid = false;
	end
end
function GetDKP_Config_Tooltipminmax()
	if (GetDKP_Config_Frame_CheckButton12:GetChecked()) then
		GDKPvar_save.minmax = true;
	else
		GDKPvar_save.minmax= false;
	end
end
function GetDKP_Config_Tooltipdkp()
	if (GetDKP_Config_Frame_CheckButton13:GetChecked()) then
		GDKPvar_save.dkp = true;
	else
		GDKPvar_save.dkp = false;
	end
end
function GetDKP_Config_Tooltipbuyers()
	if (GetDKP_Config_Frame_CheckButton14:GetChecked()) then
		GDKPvar_save.listowner = true;
	else
		GDKPvar_save.listowner= false;
	end
end
function GetDKP_Config_Tooltipreport()
	if (GetDKP_Config_Frame_CheckButton15:GetChecked()) then
		GDKPvar_save.reportowner = true;
	else
		GDKPvar_save.reportowner = false;
	end
end
function GetDKP_Config_DKPLive()
	if (GetDKP_Config_Frame_CheckButton20:GetChecked()) then
		GDKPvar_save.LiveDKP = true;
	else
		GDKPvar_save.LiveDKP = false;
	end
end
function GetDKP_Config_Tooltipposition()
	if (GetDKP_Config_Frame_CheckButton16:GetChecked()) then
		GDKPvar_save.posi_tooltip = "top";
	end
	if (GetDKP_Config_Frame_CheckButton17:GetChecked()) then
		GDKPvar_save.posi_tooltip = "buttom";
	end
	if (GetDKP_Config_Frame_CheckButton18:GetChecked()) then
		GDKPvar_save.posi_tooltip = "left";
	end
	if (GetDKP_Config_Frame_CheckButton19:GetChecked()) then
		GDKPvar_save.posi_tooltip = "right";
	end
end
function GetDKP_Config_Buyerslimit(value)
	GDKPvar_save.BuyersLimit = value;
end
function GetDKP_Config_Needlimit(value)
	GDKPvar_save.NeedLimit = value;
end
function GetDKP_Config_Skalierung_GDL(value)
	GDKPvar_save.Scaling_GDL = value;
	GDL_Scale = (GDKPvar_save.Scaling_GDL / 100);
	unsavedscale = 1 - UIParent:GetEffectiveScale() + GDL_Scale;	
	GetDKP_List_Frame:SetScale(unsavedscale);
	--debug (unsavedscale);
	GDL_Model_Scale();
	--getglobal("GDL_Itemlist_Model"):SetScale(unsavedscale);
end;
function GetDKP_Config_Skalierung_GDC(value)
	GDKPvar_save.Scaling_GDC = value;
end;
function GetDKP_Config_Skalierung_GDA(value)
	GDKPvar_save.Scaling_GDA = value;
	
	GDA_Scale = (GDKPvar_save.Scaling_GDA / 100);
	unsavedscale = 1 - UIParent:GetEffectiveScale() + GDA_Scale;	
	GetDKPAdmin_Frame:SetScale(unsavedscale);
end;

function GetDKP_Config_GDA_EditBox_OnEnterPressed(value)
	GDKPvar_save.GDA_MinDKP = tonumber(GDC_GDA_EditBox1:GetText());
	GDKPvar_save.GDA_BetWord = GDC_GDA_EditBox2:GetText()
	GDKPvar_save.GDA_MinDKP_Rule2 = tonumber(GDC_GDA_EditBox3:GetText());
	GDKPvar_save.GDA_MinDKP_Rule3 = tonumber(GDC_GDA_EditBox4:GetText());
	GDKPvar_save.GDA_Countdown_Time = tonumber(GDC_GDA_EditBox5:GetText());
	GDKPvar_save.GDA_Countdown_Alert = tonumber(GDC_GDA_EditBox6:GetText());
	GDKPvar_save.GDA_GreedWord = GDC_GDA_EditBoxGWord:GetText();
	GDKPvar_save.GDA_GreedDKP = tonumber(GDC_GDA_EditBoxGDKP:GetText());
	if (GDKPvar_save.GDA_Countdown_Alert >= GDKPvar_save.GDA_Countdown_Time) then
		GDKPvar_save.GDA_Countdown_Time = GDKPvar_save.GDA_Countdown_Alert + 1;
		GDC_GDA_EditBox5:SetText(GDKPvar_save.GDA_Countdown_Time);
	end;
	getglobal("GDC_GDA_EditBox"..value):ClearFocus();
end;
function GetDKP_Config_GDA_Rule(value)
	for i=1,3,1 do
		getglobal("GetDKP_Config_Frame_CheckButton"..(i+70)):SetChecked(nil)
		getglobal("GDAConfigFrameRule"..i):Hide();
		if (value == i)	then 
			getglobal("GetDKP_Config_Frame_CheckButton"..(i+70)):SetChecked(true)
			getglobal("GDAConfigFrameRule"..i):Show();
			GDAConfigCountdownFrame:Hide();	
		end;
	end;
	GDKPvar_save.GDA_Rule = value;
end;
function GetDKP_Config_Countdown()
	if ( GDAConfigCountdownFrame:IsVisible()) then
		for i = 1,3,1 do
			if (getglobal("GetDKP_Config_Frame_CheckButton"..(i+70)):GetChecked()) then
				getglobal("GDAConfigFrameRule"..i):Show();
			end;
		end;
		GDAConfigCountdownFrame:Hide();	
	else
		for i=1,3,1 do
			getglobal("GDAConfigFrameRule"..i):Hide();
		end;
		GDAConfigCountdownFrame:Show();
	end;
end;
function GetDKP_Config_Countdown_OnOff()
	GDKPvar_save.GDA_Countdown = false;
	if (getglobal("GetDKP_Config_Frame_CheckButton89"):GetChecked()) then
		GDKPvar_save.GDA_Countdown = true;
	end;
end;
function GetDKP_Config_Loot_OnOff()
	GDKPvar_save.GDA_Loot = false;	
	if (getglobal("GetDKP_Config_Frame_CheckButton90"):GetChecked()) then
		GDKPvar_save.GDA_Loot = true;
	end;
end;
function GetDKP_Config_Loot_GDA_OnOff()
	GDKPvar_save.GDA_Loot_GDA = false;	
	if (getglobal("GetDKP_Config_Frame_CheckButton91"):GetChecked()) then
		GDKPvar_save.GDA_Loot_GDA = true;
	end;
end;
function GetDKP_Config_Loot_GDA_RW()
	GDKPvar_save.GDA_Loot_GDA_RW = false;
	if (getglobal("GetDKP_Config_Frame_CheckButton92"):GetChecked()) then
		GDKPvar_save.GDA_Loot_GDA_RW = true;
	end;
end;
function GetDKP_Config_GDA_Rule1_ChatLook(value)
	GDKPvar_save.GDA_Chatlook = value;
end;
function GetDKP_Config_GDA_Rule1_ChatOutput(value)
	GDKPvar_save.GDA_Chatoutput = value;
end;

function GetDKP_Config_announce_highest_bid1()
	if (getglobal("GetDKP_Config_Frame_CheckButton1001"):GetChecked()) then 
		GDKPvar_save.GDA_announce_highest_bid1 = true;
	else 
		GDKPvar_save.GDA_announce_highest_bid1 = false;
	end;

end;

function GetDKP_Config_announce_highest_bid2()
	if (getglobal("GetDKP_Config_Frame_CheckButton1002"):GetChecked()) then 
		GDKPvar_save.GDA_announce_highest_bid2 = true;
	else 
		GDKPvar_save.GDA_announce_highest_bid2 = false;
	end;

end;

function GetDKP_Config_GDA_OnOff()
	if (getglobal("GetDKP_Config_Frame_CheckButton51"):GetChecked()) then 
		GetDKPAdmin_OnOff_Button:SetText(GDC_GDA_Off);
		GDKPvar_save.GDA_OnOff = true;
	else 
		GetDKPAdmin_OnOff_Button:SetText(GDC_GDA_On);
		GDKPvar_save.GDA_OnOff = false;
	end;
end;

function GDAConfigFrameHelpToggleButtonPlus()
	if (GDAConfigFrameHelpSide < 4) then
		GDAConfigFrameHelpSide = GDAConfigFrameHelpSide + 1;
		
	end;
	if (GDAConfigFrameHelpSide == 4) then
		GDAConfigFrameHelpToggleButtonNext:Disable();
	else
		GDAConfigFrameHelpToggleButtonNext:Enable();
	end;
	GDAConfigFrameHelpToggleButtonPrev:Enable();
	
	GDAConfigHelpText:SetText(GDC_GDA_HELP_TEXT[GDAConfigFrameHelpSide]);
end;
function GDAConfigFrameHelpToggleButtonMinus()
	if (GDAConfigFrameHelpSide > 1) then
		GDAConfigFrameHelpSide = GDAConfigFrameHelpSide - 1;
	end;	
	if (GDAConfigFrameHelpSide == 1) then
		GDAConfigFrameHelpToggleButtonPrev:Disable();
	else	
		GDAConfigFrameHelpToggleButtonPrev:Enable();
	end;
	GDAConfigFrameHelpToggleButtonNext:Enable();
	GDAConfigHelpText:SetText(GDC_GDA_HELP_TEXT[GDAConfigFrameHelpSide]);
end;
function GetDKP_Config_GDA_Rule2_ChatLook(value)
	for i = 1,3,1 do 
		getglobal("GetDKP_Config_Frame_CheckButton"..(39+i)):SetChecked(nil)
		if (value == i) then
			getglobal("GetDKP_Config_Frame_CheckButton"..(39+i)):SetChecked(true);
		end;
	end;
	GDKPvar_save.GDA_Chatlook_Rule2 = value;
end;
function GetDKP_Config_GDA_Rule2_ChatOutput(value)
	for i = 1,5,1 do 
		getglobal("GetDKP_Config_Frame_CheckButton"..(42+i)):SetChecked(nil)
		if (value == i) then
			getglobal("GetDKP_Config_Frame_CheckButton"..(42+i)):SetChecked(true);
		end;
	end;
	GDKPvar_save.GDA_Chatoutput_Rule2 = value;
end;
function GetDKP_Config_GDA_Rule3_ChatLook(value)
	for i = 1,3,1 do 
		getglobal("GetDKP_Config_Frame_CheckButton"..(80+i)):SetChecked(nil)
		if (value == i) then
			getglobal("GetDKP_Config_Frame_CheckButton"..(80+i)):SetChecked(true);
		end;
	end;
	GDKPvar_save.GDA_Chatlook_Rule3 = value;
end;
function GetDKP_Config_GDA_Rule3_ChatOutput(value)
	for i = 1,5,1 do 
		getglobal("GetDKP_Config_Frame_CheckButton"..(83+i)):SetChecked(nil)
		if (value == i) then
			getglobal("GetDKP_Config_Frame_CheckButton"..(83+i)):SetChecked(true);
		end;
	end;
	GDKPvar_save.GDA_Chatoutput_Rule3 = value;
end;
---------------------------
-- The Minimap Functions --
---------------------------
function GetDKP_Config_All_Set_MiniMap_Button()
	if (GetDKP_Config_Frame_CheckButton50:GetChecked()) then
		GetDKP_Config_Set_MiniMap_Button(true);
	else
		GetDKP_Config_Set_MiniMap_Button(false);
	end
end
function GetDKP_Config_All_Set_MiniMap_Positionx(value)
	GetDKP_Config_Set_MiniMap_Positionx(value);
end

function GetDKP_Config_All_Set_MiniMap_Positiony(value)
	GetDKP_Config_Set_MiniMap_Positiony(value);
end

function GetDKP_Config_Set_MiniMap_Button(newvalue)
	GDKPvar_save.ShowMiniMapButton = newvalue;
	GetDKP_Config_ShowHide_MiniMap_Button();
end

function GetDKP_Config_Set_MiniMap_Positionx(newvalue)
	GDKPvar_save.MiniMapButtonPosx = newvalue;
	GetDKP_Config_Button_UpdatePosition();
end
function GetDKP_Config_Set_MiniMap_Positiony(newvalue)
	GDKPvar_save.MiniMapButtonPosy = newvalue;
	GetDKP_Config_Button_UpdatePosition();
end

function GetDKP_Config_Button_OnClick(this, button)

	if (button == "RightButton") then
		point, relativeTo, relativePoint, xOfs, yOfs = GetDKP_Config_ButtonFrame:GetPoint()
		--GetDKP_Config_Set_MiniMap_Positionx(xOfs);
		--GetDKP_Config_Set_MiniMap_Positiony(yOfs);
		GetDKP_Config_Toggle();
	elseif (button == "LeftButton") then
		point, relativeTo, relativePoint, xOfs, yOfs = GetDKP_Config_ButtonFrame:GetPoint()
		--GetDKP_Config_Set_MiniMap_Positionx(xOfs);
		--GetDKP_Config_Set_MiniMap_Positiony(yOfs);
		GetDKP_List_Toggle();
	end;
end;	
function GetDKP_Config_Button_Tooltip(this)
local getdkptooltip = this;
	GameTooltip_SetDefaultAnchor(GameTooltip, getdkptooltip);
	GameTooltip:SetText("GetDKP PLUS "..GDKP_VERSION);
	GameTooltip:Show();
end;

function GetDKP_Config_Button_UpdatePosition()
	GetDKP_Config_ButtonFrame:SetPoint(
			"CENTER",
			"Minimap",
			"LEFT",
			GDKPvar_save.MiniMapButtonPosx,
			GDKPvar_save.MiniMapButtonPosy
	);
	--GetDKP_Config_ButtonFrame:SetPoint(
		--"TOPLEFT",
		--"Minimap",
		--"TOPLEFT",
		--55 - (GDKPvar_save.MiniMapButtonPosy * cos(GDKPvar_save.MiniMapButtonPosx)),
		--(GDKPvar_save.MiniMapButtonPosy * sin(GDKPvar_save.MiniMapButtonPosx)) - 55
	--);
end;
function GetDKP_Config_Button_Move()
	this:StartMoving();
				this.isMoving = true;
end;


---------------------------
-- Toggle Back Frames   --
---------------------------
function GDPConfig()
	GDPConfigFrame:Show();
	GDAConfigFrame:Hide();
	GDLConfigFrame:Hide();
	SCALEConfigFrame:Hide();
	GDAConfigFrameHelp:Hide();
	GDAConfigCountdownFrame:Hide();
end;
function GDAConfig()
	GDPConfigFrame:Hide();
	GDAConfigFrame:Show();
	for i=1,3,1 do
		getglobal("GDAConfigFrameRule"..i):Hide();
		if (i == GDKPvar_save.GDA_Rule)	then 
			getglobal("GDAConfigFrameRule"..i):Show();
		end;	
	end;
	GDLConfigFrame:Hide();
	SCALEConfigFrame:Hide();
	GDAConfigFrameHelp:Hide();
	GDAConfigCountdownFrame:Hide();
end;
function GDLConfig()
	GDPConfigFrame:Hide();
	GDAConfigFrame:Hide();
	GDLConfigFrame:Show();
	SCALEConfigFrame:Hide();
	GDAConfigFrameHelp:Hide();
	GDAConfigCountdownFrame:Hide();
	if (GetDKP_CheckifPlayerIsInRaid(UnitName("player"))) then
		if (IsPromoted()) then	
			getglobal("GetDKP_Config_Frame_Send"):Show();
		else
			getglobal("GetDKP_Config_Frame_Send"):Hide();
		end;
	else
		getglobal("GetDKP_Config_Frame_Send"):Hide();
	end;
	
end;
function SCALEConfig()
	GDPConfigFrame:Hide();
	GDAConfigFrame:Hide();
	GDLConfigFrame:Hide();
	SCALEConfigFrame:Show();
	GDAConfigFrameHelp:Hide();
	GDAConfigCountdownFrame:Hide();
end;

-- **************************************** OLD GetDKP Config Function ***************************** --
-- sets GETDKP Options --
function GDKP_SetOptionValue(_option,_value)

	if (_option == nil) or (_value == nil) or (_option == "") or (_value == "") then
		return
	end;
	if _option =="requestRP" then
		GDKPvar_save.requestRP = _value ;
		GDKP_show("GETDKP: "..TEXT_DKP_REQ_DKP.._value) ;
	elseif _option =="requestItems" then 
		GDKPvar_save.requestItems = _value ;
		GDKP_show("GETDKP: "..TEXT_DKP_REQ_ITEMS.._value) ;
	elseif _option =="requestItem" then 
		GDKPvar_save.requestItem = _value ;
		GDKP_show("GETDKP: "..TEXT_DKP_REQ_ITEM.._value) ;
	elseif string.lower(_option) == string.lower(TEXT_DKP_SETACCOUNT) then
		GDKPvar_save.konto = _value ;
		GDKP_show("GETDKP: "..TEXT_DKP_SETACCOUNT.." = ".._value);
	elseif _option =="showtooltip" then 
		GDKPvar_save.showtooltip = _value ;
		GDKP_show("GETDKP: "..TEXT_DKP_Tooltip.._value) ;
	elseif _option =="showtooltipraid" then 
		GDKPvar_save.showtooltipraid = _value ;
		GDKP_show("GETDKP: "..TEXT_DKP_Tooltip_Raid.._value) ;
	elseif _option =="posi_tooltip" then 
		GDKPvar_save.posi_tooltip = _value ;
		GDKP_show("GETDKP: "..TEXT_DKP_Tooltip..GDKPvar_save.posi_tooltip) ;
	elseif _option =="minmax" then 
		GDKPvar_save.minmax = _value ;
		GDKP_show("GETDKP: "..TEXT_DKP_Tooltip.." MinMax: "..GDKPvar_save.minmax) ;
	elseif _option =="dkp" then 
		GDKPvar_save.dkp = _value ;
		GDKP_show("GETDKP: "..TEXT_DKP_Tooltip.." DKP: "..GDKPvar_save.dkp) ;
	elseif _option =="ignoreValue" then 
		GDKPvar_save.ignoreValue = _value ;
	elseif _option =="listowner" then 
		GDKPvar_save.listowner = _value ;
		GDKP_show("GETDKP: "..TEXT_DKP_Tooltip.." List Buyers: "..GDKPvar_save.listowner) ;	
	elseif _option =="reportowner" then 
		GDKPvar_save.reportowner = _value ;
		GDKP_show("GETDKP: "..TEXT_DKP_Tooltip.." Report Buyers: "..GDKPvar_save.reportowner) ;	
	elseif _option =="TierDrop" then 
		GDKPvar_save.TierDrop = _value ;
		GDKP_show("GETDKP: "..TEXT_DKP_Tooltip.." Setinformations and Dropchance: "..GDKPvar_save.TierDrop) ;			
	elseif _option == "ShowOnlyInRaid" then
		GDKPvar_save.ShowOnlyInRaid = _value
		GDKP_show("GETDKP: "..TEXT_DKP_ShowOnlyInRaid..": "..GDKPvar_save.ShowOnlyInRaid) ;			
	elseif _option == "HideOutGoingWhisper" then
		GDKPvar_save.HideOutGoingWhisper = _value
		GDKP_show("GETDKP: "..TEXT_DKP_REQ_SHOW..": "..GDKPvar_save.HideOutGoingWhisper) ;			
	elseif _option == "NeedLimit" then
		if tonumber(_value) > -1 and tonumber(_value) < 41 then
			GDKPvar_save.NeedLimit = _value
			GDKP_show("GETDKP Needlimit: "..GDKPvar_save.NeedLimit) ;			
		end;	
	elseif _option == "BuyersLimit" then
		if tonumber(_value) > -1 and tonumber(_value) < 41 then
			GDKPvar_save.BuyersLimit = _value
			GDKP_show("GETDKP BuyersLimit: "..GDKPvar_save.BuyersLimit) ;			
		end;			
	elseif _option == "ShowNonSet" then
		GDKPvar_save.ShowNonSet = _value
		GDKP_show("GETDKP: "..TEXT_DKP_ShowNonSet..": "..GDKPvar_save.ShowNonSet) ;	
	elseif _option =="LiveDKP" then 
		GDKPvar_save.LiveDKP = _value ;
		GDKP_show("GETDKP: LiveDKP: "..GDKPvar_save.LiveDKP) ;	
	end;
end;


-- reset all GDKP Vars !!
function GDKP_ResetConfig()
	GDKPvar_save.konto = "dkp";
	GDKPvar_save.requestRP = true ;
	GDKPvar_save.requestItems = true ;
	GDKPvar_save.requestItem = true ;
	GDKPvar_save.showtooltip = true ;
	GDKPvar_save.showtooltipraid = true ;
	GDKPvar_save.posi_tooltip = "top" ;
	GDKPvar_save.minmax = true ;
	GDKPvar_save.dkp = true
	GDKPvar_save.ignoreValue = 0 ;
	GDKPvar_save.listowner = true;
	GDKPvar_save.reportowner = true ;
	GDKPvar_save.reportChannel = "RAID" ;
	GDKPvar_save.TierDrop = true ;
	GDKPvar_save.ShowOnlyInRaid = false
	GDKPvar_save.HideOutGoingWhisper = true
	GDKPvar_save.IncomingWhisper = false
	GDKPvar_save.NeedLimit = 0 ;
	GDKPvar_save.BuyersLimit = 0 ;
	GDKPvar_save.ShowNonSet = true;
	GDKPvar_save.LiveDKP = true;
	GDKPvar_save.LOOTLEVEL = 2;
	GDKPvar_save.GetDKPASK = true;
	GDKPvar_save.epgp = false;
	GDKPvar_save.ShowMiniMapButton = true;
	GDKPvar_save.MRT = true;
	GDKPvar_save.ShowItems = true;
	GDKPvar_save.WODConfigInit = true;
GDKP_show('GETDKP Config reset done !')
end;


function GDKP_Display_Help()
	GDKP_show(TEXT_DKP_HELP_Raidonly)
	GDKP_show(TEXT_DKP_HELP_BUYERLIMIT);
	GDKP_show(TEXT_DKP_HELP_NEEDLIMIT);
	GDKP_show(TEXT_DKP_HELP_DKPO);	
	GDKP_show(TEXT_DKP_HELP_REQ_DKP);	
	--GDKP_show(TEXT_DKP_HELP_REQ_ITEM);
	GDKP_show(TEXT_DKP_HELP_HIDE_WHISPER);
	--GDKP_show(TEXT_DKP_HELP_ITEM) ;	
	--GDKP_show(TEXT_DKP_HELP_ITEMS) ;	
	GDKP_show(TEXT_DKP_HELP_Tooltip);	
	GDKP_show(TEXT_DKP_HELP_TooltipP);
	GDKP_show(TEXT_DKP_HELP_TooltipMM);
	GDKP_show(TEXT_DKP_HELP_TTDKP);
	GDKP_show(TEXT_DKP_HELP_TTLO);
	GDKP_show(TEXT_DKP_HELP_TTLO_REP);	
	GDKP_show(TEXT_DKP_HELP_Info)	;
	GDKP_show(TEXT_DKP_HELP_Status)	;
	GDKP_show(TEXT_DKP_HELP_DKPPlus);
	GDKP_show(TEXT_DKP_HELP_DKPMinus);
	GDKP_show(TEXT_DKP_HELP_DKPNSPlus);
	GDKP_show(TEXT_DKP_HELP_DKPNSMinus);
	GDKP_show(TEXT_DKP_HELP_DKP_Live);
	GDKP_show(TEXT_DKP_HELP_Whisper);		
end;

function GDKP_DKPO(msg)
	if (msg ~= nil) and (msg ~= "") then
		if string.lower(msg) ==	"gilde" or string.lower(msg) ==	"guild" then
			msg = "GUILD"
		elseif string.lower(msg) ==	"gruppe" or string.lower(msg) == "group" then
			msg = "PARTY"
		elseif string.lower(msg) ==	"lokal" or string.lower(msg) ==	"local" then
			msg = "lokal"
		elseif string.lower(msg) ==	"sagen" or string.lower(msg) ==	"say" then
			msg = "SAY"
		elseif string.lower(msg) ==	"offizier" or string.lower(msg) ==	"officer" then
			msg = "Officer"	
		elseif string.lower(msg) ==	"raid" then
			msg = "RAID"
		end;
		
		if (msg == "lokal") or (msg == "RAID") or (msg == "PARTY") or (msg == "GUILD") or (msg == "SAY") or (msg == "Officer") then
			GDKPvar_save.reportChannel = msg
			GDKP_Output(TEXT_DKP_OUTPUT_CHAN..": "..GDKPvar_save.reportChannel,"lokal")
		end;	
	end;	
end;
function GDKP_Info(msg)
	if (msg ~= nil) and (msg ~= "") then
		if string.lower(msg) ==	"gilde" or string.lower(msg) ==	"guild" then
			msg = "GUILD"
		elseif string.lower(msg) ==	"gruppe" or string.lower(msg) == "group" then
			msg = "PARTY"
		elseif string.lower(msg) ==	"lokal" or string.lower(msg) ==	"local" then
			msg = "lokal"
		elseif string.lower(msg) ==	"sagen" or string.lower(msg) ==	"say" then
			msg = "SAY"
		elseif string.lower(msg) ==	"offizier" or string.lower(msg) ==	"officer" then
			msg = "Officer"	
		elseif string.lower(msg) ==	"raid" then
			msg = "RAID"
		end;
			if (msg == "lokal") or (msg == "RAID") or (msg == "PARTY") or (msg == "GUILD") or (msg == "SAY") or (msg == "Officer") then
				if DKPInfo.date ~= nil then
					GDKP_Output(TEXT_DKP_DATE..DKPInfo.date, msg)
				end;
				if DKPInfo.process_dkp_ver ~= nil then
					GDKP_Output(TEXT_DKP_DKPLIST..DKPInfo.process_dkp_ver, msg)
				end;
	
				if DKPInfo.total_players ~= nil then
					GDKP_Output(TEXT_DKP_PLAYERS_TOTAL..DKPInfo.total_players, msg)
				end;
			
				if DKPInfo.total_items ~= nil then
					GDKP_Output(TEXT_DKP_ITEMS_TOTAL..DKPInfo.total_items, msg)
				end;
				
				if DKPInfo.total_points ~= nil then
					GDKP_Output(TEXT_DKP_POINTS_TOTAL..DKPInfo.total_points, msg)
				end;
				
				if DKPInfo.set_items ~= nil then
					GDKP_Output(TEXT_DKP_ITEMS_SET..DKPInfo.set_items, msg)
				end;
				
				if DKPInfo.nonset_items ~= nil then
					GDKP_Output(TEXT_DKP_ITEMS_NONSET..DKPInfo.nonset_items, msg)
				end;
				
				if DKPInfo.total_points_set ~= nil then
					GDKP_Output(TEXT_DKP_POINTS_SET..DKPInfo.total_points_set, msg)
				end;
				
				if DKPInfo.total_points_ns ~= nil then
					GDKP_Output(TEXT_DKP_POINTS_NONSET..DKPInfo.total_points_ns, msg)
				end;
			end;
	end;
end;

---------------- Global GetDKP used Functions ----------------------
function findpattern(text, pattern, start)
	if (string.find(text, pattern, start) ~= nil) then
		return string.sub(text, string.find(text, pattern, start));
	else
		return
	end;
end;
function VarReturn (k)
	return k;
end;
function mytabledebug(msg1)
	myDebugVariableTree = {};
	myDebugVariableTree.selectedIndex = 0;
	myDebugVariableFrameEditBox:SetText(msg1);
	myDebugVariableFrame_BuildNode(nil, 0, msg1);
	myDebugVariableFrame_Update();
	ShowUIPanel(myDebugFrame);
end;
function debug(msg1,msg2,msg3,msg4,msg5,msg6,msg7)
	GDKP_show(msg1)
	GDKP_show(msg2)
	GDKP_show(msg3)
	GDKP_show(msg4)
	GDKP_show(msg5)
	GDKP_show(msg6)
	GDKP_show(msg7)
end;