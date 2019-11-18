--------------------------------------------------------------------
---- GetDKP Plus												----
---- Copyright (c) 2006-2019 EQdkp-Plus Developer Team			----
---- You should have received a copy of the GNU Affero			----
---- General Public License along with this program. If not,	----
---- see http://www.gnu.org/licenses/.							----
--------------------------------------------------------------------

osrHeader = "";
GDKP_Search_Warlock_eng 	= "Warlock" ;
GDKP_Search_Druid_eng 		= "Druid" ;
GDKP_Search_Mage_eng 		= "Mage" ;
GDKP_Search_Hunter_eng 		= "Hunter" ;
GDKP_Search_Rogue_eng 		= "Rogue" ;
GDKP_Search_Priest_eng 		= "Priest" ;
GDKP_Search_Warrior_eng 	= "Warrior" ;
GDKP_Search_Shaman_eng 		= "Shaman" ;
GDKP_Search_Paladin_eng 	= "Paladin" ;
GDKP_Search_DeathKnight_eng 	= "DeathKnight" ;
GDKP_Search_stoff_eng 		= "Cloth" ;
GDKP_Search_leder_eng 		= "Leather" ;
GDKP_Search_schwer_eng 		= "Mail" ;
GDKP_Search_platte_eng 		= "Plate" ;
GDKP_Search_alle_eng 		= "all" ;

GDKP_Search_Warlock_de 	= "Hexenmeister" ;
GDKP_Search_Druid_de 	= "Druide" ;
GDKP_Search_Mage_de 	= "Magier" ;
GDKP_Search_Hunter_de	= "J\195\164ger" ;
GDKP_Search_Rogue_de 	= "Schurke" ;
GDKP_Search_Priest_de 	= "Priester" ;
GDKP_Search_Warrior_de 	= "Krieger" ;
GDKP_Search_Shaman_de 	= "Schamane" ;
GDKP_Search_Paladin_de	= "Paladin" ;
GDKP_Search_DeathKnight_de	= "Todesritter" ;
GDKP_Search_stoff_de 	= "Stoff" ;
GDKP_Search_leder_de 	= "Leder" ;
GDKP_Search_schwer_de 	= "Schwer" ;
GDKP_Search_platte_de 	= "Platte" ;
GDKP_Search_alle_de 	= "alle" ;

GDKP_Search_Warlock_es 	= "Brujo" ;
GDKP_Search_Druid_es 		= "Druida" ;
GDKP_Search_Mage_es 		= "Mago" ;
GDKP_Search_Hunter_es 		= "Cazador" ;
GDKP_Search_Rogue_es 		= "P�caro" ;
GDKP_Search_Priest_es 		= "Sacerdote" ;
GDKP_Search_Warrior_es 	= "Guerrero" ;
GDKP_Search_Shaman_es 		= "Cham�n" ;
GDKP_Search_Paladin_es 	= "Palad�n" ;
GDKP_Search_DeathKnight_es 	= "Caballero de la Muerte" ;
GDKP_Search_stoff_es 		= "Tela" ;
GDKP_Search_leder_es 		= "Cuero" ;
GDKP_Search_schwer_es 		= "Mallas" ;
GDKP_Search_platte_es 		= "Placas" ;
GDKP_Search_alle_es 		= "todo" ;

GDKP_Classes_Icons = {
	Druid = "Interface\\Icons\\Ability_Druid_Maul",
	Mage = "Interface\\Icons\\INV_Staff_13",
	Warrior = "Interface\\Icons\\INV_Sword_27",
	Hunter = "Interface\\Icons\\INV_Weapon_Bow_07",
	Priest = "Interface\\Icons\\INV_Staff_30",
	Rogue = "Interface\\Icons\\INV_ThrowingKnife_04",
	Shaman = "Interface\\Icons\\Spell_Nature_BloodLust",
	Warlock = "Interface\\Icons\\Spell_Nature_Drowsy",
	Paladin = "Interface\\Icons\\INV_Hammer_01"
	}

if ( GetLocale() == "deDE" ) then
	GDKP_Classes_Icons = nil;
	GDKP_Classes_Icons = {
	Druide = "Interface\\Icons\\Ability_Druid_Maul",
	Magier = "Interface\\Icons\\INV_Staff_13",
	Krieger = "Interface\\Icons\\INV_Sword_27",
	["J\195\164ger"] = "Interface\\Icons\\INV_Weapon_Bow_07",
	Priester = "Interface\\Icons\\INV_Staff_30",
	Schurke = "Interface\\Icons\\INV_ThrowingKnife_04",
	Schamane = "Interface\\Icons\\Spell_Nature_BloodLust",
	Hexenmeister = "Interface\\Icons\\Spell_Nature_Drowsy",
	Paladin = "Interface\\Icons\\INV_Hammer_01"
	}
end;

if ( GetLocale() == "esES" ) then
	GDKP_Classes_Icons = nil;
	GDKP_Classes_Icons = {
	Druide = "Interface\\Icons\\Ability_Druid_Maul",
	Magier = "Interface\\Icons\\INV_Staff_13",
	Krieger = "Interface\\Icons\\INV_Sword_27",
	["J\195\164ger"] = "Interface\\Icons\\INV_Weapon_Bow_07",
	Priester = "Interface\\Icons\\INV_Staff_30",
	Schurke = "Interface\\Icons\\INV_ThrowingKnife_04",
	Schamane = "Interface\\Icons\\Spell_Nature_BloodLust",
	Hexenmeister = "Interface\\Icons\\Spell_Nature_Drowsy",
	Paladin = "Interface\\Icons\\INV_Hammer_01"
	}
end;

if ( GetLocale() == "esMX" ) then
	GDKP_Classes_Icons = nil;
	GDKP_Classes_Icons = {
	Druide = "Interface\\Icons\\Ability_Druid_Maul",
	Magier = "Interface\\Icons\\INV_Staff_13",
	Krieger = "Interface\\Icons\\INV_Sword_27",
	["J\195\164ger"] = "Interface\\Icons\\INV_Weapon_Bow_07",
	Priester = "Interface\\Icons\\INV_Staff_30",
	Schurke = "Interface\\Icons\\INV_ThrowingKnife_04",
	Schamane = "Interface\\Icons\\Spell_Nature_BloodLust",
	Hexenmeister = "Interface\\Icons\\Spell_Nature_Drowsy",
	Paladin = "Interface\\Icons\\INV_Hammer_01"
	}
