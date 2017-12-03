#####################################################
# GetDKP Plus
# Authors: Charla, Corgan, WalleniuM, Sylna
#####################################################

SUPPORT FORUM: https://eqdkp-plus.eu/forum/board/38-wow-getdkp/

---------------------

-> German <-
Beschreibung:
===============

DKP Informationen ingame verfügbar machen, ist jetzt kein Problem mehr.
Das Addon zeigt euch die DKP Punkte und alle Items aller Spieler in einem Fenster an, die in eurem EQDKP enthalten sind. Ihr könnt in diesem Fenster nach Klassen, Namen, Dropgruppen, Rüstungsgruppen filtern sowie geziehlt nach einem oder mehreren Spielern suchen. Ihr könnt sowohl die DKPs wie auch die Items der Spieler über die Fenster in einem beliebigen chat ausgeben lassen. Es wird bei Items die im chat gelinkt sind ein tooltip angezeigt wo enthalten ist wer das Item schon besitzt und wer es noch braucht, natürlich werden dort auch die dkps mit angezeigt und alle Tooltiplisten können auch wieder in einem chat ausgegeben werden.

Dazu biete euch GetDKP auch ein Versteigerungsmodul "Bet and Win" an, mit dem ihr in verschiedenen vorgegebenen regeln eure Items versteigern könnt und direkt seht wer wieviel geboten hatt und wieviel DKP dieser noch hat. Man kann dann auch noch direkt den Gewinner per Knopfdruck im Chat ausgeben.

Mit dem LIVEDKP könnt ihr nun im Raid einzelnen Spielern oder auch dem ganzen Raid DKPs geben oder auch abziehen.

Es gibt ein Konfigurationsmenu wo ihr alle einstellung vornehmen könnt.


Features:
- Unterstützt voll MultiDKP
- Unterstützt Umlaute wie (äöü usw)
- Flüstert jemand mit dem Addon an und bekommt sofort eure Punkte zurück !
- Zeigt alle Items an die im EQDKP eingetragen wurden.
- Bei Klick auf ein im Chat gelinktes Item öffnet sich ein weiterer Tooltip. In diesem wird angezeigt, wer dieses Item schon für wieviele Punkte bekommen hat.
  Bei Setitems wird außerdem angezeigt wer dieses Item noch braucht.
  Diese Informationen können dann in den Raid/Gruppen/Gildenchat gepostet werden.
- Zeigt alle Items und deren DKP Preise die in eurem EQDKP eingetragen sind.
- Detailanzeige über Itempreise. Bei DKP System mit unterschiedlichen Itempreisen werden die Min/Max/AVG Preise angezeigt
- Wenn die Option gesetzt ist, werden nur Spieler im Raid angezeigt.
- Ausgehende Flüsterer (z.B. Spieler oder Itemsuche) werden nicht mehr angezeigt
- Es werden auch Spieler im Tooltip angezeigt, die keine DKP Punkte haben, sich aber im Raid befinden.
- Flüsterer nach Spieler oder Items sind jetzt im Kampf abgeschaltet und Lags zu verhindern.
- Die Anzahl der auszugebenen Spieler die noch Bedarf auf ein Item haben, oder die ein Item schon bestizen kann begrentzt werden.
- Ihr könnt während eines Raids DKP Punkte von Spielern ändern.
- Minimap Icon zum Öffnen des Konfigurationsmenu oder des GetDKPList Fenster

LiveDKP
===============
Mit diesen Funktionen bleibt ihr wärend eines Raid immer auf dem aktuellen Stand.
Als normaler Spieler müsst ihr nichts weiter konfigurieren.

Lootmaster bzw CT Raidtracker Lootmaster:
Wenn ihr wärend eines Raid im Raidtracker auf edit Notes eines Items klickt könnt ihr dort die Punkte eintragen, die dem Spieler abgezogen werden sollen.
z.B. ein Spieler bekommt ein Item für 100 DKP. Dann tragt ihr in die Notes "100 DKP" ein. Wichtig dabei ist, das "DKP" groß geschrieben wird.
Wenn ihr multiDKP mit mehreren Konten habt habt, dann muss die Note "100 DKP Kontoname" heißen. kontoname ist der name den ihr im eqdkp dem jeweiligen konto gegeben habt.
Der Spieler der diese Eintr�ge im Raidtracker macht, MUSS ein A haben oder Raidleiter sein und zusätzlich /dkp livedkp on aktiviert haben. (default = on)
Wenn die Note im Raidtracker eingetragen wurde, wird im Raidchat darauf hingewiesen. Bei allen Spielern die GetDKP 4.0.1 (oder höher) installiert haben werden
die Punkte jetzt automatisch abgezogen. Die Veränderungen an den Punkten werden solange gespeichert (auch beim umloggen und zwischen Sessions) bis die
DKP Daten erneut von eurem EQDKP aktualisiert werden.

