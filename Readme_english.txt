#####################################################
# GetDKP Plus
# Authors: Charla, Corgan, WalleniuM, Sylna
# $LastChangedDate: 2009-03-09 17:16:25 +0100 (Mo, 09 Mrz 2009) $
# $LastChangedBy: sylna $
#####################################################

SUPPORT FORUM: http://www.eqdkp-plus.com/e107_plugins/forum/forum_viewforum.php?12

---------------------

-> English <- 
Description:
===============

Making DKP information available ingame is no longer a problem. 
The addon shows you the DKP points of all players who are in your EQDKP. You can selectively look for players, classes or armors. 
If you, for example, click on an item linked in the chat, you will see a tool tip displaying who has already received this item. 

There is an auction-module called "Bet and Win" to distribute your drops to your raid by using auctions. There are three differend rules for auctions at the moment. You can also announce the winner in the raidchat.

With LiveDKP your can modify the players DKP ingame during the raid to alway have an up to date list.

There is a config menu to make all your settings.

Features:
- supports MultiDKP
- supports special characters
- whisper somebody who has the addon and get your points whispered back!
- shows all items which have been entered into the EQDKP
- when clicking on an item linked in the chat, that has been entered into your EQDKP, a tool tip will open. It will display who as already received this item for how many points. For set item, you will also see who still needs this item. 
This information can then be posted in raid/group/guild chats. 
- shows all items and their DKP prices which are in your EQDKP. 
- search for item names
- search for items of players
- shows the drop chance of set items
- detailed display of item prices. For DKP systems with different item prices, min/max/avg prices are displayed
- class/armor whisper
- show only Players in Raid (Option)
- Hide outgoing Whisper
- Show Player from your Raid in the Tooltip, of an Setitem, even if they have no DKP. (if you have guests in your Raid)
- Whisper Requests for Players and Items are deactiv when you are in a fight.
- You can set a limit how much Player should displayed in the Toolip.
- All Options can be set in the TitanPanel !
- Add or subtract DKP Point from Player


Installation
===============

Just download and copy the folder Getdkp into your xxx\World of Warcraft\Interface\AddOns\ folder. 

Since WoW does not allow any direct access to files on the Internet or files on your hard drives, you need to update the points once prior to a raid. This works using the included batch file. You need to enter the paths to your WoW installation first. 

1. Unzip GetDKP.zip and copy the GetDKP folder into your /Interface/Addon folder. 
2. Use the DKP.EXE (inside the GetDKPData folder) to download the DKP information. You need to modify the path to your getdkp.php and to your WoW-Folder.
3. start the game

- after the first login to the game you should at first open the config menu "/gdc" and enter your settings.
  prior to every raid you should doublecheck if the correct account is selected when using MultiDKP.
  if your accounts are named as the instances you are raiding the account will be automatically changend when entering the instance.

Open Windows :
===============
/gdc opens the config menu
/gdl open the GetDKPList windows
/gdb opens the Bet and Win modul
  
Ingame commands:
===============
/gdc status									-> shows the configuration
/gdc info [chat/guild/raid/group]  			-> displays EQDKP information in the respective channel
/gdc help									-> shows this table
/gdc whisperdkp	[on/off]					-> turns off the whisper function for DKP points
/gdc whisperitems [on/off]					-> turns off the whisper function for items
/gdc whisperhide [on/off] 					-> Hide outgoing whisper when someone request DKP or Iteminformations 
/gdc buyerslimit xx 						-> Show only xx Buyers of an item. xx can by a number between 1 an 40. 0 = all
/gdc needlimit xx 							-> Show only xx Player with NEED of an item. xx can by a number between 1 an 40. 0 = all
/gdc reset  								-> this will reset all GETDKP Config Variables (Not the EQDKP Data !!)
/gdco [guild/group/chat/raid/officer] 		-> sets the chat the command /dkp will report to


LiveDKP
===============
/dkp+ [Spielername / Raid ] [DKP] [Kontoname]		-> Fügt dem Spieler (oder allen Spielern im Raid) xx Punkte hinzu
/dkp- [Spielername / Raid ] [DKP] [Kontoname]		-> Zieht dem Spieler (oder allen Spielern im Raid) xx Punkte ab

expamples:
/dkp+ Corgan 100 DKP1 - Add 100 DKP to Corgans DKP points in the account DKP1
/dkp- Corgan 100 DKP1 - Subtract 100 DKP from Corgans DKP points in the account DKP1
/dkp+ Raid 100 DKP1 - Add 100 DKP to all players in the Raid in the account DKP1

whisper commands:
===============

dkp	[account]	-> DKP points

example:
The player Corgan has GetDKP installed and you want to receive your dkp from him.
/w corgan dkp [kontoname]
============================================================================================