end;
TEXT_DKP_HELP_DKP		= "You have used the wrong Syntax. for example dkp BWL or dkp BWL Priest or only dkp for all";
TEXT_DKP_HELP_WORNGSET	= "You can only use dkp as set.";
TEXT_DKP_SETACCOUNT		= "SetAccount";
TEXT_DKP_HELP_REQ_ITEM	= "/gdc whisperitems on/off - Disable/Enable whisper request for Items "
TEXT_DKP_HELP_REQ_DKP	= "/gdc whisperdkp on/off - Disable/Enable whisper request for DKP Points";
TEXT_DKP_HELP_HIDE_WHISPER = "/gdc whisperhide on/off - Hide outgoing whisper when someone request DKP "
TEXT_DKP_HELP_Raidonly	= "/gdc raidonly on/off - Show only Players in Raid";
TEXT_DKP_HELP_BUYERLIMIT= "/gdc buyerslimit xx - Show only xx Buyers of an item. xx can by a number between 1 an 40."
TEXT_DKP_HELP_NEEDLIMIT = "/gdc needlimit xx - Show only xx Player with NEED of an item. xx can by a number between 1 an 40."
TEXT_DKP_HELP_ITEM 		= "/item [Itemname] (link Item)  - Itemhistory with reference on a specific item";
TEXT_DKP_HELP_ITEMS 	= "/items Playname   - Players personal itemhistory. ";
TEXT_DKP_HELP_Tooltip	= "/gdc tooltip on/off    - activate or deactivate the Tooltip "
TEXT_DKP_HELP_TooltipP	= "/gdc tooltip [top,left,top,bottom]    - Tooltip position "
TEXT_DKP_HELP_TooltipMM	= "/gdc tooltip minmax [on/off]   - Show Min/Max/AVG DKP in the Tooltip."
TEXT_DKP_HELP_TTDKP		= "/gdc tooltip dkp [on/off]     - Shows your own DKP Point in the Tooltip";
TEXT_DKP_HELP_TTLO		= "/gdc tooltip listbuyers [on/off]     - Shows witch Player owns an Setitem in the Tooltip";
TEXT_DKP_HELP_TTLO_REP	= "/gdc tooltip reportbuyers [on/off]     - Report wich Player owns an Setitem.";
TEXT_DKP_HELP_Info		= "/gdc info channel [raid, group, gilde, chat] - Shows DKP Stats in the Channel"
TEXT_DKP_HELP_Status	= "/gdc status - Shows the GETDKP Configuration"
TEXT_DKP_HELP_DKPO		= "/dkpo [guild,say,group,raid,local,officer] set the Outputchat"
TEXT_DKP_HELP_DKPPlus		= "/dkp+ [Playername/raid] [DKP] [Account] expample /dkp+ Charla 100 BWL - Add 100 DKP to Corgans DKP Point. to add dkp to all player you have to use raid as playername "
TEXT_DKP_HELP_DKPMinus		= "/dkp- [Playername] [DKP] [Account] expample /dkp- Charla 100 BWL - Subtract 100 DKP from Corgans DKP Point to substract dkp to all player you have to use raid as playername"
TEXT_DKP_HELP_DKP_Live		= "/gdc livedkp on/off - Activate the LiveGKP Function"
TEXT_DKP_HELP_Whisper		= "Whisper DKP /send name dkp [Account] example /send Charla dkp Gruuls Lair or /send charla dkp for all Accounts"
TEXT_DKP_NONSETITEM_FOUND	= "NonsetItem found";
TEXT_DKPINFO        = "Your Points: ";
TEXT_DKP_SET		= "Setpoints" ;
TEXT_DKP_DKP		= "DKP" ;
TEXT_DKP_NONSET		= "NonSetpoints" ;
TEXT_DKP_MIXED      = "Mixedpoints" ;
TEXT_NOPOINTS       = "You have no points.";
TEXT_DKP_SETT		= "Set: ";
TEXT_DKP_NONSETT	= ", NonSet: ";
TEXT_DKP_MIXEDT     = ", Mixed: ";
TEXT_DKP_LISTE		= "List ";
TEXT_DKP_LISTE_ALLE	= " all Member";
TEXT_DKP_SEARCH		= " Search ";
TEXT_DKP_PLAYER		= " Player ";
TEXT_DKP_NOTFOUND	= " not found " ;
TEXT_DKP_NOHISTORY  = "Could not find a player history for " ;
TEXT_DKP_ITEMHISTORY= "Displaying Item History for " ;
TEXT_DKP_RPSPENT	= " RaidPoints Spent Total! " ;
TEXT_DKP_RP			= " DKP] ";
TEXT_DKP_ON			= " ON " ;
TEXT_DKP_OFF		= " OFF " ;
TEXT_DKP_REQ_ITEMS	= " Whisper Request for Items " ;
TEXT_DKP_REQ_DKP	= " Whisper Request for DKP Points " ;
TEXT_DKP_REQ_SHOW	= "Hide Whisper" ;
TEXT_DKP_Buyers		= " Buyers found for " ;
TEXT_DKP_Buyer		= " Buyers found " ;
TEXT_DKP_boughtfor	= " bought for " ;
TEXT_DKP_HASNT_ITEM = " Players do not own this item  ";
TEXT_DKP_HAS		= " currently has " ;
TEXT_DKP_DATE				= "last changed: ";
TEXT_DKP_DKPLIST			= "DKP List Version; ";
TEXT_DKP_PLAYERS_TOTAL		= "Player count: ";
TEXT_DKP_ITEMS_TOTAL		= "Item count: ";
TEXT_DKP_POINTS_TOTAL		= "DKP Points : ";
TEXT_DKP_ITEMS_SET			= "Setitems count: ";
TEXT_DKP_ITEMS_NONSET		= "Nonsetitems count: ";
TEXT_DKP_POINTS_SET			= "DKP Setitems: ";
TEXT_DKP_POINTS_NONSET		= "DKP Nonsetitems: ";
TEXT_DKP_Guild				= "guild";
TEXT_DKP_Tooltip			= "Show Tooltip " ;
TEXT_DKP_Tooltip_Raid		= "Show Tooltip only in Raid ";
TEXT_DKP_Tooltip_BUTTON_PARTY = "Post Party" ;
TEXT_DKP_Anounce			= "Report: ";
TEXT_DKP_YOU				= "You: " ;
TEXT_DKP_Player_Raid 		= " - [In Raid]"
TEXT_DKP_OUTPUT_CHAN 		= " Output Chat"
TEXT_DKP_GILDE		 		= "guild"
TEXT_DKP_PARTY		 		= "party"
TEXT_DKP_LOCAL		 		= "local"
TEXT_DKP_SAY		 		= "say"
TEXT_DKP_RAID		 		= "raid"
TEXT_DKP_ShowOnlyInRaid		= "Show only Raidmember" ;
TEXT_DKP_TT_HEAD      = "Post Tooltip Information";
TEXT_DKP_TT_PARTY 			= "Post Tooltip Informationen in Partychat" ;
TEXT_DKP_TT_RAID 			= "Post Tooltip Informationen in Raidchat" ;
TEXT_DKP_TT_CHAT 			= "Post Tooltip Informationen in Chat" ;
TEXT_DKP_TT_GUILD 			= "Post Tooltip Informationen in Guildchat" ;
TEXT_DKP_TT_OFFICER			= "Post Tooltip Informationen in Officerchat" ;
TEXT_DKP_TT_NEED_RAID		= " in the Raid without DKP"
TEXT_DKP_TT_LIMIT_SHOW		= "Show only the first "
TEXT_DKP_TT_LIMIT_WARINIG	= "GETDKP: To many Rows for the Tooltip ! Please set a limit for the Player. For help /dkp help"
TEXT_DKP_FIGHT_WHISPER		= "GETDKP: Sorry in a fight now. Whisper function deactivated."
TEXT_DKP_ShowNonSet			= "Show NonSetPoints for your Class in the Titan Tooltip";
TEXT_DKP_ADDDKP_RAID		= "DKP added to all Players in the Raid";
TEXT_DKP_ADDDKP_Player		= "DKP added to";
TEXT_DKP_SUBDKP_RAID		= "DKP subtract from all Players in the Raid";
TEXT_DKP_SUBDKP_Player		= "DKP subtract from";
TEXT_DKP_GETS				= "for"
TEXT_DKP_LiveError			= " GETDKP Live DKP: You are not a raid officer. No Getdkp Values changed !";
GDKP_Text_ClientMode		= "GetDkp is in the Client mode";
GDKP_Text_multiTable		= "|cff66CCCCmultiTable, ";
GDKP_Text_DKPInfo			= "|cff66CCCCDKPInfo, ";
GDKP_Text_GDKP				= "|cff66CCCCGDKP, ";
GDKP_Text_DKPItems			= "|cff66CCCCDKPItems ";
GDKP_Text_Vars 				= "Var/s are not in yours getdkp.lua. please check this";
GDKP_Text_NoMembers			= "There are no Members in yours EQDKP. ";
GDKP_Text_NoItems			= "There are no Items inn yours EQDKP. ";
GDKP_Text_ToLow				= "You run GetDKP with an old version of getdkp.php ! Your EQDKP Admin have to update the getdkp.php to the newest Version that comes EQDKP 0.4.x";
GDKP_Text_Alias				= "The GetDKP Allias Function is runnig at the getdkp.php version 2.61 Your EQDKP Admin have to update the getdkp.php to the newest Version that comes EQDKP 0.5.x";
GDKP_Text_DataTransfer 		= "The GetDKP DataTransfer Function is running at the getdkp.php version 2.63. Your EQDKP Admin have to update the getdkp.php to the newest Version that comes EQDKP 0.5.x";
GDKP_Text_RP				= "The GetDKP RaidPlaner Function is running at the getdkp.php version 2.64. Your EQDKP Admin have to update the getdkp.php to the newest Version that comes EQDKP 0.5.x";
GDKP_Text_HookCTRT			= "Set & Substract"
--allgemein



if ( GetLocale() == "deDE" ) then
	TEXT_DKP_SETACCOUNT		= "SetKonto";

	TEXT_DKP_HELP_DKP			= "Du nutzt die falsche Syntax. ein bispiel dkp BWL oder dkp BWL Priester oder nur dkp f�r alle";
	TEXT_DKP_HELP_WORNGSET		= "Du must den befehl dkp nutzen.";
	TEXT_DKP_HELP_REQ_DKP		= "/gdc whisperdkp on/off - Schaltet die Whisperfunktion der Punkte aus "
	TEXT_DKP_HELP_REQ_ITEM		= "/gdc whisperitems on/off - Schaltet die Whisperfunktion der Items aus";
	TEXT_DKP_HELP_HIDE_WHISPER 	= "/gdc whisperhide on/off - Whisper Nachfragen f\195\188r DKP nicht mehr anzeigen "
	TEXT_DKP_HELP_Raidonly		= "/gdc raidonly an/aus - Nur Spieler an zeigen, die sich gerade im Raid befinden.";
	TEXT_DKP_HELP_BUYERLIMIT	= "/gdc buyerslimit xx - Zeige nur xx Spieler an die ein Item besitzen. xx kann eine Zahl zwischen 1 und 40 sein."
	TEXT_DKP_HELP_NEEDLIMIT 	= "/gdc needlimit xx - Zeige nur xx Spieler mit Bedarf auf ein Item an. xx kann eine Zahl zwischen 1 und 40 sein."
	TEXT_DKP_HELP_ITEM 			= "/item [Itemname] (verlinken)  - Gibt die Itemhistory f\195\188r das Item aus";
	TEXT_DKP_HELP_ITEMS 		= "/items Spielername   - Gibt alle Items des Spielers aus.";
	TEXT_DKP_HELP_Tooltip		= "/gdc tooltip an/aus    - Schaltet den Tooltip an/aus"
	TEXT_DKP_HELP_TooltipP		= "/gdc tooltip [oben,links,rechts,unten]    - Wo soll der Tooltip angezeigt werden."
	TEXT_DKP_HELP_TooltipMM		= "/gdc tooltip minmax [an/aus]   - Soll Min/Max/AVG DKP im Tooltip angezeigt werden."
	TEXT_DKP_HELP_TTDKP			= "/gdc tooltip dkp [an/aus]     - Zeigt die eigenen DKP Punkte mit im Tooltip an";
	TEXT_DKP_HELP_TTLO			= "/gdc tooltip listbuyers [an/aus]     - Zeigt die K\195\164ufer eines Items im Tooltip an";
	TEXT_DKP_HELP_TTLO_REP		= "/gdc tooltip reportbuyers [an/aus]     - Postet die K\195\164ufer eines Items.";
	TEXT_DKP_HELP_Info			= "/gdc info channel [raid, gruppe, gilde, chat] - Zeigt DKP Statistik in dem channel an"
	TEXT_DKP_HELP_Status		= "/gdc status - Zeigt die aktuellen GETDKP Einstellungen"
	TEXT_DKP_HELP_DKPO			= "/dkpo [gilde,sagen,gruppe,raid,lokal,offizier] setzt einen Ausgabechat in dem die Punkte angezeigt werden sollen"
	TEXT_DKP_HELP_DKPPlus		= "/dkp+ [Spielername/raid] [DKP] [Konto] Beispiel: /dkp+ Charla 100 BWL- Addiere 100 Punkte zu Corgans DKP Punkten, um alle spielern dkp zu addieren must du als spielername raid nehmen."
	TEXT_DKP_HELP_DKPMinus		= "/dkp- [Spielername/raid] [DKP] [Konto] Beispiel: /dkp- Charla 100 BWL- Zieht 100 Punkte von Corgans DKP Punkten ab, um alle spielern dkp ab zu ziehen must du als spielername raid nehmen."
	TEXT_DKP_HELP_DKP_Live		= "/gdc livedkp an/aus - aktiviert die Live DKP Funktion"
	TEXT_DKP_HELP_Whisper		= "Whisper DKP /send name dkp [Konto] Beispiel: /send Charla dkp Gruuls Lair oder /send Charla dkp f\195\188r alle Konten";
	TEXT_DKP_NONSETITEM_FOUND	= "NonsetItem gefunden";
	TEXT_DKPINFO               = "Du hast: ";
	TEXT_DKP_SET		= "Setpunkte" ;
	TEXT_DKP_DKP		= "DKP" ;
	TEXT_DKP_NONSET		= "NonSetpunkte" ;
	TEXT_DKP_MIXED      = "Mixedpunkte" ;
	TEXT_NOPOINTS       = "Du hast keine Punkte.";
	TEXT_DKP_SETT		= "Set: ";
	TEXT_DKP_NONSETT	= ", NonSet: ";
	TEXT_DKP_MIXEDT     = ", Mixed: ";
	TEXT_DKP_LISTE		= "Liste ";
	TEXT_DKP_LISTE_ALLE	= " alle Member";
	TEXT_DKP_SEARCH		= " Suche ";
	TEXT_DKP_PLAYER		= " Spieler ";
	TEXT_DKP_NOTFOUND	= " nicht gefunden " ;
	TEXT_DKP_NOHISTORY  = "Keine Items gefunden von " ;
	TEXT_DKP_ITEMHISTORY= "Zeige alle Items von " ;
	TEXT_DKP_RPSPENT	= " ausgegebene Punkte insgesamt! " ;
	TEXT_DKP_RP			= " DKP] ";
	TEXT_DKP_ON			= " An " ;
	TEXT_DKP_OFF		= " Aus " ;
	TEXT_DKP_REQ_ITEMS	= "Whisper Request Items " ;
	TEXT_DKP_REQ_DKP	= "Whisper Request DKP Punkte " ;
	TEXT_DKP_REQ_SHOW	= "Verstecke Whispernachfragen" ;
	TEXT_DKP_Buyers		= " K\195\164ufer gefunden von " ;
	TEXT_DKP_Buyer		= " K\195\164ufer gefunden" ;
	TEXT_DKP_boughtfor	= " gekauft f\195\188r " ;
	TEXT_DKP_HASNT_ITEM = " Spieler haben need ";
	TEXT_DKP_HAS		= " hat gerade " ;
	TEXT_DKP_DATE				= "Letzte Aktualisierung: ";
	TEXT_DKP_DKPLIST			= "DKP List Version; ";
	TEXT_DKP_PLAYERS_TOTAL		= "Spieler gesamt: ";
	TEXT_DKP_ITEMS_TOTAL		= "Items gesamt: ";
	TEXT_DKP_POINTS_TOTAL		= "DKP Punkte gesamt: ";
	TEXT_DKP_ITEMS_SET			= "Setitems gesamt: ";
	TEXT_DKP_ITEMS_NONSET		= "Nonsetitems gesamt: ";
	TEXT_DKP_POINTS_SET			= "Punkte Setitems: ";
	TEXT_DKP_POINTS_NONSET		= "Punkte Nonsetitems: ";
	TEXT_DKP_Guild				= "Gilde";
	TEXT_DKP_Tooltip			= "Zeige Tooltip " ;
	TEXT_DKP_Tooltip_Raid		= "Zeige Tooltip nur im Raid ";
	TEXT_DKP_Anounce			= "Berichte: ";
	TEXT_DKP_YOU				= "Du: " ;
	TEXT_DKP_Player_Raid 		= " - [Im Raid]"
	TEXT_DKP_OUTPUT_CHAN 		= "Ausgabe Chat"
	TEXT_DKP_GILDE		 		= "gilde"
	TEXT_DKP_PARTY		 		= "gruppe"
	TEXT_DKP_LOCAL		 		= "lokal"
	TEXT_DKP_SAY		 		= "sagen"
	TEXT_DKP_RAID		 		= "raid"
	TEXT_DKP_ShowOnlyInRaid		= "Zeige nur Raidmitglieder" ;
	TEXT_DKP_TT_HEAD      = "Poste Tooltip Information";
	TEXT_DKP_TT_PARTY 			= "schreibe Tooltip Informationen im Gruppenchat" ;
	TEXT_DKP_TT_RAID 			= "schreibe Tooltip Informationen im Raidchat" ;
	TEXT_DKP_TT_CHAT 			= "schreibe Tooltip Informationen im Chat" ;
	TEXT_DKP_TT_GUILD 			= "schreibe Tooltip Informationen im Gildenchat" ;
	TEXT_DKP_TT_OFFICER			= "schreibe Tooltip Informationen im Offizierchat" ;
	TEXT_DKP_TT_NEED_RAID		= " im Raid ohne DKP"
	TEXT_DKP_TT_LIMIT_SHOW		= "Zeige nur die ersten "
	TEXT_DKP_TT_LIMIT_WARINIG	= "GETDKP: Zuviele Zeilen f\195\188r den Tooltip. Setzte bitte ein Limit f�r die anzuzeigenen Spieler. f\195\188r Hilfe /dkp help"
	TEXT_DKP_FIGHT_WHISPER		= "GETDKP: Ich befinde mich gerade im Kampf. Whisper Funktion deaktiv."
	TEXT_DKP_ShowNonSet			= "Liste NonSet Punkte f\195\188r deine Klasse im Titan Tooltip";
	TEXT_DKP_ADDDKP_RAID		= "DKP wurden allen Spielern aus dem Raid hinzugef\195\188gt";
	TEXT_DKP_ADDDKP_Player		= "DKP hinzugef\195\188gt zu";
	TEXT_DKP_SUBDKP_RAID		= "DKP wurden allen Spielern aus dem Raid abgezogen";
	TEXT_DKP_SUBDKP_Player		= "DKP abgezogen von";
	TEXT_DKP_GETS				= "f\195\188r" ;
	TEXT_DKP_LiveError			= " GETDKP Live DKP: Du bist kein Raid Offizier. Es wurden keine GETDKP Daten ge\195\164ndert.";
	GDKP_Text_ClientMode		= "GetDkp ist jetzt im Client modus";
	GDKP_Text_multiTable		= "|cffff0000multiTable|cffffe000 , ";
	GDKP_Text_DKPInfo			= "|cffff0000DKPInfo|cffffe000 , ";
	GDKP_Text_GDKP				= "|cffff0000GDKP|cffffe000 , ";
	GDKP_Text_DKPItems			= "|cffff0000DKPItems|cffffe000 ";
	GDKP_Text_Vars 				= "Var/s sind nich in deiner getdkp.lua. bitte kontrolliere es.";
	GDKP_Text_NoMembers			= "Du hast keine Members in deinem EQDKP. ";
	GDKP_Text_NoItems			= "Du hast keine Items in deinem EQDKP. ";
	GDKP_Text_ToLow				= "Dein EQDKP l\195\164uft mit einer alten version von getdkp.php. Dein EQKPAdmin mu\195\159 die getdkp.php updaten, sie ist im EQDKP 0.4.x enthalten";
	GDKP_Text_Alias				= "Die GetDKP Allias Funktion l\195\164uft erst ab der getdkp.php version 2.61, diese ist im EQDKP 0.5.x enthalten. Bitte frage deinen EQDKPAdmin.";
	GDKP_Text_DataTransfer		= "Die GetDKP Datentransfer Funktion l\195\164uft erst ab der getdkp.php version 2.63, diese ist im EQDKP 0.5.x enthalten. Bitte frage deinen EQDKPAdmin.";
	GDKP_Text_RP				= "Die GetDKP Raidplaner Funktion l\195\164uft erst ab der getdkp.php version 2.64, diese ist im EQDKP 0.5.x enthalten. Bitte frage deinen EQDKPAdmin.";
	GDKP_Text_HookCTRT			= "Set & Abziehen"
	end