Der Lootmaster (oder berechtigter Spieler) kann außerdem gezielt einzelnen Spielern oder dem ganzen Raid Punkte abziehen bzw. hinzufügen.
Befehle dazu weiter unten.

für hilfe einfach /gdc help eingeben.

Installation
===============

Einfach runterladen und den Ordner Getdkp in euren xxx\World of Warcraft\Interface\AddOns\ ordner kopieren.

Da WoW leider keinen direkten Zugriff auf Dateien im Internet oder Dateien auf der Festplatte erlaubt, muss man vor einem Raid die Punkte einmal abrufen.
Dies funktioniert über die Datei DKP.EXE, die mit beiligt. In dieser müsst ihr die Pfade zu WoW und zu eurem EQDKP richtig eintragen.

1. Entpackt die GetDKP.zip und kopiert den GetDkp Ordner in euren /Interface/Addon Ordner
2. Benutzt das Programm DKP.EXE (im GetDKPData-Ordner) um die DKP Informationen runterzuladen. Passt dazu den Path zu eurer getdkp.php und eurem WOW Ordner an.
3. Startet das Spiel

- nach dem ersten einloggen solltet ihr als erstes mal das Konfigurationsmenü öffnen "/gdc" und dort eure einstellungen vornehmen.
  Vor jedem Raid ist darauf zu achten das im Konfigurationsmenü immer das richtige Konto eingetragen ist.
  Sollte ihr die beschreibung des kontos den Instanznamen gleichgesetzt haben so wird bei betreten der Instanz automatisch das konnto geändert.

Fenster öffnen :
===============
/gdc Öffnet das Konfigurationsmenü
/gdl Öffnet das GetDKPList Fenster
/gdb Öffnet das Versteigerungmodul Bet and Win

Befehle ingame:
===============
/gdc status									-> Zeigt die Konfiguration
/gdc info [chat/gilde/raid/gruppe] 			-> Gibt EQDKP Informationens im jeweiligen Channel aus.
/gdc help									-> Zeigt diese Tabelle
/gdc whisperdkp [on/off]					-> Schaltet die Flüsterfunktion für DKP Punkte ab
/gdc whisperhide [on/off] 					-> Wenn aktiv, werden ausgehende Fl�sterer nicht mehr angezeigt, wenn z.B. jemand seine Punkte abfragt.
/gdc buyerslimit xx 						-> Beschr�nkt die Anzahl der angezeigten Spieler die ein Item schon besitzen. xx muss eine Zahl zwischen 1 und 40 sein. 0 = alle
/gdc needlimit xx 							-> Beschr�nkt die Anzahl der angezeigten Spieler die ein Item noch nicht besitzen. xx muss eine Zahl zwischen 1 und 40 sein. 0 = alle
/gdc reset  								-> Setzt alle GETDKP Variablen auf einen Defaultwert
/gdco [gilde/gruppe/chat/raid/offizer] 		-> setzt den Ausgabechat für den Befehl /dkp

LiveDKP
===============
/dkp+ [Spielername / Raid ] [DKP] [Kontoname]		-> Fügt dem Spieler (oder allen Spielern im Raid) xx Punkte hinzu
/dkp- [Spielername / Raid ] [DKP] [Kontoname]		-> Zieht dem Spieler (oder allen Spielern im Raid) xx Punkte ab


Beispiele:
/dkp+ Corgan 100 DKP1 - Addiere 100 Punkte zu Corgans DKP Punkten auf dem Konto DKP1
/dkp- Corgan 100 DKP1 - Zieht 100 Punkte von Corgans DKP Punkten auf dem Konto DKP1 ab
/dkp+ Raid 100 DKP1 - Addiere 100 Punkte auf die Punkte aller Spieler im Raid für das Konto DKP1


Whisperbefehle:
===============

dkp	[kontoname]	-> DKP Punkte

Beispiel:
Der Spieler Corgan hat GetDKP installiert und ihr wollt von ihm erfahren wieviele Punkte ihr habt.
/w corgan dkp [kontoname]
============================================================================================
