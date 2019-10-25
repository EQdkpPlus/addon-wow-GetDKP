-------------------------------------------------------------------
---- GetDKP Plus																----
---- Copyright (C) 2006-2018 EQdkp-Plus Developer Team			----
---- You should have received a copy of the GNU Affero			----
---- General Public License along with this program. If not,	----
---- see http://www.gnu.org/licenses/.									----
-------------------------------------------------------------------

local full  = {};
local Original_ChatFrame_OnHyperlinkShow;
local Orig_ChatFrame_OnHyperlinkClick;
local links;
local GETDKP_TOOLTIP_ITEMNAME = "" ;
local TooltipLinesLocal = 1 ;
local WHISPER_PREFIX = "<GETDKP>";
local allowWhisper = true ;
local Original_CT_RaidTracker_SaveNote;
local Original_CT_RaidTracker_SaveCost;
GDKP_Player_NoItems = {};
GDKP_SET_TEST = GDKP;
nodata_shown = true;




function checkrealmname(realmname)
	local tableRealms = {}
		table.insert(tableRealms, "Aerie Peak");
		table.insert(tableRealms, "Area 52");
		table.insert(tableRealms, "Argent Dawn");
		table.insert(tableRealms, "Booty Bay");
		table.insert(tableRealms, "Borean Tundra");
		table.insert(tableRealms, "Bronze Dragonflight");
		table.insert(tableRealms, "Burning Blade");
		table.insert(tableRealms, "Burning Legion");
		table.insert(tableRealms, "Burning Steppes");
		table.insert(tableRealms, "Chamber of Aspects");
		table.insert(tableRealms, "Chants \195\169ternels");
		table.insert(tableRealms, "Colinas Pardas");
		table.insert(tableRealms, "Confr\195\169rie du Thorium");
		table.insert(tableRealms, "Conseil des Ombres");
		table.insert(tableRealms, "Culte de la Rive noire");
		table.insert(tableRealms, "Darkmoon Faire");
		table.insert(tableRealms, "Das Konsortium");
		table.insert(tableRealms, "Das Syndikat");
		table.insert(tableRealms, "Defias Brotherhood");
		table.insert(tableRealms, "Der Abyssische Rat");
		table.insert(tableRealms, "Der Mithrilorden");
		table.insert(tableRealms, "Der Rat von Dalaran");
		table.insert(tableRealms, "Die Aldor");
		table.insert(tableRealms, "Die Arguswacht");
		table.insert(tableRealms, "Die ewige Wacht");
		table.insert(tableRealms, "Die Nachtwache");
		table.insert(tableRealms, "Die Silberne Hand");
		table.insert(tableRealms, "Die Todeskrallen");
		table.insert(tableRealms, "Dun Modr");
		table.insert(tableRealms, "Dun Morogh");
		table.insert(tableRealms, "Earthen Ring");
		table.insert(tableRealms, "Emerald Dream");
		table.insert(tableRealms, "Festung der St\195\188rme");
		table.insert(tableRealms, "Grim Batol");
		table.insert(tableRealms, "Howling Fjord");
		table.insert(tableRealms, "Khaz Modan");
		table.insert(tableRealms, "Kirin Tor");
		table.insert(tableRealms, "Kul Tiras");
		table.insert(tableRealms, "Kult der Verdammten");
		table.insert(tableRealms, "La Croisade \195\169carlate");
		table.insert(tableRealms, "Laughing Skull");
		table.insert(tableRealms, "Les Clairvoyants");
		table.insert(tableRealms, "Les Sentinelles");
		table.insert(tableRealms, "Lich King");
		table.insert(tableRealms, "Lightning's Blade");
		table.insert(tableRealms, "Los Errantes");
		table.insert(tableRealms, "Mar\195\169cage de Zangar");
		table.insert(tableRealms, "Pozzo dell'Eternit\195\160");
		table.insert(tableRealms, "Scarshield Legion");
		table.insert(tableRealms, "Shattered Halls");
		table.insert(tableRealms, "Shattered Hand");
		table.insert(tableRealms, "Steamwheedle Cartel");
		table.insert(tableRealms, "Tarren Mill");
		table.insert(tableRealms, "Temple noir");
		table.insert(tableRealms, "The Maelstrom");
		table.insert(tableRealms, "The Sha'tar");
		table.insert(tableRealms, "The Venture Co");
		table.insert(tableRealms, "Twilight's Hammer");
		table.insert(tableRealms, "Twisting Nether");
		table.insert(tableRealms, "Zirkel des Cenarius");
		
	for k, v in pairs(tableRealms) do
		local nospaces = tableRealms[k]:gsub("%s+", "");

		if (nospaces == realmname) then
			if (GDKP_DEBUG) then
				print("stage1: "..realmname.."  ||"..nospaces.."||"..tableRealms[k]);
			end;
			return tableRealms[k];
		end;
	end;
	if (GDKP_DEBUG) then
		print("stage2: "..realmname);
	end;
	return realmname;
	
end;
 
--This Message show after  each Update and first install
StaticPopupDialogs["Update_Show"] = {
text = "Welcome to GetDKP v7.4.0\nFixed getDKP for WoW Patch 7.4 and fixed some minor bugs with class colors\n Bugreport @ eqdkp-plus.eu/forum/ ;)",
button1 = "Thanks!",
timeout = 0
}

StaticPopupDialogs["NO_Data"] = {
text = "There is no DKP data to load.\nPlease use JDKP to import your DKP from your EQDKP-PLUS!\nhttp://eqdkp-plus.eu/jdkp/jnlp/jdkp.jnlp",
button1 = "OK",
timeout = 0
}

function GDKP_Load()
		local this = GetDKP
		SlashCmdList["GETDKPSUB"] = GDKP_DKP_Sub;
			SLASH_GETDKPSUB1 = 	"/dkp-";  	
		SlashCmdList["GETDKPADD"] = GDKP_DKP_Add;
			SLASH_GETDKPADD1 = 	"/dkp+";  	
		this:RegisterEvent("ADDON_LOADED");	
		this:RegisterEvent("VARIABLES_LOADED");
		this:RegisterEvent("CHAT_MSG_RAID");
		this:RegisterEvent("CHAT_MSG_RAID_LEADER");
		this:RegisterEvent("CHAT_MSG_RAID_WARNING");
		this:RegisterEvent("CHAT_MSG_CHANNEL");	
		this:RegisterEvent("CHAT_MSG_WHISPER");
		this:RegisterEvent("CHAT_MSG_ADDON");
		this:RegisterEvent("PLAYER_REGEN_DISABLED");
		this:RegisterEvent("PLAYER_REGEN_ENABLED");
		this:RegisterEvent("PLAYER_TARGET_CHANGED");
		--this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
		--this:RegisterEvent("PLAYER_ENTERING_WORLD");
		--this:RegisterEvent("PLAYER_LEAVING_WORLD");
		--this:RegisterEvent("BANKFRAME_OPENED");
		--this:RegisterEvent("AUCTION_HOUSE_SHOW");
		--this:RegisterEvent("AUCTION_HOUSE_CLOSE");
		--this:RegisterEvent("AUCTION_ITEM_LIST_UPDATE");
		--this:RegisterEvent("MERCHANT_SHOW");
end;
function GetDKP_RegisterMRTNotify()
	if MRT_RegisterLootNotify ~= nil then
		local registrationSuccess = MRT_RegisterLootNotify(MRT_LootNotify);
		if (registrationSuccess) then
			print("GETDKP Plus "..GDKP_VERSION.." : MRT AutoCost successfully registered");
		end
	else
		print("GETDKP Plus "..GDKP_VERSION.." : MRT AutoCost option is set but MRT was not found");
	end
end
function GetDKP_UnregisterMRTNotify()
	if MRT_UnregisterLootNotify ~= nil then
		local unregistrationSuccess = MRT_UnregisterLootNotify(MRT_LootNotify);
		if (unregistrationSuccess) then
			print("GETDKP Plus "..GDKP_VERSION.." : MRT AutoCost successfully unregistered");
		end
	end
end
------------ Item Datenbank --------------------------------
-- Server Items suchen
function GDKP_searchServerItem ()
 j=0;
	for i=1, 50000, 1 do
		if GetItemInfo(i) then
			local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, invTexture = GetItemInfo(i);
			if (itemName ~= nil) then
				for color,link in string.gmatch(itemLink, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+:%d+:%d+:%d+:%d+)") do
					GDKP_saveItems[i] = {};
					GDKP_saveItems[i].link = link;
					GDKP_saveItems[i].color = color;
					GDKP_saveItems[i].itemName = itemName;
					GDKP_saveItems[i].invTexture = invTexture;
					GDKP_saveItems[i].itemRarity = itemRarity;
					GDKP_saveItems[i].itemLevel = itemLevel;
					GDKP_saveItems[i].itemMinLevel = itemMinLevel;
					GDKP_saveItems[i].itemType = itemType;
					GDKP_saveItems[i].itemSubType = itemSubType;
					GDKP_saveItems[i].itemStackCount = itemStackCount;
					GDKP_saveItems[i].itemEquipLoc = itemEquipLoc;
					j = j + 1; 
				end;
			end;
        end;
    end;
	GDKPvar_save.itemcount = j;
end;
function GDKP_searchTargetItem (target)
	
	for i = 0, 19 do
		local link = GetInventoryItemLink(target, i);
		if (link) then
			if GetItemInfo(link) then
				for color,links in string.gmatch(link, "|c(%x+)|Hitem:(%d+)") do 
					if (GDKP_saveItems[links] == nil) then
						local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, invTexture = GetItemInfo(link);
						for color,link in string.gmatch(itemLink, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+:%d+:%d+:%d+:%d+)") do
							GDKP_saveItems[i] = {};
							GDKP_saveItems[i].link = link;
							GDKP_saveItems[i].color = color;
							GDKP_saveItems[i].itemName = itemName;
							GDKP_saveItems[i].invTexture = invTexture;
							GDKP_saveItems[i].itemRarity = itemRarity;
							GDKP_saveItems[i].itemLevel = itemLevel;
							GDKP_saveItems[i].itemMinLevel = itemMinLevel;
							GDKP_saveItems[i].itemType = itemType;
							GDKP_saveItems[i].itemSubType = itemSubType;
							GDKP_saveItems[i].itemStackCount = ItemStackCount;
							GDKP_saveItems[i].itemEquipLoc = itemEquipLoc;
					
						end;
						
					end;
				end;
			end;
		end;
	end;
	GDKP_ItemCount(GDKP_saveItems);
end;

function GDKP_ItemLink (color,link,name)
	link = "|c"..color.."|Hitem:"..link.."|h"..name.."|h|r";
	return link;
end;

function GDKP_ItemCount (name)
	local n = 0;
	for _ in pairs(name) do
		n = n + 1;
	end
	GDKP_show("die datenbank umfast "..n.." Items");
	return n;
end;

-------------Item Datenbank ende ----------------------------

-- wird von /items aufgerufen
function GDKP_Display_ItemHistory(playerName, playerLookup,_output)
		local playerArray, playerKey, playerValue, playerPoints, playerRank;
		local ItemNames = {};		
		local ItemArray = {};
		local ItemRank, PlayerToLookup;						
		
		local itemName, itemCost;
		local totalRaidPoints = 0;
	
		if (playerLookup ~= nil) then				
				PlayerToLookup = playerLookup;
		else			
				PlayerToLookup = playerName;
		end
		
		
		if (DKP_ITEMS[PlayerToLookup] == nil) then 
			-- Check to see if player exists in array
			PlayerToLookup = string.upper(PlayerToLookup);
				
				
				
		if _output == "wisper" then
			GDKP_Send_Whisper(playerName, TEXT_DKP_NOHISTORY.. PlayerToLookup);
		elseif _output == "lokal" then
				GDKP_show_items(TEXT_DKP_NOHISTORY.. PlayerToLookup)
			end;	
			return;
		elseif (DKP_ITEMS[PlayerToLookup]['Items'] == nil) then
			-- Check to see if player's items exists in array
			PlayerToLookup = string.upper(PlayerToLookup);
			if _output == "wisper" then
				GDKP_Send_Whisper(playerName, TEXT_DKP_NOHISTORY.. PlayerToLookup);
			elseif _output == "lokal" then
				GDKP_show_items(TEXT_DKP_NOHISTORY.. PlayerToLookup);
			end;	
			return;				
		else				
				-- Do nothin
		end
		for j = 1, getn(DKP_ITEMS[PlayerToLookup]['Items']),1 do 
				itemName = DKP_ITEMS[PlayerToLookup]['Items'][j].name;
				itemCost = DKP_ITEMS[PlayerToLookup]['Items'][j].dkp;
				ItemArray[itemName] = itemCost;
				table.insert(ItemNames, itemName);
		end				
		
		table.sort(ItemNames, function (n1, n2)
			return ItemArray[n1] > ItemArray[n2]    -- compare the grades
		end)
		
		PlayerToLookup = string.upper(PlayerToLookup);
		
		if _output == "wisper" then 
			GDKP_Send_Whisper(playerName, TEXT_DKP_ITEMHISTORY.. PlayerToLookup);
		elseif _output == "lokal" then
			GDKP_show_items(TEXT_DKP_ITEMHISTORY.. PlayerToLookup);								
		end;	
		
		for itemRank, itemName in pairs(ItemNames) do		
				if (itemName ~= nil) then
						if _output == "wisper" then 
							GDKP_Send_Whisper(playerName, ItemArray[itemName]..TEXT_DKP_RP.. GDKP_Check_Loot_Text(itemName));
						elseif _output == "lokal" then
							GDKP_show_items(ItemArray[itemName]..TEXT_DKP_RP.. GDKP_Check_Loot_Text(itemName));								
						end;	
						totalRaidPoints = totalRaidPoints + ItemArray[itemName];					
				end
		end
		
		if _output == "wisper" then
			GDKP_Send_Whisper(playerName, totalRaidPoints ..TEXT_DKP_RPSPENT);
		elseif _output == "lokal" then
			GDKP_show_items(totalRaidPoints ..TEXT_DKP_RPSPENT);
		end;	

		if _output == "wisper" and playerLookup ~=nil then
			print(playerName.." looks for "..playerLookup);
		end;	
end

--/item show buyers from item 
function GDKP_cmd_ITEM_Lookup(msg)
	local _min,_max, _avg, _itemcount ;
	_min,_max, _avg, _itemcount = GDKP_item_info(GETDKP_TOOLTIP_ITEMNAME);
	
	GDKP_item_lookup("lokal",msg,"lokal"); 
  
  GDKP_cmd_HOW_HASNT_ITEM(msg,"lokal");
  if GDKPvar_save.minmax == true then
	GDKP_Output("Min: ".._min..", Max: ".._max..", AVG: ".._avg,"lokal") ;
  end;
end;