-- Spanish Localization
if ( GetLocale() == "esES" ) then
TEXT_DKP_HELP_DKP		= "Has usado una Sintaxis err�na. Por ejemplo, dkp NAX o dkp NAX Sacerdote o s�lo DKP para todo";
TEXT_DKP_HELP_WORNGSET	= "S�lo puedes usar DKP como conjunto.";
TEXT_DKP_SETACCOUNT		= "Fijar cuenta";
TEXT_DKP_HELP_REQ_ITEM	= "/gdc whisperitems on/off - activa/desactiva la funci�n de susurro de los objetos"
TEXT_DKP_HELP_REQ_DKP	= "/gdc whisperdkp on/off - activa/desactiva la funci�n de susurro de los puntos DKP";
TEXT_DKP_HELP_HIDE_WHISPER = "/gdc whisperhide on/off - Oculta los susurros salientes cuando alguien solicita informaci�n de DKP o de Objetos"
TEXT_DKP_HELP_Raidonly	= "/gdc raidonly on/off - Mostrar s�lo los jugadores en Banda";
TEXT_DKP_HELP_BUYERLIMIT= "/gdc buyerslimit xx - Muestra s�lo XX compradores de un objeto. XX puede ser un n�mero entre 1 y 40. 0 = todos"
TEXT_DKP_HELP_NEEDLIMIT = "/gdc needlimit xx - Muestra s�lo XX jugadores con NECESIDAD de ese objeto. XX puede ser un n�mero entre 1 y 40. 0 = todos"
TEXT_DKP_HELP_ITEM 		= "/item [Itemname] (link Item)  - Historial del objeto con referencia a un objeto";
TEXT_DKP_HELP_ITEMS 	= "/items Playname   - Historial personal de jugadores. ";
TEXT_DKP_HELP_Tooltip	= "/gdc tooltip on/off    - activa/desactiva el Tooltip"
TEXT_DKP_HELP_TooltipP	= "/gdc tooltip [top,left,top,bottom]    - Posici�n del Tooltip"
TEXT_DKP_HELP_TooltipMM	= "/gdc tooltip minmax [on/off]   - Muestra M�n/M�x/Media de DKP en el Tooltip."
TEXT_DKP_HELP_TTDKP		= "/gdc tooltip dkp [on/off]     - Muestra tus propios puntos DKP en el Tooltip";
TEXT_DKP_HELP_TTLO		= "/gdc tooltip listbuyers [on/off]     - Muestra qu� jugador tiene un objeto en el Tooltip";
TEXT_DKP_HELP_TTLO_REP	= "/gdc tooltip reportbuyers [on/off]     - Reporta qu� jugadores tienen un objetoReport wich Player owns an Setitem.";
TEXT_DKP_HELP_Info		= "/gdc info channel [raid, group, gilde, chat] - Muestra las estad�sticas de los DKP en el canal"
TEXT_DKP_HELP_Status	= "/gdc status - Muestra la configuraci�n de GETDKP"
TEXT_DKP_HELP_DKPO		= "/dkpo [guild,say,group,raid,local,officer] establece el chat de salida"
TEXT_DKP_HELP_DKPPlus		= "/dkp+ [Playername/raid] [DKP] [Account] ejemplo /dkp+ Belelros 100 DKP1 - A�ade 100 puntos DKP a Belelros en la cuenta DKP1. Para a�ad�rselo a todos los jugadores hay que usar el nombre de la banda como nombre de jugador."
TEXT_DKP_HELP_DKPMinus		= "/dkp- [Playername] [DKP] [Account] ejemplo /dkp- Belelros 100 DKP1 - Resta 100 DKP de los puntos de Belelros en la cuenta DKP1. Para a�ad�rselo a todos los jugadores hay que usar el nombre de la banda como nombre de jugador."
TEXT_DKP_HELP_DKP_Live		= "/gdc livedkp on/off - Activa la funci�n de LiveGKP"
TEXT_DKP_HELP_Whisper		= "Susurrar DKP /send name dkp [Account] ejemplo /send Charla dkp Naxxramas o /send charla dkp para todas las cuentas"
TEXT_DKP_NONSETITEM_FOUND	= "Set de Objetos no encontrados";
TEXT_DKPINFO        = "Tus puntos: ";
TEXT_DKP_SET		= "Puntos asignados" ;
TEXT_DKP_DKP		= "DKP" ;
TEXT_DKP_NONSET		= "Puntos sin asignar" ;
TEXT_DKP_MIXED      = "Puntos mezclados" ;
TEXT_NOPOINTS       = "No tienes puntos.";
TEXT_DKP_SETT		= "Asignados: ";
TEXT_DKP_NONSETT	= ", Sin asignar: ";
TEXT_DKP_MIXEDT     = ", Mixtos: ";
TEXT_DKP_LISTE		= "Lista ";
TEXT_DKP_LISTE_ALLE	= " todos";
TEXT_DKP_SEARCH		= " Buscar ";
TEXT_DKP_PLAYER		= " Jugador ";
TEXT_DKP_NOTFOUND	= " no encontrado " ;
TEXT_DKP_NOHISTORY  = "No se puede encontrar historial para " ;
TEXT_DKP_ITEMHISTORY= "Mostrando historial de objeto para " ;
TEXT_DKP_RPSPENT	= " Puntos de banda gastados! " ;
TEXT_DKP_RP			= " DKP] ";
TEXT_DKP_ON			= " ON " ;
TEXT_DKP_OFF		= " OFF " ;
TEXT_DKP_REQ_ITEMS	= " Susurro de petici�n de objetos " ;
TEXT_DKP_REQ_DKP	= " Susurro de petici�n de DKP " ;
TEXT_DKP_REQ_SHOW	= "Ocultar susurro" ;
TEXT_DKP_Buyers		= " Compradores encontrados para " ;
TEXT_DKP_Buyer		= " Compradores encontrados " ;
TEXT_DKP_boughtfor	= " comprado por " ;
TEXT_DKP_HASNT_ITEM = " Jugadores no tienen este objeto  ";
TEXT_DKP_HAS		= " actualmente tiene " ;
TEXT_DKP_DATE				= "�ltimo cambiado: ";
TEXT_DKP_DKPLIST			= "Versi�n de DKP; ";
TEXT_DKP_PLAYERS_TOTAL		= "Contador de jugadores: ";
TEXT_DKP_ITEMS_TOTAL		= "Contador de objetos: ";
TEXT_DKP_POINTS_TOTAL		= "Puntos DKP : ";
TEXT_DKP_ITEMS_SET			= "Contador de objetos asignados: ";
TEXT_DKP_ITEMS_NONSET		= "Contador de objetos no-asignados: ";
TEXT_DKP_POINTS_SET			= "DKP Objetos asignados: ";
TEXT_DKP_POINTS_NONSET		= "DKP Objetos no-asignados: ";
TEXT_DKP_Guild				= "hermandad";
TEXT_DKP_Tooltip			= "Mostrar Tooltip " ;
TEXT_DKP_Tooltip_Raid		= "Mostrar Tooltip s�lo en banda ";
TEXT_DKP_Tooltip_BUTTON_PARTY = "Publicar grupo" ;
TEXT_DKP_Anounce			= "Reportar: ";
TEXT_DKP_YOU				= "T�: " ;
TEXT_DKP_Player_Raid 		= " - [En Banda]"
TEXT_DKP_OUTPUT_CHAN 		= " Chat de salida"
TEXT_DKP_GILDE		 		= "hermandad"
TEXT_DKP_PARTY		 		= "grupo"
TEXT_DKP_LOCAL		 		= "local"
TEXT_DKP_SAY		 		= "decir"
TEXT_DKP_RAID		 		= "banda"
TEXT_DKP_ShowOnlyInRaid		= "Mostrar solo miembros de banda" ;
TEXT_DKP_TT_HEAD      = "Postear informaci�n del Tooltip";
TEXT_DKP_TT_PARTY 			= "Postear informaci�n del Tooltip en Chat de Grupo" ;
TEXT_DKP_TT_RAID 			= "Postear informaci�n del Tooltip en Chat de Banda" ;
TEXT_DKP_TT_CHAT 			= "Postear informaci�n del Tooltip en Chat" ;
TEXT_DKP_TT_GUILD 			= "Postear informaci�n del Tooltip en Chat de Hermandad" ;
TEXT_DKP_TT_OFFICER			= "Postear informaci�n del Tooltip en Chat de Oficiales" ;
TEXT_DKP_TT_NEED_RAID		= " en la banda sin DKP"
TEXT_DKP_TT_LIMIT_SHOW		= "Mostrar s�lo el primero "
TEXT_DKP_TT_LIMIT_WARINIG	= "GETDKP: �Demasiadas columnas para el Tooltip! Establece un l�mite. Para ayuda /dkp help"
TEXT_DKP_FIGHT_WHISPER		= "GETDKP: Lo siento. En combate ahora. Susurros desactivados."
TEXT_DKP_ShowNonSet			= "Mostrar puntos sin asignar para tu clase en el Tooltip de Titan";
TEXT_DKP_ADDDKP_RAID		= "DKP a�adidos a todos los jugadores en la banda";
TEXT_DKP_ADDDKP_Player		= "DKP a�adidos a";
TEXT_DKP_SUBDKP_RAID		= "DKP restados de todos los jugadores en la banda";
TEXT_DKP_SUBDKP_Player		= "DKP restados a";
TEXT_DKP_GETS				= "para"
TEXT_DKP_LiveError			= " GETDKP Live DKP: No eres un oficial de banda. No se cambiaron valores de GetDKP";
GDKP_Text_ClientMode		= "GetDKP est� en modo cliente";
GDKP_Text_multiTable		= "|cff66CCCCmultiTabla, ";
GDKP_Text_DKPInfo			= "|cff66CCCCDKPInfo, ";
GDKP_Text_GDKP				= "|cff66CCCCGDKP, ";
GDKP_Text_DKPItems			= "|cff66CCCCDKP-Objetos ";
GDKP_Text_Vars 				= "No hay variables en tu getdkp.lua. rev�salo";
GDKP_Text_NoMembers			= "No hay miembros en tu EQDKP. ";
GDKP_Text_NoItems			= "No hay objetos en tu EQDKP. ";
GDKP_Text_ToLow				= "�Tienes GetDKP con una versi�n antigua de getdkp.php! Tu administrador tiene que actualizarlo a una versi�n posterior que viene con EQDKP 0.4.x";
GDKP_Text_Alias				= "La funci�n de Alias de GetDKP est� en la versi�n de getdkp.php 2.61 Tu administrador tiene que actualizar al que viene con EQDKP 0.5.x";
GDKP_Text_DataTransfer 		= "La funci�n de transferencia de datos est� usando la versi�n de getdkp.php 2.63. Tu administrador tiene que actualizar al que viene con EQDKP 0.5.x";
GDKP_Text_RP				= "La funci�n de planificaci�n de bandas est� usando la versi�n de getdkp.php 2.64. Tu administrador tiene que actualizar al que viene con EQDKP 0.5.x";
GDKP_Text_HookCTRT			= "Establecer y restar"
	end
