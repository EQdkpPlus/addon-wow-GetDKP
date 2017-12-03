#####################################################
# GetDKP Plus
# Autores: Charla, Corgan, WalleniuM, Sylna
# $Cambiado por última vez: 2009-03-09 17:16:25 +0100 (lun, 09 mar 2009) $
# $Último cambio por: sylna $
#####################################################

Foro de soporte: http://www.eqdkp-plus.com/e107_plugins/forum/forum_viewforum.php?12

---------------------

-> Español <- 
Description:
===============

Hacer que la información de los DKP esté en el juego ya no será un problema.
El addon muestra los puntos DKP de todos los jugadores que estén en tu EQDKP. Puede buscar jugadores, clases o armaduras.
Si tu, por ejemplo, haces click en un objeto que aparece en el chat verás un tooltip mostrando quién ha recibido ya este objeto.

Hay un módulo de subasta llamado "Bet and Win" para distribuir el botín en tu banda a través de subastas. Hay 3 reglas diferentes para subastas por el momento. También puedes anunciar el ganador en el chat de la banda

Con LiveDKP puedes modificar los DKP de los jugadores dentro del juego durante la banda para tener la lista siempre actualizada.

Hay un menú de configuración para que puedas ajustarlo a tus necesidades.

Características:
- soporte para MultiDKP
- soporte para personajes especiales
- ¡susurra a alguien que tenga el addon y obtén tus DKP!
- muestra todos los objetos que han sido introducidos en EQDKP
- al hacer click en un objeto que se haya puesto en el chat y haya sido introducido en el EQDKP, aparecerá un tooltip. Mostrará quién ha recibido este objeto y por cuantos puntos. También verás quien necesita este objeto aún.
Esta información se puede poenr en los canales de banda/grupo/hermandad.
- muestra todos los objetos y sus precios en DKP que están en tu EQDKP. 
- búsqueda por nombre de objetos
- búsqueda por objetos de jugadores
- muestra la posibilidad de obtener un conjunto de objetos
- muestra detallada de los precios de objetos. Para sistemas DKP con distintos precios de objetos, se mostrarán min/max/media de los precios
- susurro de clase/armadura
- Opción para mostrar sólo los jugadores en Banda
- Ocultar los susurros realizados
- Mostrar jugador de tu banda en el Tooltip de un Objeto incluso si no tienen DKP (si tienes invitados en la banda)
- Peticiones de susurros para jugadores y objetos están desactivadas cuando estás en un combate
- Puedes establecer un límite de cuantos jugadores deberían mostrarse en el Tooltip.
- ¡Todas las opciones se pueden poner en TitanPanel!
- Añadir o quitar puntos DKP a un jugador


Instalación
===============

Descarga y copia la carpeta de GetDKP en tu carpeta xxx\World of Warcraft\Interface\AddOns\ . 

Teniendo en cuenta que WoW no permite ningún acceso de los archivos a Internet o a archivos de tu disco duro, tienes que actualizar los puntos una vez antes de una banda. Esto funciona usando el archivo incluido. Debes introducir las rutas en tu instalación primero.

1. Descomprime GetDKP.zip y copia la carpeta GetDKP en tu carpeta /Interface/Addon . 
2. Usa el DKP.EXE (dentro de la carpeta GetDKP) para descargar la información de los DKP. Tienes que modificar la ruta para que enlace con el archivo getdkp.php y tu carpeta de WoW.
3. Inicia el juego

- Tras el primer inicio de sesión tendrás que abrir el menú de configuración "/gdc" e introducir tus ajustes. Antes de cada banda deberías revisar si se ha seleccionado la cuenta correcta cuando se use MultiDKP. Si tus cuentas están nombradas como las bandas que estás haciendo, la cuenta será automáticamente cambiada al entrar en la estancia.

Abrir Ventana :
===============
/gdc abre el menú de configuración
/gdl abre la ventana de GetDKPList
/gdb abre el módulo de Bet and Win
  
Comandos dentro del juego:
===============
/gdc status									-> muestra la configuración
/gdc info [chat/guild/raid/group]  			-> muestra la información de EQDKP en el canal respectivo
/gdc help									-> muestra esta tabla
/gdc whisperdkp	[on/off]					-> desactiva/activa la función de susurro de los puntos DKP
/gdc whisperitems [on/off]					-> desactiva/activa la función de susurro de los objetos
/gdc whisperhide [on/off] 					-> Oculta los susurros salientes cuando alguien solicita información de DKP o de Objetos
/gdc buyerslimit xx 						-> Muestra sólo XX compradores de un objeto. XX puede ser un número entre 1 y 40. 0 = todos
/gdc needlimit xx 							-> Muestra sólo XX jugadores con NECESIDAD de ese objeto. XX puede ser un número entre 1 y 40. 0 = todos
/gdc reset  								-> Esto restaurará la configuración de EQDKP (¡¡No los datos de EQDKP!!)
/gdco [guild/group/chat/raid/officer] 		-> establece el canal donde se pondrán los reportes de /dkp


LiveDKP
===============
/dkp+ [Spielername / Raid ] [DKP] [Kontoname]		-> Fügt dem Spieler (oder allen Spielern im Raid) xx Punkte hinzu
/dkp- [Spielername / Raid ] [DKP] [Kontoname]		-> Zieht dem Spieler (oder allen Spielern im Raid) xx Punkte ab

Ejemplo:
/dkp+ Belelros 100 DKP1 - Añade 100 puntos DKP a Belelros en la cuenta DKP1
/dkp- Belelros 100 DKP1 - Resta 100 DKP de los puntos de Belelros en la cuenta DKP1
/dkp+ Raid 100 DKP1 - Añade 100 puntos DKP a todos los jugadores en la banda en la cuenta DKP1

Susurros:
===============

dkp	[account]	-> Puntos DKP

Ejemplo:
El jugador Belelros tiene GetDKP instalado y quieres que te diga cuantos DKP tienes. /w Belelros dkp[nombre de cuenta]
============================================================================================