-- is called by /item,show item owners
function GDKP_item_lookup(aPlayerName, aItemLookup, aOutput)
	local PlayerNames = {};		
	local PlayerArray = {};
	local _PlayerName = "";
	local count = 0 ;
	local aclassde = "" ;
	local aclasseng = "" ;
	local anamede = "" ;
	local anameeng = "" ;
	local atier = "" ;
	local adrop = "" ;
	local vExtractedLootText = GDKP_Extrace_Loot_Text(aItemLookup);
 
	aclassde,aclasseng,anamede,anameeng,atier,adrop = get_Informations_of_Item(aItemLookup) ;
	
	for vPlayer in pairs(DKP_ITEMS) do
		for j=1,getn(DKP_ITEMS[vPlayer]["Items"]),1 do 
		
			if (DKP_ITEMS[vPlayer]["Items"][j].name == vExtractedLootText) or (DKP_ITEMS[vPlayer]["Items"][j].name == anamede) or (DKP_ITEMS[vPlayer]["Items"][j].name == anameeng) then
				count = count + 1 ;				
			end;
		end;
		
	end	
	
	GDKP_Output(count..TEXT_DKP_Buyers..aItemLookup,aOutput);
	
	if (GDKPvar_save.BuyersLimit ~= nil) and (count > GDKPvar_save.BuyersLimit) and (GDKPvar_save.BuyersLimit > 0)  then
		GDKP_Output(TEXT_DKP_TT_LIMIT_SHOW..GDKPvar_save.NeedLimit,aOutput)
	end;
	
	for vPlayer in pairs(DKP_ITEMS) do
		for j=1,getn(DKP_ITEMS[vPlayer]["Items"]),1 do 
			if (DKP_ITEMS[vPlayer]["Items"][j].name == vExtractedLootText) or (DKP_ITEMS[vPlayer]["Items"][j].name == anamede) or (DKP_ITEMS[vPlayer]["Items"][j].name == anameeng) then
				if getNameCasesensitiv(vPlayer) ~= "" and getNameCasesensitiv(vPlayer) ~= nil then
					PlayerArray[getNameCasesensitiv(vPlayer)] = DKP_ITEMS[vPlayer]["Items"][j].dkp;
					table.insert(PlayerNames, getNameCasesensitiv(vPlayer))
				end;	
			end;
		end
	end
	
	table.sort(PlayerNames, function (n1, n2)  -- Sort by DKP
		return PlayerArray[n1] > PlayerArray[n2]    
	end)
	
	for i, _PlayerName in pairs(PlayerNames) do		
		if (_PlayerName ~= nil) then														
			if (GDKPvar_save.BuyersLimit == 0) or (i <= GDKPvar_save.BuyersLimit) then 
				GDKP_Output("  ".._PlayerName..TEXT_DKP_boughtfor..PlayerArray[_PlayerName].." DKP",aOutput)
			end;	
		end;									
	end	
end

--wird von /item aufgerufen gibt die spieler zurück, die das item nicht haben
--function GDKP_cmd_HOW_HASNT_ITEM(SETNAME,CLASSNAME_DE,CLASSNAME_ENG,ITEMTOLOOK,aOutput)
function GDKP_cmd_HOW_HASNT_ITEM(ITEMTOLOOK,aOutput)
	
		local playerName, playerAttrib;
		local itemName, itemCost; 
		local AttribName = "Items";
		local AttribValue;
		local index;
		local returnResult, foundResult;
		local finditem, acount 
		local CaseNAme ;
		local raid = ""
		PlayerNames = {};		
		local PlayerArray = {};
		local _PlayerName = "";
		local CLASSNAME_DE = "" ;
		local CLASSNAME_ENG = "" ;
		local anamede = "" ;
		local anameeng = "" ;
		local atier = "" ;
		local adrop = "" ;
		local key, val ;
		CLASSNAME_DE,CLASSNAME_ENG,anamede,anameeng,atier,adrop = get_Informations_of_Item(ITEMTOLOOK) ;		
		acount = 0 ;
		
		for playerName, playerAttrib in pairs(DKP_ITEMS) do -- schleife der member
			finditem = false ;
					
			CaseNAme = getNameCasesensitiv(playerName) ;
			if CaseNAme ~= "" then	  
				if (gdkp.players[CaseNAme].class == CLASSNAME_DE) or (gdkp.players[CaseNAme].class == CLASSNAME_ENG) or (CLASSNAME_DE == "ALL") then  -- prfe ob der klassenname des items zum player passt			  
					for j=1,getn(DKP_ITEMS[playerName]["Items"]),1 do 
						itemName = DKP_ITEMS[playerName]['Items'][j].name;
						itemCost = DKP_ITEMS[playerName]['Items'][j].dkp;					
						if (itemName == anamede) or (itemName == anameeng) or (itemName == GDKP_Extrace_Loot_Text(ITEMTOLOOK)) then
							finditem = true ;
						end;					   									
					end;	
					if finditem == false then
						acount = acount + 1 ;
					end;					
					
				end; -- end if playerclass = itemclass				
			end; -- if CaseNAme <> '' end	
		end -- end for players	
		
		-- extra abfrage ob spieler die noch nie ein Item bekommen haben, noch NEED haben
		
			GDKP_Konto = GDKPvar_save.konto;
		
		
		for key, val in sortedPairs(gdkp.players) do
			if (val.class == CLASSNAME_DE) or (val.class == CLASSNAME_ENG) then
				if not checkifPlayerHaveItems(key) then
					acount = acount + 1 ;
				end;
			end
		end	
		GDKP_Konto = nil;
		
		if acount > 0 then 
			GDKP_Output(acount..TEXT_DKP_HASNT_ITEM,aOutput)
		end
		
		if (GDKPvar_save.NeedLimit ~= nil) and (acount > GDKPvar_save.NeedLimit) and (GDKPvar_save.NeedLimit > 0)  then
				GDKP_Output(TEXT_DKP_TT_LIMIT_SHOW..GDKPvar_save.NeedLimit,aOutput)
		end;
		
		for playerName, playerAttrib in pairs(DKP_ITEMS) do -- schleife der member
			finditem = false ;
			CaseNAme = getNameCasesensitiv(playerName) ;
			if CaseNAme ~= "" then
				if (gdkp.players[CaseNAme].class == CLASSNAME_DE) or (gdkp.players[CaseNAme].class == CLASSNAME_ENG) or (CLASSNAME_DE == "ALL") then  -- prfe ob der klassenname des items zum player passt			  
					for j=1,getn(DKP_ITEMS[playerName]["Items"]),1 do 
						itemName = DKP_ITEMS[playerName]['Items'][j].name;
						itemCost = DKP_ITEMS[playerName]['Items'][j].dkp;	
						if (itemName == anamede) or (itemName == anameeng) or (itemName == GDKP_Extrace_Loot_Text(ITEMTOLOOK)) then
							finditem = true ;
						end;					   									
					end;
					if finditem == false then
						PlayerArray[getNameCasesensitiv(playerName)] = gdkp["players"][playerName][GDKP_Konto.."_current"];
						table.insert(PlayerNames, getNameCasesensitiv(playerName))							
					end;
					
				end; -- end if playerclass = itemclass	
			end; -- if CaseNAme <> '' end			
		end -- end for players	
		
		-- extra abfrage ob spieler die noch nie ein Item bekommen haben, noch NEED haben
		
			GDKP_Konto = GDKPvar_save.konto;
		
		for key, val in sortedPairs(gdkp.players) do
			if (val.class == CLASSNAME_DE) or (val.class == CLASSNAME_ENG) then
				if not checkifPlayerHaveItems(key) then
					PlayerArray[key] = gdkp["players"][key][GDKP_Konto.."_current"] ;
					table.insert(PlayerNames, key)	
				end;
			end
		end	
		GDKP_Konto = nil;
		table.sort(PlayerNames, function (n1, n2)  -- Sort by DKP
			return PlayerArray[n1] > PlayerArray[n2]    
		end)
				
		for i, _PlayerName in pairs(PlayerNames) do		
			if (_PlayerName ~= nil) then
				if (GDKPvar_save.NeedLimit == 0) or (i <= GDKPvar_save.NeedLimit) then 
					if GetDKP_CheckifPlayerIsInRaid(_PlayerName) == true and (GetNumGroupMembers()  > 0) then
						GDKP_Output("  ".._PlayerName.." ("..PlayerArray[_PlayerName].." DKP)"..TEXT_DKP_Player_Raid,aOutput) ;
					else
						if GDKPvar_save.ShowOnlyInRaid ~= true then
							GDKP_Output("  ".._PlayerName.." ("..PlayerArray[_PlayerName].." "..GDKP_Konto.." DKP)",aOutput) ;								
						end;	
					end
				end;	
			end
		end;	
		
		-- ################################################ Need In Raid without DKP #############################################
	
		if (CLASSNAME_DE ~= "") and (CLASSNAME_ENG ~= "") then
		local NeedInRaidCount = 0 ;
		
			if  GetNumGroupMembers()  > 0 then		--Raid exists
				for i = 1,GetNumGroupMembers() do 
					if  gdkp.players[GetRaidRosterInfo(i)] == nil then	
						local name, rank, subgroup, level, class, fileName, zone, online 
						name, rank, subgroup, level, class = GetRaidRosterInfo(i);
						if (CLASSNAME_DE == class) or (CLASSNAME_ENG == class) or (CLASSNAME_ENG == "ALL") then
							NeedInRaidCount = NeedInRaidCount + 1 	
						end;
						
					end;
				end; 	
			end;		
			
			if NeedInRaidCount > 0 then -- Player in Raid without DKP found
			
				if CLASSNAME_DE == "ALL" then
					GDKP_Output(NeedInRaidCount.." "..TEXT_DKP_TT_NEED_RAID,aOutput) ;								
				else
					if ( GetLocale() == "deDE" ) then
						GDKP_Output(NeedInRaidCount.." "..CLASSNAME_DE.." "..TEXT_DKP_TT_NEED_RAID,aOutput) ;								
					else
						GDKP_Output(NeedInRaidCount.." "..CLASSNAME_ENG.." "..TEXT_DKP_TT_NEED_RAID,aOutput) ;												
					end;	
				end;	
													
				if  GetNumGroupMembers()  > 0 then		--Raid exists
					for i = 1,GetNumGroupMembers() do 
						if  gdkp.players[GetRaidRosterInfo(i)] == nil then	
							local name, rank, subgroup, level, class, fileName, zone, online 
							name, rank, subgroup, level, class = GetRaidRosterInfo(i);
							if (CLASSNAME_DE == class) or (CLASSNAME_ENG == class) or (CLASSNAME_ENG == "ALL") then
								GDKP_Output("  "..name,aOutput) ;																			
							end;
							
						end;
					end; 
				end;			
			end;				
		end;
		
end; -- end function