-- Set Names
GDKP_Search_SETS =
{
	{ Class_DE = "Paladin", 	Class_ENG = "Paladin",		Class_ES = "Palad�n",		TONENAME_DE="Gerechtigkeit", 	TONENAME_ENG="Lawbringer", 		TONENAME_ES="Justiciero", 		TTWONAME_DE = "Richturteils",		TTWONAME_ENG = "Judgement",			TTWONAME_ES = "Sentencia" },
	{ Class_DE = "Priester", 	Class_ENG = "Priest", 		Class_ES = "Sacerdote", 		TONENAME_DE="Prophezeiung", 	TONENAME_ENG="Transcendence", 	TONENAME_ES="Trascendencia", 	TTWONAME_DE = "Erhabenheit",  		TTWONAME_ENG = "Prophecy",  		TTWONAME_ES = "Profec�a" },
	{ Class_DE = "Schurke", 	Class_ENG = "Rogue", 		Class_ES = "Rogue", 		TONENAME_DE="Nachttöter", 		TONENAME_ENG="Nightslayer", 	TONENAME_ES="Destripador nocturno", 	TTWONAME_DE = "Blutfang",  			TTWONAME_ENG = "Bloodfang",  		TTWONAME_ES = "Colmillo de Sangre" },
	{ Class_DE = "Druide", 		Class_ENG = "Druid", 		Class_ES = "Druida", 		TONENAME_DE="Cenarius", 		TONENAME_ENG="Cenarion", 		TONENAME_ES="Cenarion", 		TTWONAME_DE = "Stormrage",  		TTWONAME_ENG = "Stormrage",  		TTWONAME_ES = "Tempestira" },
	{ Class_DE = "Krieger",		Class_ENG = "Warrior", 		Class_ES = "Guerrero", 		TONENAME_DE="Macht", 			TONENAME_ENG="Might", 			TONENAME_ES="Poder�o", 			TTWONAME_DE = "Zorns",  			TTWONAME_ENG = "Wrath",  			TTWONAME_ES = "C�lera" },
	{ Class_DE = "Schamane",	Class_ENG = "Shaman", 		Class_ES = "Cham�n", 		TONENAME_DE="Erdfuror", 		TONENAME_ENG="Earthfury", 		TONENAME_ES="Furia Terrenal", 		TTWONAME_DE = "St�rme",  			TTWONAME_ENG = "Storms",  			TTWONAME_ES = "Tormentas" },
	{ Class_DE = "J\195\164ger",Class_ENG = "Hunter", 		Class_ES = "Cazador", 		TONENAME_DE="Riesenj\195\164gers", 	TONENAME_ENG="Giantstalker", 	TONENAME_ES="Acechagigantes", 	TTWONAME_DE = "Drachenpirscher",	TTWONAME_ENG = "Dragonstalker",		TTWONAME_ES = "Acechadrag�n" },
	{ Class_DE = "Magier",		Class_ENG = "Mage", 		Class_ES = "Mago", 		TONENAME_DE="Arkanisten", 		TONENAME_ENG="Arcanist", 		TONENAME_ES="Arcanista", 		TTWONAME_DE = "Netherwind",  		TTWONAME_ENG = "Netherwind",  		TTWONAME_ES = "Viento abisal" },
	{ Class_DE = "Hexenmeister",Class_ENG = "Warlock", 		Class_ES = "Brujo", 		TONENAME_DE="Felheart", 		TONENAME_ENG="Felheart", 		TONENAME_ES="Coraz�n vil", 		TTWONAME_DE = "Nemesis",  			TTWONAME_ENG = "Nemesis",  			TTWONAME_ES = "N�mesis" },
	{ Class_DE = "Todesritter",	Class_ENG = "Death Knight",	Class_ES = "Caballero de la Muerte",	TONENAME_DE="a", 				TONENAME_ENG="a", 				TONENAME_ES="a", 				TTWONAME_DE = "a",  				TTWONAME_ENG = "a",  				TTWONAME_ES = "a" },
};

GDKP_Special_Class = {
						[1] = {	"Schurke","Paladin","Schamane"},
						[2] = { "Krieger","Priester","Druide"},
						[3] = { "J\195\164ger","Hexenmeister","Magier"},
						[4] = { "Paladin","Priester","Hexenmeister"},
						[5] = { "Krieger","J\195\164ger","Schamane"},
						[6] = { "Druide","Magier","Schurke","Todesritter"},
						[7] = { "Paladin","Krieger","Todesritter"},
						[8] = { "Schamane","J\195\164ger"},
						[9] = { "Druide","Schurke"},
						[10] = { "Priester","Magier","Hexenmeister"},


	};
-- french localization
if ( GetLocale() == "frFR" ) then


end



------------------GetDKP List Localization -----------------------------------------

