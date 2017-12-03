# Addon-wow-GetDKP

SUPPORT
------------------
SUPPORT FORUM: https://eqdkp-plus.eu/forum/board/39-wow-getdkp/

Description:
------------------

Making DKP information available ingame is no longer a problem.
The Addon shows you the DKP points of all players who are in your EQDKP. You can selectively look for players, classes or armors.
If you, for example, click on an item linked in the chat, you will see a tool tip displaying who has already received this item.

There is an auction-module called "Bet and Win" to distribute your drops to your raid by using auctions. There are three different rules for auctions at the moment. You can also announce the winner in the raid chat.

With LiveDKP your can modify the players DKP ingame during the raid to alway have an up to date list.

There is a config menu to make all your settings.

Features
------------------
* supports MultiDKP
* supports special characters
* whisper somebody who has the Addon and get your points whispered back!
* shows all items which have been entered into the EQDKP
* when clicking on an item linked in the chat, that has been entered into your EQDKP, a tool tip will open. It will display who as already received this item for how many points. For set item, you will also see who still needs this item.
This information can then be posted in raid/group/guild chats.
* shows all items and their DKP prices which are in your EQDKP.
* search for item names
* search for items of players
* shows the drop chance of set items
* detailed display of item prices. For DKP systems with different item prices, min/max/avg prices are displayed
* class/armor whisper
* show only Players in Raid (Option)
* Hide outgoing Whisper
* Show Player from your Raid in the Tooltip, of an Setitem, even if they have no DKP. (if you have guests in your Raid)
* Whisper Requests for Players and Items are inactive when you are in a fight.
* You can set a limit how much Player should displayed in the Tooltip.
* All Options can be set in the TitanPanel !
* Add or subtract DKP Point from Player

Installation
------------------

### Requirements
* Installed WoW and getDKP AddOn
* jDKP (Multiplatform application for downloading the data of Eqdkp-Plus)

### jDKP
Download the latest version of jDKP from https://eqdkp-plus.eu/jdkp/. A documentation is available in german: https://eqdkp-plus.eu/wiki/JDKP

### General Installation
Just download and copy the folder GetDKP into your xxx\World of Warcraft\Interface\AddOns\ folder.

Since WoW does not allow any direct access to files on the Internet or files on your hard drives, you need to update the points once prior to a raid. This works using jDKP, a downloader App written in Java. You need to enter the paths to your WoW installation first.

1. Unzip GetDKP.zip and copy the GetDKP folder into your /Interface/Addon folder.
2. Download jDKP to download the Information. Follow the instructions shown in the UI of jDKP.
3. start the game

* after the first login to the game you should at first open the config menu "/gdc" and enter your settings. Prior to every raid you should double check if the correct account is selected when using MultiDKP. If your accounts are named as the instances you are raiding the account will be automatically changed when entering the instance.

Commands
------------------

### Open Windows

Command  | Description
------------ | -------------
/gdc | opens the config menu
/gdl | open the GetDKPList windows
/gdb | opens the Bet and Win modul

### Ingame commands:

Command  | Description | Parameters
------------ | -------------  | -----------
/gdc status | shows the configuration | --
/gdc info [Parameter] | displays EQDKP information in the respective channel  | chat/guild/raid/group
/gdc help | shows this table | --
/gdc whisperdkp	[Parameter] | turns off the whisper function for DKP points  | on/off
/gdc whisperitems [Parameter] | turns off the whisper function for items  | on/off
/gdc whisperhide [Parameter] | Hide outgoing whisper when someone request DKP or Item-information | on/off
/gdc buyerslimit [Parameter] | Show only xx Buyers of an item  | integer between 1 an 40. 0 = all
/gdc needlimit [Parameter] | Show only xx Player with NEED of an item.  | integer between 1 an 40. 0 = all
/gdc reset | this will reset all GETDKP Config Variables (Not the EQDKP Data !!)
/gdco [Parameter] | sets the chat the command /dkp will report to | guild/group/chat/raid/officer

### LiveDKP
Command  | Description | Parameter 1 | Parameter 2 | Parameter 3
------------ | ------------- | ----------- | ----------- | -----------
/dkp+ [Parameter 1] [Parameter 2] [Parameter 3] | Add a defined amount of DKP from a player (or all players) of a raid | Charname/Raid | Amount of DKP | Accountname
/dkp- [Parameter 1] [Parameter 2] [Parameter 3] | Subtract a defined amount of DKP from a player (or all players) of a raid | Charname/Raid | Amount of DKP | Accountname

expamples:
Command  | Description
------------ | -------------
/dkp+ Corgan 100 DKP1 | Add 100 DKP to Corgans DKP points in the account DKP1
/dkp- Corgan 100 DKP1 | Subtract 100 DKP from Corgans DKP points in the account DKP1
/dkp+ Raid 100 DKP1 | Add 100 DKP to all players in the Raid in the account DKP1

###whisper commands:

Command  | Description | Parameters
------------ | ------------- | -------------
dkp	[Parameter] | DKP points | account

example:
Command  | Description
------------ | -------------
/w corgan dkp [kontoname] | The player Corgan has GetDKP installed and you want to receive your DKP from him.