--Tooltip anzeige
function GetDKP_Tooltip_Update(tooltip, ...)

	local gdkpiname, gdkpilink = tooltip:GetItem()
	
	if DKP_ITEMS == nil or  multiTable == nil or gdkp == nil then 
		return ;
	end;	
	
	if GDKPvar_save.showtooltip == false then
		if (GETDKPInfoPanel:IsShown()) then
			GETDKPInfoPanel:Hide();
		end
		return
	end;
	
	if (GDKPvar_save.showtooltipraid and GetNumGroupMembers()  == 0 ) then
		if (GETDKPInfoPanel:IsShown()) then
			GETDKPInfoPanel:Hide();
		end
		return
	end;

	PlayerDI = {};
	PlayerNI = {};		
	PlayerHI= {};
	HIcount = 0;
	NIcount = 0;
	DIcount = 0;
	maxbet = 0;
	minbet = 99999999;
	svg = 0;
	
	if (type(gdkpiname) == "string") then 
		
		Firstline = gdkpiname;
		--gdkpiname = nil;
	else
		Firstline = ItemRefTooltipTextLeft1:GetText();
		GetDKP_ItemToolTip_Show = "ItemRefTooltip";
	end;	
	
		if (Firstline == nil) then
			if (GETDKPInfoPanel:IsShown()) then
				GETDKPInfoPanel:Hide();
			end
			return 
		end;
		
		iName,iLink,iRarity = GetItemInfo(Firstline);
		--if (iRarity == nil) then iRarity = 1; end;
		if (iRarity ~= nil) then 
			if (iRarity < 3 ) then 
				if (GETDKPInfoPanel:IsShown()) then
					GETDKPInfoPanel:Hide();
				end
				return 
			end;
		end;
	
	local dkpstring
	nonsetitem = nil;
	getdkplootwidth = 0;
	TooltipLinesLocal = 1 ;
	classcount = 0;
	classfound = {};
	GETDKP_TOOLTIP_ITEMNAME = Firstline;
	for i = 1, 47 do
		local getdkplootlayer = getglobal("GETDKPInfoPanelText"..i);
		getdkplootlayer:Hide();
	end
	itemfoundset2 = 0;
	
	
	
	for key, val in pairs(DKP_ITEMS) do
		-------suche K�ufer ------------
		itemfound = 0;
		if (gdkp["players"][key]) then
			for j= 1, getn(DKP_ITEMS[key]["Items"]),1 do 
				if (DKP_ITEMS[key]["Items"][j].name == Firstline) then
					class = GDL_SetClass(gdkp["players"][key].class);
					dkp = DKP_ITEMS[key]["Items"][j].dkp;
					tinsert(PlayerHI, {name = key, class = class,dkp = dkp});
					HIcount = HIcount + 1;
					if dkp > maxbet then maxbet = dkp end;
					if dkp < minbet then minbet = dkp end;
					svg = svg + dkp;
					itemfound = 1;
					if classcount > 0 then
						classtest = 0;
						for i=1,getn(classfound),1 do
							if (classfound[i] == class ) then
								classtest = 1;
							end;
						end;
						if (classtest == 0) then 
							classcount = classcount + 1;
							classfound[classcount] = class; 
						end;
					else
						classcount = classcount + 1;
						classfound[classcount] = class;
					end;
				end;
			end;
			------- schaue ob player need hatt ------------
			if (itemfound == 0) then
				-------------Schaue ob player need auf t4-t6 tokenitems hatt----------------------
				itemid = 0;
				class = GDL_SetClass(gdkp["players"][key].class);
				
				for l=29753, 29767 ,1 do
					if (Firstline == GDL_T4[l][3] or Firstline == GDL_T4[l][2]) then
						itemid = l;
						setid = "T4"
					end;
				end;
				for l=30236, 30250 ,1 do
					if (Firstline == GDL_T5[l][3] or Firstline == GDL_T5[l][2]) then
						itemid = l;
						setid = "T5"
					end;
				end;
				for l=31089, 31103 ,1 do
					if (Firstline == GDL_T6[l][3] or Firstline == GDL_T6[l][2]) then
						itemid = l;	
						setid = "T6";
					end;
				end;
				if (itemid ~= 0) then 
					itemfoundset2 = 1;
					nameex = "";
					for i=1, getn(GDL_Sets[class][setid]),1 do
						for setkey,setval in pairs(GDL_Sets[class][setid][i]) do
							if (GDL_Sets[class][setid][i][setkey][5] == itemid) then
								if classcount > 0 then
								classtest = 0;
									for i=1,getn(classfound),1 do
										if (classfound[i] == class ) then
											classtest = 1;
										end;
									end;
									if (classtest == 0) then 
										classcount = classcount + 1;
										classfound[classcount] = class; 
									end;
								else
									classcount = classcount + 1;
									classfound[classcount] = class;
								end;
								if (nameex ~= key) then
									tinsert(PlayerNI,{name = key,class = class,dkp = gdkp["players"][key][GDKPvar_save.konto.."_current"]});
									NIcount = NIcount + 1;
									nameex = key;
								end;
							end;	
						end;
					end;
				else
					itemfoundset = 0;
				end;
			end;
		end;
	end;
	if (itemfoundset2 == 0) then
		--------------------------nonsetitem all need----------------------
		nonsetitem = 1 ;
		if (HIcount == 0) then 
			for key, val in pairs(gdkp.players) do
				NIcount = NIcount + 1;
				tinsert (PlayerNI,{name = key, class = GDL_SetClass(val.class), dkp = gdkp["players"][key][GDKPvar_save.konto.."_current"]});
			end;
		else
			for key, val in pairs(gdkp.players) do
				for i = 1,getn(PlayerHI),1 do
					if (PlayerHI[i].name ~= key) then
						NIcount = NIcount + 1;
						tinsert (PlayerNI,{name = key, class = GDL_SetClass(val.class), dkp = gdkp["players"][key][GDKPvar_save.konto.."_current"]});
					end;
				end;
			end;
		end;
	end;
	----------------- Stop Tooltip when NO Buyers and Nonsetitem-----------------------
	if (HIcount == 0 and nonsetitem == 1) then
		if (GETDKPInfoPanel:IsShown()) then
			GETDKPInfoPanel:Hide();
		end
		return 
	end;
	--------------------- Find Player with 0 Items---------------------------------------
	
	for i = 1, getn(GDKP_Player_NoItems),1 do
		for j = 1,getn(classfound),1 do
			if (GDKP_Player_NoItems[i].class == classfound[j]) then
				tinsert(PlayerNI,{name = GDKP_Player_NoItems[i].name,class = classfound[j],dkp = GDKP_Player_NoItems[i].dkp});
				NIcount = NIcount + 1;
			end;
		end;	
	end; 
	--------------------------- Find Player is in raid but not in eqdkp ---------------------------
	local NeedInRaidCount = 0 ;
	if  GetNumGroupMembers()  > 0 then		
		for i = 1,GetNumGroupMembers() do 
			if  gdkp.players[GetRaidRosterInfo(i)] == nil then	
				local name, rank, subgroup, level, class, fileName, zone, online 
				name, rank, subgroup, level, class = GetRaidRosterInfo(i);
				for j = 1,getn(classfound),1 do
					if (class == classfound[j]) then
						tinsert(PlayerNI,{name = name,class = classfound[j],dkp = 0});
						NIcount = NIcount + 1;
					end;
				end;
			end;	
		end; 
	end;

	
	--------------------------- Show Tooltip ------------------------------------------------------
	
	for i = 1, table.getn (PlayerHI) ,1 do
		for j = 1, table.getn (PlayerHI) ,1 do
			if (PlayerHI[j]["dkp"] < PlayerHI[i]["dkp"]) then
				test = PlayerHI[j];
				PlayerHI[j] = PlayerHI[i];
				PlayerHI[i] = test;
			end;
		end;
	end;
	for i = 1, table.getn (PlayerNI) ,1 do
		for j = 1, table.getn (PlayerNI) ,1 do
			if (PlayerNI[j]["dkp"] < PlayerNI[i]["dkp"]) then
				test = PlayerNI[j];
				PlayerNI[j] = PlayerNI[i];
				PlayerNI[i] = test;
			end;
		end;
	end;
	if (GDKPvar_save.listowner == true) then
		
		if (HIcount > 0) then
			HIcount2 = 0;
			for i = 1, getn(PlayerHI),1 do
				if (GDKPvar_save.ShowOnlyInRaid == true and GetDKP_CheckifPlayerIsInRaid(PlayerHI[i].name) == true) then
					HIcount2 = HIcount2 + 1;
				end;
			end;
			if (GDKPvar_save.ShowOnlyInRaid == true) then
				getdkplootlineSetLine(HIcount..TEXT_DKP_Buyer.."/"..HIcount2.." in Raid",1.0, 0.0, 0.0);
			else
				getdkplootlineSetLine(HIcount..TEXT_DKP_Buyer,1.0, 0.0, 0.0);
			end;
		end;
		if (HIcount > 0) then
			for i = 1, getn(PlayerHI),1 do
				for j = 1,9,1 do
					if (PlayerHI[i].class == GDL_Classes[j][2]) then
						if (GDKPvar_save.ShowOnlyInRaid == true) then
							if (GetDKP_CheckifPlayerIsInRaid(PlayerHI[i].name) == true) then
								getdkplootlineSetLine("  "..PlayerHI[i].name..": "..PlayerHI[i].dkp,GDL_Classes[j][3], GDL_Classes[j][4], GDL_Classes[j][5],1);
							end;
						else
							if (GetDKP_CheckifPlayerIsInRaid(PlayerHI[i].name) == true) then
								getdkplootlineSetLine("  "..PlayerHI[i].name..": "..PlayerHI[i].dkp,GDL_Classes[j][3], GDL_Classes[j][4], GDL_Classes[j][5],1);
								getdkplootlineSetLine("  "..PlayerHI[i].name..": "..PlayerHI[i].dkp,GDL_Classes[j][3], GDL_Classes[j][4], GDL_Classes[j][5],1);
							else
								getdkplootlineSetLine("  "..PlayerHI[i].name..": "..PlayerHI[i].dkp,GDL_Classes[j][3], GDL_Classes[j][4], GDL_Classes[j][5],0.5);
							end;
						end;
					end;
				end;
			end;
		end;
	end;
	if (nonsetitem ~= 1) then
		
		if (NIcount > 0) then
			NIcount2 = 0;
			for i = 1, getn(PlayerNI),1 do
				if (GetDKP_CheckifPlayerIsInRaid(PlayerNI[i].name) == true and GetDKP_CheckifPlayerIsInRaid(PlayerNI[i].name) == true) then
					NIcount2 = NIcount2 + 1;
				end;
			end;
			if (GDKPvar_save.ShowOnlyInRaid == true) then
				getdkplootlineSetLine(NIcount..TEXT_DKP_HASNT_ITEM.."/"..NIcount2.." in Raid",1.0, 0.0, 0.0);
			else
				getdkplootlineSetLine(NIcount..TEXT_DKP_HASNT_ITEM,1.0, 0.0, 0.0);
			end;
		end;
		if (NIcount > 0) then
			for i = 1, getn(PlayerNI),1 do
				for j = 1,9,1 do
					if (PlayerNI[i].class == GDL_Classes[j][2]) then
						if (GDKPvar_save.ShowOnlyInRaid == true) then
							if (GetDKP_CheckifPlayerIsInRaid(PlayerNI[i].name) == true) then
								getdkplootlineSetLine("  "..PlayerNI[i].name..": "..PlayerNI[i].dkp,GDL_Classes[j][3], GDL_Classes[j][4], GDL_Classes[j][5],1);
							end
						else
							if (GetDKP_CheckifPlayerIsInRaid(PlayerNI[i].name) == true) then
								getdkplootlineSetLine("  "..PlayerNI[i].name..": "..PlayerNI[i].dkp,GDL_Classes[j][3], GDL_Classes[j][4], GDL_Classes[j][5],1);
							else
								getdkplootlineSetLine("  "..PlayerNI[i].name..": "..PlayerNI[i].dkp,GDL_Classes[j][3], GDL_Classes[j][4], GDL_Classes[j][5],0.5);
							end;
						end;
					end;
				end;
			end;
		end;
	end;
	getdkplootlineSetLine(" ",1.0, 1.0, 0.0);
		if GDKPvar_save.dkp == true then
			if (gdkp ~= nil) and (gdkp.players[UnitName("player")] ~= nil)  then
				getdkplootlineSetLine(TEXT_DKP_YOU..gdkp.players[UnitName("player")][GDKPvar_save.konto.."_current"].." "..GDKPvar_save.konto.." DKP",1.0,1.0,0.0);
			end;
		end;
		if minbet > 99999 then minbet = 0; svg = 0; end;
		if (HIcount == 0) then
			avg = 0;
		else
			avg = svg/HIcount
		end;
		if GDKPvar_save.minmax == true then
			avg = math.ceil(avg);
			getdkplootlineSetLine("Min: "..minbet..", Max: "..maxbet..", AVG: "..avg,1.0, 0.0, 0.0)
		end;
	
	if (GDKPvar_save.posi_tooltip == nil) or (GDKPvar_save.posi_tooltip == "top") then
		point="BOTTOMLEFT" ; 
		relative="TOPLEFT";			
	elseif GDKPvar_save.posi_tooltip == "left" then 
		point="TOPRIGHT" ; 
		relative="TOPLEFT";			
	elseif GDKPvar_save.posi_tooltip == "right" then 
		point="TOPLEFT" ; 
		relative="TOPRIGHT";
	elseif GDKPvar_save.posi_tooltip == "buttom" then 
		point="TOPLEFT" ; 
		relative="BOTTOMLEFT";
	end;
	
	GETDKPInfoPanel:ClearAllPoints();
	GETDKPInfoPanel:SetPoint(point, ItemRefTooltip, relative);
	GETDKPInfoPanel:Show();		
	DKP_P_BUTTON:ClearAllPoints();
	DKP_P_BUTTON:SetPoint("TOPLEFT","GETDKPInfoPanel",10,-(14 * TooltipLinesLocal)+5);		
end;

--add line to tooltip
function getdkplootlineSetLine(_text,r,g,b,_alpha,_warp)
	if _text == nil then
		return
	end;
	
	if TooltipLinesLocal >= 46 then
		return
	end;	

	
	if TooltipLinesLocal == 45 then
		getdkplootline = getglobal("GETDKPInfoPanelText"..TooltipLinesLocal);						
		getdkplootline:SetText("Abort !!") ;
		getdkplootline:SetTextColor(1,0,0) ;	
		getdkplootline:Show();
		TooltipLinesLocal = TooltipLinesLocal + 1 ;
		GDKP_Output(TEXT_DKP_TT_LIMIT_WARINIG,"lokal") ;
	elseif TooltipLinesLocal < 45 then
		getdkplootline = getglobal("GETDKPInfoPanelText"..TooltipLinesLocal);						
		getdkplootline:SetText(_text) ;
		getdkplootline:SetTextColor(r,g,b,_alpha) ;	
		getdkplootline:Show();
		TooltipLinesLocal = TooltipLinesLocal + 1 ;
	end;
	
		
	if (getdkplootwidth < getdkplootline:GetStringWidth()) then
		getdkplootwidth = getdkplootline:GetStringWidth()
	end
	
	GETDKPInfoPanel:SetHeight((14 * TooltipLinesLocal)+20);
	GETDKPInfoPanel:SetWidth(getdkplootwidth +20);
end;

--buttonclick in tooltip to post iteminfo
function GDKP_post_tooltipitem(msg)
	
	local _min,_max, _avg, _itemcount ;
	local CLASSNAME_DE = "" ;
	local CLASSNAME_ENG = "" ;
	local anamede = "" ;
	local anameeng = "" ;
	local atier = "" ;
	local adrop = "" ;
	_lang = "eng";
	if (HIcount == 0 and nonsetitem == 1) then
		return
	end;
	GDKP_Output("Lootinfo: "..GETDKP_TOOLTIP_ITEMNAME,msg)
	if ( GetLocale() == "deDE" ) then
		_lang = "de";
	end;
	
	if (GDKPvar_save.reportowner == true) then
		if (HIcount > 0) then
			GDKP_Output(HIcount..TEXT_DKP_Buyer,msg);
		end;
		if (HIcount > 0) then
			for i = 1, getn(PlayerHI),1 do
				GDKP_Output(PlayerHI[i].name..": "..PlayerHI[i].dkp.." -> "..GDL_SetClass(PlayerHI[i].class,_lang),msg);
			end;
		end;
		if (nonsetitem ~= 1) then
			if (NIcount > 0) then
				GDKP_Output(NIcount..TEXT_DKP_HASNT_ITEM,msg);
			end;
			if (NIcount > 0) then
				for i = 1, getn(PlayerNI),1 do
					GDKP_Output(PlayerNI[i].name..": "..PlayerNI[i].dkp.." -> "..GDL_SetClass(PlayerNI[i].class,_lang),msg);
				end;
			end;
		end;
	end;	
	if GDKPvar_save.minmax == true then
		avg = math.ceil(svg/HIcount);
		GDKP_Output("Min: "..minbet..", Max: "..maxbet..", AVG: "..avg,msg)
	end;	
end;

function GDKP_Button_OnEnter(id, description)
	
	if id == "Party" then 
		description = TEXT_DKP_TT_PARTY ;
	elseif id == "Chat" then 
		description = TEXT_DKP_TT_CHAT ;
	elseif id == "Raid" then 
		description = TEXT_DKP_TT_RAID ;
	elseif id == "Guild" then 
		description = TEXT_DKP_TT_GUILD ;
	elseif id == "Officer" then 	
		description = TEXT_DKP_TT_OFFICER ;	
	end;	

	GameTooltip_AddNewbieTip(self, TEXT_DKP_TT_HEAD, 1.0, 1.0, 1.0, description, 1)
	return
end

function GDKP_Button_OnLeave()
	GameTooltip:Hide()
end

-- extract the keywords from args and call set/nonset to whisper the Requester the DKP Point
function GDKP_RequestClass(args,Requester,_type)
	local orgchannel = GDKPvar_save.reportChannel ;
	local key,val,_args
	
	GDKPvar_save.reportChannel = Requester
	_args = GDKP_GetArgs(args, " ");
		
	for key,val in pairs(_args) do
		if key > 1 then
			GETDKP_ShowDKP(val,_type)
		end;	
	end;
		
	GDKPvar_save.reportChannel = orgchannel ;	
end;


------ OnUpdate ------------
function GetDKP_Status_Frame_OnUpdate(this, elapsed)
this.TimeSinceLastUpdate = this.TimeSinceLastUpdate + elapsed; 	
		if (this.TimeSinceLastUpdate > 50 and GDKP_Status_Window_open == 1)then
			GDKP_Status_Frame:Hide();
			GDKP_Status_Window_open = 0;
		end;
		if (GDKP_Status_Window == 1) then
			GDKP_Status_Frame:Show();
			GDKP_Status_Window = 0;
			GDKP_Status_Window_open = 1;
		end;
end;