GDL_Events = " Raidevents :";
GDL_Data = "Data from : ";
GDL_TPlayers = "Total Players : ";
GDL_TPoints = "Total DKP : ";
GDL_TItems = "Total Items : ";
GDL_Points = "DKP : ";
GDL_Items = "Items";
GDL_NAME = "Name";
GDL_SHOWITEM = "Show SetItems";
GDL_NONSETITEM = "Show NonsetItems";
GDL_SHOWPLAYER = "Player Stats";
GDL_REFRESH = "Refresh";
GDL_HEADER_SET = "SetItems from";
GDL_HEADER_NONSET = "NonItems from";
GDL_NONSETITEMS_HEADER_ITEMS = "Itemname";
GDL_NONSETITEMS_HEADER_DKP = "DKP";
GDL_NO_ATRIBUDES = "|cffffffffSorry no more Informations for this Item.";
GDL_WapponSide = {wapponmainhand = "1.Hand",shildhand = "2.Hand",diztans = "Diztans"};
GDL_NOTINRAID = "Show all user";
GDL_INRAID = "Show Raid user";
GDC_GDL_Send_Text = "Send List Data";
GDC_GDL_Resiv_Text = "Ask for Data";
if (GetLocale() == "deDE") then
	GDL_Data = "Daten vom : ";
	GDL_TPlayers = "Spieleranzahl : ";
	GDL_TPoints = "GesamtDKP : ";
	GDL_TItems = "Gesamte Items : ";
	GDL_Points = "DKP : ";
	GDL_Items = "Items";
	GDL_NAME = "Name";
	GDL_SHOWITEM = "Zeige SetItems";
	GDL_NONSETITEM = "Zeige NonsetItems";
	GDL_SHOWNONSETITEM = "Zeige NonSetItems";
	GDL_HIDESETITEM = "Hide NonSetItems";
	GDL_REFRESH = "Aktualisieren";
	GDL_HEADER_SET = "SetItems von";
	GDL_HEADER_NONSET = "NonItems from";
	GDL_NONSETITEMS_HEADER_ITEMS = "Itemname";
	GDL_NONSETITEMS_HEADER_DKP = "DKP";
	GDL_NO_ATRIBUDES = "|cffffffffSorry keine weiteren information\nf\195\188r diese item vorhanden.";
	GDL_WapponSide = {wapponmainhand = "1.Hand",shildhand = "2.Hand",diztans = "Distans"};
	GDL_NOTINRAID = "zeige Alle";
	GDL_INRAID = "zeige nur Raid";
	GDC_GDL_Send_Text = "Sende Daten";
	GDC_GDL_Resiv_Text = "Anfrage nach Daten";
end;
if (GetLocale() == "esES") then
	GDL_Events = " Raidevents :";
	GDL_Data = "Data from : ";
	GDL_TPlayers = "Total Players : ";
	GDL_TPoints = "Total DKP : ";
	GDL_TItems = "Total Items : ";
	GDL_Points = "DKP : ";
	GDL_Items = "Items";
	GDL_NAME = "Name";
	GDL_SHOWITEM = "Show SetItems";
	GDL_NONSETITEM = "Show NonsetItems";
	GDL_SHOWPLAYER = "Player Stats";
	GDL_REFRESH = "Refresh";
	GDL_HEADER_SET = "SetItems from";
	GDL_HEADER_NONSET = "NonItems from";
	GDL_NONSETITEMS_HEADER_ITEMS = "Itemname";
	GDL_NONSETITEMS_HEADER_DKP = "DKP";
	GDL_NO_ATRIBUDES = "|cffffffffSorry no more Informations for this Item.";
	GDL_WapponSide = {wapponmainhand = "1.Hand",shildhand = "2.Hand",diztans = "Diztans"};
	GDL_NOTINRAID = "Show all user";
	GDL_INRAID = "Show Raid user";
	GDC_GDL_Send_Text = "Send List Data";
	GDC_GDL_Resiv_Text = "Ask for Data";
end;

----------------------------- GetDKP Config Lokalization ---------------------------------
GDC_GDA_HELP_TEXT = {};
GDC_Raidonly = "Show only Raidmembers";
MiniMap_Button_Positionx = "MiniMap Button Position angle";
MiniMap_Button_Positiony = "MiniMap Button Position radius";
MiniMap_Button_Show = "MiniMap Button Show";
Skalierung_GDA_Show = "Bet and win scaling ";
Skalierung_GDC_Show = "GetDKPConfig scaling ";
Skalierung_GDL_Show = "GetDKPList scaling ";
GDC_Title = "Get DKP Plus Configuration";
GDC_GDP = "Get DKP PLUS";
GDC_GDA = "Bet and Win";
GDC_GDL = "Get DKP List";
GDC_SCALE = "Scale";
GDC_GDP_TEXT = "You can change the GetDKP Configuration";
GDC_GDA_TEXT = "You can change the Bet and Win Configuration";
GDC_GDL_TEXT = "You can change the GetDKP List Configuration";
GDC_SCALE_TEXT = "You can change the Scale from the Getdkp Windows";
GDC_Buyerslimit = "Show xx Itemowner";
GDC_Needlimit = "Show xx who Item need";
GDC_Chat = "Outputchat";
GDC_Whisperdkp = "Whisperfunction for Points";
GDC_Whisperitem = "Whisperfunction for Items";
GDC_Whisperhide = "Hide Whisperoutput";
GDC_Tooltip = "Show Tooltip";
GDC_Tooltip_Raid = "Show Tooltip only in Raid";
GDC_Tooltipposition = "Position of ToolTip";
GDC_Tooltipminmax = "Show Min/Max/AVG Points in Tooltip";
GDC_Tooltipdkp = "Show your own DKP in Tooltip";
GDC_Tooltipbuyers = "Show the buyers of Items in ToolTip";
GDC_Tooltipreport = "Show the buyers of a Item";
GDC_DKPLive = "LiveDKP Function";
GDC_Whisper = "Whisper";
GDC_Guild = "Guild";
GDC_Say = "Say";
GDC_Group = "Group";
GDC_Raid = "Raid";
GDC_Local = "Local";
GDC_Offz = "Officer";
GDC_Obove = "Top";
GDC_Down = "Down";
GDC_Left = "Left";
GDC_Right = "Right";
GDC_Plus = "+";
GDC_Minus = "-";


--extension Token / highest bidder
GDA_Monk = "Monk"
GDC_Announce_highest_bid = "Announce highest bid"
GDA_new_highest_bid = "New highest bid : "
GDA_bid_too_low = "Bid is lower than allowed!"
GDC_Whisper_Token_Usage = "Please use following syntax for tokenrequest : 'dkp token *Class*'  e.g. 'dkp token druid'"
GDA_bid_lowering = "You can not lower your bid!"
GDA_equal_highest_bid = "There are more than 1 highest bid with  "
GDA_low_highest_bid = "There is still a higher bid than yours with "
GDA_same_bid_as_before = "You just bid the same amount of DKP like before!"



GDC_DKPLive_RaidSetPoints = "SetDKP for the Raid";
GDC_DKPLive_RaidNonSetPoints = "NonSetDKP for the Raid";
GDC_DKPLive_PlayerSetPoints = "SetDKP for the Player";
GDC_DKPLive_PlayerSetPoints = "NonSetDKP for the Player";
GDC_GDA_Rule1_ChatLook = "Witch channel is under controle";
GDC_GDA_Rule1_MinDKP = "Minimum DKP";
GDC_GDA_Rule1_Titel = "Bet and Win Rule 1 Attribuds";
GDC_GDA_Rule2_Titel = "Bet and Win Rule 2 Attribuds";
GDC_GDA_Rule3_Titel = "Bet and Win Rule 3 Attribuds";
GDC_GDA_Rule4_Titel = "Bet and Win Rule 4 Attribuds";
GDC_GDA_Rule1 = "Rules 1";
GDC_GDA_Rule2 = "Rules 2";
GDC_GDA_Rule3 = "Rules 3";
GDC_GDA_Rule4 = "Rules 4";
GDC_GDA_OnOff = "On/Off"
GDC_GDA_HELP_TEXT[1] = "|cffffffffRegel1\n\The highest bet wins for the secound bet +1.n\nIt gives only one bet this wins for mindkp.\n\nIf 2 the same bets buyers must roll /random 100 .\n\nIs the Highst bet lower than mindkp,the player wins with mindkp."
GDC_GDA_HELP_TEXT[2] = "|cffffffffRegel2\n\nIs ordered with BetWord in the Bet channel .The player with the highest DKP wins for the FixedDKP related to the BetWord. The needWord is always higher than GreedWord.\n\nIf more then one has the same DKP they are requested to roll.";
GDC_GDA_HELP_TEXT[3] = "|cffffffffRegel3\n\nThe highst bet wins for this DKP.\n\nIf more then one has the same bets the players are requested to do /roll 100.\n\nIs the highest bet lower than mindkp,the players wins for min dkp.";
GDC_GDA_HELP_TEXT[4] = "|cffffffffRegel4\n\n";
GDC_GDL_ASK_SEND_DATA_TEXT = "GetDKP Data send !!!";
GDC_GDA_Rule4_BetWord = "NeedWord";
GDC_GDA_Rule1_FestDKP = "need DKP";
GDC_GDA_Rule4_GreedWord = "GreedWord";
GDC_GDA_Rule1_GreedDKP = "greed DKP";
GDC_Konto = "adjust the account for the raid";
GDC_ShowItems = "Show Itemwindow";
GDC_epgp = "Enable EPGP";
GDC_TokenItems = "Show all TokenItems in the Set Windows";
GDC_GDA_CD_OnOff = "Countdown On/Off";
GDC_GDA_CD_LOOTLEVEL = " LootLevel";
GDC_LOOTLEVEL2 = "Uncommon"
GDC_LOOTLEVEL3 = "Rare";
GDC_LOOTLEVEL4 = "Epic";
GDC_RESIV1 = "GetDKP has received Data from ";
GDC_RESIV2 = "GetDKP is received Data from ";
GDC_SEND = "GetDKP is send DATA";
GDC_SEND_LAG = "GetDKP have reached the max data to send. now comes for a few seconds lag.";
GDC_GDL_ASK_SEND_NO_TEXT = "No";
GDC_GDL_ASK_SEND_YES_TEXT = "Yes";
GDC_ASK_TEXT = "GetDKP Request accept";
GDC_GDL_RESET_Text = "clear data";

