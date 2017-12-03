TITAN_GETDKP_CLASS = {};
TITAN_GETDKP_MENU_TEXT = 					"GetDKP";
TITAN_GETDKP_TOOLTIP = 						"GetDKP";
TITAN_GETDKP_DISPLAY_NONE = 				"Display none";
TITAN_GETDKP_CAT_ACCOUNT = 					"Account";
TITAN_GETDKP_CAT_CLASS = 					"Class";
TITAN_GETDKP_CAT_Special_Class =			"Special Class";

TITAN_GETDKP_CLASS[1]  = 					"Priest";
TITAN_GETDKP_CLASS[2]  = 					"Druid";
TITAN_GETDKP_CLASS[3]  = 					"Warrior";
TITAN_GETDKP_CLASS[4]  = 					"Paladin";
TITAN_GETDKP_CLASS[5]  = 					"Mage";
TITAN_GETDKP_CLASS[6]  = 					"Rouge";
TITAN_GETDKP_CLASS[7]  = 					"Shaman";
TITAN_GETDKP_CLASS[8]  = 					"Hunter";
TITAN_GETDKP_CLASS[9]  = 					"Warlock";
TITAN_GETDKP_CLASS[10]  = 					"Rouge,Paladin,Shaman";
TITAN_GETDKP_CLASS[11]  =					"Warrior,Priest,Druid";
TITAN_GETDKP_CLASS[12]  = 					"Hunter,Warlock,Mage";
TITAN_GETDKP_CLASS[13]  =					"Paladin,Warlock,Priest";
TITAN_GETDKP_CLASS[14]  =					"Warrior,Hunter,Shaman";
TITAN_GETDKP_CLASS[15]  =					"Druid,Mage,Rouge";
TITAN_GETDKP_CLASS[16]  =					"Paladin,Warrior";
TITAN_GETDKP_CLASS[17]  =					"Shaman,Hunter";
TITAN_GETDKP_CLASS[18]  = 					"Druid,Rouge";
TITAN_GETDKP_CLASS[19]  = 					"Priest,Mage,Warlock";
if (GetLocale() == "deDE") then
	TITAN_GETDKP_MENU_TEXT = 				"GetDKP";
	TITAN_GETDKP_TOOLTIP = 					"GetDKP";
	TITAN_GETDKP_DISPLAY_NONE = 			"Keine Anzeige";
	TITAN_GETDKP_CAT_ACCOUNT = 				"Konto";
	TITAN_GETDKP_CAT_CLASS = 				"Klassen";
	TITAN_GETDKP_CAT_Special_Class = 		"Spezial Klassen";
	TITAN_GETDKP_CLASS[1] = 				"Priester";
	TITAN_GETDKP_CLASS[2] = 				"Druide";
	TITAN_GETDKP_CLASS[3] = 				"Krieger";
	TITAN_GETDKP_CLASS[4] = 				"Paladin";
	TITAN_GETDKP_CLASS[5] = 				"Magier";
	TITAN_GETDKP_CLASS[6] = 				"Schurke";
	TITAN_GETDKP_CLASS[7] = 				"Schamane";
	TITAN_GETDKP_CLASS[8] = 				"J\195\164ger";
	TITAN_GETDKP_CLASS[9] = 				"Hexenmeister";
	TITAN_GETDKP_CLASS[10] = 				"Schurke,Paladin,Schamane";
	TITAN_GETDKP_CLASS[11] =				"Krieger,Priester,Druide";
	TITAN_GETDKP_CLASS[12] = 				"J\195\164ger,Hexenmeister,Magier";
	TITAN_GETDKP_CLASS[13] =				"Paladin,Hexenmeister,Priester";
	TITAN_GETDKP_CLASS[14] =				"Krieger,J\195\164ger,Schamane";
	TITAN_GETDKP_CLASS[15] =				"Druide,Magier,Schurke";
	TITAN_GETDKP_CLASS[16] =				"Paladin,Krieger";
	TITAN_GETDKP_CLASS[17] =				"Schamane,J\195\164ger";
	TITAN_GETDKP_CLASS[18] = 				"Druide,Schurke";
	TITAN_GETDKP_CLASS[19] = 				"Priester,Magier,Hexenmeister";
end;




--------  Preferences --------------