-- register wisper event for dkp request
function GDKP_Event(event, ...)
	local numArgs, result;
	local requestfrom, playerlockup, _output ;
	local _args
	local _table = "";
	local _type = "";
	local this = GetDKP;
	dkpstring = TEXT_DKP_DKP;
	
	local arg1, arg2, arg3, arg4 = ...;
	
	if event == "PLAYER_REGEN_DISABLED" then
		allowWhisper = false ;
	end;

	if event == "PLAYER_REGEN_ENABLED" then
		allowWhisper = true ;
	end;	
	------------------------------- Live Update -----------------------------
	if (event == "CHAT_MSG_ADDON" and arg1 == "GETDKP" and UnitName("player").."-"..GetRealmName() ~= arg4)
	then	
		_args = GDKP_GetArgs(arg2, ",");
		GDKP_MATH_DKP(_args[3].." ".._args[1].." ".._args[2],_args[4],"false","false",_args[5],_args[6]);
	
	end;
	-------------------------------------------------------------------------
	
	if (event == "VARIABLES_LOADED") then
		
		GDKP_CheckConfig() ;
		--- Whisper DKP
		ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", GetDKP_BlockIncomingChatFrame_OnEvent)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", GetDKP_BlockOutgoingChatFrame_OnEvent)

		-- hook Tooltip
		--Orig_ChatFrame_OnHyperlinkClick = ChatFrame1:GetScript("OnHyperlinkClick");
		--ChatFrame1:SetScript("OnHyperlinkClick", GetDKP_Tooltip_Update);
		Saved_OnTooltipSetItem = ItemRefTooltip:GetScript("OnTooltipSetItem");
		---ItemRefTooltip:SetScript("OnTooltipSetItem", GetDKP_Tooltip_Update);
		ItemRefTooltip:HookScript("OnTooltipSetItem", GetDKP_Tooltip_Update);

		--for i = 2, 15 do
			--if (getglobal("ChatFrame"..i)) then
				--local cf = getglobal("ChatFrame"..i);
				--cf:SetScript("OnHyperlinkClick", GetDKP_Tooltip_Update);
			--end			
		--end
		
		if CT_RaidTracker_Version ~= nil then
			Original_CT_RaidTracker_SaveNote = CT_RaidTracker_SaveNote;
			CT_RaidTracker_SaveNote = GETDKP_CTRT_SaveNoteCT;
			Original_CT_RaidTracker_SaveCost = CT_RaidTracker_SaveCost;
			CT_RaidTracker_SaveCost = GETDKP_CTRT_SaveCostCT;
			GDKP_show("GetDKP Hooked CT Raid Tracker Item Notes !");	
			GDKP_CTRTButtonHandle();
		end;
		
		if GDKPvar_save.MRT then
			GetDKP_RegisterMRTNotify();
		end
	end	
	
	if ((event == "ADDON_LOADED") and (arg1 == "GetDKP")) then
		GDKPvar_save.client = false;
		local GDKP_Text_Line = 1;
		local GDKP_Text_Line1 = "";
		GDKP_Status_Window = 0;
		local GDKP_Status_Return = 0;
		if (not multiTable) and (not DKPInfo) and (not GDKP) and (not DKPItems) then
			GDKP_Text_Line1 = GDKP_Text_Line1..GDKP_Text_ClientMode;
			getglobal("GDKP_Text"..GDKP_Text_Line):SetText(GDKP_Text_Line1);
			GDKP_Text_Line = GDKP_Text_Line + 1;
			GDKP_Status_Window = 1;
			GDKPvar_save.client = true;
		else
			if (not multiTable) then
				GDKP_Text_Line1 = GDKP_Text_Line1..GDKP_Text_multiTable;
				GDKP_Status_Window = 1;
				GDKP_Status_Return = 1;
			end;
			if (not DKPInfo) then
				GDKP_Text_Line1 = GDKP_Text_Line1..GDKP_Text_DKPInfo;
				GDKP_Status_Window = 1;
				GDKP_Status_Return = 1;
			end;
			if (not gdkp) then
				GDKP_Text_Line1 = GDKP_Text_Line1..GDKP_Text_GDKP;
				GDKP_Status_Window = 1;
				GDKP_Status_Return = 1;
			end;
			if (not DKP_ITEMS) then
				GDKP_Text_Line1 = GDKP_Text_Line1..GDKP_Text_DKPItems;
				GDKP_Status_Window = 1;
				GDKP_Status_Return = 1;
			end;
			if (GDKP_Text_Line1 ~= "") then
				getglobal("GDKP_Text"..GDKP_Text_Line):SetText(GDKP_Text_Line1..GDKP_Text_Vars);
				GDKP_Text_Line = GDKP_Text_Line + 1;
			end;
		end;
		local GDKP_Text_Line1 = "";
		if (DKPInfo) then
			if (DKPInfo.process_dkp_ver) then
				if(tonumber(DKPInfo.total_players) < 1) or (tonumber(DKPInfo.total_items) < 1) then
					if (tonumber(DKPInfo.total_players) < 1) then
						GDKP_Text_Line1 = GDKP_Text_Line1..GDKP_Text_NoMembers;
						GDKP_Status_Window = 1;
						GDKP_Status_Return = 1;
					elseif (tonumber(DKPInfo.total_items) < 1) then
						GDKP_Text_Line1 = GDKP_Text_Line1..GDKP_Text_NoItems;
						GDKP_Status_Window = 1;
						GDKP_Status_Return = 1;
					end;
					if 	(GDKP_Text_Line1 ~= "") then
						getglobal("GDKP_Text"..GDKP_Text_Line):SetText(GDKP_Text_Line1);
						GDKP_Text_Line = GDKP_Text_Line + 1;
					end;
				end;
				local GDKP_Text_Line1 = "";
				if (tonumber(DKPInfo.process_dkp_ver) < 2.4) then
					GDKP_Text_Line1 = GDKP_Text_Line1..GDKP_Text_ToLow;
					getglobal("GDKP_Text"..GDKP_Text_Line):SetText(GDKP_Text_Line1);
					GDKP_Text_Line = GDKP_Text_Line + 1;
					GDKP_Status_Window = 1;
					GDKP_Status_Return = 1;
				end;
				local GDKP_Text_Line1 = "";
				if (tonumber(DKPInfo.process_dkp_ver) < 2.61) then
					GDKP_Text_Line1 = GDKP_Text_Line1..GDKP_Text_Alias;
					getglobal("GDKP_Text"..GDKP_Text_Line):SetText(GDKP_Text_Line1);
					GDKP_Text_Line = GDKP_Text_Line + 1;
					GDKP_Status_Window = 1;
				end;
				local GDKP_Text_Line1 = "";
				if (tonumber(DKPInfo.process_dkp_ver) < 2.63) then
					GDKP_Text_Line1 = GDKP_Text_Line1..GDKP_Text_DataTransfer;
					getglobal("GDKP_Text"..GDKP_Text_Line):SetText(GDKP_Text_Line1);
					GDKP_Text_Line = GDKP_Text_Line + 1;
					GDKP_Status_Window = 1;
				end;
				local GDKP_Text_Line1 = "";
				if (tonumber(DKPInfo.process_dkp_ver) < 2.64) then
					GDKP_Text_Line1 = GDKP_Text_Line1..GDKP_Text_RP;
					getglobal("GDKP_Text"..GDKP_Text_Line):SetText(GDKP_Text_Line1);
					GDKP_Text_Line = GDKP_Text_Line + 1;
					GDKP_Status_Window = 1;
				end;
			end;
		end;	
		if (getdkp_download_error) then
			local GDKP_Text_Line1 = "";
			GDKP_Text_Line1 = GDKP_Text_Line1.."DKP.exe Error : "..getdkp_download_error;
			getglobal("GDKP_Text"..GDKP_Text_Line):SetText(GDKP_Text_Line1);
			GDKP_Text_Line = GDKP_Text_Line + 1;
			GDKP_Status_Window = 1;
		end;
		if (GDKP_Status_Return == 1) then
			GDKP_Status_Return = 0;
			return;
		else
			print("GETDKP Plus "..GDKP_VERSION.." : loaded ! ", 1.0, 0.0, 0.0 );
			GDKP_LOAD = true;
			if (GETDKP_LISTLOAD == true) then 
				print("GETDKP Plus "..GDKP_VERSION.." : GetDKP List loaded ! ", 1.0, 0.0, 0.0 );
			elseif (GETDKP_LISTLOAD == nil ) then
				print("GETDKP Plus "..GDKP_VERSION.." : GetDKP List not loaded ! ", 1.0, 0.0, 0.0 );
			end;
			if (GETDKP_ADMINLOAD == true) then 
				print("GETDKP Plus "..GDKP_VERSION.." : GetDKP Bet and Win loaded ! ", 1.0, 0.0, 0.0 );
			elseif (GETDKP_LISTLOAD == nil ) then
				print("GETDKP Plus "..GDKP_VERSION.." : GetDKP Bet and Win not loaded ! ", 1.0, 0.0, 0.0 );
			end;
			if (GETDKP_CONFIGLOAD == true) then 
				print("GETDKP Plus "..GDKP_VERSION.." : GetDKP Config loaded ! ", 1.0, 0.0, 0.0 );
			elseif (GETDKP_LISTLOAD == nil ) then
				print("GETDKP Plus "..GDKP_VERSION.." : GetDKP Config not loaded ! ", 1.0, 0.0, 0.0 );
			end;
			if event == "ADDON_LOADED" and arg1 == "GetDKP" then
					if GDKP_Get_Updates == nil or GDKP_Get_Updates ~= GDKP_VERSION then
					GDKP_Get_Updates = GDKP_VERSION;
					StaticPopup_Show("Update_Show");
					end;
				 end;
			if (DKPInfo == nil) then
			print("GETDKP LiveDKP NOT Imported ! No Data found!!!");
			if (nodata_shown) then
				StaticPopup_Show("NO_Data");
				notata_shown = false;
			end;
			else
				if(GDKP_LiveChanged_status ~= nil) and (GDKP_LiveChanged_status == true) and (GDKP_LiveChanged_date ~= nil) and (GDKP_LiveChanged_date == DKPInfo.date) then
					GDKP_LiveChanged_status = true ; 
					if (GDKP_LiveChanged_timestamp) then
						DKPInfo["timestamp"] = GDKP_LiveChanged_timestamp;
					end;
					if(GDKP_Live_saveDKP ~= nil) and (GDKP_Live_saveDKP ~= "") then
						gdkp = GetDKP_TableCopy(GDKP_Live_saveDKP);
						if (GDKP_Live_saveItem ~= nil and GDKP_Live_saveItem ~= "") then
							DKP_ITEMS = GetDKP_TableCopy(GDKP_Live_saveItem);
						end;
						print("GETDKP LiveDKP Imported !", 1.0, 0.0, 0.0 );			
					end;	
					 
												
				else
					GDKP_LiveChanged_status = false ;
					GDKP_LiveChanged_date = nil ;
				end; 
			end;
		end;
	end;	

	if (event == "CHAT_MSG_WHISPER" and multiTable ~= nil) then
		_args = GDKP_GetArgs(arg1, " ");
		
		if ((_args[1] == "dkp") and (GDKPvar_save.requestRP)) then
			GDKP_Konto = nil;
			GDKP_Alias_found = nil;
			local Username, Userrealm = strsplit("-", arg2, 2);
			local Userrealmcheck = checkrealmname(Userrealm);
			local FullUsername=Username.."-"..Userrealmcheck;
			--print(FullUsername);
			if (_args[2] == nil) then
				for i = 1,getn(multiTable),1 do
					--print ("-----------");
					--print(arg2);
					--print (gdkp.players[Username]);
					--print ("...................");
					GDKP_Konto = table.foreach(multiTable[i], VarReturn);
					if (gdkp.players[Username] == nil and gdkp_alliases ~= nil and tonumber(DKPInfo.process_dkp_ver) > 2.60) then
						for key,val in pairs(gdkp_alliases) do
							for i=1,table.getn(gdkp_alliases[key]),1 do
								if (gdkp_alliases[key][i] ==  arg2) then
									SendChatMessage(WHISPER_PREFIX..TEXT_DKPINFO..gdkp.players[key][GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
									
								end;
							end;
						end;
					elseif(gdkp.players[Username] ~= nil) then
						--print("username");
						SendChatMessage(WHISPER_PREFIX..TEXT_DKPINFO..gdkp.players[Username][GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
					elseif(gdkp.players[FullUsername] ~= nil) then
						--print("usernamefull");
						SendChatMessage(WHISPER_PREFIX..TEXT_DKPINFO..gdkp.players[FullUsername][GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
					elseif(gdkp.players[arg2] ~= nil) then
						--print("arg2");
						SendChatMessage(WHISPER_PREFIX..TEXT_DKPINFO..gdkp.players[FullUsername][GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
					
					else
						--print ("-----------");
						--print(Username);
						--print(FullUsername);
						--print("END");
						GDKP_Alias_found = "You are not in this Raid";
					end;
				end;
			else
				_table = "";
				for i=2,getn(_args),1 do
					if (i == getn(_args)) then
						_table = _table.._args[i];
					else
						_table = _table.._args[i].." ";
					end;
				end;
				for i = 1,getn(multiTable),1 do
					if (string.lower(_table) == string.lower(table.foreach(multiTable[i], VarReturn))) then
						GDKP_Konto = table.foreach(multiTable[i], VarReturn);
						if (gdkp.players[Username] == nil and gdkp_alliases ~= nil and tonumber(DKPInfo.process_dkp_ver) > 2.60) then
							for key,val in pairs(gdkp_alliases) do
								for i=1,table.getn(gdkp_alliases[key]),1 do
									if (gdkp_alliases[key][i] ==  arg2) then
										SendChatMessage(WHISPER_PREFIX..TEXT_DKPINFO..gdkp.players[key][GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
									end;
								end;
							end;
						elseif(gdkp.players[Username] ~= nil) then
							SendChatMessage(WHISPER_PREFIX..TEXT_DKPINFO..gdkp.players[Username][GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
						elseif(gdkp.players[FullUsername] ~= nil) then
							SendChatMessage(WHISPER_PREFIX..TEXT_DKPINFO..gdkp.players[FullUsername][GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
						else
							GDKP_Alias_found = "You are not in this Raid";
						end;
					end;
				end;
				if (gdkp.players[_args[2]] ~= nil) then
					if _args[3] ~= nil then
						if is_Konto(_args[3]) then
							GDKP_Konto = getKonto(_args[3]);
							SendChatMessage(WHISPER_PREFIX.._args[2]..": "..gdkp.players[_args[2]][GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
						end
					else
						for i = 1,getn(multiTable),1 do
							GDKP_Konto = table.foreach(multiTable[i], VarReturn);
							SendChatMessage(WHISPER_PREFIX.._args[2]..": "..gdkp.players[_args[2]][GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
						end;
					end
				end
				if ((string.lower(_args[2])) == "stoff") or ((string.lower(_args[2])) == "cloth") then
					if _args[3] == nil then
						-- Stoffklassen �ber alle Konten
						for k=1,getn(multiTable),1 do
							GDKP_Konto = table.foreach(multiTable[k], VarReturn);
							for key, val in pairs(gdkp.players) do
								ClassCur = string.lower(val["class"]);
								if (ClassCur == "mage") or (ClassCur == "magier") or (ClassCur == "priest") or (ClassCur == "priester") or (ClassCur == "warlock") or (ClassCur == "hexenmeister") then
									SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
								end;
							end;
						end;								
					elseif is_Konto(_args[3]) then
					-- Stoffklassen �ber gew�hltes Konto _args[3]
						--GDKP_Konto = _args[3];
						GDKP_Konto = getKonto(_args[3]);
						for key, val in pairs(gdkp.players) do
							ClassCur = string.lower(val["class"]);
							if (ClassCur == "mage") or (ClassCur == "magier") or (ClassCur == "priest") or (ClassCur == "priester") or (ClassCur == "warlock") or (ClassCur == "hexenmeister") then
								SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
							end;
						end;
					end;
				end;
				if ((string.lower(_args[2])) == "platte") or ((string.lower(_args[2])) == "plate") then
					if _args[3] == nil then
						-- Platteklassen �ber alle Konten
						for k=1,getn(multiTable),1 do
							GDKP_Konto = table.foreach(multiTable[k], VarReturn);
							for key, val in pairs(gdkp.players) do
								ClassCur = string.lower(val["class"]);
								if (ClassCur == "warrior") or (ClassCur == "krieger") or (ClassCur == "death knight") or (ClassCur == "todesritter") or (ClassCur == "paladin") then
									SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
								end;
							end;
						end;
					elseif is_Konto(_args[3]) then
					-- Platteklassen �ber gew�hltes Konto _args[3]
						GDKP_Konto = getKonto(_args[3]);
						for key, val in pairs(gdkp.players) do
							ClassCur = string.lower(val["class"]);
							if (ClassCur == "warrior") or (ClassCur == "krieger") or (ClassCur == "death knight") or (ClassCur == "todesritter") or (ClassCur == "paladin") then
								SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
							end;
						end;
					end;
				end;
				if ((string.lower(_args[2])) == "schwere") or ((string.lower(_args[2])) == "mail") then
					if _args[3] == nil then
						-- SchwereR�stungKlassen �ber alle Konten
						for k=1,getn(multiTable),1 do
							GDKP_Konto = table.foreach(multiTable[k], VarReturn);
							for key, val in pairs(gdkp.players) do
								ClassCur = string.lower(val["class"]);
								if (ClassCur == "hunter") or (ClassCur == "j\195\164ger") or (ClassCur == "shaman") or (ClassCur == "schamane") then
									SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
								end;
							end;
						end;
					elseif is_Konto(_args[3]) then
					-- SchwereR�stungKlassen �ber gew�hltes Konto _args[3]
						GDKP_Konto = getKonto(_args[3]);
						for key, val in pairs(gdkp.players) do
							ClassCur = string.lower(val["class"]);
							if (ClassCur == "hunter") or (ClassCur == "j\195\164ger") or (ClassCur == "shaman") or (ClassCur == "schamane") then
								SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
							end;
						end;
					end;
				end;
				if ((string.lower(_args[2])) == "leder") or ((string.lower(_args[2])) == "leather") then
					if _args[3] == nil then
						-- Lederklassen �ber alle Konten
						for k=1,getn(multiTable),1 do
							GDKP_Konto = table.foreach(multiTable[k], VarReturn);
							for key, val in pairs(gdkp.players) do
								ClassCur = string.lower(val["class"]);
								if (ClassCur == "rogue") or (ClassCur == "schurke") or (ClassCur == "druid") or (ClassCur == "druide") then
									SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
								end;
							end;
						end;
					elseif is_Konto(_args[3]) then
					-- Lederklassen �ber gew�hltes Konto _args[3]
						GDKP_Konto = getKonto(_args[3]);
						for key, val in pairs(gdkp.players) do
							ClassCur = string.lower(val["class"]);
							if (ClassCur == "rogue") or (ClassCur == "schurke") or (ClassCur == "druid") or (ClassCur == "druide") then
								SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
							end;
						end;
					end;
				end;
				
				
------------------ Klassenauflistung----------------------------------------------------
				
				if ((string.lower(_args[2])) == "warrior") or ((string.lower(_args[2])) == "krieger") then
					if _args[3] == nil then
						-- Lederklassen �ber alle Konten
						for k=1,getn(multiTable),1 do
							GDKP_Konto = table.foreach(multiTable[k], VarReturn);
							for key, val in pairs(gdkp.players) do
								ClassCur = string.lower(val["class"]);
								if (ClassCur == "warrior") or (ClassCur == "krieger") then
									SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
								end;
							end;
						end;
					elseif is_Konto(_args[3]) then
					-- Lederklassen �ber gew�hltes Konto _args[3]
						GDKP_Konto = getKonto(_args[3]);
						for key, val in pairs(gdkp.players) do
							ClassCur = string.lower(val["class"]);
							if (ClassCur == "warrior") or (ClassCur == "krieger") then
								SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
							end;
						end;
					end;
				end;
				
				if ((string.lower(_args[2])) == "paladin") or ((string.lower(_args[2])) == "paladin") then
					if _args[3] == nil then
						-- Lederklassen �ber alle Konten
						for k=1,getn(multiTable),1 do
							GDKP_Konto = table.foreach(multiTable[k], VarReturn);
							for key, val in pairs(gdkp.players) do
								ClassCur = string.lower(val["class"]);
								if (ClassCur == "paladin") or (ClassCur == "paladin") then
									SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
								end;
							end;
						end;
					elseif is_Konto(_args[3]) then
					-- Lederklassen �ber gew�hltes Konto _args[3]
						GDKP_Konto = getKonto(_args[3]);
						for key, val in pairs(gdkp.players) do
							ClassCur = string.lower(val["class"]);
							if (ClassCur == "paladin") or (ClassCur == "paladin") then
								SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
							end;
						end;
					end;
				end;
				
				if ((string.lower(_args[2])) == "hunter") or ((string.lower(_args[2])) == "j\195\164ger") then
					if _args[3] == nil then
						-- Lederklassen �ber alle Konten
						for k=1,getn(multiTable),1 do
							GDKP_Konto = table.foreach(multiTable[k], VarReturn);
							for key, val in pairs(gdkp.players) do
								ClassCur = string.lower(val["class"]);
								if (ClassCur == "hunter") or (ClassCur == "j\195\164ger") then
									SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
								end;
							end;
						end;
					elseif is_Konto(_args[3]) then
					-- Lederklassen �ber gew�hltes Konto _args[3]
						GDKP_Konto = getKonto(_args[3]);
						for key, val in pairs(gdkp.players) do
							ClassCur = string.lower(val["class"]);
							if (ClassCur == "hunter") or (ClassCur == "j\195\164ger") then
								SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
							end;
						end;
					end;
				end;
				
				if ((string.lower(_args[2])) == "schurke") or ((string.lower(_args[2])) == "rogue") then
					if _args[3] == nil then
						-- Lederklassen �ber alle Konten
						for k=1,getn(multiTable),1 do
							GDKP_Konto = table.foreach(multiTable[k], VarReturn);
							for key, val in pairs(gdkp.players) do
								ClassCur = string.lower(val["class"]);
								if (ClassCur == "rogue") or (ClassCur == "schurke") then
									SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
								end;
							end;
						end;
					elseif is_Konto(_args[3]) then
					-- Lederklassen �ber gew�hltes Konto _args[3]
						GDKP_Konto = getKonto(_args[3]);
						for key, val in pairs(gdkp.players) do
							ClassCur = string.lower(val["class"]);
							if (ClassCur == "rogue") or (ClassCur == "schurke") then
								SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
							end;
						end;
					end;
				end;
				
				if ((string.lower(_args[2])) == "priest") or ((string.lower(_args[2])) == "priester") then
					if _args[3] == nil then
						-- Lederklassen �ber alle Konten
						for k=1,getn(multiTable),1 do
							GDKP_Konto = table.foreach(multiTable[k], VarReturn);
							for key, val in pairs(gdkp.players) do
								ClassCur = string.lower(val["class"]);
								if (ClassCur == "priest") or (ClassCur == "priester") then
									SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
								end;
							end;
						end;
					elseif is_Konto(_args[3]) then
					-- Lederklassen �ber gew�hltes Konto _args[3]
						GDKP_Konto = getKonto(_args[3]);
						for key, val in pairs(gdkp.players) do
							ClassCur = string.lower(val["class"]);
							if (ClassCur == "priest") or (ClassCur == "priester") then
								SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
							end;
						end;
					end;
				end;
				
				if ((string.lower(_args[2])) == "shaman") or ((string.lower(_args[2])) == "schamane") then
					if _args[3] == nil then
						-- Lederklassen �ber alle Konten
						for k=1,getn(multiTable),1 do
							GDKP_Konto = table.foreach(multiTable[k], VarReturn);
							for key, val in pairs(gdkp.players) do
								ClassCur = string.lower(val["class"]);
								if (ClassCur == "shaman") or (ClassCur == "schamane") then
									SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
								end;
							end;
						end;
					elseif is_Konto(_args[3]) then
					-- Lederklassen �ber gew�hltes Konto _args[3]
						GDKP_Konto = getKonto(_args[3]);
						for key, val in pairs(gdkp.players) do
							ClassCur = string.lower(val["class"]);
							if (ClassCur == "shaman") or (ClassCur == "schamane") then
								SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
							end;
						end;
					end;
				end;
				
				if ((string.lower(_args[2])) == "deathknight") or ((string.lower(_args[2])) == "todesritter") then
					if _args[3] == nil then
						-- Lederklassen �ber alle Konten
						for k=1,getn(multiTable),1 do
							GDKP_Konto = table.foreach(multiTable[k], VarReturn);
							for key, val in pairs(gdkp.players) do
								ClassCur = string.lower(val["class"]);
								if (ClassCur == "deathknight") or (ClassCur == "todesritter") then
									SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
								end;
							end;
						end;
					elseif is_Konto(_args[3]) then
					-- Lederklassen �ber gew�hltes Konto _args[3]
						GDKP_Konto = getKonto(_args[3]);
						for key, val in pairs(gdkp.players) do
							ClassCur = string.lower(val["class"]);
							if (ClassCur == "deathknight") or (ClassCur == "todesritter") then
								SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
							end;
						end;
					end;
				end;
				
				if ((string.lower(_args[2])) == "mage") or ((string.lower(_args[2])) == "magier") then
					if _args[3] == nil then
						-- Lederklassen �ber alle Konten
						for k=1,getn(multiTable),1 do
							GDKP_Konto = table.foreach(multiTable[k], VarReturn);
							for key, val in pairs(gdkp.players) do
								ClassCur = string.lower(val["class"]);
								if (ClassCur == "mage") or (ClassCur == "magier") then
									SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
								end;
							end;
						end;
					elseif is_Konto(_args[3]) then
					-- Lederklassen �ber gew�hltes Konto _args[3]
						GDKP_Konto = getKonto(_args[3]);
						for key, val in pairs(gdkp.players) do
							ClassCur = string.lower(val["class"]);
							if (ClassCur == "mage") or (ClassCur == "magier") then
								SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
							end;
						end;
					end;
				end;
				
				if ((string.lower(_args[2])) == "warlock") or ((string.lower(_args[2])) == "hexenmeister") then
					if _args[3] == nil then
						-- Lederklassen �ber alle Konten
						for k=1,getn(multiTable),1 do
							GDKP_Konto = table.foreach(multiTable[k], VarReturn);
							for key, val in pairs(gdkp.players) do
								ClassCur = string.lower(val["class"]);
								if (ClassCur == "warlock") or (ClassCur == "hexenmeister") then
									SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
								end;
							end;
						end;
					elseif is_Konto(_args[3]) then
					-- Lederklassen �ber gew�hltes Konto _args[3]
						GDKP_Konto = getKonto(_args[3]);
						for key, val in pairs(gdkp.players) do
							ClassCur = string.lower(val["class"]);
							if (ClassCur == "warlock") or (ClassCur == "hexenmeister") then
								SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
							end;
						end;
					end;
				end;	
				
				if ((string.lower(_args[2])) == "monk") or ((string.lower(_args[2])) == "m\195\182nch") then
					if _args[3] == nil then
						-- Lederklassen �ber alle Konten
						for k=1,getn(multiTable),1 do
							GDKP_Konto = table.foreach(multiTable[k], VarReturn);
							for key, val in pairs(gdkp.players) do
								ClassCur = string.lower(val["class"]);
								if (ClassCur == "monk") or (ClassCur == "m\195\182nch") then
									SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
								end;
							end;
						end;
					elseif is_Konto(_args[3]) then
					-- Lederklassen �ber gew�hltes Konto _args[3]
						GDKP_Konto = getKonto(_args[3]);
						for key, val in pairs(gdkp.players) do
							ClassCur = string.lower(val["class"]);
							if (ClassCur == "monk") or (ClassCur == "m\195\182nch") then
								SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
							end;
						end;
					end;
				end;
				
				if ((string.lower(_args[2])) == "druid") or ((string.lower(_args[2])) == "druide") then
					if _args[3] == nil then
						-- Lederklassen �ber alle Konten
						for k=1,getn(multiTable),1 do
							GDKP_Konto = table.foreach(multiTable[k], VarReturn);
							for key, val in pairs(gdkp.players) do
								ClassCur = string.lower(val["class"]);
								if (ClassCur == "druid") or (ClassCur == "druide") then
									SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
								end;
							end;
						end;
					elseif is_Konto(_args[3]) then
					-- Lederklassen �ber gew�hltes Konto _args[3]
						GDKP_Konto = getKonto(_args[3]);
						for key, val in pairs(gdkp.players) do
							ClassCur = string.lower(val["class"]);
							if (ClassCur == "druid") or (ClassCur == "druide") then
								SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
							end;
						end;
					end;
				end;
				
				if ((string.lower(_args[2])) == "token") then
					if _args[3] == nil then
						SendChatMessage(WHISPER_PREFIX..": "..GDC_Whisper_Token_Usage, "WHISPER", this.language,arg2);
					
					-- Schurke Todesritter magier Druide
					elseif (((string.lower(_args[3])) == "rogue") 
					or ((string.lower(_args[3])) == "schurke")
					or ((string.lower(_args[3])) == "todesritter")
					or ((string.lower(_args[3])) == "deathknight")
					or ((string.lower(_args[3])) == "magier")
					or ((string.lower(_args[3])) == "mage")
					or ((string.lower(_args[3])) == "druid")
					or ((string.lower(_args[3])) == "druide")) then
						-- Lederklassen �ber alle Konten
						for k=1,getn(multiTable),1 do
							GDKP_Konto = table.foreach(multiTable[k], VarReturn);
							for key, val in pairs(gdkp.players) do
								ClassCur = string.lower(val["class"]);
								if (ClassCur == "druid") 
								or (ClassCur == "druide") 
								or (ClassCur == "todesritter") 
								or (ClassCur == "deathknight") 
								or (ClassCur == "magier") 
								or (ClassCur == "mage") 
								or (ClassCur == "rogue") 
								or (ClassCur == "schurke") then
									SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
								end;
							end;
						end;
										
					
					elseif (((string.lower(_args[3])) == "paladin") 
					or ((string.lower(_args[3])) == "paladin")
					or ((string.lower(_args[3])) == "priest")
					or ((string.lower(_args[3])) == "priester")
					or ((string.lower(_args[3])) == "warlock")
					or ((string.lower(_args[3])) == "hexenmeister")) then
						-- Lederklassen �ber alle Konten
						for k=1,getn(multiTable),1 do
							GDKP_Konto = table.foreach(multiTable[k], VarReturn);
							for key, val in pairs(gdkp.players) do
								ClassCur = string.lower(val["class"]);
								if (ClassCur == "paladin") 
								or (ClassCur == "paladin") 
								or (ClassCur == "priest") 
								or (ClassCur == "priester") 
								or (ClassCur == "warlock") 
								or (ClassCur == "hexenmeister")  then
									SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
								end;
							end;
						end;
										
					elseif (((string.lower(_args[3])) == "krieger") 
					or ((string.lower(_args[3])) == "warrior")
					or ((string.lower(_args[3])) == "j\195\164ger")
					or ((string.lower(_args[3])) == "hunter")
					or ((string.lower(_args[3])) == "monk")
					or ((string.lower(_args[3])) == "m\195\182nch")
					or ((string.lower(_args[3])) == "shaman")
					or ((string.lower(_args[3])) == "schamane")) then
						-- Lederklassen �ber alle Konten
						for k=1,getn(multiTable),1 do
							GDKP_Konto = table.foreach(multiTable[k], VarReturn);
							for key, val in pairs(gdkp.players) do
								ClassCur = string.lower(val["class"]);
								if (ClassCur == "krieger") 
								or (ClassCur == "warrior") 
								or (ClassCur == "j\195\164ger") 
								or (ClassCur == "hunter") 
								or (ClassCur == "m\195\182nch") 
								or (ClassCur == "shaman") 
								or (ClassCur == "schamane") 
								or (ClassCur == "monk") then
									SendChatMessage(WHISPER_PREFIX..key..": "..val[GDKP_Konto.."_current"].." "..GDKP_Konto.." "..dkpstring, "WHISPER", this.language,arg2);
								end;
							end;
						end;
					end;
				end;
					
				
			end;
			
			if ((GDKP_Konto == nil and (string.lower(_args[2])) ~= "token")) then
				SendChatMessage(WHISPER_PREFIX.." "..TEXT_DKP_HELP_Whisper,"WHISPER",this.language,arg2);
			end;
		
			if (GDKP_Alias_found ~= nil) then
				SendChatMessage(GDKP_Alias_found,"WHISPER",this.language,arg2);
			end;
		end;
	

		
		if ((GDKPvar_save.requestItems == true) and (GDKPvar_save.requestItems)) then      
			if (string.lower(_args[1]) == "item") then  
				if not allowWhisper then
					SendChatMessage(TEXT_DKP_FIGHT_WHISPER, "WHISPER", this.language,arg2);
					return;
				end;
				args = GDKP_GetArgs(arg1, " ");
				requestfrom = arg2 ;
				itemlockup = string.sub(arg1,string.len("item")+2) ;
				_output = "wisper" ;
				GDKP_item_lookup(requestfrom,itemlockup,_output);
				GDKP_cmd_HOW_HASNT_ITEM(itemlockup,_output);			
			elseif  (string.lower(_args[1]) == "items") then 			
				if not allowWhisper then
					SendChatMessage(TEXT_DKP_FIGHT_WHISPER, "WHISPER", this.language,arg2);
					return;
				end;
				args = GDKP_GetArgs(arg1, " ");
				requestfrom = arg2 ;
				playerlockup = args[2] ;
				_output = "wisper" ;
				GDKP_Display_ItemHistory(requestfrom,playerlockup,_output);		
			end;	
		end; 
		
		if (string.lower(_args[1]) == "info") then  
			GDKP_info("wisper");
		end;
  	end;
	-- event msg wisper
--[[	if (event == "PLAYER_TARGET_CHANGED") then
		if (UnitIsUnit("target", "player")) then
			return;
		elseif (UnitIsPlayer("target")) then
			GDKP_searchTargetItem("target");
		end;
	end;
	
	if (event == "UPDATE_MOUSEOVER_UNIT") then
		if( UnitIsPlayer("mouseover") ) then
			GDKP_searchTargetItem("mouseover");
		end;
	end;]]--
end
	
-- Eventhandler for hiding whispers
function GetDKP_BlockIncomingChatFrame_OnEvent(msg, arg1)
	--GDKP_Output("called Inc msg: "..arg1,"lokal");
	if GDKPvar_save.HideOutGoingWhisper then
		if is_dkpwhisper(msg, "Incoming", arg1) then
			--GDKP_Output("blocked incoming: "..msg,"lokal");
			return true;
		end;
	end;
	return false;
end
function GetDKP_BlockOutgoingChatFrame_OnEvent(msg, arg1)
	--GDKP_Output("called Out msg: "..arg1,"lokal");
	if GDKPvar_save.HideOutGoingWhisper then
		if is_dkpwhisper(msg, "Outgoing", arg1) then
			--GDKP_Output("blocked outgoing: "..msg,"lokal");
			return true;
		end;
	end;
	return false;
end

-- Lookup of msg is an dkp_whisper to block
function is_dkpwhisper(msg, direction, arg1)
	local locmsg = strlower(arg1);
	local startPos, endPos, firstWord, restOfString;
	if (direction == "Incoming") then
		startPos, endPos, firstWord, restOfString = strfind(locmsg, "dkp");
		if (locmsg == "dkp") then
			return true;
		elseif ((startPos == 1) and (endPos == 3)) then
			return true;
		end;
	elseif (direction == "Outgoing") then
		startPos, endPos, firstWord, restOfString = string.find(locmsg, strlower(WHISPER_PREFIX));
		if (startPos==1) then
			return true;
		end;
	end;
	return false;
end

-- Check if str is an dkp-account
function is_Konto(str)
	local found = false;
	for i=1, getn(multiTable),1 do 
		if (string.lower(str) == string.lower(table.foreach(multiTable[i], VarReturn))) then
			found = true;
		end;
	end;
	return found;
end;

-- return acc-name (str MUST be an acc)
function getKonto(str)
	for i=1, getn(multiTable),1 do 
		if (string.lower(str) == string.lower(table.foreach(multiTable[i], VarReturn))) then
			return table.foreach(multiTable[i], VarReturn);
		end;
	end;
end;

function GETDKP_ShowDKP(msg,_table)
local DKP_Table 
		
	if msg == nil then 
		msg = "";
	end;	
	
	dkpstring = TEXT_DKP_DKP;
	
	if _table == "" or _table == nil or _table == "set" then
		DKP_Table = {}
		DKP_Table = GetDKPCreateDKPTable(gdkp)				--set
	end;	

	
	if (DKP_Table ~= nil) then
	
		if GDKPvar_save.ShowOnlyInRaid == true then
			GDKP_Output(TEXT_DKP_ShowOnlyInRaid,GDKPvar_save.reportChannel) ;
		end;
		
		local f
		
		if (GDKPvar_save.reportChannel == nil) or (GDKPvar_save.reportChannel =="") then
			GDKPvar_save.reportChannel = "lokal"
		end;
		
		if GDKPvar_save.reportChannel == "lokal" then
			f = "|cff00aeef<"..dkpstring..">|r ";
		else
			f = "<"..dkpstring..">";
		end;
		
		local format =f.."%s: %s "				
		local search = {};	
		--table.sort(gdkp.players)
		table.sort(DKP_Table)
		
		if (string.lower(msg) == GDKP_Search_alle_eng) or (string.lower(msg) == GDKP_Search_alle_de) then
			GDKP_Output(osrHeader..TEXT_DKP_LISTE..TEXT_DKP_LISTE_ALLE,GDKPvar_save.reportChannel) ;
			--for key, val in sortedPairs(gdkp.players) do 				
			for key, val in sortedPairs(DKP_Table) do 				
					GDKP_Output(string.format(format, key, val[GDKP_Konto.."_current"]),GDKPvar_save.reportChannel) ;
			end
		elseif (string.lower(msg) == string.lower(GDKP_Search_Warlock_eng)) or (string.lower(msg) == string.lower(GDKP_Search_Warlock_de)) then
			GDKP_Output(osrHeader..TEXT_DKP_LISTE..string.lower(msg),GDKPvar_save.reportChannel) ;
			for key, val in sortedPairs(DKP_Table) do 
						if (val.class == GDKP_Search_Warlock_eng) or (val.class == GDKP_Search_Warlock_de) then
							GDKP_Output(string.format(format, key, val[GDKP_Konto.."_current"]),GDKPvar_save.reportChannel);
						end
			end
		elseif (string.lower(msg) == string.lower(GDKP_Search_Druid_eng)) or (string.lower(msg) == string.lower(GDKP_Search_Druid_de)) then
			GDKP_Output(osrHeader..TEXT_DKP_LISTE..string.lower(msg),GDKPvar_save.reportChannel) ;
			for key, val in sortedPairs(DKP_Table) do
						if (val.class == GDKP_Search_Druid_eng) or (val.class == GDKP_Search_Druid_de) then
							GDKP_Output(string.format(format, key, val[GDKP_Konto.."_current"]),GDKPvar_save.reportChannel);
						end
			end		
		elseif (string.lower(msg) == string.lower(GDKP_Search_Mage_eng)) or (string.lower(msg) == string.lower(GDKP_Search_Mage_de)) then
			GDKP_Output(osrHeader..TEXT_DKP_LISTE..string.lower(msg),GDKPvar_save.reportChannel) ;
			for key, val in sortedPairs(DKP_Table) do
						if (val.class == GDKP_Search_Mage_eng) or (val.class == GDKP_Search_Mage_de) then
							GDKP_Output(string.format(format, key, val[GDKP_Konto.."_current"]),GDKPvar_save.reportChannel);
						end
			end
		elseif (string.lower(msg) == string.lower(GDKP_Search_Hunter_eng)) or (string.lower(msg) == string.lower(GDKP_Search_Hunter_de)) then
			GDKP_Output(osrHeader..TEXT_DKP_LISTE..string.lower(msg),GDKPvar_save.reportChannel) ;
			for key, val in sortedPairs(DKP_Table) do
						if (val.class == GDKP_Search_Hunter_eng) or (val.class == GDKP_Search_Hunter_de) then
							GDKP_Output(string.format(format, key, val[GDKP_Konto.."_current"]),GDKPvar_save.reportChannel);
						end
			end
		elseif (string.lower(msg) == string.lower(GDKP_Search_Rogue_eng)) or (string.lower(msg) == string.lower(GDKP_Search_Rogue_de)) then
			GDKP_Output(osrHeader..TEXT_DKP_LISTE..string.lower(msg),GDKPvar_save.reportChannel) ;
			for key, val in sortedPairs(DKP_Table) do
						if (val.class == GDKP_Search_Rogue_eng) or (val.class == GDKP_Search_Rogue_de) then
							GDKP_Output(string.format(format, key, val[GDKP_Konto.."_current"]),GDKPvar_save.reportChannel);
						end
			end
		elseif (string.lower(msg) == string.lower(GDKP_Search_Priest_eng)) or (string.lower(msg) == string.lower(GDKP_Search_Priest_de)) then
			GDKP_Output(osrHeader..TEXT_DKP_LISTE..string.lower(msg),GDKPvar_save.reportChannel) ;
			for key, val in sortedPairs(DKP_Table) do
						if (val.class == GDKP_Search_Priest_eng) or (val.class == GDKP_Search_Priest_de) then
							GDKP_Output(string.format(format, key, val[GDKP_Konto.."_current"]),GDKPvar_save.reportChannel);
						end
			end
		elseif (string.lower(msg) == string.lower(GDKP_Search_Warrior_eng)) or (string.lower(msg) == string.lower(GDKP_Search_Warrior_de)) then
			GDKP_Output(osrHeader..TEXT_DKP_LISTE..string.lower(msg),GDKPvar_save.reportChannel) ;
			for key, val in sortedPairs(DKP_Table) do
						if (val.class == GDKP_Search_Warrior_eng) or (val.class == GDKP_Search_Warrior_de) then
							GDKP_Output(string.format(format, key, val[GDKP_Konto.."_current"]),GDKPvar_save.reportChannel);
						end
			end
		elseif (string.lower(msg) == string.lower(GDKP_Search_Shaman_eng)) or (string.lower(msg) == string.lower(GDKP_Search_Shaman_de)) then
			GDKP_Output(osrHeader..TEXT_DKP_LISTE..string.lower(msg),GDKPvar_save.reportChannel) ;
			for key, val in sortedPairs(DKP_Table) do
						--GDKP_show("valclass: "..val.class.."  eng: "..GDKP_Search_Shaman_eng.." de: "..GDKP_Search_Shaman_de);
						if (val.class == GDKP_Search_Shaman_eng) or (val.class == GDKP_Search_Shaman_de) then
							GDKP_Output(string.format(format, key, val[GDKP_Konto.."_current"]),GDKPvar_save.reportChannel);
						end
			end
		elseif (string.lower(msg) == string.lower(GDKP_Search_Paladin_eng)) or (string.lower(msg) == string.lower(GDKP_Search_Paladin_de)) then
			GDKP_Output(osrHeader..TEXT_DKP_LISTE..string.lower(msg),GDKPvar_save.reportChannel) ;
			for key, val in sortedPairs(DKP_Table) do
						if (val.class == GDKP_Search_Paladin_eng) or (val.class == GDKP_Search_Paladin_de) then
							GDKP_Output(string.format(format, key, val[GDKP_Konto.."_current"]),GDKPvar_save.reportChannel);
						end
			end
		elseif (string.lower(msg) == string.lower(GDKP_Search_DeathKnight_eng)) or (string.lower(msg) == string.lower(GDKP_Search_DeathKnight_de)) then
			GDKP_Output(osrHeader..TEXT_DKP_LISTE..string.lower(msg),GDKPvar_save.reportChannel) ;
			for key, val in sortedPairs(DKP_Table) do
						if (val.class == GDKP_Search_DeathKnight_eng) or (val.class == GDKP_Search_DeathKnight_de) then
							GDKP_Output(string.format(format, key, val[GDKP_Konto.."_current"]),GDKPvar_save.reportChannel);
						end
			end
		elseif (string.lower(msg) == string.lower(GDKP_Search_stoff_eng)) or (string.lower(msg) == string.lower(GDKP_Search_stoff_de)) then
			GDKP_Output(osrHeader..TEXT_DKP_LISTE..string.lower(msg),GDKPvar_save.reportChannel) ;
			for key, val in sortedPairs(DKP_Table) do 		
						if (val.class == GDKP_Search_Warlock_eng) or (val.class == GDKP_Search_Warlock_de) or 
						  (val.class == GDKP_Search_Mage_eng) or (val.class == GDKP_Search_Mage_de) or
						  (val.class == GDKP_Search_Priest_eng) or (val.class == GDKP_Search_Priest_de) then				
							GDKP_Output(string.format(format, key, val[GDKP_Konto.."_current"]),GDKPvar_save.reportChannel );
						end
			end
		elseif (string.lower(msg) == string.lower(GDKP_Search_leder_eng)) or (string.lower(msg) == string.lower(GDKP_Search_leder_de)) then
			GDKP_Output(osrHeader..TEXT_DKP_LISTE..string.lower(msg),GDKPvar_save.reportChannel) ;
			for key, val in sortedPairs(DKP_Table) do 
						if (val.class == GDKP_Search_Rogue_eng) or (val.class == GDKP_Search_Rogue_de) or 				
						  (val.class == GDKP_Search_Druid_eng) or (val.class == GDKP_Search_Druid_de) then	
							GDKP_Output(string.format(format, key, val[GDKP_Konto.."_current"]),GDKPvar_save.reportChannel);
						end
			end
		elseif (string.lower(msg) == string.lower(GDKP_Search_platte_eng)) or (string.lower(msg) == string.lower(GDKP_Search_platte_de)) then
			GDKP_Output(osrHeader..TEXT_DKP_LISTE..string.lower(msg),GDKPvar_save.reportChannel) ;
			for key, val in sortedPairs(DKP_Table) do 
						 if (val.class == GDKP_Search_Warrior_eng) or (val.class == GDKP_Search_Warrior_de) or 				
						  (val.class == GDKP_Search_Paladin_eng) or (val.class == GDKP_Search_Paladin_de) then	
							GDKP_Output(string.format(format, key, val[GDKP_Konto.."_current"]),GDKPvar_save.reportChannel);
						end
			end
		elseif (string.lower(msg) == string.lower(GDKP_Search_schwer_eng)) or (string.lower(msg) == string.lower(GDKP_Search_schwer_de)) then
			GDKP_Output(osrHeader..TEXT_DKP_LISTE..string.lower(msg),GDKPvar_save.reportChannel) ;
			for key, val in sortedPairs(DKP_Table) do 
						 if (val.class == GDKP_Search_Shaman_eng) or (val.class == GDKP_Search_Shaman_de) or 				
						  (val.class == GDKP_Search_Hunter_eng) or (val.class == GDKP_Search_Hunter_de) then	
							GDKP_Output(string.format(format, key, val[GDKP_Konto.."_current"]),GDKPvar_save.reportChannel);
						end
			end
		else -- no given searchname found, try to look for Playernames
			
			for w in string.gmatch(string.lower(msg), "%S+") do	-- insert msg into Table search						
					table.insert(search, w);
			end
			
			if table.getn(search) == 0 then				-- count search
					GDKP_show(string.format(format, UnitName("player"), DKP_Table[UnitName("player")][GDKP_Konto.."_current"] ));			--/dkp 
			else			
					--GDKP_show(TEXT_DKP_SEARCH..table.getn(search)..TEXT_DKP_PLAYER);									--/dkp xxx
			end
			
			--Hachima start
			for _,search_name in pairs(search) do --First find missing players
				local match = 0;
				for key, val in sortedPairs(DKP_Table) do
					if (search_name == string.lower(key)) then
					--if string.gmatch(string.lower(search_name),string.lower(key)) then
						match = 1;
					end
				end
				if (match == 0) then
					GDKP_show(TEXT_DKP_PLAYER..search_name..TEXT_DKP_NOTFOUND);
				 end
			end
	
			--next show players sorted by DKP
			for key, val in sortedPairs(DKP_Table) do
				for _,search_name in pairs(search) do
					if (search_name == string.lower(key)) then
						--if string.find(string.lower(search_name),string.lower(key)) then
						--GDKP_show(string.format(format, key, val.dkp));
						GDKP_Output(string.format(format, key, val[GDKP_Konto.."_current"]),GDKPvar_save.reportChannel);
					end
				end
			end	
			
		end -- end else
	end	-- end (DKP_Table ~= nil) 
end -- end function


--################################################# Output #######################################

function GDKP_Output(msg,_channel, ...)
	local arg1, arg2 = ...
	if _channel == "wisper" then
		msg = WHISPER_PREFIX..msg
		SendChatMessage(msg,"WHISPER", this.language,arg2);
	elseif _channel == "lokal" then
		print(msg);
	elseif _channel == "WHISPER" then
		msg = WHISPER_PREFIX..msg
		SendChatMessage(msg,"WHISPER", this.language,arg2);
	elseif _channel == "RAID" then
		SendChatMessage(msg, "RAID"); 
	elseif _channel == "PARTY" then
		SendChatMessage(msg, "PARTY"); 
	elseif _channel == "GUILD" then	
		SendChatMessage(msg, "GUILD");
	elseif _channel == "SAY" then	
		SendChatMessage(msg, "SAY"); 
	elseif (_channel == "officer") or (_channel == "Officer") then	
		SendChatMessage(msg, "Officer"); 
	else
		msg = WHISPER_PREFIX..msg
		SendChatMessage(msg,"WHISPER", this.language,_channel);		
	end; 	
end;

--#############################################output function ###################################

function GDKP_show(msg)
	print(msg);
end

function GDKP_show_items(msg)
	print(msg);
end

function GDKP_Send_Whisper(playerName, Message) 				
		return SendChatMessage(WHISPER_PREFIX..Message, "WHISPER", this.language, playerName);
end
--################################################# Functions #######################################

function GDKP_DKP_Sub(msg)
	if IsPromoted() then
		GDKP_MATH_DKP_MAN(msg,"sub","true","true","");
	else
		GDKP_show(TEXT_DKP_LiveError);
	end;
end;

function GDKP_DKP_Add(msg)
	if IsPromoted() then
		GDKP_MATH_DKP_MAN(msg,"add","true","true","");
	else
		GDKP_show(TEXT_DKP_LiveError);
	end;
end;


-- check if Player is promoted in the current raid
function IsPromoted()
	--return true;
	return UnitIsGroupAssistant("player") or UnitIsGroupLeader("player");
end;

-- check if Player is in the current Raid
function GetDKP_CheckifPlayerIsInRaid(msg)
local areturn = false ;

	if msg == nil or msg == "" then
		return areturn
	else
		if  GetNumGroupMembers()  > 0 then		--Raid exists
			for i = 1,GetNumGroupMembers() do 
				
				if GetRaidRosterInfo(i) ~= nil then
					if string.lower(msg) == string.lower(GetRaidRosterInfo(i)) then 
							
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

-- Copy a table 
function GetDKP_TableCopy(tsrc)
	if tsrc == nil then
		return
	end;

  local tdest = { }
  for key, value in pairs(tsrc) do
    if (type(value) == "table") then
      tdest[key] = GetDKP_TableCopy(value)
	else
      tdest[key] = value
    end
  end
  
  return tdest
end

--copy only the Players in the Raid .
function GetDKPCreateDKPTable(tsrc,raid)
local key, value
local tdest = { }
	
	if tsrc == nil then
		return
	end;

	for key, val in pairs(tsrc.players) do 
		if GDKPvar_save.ShowOnlyInRaid == true then
			if GetDKP_CheckifPlayerIsInRaid(key) then
				tdest[key] = val
			end;	
		else
			tdest[key] = val		
		end;	
	end
	
return tdest
end;

--######################### Functions ##########################

--true if player owns items 
function checkifPlayerHaveItems(msg)
areturn = false
	if (msg ~= nil) and (msg ~= "") then
		for playerName, playerAttrib in pairs(DKP_ITEMS) do		
			if string.lower(playerName) == string.lower(msg) then
				areturn = true ;		
			end
		end;
	end;
return areturn	
end;

-- search for itemlink from [item] to get Itemid
function getdkp_GetLinkID_FromLinkedItemname(msg)
local areturn_link  = "";
 	if (msg ~= nil) and (msg ~= "" ) then
		for color, item, name in string.gmatch(msg, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+:%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r") do
			
			if( color and item and name and name ~= "" ) then	
				areturn_link = string.gsub(item, "^(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+)$", "%1:0:%3:%4");					 
			end;
		end
	end
return areturn_link ;	
end;

-- sucht in gdkp_sets nach der itemid und gibt die setinformationen zurück
function get_Informations_of_Item(msg)
local color;
local item;
local name;
local itemlink ;
local aclassde = "" ;
local aclasseng = "" ;
local anamede = "" ;
local anameeng = "" ;
local atier = "" ;
local adrop = "" ;
local LLItemlinkText = "" ;
local ItemName, ItemValues ;
local flag ;
local itemtable = {}
local i;

	itemlink = getdkp_GetLinkID_FromLinkedItemname(msg);

	-- itemlink direkt ansprechen aus gdkp_sets
	if gdkp_sets.items[itemlink] ~= nil then 
		aclassde = gdkp_sets.items[itemlink].Class_de; 
		aclasseng = gdkp_sets.items[itemlink].Class_eng; 
		anamede = gdkp_sets.items[itemlink].name_de; 
		anameeng = gdkp_sets.items[itemlink].name_eng; 
		atier = gdkp_sets.items[itemlink].Tier; 
		adrop = gdkp_sets.items[itemlink].droptby; 
	else -- tooltip, abfrage auf Namen in gdkp_sets
		for key, val in pairs(gdkp_sets.items) do 
			if (msg == val.name_de) or (msg == val.name_eng) then
				aclassde = val.Class_de
				aclasseng = val.Class_eng
				anamede = val.name_de
				anameeng = val.name_eng
				atier = val.Tier
				adrop = val.droptby
			end;			
		end
	end;
		
	-- lootlink search
	if aclassde == "" and ItemLinks ~= nil then
		--built e real [item] from Itemname
		LLItemlinkText = GDKP_Check_Loot_Text(msg) ;
		itemlink = "";
		color = "";
		item = "";
		name = "";
		itemlink = "";
		
		i = 1 ;
		-- search for itemlink from [item] to get Itemid
		itemlink = getdkp_GetLinkID_FromLinkedItemname(LLItemlinkText);
		if itemlink ~= "" then -- search for ItemID in Lootlink
			for ItemName, ItemValues in pairs(ItemLinks) do				
				if ItemLinks[ItemName]['i'] == itemlink then  -- if LootlinkID match with ID from given Item
					itemtable[i] = ItemName; --insert into arry if more than one name
					i = i+1 ;	
				end
			end
			
			if itemtable[1] ~= nil then
				anamede = itemtable[1] ;
			end;	
			if itemtable[2] ~= nil then
				anameeng = itemtable[2] ;
			end;
		end;	
	end;
	
	return aclassde,aclasseng,anamede,anameeng,atier,adrop ;
end;


-- min,max, avg dkp point from item 
function GDKP_item_info(aItemLookup)
	local count = 0 ;
	local realcount = 0 ;
	local _min = 99999  ;
	local _max = 0 ;
	local _avg = 0 ;
	local CLASSNAME_DE = "" ;
	local CLASSNAME_ENG = "" ;
	local anamede = "" ;
	local anameeng = "" ;
	local atier = "" ;
	local adrop = "" ;

	CLASSNAME_DE,CLASSNAME_ENG,anamede,anameeng,atier,adrop = get_Informations_of_Item(aItemLookup) ;
	
	GDKPvar_save.ignoreValue = 0 ;
	
	if DKP_ITEMS == nil then
		return 0,0,0,0 ;
	end;

	for vPlayer in pairs(DKP_ITEMS) do
		for j=1, getn(DKP_ITEMS[vPlayer]["Items"]),1 do
			if (DKP_ITEMS[vPlayer]["Items"][j].name == GDKP_Extrace_Loot_Text(aItemLookup)) or (DKP_ITEMS[vPlayer]["Items"][j].name == anamede) or (DKP_ITEMS[vPlayer]["Items"][j].name == anameeng) then 
				count = count + 1 ;	
				
				if GDKPvar_save.ignoreValue ~= DKP_ITEMS[vPlayer]["Items"][j].dkp  then
					realcount = realcount + 1 ;
					if DKP_ITEMS[vPlayer]["Items"][j].dkp < _min then
					  _min = DKP_ITEMS[vPlayer]["Items"][j].dkp ;
					end;
	
					if DKP_ITEMS[vPlayer]["Items"][j].dkp > _max then
						_max = DKP_ITEMS[vPlayer]["Items"][j].dkp
					end;
	
					_avg = _avg + DKP_ITEMS[vPlayer]["Items"][j].dkp ;							
				end;	
			end;
		end
	end	
	
	if count > 0 then
		_avg = math.ceil(_avg / realcount)  ;
		if _min == 99999 then
			_min = 0 ;
		end;	
		return _min,_max,_avg,count
	else
		return 0,0,0,0 ;
	end;
	
end

-- Sortiert GDKP Tabelle
function sortedPairs (t) 
	local a = {} --temp table
	for n in pairs(t) do table.insert(a, n) end --create temp table

	local j = 1;
	local delete = 0;
	local largest = 1;
	if (GDKP_Konto == nil or GDKP_Konto == "") then
		GDKP_Konto = table.foreach(multiTable[1], VarReturn);
	end;
	local iter = function () --iteration function
	j=1;
	if (a[1] == nil) then return nil end --we have returned all table values
		if(delete == 1) then  --remove the largest value from the table
			table.remove(a,largest); 
			delete = 0;
		end
		largest=1;
		while(a[j]~= nil) do --find the largest value
			if(t[a[j]][GDKP_Konto.."_current"] > t[a[largest]][GDKP_Konto.."_current"]) then 
				largest=j;
			end
			j = j+1; 
		end --while
		delete=1;
		return a[largest], t[a[largest]] --return the largest value
	end
      
	return iter
end   
--Hachima End

-- Gibt Tablelle mit Argumenten zurck
function GDKP_GetArgs(message, separator)
	if (message == nil) then
		return;
	end;
	-- Declare 'args' variable.
	local args = {};

	-- Declare 'i' integer.
	i = 0;

	-- Search for seperators in the string and return
	-- the separated data.
	
	for value in string.gmatch(message, "[^"..separator.."]+") do
		i = i + 1;
		args[i] = value;
	end -- end for

	-- Submit the filtered data.
	return args;
end -- end GetArgs()

-- Itemformatierung fr Lootlink oder Itemmatrix
function GDKP_Check_Loot_Text(checkItemName) 

if checkItemName == nil or checkItemName == "" then
return ;
end;

		local ItemName, ItemValues;
		local ItemFound = false;
		
		local IMitem;
		local ItemColor, ItemCode;
		
		local ItemText = "";
				

		if ((ItemLinks == nil) and (IMDB == nil)) then
				-- If lootlink isn't installed, just return back with original text
				return checkItemName; 
		end
		
		-- ItemMatrix Code
		if (IMDB ~= nil) then
				--DEFAULT_CHAT_FRAME:AddMessage("ItemMatrix Found");
		
				-- Sort out IM's garble
				-- ffffffff6265:0:0:46458008
				local pattern_im_item = "(.+)(.+)";						
				
				for ItemName, ItemValues in pairs(IMDB) do
						if (string.lower(ItemName) == string.lower(checkItemName)) then														
								--DEFAULT_CHAT_FRAME:AddMessage("Item Found.");						
								
								IMitem = IMDB[ItemName];
								
								for ItemColor, ItemCode in string.gmatch(IMitem, pattern_im_item) do															
										ItemText = "|c".. ItemColor .."|Hitem:".. ItemCode .."|h[".. ItemName .."]|h|r";
										ItemFound = true;
								end
						end
						
				end																							

		-- LootLink Code
		else
				--DEFAULT_CHAT_FRAME:AddMessage("Lootlink Found");
				for ItemName, ItemValues in pairs(ItemLinks) do
						if (string.lower(ItemName) == string.lower(checkItemName)) then
								ItemFound = true;
								
								ItemText = "|c".. ItemLinks[ItemName]['c'] .."|Hitem:".. ItemLinks[ItemName]['i'] .."|h[".. ItemName .."]|h|r";				
						end
				end
		end
		
		if (ItemFound) then
				return ItemText;
		else
				return checkItemName;
		end
end

--sucht nach dem Namen in der GDKP und gibt den zur�ck
function getNameCasesensitiv(msg)
local areturn = "" ;
	for key, val in pairs(gdkp.players) do 
		if string.lower(key) == string.lower(msg) then
			areturn = key ;
		end;
	end;
return areturn
end;

--Entfernt [] vom gelinkten Item by Guido
function GDKP_Extrace_Loot_Text(aItemText)

if aItemText == nil then
return ""
end;

	for item, name in string.gmatch(aItemText, "|Hitem:(%d+:%d+:%d+:%d+:%d+:%d+:%d+:%d+)|h%[(.-)%]|h") do
			return name;
	end
	
	return aItemText;
end

function GETDKP_CTRT_GetValues(f, f_note, filter)
	local clog = CT_RaidTracker_RaidLog
    local getId = CT_RaidTracker_GetLootId
    if not f or not f_note or not clog or not getId then return end
    local dkpstring = f_note:GetText()
    local raid = f.raidid and clog[f.raidid]
    if not raid or not dkpstring or not f.itemitemid then return end
    local _looter = "";
    local _item = "";
    if (not filter or f.type == filter) and f.itemplayer and f.itemtime then
        local lootid = getId(f.raidid, f.itemplayer, f.itemitemid, f.itemtime)
        _looter = raid.Loot[lootid]["player"] ;
        _item = raid.Loot[lootid]["item"]["name"] ;
    end
	
    return f.type,_looter,_item,dkpstring
end

function GETDKP_ProcessSaveNote(_type,_looter,_item,dkpstring)
    if not _type or not _looter or not _item or _dkpstring == "" then return end
    
    if not IsPromoted() then
        GDKP_show(TEXT_DKP_LiveError);
        return;
    end
    if (IsPromoted()) then
        Chan = "RAID"
    else
        Chan = "lokal"    
    end    
    if GDKPvar_save.LiveDKP ~= true then
        print("GETDKP Live DKP is"..GDKPvar_save.LiveDKP);
        return
    end;
        
    if ( _type == "itemnote" ) then
        local _args = GDKP_GetArgs(dkpstring, " ");
        local dkpvalue = tonumber(_args[1])
        if dkpvalue == nil then
            return;
        end;    
        
        _dkptable = "";
        if (_args[2] == "DKP") then        
            for i=3, getn(_args),1 do
                if (i == getn(_args)) then
                    _dkptable = _dkptable.._args[i];
                else
                    _dkptable = _dkptable.._args[i].." ";
                end;
            end;
            if (_dkptable == "" and table.foreach(multiTable[1], VarReturn) == "dkp") then
                _dkptable = "dkp";
            end;
            if (gdkp_alliases ~= nil) then
                for key,val in pairs(gdkp_alliases) do
                    for i=1,table.getn(gdkp_alliases[key]),1 do
                        if (gdkp_alliases[key][i] ==  _looter) then
                            _looter = key;
                        end;
                    end;
                end;
            end;
            if _dkptable ~= nil and _dkptable ~= "" then
                GDKP_Output("<LiveDKP> "..dkpvalue.." ".._dkptable.." "..TEXT_DKP_SUBDKP_Player.." ".._looter.." "..TEXT_DKP_GETS.." ".._item,Chan)
                GDKP_MATH_DKP(_looter.." "..dkpvalue.." ".._dkptable,"sub","true","false",_item)
            end;
        end;
    end;

end

function GETDKP_ProcessSaveCost(option,_type,_looter,_item,dkpstring)
    if not _type or not _looter or not _item or _dkpstring == "" then return end

    if ( strlen(dkpstring) == 0 ) then
        dkpstring = nil;
        return;
    end
   
    if option == "GDKP_HOOK" then
		if not IsPromoted() then
			GDKP_show(TEXT_DKP_LiveError);
			return;
		end
		if (IsPromoted()) then
			Chan = "RAID"
		else
			Chan = "lokal"    
		end    
        if GDKPvar_save.LiveDKP ~= true then
            print("GETDKP Live DKP is"..GDKPvar_save.LiveDKP);
            return
        end;
                
        local _args = GDKP_GetArgs(dkpstring, " ");
        local dkpvalue = tonumber(_args[1])
        if dkpvalue == nil then
            return;
        end;    
        
        _dkptable = GDKPvar_save.konto      
        if (_dkptable == "" and table.foreach(multiTable[1], VarReturn) == "dkp") then
            _dkptable = "dkp";
        end;
        if (gdkp_alliases ~= nil) then
            for key,val in pairs(gdkp_alliases) do
                for i=1,table.getn(gdkp_alliases[key]),1 do
                    if (gdkp_alliases[key][i] ==  _looter) then
                        _looter = key;
                    end;
                end;
            end;
        end;
        if _dkptable ~= nil and _dkptable ~= "" and _looter ~= "bank" and _looter ~= "disenchanted" then
            GDKP_Output("<LiveDKP> "..dkpvalue.." ".._dkptable.." "..TEXT_DKP_SUBDKP_Player.." ".._looter.." "..TEXT_DKP_GETS.." ".._item,Chan)
            GDKP_MATH_DKP(_looter.." "..dkpvalue.." ".._dkptable,"sub","true","false",_item)
        end;
    end;

end;

--[CTRTButtonHandle]
function GDKP_CTRTButtonHandle()
    if CT_RaidTracker_Version ~= nil then
        local CTRTbutton = CreateFrame("Button","GDKP_CTRTButton",CT_RaidTrackerEditCostFrame,"GameMenuButtonTemplate");
        CTRTbutton:SetPoint("TOP",CT_RaidTrackerEditCostFrame,"TOP",-127,-12);
        CTRTbutton:SetHeight(27);
        CTRTbutton:SetWidth(125);
        CTRTbutton:SetToplevel(true);
        CTRTbutton:SetText(GDKP_Text_HookCTRT);
        CTRTbutton:Show();
        CTRTbutton:SetScript("OnClick", function() CT_RaidTracker_SaveCost("GDKP_HOOK"); CT_RaidTrackerEditCostFrame:Hide(); end );
        GDKP_show("GetDKP added CT Raid Tracker Item Costs Button!");
    end
end

--hook CT Raidtracker Notes Function
function GETDKP_CTRT_SaveNoteCT()
    local _type,_looter,_item,dkpstring = GETDKP_CTRT_GetValues(
            CT_RaidTrackerEditNoteFrame, CT_RaidTrackerEditNoteFrameNoteEB, "itemnote")
    Original_CT_RaidTracker_SaveNote();
    GETDKP_ProcessSaveNote(_type,_looter,_item,dkpstring)
end

--hook CT Raidtracker Costs Function
function GETDKP_CTRT_SaveCostCT(option)
    local _type,_looter,_item,_dkpstring = GETDKP_CTRT_GetValues(
            CT_RaidTrackerEditCostFrame, CT_RaidTrackerEditCostFrameNoteEB)
    Original_CT_RaidTracker_SaveCost(option);
    GETDKP_ProcessSaveCost(option,_type,_looter,_item,_dkpstring)
end

function MRT_LootNotify(itemInfoTable, source, raidNum, itemNum, oldItemInfoTable)
	if (source == MRT_NOTIFYSOURCE_ADD_GUI or source == MRT_NOTIFYSOURCE_ADD_POPUP or source == MRT_NOTIFYSOURCE_ADD_SILENT) then 
		-- param itemInfoTable: A stripped down variant of the loot information from the MRT_RaidLog table
		-- Will include the keys 'ItemLink', 'ItemString', 'ItemId', 'ItemName', 'ItemColor', 'ItemCount', 'Looter', 'DKPValue'
		GETDKP_ProcessSaveCost("GDKP_HOOK", source, itemInfoTable["Looter"], itemInfoTable["ItemLink"], itemInfoTable["DKPValue"]);
	end
end

function GDKP_setcurrent(key, _dkptable)
	gdkp.players[key][_dkptable.."_current"] = (gdkp.players[key][_dkptable.."_earned"] / (gdkp.players[key][_dkptable.."_spend"] + gdkp.players[key][_dkptable.."_basepoints"])) * (gdkp.players[key][_dkptable.."_scaling"]);
end

function GDKP_MATH_DKP(msg,_type,_update,_live,_item,_time)
local key,val,amount, _args, typestring
typestring = " ";
GDKP_LiveChanged_status = true
GDKP_LiveChanged_date = DKPInfo.date
if(not _time) then
	GDKP_LiveChanged_timestamp = time();
	DKPInfo["timestamp"] = GDKP_LiveChanged_timestamp
else
	DKPInfo["timestamp"] = _time;
end;
	if msg == nil or msg == "" then return end;
	_args = GDKP_GetArgs(msg, " ");
	
	
	if (_args[2] == nil) or (_args[2] == "") then return end;
	amount = tonumber(_args[2]) ;
	if amount == nil then return end;
	if (gdkp_alliases ~= nil) then
		for key,val in pairs(gdkp_alliases) do
			for i=1,table.getn(gdkp_alliases[key]),1 do
				if (gdkp_alliases[key][i] ==  _args[1]) then 
					_args[1] = key;
				end;
			end;
		end;
	end;
	
	
	if (IsPromoted()) then
		Chan = "RAID"
	else 
		Chan = "lokal"	
	end	
	GDKP_Account_found = nil;
	_dkptable = "";
	for i=3, getn(_args),1 do
		if (i == getn(_args)) then
			_dkptable = _dkptable.._args[i];
		else
			_dkptable = _dkptable.._args[i].." ";
		end;
	end;
	if (_dkptable == "" and table.foreach(multiTable[1], VarReturn) == "dkp") then
		_dkptable = "dkp";
	end;
	for i=1, getn(multiTable),1 do 
		if (string.lower(_dkptable) == string.lower(table.foreach(multiTable[i], VarReturn))) then
			GDKP_Account_found = 1;
		end;
	end;
	
	if GDKP_Account_found ~= nil then	
	
		if string.lower(_args[1]) == "raid" then
		
			for key, val in pairs(gdkp.players) do
				if GetDKP_CheckifPlayerIsInRaid(key)  then
					if _type == "add" then
						gdkp.players[key][_dkptable.."_current"] = gdkp.players[key][_dkptable.."_current"] + amount ;
						
						
					elseif _type == "sub" then
						gdkp.players[key][_dkptable.."_current"] = gdkp.players[key][_dkptable.."_current"] - amount ;
						gdkp.players[key][_dkptable.."_spend"] = gdkp.players[key][_dkptable.."_spend"] + amount ;
					end;
					
				else
					
					if (gdkp_alliases) then
						if (gdkp_alliases[key]) then
							for i= 1,getn(gdkp_alliases[key]),1 do
								if GetDKP_CheckifPlayerIsInRaid(gdkp_alliases[key][1]) then
									if _type == "add" then
										gdkp.players[key][_dkptable.."_current"] = gdkp.players[key][_dkptable.."_current"] + amount ;
										gdkp.players[key][_dkptable.."_earned"] = gdkp.players[key][_dkptable.."_earned"] + amount ;
									elseif _type == "sub" then
										gdkp.players[key][_dkptable.."_current"] = gdkp.players[key][_dkptable.."_current"] - amount ;
										gdkp.players[key][_dkptable.."_spend"] = gdkp.players[key][_dkptable.."_spend"] + amount ;
									end;	
								end;
							end;
						end;
					end;
				end;
				if GDKPvar_save.epgp == true then
					GDKP_setcurrent(key, _dkptable);
				end
			end;
			if _type == "add" then
				if (_update == "true") then
					SendAddonMessage("GETDKP",amount..",".._dkptable..",raid,add,"..GDKP_LiveChanged_timestamp,"RAID");
					--SendAddonMessage("GETDKP",amount..",".._dkptable..",raid,add,"..GDKP_LiveChanged_timestamp,"RAID",_item); wrong syntax
				end;
			elseif _type == "sub" then
				if (_update == "true") then
					SendAddonMessage("GETDKP",amount..",".._dkptable..",raid,sub,"..GDKP_LiveChanged_timestamp,"RAID");
					--SendAddonMessage("GETDKP",amount..",".._dkptable..",raid,sub,"..GDKP_LiveChanged_timestamp,"RAID",_item); wrong syntax
				end;
			end;
			if (_live == "true") then -- set by CT Raidtracker Hook
				if _type == "add" then
					GDKP_Output("<LiveDKP> "..amount.." ".._dkptable..typestring..TEXT_DKP_ADDDKP_RAID,Chan)
				elseif _type == "sub" then
					GDKP_Output("<LiveDKP> "..amount.." ".._dkptable.." DKP "..TEXT_DKP_SUBDKP_RAID,Chan)
				end;
			end;		
		else -- Player
			for key, val in pairs(gdkp.players) do
				if (string.lower(key) == string.lower(_args[1]))  then
					if _type == "add" then
						gdkp.players[key][_dkptable.."_current"] = gdkp.players[key][_dkptable.."_current"] + amount ;
						gdkp.players[key][_dkptable.."_earned"] = gdkp.players[key][_dkptable.."_earned"] + amount ;
						
						if (_live == "true") then 
							GDKP_Output("<LiveDKP> "..amount.." ".._dkptable..typestring..TEXT_DKP_ADDDKP_Player.." "..key,Chan)
						end;	
						if (_update == "true") then
						--if (_update == "true" and _item ~= "") then
							SendAddonMessage("GETDKP",amount..",".._dkptable..","..key..",add"..",".._item..","..GDKP_LiveChanged_timestamp,"RAID");
						end;
					elseif _type == "sub" then
						gdkp.players[key][_dkptable.."_current"] = gdkp.players[key][_dkptable.."_current"] - amount ;
						gdkp.players[key][_dkptable.."_spend"] = gdkp.players[key][_dkptable.."_spend"] + amount ;
						if (_item ~= nil and _item ~= "") then
							if (DKP_ITEMS[key] == nil) then
								DKP_ITEMS[key] = {};
								DKP_ITEMS[key]["Items"] = {};
								tinsert(DKP_ITEMS[key]["Items"], {name = _item, dkp = amount;});
							else
								tinsert(DKP_ITEMS[key]["Items"], {name = _item, dkp = amount;})
							end;
						end;
						if (_live ==  "true") then 
							GDKP_Output("<LiveDKP> "..amount.." ".._dkptable..typestring..TEXT_DKP_SUBDKP_Player.." "..key,Chan)
						end;
						if (_update == "true") then
						--if (_update == "true" and _item ~= "") then -- promote to raid even if no item is given
							SendAddonMessage("GETDKP",amount..",".._dkptable..","..key..",sub"..",".._item..","..GDKP_LiveChanged_timestamp,"RAID");
						end;
					end;	
					if GDKPvar_save.epgp == true then
						GDKP_setcurrent(key, _dkptable);
					end;
					
				end;
			end;
		end;
	end;
	GDKP_Live_saveDKP = GetDKP_TableCopy(gdkp) ;
	GDKP_Live_saveItem = GetDKP_TableCopy(DKP_ITEMS) ;
	GDL_Playerlist_EditBox_OnEnterPressed()
end;


--MANUAL ADD/SUB
function GDKP_MATH_DKP_MAN(msg,_type,_update,_live,_item,_time)
local key,val,amount, _args, typestring
typestring = " ";
GDKP_LiveChanged_status = true
GDKP_LiveChanged_date = DKPInfo.date
if(not _time) then
	GDKP_LiveChanged_timestamp = time();
	DKPInfo["timestamp"] = GDKP_LiveChanged_timestamp
else
	DKPInfo["timestamp"] = _time;
end;
	if msg == nil or msg == "" then return end;
	_args = GDKP_GetArgs(msg, " ");
	
	
	if (_args[2] == nil) or (_args[2] == "") then return end;
	amount = tonumber(_args[2]) ;
	if amount == nil then return end;
	if (gdkp_alliases ~= nil) then
		for key,val in pairs(gdkp_alliases) do
			for i=1,table.getn(gdkp_alliases[key]),1 do
				if (gdkp_alliases[key][i] ==  _args[1]) then 
					_args[1] = key;
				end;
			end;
		end;
	end;
	
	
	if (IsPromoted()) then
		Chan = "RAID"
	else 
		Chan = "lokal"	
	end	
	GDKP_Account_found = nil;
	_dkptable = "";
	for i=3, getn(_args),1 do
		if (i == getn(_args)) then
			_dkptable = _dkptable.._args[i];
		else
			_dkptable = _dkptable.._args[i].." ";
		end;
	end;
	if (_dkptable == "" and table.foreach(multiTable[1], VarReturn) == "dkp") then
		_dkptable = "dkp";
	end;
	for i=1, getn(multiTable),1 do 
		if (string.lower(_dkptable) == string.lower(table.foreach(multiTable[i], VarReturn))) then
			GDKP_Account_found = 1;
		end;
	end;
	
	if GDKP_Account_found ~= nil then	
	
		if string.lower(_args[1]) == "raid" then
		
			for key, val in pairs(gdkp.players) do
				if key==nil then
					key=" ";
				else
					splitplayer, splitrealm = strsplit( "-", key, 2 );
				end;
				if GetDKP_CheckifPlayerIsInRaid(key) or GetDKP_CheckifPlayerIsInRaid(splitplayer) then
					if _type == "add" then
						gdkp.players[key][_dkptable.."_current"] = gdkp.players[key][_dkptable.."_current"] + amount ;
						
						
					elseif _type == "sub" then
						gdkp.players[key][_dkptable.."_current"] = gdkp.players[key][_dkptable.."_current"] - amount ;
						gdkp.players[key][_dkptable.."_spend"] = gdkp.players[key][_dkptable.."_spend"] + amount ;
					end;
					
				else
					
					if (gdkp_alliases) then
						if (gdkp_alliases[key]) then
							for i= 1,getn(gdkp_alliases[key]),1 do
								if GetDKP_CheckifPlayerIsInRaid(gdkp_alliases[key][1]) then
									if _type == "add" then
										gdkp.players[key][_dkptable.."_current"] = gdkp.players[key][_dkptable.."_current"] + amount ;
										gdkp.players[key][_dkptable.."_earned"] = gdkp.players[key][_dkptable.."_earned"] + amount ;
									elseif _type == "sub" then
										gdkp.players[key][_dkptable.."_current"] = gdkp.players[key][_dkptable.."_current"] - amount ;
										gdkp.players[key][_dkptable.."_spend"] = gdkp.players[key][_dkptable.."_spend"] + amount ;
									end;	
								end;
							end;
						end;
					end;
				end;
				if GDKPvar_save.epgp == true then
					GDKP_setcurrent(key, _dkptable);
				end
			end;
			if _type == "add" then
				if (_update == "true") then
					--SendAddonMessage("GETDKP",amount..",".._dkptable..",raid,add,"..GDKP_LiveChanged_timestamp,"RAID");
					--SendAddonMessage("GETDKP",amount..",".._dkptable..",raid,add,"..GDKP_LiveChanged_timestamp,"RAID",_item); wrong syntax
				end;
			elseif _type == "sub" then
				if (_update == "true") then
					--SendAddonMessage("GETDKP",amount..",".._dkptable..",raid,sub,"..GDKP_LiveChanged_timestamp,"RAID");
					--SendAddonMessage("GETDKP",amount..",".._dkptable..",raid,sub,"..GDKP_LiveChanged_timestamp,"RAID",_item); wrong syntax
				end;
			end;
			if (_live == "true") then -- set by CT Raidtracker Hook
				if _type == "add" then
					GDKP_Output("<LiveDKP> "..amount.." ".._dkptable..typestring..TEXT_DKP_ADDDKP_RAID,Chan)
				elseif _type == "sub" then
					GDKP_Output("<LiveDKP> "..amount.." ".._dkptable.." DKP "..TEXT_DKP_SUBDKP_RAID,Chan)
				end;
			end;		
		else -- Player
			for key, val in pairs(gdkp.players) do
				if (string.lower(key) == string.lower(_args[1]))  then
					if _type == "add" then
						gdkp.players[key][_dkptable.."_current"] = gdkp.players[key][_dkptable.."_current"] + amount ;
						gdkp.players[key][_dkptable.."_earned"] = gdkp.players[key][_dkptable.."_earned"] + amount ;
						
						if (_live == "true") then 
							GDKP_Output("<LiveDKP> "..amount.." ".._dkptable..typestring..TEXT_DKP_ADDDKP_Player.." "..key,Chan)
						end;	
						if (_update == "true") then
						--if (_update == "true" and _item ~= "") then
							--SendAddonMessage("GETDKP",amount..",".._dkptable..","..key..",add"..",".._item..","..GDKP_LiveChanged_timestamp,"RAID");
						end;
					elseif _type == "sub" then
						gdkp.players[key][_dkptable.."_current"] = gdkp.players[key][_dkptable.."_current"] - amount ;
						gdkp.players[key][_dkptable.."_spend"] = gdkp.players[key][_dkptable.."_spend"] + amount ;
						if (_item ~= nil and _item ~= "") then
							if (DKP_ITEMS[key] == nil) then
								DKP_ITEMS[key] = {};
								DKP_ITEMS[key]["Items"] = {};
								tinsert(DKP_ITEMS[key]["Items"], {name = _item, dkp = amount;});
							else
								tinsert(DKP_ITEMS[key]["Items"], {name = _item, dkp = amount;})
							end;
						end;
						if (_live ==  "true") then 
							GDKP_Output("<LiveDKP> "..amount.." ".._dkptable..typestring..TEXT_DKP_SUBDKP_Player.." "..key,Chan)
						end;
						if (_update == "true") then
						--if (_update == "true" and _item ~= "") then -- promote to raid even if no item is given
							--SendAddonMessage("GETDKP",amount..",".._dkptable..","..key..",sub"..",".._item..","..GDKP_LiveChanged_timestamp,"RAID");
						end;
					end;	
					if GDKPvar_save.epgp == true then
						GDKP_setcurrent(key, _dkptable);
					end;
					
				end;
			end;
		end;
	end;
	GDKP_Live_saveDKP = GetDKP_TableCopy(gdkp) ;
	GDKP_Live_saveItem = GetDKP_TableCopy(DKP_ITEMS) ;
	GDL_Playerlist_EditBox_OnEnterPressed()
end;