if (GetLocale() == "deDE") then
GDC_GDL_ASK_SEND_DATA_TEXT = "GetDKP Daten senden !!!";
GDC_GDL_ASK_SEND_NO_TEXT = "Nein";
GDC_GDL_ASK_SEND_YES_TEXT = "Ja";
GDC_Title = "Get DKP Plus Configuration";
GDC_GDP = "Get DKP PLUS";
GDC_GDA = "Bet and Win";
GDC_GDL = "Get DKP List";
GDC_SCALE = "Scale";
GDC_GDP_TEXT = "Hier kannst du die konfiguration \195\164ndern";
GDC_GDA_TEXT = "Hier kannst du die konfiguration \195\164ndern";
GDC_GDL_TEXT = "Hier kannst du die konfiguration \195\164ndern";
GDC_SCALE_TEXT = "Hier kannst ihr die konfiguration \195\164ndern";
MiniMap_Button_Positionx = "MiniMap Button Position winkel";
MiniMap_Button_Positiony = "MiniMap Button Position radius";
MiniMap_Button_Show = "Zeige MiniMap Button";
Skalierung_GDC_Show = "GetDKPConfig skalierung ";
Skalierung_GDL_Show = "GetDKPList skalierung ";
Skalierung_GDA_Show = "Bet and win skalierung ";
GDC_Close = "Schlie\195\159en";
GDC_Raidonly = "Nur Spieler im Raid zeigen";
GDC_Buyerslimit = "xx Item besitzer";
GDC_Needlimit = "xx Spieler haben bedarf";
GDC_Chat = "Ausgabechat";
GDC_Whisperdkp = "Whisperfunktion f\195\188r Punkte Ein/Ausschalten";
GDC_Whisperitem = "Whisperfunktion f\195\188r Items Ein/Ausschalten";
GDC_Whisperhide = "Whispertext ausblenden";
GDC_Tooltip = "Zeige Tooltip";
GDC_Tooltip_Raid = "Zeige Tooltip nur im Raid";
GDC_Tooltipposition = "Position des ToolTip";
GDC_Tooltipminmax = "Zeige Min/Max/AVG Punkte in Tooltip";
GDC_Tooltipdkp = "Zeige deine DKP in Tooltip";
GDC_Tooltipbuyers = "Zeige K\195\164ufer des Items in ToolTip";
GDC_Tooltipreport = "Zeige K\195\164ufer eines Item";
GDC_DKPLive = "LiveDKP Funktion";
GDC_Whisper = "Fl\195\188stern";
GDC_Guild = "Gilde";
GDC_Say = "Sagen";
GDC_Group = "Gruppe";
GDC_Raid = "Raid";
GDC_Local = "Lokal";
GDC_Offz = "Offizier";
GDC_Obove = "Oben";
GDC_Down = "Unten";
GDC_Left = "Links";
GDC_Right = "Rechts";


--extension Token / highest bidder
GDA_Monk = "M\195\182nch"
GDC_Announce_highest_bid = "Aktuelles H\195\182chstgebot ausgeben"
GDA_bid_lowering = "Du kannst dein Gebot nicht verringern!"
GDA_equal_highest_bid = "Es gibt mehr als einen H\195\182chstbietenden mit "
GDA_low_highest_bid = "Es gibt weiterhin ein H\195\182chstgebot \195\188ber dir mit "
GDA_same_bid_as_before = "Du hast das gleiche Gebot wie zuvor abgegeben!"
GDA_new_highest_bid = "Neues H\195\182chstgebot : "
GDA_bid_too_low = "Das Gebot ist niedriger als erlaubt!"
GDC_Whisper_Token_Usage = "F\195\188r Tokenanfragen bitte folgende Syntax verwenden : 'dkp token *Klasse*'  z.b. 'dkp token druide'"


GDC_DKPLive_RaidSetPoints = "SetDKP f\195\188r den Raid";
GDC_DKPLive_RaidNonSetPoints = "NonSetDKP f\195\188r den Raid";
GDC_DKPLive_PlayerSetPoints = "SetDKP f\195\188r den Spieler";
GDC_DKPLive_PlayerNonSetPoints = "NonSetDKP f\195\188r den Spieler";
GDC_GDA_Rule1_ChatLook = "Kontrolierter ChatChannel";
GDC_GDA_Rule1_MinDKP = "Minimum DKP";
GDC_GDA_Rule1_Titel = "Bet and Win Regelwerk 1 Einstellungen";
GDC_GDA_Rule2_Titel = "Bet and Win Regelwerk 2 Einstellungen";
GDC_GDA_Rule3_Titel = "Bet and Win Regelwerk 3 Einstellungen";
GDC_GDA_Rule4_Titel = "Bet and Win Regelwerk 4 Einstellungen";
GDC_GDA_Rule1 = "Regeln 1 ";
GDC_GDA_Rule2 = "Regeln 2";
GDC_GDA_Rule3 = "Regeln 3";
GDC_GDA_Rule4 = "Regeln 4";
GDC_GDA_OnOff = "ein/aus"
GDC_GDA_HELP ="Bet and Win Hilfe";
GDC_GDA_HELP2 ="Bet and Win";
GDC_GDA_HELPTEXT = "Hier kannst du dir das Regelwerk\nder einzelnen Regeln anschauen";
GDC_GDA_HELPTEXT2 = "zur\195\188ck zu Bet and Win einstellungen";
GDC_GDA_HELP_TEXT[1] = "|cffffffffRegelwerk 1\n\nDas h\195\182chste gebot gewinnt mit den DKP vom 2 h\195\182chstengebot +1.\n\nWird nur 1 gebot abgegeben gewinnt dieses mit den mindkp.\n\nSind gleich hohe h\195\182chstgebote da wird ein text ausgegeben der diese spieler nent und mit wieviel dkp der Gewinner eines /roll100 gewinnt.\n\nIst das Gewinnergebot kleiner der mindkp wird dieser mit dem mindkp gebot ausgegeben."
GDC_GDA_HELP_TEXT[2] = "|cffffffffRegelwerk 2\n\nJeder Spieler der bieten m\195\182chte muss das bietwort in den daf\195\188r eingestellten channel schreiben.Es gewinnt der Spieler der dann die h\195\182chsten DKP hat f\195\188r die zu dem bietwort eingestellten festDKP. Need-Gebote gehen stets \195\188ber Greed-Geboten.\n\nSollten mehrere Spieler gleich viel DKP besitzen so werden diese gennant und zu /roll00 aufgefordert.";
GDC_GDA_HELP_TEXT[3] = "|cffffffffRegelwerk 3\n\nDas h\195\182chste gebot gewinnt.\n\nSind gleich hohe h\195\182chstgebote da wird ein text ausgegeben der diese spieler nent und mit wieviel dkp der Gewinner eines /roll100 gewinnt.\n\nIst das Gewinnergebot kleiner der mindkp wird dieser mit dem mindkp gebot ausgegeben.";
GDC_GDA_HELP_TEXT[4] = "|cffffffffRegelwerk 4\n\nComming soon";
GDC_GDA_Rule4_BetWord = "NeedWort";
GDC_GDA_Rule1_FestDKP = "NeedDKP";
GDC_GDA_Rule4_GreedWord = "GreedWort";
GDC_GDA_Rule1_GreedDKP = "GreedDKP";
GDC_Konto = "Das f\195\188r den raid genutzte Konto einstellen";
GDC_ShowItems = "Zeige Itemfenster";
GDC_TokenItems = " Zeige alle TokenItems in den Set Fenstern";
GDC_epgp = "EPGP einschalten";
GDC_GDA_CD_OnOff = "Countdown Einschalten/Ausschalten";
GDC_GDA_CD_LOOTLEVEL = "ab welchem LootLevel";
GDC_LOOTLEVEL2 = "Selten"
GDC_LOOTLEVEL3 = "Rar";
GDC_LOOTLEVEL4 = "Episch";
GDC_RESIV1 = "GetDKP hat Daten empfangen von ";
GDC_RESIV2 = "GetDKP empf\195\164ngt Daten von ";
GDC_SEND = "GetDKP sendet Daten";
GDC_SEND_LAG = "GetDKP hat die maximale Anzahl an sendbaren Zeichen erreicht. Nun kommen f�r ein paar Sekunden lags";
GDC_ASK_TEXT = "GetDKPdaten anfrage akzeptieren ";
GDC_GDL_RESET_Text = "Daten l\195\182schen";
end;

if (GetLocale() == "esES") then
GDC_GDA_HELP_TEXT = {};
GDC_Raidonly = "Show only Raidmembers";
MiniMap_Button_Positionx = "MiniMap Button Position angle";
MiniMap_Button_Positiony = "MiniMap Button Position radius";
MiniMap_Button_Show = "MiniMap Button Show";
Skalierung_GDA_Show = "Bet and win scaling ";
Skalierung_GDC_Show = "GetDKPConfig scaling ";
Skalierung_GDL_Show = "GetDKPList scaling ";
GDC_Title = "Get DKP Plus Configuration";
GDC_GDP = "Get DKP PLUS";
GDC_GDA = "Bet and Win";
GDC_GDL = "Get DKP List";
GDC_SCALE = "Scale";
GDC_GDP_TEXT = "You can change the GetDKP Configuration";
GDC_GDA_TEXT = "You can change the Bet and Win Configuration";
GDC_GDL_TEXT = "You can change the GetDKP List Configuration";
GDC_SCALE_TEXT = "You can change the Scale from the Getdkp Windows";
GDC_Buyerslimit = "Show xx Itemowner";
GDC_Needlimit = "Show xx who Item need";
GDC_Chat = "Outputchat";
GDC_Whisperdkp = "Whisperfunction for Points";
GDC_Whisperitem = "Whisperfunction for Items";
GDC_Whisperhide = "Hide Whisperoutput";
GDC_Tooltip = "Show Tooltip";
GDC_Tooltip_Raid = "Show Tooltip only in Raid";
GDC_Tooltipposition = "Position of ToolTip";
GDC_Tooltipminmax = "Show Min/Max/AVG Points in Tooltip";
GDC_Tooltipdkp = "Show your own DKP in Tooltip";
GDC_Tooltipbuyers = "Show the buyers of Items in ToolTip";
GDC_Tooltipreport = "Show the buyers of a Item";
GDC_DKPLive = "LiveDKP Function";
GDC_Whisper = "Whisper";
GDC_Guild = "Guild";
GDC_Say = "Say";
GDC_Group = "Group";
GDC_Raid = "Raid";
GDC_Local = "Local";
GDC_Offz = "Officer";
GDC_Obove = "Top";
GDC_Down = "Down";
GDC_Left = "Left";
GDC_Right = "Right";
GDC_Plus = "+";
GDC_Minus = "-";





--extension Token / highest bidder
GDA_Monk = "Monk"
GDC_Announce_highest_bid = "Announce highest bid"
GDA_new_highest_bid = "New highest bid : "
GDA_bid_too_low = "Bid is lower than allowed!"
GDC_Whisper_Token_Usage = "Please use following syntax for tokenrequest : 'dkp token Class'  e.g. 'dkp token druid'"
GDA_bid_lowering = "You can not lower your bid!"
GDA_equal_highest_bid = "There are more than 1 highest bid with  "
GDA_low_highest_bid = "There is still a higher bid than yours with "
GDA_same_bid_as_before = "You just bid the same amount of DKP like before!"