TITAN_GETDKP_CLASSES = {
	{ class = "Priest",			name = TITAN_GETDKP_CLASS[1],	 	format = "+%d",		short = "PPRIST",		cat = "CLASS" },
	{ class = "Druid",			name = TITAN_GETDKP_CLASS[2], 		format = "+%d",		short = "DDRUID",		cat = "CLASS" },
	{ class = "Warrior",		name = TITAN_GETDKP_CLASS[3], 		format = "+%d",		short = "WWARRIOR",		cat = "CLASS" },
	{ class = "Paladin",		name = TITAN_GETDKP_CLASS[4], 		format = "+%d",		short = "NPALADIN",		cat = "CLASS" },
	{ class = "Mage",			name = TITAN_GETDKP_CLASS[5],	 	format = "+%d",		short = "MMAGE",		cat = "CLASS" },
	{ class = "Rouge",			name = TITAN_GETDKP_CLASS[6],	 	format = "+%d",		short = "RROUGE",		cat = "CLASS" },
	{ class = "Shaman",			name = TITAN_GETDKP_CLASS[7],	 	format = "+%d",		short = "SSHAMAN",		cat = "CLASS" },
	{ class = "Hunter",			name = TITAN_GETDKP_CLASS[8],	 	format = "+%d",		short = "HHUNTER",		cat = "CLASS" },
	{ class = "WARLOCK",		name = TITAN_GETDKP_CLASS[9],	 	format = "+%d",		short = "AWARLOCK",		cat = "CLASS" },
	
	
	{ class = "Special Class1",		name = "T5 = "..TITAN_GETDKP_CLASS[10],		format = "+%d",		short = "SC1",		cat = "Special_Class" },
	{ class = "Special Class2",		name = "T5 = "..TITAN_GETDKP_CLASS[11], 	format = "+%d",		short = "SC2",		cat = "Special_Class" },
	{ class = "Special Class3", 	name = "T5 = "..TITAN_GETDKP_CLASS[12], 	format = "+%d",		short = "SC3",		cat = "Special_Class" },
	{ class = "Special Class4",		name = "T6 = "..TITAN_GETDKP_CLASS[13], 	format = "+%d",		short = "SC4",		cat = "Special_Class" },
	{ class = "Special Class5",		name = "T6 = "..TITAN_GETDKP_CLASS[14],		format = "+%d",		short = "SC5",		cat = "Special_Class" },
	{ class = "Special Class6",		name = "T6 = "..TITAN_GETDKP_CLASS[15],		format = "+%d",		short = "SC6",		cat = "Special_Class" },
	{ class = "Special Class7",		name = "T3 = "..TITAN_GETDKP_CLASS[16], 	format = "+%d",		short = "SC7",		cat = "Special_Class" },
	{ class = "Special Class8", 	name = "T3 = "..TITAN_GETDKP_CLASS[17], 	format = "+%d",		short = "SC8",		cat = "Special_Class" },
	{ class = "Special Class9",		name = "T3 = "..TITAN_GETDKP_CLASS[18], 	format = "+%d",		short = "SC9",		cat = "Special_Class" },
	{ class = "Special Class10",	name = "T3 = "..TITAN_GETDKP_CLASS[19],		format = "+%d",		short = "SC10",		cat = "Special_Class" },
	
	};
TITAN_GETDKP_CATEGORIES = {'ACCOUNT','CLASS', 'Special_Class'};

TitanGETDKP_colors = {
	W = 'c79c6e',  -- Warrior
	M = '69ccf0',  -- Mage
	R = 'fff569',  -- Rouge
	D = 'ff7d0a',  -- Druid
	H = 'abd473',  -- Hunter
	S = '00dbba',  -- Shaman
	P = 'ffffff',  -- Priest
	A = '9482ca',  -- Warlock
	N = 'f58cba',  -- Paladin
	
};
TITAN_GETDKP_CLASS_TRANS = {};
TITAN_GETDKP_CLASS_TRANS [1] = "Priest,Priester";
TITAN_GETDKP_CLASS_TRANS [2] = "Druid,Druide";
TITAN_GETDKP_CLASS_TRANS [3] = "Warrior,Krieger";
TITAN_GETDKP_CLASS_TRANS [4] = "Paladin";
TITAN_GETDKP_CLASS_TRANS [5] = "Mage,Magier";
TITAN_GETDKP_CLASS_TRANS [6] = "Rouge,Schurke";
TITAN_GETDKP_CLASS_TRANS [7] = "Shaman,Schamane";
TITAN_GETDKP_CLASS_TRANS [8] = "Hunter,J\195\164ger";
TITAN_GETDKP_CLASS_TRANS [9] = "Warlock,Hexenmeister";
TITAN_GETDKP_CLASS_TRANS [10] = "Rouge,Paladin,Shaman,Schurke,Paladin,Schamane";
TITAN_GETDKP_CLASS_TRANS [11] = "Warrior,Priest,Druid,Krieger,Priester,Druide";
TITAN_GETDKP_CLASS_TRANS [12] = "Hunter,Warlock,Mage,J\195\164ger,Hexenmeister,Magier";
TITAN_GETDKP_CLASS_TRANS [13] = "Paladin,Warlock,Priest,Paladin,Hexenmeister,Priester";
TITAN_GETDKP_CLASS_TRANS [14] = "Warrior,Hunter,Shaman,Krieger,J\195\164ger,Schamane";
TITAN_GETDKP_CLASS_TRANS [15] = "Druid,Mage,Rouge,Druide,Magier,Schurke";
TITAN_GETDKP_CLASS_TRANS [16] = "Paladin,Warrior,Paladin,Krieger";
TITAN_GETDKP_CLASS_TRANS [17] = "Shaman,Hunter,Schamane,J\195\164ger";
TITAN_GETDKP_CLASS_TRANS [18] = "Druid,Rouge,Druide,Schurke";
TITAN_GETDKP_CLASS_TRANS [19] = "Priest,Mage,Warlock,Priester,Magier,Hexenmeister";