GDC_DKPLive_RaidSetPoints = "SetDKP for the Raid";
GDC_DKPLive_RaidNonSetPoints = "NonSetDKP for the Raid";
GDC_DKPLive_PlayerSetPoints = "SetDKP for the Player";
GDC_DKPLive_PlayerSetPoints = "NonSetDKP for the Player";
GDC_GDA_Rule1_ChatLook = "Witch channel is under controle";
GDC_GDA_Rule1_MinDKP = "Minimum DKP";
GDC_GDA_Rule1_Titel = "Bet and Win Rule 1 Attribuds";
GDC_GDA_Rule2_Titel = "Bet and Win Rule 2 Attribuds";
GDC_GDA_Rule3_Titel = "Bet and Win Rule 3 Attribuds";
GDC_GDA_Rule4_Titel = "Bet and Win Rule 4 Attribuds";
GDC_GDA_Rule1 = "Rules 1";
GDC_GDA_Rule2 = "Rules 2";
GDC_GDA_Rule3 = "Rules 3";
GDC_GDA_Rule4 = "Rules 4";
GDC_GDA_OnOff = "On/Off"
GDC_GDA_HELP_TEXT[1] = "|cffffffffRegel1\n\The highest bet wins for the secound bet +1.n\nIt gives only one bet this wins for mindkp.\n\nIf 2 the same bets buyers must roll /random 100 .\n\nIs the Highst bet lower than mindkp,the player wins with mindkp."
GDC_GDA_HELP_TEXT[2] = "|cffffffffRegel2\n\nIs ordered with BetWord in the Bet channel .The player with the highest DKP wins for the FixedDKP related to the BetWord. The needWord is always higher than GreedWord.\n\nIf more then one has the same DKP they are requested to roll.";
GDC_GDA_HELP_TEXT[3] = "|cffffffffRegel3\n\nThe highst bet wins for this DKP.\n\nIf more then one has the same bets the players are requested to do /roll 100.\n\nIs the highest bet lower than mindkp,the players wins for min dkp.";
GDC_GDA_HELP_TEXT[4] = "|cffffffffRegel4\n\n";
GDC_GDL_ASK_SEND_DATA_TEXT = "GetDKP Data send !!!";
GDC_GDA_Rule4_BetWord = "NeedWord";
GDC_GDA_Rule1_FestDKP = "need DKP";
GDC_GDA_Rule4_GreedWord = "GreedWord";
GDC_GDA_Rule1_GreedDKP = "greed DKP";
GDC_Konto = "adjust the account for the raid";
GDC_ShowItems = "Show Itemwindow";
GDC_TokenItems = "Show all TokenItems in the Set Windows";
GDC_epgp = "Enable EPGP";
GDC_GDA_CD_OnOff = "Countdown On/Off";
GDC_GDA_CD_LOOTLEVEL = " LootLevel";
GDC_LOOTLEVEL2 = "Uncommon"
GDC_LOOTLEVEL3 = "Rare";
GDC_LOOTLEVEL4 = "Epic";
GDC_RESIV1 = "GetDKP has received Data from ";
GDC_RESIV2 = "GetDKP is received Data from ";
GDC_SEND = "GetDKP is send DATA";
GDC_SEND_LAG = "GetDKP have reached the max data to send. now comes for a few seconds lag.";
GDC_GDL_ASK_SEND_NO_TEXT = "No";
GDC_GDL_ASK_SEND_YES_TEXT = "Yes";
GDC_ASK_TEXT = "GetDKP Request accept";
GDC_GDL_RESET_Text = "clear data";
end;

-------------------------------------------- GetDKP Admin Lokalization ---------------------

GDA_Priest = "Priest";
GDA_Paladin = "Paladin";
GDA_Rogue  = "Rogue";
GDA_Warrior = "Warrior";
GDA_Hunter = "Hunter";
GDA_Druid = "Druid";
GDA_Mage = "Mage";
GDA_Warlock = "Warlock";
GDA_Shaman = "Shaman";
GDA_DeathKnight = "DeathKnight";
GDA_All = "All";
GDA_Close = "Close";
GDA_Points = "DKP : ";
GDA_Items = "Items";
GDA_HEADER_PLAYERS_NAME = "Name";
GDA_HEADER_PLAYERS_CLASS = "Class";
GDA_HEADER_PLAYERS_SET = "DKP";
GDA_HEADER_PLAYERS_NONSET = "NS";
GDA_HEADER_PLAYERS_MIX = "Mix";
GDA_HEADER_PLAYERS_ORDER = "Order";
GDA_STRING_SELECT_CLASS = "Select Class";
GDA_HEADER_NONSET = "NonSet Items";
GDA_HEADER_SET = "Set Items";
GDA_CLEAR = "Clear";
GDA_COUNTDOWN = "Countdown";
GDA_WINS = " wins for ";
GDA_WINS2 = " wins for ";
GDA_ROLL = " please Roll 100. Winner take the Item for ";
GDA_PAAR_A = " has roll ";
GDA_PAAR_B = " and wins this Item for ";
GDA_PAAR_C = " dkp";
GDA_PAAR_1ROLL = " Please only one roll";
GDC_GDA_Off = "BaW off";
GDC_GDA_On = "BaW on";
GDC_GDA_OnOff = "On/Off";
GDAKontoName = "AccountName : ";
GDA_CD_ON = "CD Start";
GDA_CD_OFF = "CD Stop";
GDC_GDA_CD_Text = "Countdown";
GDC_GDA_CD_Timeset = "Countdown runtime in seconds";
GDC_GDA_CD_Alertset = "Countdown Alert";
GDC_GDA_CD_LOOTOnOff = "Show Loot in Chat";
GDC_GDA_CD_LOOTGDAOnOff = "Show Loot in Bet&win Window";
GDC_GDA_CD_LOOTGDA_RW = "Show item as raidwarning when countdown starts"
GDA_CD_MSG_TEXT_1 = "The Auction is started.The Countdown has started";
GDA_CD_MSG_TEXT_2 = " seconds.";
GDA_CD_MSG_TEXT_3 = "No more offers for this Auction.";
GDA_CD_MSG_TEXT_4 = "The Auction stopt in ";
GDA_CD_MSG_TEXT_5 = "The Auction stopt in 3 seconds.";
GDA_CD_MSG_TEXT_6 = "The Auction stopt in 2 seconds.";
GDA_CD_MSG_TEXT_7 = "The Auction stopt in 1 seconds.";
GDA_CD_MSG_TEXT_8 = "The Countdown has stopt.";
GDA_LOOT_TEXT_1 = "Auction started for ";
if (GetLocale() == "deDE") then
	GDA_Priest = "Priester";
	GDA_Paladin = "Paladin";
	GDA_Rogue  = "Schurke";
	GDA_Warrior = "Krieger";
	GDA_Hunter = "J\195\164ger";
	GDA_Druid = "Druide";
	GDA_Mage = "Magier";
	GDA_Warlock = "Hexenmeister";
	GDA_Shaman = "Schamane";
	GDA_DeathKnight = "Todesritter";
	GDA_All = "Alle";
	GDA_Close = "Schlie\195\159en";
	GDA_Points = "DKP : ";
	GDA_Items = "Items";
	GDA_HEADER_PLAYERS_NAME = "Name";
	GDA_HEADER_PLAYERS_CLASS = "Klasse";
	GDA_HEADER_PLAYERS_SET ="DKP";
	GDA_HEADER_PLAYERS_NONSET = "NS";
	GDA_HEADER_PLAYERS_MIX = "Mix";
	GDA_HEADER_PLAYERS_ORDER = "Gebot";
	GDA_STRING_SELECT_CLASS = "Klasse ausw\195\164hlen";
	GDA_HEADER_NONSET = "NonSet Items";
	GDA_HEADER_SET = "Set Items";
	GDA_CLEAR = "L\195\182schen";
	GDA_COUNTDOWN = "Countdown";
	GDA_WINS = " gewinnt mit ";
	GDA_WINS2 = " gewinnt f\195\188r ";
	GDA_ROLL = " bitte roll 100 machen. Der Gewinner erh\195\164lt das item f\195\188r ";
	GDA_PAAR_A = " hatt mit einem Wurf von ";
	GDA_PAAR_B = " das Item f\195\188r ";
	GDA_PAAR_C = " dkp gewonnen";
	GDA_PAAR_1ROLL = " bitte nur ein mal w\195\188rfeln";
	GDC_GDA_Off = "BaW aus";
	GDC_GDA_On = "BaW ein";
	GDC_GDA_OnOff = "ein/aus";
	GDAKontoName = "KontoName : ";
	GDA_CD_ON = "CD Starten";
	GDA_CD_OFF = "CD Stoppen";
	GDC_GDA_CD_Text = "Countdown & Loot";
	GDC_GDA_CD_Timeset = "Countdown laufzeit in sekunden";
	GDC_GDA_CD_Alertset = "Countdown Alarm";
	GDC_GDA_CD_LOOTOnOff = "Loot im Chat Zeigen";
	GDC_GDA_CD_LOOTGDAOnOff = "Zeige Loot im Bet&Win Fenster";
	GDC_GDA_CD_LOOTGDA_RW = "Zeige Items als Raidwarnung bei CD-Beginn"
	GDA_CD_MSG_TEXT_1 = "Die Auktion wurde gestartet.Die Auktion dauert ";
	GDA_CD_MSG_TEXT_2 = " sekunden.";
	GDA_CD_MSG_TEXT_3 = "Es werden keine weiteren Gebote angenommen."
	GDA_CD_MSG_TEXT_4 = "Die Versteigerung endet in ";
	GDA_CD_MSG_TEXT_5 = "Die Versteigerung endet in 3 sekunden."
	GDA_CD_MSG_TEXT_6 = "Die Versteigerung endet in 2 sekunden."
	GDA_CD_MSG_TEXT_7 = "Die Versteigerung endet in 1 sekunden."
	GDA_CD_MSG_TEXT_8 = "Der Countdown wurde abgebrochen."
	GDA_LOOT_TEXT_1 = "Versteigerung wurde gestartet f\195\188r ";
end;

if (GetLocale() == "esES") then
	GDA_Priest = "Priest";
	GDA_Paladin = "Paladin";
	GDA_Rogue  = "Rogue";
	GDA_Warrior = "Warrior";
	GDA_Hunter = "Hunter";
	GDA_Druid = "Druid";
	GDA_Mage = "Mage";
	GDA_Warlock = "Warlock";
	GDA_Shaman = "Shaman";
	GDA_DeathKnight = "DeathKnight";
	GDA_All = "All";
	GDA_Close = "Close";
	GDA_Points = "DKP : ";
	GDA_Items = "Items";
	GDA_HEADER_PLAYERS_NAME = "Name";
	GDA_HEADER_PLAYERS_CLASS = "Class";
	GDA_HEADER_PLAYERS_SET = "DKP";
	GDA_HEADER_PLAYERS_NONSET = "NS";
	GDA_HEADER_PLAYERS_MIX = "Mix";
	GDA_HEADER_PLAYERS_ORDER = "Order";
	GDA_STRING_SELECT_CLASS = "Select Class";
	GDA_HEADER_NONSET = "NonSet Items";
	GDA_HEADER_SET = "Set Items";
	GDA_CLEAR = "Clear";
	GDA_COUNTDOWN = "Countdown";
	GDA_WINS = " wins for ";
	GDA_WINS2 = " wins for ";
	GDA_ROLL = " please Roll 100. Winner take the Item for ";
	GDA_PAAR_A = " has roll ";
	GDA_PAAR_B = " and wins this Item for ";
	GDA_PAAR_C = " dkp";
	GDA_PAAR_1ROLL = " Please only one roll";
	GDC_GDA_Off = "BaW off";
	GDC_GDA_On = "BaW on";
	GDC_GDA_OnOff = "On/Off";
	GDAKontoName = "AccountName : ";
	GDA_CD_ON = "CD Start";
	GDA_CD_OFF = "CD Stop";
	GDC_GDA_CD_Text = "Countdown";
	GDC_GDA_CD_Timeset = "Countdown runtime in seconds";
	GDC_GDA_CD_Alertset = "Countdown Alert";
	GDC_GDA_CD_LOOTOnOff = "Show Loot in Chat";
	GDC_GDA_CD_LOOTGDAOnOff = "Show Loot in Bet&win Window";
	GDC_GDA_CD_LOOTGDA_RW = "Show item as raidwarning when countdown starts"
	GDA_CD_MSG_TEXT_1 = "The Auction is started.The Countdown has started";
	GDA_CD_MSG_TEXT_2 = " seconds.";
	GDA_CD_MSG_TEXT_3 = "No more offers for this Auction.";
	GDA_CD_MSG_TEXT_4 = "The Auction stopt in ";
	GDA_CD_MSG_TEXT_5 = "The Auction stopt in 3 seconds.";
	GDA_CD_MSG_TEXT_6 = "The Auction stopt in 2 seconds.";
	GDA_CD_MSG_TEXT_7 = "The Auction stopt in 1 seconds.";
	GDA_CD_MSG_TEXT_8 = "The Countdown has stopt.";
	GDA_LOOT_TEXT_1 = "Auction started for ";
end;

------------------ GetDKP RaidPlaner ----------------------------
GDR_DaysOfMonth = {31,28,31,30,31,30,31,31,30,31,30,31};




GDR_mon = "Mon";
GDR_die = "Tue";
GDR_mit = "Wed";
GDR_don = "Thu";
GDR_fre = "Fri";
GDR_sam = "Sut";
GDR_son = "Sun";
GDR_Month = {};
GDR_Month[1] = "January";
GDR_Month[2] = "Febuary";
GDR_Month[3] = "March";
GDR_Month[4] = "April";
GDR_Month[5] = "May";
GDR_Month[6] = "June";
GDR_Month[7] = "July";
GDR_Month[8] = "August";
GDR_Month[9] = "September";
GDR_Month[10] = "October";
GDR_Month[11] = "November";
GDR_Month[12] = "December";

GDR_All_Invite = "All Invite";
GDR_MonthOverview = "Month Overview";
GDR_DayOverview = "DayOverview";
GDR_raid_note = "Note";
GDR_raid_value = "Value";
GDR_raid_raidleader = "Raidleader";
GDR_raid_date = "Raid beginn";
GDR_raid_date_invite = "Invite";
GDR_raid_date_finish = "Raid stop";
GDR_raid_attendees = "is apply";
GDR_close = "exit";
GDR_whisper = "Whisper";
GDR_invite = "Invite";

GDR_invite_text = {};
	GDR_invite_text[1] = "not invite";
	GDR_invite_text[2] = "invite";
	GDR_invite_text[3] = "offline";
	GDR_invite_text[4] = "grouped";
	GDR_invite_text[5] = "is in Raid";
	GDR_invite_text[6] = "has refuse an invitation";
	GDR_invite_text[7] = "leave Group";
	GDR_invite_text[8] = "in Raid Offline";

GDR_class_groups = {};
GDR_class_groups[1] = "Healer";
GDR_class_groups[2] = "Tank";
GDR_class_groups[3] = "Melee";
GDR_class_groups[4] = "Range";

GDR_subscribed = {};
GDR_subscribed[1] = "Confirmed";
GDR_subscribed[2] = "Signed";
GDR_subscribed[3] = "Unsigned";
GDR_subscribed[4] = "Not Sure";
GDR_subscribed[5] = "Not Signed";
GDR_subscribed[6] = "Not Available";

GDR_skill = "Skill :";
GDR_noskill = "No Skill found";
GDR_Skill = {};
GDR_Skill["Paladin"] = {"Holy","Protection","Retribution"};
GDR_Skill["Rogue"] = {"Assassination","Combat","Subtlety"};
GDR_Skill["Warrior"] = {"Arms","Fury","Protection"};
GDR_Skill["Hunter"] = {"Beast Mastery","Marksmanship","Survival"};
GDR_Skill["Priest"] = {"Discipline","Holy","Shadow"};
GDR_Skill["Warlock"] = {"Affliction","Demonology","Destruction"};
GDR_Skill["Druid"] = {"Balance","Feral Combat","Restoration"};
GDR_Skill["Mage"] = {"Arcane","Fire","Frost"};
GDR_Skill["Shaman"] = {"Elemental","Enhancement","Restoration"};

GDR_Hybride_text = "Hybrid";
if (GetLocale() == "deDE") then
	GDR_mon = "Mo";
	GDR_die = "Di";
	GDR_mit = "Mi";
	GDR_don = "Do";
	GDR_fre = "Fr";
	GDR_sam = "Sa";
	GDR_son = "So";
	GDR_Month[1] = "Januar";
	GDR_Month[2] = "Febuar";
	GDR_Month[3] = "M\195\164rz";
	GDR_Month[4] = "April";
	GDR_Month[5] = "Mai";
	GDR_Month[6] = "Juni";
	GDR_Month[7] = "Juli";
	GDR_Month[8] = "August";
	GDR_Month[9] = "September";
	GDR_Month[10] = "Oktober";
	GDR_Month[11] = "November";
	GDR_Month[12] = "Dezember";

	GDR_All_Invite = "Alle einladen";
	GDR_MonthOverview = "Monats \195\156bersicht";
	GDR_DayOverview = "Tages \195\156bersicht";
	GDR_raid_note = "Notiz";
	GDR_raid_value = "Wert";
	GDR_raid_raidleader = "Raidleitung";
	GDR_raid_date = "Startzeitpunkt";
	GDR_raid_date_invite = "Einladezeitpunkt";
	GDR_raid_date_finish = "Endzeitpunkt";
	GDR_raid_attendees = "Angemeldet";
	GDR_close = "Abbrechen";
	GDR_whisper = "Fl\195\188stern";
	GDR_invite = "Einladen";

	GDR_invite_text = {};
	GDR_invite_text[1] = "ist nicht eingeladen";
	GDR_invite_text[2] = "ist eingeladen";
	GDR_invite_text[3] = "nicht online";
	GDR_invite_text[4] = "ist in Gruppe";
	GDR_invite_text[5] = "ist Raid beigetreten";
	GDR_invite_text[6] = "hatt einladung abgelehnt";
	GDR_invite_text[7] = "hatt Gruppe verlassen";
	GDR_invite_text[8] = "in Raid Offline";

	GDR_subscribed = {};
	GDR_subscribed[1] = "Best\195\164tigt";
	GDR_subscribed[2] = "Angemeldet";
	GDR_subscribed[3] = "Abgemeldet";
	GDR_subscribed[4] = "Ersatzbank";
	GDR_subscribed[5] = "Noch nicht angemeldet";
	GDR_subscribed[6] = "Nicht verf\195\188gbar";

	GDR_raid_distribution = "verteilung";
	GDR_raid_distribution_verteilung = {};
	GDR_raid_distribution_verteilung[0] = "Klassenverteilung";
	GDR_raid_distribution_verteilung[1] = "Rollenverteilung";
	GDR_raid_distribution_verteilung[2] = "ohne verteilung";

	GDR_skill = "Skillung :";
	GDR_noskill= "Keine Skillung vorhanden";
	GDR_Skill = {};
	GDR_Skill["Paladin"] = {"Heilig","Schutz","Vergeltung"};
	GDR_Skill["Schurke"] = {"Meucheln","Kampf","T\195\164uschung"};
	GDR_Skill["Krieger"] = {"Waffen","Furor","Schutz"};
	GDR_Skill["J\195\164ger"] = {"Tierherrschaft","Treffsicherheit","\195\156berleben"};
	GDR_Skill["Priester"] = {"Disziplin","Heilig","Schatten"};
	GDR_Skill["Hexenmeister"] = {"Gebrechen","D\195\164monologie","Zerst\195\182rung"};
	GDR_Skill["Druide"] = {"Gleichgewicht","Wilder Kampf","Wiederherstellung"};
	GDR_Skill["Magier"] = {"Arkan","Feuer","Frost"};
	GDR_Skill["Schamane"] = {"Elementar","Verst\195\164rkung","Wiederherstellung"};

	GDR_Hybride_text = "Hybrid";
end;

if (GetLocale() == "esES") then
	GDR_mon = "Mon";
	GDR_die = "Tue";
	GDR_mit = "Wed";
	GDR_don = "Thu";
	GDR_fre = "Fri";
	GDR_sam = "Sut";
	GDR_son = "Sun";
	GDR_Month = {};
	GDR_Month[1] = "January";
	GDR_Month[2] = "Febuary";
	GDR_Month[3] = "March";
	GDR_Month[4] = "April";
	GDR_Month[5] = "May";
	GDR_Month[6] = "June";
	GDR_Month[7] = "July";
	GDR_Month[8] = "August";
	GDR_Month[9] = "September";
	GDR_Month[10] = "October";
	GDR_Month[11] = "November";
	GDR_Month[12] = "December";

	GDR_All_Invite = "All Invite";
	GDR_MonthOverview = "Month Overview";
	GDR_DayOverview = "DayOverview";
	GDR_raid_note = "Note";
	GDR_raid_value = "Value";
	GDR_raid_raidleader = "Raidleader";
	GDR_raid_date = "Raid beginn";
	GDR_raid_date_invite = "Invite";
	GDR_raid_date_finish = "Raid stop";
	GDR_raid_attendees = "is apply";
	GDR_close = "exit";
	GDR_whisper = "Whisper";
	GDR_invite = "Invite";

	GDR_invite_text = {};
	GDR_invite_text[1] = "not invite";
	GDR_invite_text[2] = "invite";
	GDR_invite_text[3] = "offline";
	GDR_invite_text[4] = "grouped";
	GDR_invite_text[5] = "is in Raid";
	GDR_invite_text[6] = "has refuse an invitation";
	GDR_invite_text[7] = "leave Group";
	GDR_invite_text[8] = "in Raid Offline";

	GDR_class_groups = {};
	GDR_class_groups[1] = "Healer";
	GDR_class_groups[2] = "Tank";
	GDR_class_groups[3] = "Melee";
	GDR_class_groups[4] = "Range";

	GDR_subscribed = {};
	GDR_subscribed[1] = "Confirmed";
	GDR_subscribed[2] = "Signed";
	GDR_subscribed[3] = "Unsigned";
	GDR_subscribed[4] = "Not Sure";
	GDR_subscribed[5] = "Not Signed";
	GDR_subscribed[6] = "Not Available";

	GDR_skill = "Skill :";
	GDR_noskill = "No Skill found";
	GDR_Skill = {};
	GDR_Skill["Paladin"] = {"Holy","Protection","Retribution"};
	GDR_Skill["Rogue"] = {"Assassination","Combat","Subtlety"};
	GDR_Skill["Warrior"] = {"Arms","Fury","Protection"};
	GDR_Skill["Hunter"] = {"Beast Mastery","Marksmanship","Survival"};
	GDR_Skill["Priest"] = {"Discipline","Holy","Shadow"};
	GDR_Skill["Warlock"] = {"Affliction","Demonology","Destruction"};
	GDR_Skill["Druid"] = {"Balance","Feral Combat","Restoration"};
	GDR_Skill["Mage"] = {"Arcane","Fire","Frost"};
	GDR_Skill["Shaman"] = {"Elemental","Enhancement","Restoration"};

	GDR_Hybride_text = "Hybrid";
end;