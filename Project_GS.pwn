/*
    ##########  ##########  ###         ########
     ##########  ##########  ###         #########
      ###         ###    ###  ###         ###    ###
       ###         ###    ###  ###         ###    ###
        ###  #####  ###    ###  ###         ###    ###
         ###  #####  ###    ###  ###         ###    ###
          ###    ###  ###    ###  ###         ###    ###
           ###    ###  ###    ###  ###         ###    ###
            ##########  ##########  ##########  ##########
             ##########  ##########  ##########  #########
               ##########  ##########  ##########  ###                ###  ##########  ##########
                ##########  ##########  ##########   ###              ###   ##########  ##########
			     ###         ###         ###    ###    ###            ###    ###         ###    ###
	              ###         ###         ###    ###     ###          ###     ###         ###    ###
                   ##########  ##########  ##########      ###        ###      ##########  ##########
                    ##########  ##########  ##########       ###      ###       ##########  ##########
					        ###  ###         ### ###           ###    ###        ###         ### ###
					         ###  ###         ###  ###           ###  ###         ###         ###  ###
                       ##########  ##########  ###   ###           ######          ##########  ###   ###
                        ##########  ##########  ###    ###           ####           ##########  ###    ###
	+-----------------------+   +-----------------------+   +-----------------------+	+-----------------------+
	|                       |   |                       |   |                       |	|                       |
	|     Autor: Xerxes     |   |       MySQL: TAK      |   |        Kontakt:       |	|       Właściciel:     |
	|      (CC by NC)       |   |       File: NIE       |   |                       |	|                       |
	|                       |   |     Streamer: TAK     |   |	 wejer-mati@o2.pl   |   |       GoldServer      |
	| Zakaz usuwania autora |   |       OD 0: TAK       |   |                       |   |                       |
	|                       |   |     				    |   |                       |   |                       |
	+-----------------------+   +-----------------------+   +-----------------------+   +-----------------------+
*/
#include <a_samp>
#undef MAX_PLAYERS
#define MAX_PLAYERS 150
#include <foreach>
#include <mysql>
#include <zcmd>
#include <sscanf2>
#include <streamer>
#include "GoldServer/OPSP"
#include "GoldServer/MD5"
#include "GoldServer/GVC"
#include "../include/gl_common.inc"
// Ustawienia
#define VERSION "v1.3.3"
#define SERVER_IP "178.19.108.158"
#define SERVER_PORT "8109"
#define AUTHOR_NICK "Xerxes"
#define HOSTNAME "[PL] •••••••••••••• GoldServer™ •••••••••••••• ®"
#define MAPNAME "• GoldAndreas •"
#define WWW "www.GoldServer.sa-mp.pl"
// MySQL
#define SQL_HOST "178.19.108.154"
#define SQL_USER "z"
#define SQL_PASS "z"
#define SQL_DBNM "z"
// Limity
#define MAX_ENTRANCES 5
#define MAX_HOUSES 199
#define MAX_PRIVATE_VEHICLES 200
#define MAX_BIZNES 20
#define MAX_GANGS 20
#define MAX_GANG_MEMBERS 20
#undef MAX_GANG_ZONES
#define MAX_GANG_ZONES 20
// Ustawienia
#define PREFIX "GS_"
#define SERVER_TAG "[GS]"
#define DRIFT_SPEED 75
#define DRIFT_ANGLE 28
#define MAX_DRIFT_COMBO 5
#define IP_LIMIT 2
#define SAME_IP_CONNECT 4 
#define Time_Limit 3500
// Kolory
#define C_ERROR 0xF01414FF
#define C_GREEN 0x28DC28FF
#define C_GANG 0x3CE6FFFF
#define C_RED 0xCC0000FF
#define C_GREY 0xBEBEBEFF
#define JasnoNiebieski 0x33CCFFFF
#define C_YELLOW 0xFFFF00FF
#define C_ORANGE 0xFFB400FF
#define C_CB 0xD2BE6EFF
#define C_VIP 0x1EFF1EFF
#define C_WHITE 0xFFFFFFFF
#define CWARN 0xFF4444FF
#define C_INVISIBLE 0xFFFFFF00
#define C_NORMAL_PLAYER 0xFF4444FF
#define C_LIGHT_BLUE 0x33CCFFFF
#define C_RASPBERRY 0xFF2263FF
#define C_LIGHT_ORANGE 0xFF9900FF
#define C_NGANG 0xB7B7F6F6
#define C_LIGHTRED 0xFF0000FF
#define C_BLACK 0x000000FF
#define C_DESCRIPTION 0x4169E1FF
#define C_BLUE 0x0080C0FF
#define C_PINK 0xFF66FFFF
#define C_LIGHTBLUE 0x33CCFFAA
#define C_LIGHTGREEN 0x00FF00FF
#define C_VIOLET 0x9955DEFF
#define C_BROWN 0x8F4747FF
#define C_KREM 0xFF8080FF
#define W "{FFFFFF}"
#define B "{00AAFF}"
#define B2 "{006DA3}"
#define G "{28DC28}"
#define G2 "{199C19}"
#define Y "{FFFF00}"
#define R "{C92020}"
#define R2 "{EB0000}"
#define E "{FF0000} *"
#define I "{FFFF00} *"
#define WI "{FFFFFF} *"
#define WE "{FFFFFF} *"
#define GUI "{a9c4e4}"
#define GUI2 "{dedfde}"
#define O "{FFB300}"
#define RED "{FF0000}"
// Dialogi
#define D_NONE 1
#define D_REGISTER 2
#define D_LOGIN 3
#define D_SETNICK 4
#define D_SETPASS 5
#define D_CONFIRM_SETNICK 6
#define D_CONFIRM_SETPASS 7
#define D_RCON 8
#define D_ACMD 9
#define D_ACMD_1 10
#define D_ACMD_2 11
#define D_ACMD_3 12
#define D_ACMD_1_2 13
#define D_POMOC 14
#define D_CMD 15
#define D_TELES 16
#define D_MCMD 17
#define D_ANIMS 18
#define D_VIP 19
#define D_KUPNO_VIP 20
#define D_VCMD 21
#define D_VINFO 22
#define D_AUTHOR 23
#define D_ATRAKCJE 24
#define D_PANELTD 25
#define D_KONTO 26
#define D_REGULAMIN 27
#define D_CARS 28
#define D_SALONY 29
#define D_MOTORY 30
#define D_ROWERY 31
#define D_KABRIOLETY 32
#define D_DOSTAWCZE 33
#define D_LOWRIDERY 34
#define D_TERENOWE 35
#define D_PUBLICZNE 36
#define D_SPORTOWE 37
#define D_COMBI 38
#define D_LODZIE 39
#define D_SAMOLOTY 40
#define D_UNIKALNE 41
#define D_RC 42
#define D_TUNE 43
#define D_TUNE2 44
#define D_TUNE3 45
#define D_TUNE4 46
#define D_POGODA 47
#define D_STYLEWALKI 48
#define D_RADIO 49
#define D_BRONIES 50
#define D_BRONIES_CP 51
#define D_BANK 52
#define D_WPLAC 53
#define D_WYPLAC 54
#define D_STAN 55
#define D_PRZELEW 56
#define D_PRZELEW2 57
#define D_STAN2 58
#define D_OSIAGNIECIA_1 59
#define D_SHOW_ACHIEVEMENT_1 60
#define D_STATY 61
#define D_SHOW_STATY 62
#define D_STATY_PANEL 64
#define D_PLAYER 65
#define D_TP 66
#define D_SOLO 67
#define D_TUTORIAL 68
#define D_WEAPON 69
#define D_TOP 70
#define D_TLUMIK 71
#define D_LASER 72
#define D_NBRONIE 73
#define D_NEONY 74
#define D_AUTO 75
#define D_SILNIK 76
#define D_SWIATLA 77
#define D_DRZWI 78
#define D_MASKA 79
#define D_BAGAZNIK 80
#define D_TABLICA_TEXT 81
#define D_ALARM 82
#define D_ARENY 83
#define D_HOUSE_NIEKUPIONY 84
#define D_HOUSE_KUPIONY_OWNER 85
#define D_HOUSE_KUPIONY 86
#define D_CREATE_HOUSE 87
#define D_SPAWN_HOUSE 88
#define D_CZYNSZ_HOUSE 89
#define D_CONFIRM_CZYNSZ_HOUSE 90
#define D_SELLHOUSE 91
#define D_WAZNOSC_HOUSE 92
#define D_PVEH 93
#define D_PVEH_CONTROL 94
#define D_CONFIRM_PVEH 95
#define D_SETCAR 96
#define D_CONFIRM_SETCAR 97
#define D_TEST 98
#define D_BIZNES_NIEKUPIONY 99
#define D_BIZNES_KUPIONY_OWNER 100
#define D_BIZNES_KUPIONY 101
#define D_BIZNES_NAZWA 102
#define D_BIZNES_KASA 103
#define D_WYSLIJ_KASE 104
#define D_PORTFEL 105
#define D_INFO_PORTFEL 106
#define D_VGRANATY 107
#define D_RAPORT 108
#define D_WYBOR_ROOM 109
#define D_ROOM 110
#define D_BRONIE_WG 111
#define D_BRONIE_WG2 112
#define D_OSIAGNIECIA_2 113
#define D_SHOW_ACHIEVEMENT_2 114
#define D_OSIAGNIECIA_3 115
#define D_SHOW_ACHIEVEMENT_3 116
//#define D_MAIL 117
//#define D_MAIL2 118
//#define D_MAIL3 119
#define D_KWOTY_PORTFEL 120
#define D_KWOTY_INFO_PORTFEL 121
#define D_CMDS_1 122
#define D_CMDS_2 123
#define D_CONFIRM_CZYNSZ_HOUSE_PORTFEL 124
#define D_EXP 125
#define D_INFO_EXP 126
#define D_PRZELEW_EXP 127
#define D_PRZELEW_EXP2 128
#define D_STATY_TOP 129
#define D_CONTROL_GANG 130
#define D_CONTROL_GANG_VICE 131
#define D_CONTROL_GANG_SZEF 132
#define D_MENU_GANG 133
#define D_SHOW_GANGS 134
#define D_JOIN_GANG 135
#define D_CONFLICT_ZAPRO_GANG 136
#define D_INVITE_GANG 137
#define D_ZAPRO_DO_GANGU 138
#define D_VIEV_GANG_MEMBERS 139
#define D_GANG_DEGRADE 140
#define D_DEFINITE_D_G_MEMBER 141
#define D_GANG_SET_VICE 142
#define D_GANG_SET_VICE2 143
#define D_GANG_SET_TAG 144
#define D_GANG_SET_COLOR 145
#define D_GANG_SET_CAR 146
#define D_GANG_SET_SKIN 147
#define D_GANG_SET_SKIN1 148
#define D_GANG_STATS 149
#define D_CONFIRM_DELETE_GANG 150
#define D_ENTER_SIEDZIBA 151
#define D_CREATE_GANG1 152
#define D_CREATE_GANG2 153
#define D_CREATE_GANG3 154
#define D_CREATE_GANG4 155
#define D_CREATE_GANG5 156
#define D_PRACA_WOJAK 157
#define D_WYSLIJ_RAPORT 158
#define D_WYSLIJ_HITMAN 159
#define D_PRZEDMIOTY 160
#define D_PRZEDMIOTY1 161
#define D_PRZEDMIOTY2 162
#define D_PRZEDMIOTY3 163
#define D_PRZEDMIOTY4 164
#define D_PRZEDMIOTY5 165
#define D_PRZEDMIOTY6 166
#define D_SKLEP 167
#define D_GANG_ADD_TAG 168
#define SLOT_FRYZURA 0
#define SLOT_LASER 1
#define SLOT_PRZEDMIOT_GLOWA 2
#define SLOT_PRZEDMIOT_INNE 3
#define SLOT_PRZEDMIOT_RECE 4
#define SLOT_PRZEDMIOT_TORS 5
#define SLOT_KASK 6
#define SLOT_WEDKA 7
#define SLOT_LASER2 8
#define SLOT_NBRONIE 9
// Funkcje
#define SoundForAll(%0)\
	foreach(Player,sx) PlayerPlaySound(sx,%0,0.0,0.0,0.0)
#define PlaySoundForPlayer(%0,%1) PlayerPlaySound(%0,%1,0.0,0.0,0.0)
#define StopSoundForPlayer(%0) PlayerPlaySound(%0,1186,0.0,0.0,0.0)
#define CreateEntrance(%0,%1,%2,%3,%4) Entrance[%0] = CreateDynamicPickup(%1,1,%2,%3,%4,0,0,-1,50.0)
#define CreateEntranceText(%0,%1,%2,%3) CreateDynamic3DTextLabel(%0, 0xFF2F00FF, %1,%2,%3, 50.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 50.0)
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define SendClientMessageToAdmins(%0,%1) foreach(Player,xx) if(Player[xx][Admin1]) SendClientMessage(xx, %0, %1)
#define SendClientMessageToMods(%0,%1) foreach(Player,xx) if(Player[xx][Mod]) SendClientMessage(xx, %0, %1)
#define SendClientMessageToAdminsPM(%0,%1) foreach(Player,xx) if(Player[xx][Admin1] && pmid1 != xx && pmid2 != xx) SendClientMessage(xx,%0,%1)
#define SendClientMessageToPlayers(%0,%1) foreach(Player,xx) if(!Player[xx][Admin1]) SendClientMessage(xx,%0,%1)
#define SendClientMessageToVip(%0,%1) foreach(Player,xx) if(Player[xx][Vip] || Player[xx][Admin1] || Player[xx][Mod]) SendClientMessage(xx,%0,%1)
#define SCMG(%0,%1,%2) foreach(Player,xx) if(%0 == Player[xx][InGang]) SendClientMessage(xx,%1,%2)
#define GetPlayerNextExp(%0) \
	(Player[%0][Level]+1)*(Player[%0][Level]+1)*6
#define PlayerToPoint(%0,%1,%2,%3,%4) IsPlayerInRangeOfPoint(%1,%0,%2,%3,%4)
#define SelectPlayerColor(%0) playerColors[random(sizeof(playerColors))]
#define HidePlayerDialog(%0) \
    ShowPlayerDialog(%0,-1,DIALOG_STYLE_MSGBOX,"TEXT","TEXT","TEXT","TEXT")
#define CrashPlayer(%0) ApplyAnimation(%0, "GANG", "DRUGS_BUY", 10, 0, 0, 0, 0, 5*1000);
#define UpdatePlayerCheckPoint(%0,%1,%2,%3,%4,%5,%6,%7) \
    if(IsPlayerInArea(%0, %4,%5,%6,%7) && !Player[%0][IsPlayerInCheckPoint]) \
        SetPlayerCheckpoint(%0, %1,%2,%3,2)
#define WinSound(%0) SetTimerEx("SoundOff",7000,0,"i",%0); \
	PlayerPlaySound(%0, 1185, 0, 0, 0)
#define GetPlayerRoom(%0) Player[%0][Room]
#define RegeneratePlayer(%0) \
	SetPlayerHealth(%0, 100); SetPlayerArmour(%0, 100)
#define ShowAchievementGet(%0,%1) \
    TextDrawSetString(AchievementTextDraw[%0], %1); ShowAndHide2(%0, AchievementTextDraw[%0], 0, 0, 5*1000)
#define A_CHAR(%0) for(new i = strlen(%0) - 1; i >= 0; i--)\
	if((%0)[i] == '%')\
		(%0)[i] = ('#')
#define SetVehicleInterior(%0,%1) LinkVehicleToInterior(%0,%1)
#define SCM(%0,%1,%2) SendClientMessage(%0,%1,%2)
#define SCMA(%0,%1) SendClientMessageToAll(%0,%1)
#define SPD ShowPlayerDialog
/*==============================================================================
#define USE_CONTROL_IP //Zabezpieczenie
==============================================================================*/
// Zmienne graczy
enum uInfo
	AID,
	Name[MAX_PLAYER_NAME],
	Password[40],
    InfoTime,
	Exp,
	Level,
	Kills,
	Naprawil,
	Zapukal,
	FKWarnings,
	TuneWarnings,
	Deaths,
	ClickMapON,
	Suicides,
	Row_Kills,
	HouseTimer,
	Immunitet,
    FPSMode,
    CameraFirstPerson,
	AntySpawnKill,
	TpVipON,
	Onlined,
	VTPUsed,
	WaznoscPriv,
	Zajety,
	bounty,
	Biznes,
	Nicked,
	Room,
	JestSzefem,
    PrzelalExp,
	MaDochod,
	GunWarning,
	ObokDelHouse,
    PlaySound,
	DBWarnings,
	ActualColor,
	ActualSkin,
	Float:ActualPosX,
	Float:ActualPosY,
	Float:ActualPosZ,
	Float:ActualAngle,
	ActualInterior,
	ActualVirtualWorld,
	CKWarnings,
	HKWarnings,
	MinigunScore,
	RPGScore,
	VHealth,
    PrzelewExpId,
	IdzdoON,
    KolejkaSpawn,
	Santa,
	ZmienialTime,
    KupilZycie,
    KupilArmour,
    NewGangNazwa[32],
    NewGangTag[15],
    NewGangCar,
    DoTegoGanguZapro,
 	GetGangs[MAX_GANGS],
	InGang,
	gZapro,
    gAkceptEnabled,
    gAkceptInteriorEnabled,
	WygranychWG,
	WygranychWS,
	WygranychCH,
	WygranychPB,
	WygranychUS,
	WygranychSN,
	SMS_Tresc[32],
	SMS_Numer,
	SMS_Koszt,
	SMS_VAT[32],
	TimePlay,
	Warns,
	WarnsKick,
	BiznesTime,
	pVeh,
	PrivCarName,
	BiznesStep,
	Float:BiznesPosX,
	Float:BiznesPosY,
	Float:BiznesPosZ,
	BiznesNazwa[32],
	Mute,
	Money,
	DeathObject,
    WeaponPickup,
	WeaponPickupTime,
	IP[32],
	Jail,
    OnOnede,
	OnCombat,
	DriftCount,
	DriftCombo,
	Drift,
	bool:DriftEnabled,
	Float:VAngle,
	FloodTimer,
	OnMinigun,
	OnRPG,
	HouseAction,
	SiedzibaAction,
	BiznesAction,
	DamageText,
	OnedeScore,
	CombatScore,
	DriftScore,
	Skin,
    Float:NewHouseInX,
    Float:NewHouseInY,
    Float:NewHouseInZ,
    Float:NewHouseOutX,
    Float:NewHouseOutY,
    Float:NewHouseOutZ,
	Float:NewHouseAngle,
	NewHouseInterior,
    NewHouseName[32],
	SoloScore,
	DeathsSecond,
	RespektPremia,
	InArena,
	TutID,
	AirON,
	AllTD,
	Bank,
	Interior,
	Godz,
	MuteTimer,
	PrzelewID,
	KaskON,
	Float:TotalArm,
	Min,
	bool:FloatDeath,
	FirstSpawn,
	KillTime,
 	TPRefused,
	TPTo,
	AFK,
	AFKChecker,
	LevelUpTime,
	Color,
	ChatColor[15],
	SpamStrings,
	PBGod,
	ObokHouse,
	NearHouse,
	OnBike,
	Freeze,
	SoloBron,
	SoloWyzywa,
	CMDSpam,
	Update,
	Float:TotalDamage,
	IsPlayerInCheckPoint,
	FirstRequest,
    SiemaBlock,
	HitmanBlock,
	Float:SpecPosX,
	Float:SpecPosY,
	Float:SpecPosZ,
	SpecInt,
    bool:StworzylRampy,
	WlaczylRampy,
	Ramp,
	RampCoords,
	HealthTimer,
	ArmourTimer,
	RampTimer,
	SpecVW,
	Float:BombX,
	Float:BombY,
	Float:BombZ,
	bool:MozeDetonowac,
	bool:Bomber,
	Detonacjaa,
	Bombus,
	SpecOff,
	gSpectateID,
	gSpectateType,
	WaznoscVip,
	Vip,
	WaznoscMod,
	BadPassword,
	SuspensionAdmin,
	SuspensionVip,
	SuspensionMod,
	WaznoscAdmin,
	Mod,
	Nrgs,
	UsedPomoc,
	Logged,
	Registered,
	Kicks,
	Kodow,
	AutoMenu,
	Portfel,
	Bans,
	AdminLevel,
	Float:pLocX,
	Float:pLocY,
	Float:pLocZ,
	PasekON,
	HouseStep,
	LogoON,
    PodpowiedziON,
    ZegarON,
    bool:Dotacja[2],
	ZapisyON,
	LicznikON,
	ClickedPlayer,
	Nrg500,
	NewNick[MAX_PLAYER_NAME],
	NewPass[32],
	HouseOwn,
	CheckHouseSpawn,
	InHouse,
	Admin1,
	Admin2,
	House
// Zmienne osiągnięć
enum aInfo
	aRegistered,
	aTrofea,
	aDoscTego,
	aKask,
	aJestemLepszy,
	aJestemMistrzem,
	aPilot,
    a24Godziny,
	aDoOstatniegoTchu,
	aCelneOko,
	aZwinnePalce,
	aPodroznik,
	aDrifter,
	aKrolDriftu,
	aStreetKing,
	aNowaTozsamosc,
	aDomownik,
	aWlasne4,
	aZzzz,
	aWyborowy,
	aKomandos,
	aWedkarz,
	aStalyGracz,
	aPoszukiwacz
// Zmienne systemu domów
enum hInfo_
	hID,
	hName[32],
	hOwner[23],
	Float:hOutX,
	Float:hOutY,
	Float:hOutZ,
	Float:hInX,
	Float:hInY,
	Float:hInZ,
	Float:hAngle,
	hLocked,
	hCzynsz,
	hWaznosc,
	hPickup,
	hInterior,
	Text3D:hLabel,
	hIcon
new Kod[MAX_PLAYERS][10];
// Zmienne systemu prywatnych pojazdów
enum vInfo_
	vID,
	vModel,
	vOwner[20],
	Float:vPosX,
	Float:vPosY,
	Float:vPosZ,
	Float:vAngle,
	vColor1,
	vColor2,
	vPrzebieg,
	vPaintJob,
	SPOILER,
	HOOD,
	ROOF,
	SIDESKIRT,
	EXHAUST,
	LAMPS,
	WHEELS,
	STEREO,
	HYDRAULICS,
	FRONT_BUMPER,
	REAR_BUMPER,
	VENT_RIGHT,
	VENT_LEFT,
	Text3D:vLabel
// Zmienne systemu biznesów
enum bInfo_
	bID,
	bName[32],
	bOwner[20],
	Float:bX,
	Float:bY,
	Float:bZ,
	bCash,
	bPickup,
	Text3D:bLabel,
	bIcon
enum gInfo_
	gID,
	gName[50],
	gSzef[30],
	gVice[30],
	gTag[10],
	gColor,
	gColorZone,
	gKolorChat[15],
	gCar,
	gSkin,
    Float:gEnterX,
	Float:gEnterY,
	Float:gEnterZ,
	gEnterPickup,
    Text3D:gEnterLabel,
    Float:gInX,
	Float:gInY,
	Float:gInZ,
	gInterior
new bInfo[MAX_BIZNES][bInfo_],
	vInfo[MAX_PRIVATE_VEHICLES][vInfo_],
	hInfo[MAX_HOUSES][hInfo_],
    gInfo[MAX_GANGS][gInfo_],
	AchievementGet[MAX_PLAYERS][aInfo],
	Player[MAX_PLAYERS][uInfo];
new GlobalGangBuffer[MAX_PLAYERS][MAX_GANGS][MAX_PLAYER_NAME];
new cage[MAX_PLAYERS],
	caged[MAX_PLAYERS];
new Raport[10][32],
	RaportCD = -1,
	RaportID[10] = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
	bool:RaportBlock[MAX_PLAYERS];
new	MaxPojazdow,
	engine, lights, alarm, doors, bonnet, boot, objective,
	MaxPing,
	AdminPass[32],
	RconPass[32],
	LastInfoChat;
new LiczbaTak,
	LiczbaNie,
	AnkietaPozostalo,
	AnkietaPytanie[45],
	bool:Zaglosowal[MAX_PLAYERS],
	bool:AnkietaON,
	Text:AnkietaDraw;
// AntyDeAMX
stock EmitAMX()
    new d;
    #emit load.pri d
    #emit stor.pri d
// Kod do przepisania
new Letters[61] = {'q','w','e','r','t','y','u','i','o','p','a','s','d','f','g','h','j','k','l','z','x','c',
	'v','b','n','m','Q','W','E','R','T','Y','U','I','O','P','A','S','D','F','G','J','K','L','Z','X','C','V','B','N','M','1','2','3','4','5','6','7','8','9','0'};
new TestReaction;
new TimerReaction;
new STRReaction[20];
//new ReactionKolejka = 0;
new podgladPM = 1,
	bool:ChcePM[MAX_PLAYERS],
	pmid1,
	pmid2;
new bool:JailText[MAX_PLAYERS];
new LaserID[MAX_PLAYERS],vNeon[MAX_VEHICLES][2];
new BalonLV,
	Text3D:TextBalonLV[2];
new bool:GSTag[MAX_PLAYERS];
new Text:AchievementTextDraw[MAX_PLAYERS];
new Text:LogoS1,
	Text:LogoS2,
	Text:LogoS3;
new	Text:PanoramaUp1,
	Text:PanoramaDown1,
	Text:PanoramaUp2,
	Text:PanoramaDown2;
new JailTimer[MAX_PLAYERS],
	bool:Wiezien[MAX_PLAYERS];
new Same_IP=0,
	Join_Stamp,
	ban_s[25],
	exceed=0;
new Text3D:OnedeLabel;
new Text3D:MinigunLabel;
new Text3D:RPGLabel;
new Text3D:DriftLabel;
new Text3D:KillLabel;
new TotalBiznes,
	TotalHouses,
	TotalPrivCars,
	TotalGangs;
new Text:ArmourTD[MAX_PLAYERS],
	Text:HealthTD[MAX_PLAYERS];
new EndDriftTimer[MAX_PLAYERS];
new Text:FreeZone,
	Text:BezDmZone;
new Text:tdLevelUp,
	Text:CzasTD,
	Text:DataTD;
new MinigunUsers,
	RPGUsers,
	OnedeUsers,
	CombatUsers;
new Text:ZapisyString,
	Text:ZapisyLiczba;
new Text:AnnFade,
	CurrTimer[MAX_PLAYERS],
	CurrTimer2[MAX_PLAYERS];
new BagPickup,
	BagCash,
	bool:BagEnabled,
	PodkowaPickup,
	PodkowaCash,
	bool:PodkowaEnabled,
	PrezentPickup,
	bool:PrezentEnabled;
new GlobalJoins,
	GlobalKills,
	GlobalDeaths,
	GlobalUsers,
	GunDay,
	GlobalKicks,
	GlobalBans,
	RekordGraczy;
new OnlinePlayers,
	OnlineAdmins,
	OnlineMods,
	OnlineVips;
new Text:LicznikBox[13],
	Text:LicznikNazwa[MAX_PLAYERS],
	Text:LicznikPredkosc[MAX_PLAYERS];
new Text:PasekBox[13],
	Text:PasekStringGora,
	Text:ExpTD[MAX_PLAYERS],
	Text:LevelTD[MAX_PLAYERS],
	Text:OnlineTD[MAX_PLAYERS],
	Text:RatioTD[MAX_PLAYERS],
	Text:PortfelTD[MAX_PLAYERS],
	Text:GraczeTD,
    Text:WpiszVIPTD;
new Text:InfoBox[13];
new Text:InfoText[MAX_PLAYERS];
new Text3D:lExp[MAX_PLAYERS],
	Text3D:lDmg[MAX_PLAYERS];
new RywalSolo[2] = {-1,-1},
	SoloCD = 3;
new Pinger[MAX_PLAYERS];
new Entrance[MAX_ENTRANCES];
new bool:gPlayerUsingAnim[MAX_PLAYERS],
	DrunkTimer[MAX_PLAYERS];
new Count2 = 0,
	CountDowning = 0;
new bool:CDText;
new Count1 = 3;
new CountText[3][5] = {
	"~w~1",
	"~w~2",
	"~w~3"
new Top10Text[5][540];
new Float:LoadTime;
new Float:LocX = 0.0,
	Float:LocY = 0.0,
	Float:LocZ = 0.0;
new Float:AfkPosX[MAX_PLAYERS],
	Float:AfkPosY[MAX_PLAYERS],
	Float:AfkPosZ[MAX_PLAYERS];
new bool:Bombs = true;
new VehicleLocked[MAX_VEHICLES];
new Abronie[4] = {35,36,37,38};
new bool:RPGText,
	bool:MinigunText,
	bool:OnedeText,
	bool:CombatText;
new bool:SoloON;
new InAir[MAX_PLAYERS],
	JestNaZiemi[MAX_PLAYERS],
	SkoczylDwaRazy[MAX_PLAYERS],
	WaitForJump[MAX_PLAYERS];
// System zabaw
new ZabawaWG;
new ZabawaPB;
new ZabawaWS;
new ZabawaCH;
new ZabawaUS;
new ZabawaSN;
new bool:WGStarted;
new ArenaZone;
new WGTimer;
new bool:WGKandydat[MAX_PLAYERS];
new WGTeam[MAX_PLAYERS];
new WGLiczba;
new bool:WGON;
new bool:WGGlos[MAX_PLAYERS];
new WGTeamLiczba[3];
new Float:WGAreaX,Float:WGAreaY,Float:WGAreaZ,Float:WGAreaA;
new InteriorWG;
new WGAwayCount[MAX_PLAYERS];
new bool:PBStarted;
new PBZone;
new PBTimer;
new bool:PBKandydat[MAX_PLAYERS];
new PBTeam[MAX_PLAYERS];
new PBLiczba;
new bool:PBON;
new bool:PBGlos[MAX_PLAYERS];
new PBTeamLiczba[3];
new Float:PBAreaX,Float:PBAreaY,Float:PBAreaZ,Float:PBAreaA;
new InteriorPB;
new PBAwayCount[MAX_PLAYERS];
new Float:PBTeam1SpawnX;
new Float:PBTeam1SpawnY;
new Float:PBTeam1SpawnZ;
new Float:PBTeam2SpawnX;
new Float:PBTeam2SpawnY;
new Float:PBTeam2SpawnZ;
new PBPoints1;
new PBPoints2;
new PBTime;
new Text:PBTD;
#define MAX_RACE_CP 50
new Float:CarSpawnX[10];
new Float:CarSpawnY[10];
new Float:CarSpawnZ[10];
new Text:RaceStats[MAX_PLAYERS];
new CarModel;
new RaceInterior;
new CPSize;
new CPliczba;
new Float:CPx[MAX_RACE_CP];
new Float:CPy[MAX_RACE_CP];
new Float:CPz[MAX_RACE_CP];
new bool:WyscigUczestnik[MAX_PLAYERS];
new WSMans = 0;
new Float:RaceSpawnA;
new Car[10];
new WyscigStatus[MAX_PLAYERS];
new NaMecieMiejsce = 0;
new bool:RaceWystartowal;
new CountLicz = 3;
new PlayerCarNum = 0;
new Pozycja[MAX_RACE_CP];
new ActualPos[MAX_PLAYERS];
new CPType;
new RaceTimer;
new RaceStartTimer;
new RaceID;
new RaceOnFoot;
new Text:ChowanyTD;
new bool:ChowanyZapisany[MAX_PLAYERS];
new bool:Chowany[MAX_PLAYERS];
new bool:Szukajacy[MAX_PLAYERS];
new ChowanyKandydat[50];
new bool:ChStarted = false;
new ChLiczba;
new SzLiczba;
new ChEndTimer;
new Chtimercount;
new Chtimerszuk;
new ChCountLiczba;
new AwayCount[MAX_PLAYERS];
new bool:ChWystartowala;
new ChNum;
new Float:ChowPosX;
new Float:ChowPosY;
new Float:ChowPosZ;
new Float:SzukPosX;
new Float:SzukPosY;
new Float:SzukPosZ;
new Float:ChAreaX;
new Float:ChAreaY;
new Float:ChAreaZ;
new Float:ChAreaA;
new ChInt;
new DerbyCar[16];
new DerbyCar2[16];
new bool:DerbyMen[MAX_PLAYERS];
new bool:DerbyZaglosowal[MAX_PLAYERS];
new bool:DerbyON;
new bool:DerbyStartON;
new bool:DerbyLoad;
new DerbyRand;
//sianko
new SNObject[81];
new bool:SNStarted;
new SNTimer;
new bool:SNKandydat[MAX_PLAYERS];
new SNLiczba;
new bool:SNON;
new bool:SNGlos[MAX_PLAYERS];
new SNActiveGun;
new Float:gRandomPlayerSpawns[27][4] = {2033.2277,-1415.6764,16.9922,133.1975}, //SzpitalLS3636.9235, -1772.8167, 234.3411,0.0}, //Odbij2129.8120,2382.5527,23.6620,178.1799}, //LV2 obiektowe83.4930,2433.8430,83.9585,270.0}, //Tube1544.9849,-1353.7681,329.4735,0.0}, //Parkour1011.0331,-1306.1213,13.3828,0.0}, //Warsztat2-1494.9581,686.1584,7.1833,267.0135}, //Tor21121.1410,1353.5417,10.8203}, //Drift 8-24.7265,1838.4039,17.1216,0.0}, //Afganistan2056.7085,2056.1362,26.5230,269.6082}, //Baza obok /CentrumLV na dachu
	//{2900.4480,1702.4181,10.8203,71.6617}, //Tereno-858.9744,-1941.0603,15.1729,0.0}, //Bagno-1239.7552,-219.8564,14.1484,62.3732}, //Stunt SFLOT
	//{744.4009,-2850.6775,5.0497,268.9033}, //Wyspa23083.2380,-1986.0442,23.0410,270.7322}, //Tor Nrg1396.8975,-2427.2585,525.6313,270.3780}, //PiPe1383.7766,-457.5579,52.4373,126.8561}, //Domek-7.9788,-333.2255,5.4297,0.0}, //Baza 2251.2597,-157.4107,1.5703,88.8784}, //BlueBerry1718.0747,-2674.3906,13.5469,0.0}, //Stunt1079.9526,-2720.4280,7.0510,27.0597}, //Miniport316.7266,-1881.3896,2.2236,82.5482}, //Restauracja4027.2825,-1922.9817,2382.1765,178.1830}, //SkyDive1046.1104,1336.3427,10.8203,0.0}, //PKS709.9035,-132.6756,21.2761,0.0}, // Zioło-1544.8756,-2737.5942,48.5380,145.4389}, //Warsztat2100.6006,1612.5186,10.8203,179.1716}, //Baza w /LV-270.5339,2587.2126,63.5703,267.3754}, //LasPayasadas-1785.6355, 581.3128, 234.8906,0.0} //Kulki
GetRealWeaponName(weaponid)
	new String[25];
	switch(weaponid)
		case 0: format(String,sizeof(String),"Pięści");
        case 1: format(String,sizeof(String),"Łańcuch");
        case 2: format(String,sizeof(String),"Kij golfowy");
        case 3: format(String,sizeof(String),"Pałka policyjna");
        case 4: format(String,sizeof(String),"Nóż");
        case 5: format(String,sizeof(String),"Pałka golfowa");
        case 6: format(String,sizeof(String),"Łopata");
        case 7: format(String,sizeof(String),"Kij bilardowy");
        case 8: format(String,sizeof(String),"Katana");
        case 9: format(String,sizeof(String),"Piła motorowa");
        case 10: format(String,sizeof(String),"Fioletowe dildo");
        case 11: format(String,sizeof(String),"Zwykłe dildo");
        case 12: format(String,sizeof(String),"Wibrator");
        case 13: format(String,sizeof(String),"Srebrny wibrator");
        case 14: format(String,sizeof(String),"Kwiaty");
        case 15: format(String,sizeof(String),"Laska");
        case 16: format(String,sizeof(String),"Granat");
        case 17: format(String,sizeof(String),"Granat dymny");
        case 18: format(String,sizeof(String),"Koktajl mołotowa");
        case 19: format(String,sizeof(String),"INVALID_GUN_ID");
        case 20: format(String,sizeof(String),"INVALID_GUN_ID");
        case 21: format(String,sizeof(String),"INVALID_GUN_ID");
        case 22: format(String,sizeof(String),"Pistolet 9MM");
        case 23: format(String,sizeof(String),"Pistolet z tłumikiem");
        case 24: format(String,sizeof(String),"Desert Eagle");
        case 25: format(String,sizeof(String),"Shotgun");
        case 26: format(String,sizeof(String),"Sawn-off Shotgun");
        case 27: format(String,sizeof(String),"Combat Shotgun");
        case 28: format(String,sizeof(String),"Mikro UZI");
        case 29: format(String,sizeof(String),"MP5");
        case 30: format(String,sizeof(String),"AK-47");
        case 31: format(String,sizeof(String),"M4");
        case 32: format(String,sizeof(String),"Tec-9");
        case 33: format(String,sizeof(String),"Wiatrówka");
        case 34: format(String,sizeof(String),"Sniper-Rifle");
        case 35: format(String,sizeof(String),"RPG");
        case 36: format(String,sizeof(String),"Auto-RPG");
        case 37: format(String,sizeof(String),"Miotacz ognia");
        case 38: format(String,sizeof(String),"Minigun");
        case 39: format(String,sizeof(String),"Ładunki wybuchowe");
        case 40: format(String,sizeof(String),"Detonator");
        case 41: format(String,sizeof(String),"Spray");
        case 42: format(String,sizeof(String),"Gaśnica");
        case 43: format(String,sizeof(String),"Aparat");
	return String;
new gRandomPlayerSpawnsName[27][] =
	"Zostałeś(aś) zrespawnowany do "W"/SzpitalLS",
    "Zostałeś(aś) zrespawnowany do "W"/Odbij",
	"Zostałeś(aś) zrespawnowany do "W"/CentrumLV",
	"Zostałeś(aś) zrespawnowany do "W"/Tube",
    "Zostałeś(aś) zrespawnowany do "W"/Parkour",
	"Zostałeś(aś) zrespawnowany do "W"/Warsztat2",
	"Zostałeś(aś) zrespawnowany do "W"/Tor2",
	"Zostałeś(aś) zrespawnowany do "W"/Drift8",
	"Zostałeś(aś) zrespawnowany na "W"/Afganistan",
	"Zostałeś(aś) zrespawnowany do "W"/Baza3",
	//"Zostałeś(aś) zrespawnowany do "W"/Tereno",
    "Zostałeś(aś) zrespawnowany na "W"/Bagno",
    "Zostałeś(aś) zrespawnowany do "W"/SFLot",
    //"Zostałeś(aś) zrespawnowany do "W"/Wyspa2",
    "Zostałeś(aś) zrespawnowany na "W"/TorNrg",
    "Zostałeś(aś) zrespawnowany do "W"/Pipe",
    "Zostałeś(aś) zrespawnowany na "W"/Domek",
    "Zostałeś(aś) zrespawnowany do "W"/Baza2",
    "Zostałeś(aś) zrespawnowany na "W"/BlueBerry",
    "Zostałeś(aś) zrespawnowany na "W"/Stunt",
    "Zostałeś(aś) zrespawnowany na "W"/MiniPort",
    "Zostałeś(aś) zrespawnowany na "W"/Plaza",
    "Zostałeś(aś) zrespawnowany na "W"/SkyDive",
    "Zostałeś(aś) zrespawnowany na "W"/PKS",
    "Zostałeś(aś) zrespawnowany na "W"/Ziolo",
    "Zostałeś(aś) zrespawnowany na "W"/Warsztat",
    "Zostałeś(aś) zrespawnowany na "W"/Baza1",
    "Zostałeś(aś) zrespawnowany na "W"/LasPayasadas",
    "Zostałeś(aś) zrespawnowany na "W"/Kulki"
new Float:CelaSpawn[6][3] = {-2058.5615,1860.2478,10.1556},-2076.1138,1811.7256,11.0765},-2128.2261,1757.1676,14.3478},-2233.5437,1785.6115,9.3597},-2232.4055,1709.5081,5.5762},-2177.8569,1770.1165,12.1756}
new Float:RPGSpawn[10][3] = {664.8109,885.9849,-40.3984},566.4577,874.8604,-35.9215},504.8477,826.9881,-10.5402},449.2125,876.3629,-4.8458},481.3689,958.4439,5.3957},628.1097,993.2015,5.8817},705.7195,919.0931,-18.6484},774.3939,828.9639,5.8792},688.9326,748.8588,-5.6011},564.4626,778.8513,-17.1351}
new Float:MinigunSpawn[5][3] = {2618.8625,2729.7747,36.5386},2616.8274,2757.6858,23.8222},2663.6780,2782.2542,10.8203},2586.3342,2825.9221,10.8203},2531.7620,2770.3804,10.8203}
new Float:OnedeSpawn[7][3] = {296.6457,175.0513,1007.1719},291.8950,191.2039,1007.1719},251.2341,190.8307,1008.1719},237.6193,150.2289,1003.0234},195.6603,158.1704,1003.0234},193.1122,179.0792,1003.0234},226.1649,182.2769,1003.0313}
new Float:CombatSpawn[5][3] = {-66.7317,-1590.2417,2.6172},-83.3598,-1604.8137,2.6172},-104.7677,-1575.0375,2.6172},-65.1837,-1540.9169,2.6172},-53.8995,-1570.8000,2.6172}
new brama;
new OnedeObject[3][MAX_PLAYERS];
new playerColors[100] = {
	0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,0xF4A460FF,0xEE82EEFF,
	0xFFD720FF,0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,0x10DC29FF,0x534081FF,0x0495CDFF,
	0xEF6CE8FF,0xBD34DAFF,0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,0x65ADEBFF,0x5C1ACCFF,0xF2F853FF,0x11F891FF,
	0x7B39AAFF,0x53EB10FF,0x54137DFF,0x275222FF,0xF09F5BFF,0x3D0A4FFF,0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,
	0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,0x057F94FF,0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,
	0x93AB1CFF,0x95BAF0FF,0x369976FF,0x18F71FFF,0x4B8987FF,0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,
	0x2D74FDFF,0x3C1C0DFF,0x12D6D4FF,0x48C000FF,0x2A51E2FF,0xE3AC12FF,0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,
	0x42ACF5FF,0x2FD9DEFF,0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,
	0x3214AAFF,0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,0x9F945CFF,0xDCDE3DFF,
	0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,0xD8C762FF,0xD8C762FF,0xFFFF00FF,0xFF8400FF
new playerColorsZone[100] = {
	0xFF8C1388,0xC715FF88,0x20B2AA88,0xDC143C88,0x6495ED88,0xf0e68c88,0x77889988,0xFF149388,0xF4A46088,0xEE82EE88,
	0xFFD72088,0x8b451388,0x4949A088,0x148b8b88,0x14ff7f88,0x556b2f88,0x0FD9FA88,0x10DC2988,0x53408188,0x0495CD88,
	0xEF6CE888,0xBD34DA88,0x247C1B88,0x0C8E5D88,0x635B0388,0xCB7ED388,0x65ADEB88,0x5C1ACC88,0xF2F85388,0x11F89188,
	0x7B39AA88,0x53EB1088,0x54137D88,0x27522288,0xF09F5B88,0x3D0A4F88,0x22F76788,0xD6303488,0x9A698088,0xDFB93588,
	0x3793FA88,0x90239D88,0xE9AB2F88,0xAF2FF388,0x057F9488,0xB9851988,0x388EEA88,0x02815188,0xA5504388,0x0DE01888,
	0x93AB1C88,0x95BAF088,0x36997688,0x18F71F88,0x4B898788,0x491B9E88,0x829DC788,0xBCE63588,0xCEA6DF88,0x20D4AD88,
	0x2D74FD88,0x3C1C0D88,0x12D6D488,0x48C00088,0x2A51E288,0xE3AC1288,0xFC42A888,0x2FC82788,0x1A30BF88,0xB740C288,
	0x42ACF588,0x2FD9DE88,0xFAFB7188,0x05D1CD88,0xC471BD88,0x94436E88,0xC1F7EC88,0xCE79EE88,0xBD1EF288,0x93B7E488,
	0x3214AA88,0x184D3B88,0xAE4B9988,0x7E49D788,0x4C436E88,0xFA24CC88,0xCE76BE88,0xA04E0A88,0x9F945C88,0xDCDE3D88,
	0x0BE47288,0x8A2CD788,0x6152C288,0xCF72A988,0xE5933888,0xEEDC2D88,0xD8C76288,0xD8C76288,0xFFFF0088,0xFF840088
new CarList[212][] = {"Landstalker"},{"Bravura"},{"Buffalo"},{"Linerunner"},{"Perrenial"},{"Sentinel"},"Dumper"},{"Firetruck"},{"Trashmaster"},{"Stretch"},{"Manana"},{"Infernus"},{"Voodoo"},"Pony"},{"Mule"},{"Cheetah"},{"Ambulance"},{"Leviathan"},{"Moonbeam"},{"Esperanto"},{"Taxi"},"Washington"},{"Bobcat"},{"Mr. Whoopee"},{"BF. Injection"},{"Hunter"},{"Premier"},{"Enforcer"},"Securicar"},{"Banshee"},{"Predator"},{"Bus"},{"Rhino"},{"Barracks"},{"Hotknife"},{"Article Trailer"},"Previon"},{"Coach"},{"Cabbie"},{"Stallion"},{"Rumpo"},{"RC Bandit"},{"Romero"},{"Packer"},{"Monster"},"Admiral"},{"Squalo"},{"Seasparrow"},{"Pizzaboy"},{"Tram"},{"Article Trailer 2"},{"Turismo"},{"Speeder"},"Reefer"},{"Tropic"},{"Flatbed"},{"Yankee"},{"Caddy"},{"Solair"},{"RC Van"},{"Skimmer"},"PCJ-600"},{"Faggio"},{"Freeway"},{"RC Baron"},{"RC Raider"},{"Glendale"},{"Oceanic"},{"Sanchez"},"Sparrow"},{"Patriot"},{"Quad"},{"Coastguard"},{"Dinghy"},{"Hermes"},{"Sabre"},{"Rustler"},{"ZR-350"},"Walton"},{"Regina"},{"Comet"},{"BMX"},{"Burrito"},{"Camper"},{"Marquis"},{"Baggage"},{"Dozer"},"Maverick"},{"News Chopper"},{"Rancher"},{"FBI Rancher"},{"Virgo"},{"Greenwood"},{"Jetmax"},{"Hotring"},"Sandking"},{"Blista Compact"},{"Police Maverick"},{"Boxville"},{"Benson"},{"Mesa"},{"RC Goblin"},"Hotring Racer A"},{"Hotring Racer B"},{"Bloodring Banger"},{"Rancher"},{"Super GT"},{"Elegant"},"Journey"},{"Bike"},{"Mountain Bike"},{"Beagle"},{"Cropdust"},{"Stunt"},{"Tanker"},{"Roadtrain"},"Nebula"},{"Majestic"},{"Buccaneer"},{"Shamal"},{"Hydra"},{"FCR-900"},{"NRG-500"},{"HPV1000"},"Cement Truck"},{"Tow Truck"},{"Fortune"},{"Cadrona"},{"FBI Truck"},{"Willard"},{"Forklift"},"Tractor"},{"Combine"},{"Feltzer"},{"Remington"},{"Slamvan"},{"Blade"},{"Freight"},{"Streak"},"Vortex"},{"Vincent"},{"Bullet"},{"Clover"},{"Sadler"},{"Firetruck LA"},{"Hustler"},{"Intruder"},"Primo"},{"Cargobob"},{"Tampa"},{"Sunrise"},{"Merit"},{"Utility"},{"Nevada"},{"Yosemite"},{"Windsor"},"Monster A"},{"Monster B"},{"Uranus"},{"Jester"},{"Sultan"},{"Stratum"},{"Elegy"},{"Raindance"},"RC Tiger"},{"Flash"},{"Tahoma"},{"Savanna"},{"Bandito"},{"Freight Flat"},{"Streak Carriage"},"Kart"},{"Mower"},{"Dunerider"},{"Sweeper"},{"Broadway"},{"Tornado"},{"AT-400"},{"DFT-30"},{"Huntley"},"Stafford"},{"BF-400"},{"Newsvan"},{"Tug"},{"Article Trailer 3"},{"Emperor"},{"Wayfarer"},{"Euros"},{"Mobile Hotdog"},"Club"},{"Freight Carriage"},{"Trailer 3"},{"Andromada"},{"Dodo"},{"RC Cam"},{"Launch"},{"Police Car (LSPD)"},"Police Car (SFPD)"},{"Police Car (LVPD)"},{"Police Ranger"},{"Picador"},{"SWAT Van"},{"Alpha"},"Phoenix"},{"Glendale"},{"Sadler"},{"Luggage Trailer A"},{"Luggage Trailer B"},{"Stair Trailer"},"Boxville"},{"Farm Plow"},{"Utility Trailer"}
new ChatInfos[21][] =
	"{FF0066}* {D9D9D9}Nowość! Na naszym serwerze została wprowadzona {FF0066}broń dnia{D9D9D9}! (/GunDay).",
	""WI" {44a428}Pamiętaj, co "W"1 godzinę gry {44a428}na serwerze dostajesz automatycznie premię exp.",
	""WI" {44a428}Denerwuje cię ogrom wiadomości na czacie? Wpisz "W"/Room {44a428}i pogadaj na spokojnie :)",
    ""WI" {44a428}Chcesz kupić VIP'a? Doładuj "W"/Portfel {44a428}kwotą 5 zł i wpisz "W"/VIP{44a428}!.",
	"{FF0066}* {D9D9D9}Nowość! Na naszym serwerze została wprowadzona {FF0066}broń dnia{D9D9D9}! (/GunDay).",
	""WI" {44a428}Chcesz włączyć tryb "W"First-Person{44a428}? W tym celu wpisz komendę "W"/FPS{44a428}.",
	""WI" {44a428}Aby przeteleportować się do innego gracza wpisz "W"/Idzdo [ID]{44a428}.",
	""WI" {44a428}Pragniesz mieć "W"prywatny pojazd{44a428}? Wpisz "W"/Pojazd{44a428}.",
	""WI" {44a428}Chcesz posłuchać stacji radiowych? Wpisz "W"/Radio{44a428}.",
    ""WI" {44a428}Chcesz kupić VIP'a? Doładuj "W"/Portfel {44a428}kwotą 5 zł i wpisz "W"/VIP{44a428}!.",
    ""WI" {44a428}Chcesz coś wylosować? Wpisz "W"/Losowanie{44a428}. Może coś wygrasz :)",
	""WI" {44a428}Pamiętaj! Jeżeli posiadasz prywatny pojazd musisz być na serwerze co "W"pięć dni{44a428}. Inaczej go stracisz.",
	"{FF0066}* {D9D9D9}Pamiętaj o /GunDay! Bronią dnia dostajesz +2 exp za zabójstwo!",
    ""WI" {44a428}Chcesz kupić VIP'a? Doładuj "W"/Portfel {44a428}kwotą 5 zł i wpisz "W"/VIP{44a428}!.",
	""WI" {44a428}Chcesz wyłączyć kask w motorach? Wpisz "W"/Kask{44a428}.",
    ""WI" {44a428}Dodaj "W"lasery {44a428}do swojej broni! Wpisz komendę "W"/Laser{44a428}.",
	""WI" {44a428}Chcesz przelać trochę exp innemu graczowi? Wpisz "W"/Exp{44a428}.",
	""WI" {44a428}Chcesz wyłączyć podwójny skok? Wpisz "W"/Air{44a428}.",
	"{FF0066}* {D9D9D9}Chcesz sprawdzić aktualną broń dnia? Wpisz {FF0066}/GunDay{D9D9D9}.",
	""WI" {44a428}Zapraszamy na stronę internetową serwera! "W""WWW"{44a428}.",
	""WI" {44a428}Pamiętaj! Jeżeli posiadasz prywatny pojazd musisz być na serwerze co "W"pięć dni{44a428}. Inaczej go stracisz."
stock SelectGunDay()
    GunDay = random(42);
    if(GunDay == 19 || GunDay == 20 || GunDay == 21 || GunDay == 38 || GunDay == 36 || GunDay == 35 || GunDay == 1 || GunDay == 0 || 17 || GunDay == 40)
        SelectGunDay();
stock ShowInfoBox(playerid,strc[],timex)
	TextDrawSetString(InfoText[playerid],strc);
	for(new x=0;x<13;x++)
		TextDrawShowForPlayer(playerid,InfoBox[x]);
    Player[playerid][InfoTime] = timex;
	TextDrawShowForPlayer(playerid,InfoText[playerid]);
stock GetSkinName(skinid)
	new returnt[64];
	switch(skinid)
		case 0 	: { format(returnt,sizeof(returnt),  "Carl Johnson"); }
		case 1	: { format(returnt,sizeof(returnt),  "Truth"); }
		case 2	: { format(returnt,sizeof(returnt),  "Maccer"); }
		case 3	: { format(returnt,sizeof(returnt),  "INVALID_SKIN_ID"); }
		case 4	: { format(returnt,sizeof(returnt),  "INVALID_SKIN_ID"); }
		case 5	: { format(returnt,sizeof(returnt),  "INVALID_SKIN_ID"); }
		case 6	: { format(returnt,sizeof(returnt),  "INVALID_SKIN_ID"); }
		case 7	: { format(returnt,sizeof(returnt),  "Taxi Driver"); }
		case 8	: { format(returnt,sizeof(returnt),  "INVALID_SKIN_ID"); }
		case 9	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 10	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 11	: { format(returnt,sizeof(returnt),  "Casino Worker"); }
		case 12	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 13	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 14	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 15	: { format(returnt,sizeof(returnt),  "RS Haul Owner"); }
		case 16	: { format(returnt,sizeof(returnt),  "Airport Ground Worker"); }
		case 17	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 18	: { format(returnt,sizeof(returnt),  "Beach Visitor"); }
		case 19	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 20	: { format(returnt,sizeof(returnt),  "Madd Dogg's Manager"); }
		case 21	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 22	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 23	: { format(returnt,sizeof(returnt),  "BMXer"); }
		case 24	: { format(returnt,sizeof(returnt),  "Madd Dogg Bodyguard"); }
		case 25	: { format(returnt,sizeof(returnt),  "Madd Dogg Bodyguard"); }
		case 26	: { format(returnt,sizeof(returnt),  "Mountain Climber"); }
		case 27	: { format(returnt,sizeof(returnt),  "Builder"); }
		case 28	: { format(returnt,sizeof(returnt),  "Drug Dealer"); }
		case 29	: { format(returnt,sizeof(returnt),  "Drug Dealer"); }
		case 30	: { format(returnt,sizeof(returnt),  "Drug Dealer"); }
		case 31	: { format(returnt,sizeof(returnt),  "Farm-Town inhabitant"); }
		case 32	: { format(returnt,sizeof(returnt),  "Farm-Town inhabitant"); }
		case 33	: { format(returnt,sizeof(returnt),  "Farm-Town inhabitant"); }
		case 34	: { format(returnt,sizeof(returnt),  "Farm-Town inhabitant"); }
		case 35	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 36	: { format(returnt,sizeof(returnt),  "Golfer"); }
		case 37	: { format(returnt,sizeof(returnt),  "Golfer"); }
		case 38	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 39	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 40	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 41	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 42	: { format(returnt,sizeof(returnt),  "INVALID_SKIN_ID"); }
		case 43	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 44	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 45	: { format(returnt,sizeof(returnt),  "Beach Visitor"); }
		case 46	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 47	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 48	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 49	: { format(returnt,sizeof(returnt),  "Snakehead (Da Nang)"); }
		case 50	: { format(returnt,sizeof(returnt),  "Mechanic"); }
		case 51	: { format(returnt,sizeof(returnt),  "Mountain Biker"); }
		case 52	: { format(returnt,sizeof(returnt),  "Mountain Biker"); }
		case 53	: { format(returnt,sizeof(returnt),  "INVALID_SKIN_ID"); }
		case 54	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 55	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 56	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 57	: { format(returnt,sizeof(returnt),  "Feds"); }
		case 58	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 59	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 60	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 61	: { format(returnt,sizeof(returnt),  "Pilot"); }
		case 62	: { format(returnt,sizeof(returnt),  "Colonel Fuhrberger"); }
		case 63	: { format(returnt,sizeof(returnt),  "Prostitute"); }
		case 64	: { format(returnt,sizeof(returnt),  "Prostitute"); }
		case 65	: { format(returnt,sizeof(returnt),  "INVALID_SKIN_ID"); }
		case 66	: { format(returnt,sizeof(returnt),  "Pool Player"); }
		case 67	: { format(returnt,sizeof(returnt),  "Pool Player"); }
		case 68	: { format(returnt,sizeof(returnt),  "Priest"); }
		case 69	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 70	: { format(returnt,sizeof(returnt),  "Scientist"); }
		case 71	: { format(returnt,sizeof(returnt),  "Security Guard"); }
		case 72	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 73	: { format(returnt,sizeof(returnt),  "Jethro"); }
		case 74	: { format(returnt,sizeof(returnt),  "INVALID_SKIN_ID"); }
		case 75	: { format(returnt,sizeof(returnt),  "Prostitute"); }
		case 76	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 77	: { format(returnt,sizeof(returnt),  "Homeless"); }
		case 78	: { format(returnt,sizeof(returnt),  "Homeless"); }
		case 79	: { format(returnt,sizeof(returnt),  "Homeless"); }
		case 80	: { format(returnt,sizeof(returnt),  "Boxer"); }
		case 81	: { format(returnt,sizeof(returnt),  "Boxer"); }
		case 82	: { format(returnt,sizeof(returnt),  "Elvis Wannabe"); }
		case 83	: { format(returnt,sizeof(returnt),  "Elvis Wannabe"); }
		case 84	: { format(returnt,sizeof(returnt),  "Elvis Wannabe"); }
		case 85	: { format(returnt,sizeof(returnt),  "Prostitute"); }
		case 86	: { format(returnt,sizeof(returnt),  "INVALID_SKIN_ID"); }
		case 87	: { format(returnt,sizeof(returnt),  "Whore"); }
		case 88	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 89	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 90	: { format(returnt,sizeof(returnt),  "Whore"); }
		case 91	: { format(returnt,sizeof(returnt),  "INVALID_SKIN_ID"); }
		case 92	: { format(returnt,sizeof(returnt),  "Beach Visitor"); }
		case 93	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 94	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 95	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 96	: { format(returnt,sizeof(returnt),  "Jogger"); }
		case 97	: { format(returnt,sizeof(returnt),  "Beach Visitor"); }
		case 98	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 99	: { format(returnt,sizeof(returnt),  "Skeelering"); }
		case 100	: { format(returnt,sizeof(returnt),  "Biker"); }
		case 101	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 102	: { format(returnt,sizeof(returnt),  "Ballas Member"); }
		case 103	: { format(returnt,sizeof(returnt),  "Ballas Member"); }
		case 104	: { format(returnt,sizeof(returnt),  "Ballas Member"); }
		case 105	: { format(returnt,sizeof(returnt),  "Grove Member"); }
		case 106	: { format(returnt,sizeof(returnt),  "Grove Member"); }
		case 107	: { format(returnt,sizeof(returnt),  "Grove Member"); }
		case 108	: { format(returnt,sizeof(returnt),  "Vagos Member"); }
		case 109	: { format(returnt,sizeof(returnt),  "Vagos Member"); }
		case 110	: { format(returnt,sizeof(returnt),  "Vagos Member"); }
		case 111	: { format(returnt,sizeof(returnt),  "Russian Member"); }
		case 112	: { format(returnt,sizeof(returnt),  "Russian Member"); }
		case 113	: { format(returnt,sizeof(returnt),  "Russian Member"); }
		case 114	: { format(returnt,sizeof(returnt),  "Aztecas Member"); }
		case 115	: { format(returnt,sizeof(returnt),  "Aztecas Member"); }
		case 116	: { format(returnt,sizeof(returnt),  "Aztecas Member"); }
		case 117	: { format(returnt,sizeof(returnt),  "Traid Member"); }
		case 118	: { format(returnt,sizeof(returnt),  "Traid Member"); }
		case 119	: { format(returnt,sizeof(returnt),  "INVALID_SKIN_ID"); }
		case 120	: { format(returnt,sizeof(returnt),  "Traid"); }
		case 121	: { format(returnt,sizeof(returnt),  "Da Nang Boy"); }
		case 122	: { format(returnt,sizeof(returnt),  "Da Nang Boy"); }
		case 123	: { format(returnt,sizeof(returnt),  "Da Nang Boy"); }
		case 124	: { format(returnt,sizeof(returnt),  "The Mafia"); }
		case 125	: { format(returnt,sizeof(returnt),  "The Mafia"); }
		case 126	: { format(returnt,sizeof(returnt),  "The Mafia"); }
		case 127	: { format(returnt,sizeof(returnt),  "The Mafia"); }
		case 128	: { format(returnt,sizeof(returnt),  "Farmer"); }
		case 129	: { format(returnt,sizeof(returnt),  "Farmer"); }
		case 130	: { format(returnt,sizeof(returnt),  "Farmer"); }
		case 131	: { format(returnt,sizeof(returnt),  "Farmer"); }
		case 132	: { format(returnt,sizeof(returnt),  "Farmer"); }
		case 133	: { format(returnt,sizeof(returnt),  "Farmer"); }
		case 134	: { format(returnt,sizeof(returnt),  "Homeless"); }
		case 135	: { format(returnt,sizeof(returnt),  "Homeless"); }
		case 136	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 137	: { format(returnt,sizeof(returnt),  "Homeless"); }
		case 138	: { format(returnt,sizeof(returnt),  "Beach Visitor"); }
		case 139	: { format(returnt,sizeof(returnt),  "Beach Visitor"); }
		case 140	: { format(returnt,sizeof(returnt),  "Beach Visitor"); }
		case 141	: { format(returnt,sizeof(returnt),  "Office Worker"); }
		case 142	: { format(returnt,sizeof(returnt),  "Taxi Driver"); }
		case 143	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 144	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 145	: { format(returnt,sizeof(returnt),  "Beach Visitor"); }
		case 146	: { format(returnt,sizeof(returnt),  "Beach Visitor"); }
		case 147	: { format(returnt,sizeof(returnt),  "Director"); }
		case 148	: { format(returnt,sizeof(returnt),  "Secretary"); }
		case 149	: { format(returnt,sizeof(returnt),  "INVALID_SKIN_ID"); }
		case 150	: { format(returnt,sizeof(returnt),  "Secretary"); }
		case 151	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 152	: { format(returnt,sizeof(returnt),  "Prostitute"); }
		case 153	: { format(returnt,sizeof(returnt),  "Coffee mam'"); }
		case 154	: { format(returnt,sizeof(returnt),  "Beach Visitor"); }
		case 155	: { format(returnt,sizeof(returnt),  "Pizza Worker"); }
		case 156	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 157	: { format(returnt,sizeof(returnt),  "Farmer"); }
		case 158	: { format(returnt,sizeof(returnt),  "Farmer"); }
		case 159	: { format(returnt,sizeof(returnt),  "Farmer"); }
		case 160	: { format(returnt,sizeof(returnt),  "Farmer"); }
		case 161	: { format(returnt,sizeof(returnt),  "Farmer"); }
		case 162	: { format(returnt,sizeof(returnt),  "Farmer"); }
		case 163	: { format(returnt,sizeof(returnt),  "Bouncer"); }
		case 164	: { format(returnt,sizeof(returnt),  "Bouncer"); }
		case 165	: { format(returnt,sizeof(returnt),  "MIB Agent"); }
		case 166	: { format(returnt,sizeof(returnt),  "MIB Agent"); }
		case 167	: { format(returnt,sizeof(returnt),  "Cluckin' Bell"); }
		case 168	: { format(returnt,sizeof(returnt),  "Food Vendor"); }
		case 169	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 170	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 171	: { format(returnt,sizeof(returnt),  "Casino Worker"); }
		case 172	: { format(returnt,sizeof(returnt),  "Hotel Assistant"); }
		case 173	: { format(returnt,sizeof(returnt),  "Rifa Member"); }
		case 174	: { format(returnt,sizeof(returnt),  "Rifa Member"); }
		case 175	: { format(returnt,sizeof(returnt),  "Rifa Member"); }
		case 176	: { format(returnt,sizeof(returnt),  "Tatoo Worker"); }
		case 177	: { format(returnt,sizeof(returnt),  "Tatoo Worker"); }
		case 178	: { format(returnt,sizeof(returnt),  "Whore"); }
		case 179	: { format(returnt,sizeof(returnt),  "Ammu-Nation Salesmen"); }
		case 180	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 181	: { format(returnt,sizeof(returnt),  "Punker"); }
		case 182	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 183	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 184	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 185	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 186	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 187	: { format(returnt,sizeof(returnt),  "Buisnessman"); }
		case 188	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 189	: { format(returnt,sizeof(returnt),  "Valet"); }
		case 190	: { format(returnt,sizeof(returnt),  "Barbara Schternvart"); }
		case 191	: { format(returnt,sizeof(returnt),  "Helena Wankstein"); }
		case 192	: { format(returnt,sizeof(returnt),  "Michelle Cannes"); }
		case 193	: { format(returnt,sizeof(returnt),  "Katie Zhan"); }
		case 194	: { format(returnt,sizeof(returnt),  "Millie Perkins"); }
		case 195	: { format(returnt,sizeof(returnt),  "Denise Robinson"); }
		case 196	: { format(returnt,sizeof(returnt),  "Farm-Town inhabitant"); }
		case 197	: { format(returnt,sizeof(returnt),  "Farm-Town inhabitant"); }
		case 198	: { format(returnt,sizeof(returnt),  "Farm-Town inhabitant"); }
		case 199	: { format(returnt,sizeof(returnt),  "Farm-Town inhabitant"); }
		case 200	: { format(returnt,sizeof(returnt),  "Farmer"); }
		case 201	: { format(returnt,sizeof(returnt),  "Farmer"); }
		case 202	: { format(returnt,sizeof(returnt),  "Farmer"); }
		case 203	: { format(returnt,sizeof(returnt),  "Karate Teacher"); }
		case 204	: { format(returnt,sizeof(returnt),  "Karate Teacher"); }
		case 205	: { format(returnt,sizeof(returnt),  "Burger Shot Cashier"); }
		case 206	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 207	: { format(returnt,sizeof(returnt),  "Prostitute"); }
		case 208	: { format(returnt,sizeof(returnt),  "Well Stacked Pizza"); }
		case 209	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 210	: { format(returnt,sizeof(returnt),  "INVALID_SKIN_ID"); }
		case 211	: { format(returnt,sizeof(returnt),  "Shop Staff"); }
		case 212	: { format(returnt,sizeof(returnt),  "Homeless"); }
		case 213	: { format(returnt,sizeof(returnt),  "Weird old man"); }
		case 214	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 215	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 216	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 217	: { format(returnt,sizeof(returnt),  "Shop Staff"); }
		case 218	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 219	: { format(returnt,sizeof(returnt),  "Secretary"); }
		case 220	: { format(returnt,sizeof(returnt),  "Taxi Driver"); }
		case 221	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 222	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 223	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 224	: { format(returnt,sizeof(returnt),  "Sofori"); }
		case 225	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 226	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 227	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 228	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 229	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 230	: { format(returnt,sizeof(returnt),  "Homeless"); }
		case 231	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 232	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 233	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 234	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 235	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 236	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 237	: { format(returnt,sizeof(returnt),  "Prostitute"); }
		case 238	: { format(returnt,sizeof(returnt),  "Prostitute"); }
		case 239	: { format(returnt,sizeof(returnt),  "Homeless"); }
		case 240	: { format(returnt,sizeof(returnt),  "The D.A"); }
		case 241	: { format(returnt,sizeof(returnt),  "Afro-American"); }
		case 242	: { format(returnt,sizeof(returnt),  "Mexican"); }
		case 243	: { format(returnt,sizeof(returnt),  "Prostitute"); }
		case 244	: { format(returnt,sizeof(returnt),  "Whore"); }
		case 245	: { format(returnt,sizeof(returnt),  "Prostitute"); }
		case 246	: { format(returnt,sizeof(returnt),  "Whore"); }
		case 247	: { format(returnt,sizeof(returnt),  "Biker"); }
		case 248	: { format(returnt,sizeof(returnt),  "Biker"); }
		case 249	: { format(returnt,sizeof(returnt),  "Pimp"); }
		case 250	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 251	: { format(returnt,sizeof(returnt),  "Beach Visitor"); }
		case 252	: { format(returnt,sizeof(returnt),  "Naked Valet"); }
		case 253	: { format(returnt,sizeof(returnt),  "Bus Driver"); }
		case 254	: { format(returnt,sizeof(returnt),  "Drug Dealer"); }
		case 255	: { format(returnt,sizeof(returnt),  "Limo Driver"); }
		case 256	: { format(returnt,sizeof(returnt),  "Whore"); }
		case 257	: { format(returnt,sizeof(returnt),  "Whore"); }
		case 258	: { format(returnt,sizeof(returnt),  "Golfer"); }
		case 259	: { format(returnt,sizeof(returnt),  "Golfer"); }
		case 260	: { format(returnt,sizeof(returnt),  "Construction Site"); }
		case 261	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 262	: { format(returnt,sizeof(returnt),  "Taxi Driver"); }
		case 263	: { format(returnt,sizeof(returnt),  "Normal Ped"); }
		case 264	: { format(returnt,sizeof(returnt),  "Clown"); }
		case 265	: { format(returnt,sizeof(returnt),  "Tenpenny"); }
		case 266	: { format(returnt,sizeof(returnt),  "Pulaski"); }
		case 267	: { format(returnt,sizeof(returnt),  "Frank Tenpenny"); }
		case 268	: { format(returnt,sizeof(returnt),  "Dwaine"); }
		case 269	: { format(returnt,sizeof(returnt),  "Melvin Big Smoke Harris"); }
		case 270	: { format(returnt,sizeof(returnt),  "Sweet "); }
		case 271	: { format(returnt,sizeof(returnt),  "Lance Ryder Wilson"); }
		case 272	: { format(returnt,sizeof(returnt),  "Mafia Boss"); }
		case 273	: { format(returnt,sizeof(returnt),  "INVALID_SKIN_ID"); }
		case 274	: { format(returnt,sizeof(returnt),  "Paramedic"); }
		case 275	: { format(returnt,sizeof(returnt),  "Paramedic"); }
		case 276	: { format(returnt,sizeof(returnt),  "Paramedic"); }
		case 277	: { format(returnt,sizeof(returnt),  "Firefighter"); }
		case 278	: { format(returnt,sizeof(returnt),  "Firefighter"); }
		case 279	: { format(returnt,sizeof(returnt),  "Firefighter"); }
		case 280	: { format(returnt,sizeof(returnt),  "Los Santos Police"); }
		case 281	: { format(returnt,sizeof(returnt),  "San Fierro Police"); }
		case 282	: { format(returnt,sizeof(returnt),  "Las Venturas Police"); }
		case 283	: { format(returnt,sizeof(returnt),  "Country Sheriff"); }
		case 284	: { format(returnt,sizeof(returnt),  "San Andreas Police Dept."); }
		case 285	: { format(returnt,sizeof(returnt),  "S.W.A.T Special Forces"); }
		case 286	: { format(returnt,sizeof(returnt),  "Federal Agents"); }
		case 287	: { format(returnt,sizeof(returnt),  "San Andreas Army"); }
		case 288	: { format(returnt,sizeof(returnt),  "Desert Sheriff"); }
		case 289	: { format(returnt,sizeof(returnt),  "INVALID_SKIN_ID"); }
		case 290	: { format(returnt,sizeof(returnt),  "Ken Rosenberg"); }
		case 291	: { format(returnt,sizeof(returnt),  "Desert Sheriff"); }
		case 292	: { format(returnt,sizeof(returnt),  "Cesar Vialpando"); }
		case 293	: { format(returnt,sizeof(returnt),  "Jeffrey OG Loc Cross"); }
		case 294	: { format(returnt,sizeof(returnt),  "Wu Zi Mu (Woozie)"); }
		case 295	: { format(returnt,sizeof(returnt),  "Michael Toreno"); }
		case 296	: { format(returnt,sizeof(returnt),  "Jizzy B."); }
		case 297	: { format(returnt,sizeof(returnt),  "Madd Dogg"); }
		case 298	: { format(returnt,sizeof(returnt),  "Catalina"); }
		case 299	: { format(returnt,sizeof(returnt),  "Claude"); }
		default: { format(returnt,sizeof(returnt),  "INVALID_SKIN_ID"); }
	return returnt;
new AllCars[93] = {
400,401,402,404,405,410,411,412,415,418,419,420,421,422,424,426,429,434,436,
438,439,442,445,451,458,466,467,470,474,475,477,478,480,480,480,480,489,490,
491,492,494,496,500,501,502,503,504,505,506,507,516,517,518,526,527,529,533,
534,535,536,540,541,542,543,545,546,547,549,550,551,555,558,559,560,561,562,
565,566,567,575,576,580,585,587,589,596,597,598,600,602,603,604,605};
forward CountNext();
public CountNext()
	if(!AnkietaON) return 1;
	new string[128];
	AnkietaPozostalo --;
	format(string, sizeof(string), "%s ~n~~y~%d ~w~I ~g~~h~/TAK ~w~- %d ~r~~h~/NIE ~w~- %d",AnkietaPytanie,AnkietaPozostalo,LiczbaTak,LiczbaNie);
	TextDrawSetString(AnkietaDraw,string);
	if(AnkietaPozostalo <= 0)
		if(LiczbaTak > LiczbaNie){
			format(string, sizeof(string), "%s ~n~~g~~h~TAK ~w~- %d glosow",AnkietaPytanie,LiczbaTak);
		else if(LiczbaTak < LiczbaNie){
			format(string, sizeof(string), "%s ~n~~r~~h~NIE ~w~- %d glosow",AnkietaPytanie,LiczbaNie);
		else if(LiczbaTak == LiczbaNie){
			format(string, sizeof(string), "%s ~n~~b~~h~REMIS ~w~- %d/%d",AnkietaPytanie,LiczbaTak,LiczbaNie);
        TextDrawSetString(AnkietaDraw,string);
		SetTimer("AnkietaWylacz",5000,0);
	else
		SetTimer("CountNext",1000,0);
	return 1;
DestroyVehicleEx(vehicleid)
	DestroyNeon(vehicleid);
	DestroyVehicle(vehicleid);
	return 1;
//#define DestroyVehicle DestroyVehicleEx
DestroyNeon(vehicleid)
	if(vNeon[vehicleid][0] != -1)
		DestroyObject(vNeon[vehicleid][0]);
		vNeon[vehicleid][0] = -1;
	if(vNeon[vehicleid][1] != -1)
		DestroyObject(vNeon[vehicleid][1]);
		vNeon[vehicleid][1] = -1;
	return 1;
forward AnkietaWylacz();
public AnkietaWylacz()
	TextDrawSetString(AnkietaDraw,"_");
	TextDrawHideForAll(AnkietaDraw);
	AnkietaON = false;
	AnkietaPozostalo = 0;
	return 1;
forward JailTextUnlock(playerid);
public JailTextUnlock(playerid)
	JailText[playerid] = false;
	return 1;
LoadBiznes()
    print("[GS:Biznes] Rozpoczeto ladowanie biznesow");
	new Query[128],String[128],bIDx,bNamex[32],bOwnerx[20],bCashx,Float:bXx,Float:bYx,Float:bZx;
	mysql_query("SELECT * FROM `"PREFIX"Biznesy` WHERE `bID` < "#MAX_BIZNES" ORDER BY bID");
	mysql_store_result();
    if(mysql_num_rows() > 0)
        while(mysql_fetch_row(Query))
            sscanf(Query, "p<|>ds[32]s[20]dfff",bIDx,bNamex,bOwnerx,bCashx,bXx,bYx,bZx);
            printf("[GS:Biznes] Ladowanie biznesu ID: %d", bIDx);
            bInfo[bIDx][bID] = bIDx;
			bInfo[bIDx][bName] = bNamex;
            bInfo[bIDx][bOwner] = bOwnerx;
			bInfo[bIDx][bCash] = bCashx;
			bInfo[bIDx][bX] = bXx;
            bInfo[bIDx][bY] = bYx;
            bInfo[bIDx][bZ] = bZx;
            bInfo[bIDx][bPickup] = CreateDynamicPickup(1274, 1, bInfo[bIDx][bX], bInfo[bIDx][bY],bInfo[bIDx][bZ], 0, 0, -1, 60.0);
			if(bInfo[bIDx][bOwner] == '0')
				format(String,sizeof(String), "[BIZNES]\n{61C900}%s - %d$\nNa sprzedaż", bInfo[bIDx][bName],bInfo[bIDx][bCash]);
				bInfo[bIDx][bLabel] = CreateDynamic3DTextLabel(String, 0xFFFFFFFF, bInfo[bIDx][bX], bInfo[bIDx][bY],bInfo[bIDx][bZ], 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 20.0);
			else
                format(String,sizeof(String), "[BIZNES]\n{61C900}%s - %d$\nWłaściciel: %s", bInfo[bIDx][bName],bInfo[bIDx][bCash],bInfo[bIDx][bOwner]);
				bInfo[bIDx][bLabel] = CreateDynamic3DTextLabel(String, 0xFFFFFFFF, bInfo[bIDx][bX], bInfo[bIDx][bY],bInfo[bIDx][bZ], 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 20.0);
			TotalBiznes ++;
 	mysql_free_result();
	printf("[GS:Biznes] Zaladowano %d biznesow!",TotalBiznes);
LoadPrivateVehicles()
    print("[GS:PVehicles] Rozpoczeto ladowanie prywatnych pojazdow");
    TotalPrivCars = 0;
    for(new x=0;x<MAX_PRIVATE_VEHICLES;x++)
        vInfo[x][vID] = CreateVehicle(481,0.0,0.0,0.0,0.0,0,0, 9999);
		SetVehicleVirtualWorld(vInfo[x][vID],17);
	new Query[300],String[128],vIDx,vModelx,vOwnerx[24],Float:vPosXx,Float:vPosYx,Float:vPosZx,Float:vAnglex,vColor1x,vColor2x,vPrzebiegx,vPaintJobx;
	new SPOILERx,HOODx,ROOFx,SIDESKIRTx,LAMPSx,EXHAUSTx,WHEELSx,STEREOx,HYDRAULICSx,FRONT_BUMPERx,REAR_BUMPERx,VENT_RIGHTx,VENT_LEFTx;
    if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	mysql_query("SELECT * FROM `"PREFIX"Vehicles` WHERE `vID` < "#MAX_PRIVATE_VEHICLES" ORDER BY vID");
	mysql_store_result();
    if(mysql_num_rows() > 0)
        while(mysql_fetch_row(Query))
			sscanf(Query, "p<|>dds[23]ffffddddddddddddddddd",
			vIDx,vModelx,vOwnerx,vPosXx,vPosYx,vPosZx,vAnglex,vColor1x,vColor2x,vPrzebiegx,vPaintJobx,SPOILERx,HOODx,ROOFx,SIDESKIRTx,LAMPSx,EXHAUSTx,WHEELSx,STEREOx,HYDRAULICSx,FRONT_BUMPERx,REAR_BUMPERx,VENT_RIGHTx,VENT_LEFTx);
            printf("[GS:PVehicles] Ladowanie pojazdu ID: %d", vIDx);
            vInfo[vIDx][vID] = vIDx;
			vInfo[vIDx][vModel] = vModelx;
			format(vInfo[vIDx][vOwner],24,vOwnerx);
            vInfo[vIDx][vPosX] = vPosXx;
            vInfo[vIDx][vPosY] = vPosYx;
            vInfo[vIDx][vPosZ] = vPosZx;
            vInfo[vIDx][vAngle] = vAnglex;
			vInfo[vIDx][vColor1] = vColor1x;
            vInfo[vIDx][vColor2] = vColor2x;
            vInfo[vIDx][vPrzebieg] = vPrzebiegx;
		    vInfo[vIDx][vPaintJob] = vPaintJobx;
		    vInfo[vIDx][SPOILER] = SPOILERx;
		    vInfo[vIDx][HOOD] = HOODx;
		    vInfo[vIDx][ROOF] = ROOFx;
		    vInfo[vIDx][SIDESKIRT] = SIDESKIRTx;
		    vInfo[vIDx][LAMPS] = LAMPSx;
		    vInfo[vIDx][EXHAUST] = EXHAUSTx;
            vInfo[vIDx][WHEELS] = WHEELSx;
            vInfo[vIDx][STEREO] = STEREOx;
            vInfo[vIDx][HYDRAULICS] = HYDRAULICSx;
            vInfo[vIDx][FRONT_BUMPER] = FRONT_BUMPERx;
            vInfo[vIDx][REAR_BUMPER] = REAR_BUMPERx;
            vInfo[vIDx][VENT_RIGHT] = VENT_RIGHTx;
            vInfo[vIDx][VENT_LEFT] = VENT_LEFTx;
            TotalPrivCars ++;
    		DestroyVehicleEx(vInfo[vIDx][vID]);
			vInfo[vIDx][vID] = CreateVehicle(vInfo[vIDx][vModel],vInfo[vIDx][vPosX],vInfo[vIDx][vPosY],vInfo[vIDx][vPosZ],vInfo[vIDx][vAngle],vInfo[vIDx][vColor1],vInfo[vIDx][vColor2], 9999);
            SetVehicleVirtualWorld(vInfo[vIDx][vID], 17);
			format(String,sizeof(String),"Właściciel: {9eae41}%s\n{c3c3c3}Przebieg: {9eae41}%.1f km.",vInfo[vIDx][vOwner],vInfo[vIDx][vPrzebieg]/1000.0);
			vInfo[vIDx][vLabel] = Create3DTextLabel(String, 0xc3c3c3FF, 0.0, 0.0, 0.0, 10.0, 0, 0);
			Attach3DTextLabelToVehicle(vInfo[vIDx][vLabel], vInfo[vIDx][vID], 0.0, 0.0, 0.5);
			if(IsVehicleValidComponent(vInfo[vIDx][vID],vInfo[vIDx][SPOILER]))
				AddVehicleComponent(vInfo[vIDx][vID], vInfo[vIDx][SPOILER]);
			if(IsVehicleValidComponent(vInfo[vIDx][vID],vInfo[vIDx][HOOD]))
				AddVehicleComponent(vInfo[vIDx][vID], vInfo[vIDx][HOOD]);
			if(IsVehicleValidComponent(vInfo[vIDx][vID],vInfo[vIDx][ROOF]))
				AddVehicleComponent(vInfo[vIDx][vID], vInfo[vIDx][ROOF]);
            if(IsVehicleValidComponent(vInfo[vIDx][vID],vInfo[vIDx][SIDESKIRT]))
				AddVehicleComponent(vInfo[vIDx][vID], vInfo[vIDx][SIDESKIRT]);
            if(IsVehicleValidComponent(vInfo[vIDx][vID],vInfo[vIDx][LAMPS]))
				AddVehicleComponent(vInfo[vIDx][vID], vInfo[vIDx][LAMPS]);
            if(IsVehicleValidComponent(vInfo[vIDx][vID],vInfo[vIDx][EXHAUST]))
				AddVehicleComponent(vInfo[vIDx][vID], vInfo[vIDx][EXHAUST]);
            if(IsVehicleValidComponent(vInfo[vIDx][vID],vInfo[vIDx][WHEELS]))
				AddVehicleComponent(vInfo[vIDx][vID], vInfo[vIDx][WHEELS]);
            if(IsVehicleValidComponent(vInfo[vIDx][vID],vInfo[vIDx][STEREO]))
				AddVehicleComponent(vInfo[vIDx][vID], vInfo[vIDx][STEREO]);
            if(IsVehicleValidComponent(vInfo[vIDx][vID],vInfo[vIDx][HYDRAULICS]))
				AddVehicleComponent(vInfo[vIDx][vID], vInfo[vIDx][HYDRAULICS]);
            if(IsVehicleValidComponent(vInfo[vIDx][vID],vInfo[vIDx][FRONT_BUMPER]))
				AddVehicleComponent(vInfo[vIDx][vID], vInfo[vIDx][FRONT_BUMPER]);
            if(IsVehicleValidComponent(vInfo[vIDx][vID],vInfo[vIDx][REAR_BUMPER]))
				AddVehicleComponent(vInfo[vIDx][vID], vInfo[vIDx][REAR_BUMPER]);
            if(IsVehicleValidComponent(vInfo[vIDx][vID],vInfo[vIDx][VENT_RIGHT]))
				AddVehicleComponent(vInfo[vIDx][vID], vInfo[vIDx][VENT_RIGHT]);
            if(IsVehicleValidComponent(vInfo[vIDx][vID],vInfo[vIDx][VENT_LEFT]))
				AddVehicleComponent(vInfo[vIDx][vID], vInfo[vIDx][VENT_LEFT]);
            if(IsVehicleValidPaintJob(vInfo[vIDx][vID],vPaintJob))
				ChangeVehiclePaintjob(vInfo[vIDx][vID], vPaintJobx);
	mysql_free_result();
    for(new x=0;x<MAX_PRIVATE_VEHICLES;x++)
        Attach3DTextLabelToVehicle(vInfo[x][vLabel],vInfo[x][vID],0.0, 0.0, 0.5);
	printf("[GS:PVehicles] Zaladowano %d prywatnych pojazdow!",TotalPrivCars);
LoadHouses()
    print("[GS:Domy] Rozpoczeto ladowanie domow");
	TotalHouses = 0;
    for(new x=0;x<MAX_HOUSES;x++)
		DestroyDynamicPickup(hInfo[x][hPickup]);
		DestroyDynamicMapIcon(hInfo[x][hIcon]);
        DestroyDynamic3DTextLabel(hInfo[x][hLabel]);
	if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	new Query[300],String[155],hIDx,hNamex[33],hOwnerx[24],Float:hOutXx,Float:hOutYx,Float:hOutZx,Float:hInXx,Float:hInYx,Float:hInZx,hLockedx,hCzynszx,hWaznoscx,hInteriorx;
	new Float:hAnglex;
	mysql_query("SELECT * FROM `"PREFIX"Houses` WHERE `hID` < "#MAX_HOUSES" ORDER BY hID");
	mysql_store_result();
    if(mysql_num_rows() > 0)
        while(mysql_fetch_row(Query))
            sscanf(Query, "p<|>ds[32]s[23]ffffffddddf",hIDx,hNamex,hOwnerx,hOutXx,hOutYx,hOutZx,hInXx,hInYx,hInZx,hLockedx,hCzynszx,hWaznoscx,hInteriorx,hAnglex);
            printf("[GS:Domy] Ladowanie domu ID: %d", hIDx);
            hInfo[hIDx][hID] = hIDx;
			format(hInfo[hIDx][hName],33,hNamex);
            format(hInfo[hIDx][hOwner],24,hOwnerx);
            hInfo[hIDx][hOutX] = hOutXx;
            hInfo[hIDx][hOutY] = hOutYx;
            hInfo[hIDx][hOutZ] = hOutZx;
            hInfo[hIDx][hInX] = hInXx;
            hInfo[hIDx][hInY] = hInYx;
            hInfo[hIDx][hInZ] = hInZx;
            hInfo[hIDx][hLocked] = hLockedx;
            hInfo[hIDx][hCzynsz] = hCzynszx;
            hInfo[hIDx][hWaznosc] = hWaznoscx;
			hInfo[hIDx][hInterior] = hInteriorx;
			hInfo[hIDx][hAngle] = hAnglex;
			if(hInfo[hIDx][hOwner] == '0')
				format(String,sizeof(String), "%s\nKoszt: %d exp", hInfo[hIDx][hName], hInfo[hIDx][hCzynsz]);
				hInfo[hIDx][hPickup] = CreateDynamicPickup(1273, 1, hInfo[hIDx][hOutX], hInfo[hIDx][hOutY], hInfo[hIDx][hOutZ], 0, 0, -1, 60.0);
				hInfo[hIDx][hLabel] = CreateDynamic3DTextLabel(String, 0xFFB400FF, hInfo[hIDx][hOutX], hInfo[hIDx][hOutY], hInfo[hIDx][hOutZ], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 30.0);
				hInfo[hIDx][hIcon] = CreateDynamicMapIcon(hInfo[hIDx][hOutX], hInfo[hIDx][hOutY], hInfo[hIDx][hOutZ], 31, -1, 0, 0, -1, 1000000.0);
			else
                format(String,sizeof(String), "%s\nWłaściciel: %s", hInfo[hIDx][hName], hInfo[hIDx][hOwner]);
				hInfo[hIDx][hPickup] = CreateDynamicPickup(1272, 1, hInfo[hIDx][hOutX], hInfo[hIDx][hOutY], hInfo[hIDx][hOutZ], 0, 0, -1, 60.0);
				hInfo[hIDx][hLabel] = CreateDynamic3DTextLabel(String, 0xFFB400FF, hInfo[hIDx][hOutX], hInfo[hIDx][hOutY], hInfo[hIDx][hOutZ], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 30.0);
				hInfo[hIDx][hIcon] = CreateDynamicMapIcon(hInfo[hIDx][hOutX], hInfo[hIDx][hOutY], hInfo[hIDx][hOutZ], 32, -1, 0, 0, -1, 1000000.0);
			TotalHouses ++;
	mysql_free_result();
	printf("[GS:Domy] Zaladowano %d domow!",TotalHouses);
LoadGangs()
    print("[GS:Gangs] Rozpoczeto ladowanie gangow");
	new Query[300],gIDx,gNamex[50],gSzefx[30],gVicex[30],gTagx[10],gColorx[15],gCarx,gSkinx,gEnterx[50],gInx[50],gInteriorx;
	mysql_query("SELECT * FROM `"PREFIX"Gangi` WHERE `gID` < "#MAX_GANGS" ORDER BY gID");
	mysql_store_result();
    if(mysql_num_rows() > 0)
        while(mysql_fetch_row(Query))
			sscanf(Query, "p<|>ds[49]s[29]s[29]s[9]s[14]dds[49]s[49]d",gIDx,gNamex,gSzefx,gVicex,gTagx,gColorx,gCarx,gSkinx,gEnterx,gInx,gInteriorx);
            printf("[GS:Gangs] Ladowanie gangu ID: %d", gIDx);
            gInfo[gIDx][gID] = gIDx;
			format(gInfo[gIDx][gName],50,gNamex);
			format(gInfo[gIDx][gSzef],30,gSzefx);
			format(gInfo[gIDx][gVice],30,gVicex);
            format(gInfo[gIDx][gKolorChat],32,gColorx);
            strins(gColorx, "0x", 0);
   			strins(gColorx, "FF", 8);
            gInfo[gIDx][gColor] = HexToInt(gColorx);
            for(new x=0;x<sizeof(playerColors);x++)
				if(gInfo[gIDx][gColor] == playerColors[x])
					gInfo[gIDx][gColorZone] = playerColorsZone[x];
			gInfo[gIDx][gCar] = gCarx;
			gInfo[gIDx][gSkin] = gSkinx;
            format(gInfo[gIDx][gTag],10,gTagx);
			sscanf(gEnterx,"p<,>fff",gInfo[gIDx][gEnterX],gInfo[gIDx][gEnterY],gInfo[gIDx][gEnterZ]);
            sscanf(gInx,"p<,>fff",gInfo[gIDx][gInX],gInfo[gIDx][gInY],gInfo[gIDx][gInZ]);
			gInfo[gIDx][gInterior] = gInteriorx;
            if(gInfo[gIDx][gEnterX] != 0.0)
				gInfo[gIDx][gEnterPickup] = CreateDynamicPickup(19135,1,gInfo[gIDx][gEnterX],gInfo[gIDx][gEnterY],gInfo[gIDx][gEnterZ],0,0,-1,60.0);
				format(Query,sizeof(Query),"{%s}%s",gInfo[gIDx][gKolorChat],gNamex);
				gInfo[gIDx][gEnterLabel] = CreateDynamic3DTextLabel(Query, 0xFFFFFFFF,gInfo[gIDx][gEnterX],gInfo[gIDx][gEnterY],gInfo[gIDx][gEnterZ], 40.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 40.0);
	TotalGangs = mysql_num_rows();
    printf("[GS:Gangs] Zaladowano %d gangow!",TotalGangs);
	mysql_free_result();
stock UnCagePlayer(playerid)
    cage[playerid] = DestroyObject(cage[playerid]);
    caged[playerid] = 0;
IsValidSkin(skinid)
	switch(skinid)
		case 3, 4, 5, 6, 8, 42, 65, 74, 86, 119, 149, 208, 273, 289:
			return 0;
	return 1;
stock SetGangSzef(gangid,gangszef[])
	new String[155];
	format(String,sizeof(String),"UPDATE `"PREFIX"Gangi` SET gSzef='%s' WHERE gID='%d'",gangszef,gangid);
	mysql_query(String);
	format(gInfo[gangid][gSzef],29,gangszef);
    new SzefId = GetPlayerIdFromName(gangszef);
    format(String,sizeof(String),"Mianowano cię {FF0000}Szefem "GUI"gangu %s!\n\nPanel zarządzania znajdziesz pod komendą /Gang.",gInfo[gangid][gName]);
    SPD(SzefId,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Awans!",String,"Zamknij","");
stock SetGangVice(gangid,gangvice[])
	new String[155];
	format(String,sizeof(String),"UPDATE `"PREFIX"Gangi` SET gVice='%s' WHERE gID='%d'",gangvice,gangid);
	mysql_query(String);
	format(gInfo[gangid][gVice],29,gangvice);
    new ViceId = GetPlayerIdFromName(gangvice);
	format(String,sizeof(String),"Mianowano cię {FFFF00}Vice-Szefem "GUI"gangu %s!\n\nPanel zarządzania znajdziesz pod komendą /Gang.",gInfo[gangid][gName]);
	SPD(ViceId,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Awans!",String,"Zamknij","");
stock SetGangEnterPos(gangid,Float:gangx,Float:gangy,Float:gangz)
	new String[175];
	format(String,sizeof(String),"UPDATE `"PREFIX"Gangi` SET gEnter='%f,%f,%f' WHERE gID='%d'",gangx,gangy,gangz,gangid);
	mysql_query(String);
	gInfo[gangid][gEnterX] = gangx;
    gInfo[gangid][gEnterY] = gangy;
    gInfo[gangid][gEnterZ] = gangz;
    DestroyDynamicPickup(gInfo[gangid][gEnterPickup]);
 	DestroyDynamic3DTextLabel(gInfo[gangid][gEnterLabel]);
 	format(String,sizeof(String),"{%s}%s",gInfo[gangid][gKolorChat],gInfo[gangid][gName]);
 	gInfo[gangid][gEnterPickup] = CreateDynamicPickup(19135,1,gInfo[gangid][gEnterX],gInfo[gangid][gEnterY],gInfo[gangid][gEnterZ],0,0,-1,60.0);
	gInfo[gangid][gEnterLabel] = CreateDynamic3DTextLabel(String,0xFFFFFFFF,gInfo[gangid][gEnterX],gInfo[gangid][gEnterY],gInfo[gangid][gEnterZ], 40.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 40.0);
stock SetGangExitPos(gangid,Float:gangx,Float:gangy,Float:gangz,interiorex)
	new String[155];
	format(String,sizeof(String),"UPDATE `"PREFIX"Gangi` SET gExit='%f,%f,%f',gInterior='%d' WHERE gID='%d'",gangx,gangy,gangz,interiorex,gangid);
	mysql_query(String);
	gInfo[gangid][gInX] = gangx;
    gInfo[gangid][gInY] = gangy;
    gInfo[gangid][gInZ] = gangz;
	gInfo[gangid][gInterior] = interiorex;
stock SetGangTag(gangid,gangtag[])
	new String[155];
	format(String,sizeof(String),"UPDATE `"PREFIX"Gangi` SET gTag='[%s]' WHERE gID='%d'",gangtag,gangid);
	mysql_query(String);
	format(gInfo[gangid][gTag],10,"[%s]",gangtag);
stock SetGangColor(gangid,color[])
	new Query[128],colorek[32];
	format(Query,sizeof(Query),"UPDATE "PREFIX"Gangi SET gColor='%s' WHERE gID='%d'",color,gangid);
	mysql_query(Query);
	format(colorek,sizeof(colorek),color);
    format(gInfo[gangid][gKolorChat],32,color);
	strins(colorek, "0x", 0);
	strins(colorek, "FF", 8);
	gInfo[gangid][gColor] = HexToInt(colorek);
	format(colorek,32,gInfo[gangid][gKolorChat]);
	strins(colorek, "0x", 0);
	strins(colorek, "88", 8);
	gInfo[gangid][gColorZone] = HexToInt(colorek);
	if(gInfo[gangid][gEnterX] != 0.0)
 		DestroyDynamic3DTextLabel(gInfo[gangid][gEnterLabel]);
		gInfo[gangid][gEnterLabel] = CreateDynamic3DTextLabel(gInfo[gangid][gName],gInfo[gangid][gColor],gInfo[gangid][gEnterX],gInfo[gangid][gEnterY],gInfo[gangid][gEnterZ], 40.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 40.0);
stock SetGangCar(gangid,gangcar)
	new Query[128];
	format(Query,sizeof(Query),"UPDATE "PREFIX"Gangi SET gCar='%d' WHERE gID='%d'",gangcar,gangid);
	mysql_query(Query);
	gInfo[gangid][gCar] = gangcar;
stock SetGangSkin(gangid,gangskin)
	new Query[128];
	format(Query,sizeof(Query),"UPDATE "PREFIX"Gangi SET gSkin='%d' WHERE gID='%d'",gangskin,gangid);
	mysql_query(Query);
	gInfo[gangid][gSkin] = gangskin;
stock DeleteGang(playerid,gangid)
    new String[128];
	TotalGangs --;
	if(gInfo[gangid][gVice][0] == 'B' && gInfo[gangid][gVice][1] == 'r' && gInfo[gangid][gVice][2] == 'a' && gInfo[gangid][gVice][3] == 'k')
		format(String,sizeof(String),"DELETE FROM `"PREFIX"Gangi` WHERE gID='%d'",gangid);
		mysql_query(String);
        format(String,sizeof(String),"UPDATE `"PREFIX"Gangi_Users` SET gID='-1',gZapro='-1',gName='-1' WHERE gID='%d'",gangid);
		mysql_query(String);
        gInfo[gangid][gID] = -1;
	    gInfo[gangid][gName][0] = EOS;
	    gInfo[gangid][gSzef][0] = EOS;
		gInfo[gangid][gVice][0] = EOS;
	    gInfo[gangid][gTag][0] = EOS;
        gInfo[gangid][gKolorChat][0] = EOS;
        gInfo[gangid][gSkin] = -1;
        gInfo[gangid][gCar] = -1;
		foreach(Player,x)
			if(Player[x][InGang] == gangid)
    			Player[x][InGang] = -1;
				SPD(x,D_NONE,DIALOG_STYLE_MSGBOX,"Informacja","Twój gang został usunięty przez szefa!","Zamknij","");
	else
	    SetGangSzef(gangid,gInfo[gangid][gVice]);
		SetGangVice(gangid,"Brak");
        Player[playerid][InGang] = -1;
        format(String,sizeof(String),"UPDATE `"PREFIX"Gangi_Users` SET gID='-1',gZapro='-1',gName='-1' WHERE gMember='%s'",Player[playerid][Name]);
		mysql_query(String);
stock CreateGang(playerid,gangname[],gangtag[],gangcolor[],gangcar,gangskin)
	new bool:Block = true,TabColor[32];
	TotalGangs ++;
	for(new x=0;x<MAX_GANGS;x++)
		if(!GangExists(x) && Block)
    		new String[255];
			format(String,sizeof(String),"INSERT INTO `"PREFIX"Gangi` VALUES ('%d','%s','%s','Brak','[%s]','%s','%d','%d','0.0,0.0,0.0','0.0,0.0,0.0','-1')",x,gangname,Player[playerid][Name],gangtag,gangcolor,gangcar,gangskin);
			mysql_query(String);
			if(GangAccountExists(Player[playerid][Name]))
                format(String,sizeof(String),"UPDATE `"PREFIX"Gangi_Users` SET gID='%d',gName='%s',gZapro='-1' WHERE gMember='%s'",x,gangname,Player[playerid][Name]);
			else
				format(String,sizeof(String),"INSERT INTO `"PREFIX"Gangi_Users` VALUES ('%d','%s','%s','-1')",x,Player[playerid][Name],gangname);
            mysql_query(String);
			gInfo[x][gID] = x;
			format(gInfo[x][gName],50,gangname);
			format(gInfo[x][gSzef],30,Player[playerid][Name]);
			format(gInfo[x][gVice],30,"Brak");
            format(gInfo[x][gTag],10,"[%s]",gangtag);
            format(TabColor,32,gangcolor);
            format(gInfo[x][gKolorChat],15,gangcolor);
            strins(TabColor, "0x", 0);
			strins(TabColor, "FF", 8);
		    gInfo[x][gColor] = HexToInt(TabColor);
			gInfo[x][gCar] = gangcar;
			gInfo[x][gSkin] = gangskin;
			gInfo[x][gInterior] = -1;
			gInfo[x][gEnterX] = 0.0;
            gInfo[x][gEnterY] = 0.0;
            gInfo[x][gEnterZ] = 0.0;
            gInfo[x][gInX] = 0.0;
            gInfo[x][gInY] = 0.0;
            gInfo[x][gInZ] = 0.0;
			Player[playerid][InGang] = x;
            Player[playerid][gZapro] = -1;
			Block = false;
stock AddPlayerToGang(gangid,playername[])
	new String[200];
	if(!GangAccountExists(playername))
		format(String,sizeof(String),"INSERT INTO `"PREFIX"Gangi_Users` VALUES ('%d','%s','%s','-1')",gangid,playername,gInfo[gangid][gName]);
	else
		format(String,sizeof(String),"UPDATE "PREFIX"Gangi_Users SET gZapro='-1',gName='%s',gID='%d' WHERE gMember='%s'",gInfo[gangid][gName],gangid,playername);
    mysql_query(String);
    new userid = GetPlayerIdFromName(playername);
	Player[userid][InGang] = gangid;
	Player[userid][gZapro] = -1;
	format(String,sizeof(String),"Gratulacje! Przyjęto cię do gangu %s!\n\nPanel członka pod komendą /Gang.",gInfo[gangid][gName]);
	SPD(userid,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Przyjęcie do gangu",String,"Zamknij","");
stock RemovePlayerFromGang(gangid,playername[])
	new String[155];
	format(String,sizeof(String),"UPDATE "PREFIX"Gangi_Users SET gZapro='-1',gName='-1',gID='-1' WHERE gMember='%s'",playername);
    mysql_query(String);
	if(strcmp(gInfo[gangid][gVice],playername) == 0)
        format(gInfo[gangid][gVice],15,"Brak");
    new userid = GetPlayerIdFromName(playername);
	Player[userid][InGang] = -1;
	Player[userid][gZapro] = -1;
	format(String,sizeof(String),"Wydalono cię z gangu %s.",gInfo[gangid][gName]);
	SPD(userid,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Informacja",String,"Zamknij","");
stock LeavePlayerFromGang(gangid,playerid)
	new String[155];
	format(String,sizeof(String),"UPDATE "PREFIX"Gangi_Users SET gZapro='-1',gName='-1',gID='-1' WHERE gMember='%s'",Player[playerid][Name]);
    mysql_query(String);
	Player[playerid][InGang] = -1;
	Player[playerid][gZapro] = -1;
	format(String,sizeof(String),"Odeszłeś z gangu %s.",gInfo[gangid][gName]);
	SPD(playerid,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Informacja",String,"Zamknij","");
	return 1;
stock IsPlayerInAnyGang(playerid)
	if(Player[playerid][InGang] > -1) return 1;
	return 0;
stock IsPlayerGangSzef(playerid)
    if(strcmp(gInfo[Player[playerid][InGang]][gSzef],Player[playerid][Name])==0) return 1;
	return 0;
stock IsPlayerGangVice(playerid)
	if(strcmp(gInfo[Player[playerid][InGang]][gVice],Player[playerid][Name])==0) return 1;
	return 0;
stock GangExists(gangid)
	new String[100];
	format(String, sizeof(String), "SELECT gID FROM "PREFIX"Gangi WHERE gID = '%d' LIMIT 1", gangid);
	mysql_query(String);
	mysql_store_result();
	new value;
	value = mysql_num_rows();
	mysql_free_result();
    return value;
stock GangAccountExists(playername[])
	new String3[155];
	format(String3, sizeof(String3),"SELECT `gMember` FROM "PREFIX"Gangi_Users WHERE gMember = '%s' LIMIT 1",playername);
	mysql_query(String3);
	mysql_store_result();
	new value;
	value = mysql_num_rows();
	mysql_free_result();
    return value;
stock GetGangsForPlayer(playerid,Delimiter[])
	new String[500],Query[500],OverFlow = 0;
	mysql_query("SELECT gName FROM "PREFIX"Gangi ORDER BY gID");
	mysql_store_result();
 	String="\0";
	while(mysql_fetch_row(Query))
  		strcat(String, "› ");
		strcat(String, Query);
		strcat(String, Delimiter);
    if(strlen(Query) < 4)
		SPD(playerid,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Lista gangów","Brak istniejących gangów na serwerze.","Zamknij","");
	else
		mysql_query("SELECT gID FROM "PREFIX"Gangi ORDER BY gID");
		mysql_store_result();
	    while(mysql_fetch_row(Query))
			Player[playerid][GetGangs][OverFlow] = strval(Query);
			OverFlow ++;
	mysql_free_result();
	return String;
stock GetZaproDoGangu(playerid,Delimiter[])
    new String[500],Query[500],OverFlow;
	format(String,sizeof(String),"SELECT gMember FROM "PREFIX"Gangi_Users WHERE gZapro = '%d'",Player[playerid][InGang]);
	mysql_query(String);
	mysql_store_result();
	String[0] = EOS;
 	String="\0";
	while(mysql_fetch_row(Query))
        format(GlobalGangBuffer[playerid][OverFlow],MAX_PLAYER_NAME,Query);
		strcat(String, "› ");
		strcat(String, Query);
		strcat(String, Delimiter);
		OverFlow ++;
	mysql_free_result();
    if(strlen(Query) < 4)
		SPD(playerid,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Prośby o dołączenie","Aktualnie brak próźb o dołączenie do gangu.","Zamknij","");
	return String;
stock GetGangMembersForPlayer(playerid,Delimiter[])
    new String[500],Query[500];
	format(String,sizeof(String),"SELECT gMember FROM "PREFIX"Gangi_Users WHERE gID = '%d'",Player[playerid][InGang]);
	mysql_query(String);
	mysql_store_result();
	String[0] = EOS;
 	String="\0";
	while(mysql_fetch_row(Query))
		strcat(String, "› ");
		strcat(String, Query);
		strcat(String, Delimiter);
	mysql_free_result();
	return String;
stock GetGangDegradeMembersForPlayer(playerid,Delimiter[])
    new String[500],Query[500],OverFlow;
	format(String,sizeof(String),"SELECT gMember FROM "PREFIX"Gangi_Users WHERE gID = '%d'",Player[playerid][InGang]);
	mysql_query(String);
	mysql_store_result();
	String[0] = EOS;
 	String="\0";
	while(mysql_fetch_row(Query))
        format(GlobalGangBuffer[playerid][OverFlow],MAX_PLAYER_NAME,Query);
		strcat(String, "› ");
		strcat(String, Query);
		strcat(String, Delimiter);
		OverFlow ++;
	mysql_free_result();
	return String;
stock GetGangPlayersCount(gangid)
	new Query[80];
	format(Query, sizeof(Query), "SELECT gID FROM "PREFIX"Gangi_Users WHERE gID = '%d'",gangid);
	mysql_query(Query);
	mysql_store_result();
	new rows = mysql_num_rows();
	mysql_free_result();
	return rows;
stock SetPlayerGangZapro(playerid,gangid)
	new String[155];
	format(String,sizeof(String),"UPDATE "PREFIX"Gangi_Users SET gZapro='%d' WHERE gMember='%s'",gangid,Player[playerid][Name]);
	mysql_query(String);
	Player[playerid][gZapro] = gangid;
CMD:rapts_o(playerid)
    GameTextForPlayer(playerid, "~n~Otwieranie Bramy", 2500, 5);
	MoveObject(brama, 1534.5000000, 2773.5000000, 6.8000002, 4); //pozycja otwartej bramy
	return 1;
CMD:rapts_z(playerid)
    GameTextForPlayer(playerid, "~n~Zamykanie Bramy", 2500, 5);
	MoveObject(brama, 1534.6999512, 2773.5000000, 12.5000000, 4); //pozycja zamknietej bramy
	return 1;
CMD:sklep(playerid)
	SPD(playerid,D_SKLEP,DIALOG_STYLE_LIST,"{00BFFF}Sklepik serwera","› Doładowanie portfela\n› VIP (1 miesiąc)\n› Moderator (1 miesiąc)","Wybierz","Zamknij");
	return 1;
CMD:t(playerid,cmdtext[])
	if(!IsPlayerInAnyGang(playerid)) return SCM(playerid,C_ERROR,""WE" "R"Nie jesteś w żadnym gangu!");
    new tmp[155];
	if(sscanf(cmdtext, "s[155]",tmp))
	    SCM(playerid, C_WHITE, ""I" "W"/t [tekst]");
	    return 1;
	format(tmp,sizeof(tmp),"[Gang-Chat] %s: %s",Player[playerid][Name],tmp);
	foreach(Player,x)
		if(Player[x][InGang] == Player[playerid][InGang])
			SCM(x,gInfo[Player[playerid][InGang]][gColor],tmp);
	return 1;
CMD:f(playerid,cmdtext[])
	return cmd_t(playerid,cmdtext);
CMD:takegunday(playerid)
	if(!IsPlayerAdmin(playerid)) return 1;
	SelectGunDay();
	new String[128];
	format(String,sizeof(String),"UPDATE "PREFIX"Config SET GunDay='%d'",GunDay);
	mysql_query(String);
	return 1;
CMD:gang(playerid)
	if(IsPlayerInAnyGang(playerid))
        new String[55];
        if(IsPlayerGangSzef(playerid))
            format(String,sizeof(String),"{00BFFF}Szef - %s",gInfo[Player[playerid][InGang]][gName]);
  			SPD(playerid,D_CONTROL_GANG_SZEF,DIALOG_STYLE_LIST,String,
			"› Zobacz prośby o dołączenie\n› Lista członków\n› Wyrzuć członka\n› Zmień Vice-Szefa gangu\n› Zmień tag gangu\n› Zmień kolor gangu\n› Zmień pojazd gangowy\n› Zmień skin gangu\n› Ustaw wejście do siedziby gangu\n› Ustaw wnętrze siedziby gangu\n› Usuń gang\n› Zmień swój skin na gangowy\n› Zmień kolor nicku na barwy gangu\n› Teleportuj przed siedzibę\n› Zrespawnuj pojazd gangowy\n› Dodaj tag gangu do nicku\n› Informacje o gangu","Wybierz","Zamknij");
        else if(IsPlayerGangVice(playerid))
            format(String,sizeof(String),"{00BFFF}Vice - %s",gInfo[Player[playerid][InGang]][gName]);
			SPD(playerid,D_CONTROL_GANG_VICE,DIALOG_STYLE_LIST,String,
			"› Zobacz prośby o dołączenie\n› Lista członków\n› Wyrzuć członka\n"GUI2"› Zmień swój skin na gangowy\n› Zmień kolor nicku na barwy gangu\n›  Teleportuj przed siedzibę\n› Zrespawnuj pojazd gangowy\n› Dodaj tag  gangu do nicku\n› Informacje o gangu\n› Odejdź z gangu","Wybierz","Zamknij");
        else
            format(String,sizeof(String),"{00BFFF}Członek - %s",gInfo[Player[playerid][InGang]][gName]);
			SPD(playerid,D_CONTROL_GANG,DIALOG_STYLE_LIST,String,
			"› Lista członków\n› Zmień swój skin na gangowy\n› Zmień kolor nicku na barwy gangu\n› Teleportuj przed siedzibę\n› Zrespawnuj pojazd gangowy\n› Dodaj tag gangu do nicku\n› Informacje o gangu\n› Odejdź z gangu","Wybierz","Zamknij");
    else
        SPD(playerid,D_MENU_GANG,DIALOG_STYLE_LIST,"{00BFFF}Menu Gangów","› Dołącz do gangu\n"GUI2"› Stwórz gang (Kosztuje 10.000 exp)","Wybierz","Zamknij");
    return 1;
CMD:exit(playerid)
    if(GetPlayerVirtualWorld(playerid) != Player[playerid][InGang]+MAX_HOUSES) return SCM(playerid,C_RED,""WE" "R"Nie jesteś w siedzibie gangu.");
	new GangId = Player[playerid][InGang];
	SetPlayerPos(playerid,gInfo[GangId][gEnterX],gInfo[GangId][gEnterY],gInfo[GangId][gEnterZ]);
	SetPlayerInterior(playerid,0);
	SetPlayerVirtualWorld(playerid,0);
	return 1;
CMD:siedzibaexit(playerid)
	return cmd_exit(playerid);
CMD:gakceptuj(playerid)
	if(!Player[playerid][gAkceptEnabled]) return SCM(playerid,C_RED,""WE" "R"Nie włączyłeś opcji zmiany wejścia do siedziby.");
	if(GetPlayerInterior(playerid) != 0)
		SCM(playerid,C_WHITE,""I" "W"Siedzibę możesz zakładać tylko na zewnątrz.");
		return 1;
	new Float:LocalX,Float:LocalY,Float:LocalZ;
	GetPlayerPos(playerid,LocalX,LocalY,LocalZ);
	SetGangEnterPos(Player[playerid][InGang],LocalX,LocalY,LocalZ);
	Player[playerid][gAkceptEnabled] = false;
	SCM(playerid,C_WHITE,""I" "W"Zmieniono pozycję wejścia do siedziby.");
	return 1;
CMD:gakceptujinterior(playerid)
	if(!Player[playerid][gAkceptInteriorEnabled]) return SCM(playerid,C_RED,""WE" "R"Nie włączyłeś opcji zmiany wnętrza siedziby.");
	new localinterior = GetPlayerInterior(playerid);
	if(localinterior != 0)
 		new Float:LocalX,Float:LocalY,Float:LocalZ;
		GetPlayerPos(playerid,LocalX,LocalY,LocalZ);
		SetGangExitPos(Player[playerid][InGang],LocalX,LocalY,LocalZ,localinterior);
		Player[playerid][gAkceptInteriorEnabled] = false;
		SCM(playerid,C_WHITE,""I" "W"Zmieniono wnętrze siedziby gangu.");
    else
        SCM(playerid,C_WHITE,""I" "W"Nie możesz robić wnętrz na zewnątrz. Musisz znajdować się wewnątrz jakiegoś domu itp.");
	return 1;
stock AntiAdvertisement(string[])
	if(strfind(string,"91.",true)!=-1 || strfind(string,"178.",true)!=-1 || strfind(string,"195.",true)!=-1 || strfind(string,":7777",true)!=-1 || strfind(string,":8422",true)!=-1) return 1;
	return 0;
PlayCompleteMissionSound(playerid)
	if(Player[playerid][PlaySound] == 0 && !Player[playerid][FirstSpawn])
		PlayAudioStreamForPlayer(playerid, "http://www.goldserver.sa-mp.pl/upload/gs_complete_1.ogg");
		Player[playerid][PlaySound] = 10;
stock RemovePlayerWeapon(playerid, weaponid)
	new plyWeapons[12];
	new plyAmmo[12];
	for(new slot = 0; slot != 12; slot++)
		new wep, ammo;
		GetPlayerWeaponData(playerid, slot, wep, ammo);
		if(wep != weaponid)
			GetPlayerWeaponData(playerid, slot, plyWeapons[slot], plyAmmo[slot]);
	ResetPlayerWeapons(playerid);
	for(new slot = 0; slot != 12; slot++)
		GivePlayerWeapon(playerid, plyWeapons[slot], plyAmmo[slot]);
IsNumeric(const string[])
	for (new i = 0, j = strlen(string); i < j; i++)
		if (string[i] > '9' || string[i] < '0') return 0;
	return 1;
IsVehicleValidComponent(vehicleid, componentid)
	switch(GetVehicleModel(vehicleid))
 		case 560: // Sultan
     		switch(componentid)
         		case 1026,1027,1028,1029,1030,1031,1032,1033,1138,1139,1140,1141,1169,1170,1087,1008,1009,1010: return true; // Zwróci wartość logiczną true, gdy componentid ma wartość od 1 do 5.
           		default: return false; // Zwróci wartość logiczną false, gdy componentid ma wartość inną niż od 1 do 5.
        case 562: // Elegy
     		switch(componentid)
         		case 1034,1035,1036,1037,1038,1039,1040,1041,1146,1147,1148,1149,1171,1172,1087,1008,1009,1010: return true; // Zwróci wartość logiczną true, gdy componentid ma wartość od 1 do 5.
           		default: return false; // Zwróci wartość logiczną false, gdy componentid ma wartość inną niż od 1 do 5.
		case 561: // Stratum
     		switch(componentid)
         		case 1055,1056,1057,1058,1059,1060,1061,1062,1063,1064,1154,1155,1156,1157,1087,1008,1009,1010: return true; // Zwróci wartość logiczną true, gdy componentid ma wartość od 1 do 5.
           		default: return false; // Zwróci wartość logiczną false, gdy componentid ma wartość inną niż od 1 do 5.
        case 558: // Uranus
     		switch(componentid)
         		case 1088,1089,1090,1091,1092,1093,1094,1095,1163,1164,1165,1166,1167,1168,1087,1008,1009,1010: return true; // Zwróci wartość logiczną true, gdy componentid ma wartość od 1 do 5.
           		default: return false; // Zwróci wartość logiczną false, gdy componentid ma wartość inną niż od 1 do 5.
        case 559: // Jester
     		switch(componentid)
         		case 1065,1066,1067,1069,1070,1072,1158,1159,1160,1161,1162,1173,1087,1008,1009,1010: return true; // Zwróci wartość logiczną true, gdy componentid ma wartość od 1 do 5.
           		default: return false; // Zwróci wartość logiczną false, gdy componentid ma wartość inną niż od 1 do 5.
        case 565: // Flash
     		switch(componentid)
         		case 1045,1046,1047,1048,1049,1050,1052,1154,1150,1151,1152,1153,1087,1008,1009,1010: return true; // Zwróci wartość logiczną true, gdy componentid ma wartość od 1 do 5.
           		default: return false; // Zwróci wartość logiczną false, gdy componentid ma wartość inną niż od 1 do 5.
        case 575: // Broadway
     		switch(componentid)
         		case 1042,1043,1044,1099,1074,1075,1076,1077,1087,1008,1009,1010: return true; // Zwróci wartość logiczną true, gdy componentid ma wartość od 1 do 5.
           		default: return false; // Zwróci wartość logiczną false, gdy componentid ma wartość inną niż od 1 do 5.
        case 534: // Remington
     		switch(componentid)
         		case 1100,1101,1106,1022,1023,1024,1025,1026,1027,1078,1079,1080,1085,1087,1008,1009,1010: return true; // Zwróci wartość logiczną true, gdy componentid ma wartość od 1 do 5.
           		default: return false; // Zwróci wartość logiczną false, gdy componentid ma wartość inną niż od 1 do 5.
        case 536: // Blade
     		switch(componentid)
         		case 1103,1104,1105,1107,1108,1128,1181,1182,1183,1087,1008,1009,1010: return true; // Zwróci wartość logiczną true, gdy componentid ma wartość od 1 do 5.
           		default: return false; // Zwróci wartość logiczną false, gdy componentid ma wartość inną niż od 1 do 5.
        case 567: // Savanna
     		switch(componentid)
         		case 1102,1129,1130,1131,1132,1133,1186,1187,1188,1189,1008,1009,1010: return true; // Zwróci wartość logiczną true, gdy componentid ma wartość od 1 do 5.
           		default: return false; // Zwróci wartość logiczną false, gdy componentid ma wartość inną niż od 1 do 5.
        case 535: // Slamvan
     		switch(componentid)
         		case 1109,1110,1111,1112,1113,1114,1115,1116,1117,1118,1119,1120,1121,1087,1008,1009,1010: return true; // Zwróci wartość logiczną true, gdy componentid ma wartość od 1 do 5.
           		default: return false; // Zwróci wartość logiczną false, gdy componentid ma wartość inną niż od 1 do 5.
        case 576: // Tornado
     		switch(componentid)
         		case 1134,1135,1136,1137,1190,1191,1192,1193,1087,1008,1009,1010: return true; // Zwróci wartość logiczną true, gdy componentid ma wartość od 1 do 5.
           		default: return false; // Zwróci wartość logiczną false, gdy componentid ma wartość inną niż od 1 do 5.
	return false;
IsVehicleValidPaintJob(vehicleid, paintjobid)
	switch(GetVehicleModel(vehicleid))
 		case 560: // Sultan
     		switch(paintjobid)
         		case 0,1,2: return true; // Zwróci wartość logiczną true, gdy componentid ma wartość od 1 do 5.
           		default: return false; // Zwróci wartość logiczną false, gdy componentid ma wartość inną niż od 1 do 5.
        case 562: // Elegy
     		switch(paintjobid)
         		case 0,1,2: return true; // Zwróci wartość logiczną true, gdy componentid ma wartość od 1 do 5.
           		default: return false; // Zwróci wartość logiczną false, gdy componentid ma wartość inną niż od 1 do 5.
		case 561: // Stratum
     		switch(paintjobid)
         		case 0,1,2: return true; // Zwróci wartość logiczną true, gdy componentid ma wartość od 1 do 5.
           		default: return false; // Zwróci wartość logiczną false, gdy componentid ma wartość inną niż od 1 do 5.
        case 558: // Uranus
     		switch(paintjobid)
         		case 0,1,2: return true; // Zwróci wartość logiczną true, gdy componentid ma wartość od 1 do 5.
           		default: return false; // Zwróci wartość logiczną false, gdy componentid ma wartość inną niż od 1 do 5.
        case 559: // Jester
     		switch(paintjobid)
         		case 0,1,2: return true; // Zwróci wartość logiczną true, gdy componentid ma wartość od 1 do 5.
           		default: return false; // Zwróci wartość logiczną false, gdy componentid ma wartość inną niż od 1 do 5.
        case 565: // Flash
     		switch(paintjobid)
         		case 0,1,2: return true; // Zwróci wartość logiczną true, gdy componentid ma wartość od 1 do 5.
           		default: return false; // Zwróci wartość logiczną false, gdy componentid ma wartość inną niż od 1 do 5.
        case 575: // Broadway
     		switch(paintjobid)
         		case 0,1: return true; // Zwróci wartość logiczną true, gdy componentid ma wartość od 1 do 5.
           		default: return false; // Zwróci wartość logiczną false, gdy componentid ma wartość inną niż od 1 do 5.
        case 534: // Remington
     		switch(paintjobid)
         		case 0,1,2: return true; // Zwróci wartość logiczną true, gdy componentid ma wartość od 1 do 5.
           		default: return false; // Zwróci wartość logiczną false, gdy componentid ma wartość inną niż od 1 do 5.
        case 536: // Blade
     		switch(paintjobid)
         		case 0,1,2: return true; // Zwróci wartość logiczną true, gdy componentid ma wartość od 1 do 5.
           		default: return false; // Zwróci wartość logiczną false, gdy componentid ma wartość inną niż od 1 do 5.
        case 567: // Savanna
     		switch(paintjobid)
         		case 0,1,2: return true; // Zwróci wartość logiczną true, gdy componentid ma wartość od 1 do 5.
           		default: return false; // Zwróci wartość logiczną false, gdy componentid ma wartość inną niż od 1 do 5.
        case 535: // Slamvan
     		switch(paintjobid)
         		case 0,1,2: return true; // Zwróci wartość logiczną true, gdy componentid ma wartość od 1 do 5.
           		default: return false; // Zwróci wartość logiczną false, gdy componentid ma wartość inną niż od 1 do 5.
        case 576: // Tornado
     		switch(paintjobid)
         		case 0,1,2: return true; // Zwróci wartość logiczną true, gdy componentid ma wartość od 1 do 5.
           		default: return false; // Zwróci wartość logiczną false, gdy componentid ma wartość inną niż od 1 do 5.
	return false;
stock GetRandomColor(Type = 0, Model)
	if(Model == 420 || Model == 409 || Model == 601 || Model == 597 || Model == 599 || Model == 596 || Model == 432 || Model == 416 || Model == 433 || Model == 490 || Model == 407 || Model == 470 || Model == 437 || Model == 438)
	    return -1;
	if(Type == 0)
		return random(126);
	return random(2);
GivePlayerEquipment(userid)
    PlaySoundForPlayer(userid, 30800);
	new PLVL = Player[userid][Level];
	GivePlayerWeapon(userid, 4, 1);
	if(PLVL <= 3)
	    GivePlayerWeapon(userid, 30, 500);
	else if(PLVL > 3 && PLVL <= 5)
	    GivePlayerWeapon(userid, 29, 500);
	else if(PLVL > 5)
	    GivePlayerWeapon(userid, 31, 500);
	if(PLVL <= 2)
	    GivePlayerWeapon(userid, 25, 500);
	else if(PLVL > 2 && PLVL <= 4)
	    GivePlayerWeapon(userid, 27, 500);
	else if(PLVL > 4)
	    GivePlayerWeapon(userid, 26, 500);
	if(PLVL >= 10)
	    GivePlayerWeapon(userid, 34, 500);
	if(PLVL >= 8)
		SetPlayerArmour(userid, 100.0);
    if(PLVL <= 2)
		GivePlayerWeapon(userid, 22, 500);
        SetPlayerArmedWeapon(userid,22);
	else if(PLVL > 2)
		GivePlayerWeapon(userid, 24, 300);
        SetPlayerArmedWeapon(userid,24);
stock GetPlayerActualInfo(playerid)
	Player[playerid][ActualColor] = Player[playerid][Color];
	Player[playerid][ActualSkin] = GetPlayerSkin(playerid);
	GetPlayerPos(playerid, Player[playerid][ActualPosX],Player[playerid][ActualPosY],Player[playerid][ActualPosZ]);
	GetPlayerFacingAngle(playerid, Player[playerid][ActualAngle]);
	Player[playerid][ActualVirtualWorld] = GetPlayerVirtualWorld(playerid);
	Player[playerid][ActualInterior] = GetPlayerInterior(playerid);
stock SetPlayerActualInfo(playerid)
    Player[playerid][Color] = Player[playerid][ActualColor];
    format(Player[playerid][ChatColor],15,HexToString(Player[playerid][Color]));
	SetPlayerColor(playerid, Player[playerid][Color]);
	SetPlayerSkin(playerid,Player[playerid][ActualSkin]);
	if(Player[playerid][ActualVirtualWorld] != 0)
		SetPlayerRandomSpawn(playerid);
	else
		PlayerLegalTeleport(playerid, Player[playerid][ActualInterior],Player[playerid][ActualPosX],Player[playerid][ActualPosY],Player[playerid][ActualPosZ]);
	    SetPlayerFacingAngle(playerid, Player[playerid][ActualAngle]);
        PlaySoundForPlayer(playerid, 30800);
		ResetPlayerWeapons(playerid);
		PlaySoundForPlayer(playerid, 30800);
		GivePlayerEquipment(playerid);
stock mktime(hour,minute,second,day,month,year)
	new timestamp2;
	timestamp2 = second + (minute * 60) + (hour * 3600);
	new days_of_month[12];
	if(((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0))
		days_of_month = {31,29,31,30,31,30,31,31,30,31,30,31};
	else
		days_of_month = {31,28,31,30,31,30,31,31,30,31,30,31};
	new days_this_year = 0;
	days_this_year = day;
	if(month > 1)
		for(new i=0; i<month-1;i++)
			days_this_year += days_of_month[i];
	timestamp2 += days_this_year * 86400;
	for(new j=1970;j<year;j++)
		timestamp2 += 31536000;
		if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) )  timestamp2 += 86400;
	return timestamp2;
CagePlayer(playerid)
	if(IsPlayerConnected(playerid))
		new Float:X5, Float:Y5, Float:Z5;
		GetPlayerPos(playerid, X5, Y5, Z5);
		cage[playerid] = CreateObject(18856, X5, Y5, Z5+1,   0.00, 0.00, 0.00);
		caged[playerid] = 1;
		PlayerPlaySound(playerid, 1137, X5, Y5, Z5);
stock BanExists(account[])
	new xtring[128];
	format(xtring, sizeof(xtring), "SELECT Nick FROM "PREFIX"Bans WHERE Nick = '%s' LIMIT 1", account);
	mysql_query(xtring);
	mysql_store_result();
	new value;
	value = mysql_num_rows();
	mysql_free_result();
    return value;
stock PrivCarExists(pcarid)
	new xtring[125];
	format(xtring, sizeof(xtring), "SELECT vID FROM "PREFIX"Vehicles WHERE vID = '%d' LIMIT 1", pcarid);
	mysql_query(xtring);
	mysql_store_result();
	new value;
	value = mysql_num_rows();
	mysql_free_result();
    return value;
stock AccountExists(account[])
	new xtring[100];
	format(xtring, sizeof(xtring), "SELECT AID FROM "PREFIX"Users WHERE Name = '%s' LIMIT 1", account);
	mysql_query(xtring);
    mysql_store_result();
	new value;
	value = mysql_num_rows();
	mysql_free_result();
    return value;
stock CheckBanExists(account[],adress[])
	new xtring[128];
	format(xtring, sizeof(xtring), "SELECT Nick FROM "PREFIX"Bans WHERE Nick = '%s' OR IP = '%s' LIMIT 1", account,adress);
	mysql_query(xtring);
	mysql_store_result();
	new value;
	value = mysql_num_rows();
	mysql_free_result();
    return value;
stock VipExists(account[])
	new xtring[100];
	format(xtring, sizeof(xtring), "SELECT Name FROM "PREFIX"Vips WHERE Name = '%s' LIMIT 1", account);
	mysql_query(xtring);
	mysql_store_result();
	new value;
	value = mysql_num_rows();
	mysql_free_result();
    return value;
stock ModExists(account[])
	new xtring[100];
	format(xtring, sizeof(xtring), "SELECT Name FROM "PREFIX"Mods WHERE Name = '%s' LIMIT 1", account);
	mysql_query(xtring);
	mysql_store_result();
	new value;
	value = mysql_num_rows();
	mysql_free_result();
    return value;
stock AdminExists(account[])
	new xtring[100];
	format(xtring, sizeof(xtring), "SELECT Name FROM "PREFIX"Admins WHERE Name = '%s' LIMIT 1", account);
	mysql_query(xtring);
	mysql_store_result();
	new value;
	value = mysql_num_rows();
	mysql_free_result();
    return value;
stock AchievementExists(account[])
	new xtring[128];
	format(xtring, sizeof(xtring), "SELECT Name FROM "PREFIX"Achievements WHERE Name = '%s' LIMIT 1", account);
	mysql_query(xtring);
	mysql_store_result();
	new value;
	value = mysql_num_rows();
	mysql_free_result();
    return value;
stock HouseExists(HouseId)
	new xtring[100];
	format(xtring, sizeof(xtring), "SELECT hID FROM "PREFIX"Houses WHERE hID = '%d' LIMIT 1", HouseId);
	mysql_query(xtring);
	mysql_store_result();
	new value;
	value = mysql_num_rows();
	mysql_free_result();
    return value;
stock GetPlayerIdFromName(playername[])
	foreach(Player,i)
        if(strcmp(Player[i][Name],playername)==0)
			return i;
	return INVALID_PLAYER_ID;
stock GetStampIP(playerid)
	new S_IP[16];
	Join_Stamp=GetTickCount();
	GetPlayerIp(playerid,S_IP,16);
	format(ban_s, 16, "%s", S_IP);
stock IsVehicleCar(VehicleId)
    for(new Order = 0; Order < 93; Order++)
		if(GetVehicleModel(VehicleId) == AllCars[Order])
        	return true;
    return false;
stock WGExists(valuet)
	new xtring[100];
	format(xtring, sizeof(xtring), "SELECT ID FROM "PREFIX"WG WHERE ID = '%d' LIMIT 1",valuet);
	mysql_query(xtring);
	mysql_store_result();
	new valuer;
	valuer = mysql_num_rows();
	mysql_free_result();
    return valuer;
stock PBExists(valuet)
	new xtring[100];
	format(xtring, sizeof(xtring), "SELECT ID FROM "PREFIX"PB WHERE ID = '%d' LIMIT 1",valuet);
	mysql_query(xtring);
	mysql_store_result();
	new valuer;
	valuer = mysql_num_rows();
	mysql_free_result();
    return valuer;
stock WSExists(valuet)
	new xtring[100];
	format(xtring, sizeof(xtring), "SELECT ID FROM "PREFIX"WS WHERE ID = '%d' LIMIT 1",valuet);
	mysql_query(xtring);
	mysql_store_result();
	new valuer;
	valuer = mysql_num_rows();
	mysql_free_result();
    return valuer;
stock CHExists(valuet)
	new xtring[100];
	format(xtring, sizeof(xtring), "SELECT ID FROM "PREFIX"CH WHERE ID = '%d' LIMIT 1",valuet);
	mysql_query(xtring);
	mysql_store_result();
	new valuer;
	valuer = mysql_num_rows();
	mysql_free_result();
    return valuer;
EndTutorialForPlayer(playerid)
	SetCameraBehindPlayer(playerid);
	TogglePlayerControllable(playerid, 1);
    Player[playerid][TutID] = 0;
stock ReturnWeaponName(weaponid)
	new weaponname[32];
	GetWeaponName(weaponid,weaponname,sizeof(weaponname));
	if(weaponid == 0)
		format(weaponname,32,"Hands");
	return weaponname;
Odswiez3DAren()
	new String[512];
	strdel(String,0,512);
    if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	for(new x=0;x<5;x++)
		new str[128];
		new name[25];
		new score[11];
		format(str,sizeof(str),"SELECT Name,OnedeScore FROM "PREFIX"Users ORDER BY `OnedeScore` DESC, `Name` ASC LIMIT %d , %d",x,x+1);
		mysql_query(str);
		mysql_store_result();
		mysql_fetch_row(str, "|");
		new ii=strlen(str);
		for(new i=0;i<ii;i++)
			if(strfind(str[i],"|",false)==0)
				strmid(name,str,0,i);
				strmid(score,str,i+1,ii);
				format(score,sizeof(score),"%s",score);
				break;
		mysql_free_result();
		format(String,512,"%s\n{ff5219}%02d.	{FFFFFF}%21s		{d0d0d0}%11s",String,x+1,name,score);
	format(String,sizeof(String),"Najlepsi na /Onede\n\n{FFFFFF}%s",String);
	Update3DTextLabelText(OnedeLabel, 0xff5219FF, String);
    strdel(String,0,512);
    for(new x=0;x<5;x++)
		new str[128];
		new name[25];
		new score[11];
		format(str,sizeof(str),"SELECT Name,MinigunScore FROM "PREFIX"Users ORDER BY `MinigunScore` DESC, `Name` ASC LIMIT %d , %d",x,x+1);
		mysql_query(str);
		mysql_store_result();
		mysql_fetch_row(str, "|");
		new ii=strlen(str);
		for(new i=0;i<ii;i++)
			if(strfind(str[i],"|",false)==0)
				strmid(name,str,0,i);
				strmid(score,str,i+1,ii);
				format(score,sizeof(score),"%s",score);
				break;
		mysql_free_result();
		format(String,512,"%s\n{ff5219}%02d.	{FFFFFF}%21s		{d0d0d0}%11s",String,x+1,name,score);
	format(String,sizeof(String),"Najlepsi na /Minigun\n\n{FFFFFF}%s",String);
	Update3DTextLabelText(MinigunLabel, 0xff5219FF, String);
    strdel(String,0,512);
    for(new x=0;x<5;x++)
		new str[128];
		new name[25];
		new score[11];
		format(str,sizeof(str),"SELECT Name,RPGScore FROM "PREFIX"Users ORDER BY `RPGScore` DESC, `Name` ASC LIMIT %d , %d",x,x+1);
		mysql_query(str);
		mysql_store_result();
		mysql_fetch_row(str, "|");
		new ii=strlen(str);
		for(new i=0;i<ii;i++)
			if(strfind(str[i],"|",false)==0)
				strmid(name,str,0,i);
				strmid(score,str,i+1,ii);
				format(score,sizeof(score),"%s",score);
				break;
		mysql_free_result();
		format(String,512,"%s\n{ff5219}%02d.	{FFFFFF}%21s		{d0d0d0}%11s",String,x+1,name,score);
	format(String,sizeof(String),"Najlepsi na /RPG\n\n{FFFFFF}%s",String);
	Update3DTextLabelText(RPGLabel, 0xff5219FF, String);
	strdel(String,0,512);
    for(new x=0;x<5;x++)
		new str[128];
		new name[25];
		new score[11];
		format(str,sizeof(str),"SELECT Name,DriftScore FROM "PREFIX"Users ORDER BY `DriftScore` DESC, `Name` ASC LIMIT %d , %d",x,x+1);
		mysql_query(str);
		mysql_store_result();
		mysql_fetch_row(str, "|");
		new ii=strlen(str);
		for(new i=0;i<ii;i++)
			if(strfind(str[i],"|",false)==0)
				strmid(name,str,0,i);
				strmid(score,str,i+1,ii);
				format(score,sizeof(score),"%s",score);
				break;
		mysql_free_result();
		format(String,512,"%s\n{ff5219}%02d.	{FFFFFF}%21s		{d0d0d0}%11s pkt.",String,x+1,name,score);
	format(String,sizeof(String),"Najlepsi drifterzy\n\n{FFFFFF}%s",String);
	Update3DTextLabelText(DriftLabel, 0xff5219FF, String);
    strdel(String,0,512);
    for(new x=0;x<5;x++)
		new str[128];
		new name[25];
		new score[11];
		format(str,sizeof(str),"SELECT Name,Kills FROM "PREFIX"Users ORDER BY `Kills` DESC, `Name` ASC LIMIT %d , %d",x,x+1);
		mysql_query(str);
		mysql_store_result();
		mysql_fetch_row(str, "|");
		new ii=strlen(str);
		for(new i=0;i<ii;i++)
			if(strfind(str[i],"|",false)==0)
				strmid(name,str,0,i);
				strmid(score,str,i+1,ii);
				format(score,sizeof(score),"%s",score);
				break;
		mysql_free_result();
		format(String,512,"%s\n{ff5219}%02d.	{FFFFFF}%21s		{d0d0d0}%11s pkt.",String,x+1,name,score);
	format(String,sizeof(String),"Najlepsi zabójcy w San Andreas\n\n{FFFFFF}%s",String);
	Update3DTextLabelText(KillLabel, 0xff5219FF, String);
	return 1;
Show2ListAchievements(playerid)
    new string[500],oPodroznik[45],oDrifter[45],oKrolDriftu[45],oStreetKing[45],oNowaTozsamosc[45],oDomownik[45],oWlasne4[50],oZzzz[45],oWyborowy[45];
	new oKomandos[45];
	if(AchievementGet[playerid][aPodroznik] >= 1)
		format(oPodroznik, sizeof(oPodroznik), "10. {1DEB02}Podróżnik - Zakończony\n");
	else
		format(oPodroznik, sizeof(oPodroznik), "10. Podróżnik - 0/1\n");
    if(AchievementGet[playerid][aDrifter] >= 1)
		format(oDrifter, sizeof(oDrifter), "11. {1DEB02}Drifter - Zakończony\n");
	else
		format(oDrifter, sizeof(oDrifter), "11. Drifter - 0/1\n");
    if(AchievementGet[playerid][aKrolDriftu] >= 1)
		format(oKrolDriftu, sizeof(oKrolDriftu), "12. {1DEB02}Król Driftu - Zakończony\n");
	else
		format(oKrolDriftu, sizeof(oKrolDriftu), "12. Król Driftu - 0/1\n");
    if(AchievementGet[playerid][aStreetKing] >= 10)
		format(oStreetKing, sizeof(oStreetKing), "13. {1DEB02}StreetKing! - Zakończony\n");
	else
		format(oStreetKing, sizeof(oStreetKing), "13. StreetKing! - %d/10\n",AchievementGet[playerid][aStreetKing]);
    if(AchievementGet[playerid][aNowaTozsamosc] >= 1)
		format(oNowaTozsamosc, sizeof(oNowaTozsamosc), "14. {1DEB02}Nowa Tożsamość - Zakończony\n");
	else
		format(oNowaTozsamosc, sizeof(oNowaTozsamosc), "14. Nowa Tożsamość - 0/1\n");
    if(AchievementGet[playerid][aDomownik] >= 1)
		format(oDomownik, sizeof(oDomownik), "15. {1DEB02}Domownik - Zakończony\n");
	else
		format(oDomownik, sizeof(oDomownik), "15. Domownik - 0/1\n");
    if(AchievementGet[playerid][aWlasne4] >= 1)
		format(oWlasne4, sizeof(oWlasne4), "16. {1DEB02}Własne cztery kółka - Zakończony\n");
	else
		format(oWlasne4, sizeof(oWlasne4), "16. Własne cztery kółka - 0/1\n");
    if(AchievementGet[playerid][aZzzz] >= 1)
		format(oZzzz, sizeof(oZzzz), "17. {1DEB02}Zzzz... - Zakończony\n");
	else
		format(oZzzz, sizeof(oZzzz), "17. Zzzz... - 0/1\n");
    if(AchievementGet[playerid][aWyborowy] >= 100)
		format(oWyborowy, sizeof(oWyborowy), "18. {1DEB02}Strzelec Wyborowy - Zakończony\n");
	else
		format(oWyborowy, sizeof(oWyborowy), "18. Strzelec Wyborowy - %d/100\n",AchievementGet[playerid][aWyborowy]);
    if(AchievementGet[playerid][aKomandos] >= 100)
		format(oKomandos, sizeof(oKomandos), "19. {1DEB02}Komandos - Zakończony\n");
	else
		format(oKomandos, sizeof(oKomandos), "19. Komandos - %d/100\n",AchievementGet[playerid][aKomandos]);
	strcat(string,""R"Cofnij"W"\n");
	strcat(string,oPodroznik);
    strcat(string,oDrifter);
    strcat(string,oKrolDriftu);
    strcat(string,oStreetKing);
    strcat(string,oNowaTozsamosc);
    strcat(string,oDomownik);
    strcat(string,oWlasne4);
    strcat(string,oZzzz);
    strcat(string,oWyborowy);
    strcat(string,oKomandos);
	strcat(string,""R"Dalej"W"");
	SPD(playerid,D_OSIAGNIECIA_2,DIALOG_STYLE_LIST,"{00BFFF}Osiągnięcia "W"- Strona 2",string,"Wybierz","Zamknij");
Show3ListAchievements(playerid)
    new string[250],oWedkarz[45],oStalyGracz[45],oPoszukiwacz[45];
    if(AchievementGet[playerid][aWedkarz] >= 100)
		format(oWedkarz, sizeof(oWedkarz), "20. {1DEB02}Wędkarz - Zakończony\n");
	else
		format(oWedkarz, sizeof(oWedkarz), "20. Wędkarz - %d/100\n",AchievementGet[playerid][aWedkarz]);
    if(AchievementGet[playerid][aStalyGracz] >= 10)
		format(oStalyGracz, sizeof(oStalyGracz), "21. {1DEB02}Stały Gracz - Zakończony\n");
	else
		format(oStalyGracz, sizeof(oStalyGracz), "21. Stały Gracz - %d/10\n",AchievementGet[playerid][aStalyGracz]);
    if(AchievementGet[playerid][aPoszukiwacz] >= 20)
		format(oPoszukiwacz, sizeof(oPoszukiwacz), "22. {1DEB02}Poszukiwacz - Zakończony\n");
	else
		format(oPoszukiwacz, sizeof(oPoszukiwacz), "22. Poszukiwacz - %d/20\n",AchievementGet[playerid][aPoszukiwacz]);
	strcat(string,""R"Cofnij"W"\n");
	strcat(string,oWedkarz);
    strcat(string,oStalyGracz);
    strcat(string,oPoszukiwacz);
	strcat(string,""R"Dalej"W"");
	SPD(playerid,D_OSIAGNIECIA_3,DIALOG_STYLE_LIST,"{00BFFF}Osiągnięcia "W"- Strona 3",string,"Wybierz","Zamknij");
forward HitmanUnlock(playerid);
public HitmanUnlock(playerid)
	Player[playerid][HitmanBlock] = false;
	return 1;
JailPlayer(playerid,reason[],time)
	new string[1150];
    WGKandydat[playerid] = false;
	WGGlos[playerid] = false;
	PBKandydat[playerid] = false;
	PBGlos[playerid] = false;
	WyscigUczestnik[playerid] = false;
	WyscigStatus[playerid] = false;
	ChowanyZapisany[playerid] = false;
	Chowany[playerid] = false;
	Szukajacy[playerid] = false;
	DerbyMen[playerid] = false;
	DerbyZaglosowal[playerid] = false;
	SNKandydat[playerid] = false;
	SNGlos[playerid] = false;
	Player[playerid][Jail] = time;
	time = time*60000;
	Wiezien[playerid] = true;
	if(!JailText[playerid])
		format(string, sizeof(string), ""WI" "R"Trafiłeś(aś) do więzienia na "R2"%d minut "R"za: "R2"%s",time/60000,reason);
		SCM(playerid,C_RED, string);
		JailText[playerid] = true;
		SetTimerEx("JailTextUnlock",5000,0,"i",playerid);
	new rand = random(sizeof(CelaSpawn));
	PlayerLegalTeleport(playerid,0,CelaSpawn[rand][0], CelaSpawn[rand][1], CelaSpawn[rand][2]);
	TogglePlayerControllable(playerid,0);
	SetPlayerVirtualWorld(playerid,18);
	ResetPlayerWeapons(playerid);
	SetTimerEx("JailUnfreeze",2000,0,"i",playerid);
	KillTimer(JailTimer[playerid]);
	JailTimer[playerid] = SetTimerEx("UnjailPlayer",time,0,"i",playerid);
    //{FFD900} pomarancz {00DB8B} zielony
	string[0] = EOS;
	strcat(string,""W"1. {44a428}Zabrania się podszywania/prób logowania na Admina/Moderatora.\n");
	strcat(string,""W"2. {44a428}Zakaz używania progamów ułatwiających grę (s0beit, v0lgez oraz mody CLEO które umożliwiają latanie itp.)\n");
	strcat(string,""W"3. {44a428}Wszelkie treści obraźliwe i rasistowskie będą karane.\n");
	strcat(string,""W"4. {44a428}Nie używaj wulgarnego słownictwa.\n");
	strcat(string,""W"5. {44a428}Zakaz reklamowania innych serwerów.\n");
	strcat(string,""W"6. {44a428}Zakaz floodowania, spamowania, bugowania.\n");
	strcat(string,""W"7. {44a428}HK, CK itp. za strefą śmierci zabronione! (/faq)\n");
    strcat(string,""W"8. {44a428}Zabrania się reklamowania innych serwerów itp.\n");
    strcat(string,""W"9. {44a428}Zakaz nieuczciwego zdobywania exp.\n");
    strcat(string,""W"10. {44a428}Zakaz uciekania z więzennej wyspy.\n");
    strcat(string,""W"11. {44a428}Zakaz przeszkadzania w zabawach zorganizowanych.\n");
    strcat(string,""W"12. {44a428}Zakaz przeszkadzania w zabawach zorganizowanych.\n\n");
	strcat(string,""W"Nieznajomość regulaminu nie usprawiedliwia Cię.\n");
	strcat(string,""W"Wchodząc na serwer akceptujesz ustalone przez nas zasady.\n");
    strcat(string,""W"Jeżeli ich nie czytałeś to twoja wina i zostaniesz ukarany nawet jeżeli łamałeś regulamin nieświadomie.\n\n");
	strcat(string,"{FF0000}Administracja zastrzega sobie prawo do zmiany regulaminu w każdej chwili.");
	SPD(playerid,D_NONE,0,"{00BFFF}Regulamin serwera",string,"Zamknij","");
	return 1;
forward RaportUnlock(playerid);
public RaportUnlock(playerid)
	RaportBlock[playerid] = false;
	return 1;
UnPanorama(playerid)
	TextDrawHideForPlayer(playerid,PanoramaUp1);
 	TextDrawHideForPlayer(playerid,PanoramaDown1);
 	TextDrawHideForPlayer(playerid,PanoramaUp2);
 	TextDrawHideForPlayer(playerid,PanoramaDown2);
    /*TextDrawHideForPlayer(playerid,LogoS1);
  	TextDrawHideForPlayer(playerid,LogoS2);
  	TextDrawHideForPlayer(playerid,LogoS3);*/
Panorama(playerid)
	TextDrawShowForPlayer(playerid,PanoramaUp1);
  	TextDrawShowForPlayer(playerid,PanoramaDown1);
  	TextDrawShowForPlayer(playerid,PanoramaUp2);
  	TextDrawShowForPlayer(playerid,PanoramaDown2);
    TextDrawShowForPlayer(playerid,LogoS1);
  	TextDrawShowForPlayer(playerid,LogoS2);
  	TextDrawShowForPlayer(playerid,LogoS3);
forward UnjailPlayer(playerid);
public UnjailPlayer(playerid)
	Wiezien[playerid] = false;
    Player[playerid][Jail] = 0;
	KillTimer(JailTimer[playerid]);
 	SetPlayerRandomSpawn(playerid);
	SCM(playerid,C_GREEN,""WI" "G"Odbyłeś(aś) swoją karę i możesz już grać!");
	return 1;
Losowanko(playerid)
	new losek = random(21);
	if(losek == 0)
		SCM(playerid, 0xFFFFFFAA,""I" "W"Wygrales(aś) m4!");
		GivePlayerWeapon(playerid, 31, 2000);
		PlaySoundForPlayer(playerid, 30800);
	else if(losek == 1)
		SCM(playerid, 0xFFFFFFAA,""I" "W"Wygrałeś(aś) nóż! ");
		GivePlayerWeapon(playerid, 4, 1);
        PlaySoundForPlayer(playerid, 30800);
	else if(losek == 2)
		SCM(playerid, 0xFFFFFFAA,""I" "W"Wygrałeś(aś) wibrator");
		GivePlayerWeapon(playerid, 12, 1);
        PlaySoundForPlayer(playerid, 30800);
	else if(losek == 3)
		SCM(playerid, 0xFFFFFFAA,""I" "W"Wygrałeś(aś) Snajperkę!!!");
		GivePlayerWeapon(playerid, 34, 100);
        PlaySoundForPlayer(playerid, 30800);
	else if(losek == 4)
		SCM(playerid, 0xFFFFFFAA,""I" "W"Wygrałeś(aś) skin dziadka");
		SetPlayerSkin(playerid, 49);
		GivePlayerWeapon(playerid, 15 ,1);
        PlaySoundForPlayer(playerid, 30800);
	else if(losek == 5)
		SCM(playerid, 0xFFFFFFAA,""I" "W"Nic nie wygrałeś(aś)");
	else if(losek == 6)
		SCM(playerid, 0xFFFFFFAA,""I" "W"Wygrałeś(aś) fortune");
		GivePlayerMoney(playerid, 1);
        Player[playerid][Money] += 1;
	else if(losek == 7)
		SCM(playerid, 0xFFFFFFAA,""I" "W"Wygrałeś(aś) trochę kaski na wydatki");
		GivePlayerMoney(playerid, 10000);
        Player[playerid][Money] += 10000;
	else if(losek == 8)
		SCM(playerid, C_LIGHTRED,""WI" "R"Niestety Tym Razem Wygrałeś(aś) pobyt w więzieniu!");
		JailPlayer(playerid,"Nagroda z Losowania",3);
	else if(losek == 9)
		SCM(playerid, 0xFFFFFFAA,""I" "W"Nic nie wygrałeś(aś)");
	else if(losek == 10)
		SCM(playerid, C_LIGHTRED,""WI" "R"Niestety Tym Razem Wygrałeś(aś) pobyt w więzieniu!");
		JailPlayer(playerid,"Nagroda z Losowania",3);
	else if(losek == 11)
		SCM(playerid, 0xFFFFFFAA,""I" "W"Wygrałeś(aś) Reset kasy");
		ResetPlayerMoney(playerid);
	else if(losek == 12)
		SCM(playerid, 0xFFFFFFAA,""I" "W"Wygrałeś(aś) Dług!");
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid, -10000);
        Player[playerid][Money] += -10000;
	else if(losek == 13)
		SCM(playerid, 0xFFFFFFAA,""I" "W"Wygrałeś(aś) Teleport");
		SetPlayerPos(playerid, -1383.3280,-1507.3010,102.2328);
	else if(losek == 15)
		SCM(playerid, 0xFFFFFFAA,""I" "W"Wygrałeś(aś) śmierć");
		SetPlayerHealth(playerid, 0);
	else if(losek == 16)
		SCM(playerid, 0xFFFFFFAA,""I" "W"Wygrałeś(aś) Życie = 1 hp");
		SetPlayerHealth(playerid, 1);
	else if(losek == 17)
		SCM(playerid, 0xFFFFFFAA,""I" "W"Wygrałeś(aś) łopatę");
		GivePlayerWeapon(playerid, 6, 1);
        PlaySoundForPlayer(playerid, 30800);
	else if(losek == 18)
		SCM(playerid, 0xFFFFFFAA,""I" "W"Nic nie wygrałeś(aś)");
	else if(losek == 19)
		SCM(playerid, 0xFFFFFFAA,""I" "W"Wygrałeś(aś) Mega Zestaw");
		GivePlayerWeapon(playerid, 29, 2000);
		GivePlayerWeapon(playerid, 31, 2000);
  		PlaySoundForPlayer(playerid, 30800);
		GivePlayerWeapon(playerid, 34, 2000);
		GivePlayerWeapon(playerid, 24, 2000);
		SetPlayerArmour(playerid, 100);
		SetPlayerHealth(playerid, 100);
		GivePlayerMoney(playerid, 10000);
        Player[playerid][Money] += 10000;
	else if(losek == 20)
		SCM(playerid, C_LIGHTRED,""WI" "R"Niestety Tym Razem Wygrałeś(aś) pobyt w więzieniu!");
		JailPlayer(playerid,"Nagroda z Losowania",3);
forward SoundOff(playerid);
public SoundOff(playerid)
	PlayerPlaySound(playerid,1098,0.0,0.0,0.0);
	return 1;
forward KillOff(playerid);
public KillOff(playerid)
	Player[playerid][DeathsSecond] = 0;
    KillTimer(Player[playerid][FloodTimer]);
	return 1;
ZapisyUpdate()
	new strr[6][25],Liczba[6];
	Liczba[0] = WGLiczba,Liczba[2] = WSMans,Liczba[3] = ChNum,Liczba[4] = PBLiczba,Liczba[5] = SNLiczba;
	foreach(Player,x)
		if(DerbyMen[x])
			Liczba[1] ++;
	if(Liczba[0] < 4)
		format(strr[0],25,"~w~%d/4",Liczba[0]);
	else
		format(strr[0],25,"~y~%d",Liczba[0]);
	if(WGON)
		format(strr[0],25,"~r~~h~Trwa");
	if(Liczba[1] < 4)
		format(strr[1],25,"~w~%d/4",Liczba[1]);
	else
		format(strr[1],25,"~y~%d",Liczba[1]);
	if(DerbyON || Liczba[1] >= 16)
		format(strr[1],25,"~r~~h~Trwa");
		DerbyStartON = false;
	if(Liczba[2] < 4)
		format(strr[2],25,"~w~%d/4",Liczba[2]);
	else
		format(strr[2],25,"~y~%d",Liczba[2]);
	if(RaceWystartowal || Liczba[2] >= 10)
		format(strr[2],25,"~r~~h~Trwa");
	if(Liczba[3] < 5)
		format(strr[3],25,"~w~%d/5",Liczba[3]);
	else
		format(strr[3],25,"~y~%d",Liczba[3]);
	if(ChWystartowala || Liczba[3] >= 49)
		format(strr[3],25,"~r~~h~Trwa");
    if(Liczba[4] < 4)
		format(strr[4],25,"~w~%d/4",Liczba[4]);
	else
		format(strr[4],25,"~y~%d",Liczba[4]);
	if(PBON)
		format(strr[4],25,"~r~~h~Trwa");
    if(Liczba[5] < 4)
		format(strr[5],25,"~w~%d/4",Liczba[5]);
	else
		format(strr[5],25,"~y~%d",Liczba[5]);
	if(SNON)
		format(strr[5],25,"~r~~h~Trwa");
	new string2[128];
	format(string2,sizeof(string2),"%s~n~~n~%s~n~~n~%s~n~~n~%s~n~~n~%s~n~~n~%s",strr[0],strr[2],strr[3],strr[1],strr[4],strr[5]);
	TextDrawSetString(ZapisyLiczba,string2);
	return 1;
forward RespektScore();
public RespektScore()
	foreach(Player,x)
	    Player[x][Exp] ++;
    	if(Player[x][Level] < GetPlayerLevel(x))
   			LevelUp(x);
	return 1;
forward WGPlayerEnd(playerid);
public WGPlayerEnd(playerid)
	WGTeam[playerid] = 0;
	WGKandydat[playerid] = false;
	SetPlayerTeam(playerid,playerid+10);
	return 1;
forward SNPlayerEnd(playerid);
public SNPlayerEnd(playerid)
	SNKandydat[playerid] = false;
	SetPlayerTeam(playerid,playerid+10);
	SetPlayerActualInfo(playerid);
	return 1;
forward WGoff();
public WGoff()
	KillTimer(WGTimer);
	foreach(Player,x)
		WGGlos[x] = false;
		if(WGTeam[x] == 1 || WGTeam[x] == 2)
			SetPlayerActualInfo(x);
            SetPlayerHealth(x, 100.0);
		SetPlayerTeam(x,x+10);
		WGTeam[x] = 0;
		WGKandydat[x] = false;
	WGLiczba = 0;
	WGTeamLiczba[1] = 0;
	WGTeamLiczba[2] = 0;
	WGON = false;
	WGStarted = false;
	GangZoneHideForAll(ArenaZone);
	ZapisyUpdate();
	return 1;
forward SNoff();
public SNoff()
	KillTimer(SNTimer);
	foreach(Player,x)
		SNGlos[x] = false;
		if(SNKandydat[x])
			SetPlayerActualInfo(x);
			SetPlayerVirtualWorld(x, 0);
			SetPlayerHealth(x, 100.0);
		SetPlayerTeam(x,x+10);
		SNKandydat[x] = false;
    for(new x=0;x<81;x++)
    	DestroyDynamicObject(SNObject[x]);
	SNLiczba = 0;
	SNON = false;
	SNStarted = false;
	ZapisyUpdate();
	return 1;
forward WGPlayerCheck();
public WGPlayerCheck()
	if(!WGON) return 1;
	foreach(Player,x)
		if(IsPlayerConnected(x) && WGTeam[x] > 0)
			if(InteriorWG == 0)
				if(!IsPlayerInArea(x,WGAreaX,WGAreaY,WGAreaZ,WGAreaA))
					WGAwayCount[x] ++;
					SCM(x, C_RED, " {FFFFFF}*(WG) {FF0000}Wracaj na teren wojny gangów!");
					if(WGAwayCount[x] >= 3)
						WGPlayerEnd(x);
						SetPlayerActualInfo(x);
						SCM(x, C_RED, " {FFFFFF}*(WG) {FF0000}Uciekłeś(aś) właśnie z wojny gangów!");
			if(InteriorWG != 0)
				if(GetPlayerInterior(x) != InteriorWG)
					WGAwayCount[x] ++;
					SCM(x, C_RED, " {FFFFFF}*(WG) {FF0000}Wracaj na teren wojny gangów!");
					if(WGAwayCount[x] >= 3)
						WGPlayerEnd(x);
						SetPlayerActualInfo(x);
						SCM(x, C_RED, " {FFFFFF}*(WG) {FF0000}Uciekłeś(aś) właśnie z wojny gangów!");
			new weap = GetPlayerWeapon(x);
			if(weap == 38 || weap == 36 || weap == 35 || weap == 37 || weap == 39 || weap == 41 || weap == 9)
				SCM(x, C_RED, "{FFFFFF} *(WG) {FF0000}Ta broń jest nie dozwolona na WG!");
				RemovePlayerWeapon(x, 38);
                RemovePlayerWeapon(x, 36);
                RemovePlayerWeapon(x, 35);
                RemovePlayerWeapon(x, 37);
                RemovePlayerWeapon(x, 39);
                RemovePlayerWeapon(x, 41);
                RemovePlayerWeapon(x, 9);
	return 1;
forward SNPlayerCheck();
public SNPlayerCheck()
	if(!SNON) return 1;
	new InGameSN;
	foreach(Player,x)
		if(IsPlayerConnected(x) && SNKandydat[x])
			InGameSN ++;
			new Float:rx,Float:ry,Float:rz;
			GetPlayerPos(x,rx,ry,rz);
			if(floatround(rz) <= 295)
				InGameSN --;
    			SNPlayerEnd(x);
				return 1;
            if(SNActiveGun)
				ResetPlayerWeapons(x);
	            GivePlayerWeapon(x,24,1);
                SetPlayerArmedWeapon(x, 24);
                GameTextForPlayer(x,"~r~~h~STRZELAJ!",2000,5);
				PlayerPlaySound(x, 1057, 0.0, 0.0, 0.0);
    if(InGameSN <= 1)
		foreach(Player,x)
			if(SNKandydat[x])
				new str[128];
				format(str,sizeof(str)," "W"*(SN) {A346FF}Sianko wygrywa %s , Zapisy wznowione!",Player[x][Name]);
				SCMA(0xA346FFFF,str);
				SoundForAll(1150);
                PlayCompleteMissionSound(x);
				Player[x][WygranychSN] ++;
				Player[x][Exp] += 15;
		  		if(Player[x][Level] < GetPlayerLevel(x))
					LevelUp(x);
				GameTextForPlayer(x,"~w~Exp + ~b~~h~15", 1000, 1);
				SNoff();
    SNActiveGun = true;
	return 1;
forward WGEndCheck();
public WGEndCheck()
	if(!WGON) return 1;
	WGTeamLiczba[1] = 0;
	WGTeamLiczba[2] = 0;
	WGLiczba = 0;
	foreach(Player,x)
		if(WGTeam[x] == 1)
			WGTeamLiczba[1] ++;
			WGLiczba ++;
		if(WGTeam[x] == 2)
			WGTeamLiczba[2] ++;
			WGLiczba ++;
	if(WGLiczba <= 0)
		return WGoff();
	if(WGON && WGTeamLiczba[1] == 0 || WGTeamLiczba[2] == 0)
		if(WGTeamLiczba[1] == WGTeamLiczba[2])
			SCMA(0x008080FF," {FFFFFF}*(WG) {008080}Mamy Remis na Wojnie Gangów!");
			WGoff();
			return 1;
		if(WGTeamLiczba[1] > WGTeamLiczba[2])
			SCMA(0x008080FF," {FFFFFF}*(WG) {008080}Wojnę gangów wygrywają niebiescy!");
			SoundForAll(1150);
			foreach(Player,x)
				if(IsPlayerConnected(x) && WGTeam[x] == 1)
					Player[x][WygranychWG] ++;
					Player[x][Money] += 5000;
                    GivePlayerMoney(x, 5000);
					PlayCompleteMissionSound(x);
					Player[x][Exp] += 5;
                    if(Player[x][Level] < GetPlayerLevel(x))
   						LevelUp(x);
					GameTextForPlayer(x,"~w~Exp + ~b~~h~5", 1000, 1);
			WGoff();
			return 1;
		if(WGTeamLiczba[1] < WGTeamLiczba[2])
			SCMA(0x008080FF," {FFFFFF}*(WG) {008080}Wojnę gangów wygrywają zieloni!");
            SoundForAll(1150);
			foreach(Player,x)
				if(IsPlayerConnected(x) && WGTeam[x] == 2)
                    Player[x][WygranychWG] ++;
                    Player[x][Money] += 5000;
					GivePlayerMoney(x, 5000);
					PlayCompleteMissionSound(x);
					Player[x][Exp] += 5;
     				if(Player[x][Level] < GetPlayerLevel(x))
   						LevelUp(x);
					GameTextForPlayer(x,"~w~Exp + ~b~~h~5", 1000, 1);
			WGoff();
			return 1;
	return 1;
forward WGStart();
public WGStart()
	new Rand = random(18);
	new Float:Team1SpawnX,Float:Team1SpawnY,Float:Team1SpawnZ;
	new Float:Team2SpawnX,Float:Team2SpawnY,Float:Team2SpawnZ;
	if(!WGExists(Rand))
		WGStart();
		return 1;
    if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	new Query[256], String[256];
	format(Query, 256, "SELECT `Team1SpawnX`,`Team1SpawnY`,`Team1SpawnZ`,`Team2SpawnX`,`Team2SpawnY`,`Team2SpawnZ`,`WGAreaX`,`WGAreaY`,`WGAreaZ`,`WGAreaA`,`Interior` FROM `"PREFIX"WG` WHERE `ID`='%d' LIMIT 1", Rand);
	mysql_query(Query);
	mysql_store_result();
	mysql_fetch_row(String);
	sscanf(String, "p<|>ffffffffffd",Team1SpawnX,Team1SpawnY,Team1SpawnZ,Team2SpawnX,Team2SpawnY,Team2SpawnZ,WGAreaX,WGAreaY,WGAreaZ,WGAreaA,InteriorWG);
    mysql_free_result();
	ArenaZone = GangZoneCreate(WGAreaX,WGAreaZ,WGAreaY,WGAreaA);
	WGLiczba = 0;
	SCMA(0x008080FF," *(WG) Wojna Gangów Rozpoczęta!");
	WGON = true;
	foreach(Player,x)
		if(WGKandydat[x])
			GetPlayerActualInfo(x);
			Player[x][InHouse] = false;
			Player[x][OnOnede] = false;
            Player[x][OnCombat] = false;
			Player[x][OnMinigun] = false;
			Player[x][OnRPG] = false;
		    KillTimer(Player[x][HealthTimer]);
		    KillTimer(Player[x][ArmourTimer]);
		    SetPlayerWorldBounds(x,20000.0000,-20000.0000,20000.0000,-20000.0000); //Reset world to player
		    if(Player[x][InHouse])
		        Player[x][InHouse] = false;
		        Player[x][ObokHouse] = false;
		        Player[x][NearHouse] = false;
			WGAwayCount[x] = 0;
			GangZoneShowForPlayer(x,ArenaZone,0xFF000077);
            GangZoneFlashForPlayer(x,ArenaZone,0xFF000022);
			ResetPlayerWeapons(x);
			SetPlayerSkin(x, 48);
			GivePlayerWeapon(x,4,1);
			SetPlayerHealth(x,100);
			SetPlayerArmour(x,0);
            if(!Player[x][Zajety])
				SPD(x, D_BRONIE_WG, DIALOG_STYLE_LIST, "{00BFFF}Bronie WG "W"- Broń lekka", "› 9MM (Bez Tłumika)\n"GUI2"› 9MM (Z Tłumikiem)\n"W"› Desert Eagle\n"GUI2"› MP5", "Wybierz", "");
			WGTeam[x] = 1;
			SetPlayerTeam(x,1);
			SetPlayerColor(x,0x0080FFFF);
			Player[x][Color] = GetPlayerColor(x);
            format(Player[x][ChatColor],15,HexToString(Player[x][Color]));
			SetPlayerInterior(x,InteriorWG);
			SetPlayerVirtualWorld(x,8);
			new randx = random(10);
			new randy = random(10);
			SetPlayerPos(x,Team1SpawnX-5+randx,Team1SpawnY-5+randy,Team1SpawnZ);
			TogglePlayerControllable(x,0);
			SetTimerEx("JailUnfreeze",2000,0,"i",x);
			WGTeamLiczba[1] ++;
			if(WGTeamLiczba[1] > WGTeamLiczba[2])
				WGTeam[x] = 2;
				SetPlayerTeam(x,2);
				SetPlayerColor(x,0x00D900FF);
                Player[x][Color] = 0x00D900FF;
                format(Player[x][ChatColor],15,HexToString(Player[x][Color]));
                SetPlayerSkin(x, 107);
				SetPlayerInterior(x,InteriorWG);
				SetPlayerVirtualWorld(x,8);
				SetPlayerPos(x,Team2SpawnX-5+randx,Team2SpawnY-5+randy,Team2SpawnZ);
				TogglePlayerControllable(x,0);
				SetTimerEx("JailUnfreeze",2000,0,"i",x);
				WGTeamLiczba[2] ++;
				WGTeamLiczba[1] --;
    ZapisyUpdate();
	return 1;
forward SNStart();
public SNStart()
	SNLiczba = 0;
	SCMA(0x008080FF," *(SN) Sianko rozpoczęte!");
	SNON = true;
    SNActiveGun = false;
	foreach(Player,x)
		if(SNKandydat[x])
            GetPlayerActualInfo(x);
			Player[x][InHouse] = false;
			Player[x][OnOnede] = false;
            Player[x][OnCombat] = false;
			Player[x][OnMinigun] = false;
			Player[x][OnRPG] = false;
		    KillTimer(Player[x][HealthTimer]);
		    KillTimer(Player[x][ArmourTimer]);
		    SetPlayerWorldBounds(x,20000.0000,-20000.0000,20000.0000,-20000.0000); //Reset world to player
		    if(Player[x][InHouse])
		        Player[x][InHouse] = false;
		        Player[x][ObokHouse] = false;
		        Player[x][NearHouse] = false;
			ResetPlayerWeapons(x);
			SetPlayerHealth(x,100);
			SetPlayerArmour(x,0);
			SetPlayerTeam(x,5);
			SetPlayerVirtualWorld(x,13);
			PlayerLegalTeleport(x,0,9.1371+random(6),-2058.7327+random(6),303.3672);
    ZapisyUpdate();
	return 1;
forward PBStart();
public PBStart()
	new Rand = random(18);
	if(!PBExists(Rand))
		PBStart();
		return 1;
    if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	new Query[256], String[256];
	format(Query, 256, "SELECT `Team1SpawnX`,`Team1SpawnY`,`Team1SpawnZ`,`Team2SpawnX`,`Team2SpawnY`,`Team2SpawnZ`,`PBAreaX`,`PBAreaY`,`PBAreaZ`,`PBAreaA`,`Interior` FROM `"PREFIX"PB` WHERE `ID`='%d' LIMIT 1", Rand);
	mysql_query(Query);
	mysql_store_result();
	mysql_fetch_row(String);
	sscanf(String, "p<|>ffffffffffd",PBTeam1SpawnX,PBTeam1SpawnY,PBTeam1SpawnZ,PBTeam2SpawnX,PBTeam2SpawnY,PBTeam2SpawnZ,PBAreaX,PBAreaY,PBAreaZ,PBAreaA,InteriorPB);
    mysql_free_result();
	PBZone = GangZoneCreate(PBAreaX,PBAreaZ,PBAreaY,PBAreaA);
	GangZoneShowForAll(PBZone,0xFFFF0033);
    PBTime = 180;
	PBLiczba = 0;
	PBPoints1 = 0;
	PBPoints2 = 0;
    PBON = true;
	SCMA(0x008080FF," *(PB) Paintball rozpoczęty!");
	foreach(Player,x)
		if(PBKandydat[x])
            GetPlayerActualInfo(x);
			Player[x][InHouse] = false;
			Player[x][OnOnede] = false;
            Player[x][OnCombat] = false;
			Player[x][OnMinigun] = false;
	 		Player[x][OnRPG] = false;
			TextDrawShowForPlayer(x, PBTD);
	        TextDrawHideForPlayer(x,ChowanyTD);
	        KillTimer(Player[x][HealthTimer]);
		    KillTimer(Player[x][ArmourTimer]);
	        SetPlayerWorldBounds(x,20000.0000,-20000.0000,20000.0000,-20000.0000); //Reset world to player
	        if(Player[x][InHouse])
		        Player[x][InHouse] = false;
		        Player[x][ObokHouse] = false;
		        Player[x][NearHouse] = false;	
			PBAwayCount[x] = 0;
			ResetPlayerWeapons(x);
			GivePlayerWeapon(x,23,1000);
            PlaySoundForPlayer(x, 30800);
			SetPlayerHealth(x,10);
			SetPlayerArmour(x,0);
			SetPlayerSkin(x, 287);
			PBTeam[x] = 1;
			SetPlayerTeam(x,1);
			SetPlayerColor(x,0xFF0000FF);
			Player[x][Color] = 0xFF0000FF;
            format(Player[x][ChatColor],15,HexToString(Player[x][Color]));
			SetPlayerInterior(x,InteriorPB);
			SetPlayerVirtualWorld(x,13);
			new randx = random(10);
			new randy = random(10);
			SetPlayerPos(x,PBTeam1SpawnX-5+randx,PBTeam1SpawnY-5+randy,PBTeam1SpawnZ);
			TogglePlayerControllable(x,0);
			SetTimerEx("JailUnfreeze",2000,0,"i",x);
			PBTeamLiczba[1] ++;
			if(PBTeamLiczba[1] > PBTeamLiczba[2])
				PBTeam[x] = 2;
				SetPlayerTeam(x,2);
				SetPlayerColor(x,0xFFFF00FF);
				Player[x][Color] = 0xFFFF00FF;
                format(Player[x][ChatColor],15,HexToString(Player[x][Color]));
				SetPlayerInterior(x,InteriorPB);
				SetPlayerVirtualWorld(x,13);
				SetPlayerPos(x,PBTeam2SpawnX-5+randx,PBTeam2SpawnY-5+randy,PBTeam2SpawnZ);
				TogglePlayerControllable(x,0);
				SetTimerEx("JailUnfreeze",2000,0,"i",x);
				PBTeamLiczba[2] ++;
				PBTeamLiczba[1] --;
    ZapisyUpdate();
	return 1;
forward PBPlayerCheck();
public PBPlayerCheck()
	if(!PBON) return 1;
	foreach(Player,x)
		if(IsPlayerConnected(x) && PBTeam[x] > 0)
			if(InteriorPB == 0)
				if(!IsPlayerInArea(x,PBAreaX,PBAreaY,PBAreaZ,PBAreaA) && !Player[x][FloatDeath])
					PBAwayCount[x] ++;
					SCM(x, C_RED, " {FFFFFF}*(PB) {FF0000}Wracaj na teren paintball!");
					if(PBAwayCount[x] >= 3)
						PBPlayerEnd(x);
						SetPlayerActualInfo(x);
						SCM(x, C_RED, " {FFFFFF}*(PB) {FF0000}Uciekłeś(aś) właśnie z paintball'a!");
			if(InteriorPB != 0)
				if(GetPlayerInterior(x) != InteriorPB)
					PBAwayCount[x] ++;
					SCM(x, C_RED, " {FFFFFF}*(PB) {FF0000}Wracaj na teren paintball!");
					if(PBAwayCount[x] >= 3)
						PBPlayerEnd(x);
						SetPlayerActualInfo(x);
						SCM(x, C_RED, " {FFFFFF}*(PB) {FF0000}Uciekłeś(aś) właśnie z paintball'a!");
   			new weap = GetPlayerWeapon(x);
			if(weap != 0 && weap != 23)
				SCM(x, C_RED, " {FFFFFF}*(PB) {FF0000}Ta broń jest nie dozwolona na paintball'u!");
				ResetPlayerWeapons(x);
				GivePlayerWeapon(x,23,1000);
	return 1;
forward PBEndCheck();
public PBEndCheck()
	if(!PBON) return 1;
	if(PBON && PBTime <= 0)
		if(PBPoints1 == PBPoints2)
			SCMA(0x008080FF," {FFFFFF}*(PB) {008080}Mamy Remis na Paintball'u!");
			PBoff();
			return 1;
		if(PBPoints1 > PBPoints2)
			SCMA(0x008080FF," {FFFFFF}*(PB) {008080}Paintball wygrywają żółci!");
			foreach(Player,x)
				if(PBTeam[x] == 2)
                    Player[x][WygranychPB] ++;
					PlayCompleteMissionSound(x);
					Player[x][Money] += 5000;
                    GivePlayerMoney(x, 5000);
					Player[x][Exp] += 15;
     				if(Player[x][Level] < GetPlayerLevel(x))
   						LevelUp(x);
					GameTextForPlayer(x,"~w~Exp + ~b~~h~15", 1000, 1);
			PBoff();
			return 1;
		if(PBPoints1 < PBPoints2)
			SCMA(0x008080FF," {FFFFFF}*(PB) {008080}Paintball wygrywają czerwoni!");
			foreach(Player,x)
				if(PBTeam[x] == 1)
                    Player[x][WygranychPB] ++;
					PlayCompleteMissionSound(x);
                    Player[x][Money] += 5000;
                    GivePlayerMoney(x, 5000);
					Player[x][Exp] += 15;
                    if(Player[x][Level] < GetPlayerLevel(x))
   						LevelUp(x);
					GameTextForPlayer(x,"~w~Exp + ~b~~h~15", 1000, 1);
			PBoff();
			return 1;
	return 1;
forward PBPlayerEnd(playerid);
public PBPlayerEnd(playerid)
	PBTeam[playerid] = 0;
	PBKandydat[playerid] = false;
    TextDrawHideForPlayer(playerid, PBTD);
	SetPlayerTeam(playerid,playerid+10);
	return 1;
forward PBoff();
public PBoff()
	KillTimer(PBTimer);
	foreach(Player,x)
		PBGlos[x] = false;
		if(PBTeam[x] == 1 || PBTeam[x] == 2)
			SetPlayerActualInfo(x);
			SetPlayerHealth(x, 100.0);
			TextDrawHideForPlayer(x, PBTD);
		SetPlayerTeam(x,x+10);
		PBTeam[x] = 0;
		PBKandydat[x] = false;
	PBLiczba = 0;
	PBTime = 0;
	PBTeamLiczba[1] = 0;
	PBTeamLiczba[2] = 0;
	PBON = false;
	PBStarted = false;
	GangZoneHideForAll(PBZone);
	ZapisyUpdate();
	return 1;
forward ChowanyWyznaczArene();
public ChowanyWyznaczArene()
	new rand = random(22);
 	if(!CHExists(rand))
		ChowanyWyznaczArene();
		return 1;
    new chowanystring[50];
	new szukanystring[50];
	new strefastring[50];
	ChWystartowala = true;
    new Query[255], String[255];
	format(Query,255,"SELECT ChowanyTP,SzukanyTP,Interior,Strefa FROM `"PREFIX"CH` WHERE `ID`='%d' LIMIT 1",rand);
	mysql_query(Query);
	mysql_store_result();
	mysql_fetch_row(String,"|");
	sscanf(String, "p<|>s[50]s[50]ds[60]",chowanystring,szukanystring,ChInt,strefastring);
    mysql_free_result();
    sscanf(chowanystring, "p<,>fff",ChowPosX,ChowPosY,ChowPosZ);
    sscanf(szukanystring, "p<,>fff",SzukPosX,SzukPosY,SzukPosZ);
	sscanf(strefastring, "p<,>ffff",ChAreaX,ChAreaY,ChAreaZ,ChAreaA);
	SetTimer("ChowWyznaczSzuk",500,0);
    ChNum = 0;
    ZapisyUpdate();
	return 1;
forward ChowWyznaczSzuk();
public ChowWyznaczSzuk()
	new num;
	foreach(Player,x)
		if(ChowanyZapisany[x])
			num ++;
	if(num <= 0)
		ChowanyEnd();
		SCMA(C_RED," "W"*(CH) "R"Zabawa w chowanego nie mogła wystartować, nikt się nie zapisał");
		return 1;
	new num2 = num/5;
	if(num2 <=0) num2 = 1;
	new cd;
	for(new x=0;x<num;x++)
		new id = ChowanyKandydat[x];
		if(IsPlayerConnected(id) && !Szukajacy[id])
			Chowany[id] = false;
			Szukajacy[id] = true;
			cd ++;
			SCM(id,C_GREEN," "W"*(CH) "G"Zostałeś(aś) wylosowany(a) jako szukający(a)");
			if(cd >= num2) break;
	for(new x=0;x<50;x++)
		if(ChowanyKandydat[x] > -1)
			new idd = ChowanyKandydat[x];
			if(!Szukajacy[idd] && IsPlayerConnected(idd))
				Chowany[idd] = true;
				Szukajacy[idd] = false;
				SCM(idd,C_GREEN," "W"*(CH) "G"Zostałeś(aś) wylosowany(a) jako chowający(a) się");
	SetTimer("ChowStrt",2000,0);
	return 1;
forward ChowStrt();
public ChowStrt()
    new bla = 0;
	foreach(Player,x)
		ChowanyZapisany[x] = false;
		if(Chowany[x])
            GetPlayerActualInfo(x);
			Player[x][InHouse] = false;
			Player[x][OnOnede] = false;
            Player[x][OnCombat] = false;
			Player[x][OnMinigun] = false;
	 		Player[x][OnRPG] = false;
 	        SetPlayerWorldBounds(x,20000.0000,-20000.0000,20000.0000,-20000.0000); //Reset world to player
 	        if(Player[x][InHouse])
		        Player[x][InHouse] = false;
		        Player[x][ObokHouse] = false;
		        Player[x][NearHouse] = false;
			WyscigUczestnik[x] = false;
			WGTeam[x] = 0;
			WGKandydat[x] = false;
		    SNKandydat[x] = false;
			SetPlayerPos(x,ChowPosX,ChowPosY,ChowPosZ);
			SetPlayerInterior(x,ChInt);
			SetPlayerVirtualWorld(x,2);
			SetPlayerColor(x,0xFFFFFF00);
            bla ++;
			ResetPlayerWeapons(x);
	if(bla < 2)
		ChowanyEnd();
		SCMA(C_RED," "W"*(CH) "R"Zabawa w chowanego nie mogła wystartować, zbyt mało chowających się");
		return 1;
	foreach(Player,x)
		if(Szukajacy[x])
            GetPlayerActualInfo(x);
			Player[x][InHouse] = false;
		    Player[x][OnOnede] = false;
            Player[x][OnCombat] = false;
			Player[x][OnMinigun] = false;
	 		Player[x][OnRPG] = false;
	        TextDrawHideForPlayer(x,PBTD);
	        TextDrawHideForPlayer(x, RaceStats[x]);
	        TextDrawShowForPlayer(x,ChowanyTD);
            Update3DTextLabelText(lExp[x], 0xFFFFFF00, " ");
	        SetPlayerWorldBounds(x,20000.0000,-20000.0000,20000.0000,-20000.0000); //Reset world to player
			new string[80];
			format(string, sizeof(string), " {FFFFFF}*(CH) "Y"Do znalezienia masz %d graczy!", bla);
			SCM(x, C_YELLOW, string);
		if(Chowany[x])
  			TextDrawHideForPlayer(x, RaceStats[x]);
            TextDrawHideForPlayer(x,PBTD);
			TextDrawShowForPlayer(x,ChowanyTD);
            Update3DTextLabelText(lExp[x], 0xFFFFFF00, " ");
	ChCountLiczba = 31;
	KillTimer(Chtimercount);
	Chtimercount = SetTimer("Count",1000,1);
	Chtimerszuk = SetTimer("Szukaja",31000,0);
	SCMA(C_GREEN," "W"*(CH) "G"Zabawa w chowanego Wystartowała!");
	TextDrawSetString(ChowanyTD,"_");
	return 1;
forward ChowanyCheck();
public ChowanyCheck()
	if(!ChWystartowala) return 1;
	ChLiczba = 0;
	SzLiczba = 0;
	foreach(Player,x)
		if(Chowany[x])
			ChLiczba ++;
		else if(Szukajacy[x])
			SzLiczba ++;
	if(ChLiczba == 1)
		foreach(Player,i)
			if(Chowany[i])
				Player[i][Exp] += 15;
                if(Player[i][Level] < GetPlayerLevel(i))
   						LevelUp(i);
				GameTextForPlayer(i,"~w~Exp + ~b~~h~15", 1000, 1);
                Player[i][Money] += 5000;
                GivePlayerMoney(i, 5000);
				for(new x=0;x<50;x++)
					ChowanyKandydat[x] = -1;
				ChNum = 0;
				PlayCompleteMissionSound(i);
				new string[128];
				format(string, sizeof(string), " "W"*(CH) {FF0066}%s wygrał zabawę w chowanego! Zapisy wznowione.", Player[i][Name],i);
				SCMA(C_PINK, string);
                SoundForAll(1150);
				KillTimer(Chtimercount);
				KillTimer(Chtimerszuk);
				ChStarted = false;
				ChLiczba = 0;
				ChCountLiczba = 31;
				ChWystartowala = false;
				Player[i][WygranychCH] ++;
				format(string,sizeof(string),"~r~~h~Chowany~n~~w~Zwyciezca: ~y~%s (%d)",Player[i][Name],i);
				TextDrawSetString(ChowanyTD,string);
				SetTimer("ChowanyTDoff",7000,0);
            if(Szukajacy[i] || Chowany[i])
				ResetPlayerWeapons(i);
				SetPlayerActualInfo(i);
				SetPlayerHealth(i,100);
				SetPlayerInterior(i,0);
				SetPlayerVirtualWorld(i,0);
			Chowany[i] = false;
			Szukajacy[i] = false;
			ChowanyZapisany[i] = false;
		ZapisyUpdate();
		return 1;
	if(ChLiczba <= 0 || SzLiczba <= 0)
		for(new x=0;x<50;x++)
			ChowanyKandydat[x] = -1;
		ChNum = 0;
		SCMA(C_RED," "W"*(CH) "R"Chowany zakończony bez zwycięzcy!");
		KillTimer(Chtimercount);
		KillTimer(Chtimerszuk);
		ChLiczba = 0;
		ChWystartowala = false;
		ChStarted = false;
		ChCountLiczba = 31;
		ChowanyTDoff();
		foreach(Player,u)
			if(Szukajacy[u] || Chowany[u])
				ResetPlayerWeapons(u);
				SetPlayerHealth(u,100);
				SetPlayerActualInfo(u);
				SetPlayerInterior(u,0);
				SetPlayerVirtualWorld(u,0);
			Chowany[u] = false;
			Szukajacy[u] = false;
			ChowanyZapisany[u] = false;
	new string[67];
	format(string,sizeof(string),"~r~~h~Chowany~n~~w~Chowajacych: ~y~%d ~w~Szukajacych: ~y~%d",ChLiczba,SzLiczba);
	TextDrawSetString(ChowanyTD,string);
	return 1;
forward ChowanyTDoff();
public ChowanyTDoff()
    TextDrawSetString(ChowanyTD,"_");
	TextDrawHideForAll(ChowanyTD);
	return 1;
forward Count();
public Count()
	ChCountLiczba --;
	new string[64];
	format(string, sizeof(string), "~r~~h~Chowany~n~~w~Kryc sie! ~y~%d ~w~sek.", ChCountLiczba);
    TextDrawSetString(ChowanyTD,string);
	if(ChCountLiczba == 0)
		KillTimer(Chtimercount);
		return 1;
	return 1;
forward Szukaja();
public Szukaja()
	foreach(Player,x)
		if(Szukajacy[x])
			WyscigUczestnik[x] = false;
			WGTeam[x] = 0;
			WGKandydat[x] = false;
            SNKandydat[x] = false;
			SetPlayerPos(x,SzukPosX,SzukPosY,SzukPosZ);
			SetPlayerInterior(x,ChInt);
			GivePlayerWeapon(x,38,10000);
            PlaySoundForPlayer(x, 30800);
			SetPlayerHealth(x,99999);
			SetPlayerVirtualWorld(x,2);
			SetPlayerColor(x,C_ERROR);
		if(Chowany[x])
			SetPlayerVirtualWorld(x,2);
	return 1;
// Pod tą linijką jest funkcja ChowanyAutoEnd.
forward ChowanyAutoEnd();
public ChowanyAutoEnd()
	SCMA(C_RED," "W"*(CH) "R"Chowany został przerwany przez serwer");
    ChowanyEnd();
	return 1;
forward ChowanyEnd();
public ChowanyEnd()
	ChWystartowala = false;
	foreach(Player,x)
		if(Szukajacy[x] || Chowany[x])
			ResetPlayerWeapons(x);
			SetPlayerHealth(x,100);
			SetPlayerActualInfo(x);
			SetPlayerInterior(x,0);
			SetPlayerVirtualWorld(x,0);
		Chowany[x] = false;
		Szukajacy[x] = false;
		ChowanyZapisany[x] = false;
	ChLiczba = 0;
	ChCountLiczba = 31;
	KillTimer(Chtimercount);
	KillTimer(Chtimerszuk);
	ChowanyTDoff();
	for(new x=0;x<50;x++)
		ChowanyKandydat[x] = -1;
	ChNum = 0;
	ChStarted = false;
	ZapisyUpdate();
	return 1;
forward ChowanyAreaCheck();
public ChowanyAreaCheck()
	if(!ChWystartowala) return 1;
	foreach(Player,x)
		if(IsPlayerConnected(x))
			if(Chowany[x] || Szukajacy[x])
				if(Player[x][AFK])
					SCM(x,C_RED," "W"*(CH) "R"Uciekłeś(aś) na AFK podczas zabawy i zostałeś(aś) zdyskwalifikowany(a)");
					ResetPlayerWeapons(x);
					SetPlayerPos(x, 2140.6675,993.1867,10.5248);
					SetPlayerInterior(x,0);
					SetPlayerHealth(x,100);
					SetPlayerVirtualWorld(x,0);
					Chowany[x] = false;
					Szukajacy[x] = false;
					ChowanyZapisany[x] = false;
					return 1;
				new idx = GetPlayerAnimationIndex(x);
				if(ChCountLiczba <= 0)
					if(!IsPlayerInArea(x,ChAreaX,ChAreaY,ChAreaZ,ChAreaA) && ChInt == 0 || GetPlayerInterior(x) != ChInt || idx == 1538 || idx == 1539 || idx == 1541 || idx == 1544)
						if(AwayCount[x] < 2)
							SCM(x, C_RED, " "W"*(CH) "R"Wracaj na teren zabawy!");
							AwayCount[x] ++;
							return 1;
						SCM(x,C_RED," "W"*(CH) "R"Uciekłeś(aś) poza teren zabawy i zostałeś(aś) zdyskwalifikowany(a)");
						ResetPlayerWeapons(x);
						SetPlayerActualInfo(x);
						SetPlayerHealth(x,100);
			            TextDrawHideForPlayer(x,ChowanyTD);
						Chowany[x] = false;
						Szukajacy[x] = false;
						ChowanyZapisany[x] = false;
						AwayCount[x] = 0;
					else
						AwayCount[x] = 0;
	return 1;
forward DerbyStart();
public DerbyStart()
	DerbyON = true;
	DerbyLoad = true;
    DerbyStartON = false;
	new cd;
	foreach(Player,x)
		if(IsPlayerConnected(x) && DerbyMen[x])
	        GetPlayerActualInfo(x);
	        Player[x][InHouse] = false;
	        Player[x][OnOnede] = false;
            Player[x][OnCombat] = false;
			Player[x][OnMinigun] = false;
			Player[x][OnRPG] = false;
			WyscigUczestnik[x] = false;
			Chowany[x] = false;
            PBTeam[x] = 0;
            TextDrawHideForPlayer(x, PBTD);
			WGTeam[x] = 0;
			WGKandydat[x] = false;
            SNKandydat[x] = false;
            SetPlayerWorldBounds(x,20000.0000,-20000.0000,20000.0000,-20000.0000); //Reset world to player
			for(new i=0;i<50;i++)
				if(ChowanyKandydat[i] == x)
					ChowanyKandydat[i] = -1;
					break;
            if(Player[x][InHouse])
		        Player[x][InHouse] = false;
		        Player[x][ObokHouse] = false;
		        Player[x][NearHouse] = false;
		    ResetPlayerWeapons(x);
		    SCM(x,C_GREEN," *(US) Aby się wypisać wpisz "G2"/UsExit"G".");
		    TogglePlayerControllable(x,0);
		    SetTimerEx("JailUnfreeze",3000,0,"i",x);
			if(DerbyRand == 0)
	            SetVehicleVirtualWorld(DerbyCar[cd],5);
				SetPlayerVirtualWorld(x,5);
				SetVehicleToRespawn(DerbyCar[cd]);
				SetPlayerInterior(x, 0);
				SetVehicleHealth(DerbyCar[cd],999999);
				SetPlayerPos(x,-189.3335,-612.0821,67.7825);
				SetTimerEx("DerbyPutInCar",2500,0,"ii",x,DerbyCar[cd]);
			else
	            SetVehicleVirtualWorld(DerbyCar2[cd],5);
				SetPlayerVirtualWorld(x,5);
                SetPlayerInterior(x, 0);
				SetVehicleToRespawn(DerbyCar2[cd]);
				SetVehicleHealth(DerbyCar2[cd],999999);
				SetPlayerPos(x,-4214.1768,-2167.5132,4.2961);
				SetTimerEx("DerbyPutInCar",3000,0,"ii",x,DerbyCar2[cd]);
			cd ++;
	SCMA(0xA346FFFF," "W"*(US) {A346FF}Uważaj Spadasz wystartował!");
    ZapisyUpdate();
	return 1;
forward DerbyPutInCar(playerid,carid);
public DerbyPutInCar(playerid,carid)
    PutPlayerInVehicle(playerid,carid,0);
	if(DerbyRand == 1)
		new Float:r,Float:w,Float:t;
		GetVehiclePos(GetPlayerVehicleID(playerid), r,w,t);
		SetVehiclePos(GetPlayerVehicleID(playerid),r,w,4.1);
	DerbyLoad = false;
	return 1;
forward DerbyCheck();
public DerbyCheck()
	if(!DerbyON) return 1;
	if(DerbyLoad) return 1;
	new Licz;
	foreach(Player,x)
		if(DerbyMen[x])
			Licz ++;
			new Float:xx,Float:y,Float:z;
			GetPlayerPos(x,xx,y,z);
            if(DerbyRand == 0)
				if(floatround(z) <= 20 || !IsPlayerInAnyVehicle(x) || Player[x][AFK])
				    Licz --;
			        DerbyMen[x] = false;
			        DerbyZaglosowal[x] = false;
			        if(IsPlayerInAnyVehicle(x))
			        	new veh = GetPlayerVehicleID(x);
			        	SetVehicleVirtualWorld(veh,2);
			        SetPlayerActualInfo(x);
			if(DerbyRand == 1)
				if(floatround(z) <= 0 || !IsPlayerInAnyVehicle(x) || Player[x][AFK])
				    Licz --;
			        DerbyMen[x] = false;
			        DerbyZaglosowal[x] = false;
			        if(IsPlayerInAnyVehicle(x))
			        	new veh = GetPlayerVehicleID(x);
			        	SetVehicleVirtualWorld(veh,2);
			        SetPlayerActualInfo(x);
	if(Licz <= 1)
	    foreach(Player,x)
		    if(DerbyMen[x])
				new str[128];
				format(str,sizeof(str)," "W"*(US) {A346FF}Uważaj spadasz wygrywa %s , Zapisy wznowione!",Player[x][Name]);
				SCMA(0xA346FFFF,str);
				SoundForAll(1150);
                PlayCompleteMissionSound(x);
				Player[x][WygranychUS] ++;
				Player[x][Exp] += 15;
	            if(Player[x][Level] < GetPlayerLevel(x))
					LevelUp(x);
	   			GameTextForPlayer(x,"~w~Exp + ~b~~h~15", 1000, 1);
	    DerbyEnd();
		return 1;
	return 1;
forward DerbyEnd();
public DerbyEnd()
	DerbyON = false;
    DerbyStartON = false;
	foreach(Player,x)
		if(DerbyMen[x])
			SetPlayerActualInfo(x);
		DerbyMen[x] = false;
		DerbyZaglosowal[x] = false;
	for(new x=0;x<16;x++)
		SetVehicleVirtualWorld(DerbyCar[x],5);
        SetVehicleVirtualWorld(DerbyCar2[x],5);
	ZapisyUpdate();
	return 1;
forward TotalRaceEnd();
public TotalRaceEnd()
	KillTimer(RaceTimer);
	foreach(Player,x)
		if(WyscigUczestnik[x])
			DisablePlayerRaceCheckpoint(x);
			SetPlayerVirtualWorld(x, 0);
			TextDrawHideForPlayer(x, RaceStats[x]);
		WyscigUczestnik[x] = false;
		WyscigStatus[x] = 0;
		TextDrawHideForPlayer(x, RaceStats[x]);
	WSMans = 0;
	NaMecieMiejsce = 0;
	RaceWystartowal = false;
	PlayerCarNum = 0;
	for(new x=0;x<MAX_RACE_CP;x++)
		Pozycja[x] = 0;
	for(new x=0;x<10;x++)
	    if(!IsVehicleInUse(Car[x]))
			DestroyVehicleEx(Car[x]);
    ZapisyUpdate();
	return 1;
forward RaceCount();
public RaceCount()
	foreach(Player,x)
		if(WyscigUczestnik[x])
			new string[10];
			if(CountLicz >= 1)
				format(string,10,"~w~%d",CountLicz);
				GameTextForPlayer(x,string,2000,3);
				PlayerPlaySound(x, 1056, 0, 0, 0);
				TogglePlayerControllable(x,0);
			else
				GameTextForPlayer(x,"~y~START",2000,3);
				PlayerPlaySound(x, 1057, 0, 0, 0);
	if(CountLicz <= 0)
		foreach(Player,x)
			if(WyscigUczestnik[x])
				TogglePlayerControllable(x,1);
		return 1;
	CountLicz --;
	SetTimer("RaceCount",1000,0);
	return 1;
forward RaceAutoStart();
public RaceAutoStart()
	if(RaceWystartowal) return 1;
	RaceID = random(30);
	if(!WSExists(RaceID))
		RaceAutoStart();
		return 1;
	if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
    new Query[1500], String[1500];
	format(Query, 1500,"SELECT `Interior`,`Model`,`CP_LICZBA`,`Angle`,`CP_SIZE`,`CP_TYPE`,`ON_FOOT` FROM `"PREFIX"WS` WHERE `ID`='%d' LIMIT 1", RaceID);
	mysql_query(Query);
	mysql_store_result();
	mysql_fetch_row(String);
	sscanf(String, "p<|>dddfddd",RaceInterior,CarModel,CPliczba,RaceSpawnA,CPSize,CPType,RaceOnFoot);
	WSMans = 0;
	foreach(Player,x)
		if(WyscigUczestnik[x])
			WSMans ++;
            Player[x][OnOnede] = false;
            Player[x][OnCombat] = false;
			Player[x][OnMinigun] = false;
	 		Player[x][OnRPG] = false;
            SetPlayerWorldBounds(x,20000.0000,-20000.0000,20000.0000,-20000.0000); //Reset world to player
    new string[256];
	for(new x=0;x<WSMans;x++)
		format(Query, 256,"SELECT `C_%d` FROM "PREFIX"WS WHERE `ID`='%d' LIMIT 1",x,RaceID);
        mysql_query(Query);
		mysql_store_result();
		mysql_fetch_row(String);
        sscanf(String, "p<|>s[120]",string);
		sscanf(string, "p<,>fff",CarSpawnX[x],CarSpawnY[x],CarSpawnZ[x]);
	for(new x=0;x<CPliczba;x++)
		format(Query, 256,"SELECT `CP_%d` FROM "PREFIX"WS WHERE `ID`='%d' LIMIT 1",x,RaceID);
        mysql_query(Query);
		mysql_store_result();
		mysql_fetch_row(String);
		sscanf(String, "p<|>s[120]",string);
        sscanf(string, "p<,>fff",CPx[x],CPy[x],CPz[x]);
	mysql_free_result();
	for(new x=0;x<WSMans;x++)
        Player[x][InHouse] = false;
		Car[x] = CreateVehicle(CarModel,CarSpawnX[x],CarSpawnY[x],CarSpawnZ[x],RaceSpawnA,-1,-1,9999);
		LinkVehicleToInterior(Car[x],RaceInterior);
		SetVehicleVirtualWorld(Car[x],1);
	RaceWystartowal = true;
	PlayerCarNum = 0;
	SCMA(0xFF00FFFF," *(WS) Wyścig wystartował!");
    mysql_free_result();
	KillTimer(RaceStartTimer);
	RaceStartTimer = SetTimer("RaceStart",1000,0);
	return 1;
forward RaceStart();
public RaceStart()
	KillTimer(RaceTimer);
	RaceTimer = SetTimer("TotalRaceEnd",300000,false);
	foreach(Player,x)
		if(WyscigUczestnik[x])
            GetPlayerActualInfo(x);
			SetPlayerColor(x, 0x59E551FF);
			Player[x][Color] = 0x59E551FF;
		    format(Player[x][ChatColor],15,HexToString(Player[x][Color]));
		    PBTeam[x] = 0;
            TextDrawHideForPlayer(x, PBTD);
	        TextDrawHideForPlayer(x,ChowanyTD);
			Chowany[x] = false;
			DerbyMen[x] = false;
			WGTeam[x] = 0;
			WGKandydat[x] = false;
            SNKandydat[x] = false;
            if(Player[x][InHouse])
		        Player[x][InHouse] = false;
		        Player[x][ObokHouse] = false;
		        Player[x][NearHouse] = false;
			for(new i=0;i<50;i++)
				if(ChowanyKandydat[i] == x)
					ChowanyKandydat[i] = -1;
					break;
			SetPlayerInterior(x,RaceInterior);
			SetPlayerVirtualWorld(x,1);
			ResetPlayerWeapons(x);
			PutPlayerInVehicle(x,Car[PlayerCarNum],0);
			WyscigStatus[x] = 0;
			SetPlayerRaceCheckpoint(x,CPType,CPx[WyscigStatus[x]],CPy[WyscigStatus[x]],CPz[WyscigStatus[x]],CPx[WyscigStatus[x]+1],CPy[WyscigStatus[x]+1],CPz[WyscigStatus[x]+1],CPSize);
			TogglePlayerControllable(x,0);
			if(RaceOnFoot == 1)
				DestroyVehicleEx(Car[PlayerCarNum]);
			PlayerCarNum ++;
   			TextDrawShowForPlayer(x, RaceStats[x]);
	CountLicz = 3;
	RaceCount();
    ZapisyUpdate();
	return 1;
stock GetVehicleModelIDFromName(vname[])
	for(new i = 0; i < 211; i++)
		if(strfind(CarList[i],vname,true) != -1)
		return i+400;
	return -1;
stock IsInParking(playerid)
	if(IsPlayerInArea(playerid,2254.9153,2359.9431,1380.3641,1526.6163)) return 1; //G1
    if(IsPlayerInArea(playerid,1869.5453,2019.3574,1722.1704,1872.5408)) return 1; //G2
    if(IsPlayerInArea(playerid,2033.9816,2117.3416,2362.1548,2444.0037)) return 1; //G3
    if(IsPlayerInArea(playerid,1676.5981,1738.0406,1160.3583,1252.6394)) return 1; //G4
	return 0;
stock IsPlayerInFreeZone(playerid)
	if(IsPlayerInArea(playerid, -102.0093,488.8185, 1661.8014, 2204.8889)) return 1;
	if(IsPlayerInArea(playerid,392.2149,782.6511,716.4636,1049.3254)) return 1;
	if(PlayerToPoint(140,playerid,2618.8625,2729.7747,36.5386)) return 1;
	return 0;
stock IsPlayerInBezDmZone(playerid)
    if(IsPlayerInArea(playerid, -2557.7664,-2328.0522,-741.7057,-526.3204)) return 1; //Drift3
    if(IsPlayerInArea(playerid, -1656.6671,-1492.0673,-2820.3381,-2666.0032)) return 1; //Warsztat
    if(IsPlayerInArea(playerid, 1785.2123,2091.2017,-6882.3555,-6379.6655)) return 1; //Nascar
    if(IsPlayerInArea(playerid, 2142.0176,2223.3738,-4084.6072,-3940.1150)) return 1; //Tor
    if(IsPlayerInArea(playerid, -1842.8026,-1768.6263,480.3416,582.5101)) return 1; //Kulki
    if(IsPlayerInArea(playerid, 2363.2397,2398.1533,1092.1472,1117.4971)) return 1; //Impra
	return 0;
stock GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);
	if(GetPlayerVehicleID(playerid))
		GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
stock IntToHex(int)
	new
 	buffer[8],i = 0,result[8],g = 0;
	while(int > 0)
 		new tmp = int % 16;
 		if(tmp < 10)
		 	buffer[i] = tmp + 48;
 		else
	  		buffer[i] = tmp + 55;
 		i++;
 		int = int / 16;
	for(i = strlen(buffer) - 1; i >= 0; i--)
	 	result[g++] = buffer[i];
	while(strlen(result) < 6)
 		strins(result, "0", 0);
	return result;
stock HexToInt(string[])
   	if(string[0] == 0) return 0;
   	new
    cur = 1,
    res = 0;
   	for(new i = strlen(string); i > 0; i--)
       	if(string[i - 1] < 58)
  	 		res = res + cur * (string[i - 1] - 48);
       	else
           	res = res + cur * (string[i - 1] - 65 + 10);
 		cur = cur * 16;
   	return res;
stock HexToString(hex)
	hex >>= 8;
	new divider=1048576, digit, idx, output[7];
	for (new i; i < 6; i++)
		digit=hex/divider;
	 	hex -= digit * divider;
		divider /= 16;
		if (digit < 0)
			digit += 16;
		if (digit < 10)
			output [idx++] = '0' + digit;
		else
			output [idx++] = 'A' + digit - 10;
	return output;
stock FindValidText(String[])
	if(strlen(String) > 32)
	    return false;
    for(new Char = 0; Char < strlen(String); Char++)
        if(String[Char] >= 'a' && String[Char] <= 'z')
            continue;
		if(String[Char] >= 'A' && String[Char] <= 'Z')
		    continue;
		if(String[Char] >= '0' && String[Char] <= '9')
		    continue;
		if(String[Char] == '_' || String[Char] == '.' || String[Char] == '[' || String[Char] == ']' || String[Char] == '(' || String[Char] == ')')
		    continue;
		return false;
	return true;
stock FindSQLInjection(String[])
	if(strfind(String, "INSERT", true)== 0) return 1;
    if(strfind(String, "UPDATE", true)== 0) return 1;
    if(strfind(String, "DELETE", true)== 0) return 1;
    if(strfind(String, "FROM", true)== 0) return 1;
    if(strfind(String, "DROP", true)== 0)return 1;
    if(strfind(String, "ALTER", true)== 0)return 1;
    if(strfind(String, "TABLE", true)== 0)return 1;
    if(strfind(String, "WHERE", true)== 0)return 1;
    if(strfind(String, "SELECT", true)== 0)return 1;
    if(strfind(String, "NULL", true)== 0)return 1;
    if(strfind(String, "EXISTS", true)== 0)return 1;
    if(strfind(String, "--", true)== 0)return 1;
    if(strfind(String, "'", true)== 0)return 1;
    if(strfind(String, "`", true)== 0)return 1;
   
	return 0;
stock TuneCar(vehicleid)
	switch(GetVehicleModel(vehicleid))
		case 400:
		AddVehComp(vehicleid,1008,1009,1010,1013,1018,1019,1020,1021,1024,1086,1087);
		case 401:
		AddVehComp(vehicleid,1001,1003,1004,1005,1006,1007,1008,1009,1010,1013,1017,1019,1020,1086,10871142,1143,1144,1145);
		case 404:
		AddVehComp(vehicleid,1000,1002,1007,1008,1009,1010,1013,1016,1017,1019,1020,1021,1086,1087);
		case 405:
		AddVehComp(vehicleid,1000,1001,1008,1009,1010,1014,1018,1019,1020,1021,1023,1086,1087);
		case 410:
		AddVehComp(vehicleid,1001,1003,1007,1008,1009,1010,1013,1017,1019,1020,1021,1023,1024,1086,1087);
		case 415:
		AddVehComp(vehicleid,1001,1003,1007,1008,1009,1010,1017,1018,1019,1023,1086,1087);
		case 418:
		AddVehComp(vehicleid,1002,1006,1008,1009,1010,1016,1020,1021,1086,1087);
		case 420:
		AddVehComp(vehicleid,1001,1003,1004,1005,1008,1009,1010,1019,1021,1086,1087);
		case 421:
		AddVehComp(vehicleid,1000,1008,1009,1010,1014,1016,1018,1019,1020,1021,1023,1086,1087);
		case 422:
		AddVehComp(vehicleid,1007,1008,1009,1010,1013,1017,1019,1020,1021,1086,1087);
		case 426:
		AddVehComp(vehicleid,1001,1003,1004,1005,1006,1008,1009,1010,1019,1021,1086,1087);
		case 436:
		AddVehComp(vehicleid,1001,1003,1006,1007,1008,1009,1010,1013,1017,1019,1020,1021,1022,1086,1087);
		case 439:
		AddVehComp(vehicleid,1001,1003,1007,1008,1009,1010,1013,1017,1023,1086,1087,1142,1143,1144,1145);
		case 477:
		AddVehComp(vehicleid,1006,1007,1008,1009,1010,1017,1018,1019,1020,1021,1086,1087);
		case 478:
		AddVehComp(vehicleid,1004,1005,1008,1009,1010,1012,1013,1020,1021,1022,1024,1086,1087);
		case 489:
		AddVehComp(vehicleid,1000,1002,1004,1005,1006,1008,1009,1010,1013,1016,1018,1019,1020,1024,1086,1087);
		case 491:
		AddVehComp(vehicleid,1003,1007,1008,1009,1010,1014,1017,1018,1019,1020,1021,1023,1086,1087,1142,1143,1144,1145);
		case 492:
		AddVehComp(vehicleid,1000,1004,1005,1006,1008,1009,1010,1016,1086,1087);
		case 496:
		AddVehComp(vehicleid,1001,1002,1003,1006,1007,1008,1009,1010,1011,1017,1019,1020,1023,1086,1087);
		case 500:
		AddVehComp(vehicleid,1008,1009,1010,1013,1019,1020,1021,1024,1086,1087);
		case 505:
		AddVehComp(vehicleid,1000,1002,1004,1005,1006,1008,1009,1010,1013,1016,1018,1019,1020,1024,1086,1087);
		case 516:
		AddVehComp(vehicleid,1000,1002,1004,1007,1008,1009,1010,1015,1016,1017,1018,1019,1020,1021,1086,1087);
		case 517:
		AddVehComp(vehicleid,1002,1003,1007,1008,1009,1010,1016,1017,1018,1019,1020,1023,1086,1087,1142,1143,1144,1145);
		case 518:
		AddVehComp(vehicleid,1001,1003,1005,1006,1007,1008,1009,1010,1013,1017,1018,1020,1023,1086,1087,1142,1143,1144,1145);
		case 527:
		AddVehComp(vehicleid,1001,1007,1008,1009,1010,1014,1015,1017,1018,1020,1021,1086,1087);
		case 529:
		AddVehComp(vehicleid,1001,1003,1006,1007,1008,1009,1010,1011,1012,1017,1018,1019,1020,1023,1086,1087);
		case 534:
		AddVehComp(vehicleid,1008,1009,1010,1086,1087,1100,1101,1106,1122,1123,1124,1125,1126,1127,1178,1179,1180,1185);
		case 535:
		AddVehComp(vehicleid,1008,1009,1010,1086,1087,1109,1110,1111,1112,1113,1114,1115,1116,1117,1118,1119,1120,1121);
		case 536:
		AddVehComp(vehicleid,1008,1009,1010,1086,1087,1103,1104,1105,1107,1108,1128,1181,1182,1183,1184);
		case 540:
		AddVehComp(vehicleid,1001,1004,1006,1007,1008,1009,1010,1017,1018,1019,1020,1023,1024,1086,1087,1142,1143,1144,1145);
		case 542:
		AddVehComp(vehicleid,1008,1009,1010,1014,1015,1018,1019,1020,1021,1086,1087,1142,1143,1144,1145);
		case 546:
		AddVehComp(vehicleid,1001,1002,1004,1006,1007,1008,1009,1010,1017,1018,1019,1023,1024,1086,1087,1142,1143,1144,1145);
		case 547:
		AddVehComp(vehicleid,1000,1003,1008,1009,1010,1016,1018,1019,1020,1021,1086,1087);
		case 549:
		AddVehComp(vehicleid,1001,1003,1007,1008,1009,1010,1011,1012,1017,1018,1019,1020,1023,1086,1087,1142,1143,1144,1145);
		case 550:
		AddVehComp(vehicleid,1001,1003,1004,1005,1006,1008,1009,1010,1018,1019,1020,1023,1086,1087,1142,1143,1144,1145);
		case 551:
		AddVehComp(vehicleid,1002,1003,1005,1006,1008,1009,1010,1016,1018,1019,1020,1021,1023,1086,1087);
		case 558:
		AddVehComp(vehicleid,1008,1009,1010,1086,1087,1088,1089,1090,1091,1092,1093,1094,1095,1163,1164,1165,1166,1167,1168);
		case 559:
		AddVehComp(vehicleid,1008,1009,1010,1065,1066,1067,1068,1069,1070,1071,1072,1086,1087,1158,1159,1160,1161,1162,1173);
		case 560:
		AddVehComp(vehicleid,1008,1009,1010,1026,1027,1028,1029,1030,1031,1032,1033,1086,1087,1138,1139,1140,1141,1169,1170);
		case 561:
		AddVehComp(vehicleid,1008,1009,1010,1055,1056,1057,1058,1059,1060,1061,1062,1063,1064,1086,1087,1154,1155,1156,1157);
		case 562:
		AddVehComp(vehicleid,1008,1009,1010,1034,1035,1036,1037,1038,1039,1040,1041,1086,1087,1146,1147,1148,1149,1171,1172);
		case 565:
		AddVehComp(vehicleid,1008,1009,1010,1045,1046,1047,1048,1049,1050,1051,1052,1053,1054,1086,1087,1150,1151,1152,1153);
		case 567:
		AddVehComp(vehicleid,1008,1009,1010,1086,1087,1102,1129,1130,1131,1132,1133,1186,1187,1188,1189);
		case 575:
		AddVehComp(vehicleid,1008,1009,1010,1042,1043,1044,1086,1087,1099,1174,1175,1176,1177);
		case 576:
		AddVehComp(vehicleid,1008,1009,1010,1086,1087,1134,1135,1136,1137,1190,1191,1192,1193);
		case 580:
		AddVehComp(vehicleid,1001,1006,1007,1008,1009,1010,1017,1018,1020,1023,1086,1087);
		case 585:
		AddVehComp(vehicleid,1001,1003,1006,1007,1008,1009,1010,1013,1017,1018,1019,1020,1023,1086,1087,1142,1143,1144,1145);
		case 589:
		AddVehComp(vehicleid,1000,1004,1005,1006,1007,1008,1009,1010,1013,1016,1017,1018,1020,1024,1086,1087,1142,1143,1144,1145);
		case 600:
		AddVehComp(vehicleid,1004,1005,1006,1007,1008,1009,1010,1013,1017,1018,1020,1022,1086,1087);
		case 603:
		AddVehComp(vehicleid,1001,1006,1007,1008,1009,1010,1017,1018,1019,1020,1023,1024,1086,1087,1142,1143,1144,1145);
		case 402,409,411,412,419,424,
		438,442,445,451,458,466,
		467,474,475,479,480,506,
		507,526,533,541,545,555,
		566,579,587,602:
		AddVehComp(vehicleid,1008,1009,1010,1086,1087);
	return 1;
stock AddVehComp(vehicleid, ...)
	new Wheels[] =
		1025, 1073, 1074, 1075,
		1076, 1077, 1078, 1079,
		1080, 1081, 1082, 1083,
		1084, 1085, 1096, 1097,
		1098;
	AddVehicleComponent(vehicleid, Wheels[random(sizeof(Wheels))]);
	ChangeVehiclePaintjob(vehicleid, random(3));
	for(new n = 1; n < numargs(); n++)
    	if(IsVehicleValidComponent(vehicleid,getarg(n, 0)))
			AddVehicleComponent(vehicleid, getarg(n, 0));
	return 1;
PlayerBuyVip(playerid, cost, days)
	Player[playerid][Portfel] -= cost;
	Player[playerid][WaznoscVip] += days;
	if(Player[playerid][SuspensionVip] <= 0)
		Player[playerid][Vip] = true;
    if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
    new String[155];
	if(VipExists(Player[playerid][Name]))
	    format(String,sizeof(String), "UPDATE "PREFIX"Vips SET Waznosc='%d' WHERE Name='%s'",Player[playerid][WaznoscVip],Player[playerid][Name]);
		mysql_query(String);
	else
	    format(String,sizeof(String), "INSERT INTO "PREFIX"Vips VALUES('%s','%d','0')",Player[playerid][Name],Player[playerid][WaznoscVip]);
		mysql_query(String);
	format(String,sizeof(String), "UPDATE "PREFIX"Users SET Portfel='%d' WHERE Name='%s'",Player[playerid][Portfel],Player[playerid][Name]);
	mysql_query(String);
	format(String,sizeof(String), ""I" "W"Gratulacje! Zakupiłeś konto VIP! Ważność: %d dni. Sprawdź komendy vipa.",Player[playerid][WaznoscVip]);
    SCM(playerid, C_WHITE, String);
LevelUp(playerid)
	TextDrawShowForPlayer(playerid, tdLevelUp);
	Player[playerid][Level] = GetPlayerLevel(playerid);
	Player[playerid][LevelUpTime] = 9;
	GivePlayerMoney(playerid, 8000);
	Player[playerid][Money] += 8000;
    PlayCompleteMissionSound(playerid);
stock IsPlayerNearAnyone(userid, Float:Distance)
	new Float:PlayerPos[3], Float:OtherPos[3];
	GetPlayerPos(userid, PlayerPos[0], PlayerPos[1], PlayerPos[2]);
	foreach(Player,OtherId)
		if(userid != OtherId)
			if(Player[OtherId][gSpectateType] == 1)
			    continue;
		    if(GetPlayerInterior(OtherId) != GetPlayerInterior(userid))
		        continue;
			if(GetPlayerState(userid) == PLAYER_STATE_DRIVER && GetPlayerState(OtherId) == PLAYER_STATE_PASSENGER)
			    continue;
            if(GetPlayerState(OtherId) == PLAYER_STATE_DRIVER && GetPlayerState(userid) == PLAYER_STATE_PASSENGER)
			    continue;
			if(Player[userid][Admin1])
			    continue;
			    
			if(Player[userid][Mod])
			    continue;
			GetPlayerPos(OtherId, OtherPos[0], OtherPos[1], OtherPos[2]);
			if(floatabs(PlayerPos[0]-OtherPos[0]) <= Distance)
			    if(floatabs(PlayerPos[1]-OtherPos[1]) <= Distance)
			        if(floatabs(PlayerPos[2]-OtherPos[2]) <= Distance)
						return true;
	return false;
stock LoopingAnim(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, lockz, lp)
	gPlayerUsingAnim[playerid] = true;
	ApplyAnimation(playerid, animlib, animname, Speed, looping, lockx, locky, lockz, lp);
stock OnePlayAnim(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, lockz, lp)
	gPlayerUsingAnim[playerid] = true;
	ApplyAnimation(playerid, animlib, animname, Speed, looping, lockx, locky, lockz, lp);
stock StopLoopingAnim(playerid)
	gPlayerUsingAnim[playerid] = false;
	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
	ClearAnimations(playerid);
stock GetPlayerLevel(playerid)
	new Lvl;
	do {
	    Lvl++; while(Lvl*Lvl*6 < Player[playerid][Exp]);
	return (Lvl-1 < 1) ? 1 : Lvl-1;
stock IsTrailer(vehicleid)
	new model = GetVehicleModel(vehicleid);
	switch(model)
		case 435:return 1;
		case 450:return 1;
		case 591:return 1;
		case 606:return 1;
		case 610:return 1;
		case 584:return 1;
		case 608:return 1;
		case 611:return 1;
		case 607:return 1;
	return 0;
stock IsVehicleInUse(vehicleid)
 	foreach(Player,x)
		if(GetPlayerVehicleID(x) == vehicleid) return 1;
	return 0;
UpdatePlayerScore(userid)
	SetPlayerScore(userid, Player[userid][Exp]);
	new String[45];
	format(String, sizeof(String), "Exp: %d",Player[userid][Exp]);
	Update3DTextLabelText(lExp[userid], Player[userid][Color], String);
ShowServerStats(playerid)//{FFD900} pomarancz {44a428} zielony
	new String[680];
	format(String,sizeof(String), "{44a428}Wejść na serwer: "W"%d\n{44a428}Zarejestrowanych kont: "W"%d\n{44a428}Ogólnych fragów: "W"%d\n{44a428}Ogólnych śmierci: "W"%d\n{44a428}Rozdanych kicków: "W"%d\n{44a428}Rozdanych banów: "W"%d\n{44a428}Rekord graczy: "W"%d\n\n",GlobalJoins,GlobalUsers,GlobalKills,GlobalDeaths,GlobalKicks,GlobalBans,RekordGraczy);
    format(String,sizeof(String), "%s"W"Informacje dodatkowe\n\n{44a428}Załadowanych obiektów: "W"%d\n{44a428}Prywatnych pojazdów ogółem: "W"%d\n{44a428}Załadowanych domów: "W"%d\n{44a428}Załadowanych biznesów: "W"%d\n\nDane aktualizowane są co 10 minut.",String,CountDynamicObjects(),TotalPrivCars,TotalHouses,TotalBiznes);
    SPD(playerid, D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Statystyki serwera",String,"Zamknij","");
ShowPlayerStats(playerid,userid)
	new StringM[1500];
    new Float:Ratio = floatdiv(Player[userid][Kills], Player[userid][Deaths]);
    if(Player[userid][Kills] == 0 && Player[userid][Deaths] == 0)
		Ratio = 0.00;
    if(Player[userid][Kills] > Player[userid][Deaths] && Player[userid][Deaths] == 0)
		Ratio = Player[userid][Kills];
    new Float:sec = Player[userid][TimePlay];
	sec = sec/60;
	sec = sec - (Player[userid][TimePlay]/60);
	sec = 60*sec;
	format(StringM,sizeof(StringM), "{44a428}Exp: "W"%d/%d\n{44a428}Level: "W"%d\n{44a428}Zabójstw: "W"%d\n{44a428}Śmierci: "W"%d\n{44a428}Ratio: "W"%.2f\n",Player[userid][Exp],GetPlayerNextExp(userid),Player[userid][Level],Player[userid][Kills],Player[userid][Deaths],Ratio);
	format(StringM,sizeof(StringM), "%s{44a428}Samobójstw: "W"%d\n{44a428}Łączna kasa: "W"%d $\n{44a428}Ping: "W"%d ms\n",StringM,Player[userid][Suicides],Player[userid][Bank]+Player[userid][Money],GetPlayerPing(userid));
	format(StringM,sizeof(StringM), "%s{44a428}Zapisany skin: "W"%d\n{44a428}Ogólny czas gry: "W"%d godzin, %d minut\n{44a428}Najlepszy drifting: "W"%d pkt.\n{44a428}Otrzymanych kicków: "W"%d\n{44a428}Otrzymanych banów: "W"%d\n\n",StringM,Player[userid][Skin],Player[userid][TimePlay]/60,floatround(sec),Player[userid][DriftScore],Player[userid][Kicks],Player[userid][Bans]);
    format(StringM,sizeof(StringM), "%s{44a428}Wygranych WG: "W"%d\n{44a428}Wygranych WS: "W"%d\n{44a428}Wygranych CH: "W"%d\n{44a428}Wygranych PB: "W"%d\n{44a428}Wygranych US: "W"%d\n{44a428}Wygranych SN: "W"%d\n\n",StringM,Player[userid][WygranychWG],Player[userid][WygranychWS],Player[userid][WygranychCH],Player[userid][WygranychPB],Player[userid][WygranychUS],Player[userid][WygranychSN]);
	format(StringM,sizeof(StringM), "%s"W"Wyniki z aren DM:\n\n{44a428}Arena Solo: "W"%d {44a428}wygranych\nMinigun: "W"%d {44a428}zabójstw\nRPG: "W"%d {44a428}zabójstw\nOnede: "W"%d {44a428}zabójstw\nCombat: "W"%d {44a428}zabójstw",StringM,Player[userid][SoloScore],Player[userid][MinigunScore],Player[userid][RPGScore],Player[userid][OnedeScore],Player[userid][CombatScore]);
    SPD(playerid,D_NONE,DIALOG_STYLE_MSGBOX,Player[userid][Name], StringM, "Zamknij","");
	return 1;
DriftSystem(userid)
	new Float:PlayerAngle, Float:ChangeAngle, Scores, CarHealth, String[255];
	GetVehicleZAngle(GetPlayerVehicleID(userid), PlayerAngle);
	ChangeAngle = PlayerAngle - Player[userid][VAngle];
	if(ChangeAngle > 300.0)
		ChangeAngle = ChangeAngle - 360.0;
	if(ChangeAngle < -300.0)
		ChangeAngle = ChangeAngle + 360.0;
	if(ChangeAngle < 0.0)
		ChangeAngle = -ChangeAngle;
	CarHealth = GetRealVehicleHealth(userid);
	if(CarHealth < Player[userid][VHealth] && Player[userid][Drift])
		format(String, sizeof(String), "~r~~h~Drift przerwany z wynikiem %d pkt!", Player[userid][Drift] * Player[userid][DriftCombo]);
        ShowInfoBox(userid,String,2);
		Player[userid][Drift] = 0;
		Player[userid][DriftCombo] = 0;
		Player[userid][DriftCount] = 0;
		KillTimer(EndDriftTimer[userid]);
	else
		if(GetVehSpeed(GetPlayerVehicleID(userid)) >= DRIFT_SPEED && ChangeAngle >= DRIFT_ANGLE)
			Player[userid][DriftCount]++;
			if(Player[userid][DriftCount] == 1 || (Player[userid][DriftCount] % 8 == 0 && Player[userid][DriftCount] <= 8 * (MAX_DRIFT_COMBO - 1)))
				Player[userid][DriftCombo]++;
			KillTimer(EndDriftTimer[userid]);
			Scores = floatround(((ChangeAngle * 1.25) * (GetVehSpeed(GetPlayerVehicleID(userid)) * 0.2)) / 10);
			Player[userid][Drift] = Player[userid][Drift] + Scores;
			if(Player[userid][Drift] * Player[userid][DriftCombo] > 50000)
                format(String, sizeof(String), "Drifting: ~y~%d pkt. ~w~~h~Combo: ~y~X%d ~w~~h~- Mistrzowski drift!", Player[userid][Drift],Player[userid][DriftCombo]);
			else if(Player[userid][Drift] * Player[userid][DriftCombo] > 40000)
                format(String, sizeof(String), "Drifting: ~y~%d pkt. ~w~~h~Combo: ~y~X%d ~w~~h~- Ekspercki drift!", Player[userid][Drift],Player[userid][DriftCombo]);
			else if(Player[userid][Drift] * Player[userid][DriftCombo] > 30000)
                format(String, sizeof(String), "Drifting: ~y~%d pkt. ~w~~h~Combo: ~y~X%d ~w~~h~- Profesjonalny drift!", Player[userid][Drift],Player[userid][DriftCombo]);
            else if(Player[userid][Drift] * Player[userid][DriftCombo] > 20000)
                format(String, sizeof(String), "Drifting: ~y~%d pkt. ~w~~h~Combo: ~y~X%d ~w~~h~- Wspanialy drift!", Player[userid][Drift],Player[userid][DriftCombo]);
            else if(Player[userid][Drift] * Player[userid][DriftCombo] > 10000)
                format(String, sizeof(String), "Drifting: ~y~%d pkt. ~w~~h~Combo: ~y~X%d ~w~~h~- Drift na medal!", Player[userid][Drift],Player[userid][DriftCombo]);
            else if(Player[userid][Drift] * Player[userid][DriftCombo] > 7000)
                format(String, sizeof(String), "Drifting: ~y~%d pkt. ~w~~h~Combo: ~y~X%d ~w~~h~- Dobry drift!", Player[userid][Drift],Player[userid][DriftCombo]);
            else if(Player[userid][Drift] * Player[userid][DriftCombo] > 5000)
                format(String, sizeof(String), "Drifting: ~y~%d pkt. ~w~~h~Combo: ~y~X%d ~w~~h~- Niezly drift!", Player[userid][Drift],Player[userid][DriftCombo]);
            else if(Player[userid][Drift] * Player[userid][DriftCombo] > 0)
                format(String, sizeof(String), "Drifting: ~y~%d pkt. ~w~~h~Combo: ~y~X%d ~w~~h~- Slaby drift...", Player[userid][Drift],Player[userid][DriftCombo]);
            ShowInfoBox(userid,String,60);
			EndDriftTimer[userid] = SetTimerEx("SuccessDrift", (1000 + ((6 - Player[userid][DriftCombo]) * 350)), false, "%d", userid);
	GetVehicleZAngle(GetPlayerVehicleID(userid), Player[userid][VAngle]);
forward SuccessDrift(userid);
public SuccessDrift(userid)
	if(Player[userid][Drift] > 0)
		new String[255];
		format(String, sizeof(String), "~g~~h~Drift zakonczony z wynikiem %d pkt!", Player[userid][Drift] * Player[userid][DriftCombo]);
        ShowInfoBox(userid,String,2);
        PlaySoundForPlayer(userid, 1058);
		if(Player[userid][Drift] * Player[userid][DriftCombo] > Player[userid][DriftScore])
			Player[userid][DriftScore] = Player[userid][Drift] * Player[userid][DriftCombo];
            if(Player[userid][DriftScore] >= 20000)
                Achievement(userid, "aKrolDriftu");
			if(Player[userid][DriftScore] >= 5000)
                Achievement(userid, "aDrifter");
	Player[userid][Drift] = 0;
	Player[userid][DriftCombo] = 0;
	Player[userid][DriftCount] = 0;
	return 1;
CMD:dajkase(playerid,cmdtext[])
	return cmd_givecash(playerid,cmdtext);
CMD:czysc(playerid)
	for(new i = 0; i < 100; i++) SCM(playerid, C_WHITE, " ");
	return 1;
CMD:fryzura(playerid, params[])
    new fryzura;
	if(sscanf(params,"d", fryzura)) return SCM(playerid, C_WHITE, ""E" "W"/fryzura [1-5]");
    if(fryzura > 5) return SCM(playerid, C_WHITE, ""E" "W"/fryzura [1-5].");
    SCM(playerid, C_WHITE, ""I" "W"Fryzjer zmienił ci fryzurę. Aby przywrócić normalną wpisz /fReset.");
	if(fryzura == 1)
	    if(IsPlayerAttachedObjectSlotUsed(playerid,SLOT_FRYZURA)) RemovePlayerAttachedObject(playerid,SLOT_FRYZURA);
		SetPlayerAttachedObject(playerid, SLOT_FRYZURA, 18640, 2, 0.081841, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
	if(fryzura == 2)
	    if(IsPlayerAttachedObjectSlotUsed(playerid,SLOT_FRYZURA)) RemovePlayerAttachedObject(playerid,SLOT_FRYZURA);
		SetPlayerAttachedObject(playerid, SLOT_FRYZURA, 18975, 2, 0.128191, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
	if(fryzura == 3)
	    if(IsPlayerAttachedObjectSlotUsed(playerid,SLOT_FRYZURA)) RemovePlayerAttachedObject(playerid,SLOT_FRYZURA);
		SetPlayerAttachedObject(playerid, SLOT_FRYZURA, 19077, 2, 0.124588, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
	if(fryzura == 4)
	    if(IsPlayerAttachedObjectSlotUsed(playerid,SLOT_FRYZURA)) RemovePlayerAttachedObject(playerid,SLOT_FRYZURA);
    	SetPlayerAttachedObject(playerid, SLOT_FRYZURA, 19136, 2, 0.141113, 0.006911, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
	if(fryzura == 5)
	    if(IsPlayerAttachedObjectSlotUsed(playerid,SLOT_FRYZURA)) RemovePlayerAttachedObject(playerid,SLOT_FRYZURA);
		SetPlayerAttachedObject(playerid, SLOT_FRYZURA, 19274, 2, 0.099879, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
	return 1;
CMD:freset(playerid)
    if(IsPlayerAttachedObjectSlotUsed(playerid, SLOT_FRYZURA)) RemovePlayerAttachedObject(playerid, SLOT_FRYZURA);
    SCM(playerid, C_WHITE, ""I" "W"Usunąłeś swoją fryzure.");
    return 1;
CMD:flo(playerid)
    if(IsPlayerNearAnyone(playerid, 15.0))
		SPD(playerid, D_NONE, DIALOG_STYLE_MSGBOX, "{00BFFF}Spawn", "Niestety nie możesz tego zrobić!\nPrawdobodobnie próbujesz uciec z walki.\n\nAby temu zaradzić odjedź na pewną odlgegłość\nod graczy obok ciebie.", "Zamknij", "");
	    return 0;
	SetPlayerRandomSpawn(playerid);
	return 1;
CMD:drift(playerid)
	if(Player[playerid][DriftEnabled])
	    Player[playerid][DriftEnabled] = false;
	    SCM(playerid, C_GREEN, ""WI" "G"Drift został wyłączony. Aby włączyć ponownie wpisz /drift");
	else
	    Player[playerid][DriftEnabled] = true;
	    SCM(playerid, C_GREEN, ""WI" "G"Drift został włączony. Aby wyłączyć ponownie wpisz /drift");
	return 1;
forward VehicleUpdateAndMain();
public VehicleUpdateAndMain()
    new String[130];
	foreach(Player,x)
		if(GetPlayerState(x) == PLAYER_STATE_DRIVER && Player[x][LicznikON] && GetPlayerVehicleSeat(x) == 0 && !Player[x][AFK])
            if(Player[x][DriftEnabled] && IsVehicleCar(GetPlayerVehicleID(x)))
				DriftSystem(x);
			new vehid = GetPlayerVehicleID(x);
			new model = GetVehicleModel(vehid);
			Player[x][VHealth] = GetRealVehicleHealth(x);
			if(GetVehSpeed(vehid) >= 120)
				format(String,sizeof(String), "~r~~h~%d ~w~~h~km/h___HP: %d/100",GetVehSpeed(vehid),Player[x][VHealth]);
			else if(GetVehSpeed(vehid) > 60)
   				format(String,sizeof(String), "~y~%d ~w~~h~km/h___HP: %d/100",GetVehSpeed(vehid),Player[x][VHealth]);
            else if(GetVehSpeed(vehid) <= 60)
   				format(String,sizeof(String), "~g~~h~%d ~w~~h~km/h___HP: %d/100",GetVehSpeed(vehid),Player[x][VHealth]);
			TextDrawSetString(LicznikPredkosc[x], String);
			TextDrawSetString(LicznikNazwa[x], CarList[model-400]);
	return 1;
DelTrailers()
	for(new x=MaxPojazdow;x<2000;x++)
		if(IsTrailer(x))
			DestroyVehicleEx(x);
	SCMA(C_YELLOW,""WI" "Y"Nieużywane naczepy pojazdy usunięte!");
	return 1;
DelPojazdy()
	for(new x=MaxPojazdow;x<2000;x++)
		if(GetVehicleModel(x) == 0) continue;
		if(!IsVehicleInUse(x) && !IsTrailer(x))
            new bool:block;
		    for(new i=0;i<MAX_PRIVATE_VEHICLES;i++)
		    	if(vInfo[i][vID] == x)
					block = true;
					break;
			if(block) continue;
			DestroyVehicleEx(x);
	SCMA(C_YELLOW,""WI" "Y"Nieużywane stworzone pojazdy usunięte!");
	return 1;
////////////////////////-----[System Osiągnięć]----/////////////////////////////
Achievement(playerid, name[])
    if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	if(strfind(name,"aRegistered",false) == 0 && Player[playerid][Registered])
		if(AchievementGet[playerid][aRegistered] == 0)
            AchievementGet[playerid][aRegistered] = 1;
			ShowAchievementGet(playerid, "~y~Nowe osiagniecie! ~n~~w~~h~Witamy!");
            PlaySoundForPlayer(playerid, 1058);
			Player[playerid][Exp] += 15;
			GivePlayerMoney(playerid, 5000);
			Player[playerid][Money] += 5000;
            if(Player[playerid][Level] < GetPlayerLevel(playerid))
				LevelUp(playerid);
			GameTextForPlayer(playerid,"~w~Exp + ~b~~h~15", 1000, 1);
			new String[128];
			format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aRegistered='1' WHERE Name='%s'",Player[playerid][Name]);
			mysql_query(String);
            PlayCompleteMissionSound(playerid);
    else if(strfind(name,"aTrofea",false) == 0 && Player[playerid][Registered])
		if(AchievementGet[playerid][aTrofea] <= 7)
			if(AchievementGet[playerid][aTrofea] != 7)
				AchievementGet[playerid][aTrofea] ++;
			if(AchievementGet[playerid][aTrofea] == 7)
				AchievementGet[playerid][aTrofea] ++;
				ShowAchievementGet(playerid, "~y~Nowe osiagniecie! ~n~~w~~h~Trofea!");
				PlaySoundForPlayer(playerid, 1058);
				new String[128];
				format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aTrofea='8' WHERE Name='%s'",Player[playerid][Name]);
				mysql_query(String);
                Player[playerid][Exp] += 50;
				GivePlayerMoney(playerid, 5000);
				Player[playerid][Money] += 5000;
	            if(Player[playerid][Level] < GetPlayerLevel(playerid))
					LevelUp(playerid);
				GameTextForPlayer(playerid,"~w~Exp + ~b~~h~50", 1000, 1);
                PlayCompleteMissionSound(playerid);
			else
	            new String[128];
				format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aTrofea='%d' WHERE Name='%s'",AchievementGet[playerid][aTrofea],Player[playerid][Name]);
				mysql_query(String);
    			format(String,sizeof(String), "~y~Trofea ~n~~w~~h~Status: %d/7",AchievementGet[playerid][aTrofea]);
				ShowAchievementGet(playerid, String);
	            PlaySoundForPlayer(playerid, 1058);
    else if(strfind(name,"aDoscTego",false) == 0  && Player[playerid][Registered])
		if(AchievementGet[playerid][aDoscTego] <= 10)
			if(AchievementGet[playerid][aDoscTego] != 10)
				AchievementGet[playerid][aDoscTego] ++;
			if(AchievementGet[playerid][aDoscTego] == 10)
				AchievementGet[playerid][aDoscTego] ++;
				ShowAchievementGet(playerid, "~y~Nowe osiagniecie! ~n~~w~~h~Dosc Tego!");
				PlaySoundForPlayer(playerid, 1058);
				new String[128];
				format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aDoscTego='11' WHERE Name='%s'",Player[playerid][Name]);
				mysql_query(String);
                Player[playerid][Exp] += 30;
				GivePlayerMoney(playerid, 5000);
				Player[playerid][Money] += 5000;
	            if(Player[playerid][Level] < GetPlayerLevel(playerid))
					LevelUp(playerid);
				GameTextForPlayer(playerid,"~w~Exp + ~b~~h~30", 1000, 1);
                PlayCompleteMissionSound(playerid);
			else
	            new String[128];
                if(Player[playerid][Registered])
					format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aDoscTego='%d' WHERE Name='%s'",AchievementGet[playerid][aDoscTego],Player[playerid][Name]);
					mysql_query(String);
				format(String,sizeof(String), "~y~Dosc Tego! ~n~~w~~h~Status: %d/10",AchievementGet[playerid][aDoscTego]);
				ShowAchievementGet(playerid, String);
	            PlaySoundForPlayer(playerid, 1058);
    else if(strfind(name,"aKask",false) == 0 && Player[playerid][Registered])
		if(AchievementGet[playerid][aKask] == 0)
            AchievementGet[playerid][aKask] = 1;
			ShowAchievementGet(playerid, "~y~Nowe osiagniecie! ~n~~w~~h~Potrzebuje kask!");
            PlaySoundForPlayer(playerid, 1058);
            Player[playerid][Exp] += 50;
			GivePlayerMoney(playerid, 5000);
			Player[playerid][Money] += 5000;
            if(Player[playerid][Level] < GetPlayerLevel(playerid))
				LevelUp(playerid);
			GameTextForPlayer(playerid,"~w~Exp + ~b~~h~50", 1000, 1);
			new String[128];
			format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aKask='1' WHERE Name='%s'",Player[playerid][Name]);
			mysql_query(String);
            PlayCompleteMissionSound(playerid);
    else if(strfind(name,"aJestemLepszy",false) == 0 && Player[playerid][Registered])
		if(AchievementGet[playerid][aJestemLepszy] == 0)
            AchievementGet[playerid][aJestemLepszy] = 1;
			ShowAchievementGet(playerid, "~y~Nowe osiagniecie! ~n~~w~~h~Jestem Lepszy!");
            PlaySoundForPlayer(playerid, 1058);
           
            Player[playerid][Exp] += 50;
			GivePlayerMoney(playerid, 5000);
			Player[playerid][Money] += 5000;
            if(Player[playerid][Level] < GetPlayerLevel(playerid))
				LevelUp(playerid);
			GameTextForPlayer(playerid,"~w~Exp + ~b~~h~50", 1000, 1);
			new String[128];
			format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aJestemLepszy='1' WHERE Name='%s'",Player[playerid][Name]);
			mysql_query(String);
            PlayCompleteMissionSound(playerid);
    else if(strfind(name,"aJestemMistrzem",false) == 0 && Player[playerid][Registered])
		if(AchievementGet[playerid][aJestemMistrzem] == 0)
            AchievementGet[playerid][aJestemMistrzem] = 1;
			ShowAchievementGet(playerid, "~y~Nowe osiagniecie! ~n~~w~~h~Jestem Mistrzem!");
            PlaySoundForPlayer(playerid, 1058);
           
            Player[playerid][Exp] += 50;
			GivePlayerMoney(playerid, 5000);
			Player[playerid][Money] += 5000;
            if(Player[playerid][Level] < GetPlayerLevel(playerid))
				LevelUp(playerid);
			GameTextForPlayer(playerid,"~w~Exp + ~b~~h~50", 1000, 1);
			new String[128];
			format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aJestemMistrzem='1' WHERE Name='%s'",Player[playerid][Name]);
			mysql_query(String);
            PlayCompleteMissionSound(playerid);
    else if(strfind(name,"aPilot",false) == 0  && Player[playerid][Registered])
		if(AchievementGet[playerid][aPilot] <= 60)
			if(AchievementGet[playerid][aPilot] != 60)
				AchievementGet[playerid][aPilot] ++;
			if(AchievementGet[playerid][aPilot] == 60)
                AchievementGet[playerid][aPilot] ++;
				ShowAchievementGet(playerid, "~y~Nowe osiagniecie! ~n~~w~~h~Pilot!");
				PlaySoundForPlayer(playerid, 1058);
               
                Player[playerid][Exp] += 50;
				GivePlayerMoney(playerid, 5000);
				Player[playerid][Money] += 5000;
	            if(Player[playerid][Level] < GetPlayerLevel(playerid))
					LevelUp(playerid);
				GameTextForPlayer(playerid,"~w~Exp + ~b~~h~50", 1000, 1);
				new String[128];
				format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aPilot='61' WHERE Name='%s'",Player[playerid][Name]);
				mysql_query(String);
                PlayCompleteMissionSound(playerid);
			else
	            new String[128];
                if(Player[playerid][Registered])
					format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aPilot='%d' WHERE Name='%s'",AchievementGet[playerid][aPilot],Player[playerid][Name]);
					mysql_query(String);
				format(String,sizeof(String), "~y~Pilot ~n~~w~~h~Status: %d/60",AchievementGet[playerid][aPilot]);
				ShowAchievementGet(playerid, String);
	            PlaySoundForPlayer(playerid, 1058);
	else if(strfind(name,"a24Godziny",false) == 0 && Player[playerid][Registered])
		if(AchievementGet[playerid][a24Godziny] == 0)
            AchievementGet[playerid][a24Godziny] = 1;
			ShowAchievementGet(playerid, "~y~Nowe osiagniecie! ~n~~w~~h~24 Godziny!");
            PlaySoundForPlayer(playerid, 1058);
            PlayCompleteMissionSound(playerid);
            Player[playerid][Exp] += 50;
			GivePlayerMoney(playerid, 5000);
			Player[playerid][Money] += 5000;
            if(Player[playerid][Level] < GetPlayerLevel(playerid))
				LevelUp(playerid);
			GameTextForPlayer(playerid,"~w~Exp + ~b~~h~50", 1000, 1);
			new String[128];
			format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET a24Godziny='1' WHERE Name='%s'",Player[playerid][Name]);
			mysql_query(String);
	else if(strfind(name,"aDoOstatniegoTchu",false) == 0 && Player[playerid][Registered])
		if(AchievementGet[playerid][aDoOstatniegoTchu] == 0)
            AchievementGet[playerid][aDoOstatniegoTchu] = 1;
			ShowAchievementGet(playerid, "~y~Nowe osiagniecie! ~n~~w~~h~Do ostatniego tchu!");
            PlaySoundForPlayer(playerid, 1058);
            PlayCompleteMissionSound(playerid);
            Player[playerid][Exp] += 50;
			GivePlayerMoney(playerid, 5000);
			Player[playerid][Money] += 5000;
            if(Player[playerid][Level] < GetPlayerLevel(playerid))
				LevelUp(playerid);
			GameTextForPlayer(playerid,"~w~Exp + ~b~~h~50", 1000, 1);
			new String[128];
			format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aDoOstatniegoTchu='1' WHERE Name='%s'",Player[playerid][Name]);
			mysql_query(String);
    else if(strfind(name,"aCelneOko",false) == 0 && Player[playerid][Registered])
		if(AchievementGet[playerid][aCelneOko] <= 100)
			if(AchievementGet[playerid][aCelneOko] != 100)
				AchievementGet[playerid][aCelneOko] ++;
			if(AchievementGet[playerid][aCelneOko] == 100)
                AchievementGet[playerid][aCelneOko] ++;
				ShowAchievementGet(playerid, "~y~Nowe osiagniecie! ~n~~w~~h~Celne Oko!");
				PlaySoundForPlayer(playerid, 1058);
                PlayCompleteMissionSound(playerid);
                Player[playerid][Exp] += 50;
				GivePlayerMoney(playerid, 5000);
				Player[playerid][Money] += 5000;
	            if(Player[playerid][Level] < GetPlayerLevel(playerid))
					LevelUp(playerid);
				GameTextForPlayer(playerid,"~w~Exp + ~b~~h~50", 1000, 1);
                if(Player[playerid][Registered])
					new String[128];
					format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aCelneOko='101' WHERE Name='%s'",Player[playerid][Name]);
					mysql_query(String);
			else
	            new String[128];
                if(Player[playerid][Registered])
					format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aCelneOko='%d' WHERE Name='%s'",AchievementGet[playerid][aCelneOko],Player[playerid][Name]);
					mysql_query(String);
				format(String,sizeof(String), "~y~Celne Oko ~n~~w~~h~Status: %d/100",AchievementGet[playerid][aCelneOko]);
				ShowAchievementGet(playerid, String);
	            PlaySoundForPlayer(playerid, 1058);
    else if(strfind(name,"aZwinnePalce",false) == 0 && Player[playerid][Registered])
		if(AchievementGet[playerid][aZwinnePalce] <= 100)
            AchievementGet[playerid][aZwinnePalce] = Player[playerid][Kodow];
			if(AchievementGet[playerid][aZwinnePalce] == 100)
				ShowAchievementGet(playerid, "~y~Nowe osiagniecie! ~n~~w~~h~Zwinne Palce!");
				PlaySoundForPlayer(playerid, 1058);
                PlayCompleteMissionSound(playerid);
                Player[playerid][Exp] += 50;
				GivePlayerMoney(playerid, 5000);
				Player[playerid][Money] += 5000;
	            if(Player[playerid][Level] < GetPlayerLevel(playerid))
					LevelUp(playerid);
				GameTextForPlayer(playerid,"~w~Exp + ~b~~h~50", 1000, 1);
                if(Player[playerid][Registered])
					new String[128];
					format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aZwinnePalce='101' WHERE Name='%s'",Player[playerid][Name]);
					mysql_query(String);
			else
	            new String[128];
                if(Player[playerid][Registered])
					format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aZwinnePalce='%d' WHERE Name='%s'",AchievementGet[playerid][aZwinnePalce],Player[playerid][Name]);
					mysql_query(String);
				format(String,sizeof(String), "~y~Zwinne Palce ~n~~w~~h~Status: %d/100",AchievementGet[playerid][aZwinnePalce]);
				ShowAchievementGet(playerid, String);
	            PlaySoundForPlayer(playerid, 1058);
    else if(strfind(name,"aPodroznik",false) == 0 && Player[playerid][Registered])
		if(AchievementGet[playerid][aPodroznik] == 0)
            AchievementGet[playerid][aPodroznik] = 1;
			ShowAchievementGet(playerid, "~y~Nowe osiagniecie! ~n~~w~~h~Podroznik!");
            PlaySoundForPlayer(playerid, 1058);
            PlayCompleteMissionSound(playerid);
            Player[playerid][Exp] += 50;
			GivePlayerMoney(playerid, 5000);
			Player[playerid][Money] += 5000;
            if(Player[playerid][Level] < GetPlayerLevel(playerid))
				LevelUp(playerid);
			GameTextForPlayer(playerid,"~w~Exp + ~b~~h~50", 1000, 1);
			new String[128];
			format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aPodroznik='1' WHERE Name='%s'",Player[playerid][Name]);
			mysql_query(String);
    else if(strfind(name,"aDrifter",false) == 0 && Player[playerid][Registered])
		if(AchievementGet[playerid][aDrifter] == 0)
            AchievementGet[playerid][aDrifter] = 1;
			ShowAchievementGet(playerid, "~y~Nowe osiagniecie! ~n~~w~~h~Drifter!");
            PlaySoundForPlayer(playerid, 1058);
            PlayCompleteMissionSound(playerid);
            Player[playerid][Exp] += 50;
			GivePlayerMoney(playerid, 5000);
			Player[playerid][Money] += 5000;
            if(Player[playerid][Level] < GetPlayerLevel(playerid))
				LevelUp(playerid);
			GameTextForPlayer(playerid,"~w~Exp + ~b~~h~50", 1000, 1);
			new String[128];
			format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aDrifter='1' WHERE Name='%s'",Player[playerid][Name]);
			mysql_query(String);
    else if(strfind(name,"aKrolDriftu",false) == 0 && Player[playerid][Registered])
		if(AchievementGet[playerid][aKrolDriftu] == 0)
            AchievementGet[playerid][aKrolDriftu] = 1;
			ShowAchievementGet(playerid, "~y~Nowe osiagniecie! ~n~~w~~h~Krol Driftu!");
            PlaySoundForPlayer(playerid, 1058);
            PlayCompleteMissionSound(playerid);
            Player[playerid][Exp] += 50;
			GivePlayerMoney(playerid, 5000);
			Player[playerid][Money] += 5000;
            if(Player[playerid][Level] < GetPlayerLevel(playerid))
				LevelUp(playerid);
			GameTextForPlayer(playerid,"~w~Exp + ~b~~h~50", 1000, 1);
			new String[128];
			format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aKrolDriftu='1' WHERE Name='%s'",Player[playerid][Name]);
			mysql_query(String);
    else if(strfind(name,"aStreetKing",false) == 0  && Player[playerid][Registered])
		if(AchievementGet[playerid][aStreetKing] <= 10)
			if(AchievementGet[playerid][aStreetKing] != 10)
				AchievementGet[playerid][aStreetKing] ++;
			if(AchievementGet[playerid][aStreetKing] == 10)
   				PlayCompleteMissionSound(playerid);
				AchievementGet[playerid][aStreetKing] ++;
				ShowAchievementGet(playerid, "~y~Nowe osiagniecie! ~n~~w~~h~Street King!");
				PlaySoundForPlayer(playerid, 1058);
                Player[playerid][Exp] += 50;
				GivePlayerMoney(playerid, 5000);
				Player[playerid][Money] += 5000;
	            if(Player[playerid][Level] < GetPlayerLevel(playerid))
					LevelUp(playerid);
				GameTextForPlayer(playerid,"~w~Exp + ~b~~h~50", 1000, 1);
                if(Player[playerid][Registered])
					new String[128];
					format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aStreetKing='11' WHERE Name='%s'",Player[playerid][Name]);
					mysql_query(String);
			else
	            new String[128];
                if(Player[playerid][Registered])
					format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aStreetKing='%d' WHERE Name='%s'",AchievementGet[playerid][aStreetKing],Player[playerid][Name]);
					mysql_query(String);
				format(String,sizeof(String), "~y~Street King! ~n~~w~~h~Status: %d/10",AchievementGet[playerid][aStreetKing]);
				ShowAchievementGet(playerid, String);
	            PlaySoundForPlayer(playerid, 1058);
    else if(strfind(name,"aNowaTozsamosc",false) == 0 && Player[playerid][Registered])
		if(AchievementGet[playerid][aNowaTozsamosc] == 0)
            AchievementGet[playerid][aNowaTozsamosc] = 1;
			ShowAchievementGet(playerid, "~y~Nowe osiagniecie! ~n~~w~~h~Nowa Tozsamosc!");
            PlaySoundForPlayer(playerid, 1058);
            PlayCompleteMissionSound(playerid);
            Player[playerid][Exp] += 50;
			GivePlayerMoney(playerid, 5000);
			Player[playerid][Money] += 5000;
            if(Player[playerid][Level] < GetPlayerLevel(playerid))
				LevelUp(playerid);
			GameTextForPlayer(playerid,"~w~Exp + ~b~~h~50", 1000, 1);
			new String[128];
			format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aNowaTozsamosc='1' WHERE Name='%s'",Player[playerid][Name]);
			mysql_query(String);
    else if(strfind(name,"aDomownik",false) == 0 && Player[playerid][Registered])
		if(AchievementGet[playerid][aDomownik] == 0)
            AchievementGet[playerid][aDomownik] = 1;
			ShowAchievementGet(playerid, "~y~Nowe osiagniecie! ~n~~w~~h~Domownik!");
            PlaySoundForPlayer(playerid, 1058);
            PlayCompleteMissionSound(playerid);
            Player[playerid][Exp] += 50;
			GivePlayerMoney(playerid, 5000);
			Player[playerid][Money] += 5000;
            if(Player[playerid][Level] < GetPlayerLevel(playerid))
				LevelUp(playerid);
			GameTextForPlayer(playerid,"~w~Exp + ~b~~h~50", 1000, 1);
			new String[128];
			format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aDomownik='1' WHERE Name='%s'",Player[playerid][Name]);
			mysql_query(String);
    else if(strfind(name,"aWlasne4",false) == 0 && Player[playerid][Registered])
		if(AchievementGet[playerid][aWlasne4] == 0)
            AchievementGet[playerid][aWlasne4] = 1;
			ShowAchievementGet(playerid, "~y~Nowe osiagniecie! ~n~~w~~h~Wlasne cztery kolka!");
            PlaySoundForPlayer(playerid, 1058);
            PlayCompleteMissionSound(playerid);
            Player[playerid][Exp] += 50;
			GivePlayerMoney(playerid, 5000);
			Player[playerid][Money] += 5000;
            if(Player[playerid][Level] < GetPlayerLevel(playerid))
				LevelUp(playerid);
			GameTextForPlayer(playerid,"~w~Exp + ~b~~h~50", 1000, 1);
			new String[128];
			format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aWlasne4='1' WHERE Name='%s'",Player[playerid][Name]);
			mysql_query(String);
    else if(strfind(name,"aZzzz",false) == 0 && Player[playerid][Registered])
		if(AchievementGet[playerid][aZzzz] == 0)
            AchievementGet[playerid][aZzzz] = 1;
			ShowAchievementGet(playerid, "~y~Nowe osiagniecie! ~n~~w~~h~Zzzz...");
            PlaySoundForPlayer(playerid, 1058);
            PlayCompleteMissionSound(playerid);
            Player[playerid][Exp] += 50;
			GivePlayerMoney(playerid, 5000);
			Player[playerid][Money] += 5000;
            if(Player[playerid][Level] < GetPlayerLevel(playerid))
				LevelUp(playerid);
			GameTextForPlayer(playerid,"~w~Exp + ~b~~h~50", 1000, 1);
			new String[128];
			format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aZzzz='1' WHERE Name='%s'",Player[playerid][Name]);
			mysql_query(String);
    else if(strfind(name,"aWyborowy",false) == 0 && Player[playerid][Registered])
		if(AchievementGet[playerid][aWyborowy] <= 100)
			if(AchievementGet[playerid][aWyborowy] != 100)
				AchievementGet[playerid][aWyborowy] ++;
			if(AchievementGet[playerid][aWyborowy] == 100)
                AchievementGet[playerid][aWyborowy] ++;
				ShowAchievementGet(playerid, "~y~Nowe osiagniecie! ~n~~w~~h~Strzelec Wyborowy!");
				PlaySoundForPlayer(playerid, 1058);
                PlayCompleteMissionSound(playerid);
                Player[playerid][Exp] += 50;
				GivePlayerMoney(playerid, 5000);
				Player[playerid][Money] += 5000;
	            if(Player[playerid][Level] < GetPlayerLevel(playerid))
					LevelUp(playerid);
				GameTextForPlayer(playerid,"~w~Exp + ~b~~h~50", 1000, 1);
                if(Player[playerid][Registered])
					new String[128];
					format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aWyborowy='101' WHERE Name='%s'",Player[playerid][Name]);
					mysql_query(String);
			else
	            new String[128];
                if(Player[playerid][Registered])
					format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aWyborowy='%d' WHERE Name='%s'",AchievementGet[playerid][aWyborowy],Player[playerid][Name]);
					mysql_query(String);
				format(String,sizeof(String), "~y~Strzelec Wyborowy ~n~~w~~h~Status: %d/100",AchievementGet[playerid][aWyborowy]);
				ShowAchievementGet(playerid, String);
	            PlaySoundForPlayer(playerid, 1058);
    else if(strfind(name,"aKomandos",false) == 0 && Player[playerid][Registered])
		if(AchievementGet[playerid][aKomandos] <= 100)
			if(AchievementGet[playerid][aKomandos] != 100)
				AchievementGet[playerid][aKomandos] ++;
			if(AchievementGet[playerid][aKomandos] == 100)
                AchievementGet[playerid][aKomandos] ++;
				ShowAchievementGet(playerid, "~y~Nowe osiagniecie! ~n~~w~~h~Komandos!");
				PlaySoundForPlayer(playerid, 1058);
                PlayCompleteMissionSound(playerid);
                Player[playerid][Exp] += 50;
				GivePlayerMoney(playerid, 5000);
				Player[playerid][Money] += 5000;
	            if(Player[playerid][Level] < GetPlayerLevel(playerid))
					LevelUp(playerid);
				GameTextForPlayer(playerid,"~w~Exp + ~b~~h~50", 1000, 1);
                if(Player[playerid][Registered])
					new String[128];
					format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aKomandos='101' WHERE Name='%s'",Player[playerid][Name]);
					mysql_query(String);
			else
	            new String[128];
                if(Player[playerid][Registered])
					format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aKomandos='%d' WHERE Name='%s'",AchievementGet[playerid][aKomandos],Player[playerid][Name]);
					mysql_query(String);
				format(String,sizeof(String), "~y~Komandos ~n~~w~~h~Status: %d/100",AchievementGet[playerid][aKomandos]);
				ShowAchievementGet(playerid, String);
	            PlaySoundForPlayer(playerid, 1058);
    else if(strfind(name,"aWedkarz",false) == 0 && Player[playerid][Registered])
		if(AchievementGet[playerid][aWedkarz] <= 100)
			if(AchievementGet[playerid][aWedkarz] != 100)
				AchievementGet[playerid][aWedkarz] ++;
			if(AchievementGet[playerid][aWedkarz] == 100)
                AchievementGet[playerid][aWedkarz] ++;
				ShowAchievementGet(playerid, "~y~Nowe osiagniecie! ~n~~w~~h~Wedkarz!");
				PlaySoundForPlayer(playerid, 1058);
                PlayCompleteMissionSound(playerid);
                Player[playerid][Exp] += 50;
				GivePlayerMoney(playerid, 5000);
				Player[playerid][Money] += 5000;
	            if(Player[playerid][Level] < GetPlayerLevel(playerid))
					LevelUp(playerid);
				GameTextForPlayer(playerid,"~w~Exp + ~b~~h~50", 1000, 1);
                if(Player[playerid][Registered])
					new String[128];
					format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aWedkarz='101' WHERE Name='%s'",Player[playerid][Name]);
					mysql_query(String);
			else
	            new String[128];
                if(Player[playerid][Registered])
					format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aWedkarz='%d' WHERE Name='%s'",AchievementGet[playerid][aWedkarz],Player[playerid][Name]);
					mysql_query(String);
				format(String,sizeof(String), "~y~Wedkarz ~n~~w~~h~Status: %d/100",AchievementGet[playerid][aWedkarz]);
				ShowAchievementGet(playerid, String);
	            PlaySoundForPlayer(playerid, 1058);
    else if(strfind(name,"aStalyGracz",false) == 0 && Player[playerid][Registered])
		if(AchievementGet[playerid][aStalyGracz] <= 10)
			if(AchievementGet[playerid][aStalyGracz] != 10)
				AchievementGet[playerid][aStalyGracz] ++;
			if(AchievementGet[playerid][aStalyGracz] == 10)
                AchievementGet[playerid][aStalyGracz] ++;
				ShowAchievementGet(playerid, "~y~Nowe osiagniecie! ~n~~w~~h~Staly Gracz!");
				PlaySoundForPlayer(playerid, 1058);
                PlayCompleteMissionSound(playerid);
                Player[playerid][Exp] += 50;
				GivePlayerMoney(playerid, 5000);
				Player[playerid][Money] += 5000;
	            if(Player[playerid][Level] < GetPlayerLevel(playerid))
					LevelUp(playerid);
				GameTextForPlayer(playerid,"~w~Exp + ~b~~h~50", 1000, 1);
                if(Player[playerid][Registered])
					new String[128];
					format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aStalyGracz='11' WHERE Name='%s'",Player[playerid][Name]);
					mysql_query(String);
			else
	            new String[128];
                if(Player[playerid][Registered])
					format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aStalyGracz='%d' WHERE Name='%s'",AchievementGet[playerid][aStalyGracz],Player[playerid][Name]);
					mysql_query(String);
				format(String,sizeof(String), "~y~Staly Gracz ~n~~w~~h~Status: %d/10",AchievementGet[playerid][aStalyGracz]);
				ShowAchievementGet(playerid, String);
	            PlaySoundForPlayer(playerid, 1058);
    else if(strfind(name,"aPoszukiwacz",false) == 0 && Player[playerid][Registered])
		if(AchievementGet[playerid][aPoszukiwacz] <= 20)
			if(AchievementGet[playerid][aPoszukiwacz] != 20)
				AchievementGet[playerid][aPoszukiwacz] ++;
			if(AchievementGet[playerid][aPoszukiwacz] == 20)
                AchievementGet[playerid][aPoszukiwacz] ++;
				ShowAchievementGet(playerid, "~y~Nowe osiagniecie! ~n~~w~~h~Poszukiwacz!");
				PlaySoundForPlayer(playerid, 1058);
                PlayCompleteMissionSound(playerid);
                Player[playerid][Exp] += 50;
				GivePlayerMoney(playerid, 5000);
				Player[playerid][Money] += 5000;
	            if(Player[playerid][Level] < GetPlayerLevel(playerid))
					LevelUp(playerid);
				GameTextForPlayer(playerid,"~w~Exp + ~b~~h~50", 1000, 1);
                if(Player[playerid][Registered])
					new String[128];
					format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aPoszukiwacz='21' WHERE Name='%s'",Player[playerid][Name]);
					mysql_query(String);
			else
	            new String[128];
                if(Player[playerid][Registered])
					format(String, sizeof(String),"UPDATE "PREFIX"Achievements SET aPoszukiwacz='%d' WHERE Name='%s'",AchievementGet[playerid][aPoszukiwacz],Player[playerid][Name]);
					mysql_query(String);
				format(String,sizeof(String), "~y~Poszukiwacz ~n~~w~~h~Status: %d/20",AchievementGet[playerid][aPoszukiwacz]);
				ShowAchievementGet(playerid, String);
	            PlaySoundForPlayer(playerid, 1058);
////////////////////////////////////////////////////////////////////////////////
forward Armor(playerid);
public Armor(playerid)
	SetPlayerArmour(playerid, 100);
	SCM(playerid,C_GREEN,""WI" "G"Kamizelka została założona.");
	KillTimer(Player[playerid][ArmourTimer]);
	return 1;
forward Uleczenie(playerid);
public Uleczenie(playerid)
	SetPlayerHealth(playerid, 100);
    Player[playerid][Immunitet] = false;
	SCM(playerid,C_GREEN,""WI" "G"Zostałeś uzdrowiony.");
    KillTimer(Player[playerid][HealthTimer]);
	return 1;
TeleportPlayer(userid, ToPlayerId)
    if(Player[ToPlayerId][InHouse] == 1)
	    PlayerEnterHouse(userid, Player[ToPlayerId][House]);
	else
		new Float:PlayerPos[3];
		GetPlayerPos(ToPlayerId, PlayerPos[0], PlayerPos[1], PlayerPos[2]);
        Player[userid][ObokHouse] = false;
        Player[userid][NearHouse] = false;
		new ToPlayerInterior = Player[ToPlayerId][Interior];
		new PlayerInterior = Player[userid][Interior];
		if(PlayerInterior != ToPlayerInterior)
			SetPlayerInterior(userid, ToPlayerInterior);
        PlayerPlaySound(userid, 1039, 0, 0, 0);
		if(!IsPlayerInAnyVehicle(userid))
			SetPlayerPos(userid, PlayerPos[0], PlayerPos[1], PlayerPos[2]);
		else
			if(PlayerInterior != ToPlayerInterior)
				LinkVehicleToInterior(GetPlayerVehicleID(userid), ToPlayerInterior);
			SetVehiclePos(GetPlayerVehicleID(userid), PlayerPos[0], PlayerPos[1], PlayerPos[2]);
			SetVehicleVirtualWorld(GetPlayerVehicleID(userid), GetPlayerVirtualWorld(ToPlayerId));
	SetPlayerVirtualWorld(userid, GetPlayerVirtualWorld(ToPlayerId));
stock IsPlayerOnEvent(playerid)
    if(Chowany[playerid] || Szukajacy[playerid] && ChWystartowala) return 1;
	if(DerbyMen[playerid] && DerbyON) return 1;
	if(WGTeam[playerid] == 1 || WGTeam[playerid] == 2) return 1;
	if(PBTeam[playerid] == 1 || PBTeam[playerid] == 2) return 1;
    if(SNKandydat[playerid] && SNON) return 1;
	if(RaceWystartowal && WyscigUczestnik[playerid]) return 1;
	return 0;
stock IsPlayerOnArena(playerid)
	if(Player[playerid][OnOnede] || Player[playerid][OnMinigun] || Player[playerid][OnRPG] || Player[playerid][OnCombat] && GetPlayerVirtualWorld(playerid) == 10) return 1;
	return 0;
stock IsPlayerOnSolo(playerid)
    if(playerid == RywalSolo[0] || playerid == RywalSolo[1]) return 1;
	return 0;
GoTo(userid, ToPlayerId)
	if(Player[ToPlayerId][Registered] && !Player[ToPlayerId][Logged])
        SCM(userid, C_ERROR, ""WE" "R"Ten gracz nie jest zalogowany!");
		return 1;
	if(!Player[ToPlayerId][IdzdoON])
        SCM(userid, C_ERROR, ""WE" "R"Ten gracz nie przyjmuje teleportów!");
		return 1;
	if(IsPlayerOnEvent(ToPlayerId)) return SCM(userid,C_ERROR,""WE" "R"Ten gracz jest na evencie!");
    if(ToPlayerId == RywalSolo[0] || ToPlayerId == RywalSolo[1])
		SCM(userid, C_ERROR, ""WE" "R"Ten gracz odbywa solówkę!");
		return 1;
    if(Player[ToPlayerId][OnOnede] || Player[ToPlayerId][OnMinigun] || Player[ToPlayerId][OnRPG] || Player[ToPlayerId][OnCombat] && GetPlayerVirtualWorld(ToPlayerId) == 10)
  	 	SCM(userid, C_ERROR, ""WE" "R"Ten gracz jest na arenie!");
   		PlaySoundForPlayer(userid,1085);
		return 1;
	if(Player[ToPlayerId][Zajety])
        SCM(userid, C_ERROR, ""WE" "R"Ten gracz jest zajęty!");
   		PlaySoundForPlayer(userid,1085);
		return 1;
    if(Wiezien[ToPlayerId])
        SCM(userid, C_ERROR, ""WE" "R"Ten gracz jest w więzieniu!");
   		PlaySoundForPlayer(userid,1085);
		return 1;
	Player[userid][TPTo] = ToPlayerId;
	Player[userid][TPRefused] = 30;
	new String[255];
	format(String, sizeof(String), "Gracz "W"%s (%d) "GUI"chce się do ciebie teleportować\nWyrażasz na to zgodę?", Player[userid][Name], userid);
	SPD(ToPlayerId, D_TP, DIALOG_STYLE_MSGBOX, "{00BFFF}Teleport", String, "Akceptuj", "Odrzuć");
	SCM(userid, C_GREEN, ""WI" "G"Zaproszenie zostało wysłane.");
	Player[userid][ClickedPlayer] = -1;
	return 1;
stock GetRealVehicleHealth(userid)
	new Float:VehHealth;
	GetVehicleHealth(GetPlayerVehicleID(userid), VehHealth);
	if(VehHealth >= 1000.0)
	    return 100;
    return floatround(((VehHealth - 250) / 750) * 100) < 0 ? 0 : floatround(((VehHealth - 250) / 750) * 100);
stock GetVehSpeed(vehid)
   new Float:PosyzjaX, Float:PosyzjaY, Float:PosyzjaZ;
   GetVehicleVelocity(vehid, PosyzjaX, PosyzjaY, PosyzjaZ);
   return floatround(floatsqroot(floatpower(PosyzjaX, 2) + floatpower(PosyzjaY, 2) + floatpower(PosyzjaZ, 2)) * 200);
forward CountDown();
public CountDown()
	if(Count1 > 0)
		GameTextForAll(CountText[Count1-1], 2500, 3);
		Count1--;
		SoundForAll(1056);
		SetTimer("CountDown", 1000, 0);
	else
		GameTextForAll("~y~START", 2500, 3);
		Count1 = 3;
		SoundForAll(1057);
	return 1;
forward CountDownAS();
public CountDownAS()
	if(Count2 == -1)
		GameTextForAll("~r~~h~PRZERWANO ODLICZANIE",3000,3);
        SoundForAll(1085);
		CountDowning = 0;
		return 1;
	if(Count2 > 0)
		new string[10];
		format(string,10,"~w~%d",Count2);
		GameTextForAll(string, 2500, 3);
        SoundForAll(1056);
		Count2--;
		SetTimer("CountDownAS", 1000, 0);
	else
		GameTextForAll("~y~START", 2500, 3);
        SoundForAll(1057);
		Count2 = 0;
		foreach(Player,x)
			if(!Player[x][Freeze])
				TogglePlayerControllable(x,1);
		CountDowning = 0;
	return 1;
SaveStatistics()
    if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	new query[256];
	format(query, sizeof(query), "UPDATE `"PREFIX"Stats` SET RekordGraczy='%d',Wejsc='%d',Kickow='%d',Banow='%d',Zabojstw='%d',Smierci='%d'",RekordGraczy,GlobalJoins,GlobalKicks,GlobalBans,GlobalUsers,GlobalKills,GlobalDeaths);
	mysql_query(query);
LoadStatistics()
	if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	mysql_query("SELECT * FROM "PREFIX"Stats");
	mysql_store_result();
	new str[520];
    while(mysql_fetch_row(str, "|"))
		sscanf(str, "p<|>dddddd",
        RekordGraczy,
		GlobalJoins,
		GlobalKicks,
		GlobalBans,
		GlobalKills,
		GlobalDeaths);
	mysql_free_result();
    mysql_query("SELECT AID FROM "PREFIX"Users");
	mysql_store_result();
	new rows = mysql_num_rows();
	mysql_free_result();
	GlobalUsers = rows;
SaveConfigs()
    if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	new query[256];
	format(query, sizeof(query), "UPDATE "PREFIX"Config SET MaxPing='%d',AdminPass='%s',RconPass='%s',GunDay='%d'",MaxPing,AdminPass,RconPass,GunDay);
	mysql_query(query);
LoadConfigs()
	if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	mysql_query("SELECT * FROM "PREFIX"Config");
	mysql_store_result();
	new str[520];
    while(mysql_fetch_row(str, "|"))
		sscanf(str, "p<|>ds[32]s[32]d",MaxPing,AdminPass,RconPass,GunDay);
	mysql_free_result();
forward CDTextUnlock();
public CDTextUnlock()
	CDText = false;
	return 1;
CreateDynamicEntrance(id,model,Float:x,Float:y,Float:z,text[],usecp)
    CreateEntrance(id,model,x,y,z);
	if(strcmp(text, "null", false))
        CreateEntranceText(text,x,y,z);
	if(usecp > 0)
		//Kod na tworzenie check pointu
	return 1;
GivePlayerCar(playerid,carid)
    if(Player[playerid][Money] < 1000)
        SCM(playerid, C_RED, ""WE" "R"Musisz mieć 1000$ aby kupić pojazd!");
		return 1;
	if(GetPlayerInterior(playerid) != 0)
		SCM(playerid,C_ERROR,""WE" "R"Pojazdy można kupować tylko na dworze!");
		return 1;
	if(IsPlayerInAnyVehicle(playerid))
        SCM(playerid,C_ERROR,""WE" "R"Wysiądź z obecnego pojazdu!");
		return 1;
    if(IsPlayerOnEvent(playerid)) return SCM(playerid,C_ERROR,""WE" "R"Nie możesz kupić pojazdu na evencie.");
	if(carid == 520 || carid == 425 || carid == 432 && !IsPlayerAdmin(playerid))
        if(!IsPlayerInFreeZone(playerid))
			SCM(playerid,C_ERROR,""WE" "R"Ten pojazd możesz zrespawnować tylko w "R2"strefie śmierci"R"!");
			return 1;
    if(carid != 462 || carid != 448 || carid != 581 || carid != 522 || carid != 461 || carid != 521 || carid != 523 || carid != 463 || carid != 586 || carid != 468 || carid != 471)
 		Player[playerid][OnBike] = false;
		RemovePlayerAttachedObject(playerid,SLOT_KASK);
	GivePlayerMoney(playerid, -1000);
    Player[playerid][Money] += -1000;
	new Float:x, Float:y, Float:z,Float:Angle;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,Angle);
	if(!IsVehicleInUse(Player[playerid][AutoMenu]))
		DestroyVehicleEx(Player[playerid][AutoMenu]);
	Player[playerid][AutoMenu] = CreateVehicle(carid,x ,y,z + 2,Angle,-1,-1, 9999);
	PutPlayerInVehicle(playerid,Player[playerid][AutoMenu],0);
	return 1;
forward RPGTextUnlock();
public RPGTextUnlock()
	RPGText = false;
	return 1;
forward MinigunTextUnlock();
public MinigunTextUnlock()
	MinigunText = false;
	return 1;
forward OnedeTextUnlock();
public OnedeTextUnlock()
	OnedeText = false;
	return 1;
forward CombatTextUnlock();
public CombatTextUnlock()
	CombatText = false;
	return 1;
SoloEnd(loser)
	new x1 = RywalSolo[0];
	new x2 = RywalSolo[1];
	if(x1 != loser)
		SetPlayerPos(x1,-1468.4532,344.1803,30.0820);
		ResetPlayerWeapons(x1);
		Player[x1][SoloScore] ++;
	if(x2 != loser)
		SetPlayerPos(x2,-1468.4532,344.1803,30.0820);
		ResetPlayerWeapons(x2);
		Player[x2][SoloScore] ++;
	SoloON = false;
	RywalSolo[0] = -1;
	RywalSolo[1] = -1;
	foreach(Player,x)
		Player[x][SoloWyzywa] = -1;
		Player[x][SoloBron] = 0;
	return 1;
StartSolo(gracz1,gracz2,bron)
	SoloON = true;
	SetPlayerPos(gracz1,-1398.4670,369.9272,36.4953);
	SetPlayerPos(gracz2,-1358.7574,409.3822,36.4700);
	SetPlayerFacingAngle(gracz1,313.7109);
	SetPlayerFacingAngle(gracz2,135.4460);
	SetCameraBehindPlayer(gracz1);
	SetCameraBehindPlayer(gracz2);
	TogglePlayerControllable(gracz1,0);
	TogglePlayerControllable(gracz2,0);
	ResetPlayerWeapons(gracz1);
	ResetPlayerWeapons(gracz2);
	GivePlayerWeapon(gracz1, bron, 3500);
	GivePlayerWeapon(gracz2, bron, 3500);
    PlaySoundForPlayer(gracz1, 30800);
    PlaySoundForPlayer(gracz2, 30800);
	SetPlayerHealth(gracz1,100);
	SetPlayerHealth(gracz2,100);
	SetPlayerArmour(gracz1,100);
	SetPlayerArmour(gracz2,100);
	RywalSolo[0] = gracz1;
	RywalSolo[1] = gracz2;
	new string[100];
	format(string, sizeof(string), "(Solo) Walka rozpoczęta! Walczą: %s vs %s bronią %s.", Player[gracz1][Name], Player[gracz2][Name],ReturnWeaponName(bron));
	foreach(Player,x)
		if(IsPlayerInArea(x, -1486.0240,-1343.8665,335.8203,446.1019))
			SCM(x,C_YELLOW,string);
	Solocd();
	return 1;
forward Solocd();
public Solocd()
	if (SoloCD > 0)
		GameTextForPlayer(RywalSolo[0],CountText[SoloCD-1], 2500, 3);
		GameTextForPlayer(RywalSolo[1],CountText[SoloCD-1], 2500, 3);
		PlayerPlaySound(RywalSolo[0],1056,0,0,0);
		PlayerPlaySound(RywalSolo[1],1056,0,0,0);
		SoloCD--;
		SetTimer("Solocd", 1000, 0);
	else
		GameTextForPlayer(RywalSolo[0],"~y~START", 2500, 3);
		GameTextForPlayer(RywalSolo[1],"~y~START", 2500, 3);
		PlayerPlaySound(RywalSolo[0],1057,0,0,0);
		PlayerPlaySound(RywalSolo[1],1057,0,0,0);
		TogglePlayerControllable(RywalSolo[0],1);
		TogglePlayerControllable(RywalSolo[1],1);
		SoloCD = 3;
	return 1;
forward DestroyRamp(userid);
public DestroyRamp(userid)
	if(Player[userid][StworzylRampy] == true)
		Player[userid][StworzylRampy] = false;
		return DestroyPlayerObject(userid, Player[userid][Ramp]);
	else
		return 0;
forward ShowAndHide(playerid, Text:TD, AlphaC, AlphaB, time);
public ShowAndHide(playerid, Text:TD, AlphaC, AlphaB, time)
	KillTimer(CurrTimer[playerid]);
	if (time > 0) {
		if (AlphaC < (0xFFFFFFFF&0xFF)) AlphaC += (0xFFFFFFFF&0xFF)/0x12;
		if (AlphaC > (0xFFFFFFFF&0xFF)) AlphaC = (0xFFFFFFFF&0xFF);
		if (AlphaB < (0x00000040&0xFF)) AlphaB += (0x00000040&0xFF)/0x12;
		if (AlphaB > (0x00000040&0xFF)) AlphaB = (0x00000040&0xFF);
		TextDrawColor(TD, ((0xFFFFFFFF>>>8)<<8)|AlphaC);
		TextDrawBackgroundColor(TD, ((0x00000040>>>8)<<8)|AlphaB);
		TextDrawShowForPlayer(playerid, TD);
		if(AlphaC == (0xFFFFFFFF&0xFF) && AlphaB == (0x00000040&0xFF))
			CurrTimer[playerid] = SetTimerEx("ShowAndHide", time, false, "ddddd",playerid,_:TD, AlphaC, AlphaB, 0);
		else
		    CurrTimer[playerid] = SetTimerEx("ShowAndHide", 50, false, "ddddd",playerid,_:TD,  AlphaC, AlphaB, time);
	else
		if (AlphaC > 0) AlphaC -= (0xFFFFFFFF&0xFF)/0x12;
		if (AlphaC < 0) AlphaC = 0;
		if (AlphaB > 0) AlphaB -= (0x00000040&0xFF)/0x12;
		if (AlphaB < 0) AlphaB = 0;
		TextDrawColor(TD,((0xFFFFFFFF>>>8)<<8)|AlphaC);
		TextDrawBackgroundColor(TD, ((0x00000040>>>8)<<8)|AlphaB);
  		TextDrawShowForPlayer(playerid, TD);
  		if (AlphaC == 0 && AlphaB == 0)
			TextDrawHideForPlayer(playerid, TD);
		else
		    CurrTimer[playerid] = SetTimerEx("ShowAndHide", 50, false, "ddddd",playerid, _:TD, AlphaC, AlphaB, 0);
forward ShowAndHide2(playerid, Text:TD, AlphaC, AlphaB, time);
public ShowAndHide2(playerid, Text:TD, AlphaC, AlphaB, time)
	KillTimer(CurrTimer2[playerid]);
	if(time > 0)
		if (AlphaC < (0xFFFFFFFF&0xFF)) AlphaC += (0xFFFFFFFF&0xFF)/0x12;
		if (AlphaC > (0xFFFFFFFF&0xFF)) AlphaC = (0xFFFFFFFF&0xFF);
		if (AlphaB < (0x00000040&0xFF)) AlphaB += (0x00000040&0xFF)/0x12;
		if (AlphaB > (0x00000040&0xFF)) AlphaB = (0x00000040&0xFF);
		TextDrawColor(TD, ((0xFFFFFFFF>>>8)<<8)|AlphaC);
		TextDrawBackgroundColor(TD, ((0x00000040>>>8)<<8)|AlphaB);
		TextDrawBoxColor(TD, ((0x00000040>>>8)<<8)|AlphaB);
		TextDrawShowForPlayer(playerid,TD);
		if(AlphaC == (0xFFFFFFFF&0xFF) && AlphaB == (0x00000040&0xFF))
			CurrTimer2[playerid] = SetTimerEx("ShowAndHide2", time, false, "ddddd",playerid,_:TD, AlphaC, AlphaB, 0);
		else
		    CurrTimer2[playerid] = SetTimerEx("ShowAndHide2", 50, false, "ddddd",playerid,_:TD,  AlphaC, AlphaB, time);
	else
		if (AlphaC > 0) AlphaC -= (0xFFFFFFFF&0xFF)/0x12;
		if (AlphaC < 0) AlphaC = 0;
		if (AlphaB > 0) AlphaB -= (0x00000040&0xFF)/0x12;
		if (AlphaB < 0) AlphaB = 0;
		TextDrawColor(TD,((0xFFFFFFFF>>>8)<<8)|AlphaC);
		TextDrawBackgroundColor(TD, ((0x00000040>>>8)<<8)|AlphaB);
		TextDrawBoxColor(TD,((0x00000040>>>8)<<8)|AlphaB);
  		TextDrawShowForPlayer(playerid, TD);
  		if(AlphaC == 0 && AlphaB == 0)
			TextDrawHideForPlayer(playerid, TD);
		else
		    CurrTimer2[playerid] = SetTimerEx("ShowAndHide2", 50, false, "ddddd",playerid, _:TD, AlphaC, AlphaB, 0);
CarTeleport(playerid,interior,Float:x,Float:y,Float:z,text[],sound)
    if(IsPlayerNearAnyone(playerid, 15.0))
		SPD(playerid, D_NONE, DIALOG_STYLE_MSGBOX, "{00BFFF}Teleport", "Niestety nie możesz tego zrobić!\nPrawdobodobnie próbujesz uciec z walki.\n\nAby temu zaradzić odjedź na pewną odlgegłość\nod graczy obok ciebie.", "Zamknij", "");
	    return 0;
    if(strcmp(text, "null", false))
	   	new String[55];
		switch(random(4))
			case 0: format(String,sizeof(String),"~r~~h~%s",text);
            case 1: format(String,sizeof(String),"~b~~h~%s",text);
            case 2: format(String,sizeof(String),"~g~~h~%s",text);
            case 3: format(String,sizeof(String),"~y~%s",text);
	    GameTextForPlayer(playerid,String, 1000, 1);
	if(sound > 0)
        PlayerPlaySound(playerid, 1039, 0, 0, 0);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		new VehicleID = GetPlayerVehicleID(playerid);
		SetVehiclePos(VehicleID, x,y,z);
		SetPlayerInterior(playerid,interior);
		LinkVehicleToInterior(VehicleID,interior);
		SetVehicleVirtualWorld(VehicleID,0);
	else
		SetPlayerPos(playerid, x,y,z);
		SetPlayerVirtualWorld(playerid,0);
		SetPlayerInterior(playerid,interior);
	TogglePlayerControllable(playerid,0);
	SetTimerEx("JailUnfreeze",2000,0,"i",playerid);
	return 1;
PlayerTeleport(playerid,interior,Float:x,Float:y,Float:z,text[],sound)
	if(IsPlayerNearAnyone(playerid, 15.0))
		SPD(playerid, D_NONE, DIALOG_STYLE_MSGBOX, "{00BFFF}Teleport", "Niestety nie możesz tego zrobić!\nPrawdobodobnie próbujesz uciec z walki.\n\nAby temu zaradzić odjedź na pewną odlgegłość\nod graczy obok ciebie.", "Zamknij", "");
	    return 0;
	if(strcmp(text, "null", false))
		new String[55];
		switch(random(4))
			case 0: format(String,sizeof(String),"~r~~h~%s",text);
            case 1: format(String,sizeof(String),"~b~~h~%s",text);
            case 2: format(String,sizeof(String),"~g~~h~%s",text);
            case 3: format(String,sizeof(String),"~y~%s",text);
	    GameTextForPlayer(playerid,String, 1000, 1);
	if(sound > 0)
        PlayerPlaySound(playerid, 1039, 0, 0, 0);
	SetPlayerPos(playerid, x,y,z);
	SetPlayerInterior(playerid,interior);
	SetPlayerVirtualWorld(playerid,0);
	TogglePlayerControllable(playerid,0);
	SetTimerEx("JailUnfreeze",2500,0,"i",playerid);
	return 1;
SetPlayerRandomSpawn(playerid)
	ResetPlayerWeapons(playerid);
    GivePlayerEquipment(playerid);
	if(Player[playerid][CheckHouseSpawn] >= 1)
        PlayerEnterHouse(playerid, Player[playerid][HouseOwn]);
	else
		new rand = Player[playerid][KolejkaSpawn];
        Player[playerid][KolejkaSpawn] ++;
		if(Player[playerid][KolejkaSpawn] >= sizeof(gRandomPlayerSpawns))
		    Player[playerid][KolejkaSpawn] = 0;
		PlayerLegalTeleport(playerid,0,gRandomPlayerSpawns[rand][0], gRandomPlayerSpawns[rand][1], gRandomPlayerSpawns[rand][2]);
		SetPlayerFacingAngle(playerid,gRandomPlayerSpawns[rand][3]);
		SetCameraBehindPlayer(playerid);
		SetPlayerVirtualWorld(playerid,0);
		Player[playerid][FPSMode] = false;
		SetPlayerTeam(playerid,playerid+10);
        if(!Player[playerid][Zajety])
			SPD(playerid,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Spawn",gRandomPlayerSpawnsName[rand],"Zamknij","");
	return 1;
forward Spam();
public Spam()
	foreach(Player,i)
		if(Player[i][SpamStrings] > 0)
			Player[i][SpamStrings] --;
		if(Player[i][SpamStrings] > 2)
			Player[i][SpamStrings] = 2;
        if(Player[i][CMDSpam] > 0)
			Player[i][CMDSpam] --;
		if(Player[i][CMDSpam] > 3)
			Player[i][CMDSpam] = 3;
	return 1;
stock SellPlayerWeapon(playerid,gun,ammo,cost)
	if(Player[playerid][Money] < cost && !Player[playerid][Vip] && !Player[playerid][Mod] && !Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Masz za mało pieniędzy aby kupić tę broń.");
	if(IsPlayerOnEvent(playerid)) return SCM(playerid,C_ERROR,""WE" "R"Nie możesz kupić broni na evencie.");
    if(Wiezien[playerid]) return SCM(playerid,C_ERROR,""WE" "R"Nie możesz kupić broni w więzieniu.");
	GivePlayerWeapon(playerid,gun,ammo);
    PlaySoundForPlayer(playerid, 30800);
	if(gun == 39) GivePlayerWeapon(playerid,40,1);
	GivePlayerMoney(playerid,0-cost);
    Player[playerid][Money] += 0-cost;
	SCM(playerid, C_GREEN, ""WI" "G"Broń zakupiona!");
	if(gun == 38 || gun == 36 || gun == 37 || gun == 35 || gun == 39 || gun == 40 || gun == 16)
        SPD(playerid, D_BRONIES, DIALOG_STYLE_LIST, "{00BFFF}Bronie Specjalne "W"(Na teren wojska)", "Minigun   $1 000 000\n"GUI2"RPG   $500 000\n"W"RPG Auto   $750 000\n"GUI2"Miotacz ognia   $400 000\n"W"Ladunki wybuchowe   $200 000\n"GUI2"Granaty   $150 000", "Zakup", "Anuluj");
	else
		SPD(playerid, D_WEAPON, DIALOG_STYLE_LIST,
		"Kupno broni", "› Kastet - 1000$\n› Kij Golfowy - 1500$\n› Pałka Policyjna - 2500$\n› Nóż - 2000$\n› Pałka Golfowa - 3000$\n› Łopata - 3000$\n› Katana - 5000$\n› Piła Łańcuchowa - 6000$\n› Kwiaty - 500$\n› Pistolet (9-MM) - 4000$\n› Shotgun - 5000$\n› Combat Shotgun - 5500$\n› Sawn Off Shotgun - 7000$\n› Uzi - 5000$\n› TEC9 - 5000$\n› Wiatrówka - 3500$\n› Sniper-Rifle - 10000$\n› Spray - 3000$\n› Aparat - 500$\n› M4 - 12000$\n› AK-47 - 8000$\n› MP5 - 5500$\n› Desert Eagle - 4000$",
		"Wybierz", "Anuluj");
	return 1;
IsPlayerInArea(playerid, Float:minx, Float:maxx, Float:miny, Float:maxy)
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if (x > minx && x < maxx && y > miny && y < maxy) return 1;
	return 0;
forward DetonUnlock(playerid);
public DetonUnlock(playerid)
	Player[playerid][MozeDetonowac] = true;
	return 1;
forward Detonacja(playerid);
public Detonacja(playerid)
	Player[playerid][Bomber] = false;
	CreateExplosion(Player[playerid][BombX], Player[playerid][BombY], Player[playerid][BombZ], 6, 100.0);
	DestroyPickup(Player[playerid][Bombus]);
	return 1;
forward SiemaUnlock(playerid);
public SiemaUnlock(playerid)
	Player[playerid][SiemaBlock] = false;
	return 1;
forward PlayerLegalTeleport(playerid,interior,Float:x,Float:y,Float:z);
public PlayerLegalTeleport(playerid,interior,Float:x,Float:y,Float:z)
	SetPlayerPos(playerid, x,y,z);
	SetPlayerInterior(playerid,interior);
	SetPlayerVirtualWorld(playerid,0);
	TogglePlayerControllable(playerid,0);
	SetTimerEx("JailUnfreeze",2500,0,"i",playerid);
	return 1;
forward JailUnfreeze(playerid);
public JailUnfreeze(playerid)
	TogglePlayerControllable(playerid,1);
	return 1;
forward NotDrunk(playerid);
public NotDrunk(playerid)
	SetPlayerDrunkLevel(playerid,0);
	KillTimer(DrunkTimer[playerid]);
	return 1;
GetDistanceBetweenPlayers(playerid,playerid2)
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	new Float:dis;
	if(!IsPlayerConnected(playerid) || !IsPlayerConnected(playerid2))
		return 0;
	GetPlayerPos(playerid,x1,y1,z1);
	GetPlayerPos(playerid2,x2,y2,z2);
	dis = floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
	return floatround(dis);
CheckAdmin(playerid)
	new String[200];
	if(Player[playerid][AdminLevel] == 0)
	    format(String, sizeof(String), ""W"*(K) "R2"%s "R"został wyrzucony z serwera za próbę logowania na admina.",Player[playerid][Name]);
		SCMA(C_ERROR, String);
		Kick(playerid);
	if(Player[playerid][AdminLevel] == 1 && Player[playerid][WaznoscAdmin] > 0 && Player[playerid][SuspensionAdmin] <= 0)
        if(IsPlayerAdmin(playerid))
		    SCM(playerid, C_WHITE,""E" "W"Jesteś już zalogowany na administratora [RCON].");
			return 1;
		Player[playerid][Admin1] = true;
		format(String, sizeof(String), ""WI" {970000}%s {D50101}zalogował się jako administrator poziom: {970000}1",Player[playerid][Name]);
		SCMA(0x970000FF, String);
        SoundForAll(1133);
		OnlineAdmins ++;
	if(Player[playerid][AdminLevel] >= 2 && Player[playerid][WaznoscAdmin] > 0 && Player[playerid][SuspensionAdmin] <= 0)
		if(IsPlayerAdmin(playerid))
		    SCM(playerid, C_WHITE,""E" "W"Jesteś już zalogowany na administratora [RCON].");
			return 1;
		Player[playerid][Admin2] = true;
		Player[playerid][Admin1] = true;
        format(String, sizeof(String), ""WI" {970000}%s {D50101}zalogował się jako administrator poziom: {970000}2",Player[playerid][Name]);
		SCMA(0x970000FF, String);
		SoundForAll(1133);
        OnlineAdmins ++;
	return 1;
CheckRconAdmin(playerid)
    if(Player[playerid][AdminLevel] == 3 && Player[playerid][WaznoscAdmin] > 0 && Player[playerid][SuspensionAdmin] <= 0)
		new String[200];
	 	Player[playerid][Admin2] = true;
		Player[playerid][Admin1] = true;
		format(String, sizeof(String), " *** {970000}%s {D50101}zalogował się jako administrator poziom: {970000}3",Player[playerid][Name]);
		SCMA(0x970000FF, String);
	 	SoundForAll(1133);
        Player[playerid][Zajety] = false;
		OnlineAdmins ++;
	else
		new tmp[128];
		format(tmp, sizeof(tmp), ""W" *(K) "R2"%s "R"został wyrzucony za próbę logowania na RCON.", Player[playerid][Name]);
		SCMA(C_ERROR, tmp);
		Kick(playerid);
	return 1;
CheckRconFirstAdmin(playerid)
    if(Player[playerid][AdminLevel] == 3 && Player[playerid][WaznoscAdmin] > 0 && Player[playerid][SuspensionAdmin] <= 0)
	 	Player[playerid][Admin2] = true;
		Player[playerid][Admin1] = true;
        Player[playerid][Zajety] = true;
		OnlineAdmins ++;
	else
		new tmp[128];
		format(tmp, sizeof(tmp), ""W"*(K) "R2"%s "R"został wyrzucony za próbę logowania na RCON.", Player[playerid][Name]);
		SCMA(C_ERROR, tmp);
		Kick(playerid);
	return 1;
GMBan(playerid,admin[],powod[],playerip[])
    if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	new czas[17],data[17];
	new Date[3], Timer[3];
	getdate(Date[0],Date[1],Date[2]);
	gettime(Timer[0],Timer[1],Timer[2]);
	format(data, sizeof(data), "%04d/%02d/%02d", Date[0], Date[1], Date[2]);
	format(czas, sizeof(czas), "%02d:%02d:%02d", Timer[0], Timer[1], Timer[2]);
	new query2[256];
	format(query2, sizeof(query2), "INSERT INTO "PREFIX"Bans VALUES('%s', '%s', '%s', '%s', '%s', '%s')",Player[playerid][Name], playerip, admin, data, czas, powod);
	mysql_query(query2);
	new String[450];
	format(String,sizeof(String), "Twój nick: %s", Player[playerid][Name]);
	SCM(playerid, C_WHITE, String);
	format(String,sizeof(String), "Twoje IP: %s", playerip);
	SCM(playerid, C_WHITE, String);
	format(String,sizeof(String), "Nick admina: %s", admin);
	SCM(playerid, C_WHITE, String);
	format(String,sizeof(String), "Data: %s", data);
	SCM(playerid, C_WHITE, String);
	format(String,sizeof(String), "Godzina: %s", czas);
	SCM(playerid, C_WHITE, String);
	format(String,sizeof(String), "Powód: %s", powod);
	SCM(playerid, C_WHITE, String);
	SCM(playerid, C_WHITE, ""WI" "G" Jeżeli masz zamiar prosić o odbanowanie to złóż wniosek na "WWW"");
	Player[playerid][Bans] ++;
    Player[playerid][Warns] = 0;
	GlobalBans ++;
	SavePlayer(playerid);
	Kick(playerid);
	return 1;
forward UnmutePlayer(playerid);
public UnmutePlayer(playerid)
	Player[playerid][Mute] = 0;
	KillTimer(Player[playerid][MuteTimer]);
	SCM(playerid,C_GREEN,""WI" "G"Możesz już pisać na czacie! Kara się skończyła!");
	return 1;
forward TimerSekunda();
public TimerSekunda()
	new String[90];
	foreach(Player,x)
        if(Player[x][PlaySound] > 0)
            Player[x][PlaySound] --;
            if(Player[x][PlaySound] == 0)
				StopAudioStreamForPlayer(x);
		if(Player[x][FKWarnings] > 0)
		    Player[x][FKWarnings] --;
        if(Player[x][TuneWarnings] > 0)
		    Player[x][TuneWarnings] --;
        if(Player[x][Naprawil] > 0)
		    Player[x][Naprawil] --;
		if(Player[x][HouseAction] > 0)
            Player[x][HouseAction] --;
        if(Player[x][SiedzibaAction] > 0)
            Player[x][SiedzibaAction] --;
        if(Player[x][InfoTime] > 0)
			Player[x][InfoTime] --;
			if(Player[x][InfoTime] == 0)
                for(new i=0;i<13;i++)
					TextDrawHideForPlayer(x,InfoBox[i]);
				TextDrawHideForPlayer(x,InfoText[x]);
        if(Player[x][KupilZycie] > 0)
		    Player[x][KupilZycie] --;
        if(Player[x][KupilArmour] > 0)
		    Player[x][KupilArmour] --;
        if(Player[x][BiznesAction] > 0)
            Player[x][BiznesAction] --;
		if(GetPlayerWeapon(x) == 44 || GetPlayerWeapon(x) == 45)
			ResetPlayerWeapons(x);
		if(Player[x][AntySpawnKill] > 0)
			Player[x][AntySpawnKill] --;
			if(Player[x][AntySpawnKill] <= 0)
			    SetPlayerHealth(x,100.0);
		if(Player[x][LevelUpTime] > 0)
  			Player[x][LevelUpTime]--;
			if(Player[x][LevelUpTime] < 1)
   				TextDrawHideForPlayer(x, tdLevelUp);
				StopAudioStreamForPlayer(x);
		if(Player[x][TPRefused] > 0)
	        Player[x][TPRefused] --;
		if(Player[x][KillTime] > 0)
            Player[x][KillTime] --;
			if(Player[x][KillTime] == 0)
                TogglePlayerSpectating(x, 0);
				SpawnPlayer(x);
		if(Player[x][DamageText] > 0)
	        Player[x][DamageText] --;
	        if(Player[x][DamageText] == 0)
	            Update3DTextLabelText(lDmg[x],0x00ff00FF," ");
                Player[x][TotalArm] = 0;
                Player[x][TotalDamage] = 0;
		if(Player[x][PBGod] > 0)
			Player[x][PBGod] --;
			if(Player[x][PBGod] <= 0)
				SetPlayerHealth(x, 10);
		if(Player[x][Zapukal] > 0)
            Player[x][Zapukal] --;
        new Float: hp, Float:arm;
		GetPlayerHealth(x,hp);
		GetPlayerArmour(x,arm);
		if(Player[x][AntySpawnKill] <= 0)
         	format(String,sizeof(String),"~r~~h~%.0f%",hp);
			TextDrawSetString(HealthTD[x],String);
		else
			TextDrawSetString(HealthTD[x],"~r~~h~N/A");
		format(String,sizeof(String),"%.0f%",arm);
		TextDrawSetString(ArmourTD[x],String);
		if(arm > 0.0)
		    TextDrawShowForPlayer(x,ArmourTD[x]);
		else
		    TextDrawHideForPlayer(x,ArmourTD[x]);
        UpdateVehiclePrzebieg(x);
        new bool:IsInFreeZone;
		if(GetPlayerInterior(x) == 0)
			if(!IsPlayerInFreeZone(x))
				TextDrawHideForPlayer(x,FreeZone);
			else
				TextDrawShowForPlayer(x,FreeZone);
				IsInFreeZone = true;
            if(!IsPlayerInBezDmZone(x))
				TextDrawHideForPlayer(x,BezDmZone);
			else
				TextDrawShowForPlayer(x,BezDmZone);
		new gun = GetPlayerWeapon(x);
        if(gun == 38 || gun == 36 || gun == 37 || gun == 35 || gun == 39 || gun == 40 || gun == 16)
            if(!Player[x][Admin1] && !Player[x][Mod] && !Szukajacy[x] && !IsInFreeZone && !Player[x][FirstSpawn])
				if(Player[x][GunWarning] == 5)
	   				SCM(x,C_ERROR,""WE" "R"Zostałeś(aś) wyrzucony(a) za próbę zdobycia nielegalnej broni.");
					return 1;
				RemovePlayerWeapon(x, 35);
	   			RemovePlayerWeapon(x, 36);
	      		RemovePlayerWeapon(x, 37);
				RemovePlayerWeapon(x, 38);
				SCM(x,C_ERROR,""WE" "R"Tej broni możesz użyć tylko w Strefie Śmierci.");
				Player[x][GunWarning] ++;
    new Czas[3];
	gettime(Czas[0],Czas[1],Czas[2]);
	format(String,sizeof(String), "%02d:%02d:%02d",Czas[0],Czas[1],Czas[2]);
	TextDrawSetString(CzasTD, String);
    if(PBTime >= 0 && PBON)
		PBTime --;
		if(PBTime <= 1)
            PBEndCheck();
    if(PBON)
		new pbstring[80];
		format(pbstring, sizeof(pbstring), "~r~~h~PaintBall ~w~- 0%d:%02d~n~~y~Zolci: ~w~%d ~r~Czerwoni: ~w~%d",PBTime/60, PBTime%60,PBPoints1,PBPoints2);
	 	TextDrawSetString(PBTD, pbstring);
	return 1;
UpdateVehiclePrzebieg(playerid)
	new VehicleId = Player[playerid][pVeh],RealVehicleId = GetPlayerVehicleID(playerid);
	if(RealVehicleId == vInfo[VehicleId][vID])
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && !Player[playerid][AFK])
			if(GetVehSpeed(RealVehicleId) >= 160) return vInfo[VehicleId][vPrzebieg] += 160/5;
			if(GetVehSpeed(RealVehicleId) >= 155) return vInfo[VehicleId][vPrzebieg] += 155/5;
			if(GetVehSpeed(RealVehicleId) >= 150) return vInfo[VehicleId][vPrzebieg] += 150/5;
			if(GetVehSpeed(RealVehicleId) >= 145) return vInfo[VehicleId][vPrzebieg] += 145/5;
			if(GetVehSpeed(RealVehicleId) >= 140) return vInfo[VehicleId][vPrzebieg] += 140/5;
			if(GetVehSpeed(RealVehicleId) >= 135) return vInfo[VehicleId][vPrzebieg] += 135/5;
			if(GetVehSpeed(RealVehicleId) >= 130) return vInfo[VehicleId][vPrzebieg] += 130/5;
			if(GetVehSpeed(RealVehicleId) >= 125) return vInfo[VehicleId][vPrzebieg] += 125/5;
			if(GetVehSpeed(RealVehicleId) >= 120) return vInfo[VehicleId][vPrzebieg] += 120/5;
			if(GetVehSpeed(RealVehicleId) >= 115) return vInfo[VehicleId][vPrzebieg] += 115/5;
			if(GetVehSpeed(RealVehicleId) >= 110) return vInfo[VehicleId][vPrzebieg] += 110/5;
			if(GetVehSpeed(RealVehicleId) >= 105) return vInfo[VehicleId][vPrzebieg] += 105/5;
			if(GetVehSpeed(RealVehicleId) >= 100) return vInfo[VehicleId][vPrzebieg] += 100/5;
			if(GetVehSpeed(RealVehicleId) >= 95) return vInfo[VehicleId][vPrzebieg] += 95/5;
			if(GetVehSpeed(RealVehicleId) >= 90) return vInfo[VehicleId][vPrzebieg] += 90/5;
			if(GetVehSpeed(RealVehicleId) >= 85) return vInfo[VehicleId][vPrzebieg] += 85/5;
			if(GetVehSpeed(RealVehicleId) >= 80) return vInfo[VehicleId][vPrzebieg] += 80/5;
			if(GetVehSpeed(RealVehicleId) >= 75) return vInfo[VehicleId][vPrzebieg] += 75/5;
			if(GetVehSpeed(RealVehicleId) >= 70) return vInfo[VehicleId][vPrzebieg] += 70/5;
			if(GetVehSpeed(RealVehicleId) >= 65) return vInfo[VehicleId][vPrzebieg] += 65/5;
			if(GetVehSpeed(RealVehicleId) >= 60) return vInfo[VehicleId][vPrzebieg] += 60/5;
			if(GetVehSpeed(RealVehicleId) >= 55) return vInfo[VehicleId][vPrzebieg] += 55/5;
			if(GetVehSpeed(RealVehicleId) >= 50) return vInfo[VehicleId][vPrzebieg] += 50/5;
			if(GetVehSpeed(RealVehicleId) >= 45) return vInfo[VehicleId][vPrzebieg] += 45/5;
			if(GetVehSpeed(RealVehicleId) >= 40) return vInfo[VehicleId][vPrzebieg] += 40/5;
			if(GetVehSpeed(RealVehicleId) >= 35) return vInfo[VehicleId][vPrzebieg] += 35/5;
			if(GetVehSpeed(RealVehicleId) >= 30) return vInfo[VehicleId][vPrzebieg] += 30/5;
			if(GetVehSpeed(RealVehicleId) >= 25) return vInfo[VehicleId][vPrzebieg] += 25/5;
			if(GetVehSpeed(RealVehicleId) >= 20) return vInfo[VehicleId][vPrzebieg] += 20/5;
			if(GetVehSpeed(RealVehicleId) >= 15) return vInfo[VehicleId][vPrzebieg] += 15/5;
			if(GetVehSpeed(RealVehicleId) >= 10) return vInfo[VehicleId][vPrzebieg] += 10/5;
			if(GetVehSpeed(RealVehicleId) >= 5) return vInfo[VehicleId][vPrzebieg] += 5-4;
	return 1;
forward PlayerUpdate();
public PlayerUpdate()
	new String[165],Float:MX,Float:MY,Float:MZ;
	format(String,sizeof(String), "%d(~y~%d~w~~h~/~g~%d~w~~h~/~r~%d~w~~h~)",OnlinePlayers,OnlineVips,OnlineMods,OnlineAdmins);
    TextDrawSetString(GraczeTD, String);
    OnlinePlayers = 0,OnlineAdmins = 0,OnlineMods = 0,OnlineVips = 0,MinigunUsers = 0,RPGUsers = 0,OnedeUsers = 0,CombatUsers = 0;
    WGEndCheck();
    WGPlayerCheck();
    PBEndCheck();
    PBPlayerCheck();
    ChowanyCheck();
    ChowanyAreaCheck();
    DerbyCheck();
    SNPlayerCheck();
    new Float:BalonX,Float:BalonY,Float:BalonZ;
    GetObjectPos(BalonLV,BalonX,BalonY,BalonZ);
	if(BalonZ >= 130.0) //Jeżeli balon jest wysoko
		if(BalonX == 2177.63) //Jeżeli balon jest w LV
			MoveObject(BalonLV, 197.66, 1879.46, 16.61, 15.0);
		else if(BalonX == 197.66) //Jeżeli balon jest w wojsku
            MoveObject(BalonLV, 2177.63,944.26,14.66, 15.0);
	foreach(Player,x)
        if(WyscigUczestnik[x])
			format(String,sizeof(String),"~r~~h~Wyscig~n~~w~Pozycja: ~y~%d/%d ~w~CheckPoint: ~y~%d/%d",ActualPos[x],WSMans,WyscigStatus[x],CPliczba);
			TextDrawSetString(RaceStats[x], String);
		if(GetPlayerInterior(x) != hInfo[Player[x][House]][hInterior] && Player[x][InHouse])
			PlayerLeaveHouse(x, Player[x][House]);
		GetPlayerPos(x,MX,MY,MZ);
		if(floatround(MZ) <= 10 && GetPlayerState(x) == PLAYER_STATE_DRIVER && !Player[x][AFK] && GetVehSpeed(GetPlayerVehicleID(x)) >= 800)
            GMBan(x, "SERWER", "Speed Hack", Player[x][IP]);
        format(String,sizeof(String), "%d/%d",Player[x][Exp],GetPlayerNextExp(x));
		TextDrawSetString(ExpTD[x], String);
        format(String,sizeof(String), "%d",Player[x][Level]);
		TextDrawSetString(LevelTD[x], String);
        format(String,sizeof(String), "%dh %dmin",Player[x][Godz],Player[x][Min]);
		TextDrawSetString(OnlineTD[x], String);
        new Float:Ratio = floatdiv(Player[x][Kills], Player[x][Deaths]);
	    if(Player[x][Kills] == 0 && Player[x][Deaths] == 0)
			Ratio = 0.00;
	    if(Player[x][Kills] > Player[x][Deaths] && Player[x][Deaths] == 0)
			Ratio = Player[x][Kills];
        format(String,sizeof(String), "%.2f",Ratio);
		TextDrawSetString(RatioTD[x], String);
        format(String,sizeof(String), "%d zl",Player[x][Portfel]);
		TextDrawSetString(PortfelTD[x], String);
        ResetPlayerMoney(x);
		GivePlayerMoney(x,Player[x][Money]);
        OnlinePlayers ++;
	    if(Player[x][Admin1] || IsPlayerAdmin(x))
	    	OnlineAdmins ++;
		if(Player[x][Mod])
			OnlineMods ++;
		if(Player[x][Vip])
			OnlineVips ++;
		if(Player[x][OnRPG])
			RPGUsers ++;
	    if(Player[x][OnOnede])
			OnedeUsers ++;
	    if(Player[x][OnCombat])
			CombatUsers ++;
		if(Player[x][OnMinigun])
			MinigunUsers ++;
        UpdatePlayerCheckPoint(x,355.4244,1800.5325,18.4137,-102.0093,488.8185, 1661.8014, 2204.8889); //Wojsko
        UpdatePlayerCheckPoint(x,355.4244,1800.5325,18.4137,392.2149,782.6511,716.4636,1049.3254); //Wojsko x2
        UpdatePlayerCheckPoint(x,-23.7956,-54.8599,1003.5469,-36.6350,-17.2657,-57.9944,-49.0046); //Bank
        UpdatePlayerCheckPoint(x,23.7660,1864.5850,19.9094,-56.4757,97.0263,1791.5306,1930.1420); //Nabór do wojska na afganistanie
		if(Player[x][pVeh] > 0)
			format(String,sizeof(String),"Właściciel: {9eae41}%s\n{c3c3c3}Przebieg: {9eae41}%.1f km.",vInfo[Player[x][pVeh]][vOwner],vInfo[Player[x][pVeh]][vPrzebieg]/1000.0);
            Update3DTextLabelText(vInfo[Player[x][pVeh]][vLabel], 0xc3c3c3FF, String);
        if(Wiezien[x])
			if(!IsPlayerInArea(x, -2337.5520,-2005.9673,1664.4182,1960.4541)) //Coordy arey playera w więzieniu
				new rand = random(sizeof(CelaSpawn));
				SetPlayerPos(x, CelaSpawn[rand][0], CelaSpawn[rand][1], CelaSpawn[rand][2]);
				SetPlayerInterior(x,0);
				SCM(x,C_RED,""WI" "R"Odczekaj karę w więzieniu!");
				TogglePlayerControllable(x,0);
				SetTimerEx("JailUnfreeze",2000,0,"i",x);
				ResetPlayerWeapons(x);
        if(!Player[x][AFKChecker] && !Player[x][AFK])
			Player[x][AFK] = true;
  			Update3DTextLabelText(lExp[x], 0xFF0000FF, "(AFK)");
     		Player[x][Update] = false;
		else if(Player[x][AFKChecker] && Player[x][AFK])
			Player[x][AFK] = false;
			Player[x][Update] = true;
        Player[x][AFKChecker] = false;
		if(Player[x][OnOnede] || Player[x][OnRPG] || Player[x][OnMinigun] || Player[x][OnCombat] && Player[x][Update])
            Update3DTextLabelText(lExp[x], 0xFFFFFF00, " ");
          
        if(Player[x][Update] && !Chowany[x] && !Player[x][OnOnede] && !Player[x][OnRPG] && !Player[x][OnCombat] && !Player[x][OnMinigun])
		  	UpdatePlayerScore(x);
		if(GetPlayerPing(x) > MaxPing && !Player[x][FirstSpawn])
			Pinger[x]++;
			if(Pinger[x] == 1)
				format(String,sizeof(String),""WI" "R"Uwaga! Twój ping ("W"%d"R"/%d) jest zbyt wysoki aby grać na serwerze! Zmniejsz ping!",GetPlayerPing(x),MaxPing);
				SCM(x,C_RED,String);
                PlaySoundForPlayer(x,1085);
			if(Pinger[x] > 1)
                format(String,sizeof(String),""W"*(K) "R2"%s "R"został(a) wyrzucony z serwera z podowu zbyt dużego pingu! ("W"%d"R"/%d)",Player[x][Name],GetPlayerPing(x),MaxPing);
				SCMA(C_ERROR,String);
                PlaySoundForPlayer(x,1085);
				Kick(x);
		else
			Pinger[x] = 0;
	return 1;
forward TimerMinuta();
public TimerMinuta()
    new Timer[2];
	gettime(Timer[0],Timer[1]);
	foreach(Player,x)
		Player[x][TimePlay] ++;
		if(Player[x][GunWarning] > 0)
			Player[x][GunWarning] = 0;
		if(Player[x][Registered])
	        if(vInfo[Player[x][pVeh]][vPrzebieg] >= 50000 && GetPlayerState(x) == PLAYER_STATE_DRIVER && GetPlayerVehicleID(x) == Player[x][pVeh])
				Achievement(x, "aPodroznik");
		Player[x][Min] ++;
		if(Player[x][Min] >= 60)
			Player[x][Min] = 0;
			Player[x][Godz] ++;
        new Model = GetVehicleModel(GetPlayerVehicleID(x));
		if(Model == 592 || Model == 577 || Model == 511 || Model == 512 || Model == 593 || Model == 520 || Model == 553 || Model == 476 || Model == 519 || Model == 460 || Model == 513 || Model == 548 || Model == 425 || Model == 417 || Model == 487 || Model == 488 || Model == 497 || Model == 488 || Model == 497 || Model == 563 || Model == 447 || Model == 469)
			Achievement(x, "aPilot");
        if(Timer[0] >= 3 && Timer[0] <= 5)
	        Achievement(x, "aZzzz");
        if(Player[x][TimePlay]/60 == 24)
			Achievement(x, "a24Godziny");
		if(Player[x][BiznesTime] > 0)
            Player[x][BiznesTime] --;
        if(Player[x][ZmienialTime] > 0)
            Player[x][ZmienialTime] --;
		if(Player[x][PrzelalExp] > 0)
		    Player[x][PrzelalExp] --;
		if(Player[x][VTPUsed] > 0)
		    Player[x][VTPUsed] --;
        if(Player[x][Godz] > Player[x][RespektPremia])
			Player[x][RespektPremia] ++;
			WinSound(x);
			if(!GSTag[x])
				SCM(x,C_GREEN,""WI" "G"Otrzymałeś(aś) premię respektu za pełną godzine grania!");
			    Player[x][Exp] += 100;
                GameTextForPlayer(x,"~w~Exp + ~b~~h~100", 1000, 1);
				Player[x][Level] = GetPlayerLevel(x);
                SavePlayer(x);
			else
				SCM(x,C_GREEN,"Otrzymałeś(aś) premię respektu za pełną godzine grania + Tag "SERVER_TAG"!");
                Player[x][Exp] += 150;
                GameTextForPlayer(x,"~w~Exp + ~b~~h~150", 1000, 1);
				Player[x][Level] = GetPlayerLevel(x);
				SavePlayer(x);
	new Float:BalonX,Float:BalonY,Float:BalonZ;
    GetObjectPos(BalonLV,BalonX,BalonY,BalonZ);
	if(BalonX == 2177.63, BalonY == 944.26, BalonZ == 14.66) //Jeżeli balon jest w LV
		MoveObject(BalonLV, BalonX, BalonY, 130.0, 15.0);
        UpdateDynamic3DTextLabelText(TextBalonLV[0], 0xFFFFFFFF, ""G"[Balon]\n"W"Balon wylatuje do wojska.");
        UpdateDynamic3DTextLabelText(TextBalonLV[1], 0xFFFFFFFF, ""G"[Balon]\n"W"Balon przylatuje z LV.");
    if(BalonX == 197.66, BalonY == 1879.46, BalonZ == 16.61) //Jeżeli balon jest w Wojsku LV
		MoveObject(BalonLV, BalonX, BalonY, 130.0, 15.0);
        UpdateDynamic3DTextLabelText(TextBalonLV[1], 0xFFFFFFFF, ""G"[Balon]\n"W"Balon wylatuje do LV.");
        UpdateDynamic3DTextLabelText(TextBalonLV[0], 0xFFFFFFFF, ""G"[Balon]\n"W"Balon przylatuje z wojska.");
    if(LastInfoChat >= sizeof(ChatInfos)) LastInfoChat = 0;
	SCMA(C_GREEN, ChatInfos[LastInfoChat]);
	LastInfoChat ++;
	Odswiez3DAren();
	if(Timer[0] == 23 && Timer[1] == 59)
        if(mysql_ping() == -1)
			mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
        DomyCzynsz();
		mysql_query("UPDATE `"PREFIX"Vips` SET `Waznosc` = `Waznosc` - 1 WHERE `Waznosc` > 0");
        mysql_query("UPDATE `"PREFIX"Mods` SET `Waznosc` = `Waznosc` - 1 WHERE `Waznosc` > 0");
        mysql_query("UPDATE `"PREFIX"Vips` SET `Suspension` = `Suspension` - 1 WHERE `Suspension` > 0");
        mysql_query("UPDATE `"PREFIX"Mods` SET `Suspension` = `Suspension` - 1 WHERE `Suspension` > 0");
        mysql_query("UPDATE `"PREFIX"Admins` SET `Waznosc` = `Waznosc` - 1 WHERE `Waznosc` > 0");
        mysql_query("UPDATE `"PREFIX"Admins` SET `Suspension` = `Suspension` - 1 WHERE `Suspension` > 0");
  		mysql_query("DELETE FROM "PREFIX"Vips WHERE `Waznosc` = 0");
        mysql_query("DELETE FROM "PREFIX"Mods WHERE `Waznosc` = 0");
        mysql_query("DELETE FROM "PREFIX"Admins WHERE `Waznosc` = 0");
       	mysql_query("UPDATE "PREFIX"Users SET Onlined='0'");
		mysql_query("UPDATE `"PREFIX"Users` SET `WaznoscPriv` = `WaznoscPriv` - 1 WHERE `WaznoscPriv` > 0");
		mysql_query("UPDATE `"PREFIX"Users` SET pVeh='0' WHERE WaznoscPriv = 0");
        mysql_query("DELETE pv FROM "PREFIX"Vehicles AS pv, "PREFIX"Users AS us WHERE pv.vOwner = us.Name && us.WaznoscPriv = 0");
		SelectGunDay();
 		new String[128];
		format(String,sizeof(String),"UPDATE "PREFIX"Config SET GunDay='%d'",GunDay);
		mysql_query(String);
		SendRconCommand("gmx");
	return 1;
public OnRconCommand(cmd[])
    new Timer[2];
	gettime(Timer[0],Timer[1]);
	if(Timer[0] != 23)
		if(!strcmp(cmd,"gmx",true))
	        return 0;
	    if(!strcmp(cmd,"exit",true))
	        return 0;
	    if(!strcmp(cmd,"password",true))
	        return 0;
	    if(!strcmp(cmd,"ban",true))
	        return 0;
	return 0;
new Text:KodTD;
forward ReactionTimeout();
public ReactionTimeout()
	KillTimer(TimerReaction);
	TimerReaction = SetTimer("ReactionTest", 600000, 0);
	TextDrawHideForAll(KodTD);
	TestReaction = 0;
	return 1;
forward ReactionTest();
public ReactionTest()
	if(OnlinePlayers == 0) return 1;
	KillTimer(TimerReaction);
	TimerReaction = SetTimer("ReactionTimeout",600000,0);
	TestReaction = 1;
    new mstr[64];
	format(STRReaction, 20, "%c%c%c%c%c%c%c%c%c%c",
		Letters[random(60)],Letters[random(60)],Letters[random(60)],
		Letters[random(60)],Letters[random(60)],Letters[random(60)],
		Letters[random(60)],Letters[random(60)],Letters[random(60)],Letters[random(60)]);
	format(mstr, 64, "~r~~h~Kod:~w~ %s", STRReaction);
	TextDrawSetString(KodTD, mstr);
	TextDrawShowForAll(KodTD);
	return 1;
forward Timer10Minut();
public Timer10Minut()
    new hour;
	gettime(hour);
	SetWorldTime(hour);
	SetWeather(random(5));
    SetGameModeText("PL|GS™ "VERSION" [FR/DM]");
	SendRconCommand("mapname "MAPNAME"");
	SendRconCommand("hostname "HOSTNAME"");
    SendRconCommand("weburl "WWW"");
    SaveStatistics();
    SaveConfigs();
    if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
    new Float:posX[MAX_PLAYERS],Float:posY[MAX_PLAYERS],Float:posZ[MAX_PLAYERS];
    for(new x=0;x<MAX_BIZNES;x++)
        foreach(Player,playerid)
            if(strcmp(bInfo[x][bOwner],Player[playerid][Name])==0)
				if(Player[playerid][Bank] < 999999)
					Player[playerid][Bank] += bInfo[x][bCash];
					Player[playerid][MaDochod] = true;
	foreach(Player,x)
		SavePlayer(x);
		if(Player[x][MaDochod])
	        SCM(x, C_YELLOW, ""WI" "Y"Otrzymałeś dochód z swoich posiadłości! Sprawdź stan konta w banku.");
            Player[x][MaDochod] = false;
        GetPlayerPos(x,posX[x],posY[x],posZ[x]);
		if(posX[x] == AfkPosX[x] && posY[x] == AfkPosY[x] && posZ[x] == AfkPosZ[x] && posX[x] != 0.0 && posY[x] != 0.0 && posZ[x] != 0.0)
			new tmp[140];
			format(tmp, sizeof(tmp), ""W"*(K) "R2"%s "R"został wyrzucony(a) z serwera za zbyt długą nieaktywność.",Player[x][Name]);
			SCMA(C_ERROR, tmp);
			Player[x][Kicks] ++;
			GlobalKicks ++;
			Kick(x);
		else
			GetPlayerPos(x,AfkPosX[x],AfkPosY[x],AfkPosZ[x]);
 	new String[125];
    for(new x=0;x<MAX_PRIVATE_VEHICLES;x++)
		format(String,sizeof(String),"UPDATE `"PREFIX"Vehicles` SET vPrzebieg='%d' WHERE `vID` = %d",vInfo[x][vPrzebieg],x);
		mysql_query(String);
	mysql_free_result();
	return 1;
forward TimerGodzina();
public TimerGodzina()
    DelPojazdy();
    new Data[3],String[50];
	getdate(Data[0],Data[1],Data[2]);
	format(String,sizeof(String), "~w~~h~%02d~y~.~w~~h~%02d~y~.~w~~h~%04d",Data[2],Data[1],Data[0]);
	TextDrawSetString(DataTD, String);
	return 1;
DomyCzynsz()
    if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
    new String[300];
	mysql_query("UPDATE `"PREFIX"Houses` SET `hWaznosc` = `hWaznosc` - 1 WHERE `hWaznosc` > 0 OR `hOwner` != 0");
    mysql_query("UPDATE `"PREFIX"Houses` SET hWaznosc='0',hOwner='0' WHERE `hWaznosc` = '0' OR `hOwner` != 0");
	for(new HouseId = 0; HouseId < MAX_HOUSES; HouseId++)
		if(hInfo[HouseId][hWaznosc] > 0)
   			hInfo[HouseId][hWaznosc] --;
   		
			if(hInfo[HouseId][hWaznosc] <= 0)
				DestroyDynamicPickup(hInfo[HouseId][hPickup]);
				DestroyDynamicMapIcon(hInfo[HouseId][hIcon]);
		        hInfo[HouseId][hPickup] = CreateDynamicPickup(1273, 1, hInfo[HouseId][hOutX], hInfo[HouseId][hOutY], hInfo[HouseId][hOutZ], 0, 0, -1, 60.0);
				hInfo[HouseId][hIcon] = CreateDynamicMapIcon(hInfo[HouseId][hOutX], hInfo[HouseId][hOutY], hInfo[HouseId][hOutZ], 31, -1, 0, 0, -1, 1000000.0);
	            new userid = GetPlayerIdFromName(hInfo[HouseId][hOwner]);
                format(String,sizeof(String),"UPDATE `"PREFIX"Users` SET House='-1',HouseSpawn='0' WHERE Name='%s'",hInfo[HouseId][hOwner]);
				mysql_query(String);
				if(hInfo[HouseId][hOwner] != 0)
					format(hInfo[HouseId][hOwner],MAX_PLAYER_NAME,"0");
					if(IsPlayerConnected(userid))
						SCM(userid, C_WHITE, ""I" "W"Zostałeś(aś) wyrzucony(a) z domu z powodu nie płacenia czynszu!");
						if(!Player[userid][Zajety])
							SPD(userid, D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Informacja","Straciłeś(aś) swój domek!", "Zamknij", "");
						PlaySoundForPlayer(userid, 1150);
						if(Player[userid][InHouse])
							PlayerLeaveHouse(userid, hInfo[Player[userid][HouseOwn]][hID]);
						Player[userid][HouseOwn] = -1;
						Player[userid][CheckHouseSpawn] = 0;
				hInfo[HouseId][hOwner] = 0;
				format(String,sizeof(String),"%s\nKoszt: %d exp",hInfo[HouseId][hName],hInfo[HouseId][hCzynsz]);
				UpdateDynamic3DTextLabelText(hInfo[HouseId][hLabel], 0xFFB400FF, String);
	return 1;
main()
	print("\n-----------------------------------------------");
    print(" 											    ");
    print(" 											    ");
    printf(" PL|GoldServer™ "VERSION" zaladowany w %.4fs.    ",LoadTime);
    print(" 											    ");
    print(" 											    ");
    print("-----------------------------------------------\n");
public OnGameModeInit()
    EmitAMX();
	#if defined USE_CONTROL_IP
	new ip[16];
	GetServerVarAsString("bind", ip, sizeof(ip));
	if (!ip[0] || strcmp(ip, SERVER_IP))
		for (;;)
			printf("[GoldServer] - Brak autoryzacji!");
	#endif
    new Tick;
	Tick = tickcount();
	SetGameModeText("PL|GS™ "VERSION" [FR/DM]");
	SendRconCommand("mapname "MAPNAME"");
	SendRconCommand("hostname "HOSTNAME"");
	SendRconCommand("weburl "WWW"");
	AllowInteriorWeapons(0);
	AllowAdminTeleport(1);
	UsePlayerPedAnims();
	SetNameTagDrawDistance(30.0);
	ShowPlayerMarkers(1);
	ShowNameTags(1);
	EnableStuntBonusForAll(0);
    SetWeather(random(5));
	print("\n[GoldServer] Konfiguracje zostały załadowane.");
    print("[GoldServer] Trwa łączenie z bazą danych...");
    mysql_init();
    mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	new StringUsers[2100];
	format(StringUsers,sizeof(StringUsers),"CREATE TABLE IF NOT EXISTS `"PREFIX"Users` (AID INT(20),Name VARCHAR(20),Password VARCHAR(40),Exp INT(20),Money INT(15),Kills INT(20),Deaths INT(20),Suicides INT(20),Row_Kills SMALLINT(10),TimePlay SMALLINT(10),Warns SMALLINT(10),Mute SMALLINT(10),Jail SMALLINT(10),");
	strcat(StringUsers, "Bank INT(20),Kodow SMALLINT(10),Kicks SMALLINT(10),Bans SMALLINT(10),Portfel SMALLINT(10),Skin SMALLINT(10),SoloScore SMALLINT(10),OnedeScore SMALLINT(10),MinigunScore SMALLINT(10),RPGScore SMALLINT(10),DriftScore INT(20),House SMALLINT(1),HouseSpawn SMALLINT(1),pVeh SMALLINT(1),Onlined SMALLINT(1),WaznoscPriv SMALLINT(1),CombatScore INT(10),");
    strcat(StringUsers, "WygranychWG INT(10),WygranychWS INT(10),WygranychCH INT(10),WygranychPB INT(10),WygranychUS INT(10),WygranychSN INT(10))");
	mysql_query(StringUsers);
    mysql_query("CREATE TABLE IF NOT EXISTS `"PREFIX"Vips` (Name VARCHAR(20),Waznosc SMALLINT(4),Suspension SMALLINT(4))");
    mysql_query("CREATE TABLE IF NOT EXISTS `"PREFIX"Mods` (Name VARCHAR(20),Waznosc SMALLINT(4),Suspension SMALLINT(4))");
    mysql_query("CREATE TABLE IF NOT EXISTS `"PREFIX"Admins` (Name VARCHAR(20),Level SMALLINT(1),Waznosc SMALLINT(4),Suspension SMALLINT(4))");
    mysql_query("CREATE TABLE IF NOT EXISTS `"PREFIX"Bans` (Nick VARCHAR(20), IP VARCHAR(30), Admin VARCHAR(20), Data VARCHAR(20), Godzina VARCHAR(20), Powod VARCHAR(80))");
	format(StringUsers,sizeof(StringUsers), "CREATE TABLE IF NOT EXISTS `"PREFIX"Achievements` (Name VARCHAR(20), aRegistered SMALLINT(4),aTrofea SMALLINT(4),aDoscTego SMALLINT(4),aKask SMALLINT(4),aJestemLepszy SMALLINT(4),aJestemMistrzem SMALLINT(4),aPilot SMALLINT(2),a24Godziny SMALLINT(2),aDoOstatniegoTchu SMALLINT(2),");
	strcat(StringUsers, "aCelneOko SMALLINT(3),aZwinnePalce SMALLINT(3),aPodroznik SMALLINT(1),aDrifter SMALLINT(1),aKrolDriftu SMALLINT(1),aStreetKing SMALLINT(2),aNowaTozsamosc SMALLINT(1),aDomownik SMALLINT(1),aWlasne4 SMALLINT(1),aZzzz SMALLINT(1),aWyborowy SMALLINT(3),aKomandos SMALLINT(3),aWedkarz SMALLINT(3),aStalyGracz SMALLINT(2),aPoszukiwacz SMALLINT(2))");
	mysql_query(StringUsers);
	mysql_query("CREATE TABLE IF NOT EXISTS `"PREFIX"Config` (MaxPing SMALLINT(5),AdminPass VARCHAR(32),RconPass VARCHAR(32),GunDay SMALLINT(3))");
    mysql_query("CREATE TABLE IF NOT EXISTS `"PREFIX"Stats` (RekordGraczy INT(4), Wejsc INT(10), Kickow INT(10), Banow INT(10), Zabojstw INT(10), Smierci INT(10))");
    mysql_query("CREATE TABLE IF NOT EXISTS `"PREFIX"WG` (ID SMALLINT(5),Team1SpawnX VARCHAR(32),Team1SpawnY VARCHAR(32),Team1SpawnZ VARCHAR(32),Team2SpawnX VARCHAR(32),Team2SpawnY VARCHAR(32),Team2SpawnZ VARCHAR(32),WGAreaX VARCHAR(32),WGAreaY VARCHAR(32),WGAreaZ VARCHAR(32),WGAreaA VARCHAR(32),Interior INT(3))");
    mysql_query("CREATE TABLE IF NOT EXISTS `"PREFIX"PB` (ID SMALLINT(5),Team1SpawnX VARCHAR(32),Team1SpawnY VARCHAR(32),Team1SpawnZ VARCHAR(32),Team2SpawnX VARCHAR(32),Team2SpawnY VARCHAR(32),Team2SpawnZ VARCHAR(32),PBAreaX VARCHAR(32),PBAreaY VARCHAR(32),PBAreaZ VARCHAR(32),PBAreaA VARCHAR(32),Interior INT(3))");
	mysql_query("CREATE TABLE IF NOT EXISTS `"PREFIX"CH` (ID SMALLINT(5),ChowanyTP VARCHAR(50),SzukanyTP VARCHAR(50),Interior SMALLINT(5),Strefa VARCHAR(60))");
    mysql_query("CREATE TABLE IF NOT EXISTS `"PREFIX"Houses` (hID SMALLINT(5),hName VARCHAR(32),hOwner VARCHAR(20),hOutX VARCHAR(20),hOutY VARCHAR(20),hOutZ VARCHAR(20),hInX VARCHAR(20),hInY VARCHAR(20),hInZ VARCHAR(20),hLocked SMALLINT(1),hCzynsz SMALLINT(5),hWaznosc SMALLINT(5),hInterior SMALLINT(5),hAngle VARCHAR (20))");
	mysql_query("CREATE TABLE IF NOT EXISTS `"PREFIX"Biznesy` (bID SMALLINT(5),bName VARCHAR(32),bOwner VARCHAR(20),bCash INT(15),bPosX VARCHAR(24),bPosY VARCHAR(24),bPosZ VARCHAR(24))");
	format(StringUsers,sizeof(StringUsers),"CREATE TABLE IF NOT EXISTS `"PREFIX"Vehicles` (vID SMALLINT(5),vModel SMALLINT(5),vOwner VARCHAR(20),vPosX VARCHAR(24),vPosY VARCHAR(24),vPosZ VARCHAR(24),vAngle VARCHAR(24),vColor1 SMALLINT(5),vColor2 SMALLINT(5),vPrzebieg INT(10),vPaintJob SMALLINT(3),SPOILER SMALLINT(5),HOOD SMALLINT(5),ROOF SMALLINT(5),SIDESKIRT SMALLINT(5),LAMPS SMALLINT(5),");
	strcat(StringUsers, "EXHAUST SMALLINT(5),WHEELS SMALLINT(5),STEREO SMALLINT(5),HYDRAULICS SMALLINT(5),FRONT_BUMPER SMALLINT(5),REAR_BUMPER SMALLINT(5),VENT_RIGHT SMALLINT(5),VENT_LEFT SMALLINT(5))");
	mysql_query(StringUsers);
	format(StringUsers,sizeof(StringUsers),"CREATE TABLE IF NOT EXISTS `"PREFIX"WS` (ID SMALLINT(5),Interior SMALLINT(5),Model SMALLINT(4),CP_LICZBA SMALLINT(4),Angle VARCHAR(24),CP_SIZE SMALLINT(4),CP_TYPE SMALLINT(4),ON_FOOT SMALLINT(4),");
	strcat(StringUsers, "C_0 VARCHAR(50),C_1 VARCHAR(50),C_2 VARCHAR(50),C_3 VARCHAR(50),C_4 VARCHAR(50),C_5 VARCHAR(50),C_6 VARCHAR(50),C_7 VARCHAR(50),C_8 VARCHAR(50),C_9 VARCHAR(50),");
	strcat(StringUsers, "CP_0 VARCHAR(50),CP_1 VARCHAR(50),CP_2 VARCHAR(50),CP_3 VARCHAR(50),CP_4 VARCHAR(50),CP_5 VARCHAR(50),CP_6 VARCHAR(50),CP_7 VARCHAR(50),CP_8 VARCHAR(50),CP_9 VARCHAR(50),CP_10 VARCHAR(50),CP_11 VARCHAR(50),CP_12 VARCHAR(50),CP_13 VARCHAR(50),CP_14 VARCHAR(50),CP_15 VARCHAR(50),CP_16 VARCHAR(50),CP_17 VARCHAR(50),CP_18 VARCHAR(50),CP_19 VARCHAR(50),CP_20 VARCHAR(50),CP_21 VARCHAR(50),CP_22 VARCHAR(50),");
	strcat(StringUsers, "CP_23 VARCHAR(50),CP_24 VARCHAR(50),CP_25 VARCHAR(50),CP_26 VARCHAR(50),CP_27 VARCHAR(50),CP_28 VARCHAR(50),CP_29 VARCHAR(50),CP_30 VARCHAR(50),CP_31 VARCHAR(50),CP_32 VARCHAR(50),CP_33 VARCHAR(50),CP_34 VARCHAR(50),CP_35 VARCHAR(50),CP_36 VARCHAR(50),CP_37 VARCHAR(50),CP_38 VARCHAR(50),CP_39 VARCHAR(50),");
	strcat(StringUsers, "CP_40 VARCHAR(50),CP_41 VARCHAR(50),CP_42 VARCHAR(50),CP_43 VARCHAR(50),CP_44 VARCHAR(50),CP_45 VARCHAR(50),CP_46 VARCHAR(50),CP_47 VARCHAR(50),CP_48 VARCHAR(50),CP_49 VARCHAR(50))");
	mysql_query(StringUsers);
	mysql_query("CREATE TABLE IF NOT EXISTS `"PREFIX"Gangi` (gID SMALLINT(3),gName VARCHAR(50),gSzef VARCHAR(30),gVice VARCHAR(30),gTag VARCHAR(10),gColor VARCHAR(10),gCar SMALLINT(4),gSkin SMALLINT(3),gEnter VARCHAR(50),gExit VARCHAR(50),gInterior SMALLINT(3))");
	mysql_query("CREATE TABLE IF NOT EXISTS `"PREFIX"Gangi_Users` (gID SMALLINT(3),gMember VARCHAR(30),gName VARCHAR(50),gZapro SMALLINT(3))");
	if(!mysql_ping())
        print("[GoldServer] Połączono z bazą danych i stworzono tabele.");
    else
        print("[GoldServer] Błąd połączenia. Ponawianie połączenia...");
        mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
        if(!mysql_ping())
            print("[GoldServer] Połączono z baządanych i stworzono tabele.");
            mysql_free_result();
        else
            print("[GoldServer] Błąd połączenia. Wyłączenie GameMode.");
			SendRconCommand("exit");
    LoadStatistics();
	LoadConfigs();
	if(GlobalJoins == 0 && GlobalKills == 0 && GlobalDeaths == 0 && GlobalUsers == 0 && GlobalKicks == 0 && GlobalBans == 0 && RekordGraczy == 0)
		mysql_query("DELETE FROM `"SQL_DBNM"`.`"PREFIX"Stats` WHERE `"PREFIX"Stats`.`RekordGraczy` = '0' AND `"PREFIX"Stats`.`Wejsc` = '0' AND `"PREFIX"Stats`.`Zabojstw` = '0'  AND `"PREFIX"Stats`.`Smierci` = '0' LIMIT 1");
		mysql_query("INSERT INTO "PREFIX"Stats VALUES('0', '0', '0', '0', '0', '0')");
	if(MaxPing <= 0)
        for(new i = 0; i < 10; i++)
  			RconPass[i] = Letters[random(60)];
            AdminPass[i] = Letters[random(60)];
		mysql_query("DELETE FROM `"SQL_DBNM"`.`"PREFIX"Config` WHERE `"PREFIX"Config`.`MaxPing` = '0' AND `"PREFIX"Config`.`AdminPass` = 'null' AND `"PREFIX"Config`.`RconPass` = 'null' LIMIT 1");
		new Si[150];
		format(Si,sizeof(Si),"INSERT INTO "PREFIX"Config VALUES('350','%s','%s','1')",AdminPass,RconPass);
		mysql_query(Si);
		print("[GoldServer] Wygenerowano losowe hasla admina i rcon. Nalezy je zmienic!");
	printf("[GoldServer] Załadowano statystyki,configi serwera i skonfigurowano tabele stats & config.");
	MaxPing = 350;
	//Mężczyźni
	AddPlayerClass(1, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(2, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(3, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(4, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(5, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(6, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(7, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(8, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(14, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(15, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(16, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(17, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(18, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(19, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(20, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(21, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(22, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(23, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(24, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(25, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(26, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(27, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(28, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(29, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(30, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(32, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(33, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(34, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(35, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(36, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(37, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(42, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(43, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(44, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(45, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(46, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(47, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(48, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(49, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(50, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(51, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(52, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(57, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(58, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(59, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(60, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(61, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(62, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(66, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(67, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(68, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(70, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(71, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(72, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(73, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(78, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(79, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(80, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(81, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(82, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(83, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(84, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(86, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(94, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(95, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(96, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(97, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(98, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(99, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(100, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(101, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(102, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(103, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(104, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(105, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(106, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(107, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(108, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(109, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(110, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(111, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(112, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(113, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(114, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(115, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(116, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(117, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(118, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(119, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(120, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(121, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(122, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(123, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(124, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(125, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(126, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(127, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(128, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(132, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(133, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(134, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(135, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(136, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(137, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(142, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(143, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(144, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(146, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(147, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(149, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(153, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(154, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(155, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(156, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(158, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(159, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(160, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(161, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(162, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(163, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(164, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(165, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(166, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(167, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(168, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(170, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(171, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(173, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(174, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(175, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(176, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(177, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(179, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(180, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(181, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(182, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(183, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(184, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(185, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(186, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(187, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(188, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(189, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(200, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(202, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(203, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(204, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(206, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(208, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(209, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(210, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(212, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(213, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(217, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(220, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(221, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(222, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(223, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(227, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(228, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(229, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(230, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(234, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(235, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(236, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(239, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(240, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(241, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(242, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(247, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(248, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(249, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(250, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(252, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(253, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(254, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(255, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(258, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(259, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(260, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(261, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(262, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(264, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(265, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(266, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(267, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(268, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(269, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(270, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(271, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(272, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(273, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(274, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(275, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(276, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(277, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(278, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(279, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(280, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(281, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(282, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(283, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(284, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(285, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(286, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(287, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(288, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(289, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(290, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(291, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(292, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(293, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(294, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(295, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(296, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(297, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(299, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    print("[GoldServer] Skiny męskie zostały załadowane.");
	//Kobiety
    AddPlayerClass(9, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(10, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(11, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(12, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(13, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(219, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(224, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(225, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(226, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(231, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(233, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(237, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(238, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(31, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(38, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(39, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(40, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(41, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(53, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(75, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(76, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(77, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(85, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(87, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(88, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(89, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(90, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(91, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(92, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(93, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(129, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(130, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(131, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(138, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(139, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(140, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(141, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(145, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(148, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(150, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(151, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(152, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(157, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(169, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(172, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(190, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(191, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(192, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(193, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(194, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(195, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(196, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(197, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(198, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(199, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(201, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(205, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(207, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(211, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(214, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(215, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(216, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(218, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(243, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(244, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(245, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(246, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(251, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(256, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(257, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(263, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(298, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(54, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(55, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(56, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(63, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(64, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(65, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(69, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    print("[GoldServer] Skiny damskie zostały załadowane.");
    PanoramaUp1 = TextDrawCreate(1.000000,1.000000,"_");
	PanoramaUp2 = TextDrawCreate(1.000000,1.000000,"_");
	TextDrawUseBox(PanoramaUp1,1);
	TextDrawBoxColor(PanoramaUp1,0xFFFA6666);
	TextDrawTextSize(PanoramaUp1,646.000000,0.000000);
	TextDrawUseBox(PanoramaUp2,1);
	TextDrawBoxColor(PanoramaUp2,0x000000ff);
	TextDrawTextSize(PanoramaUp2,650.000000,0.000000);
	TextDrawAlignment(PanoramaUp1,0);
	TextDrawAlignment(PanoramaUp2,0);
	TextDrawBackgroundColor(PanoramaUp1,0x000000ff);
	TextDrawBackgroundColor(PanoramaUp2,0x000000ff);
	TextDrawFont(PanoramaUp1,3);
	TextDrawLetterSize(PanoramaUp1,1.000000,8.399993);
	TextDrawFont(PanoramaUp2,3);
	TextDrawLetterSize(PanoramaUp2,1.000000,7.999994);
	TextDrawColor(PanoramaUp1,0xffffffff);
	TextDrawColor(PanoramaUp2,0xffffffff);
	TextDrawSetOutline(PanoramaUp1,1);
	TextDrawSetOutline(PanoramaUp2,1);
	TextDrawSetProportional(PanoramaUp1,1);
	TextDrawSetProportional(PanoramaUp2,1);
	TextDrawSetShadow(PanoramaUp1,1);
	TextDrawSetShadow(PanoramaUp2,1);
	PanoramaDown1 = TextDrawCreate(1.000000,373.000000,"_");
	PanoramaDown2 = TextDrawCreate(1.000000,377.000000,"_");
	TextDrawUseBox(PanoramaDown1,1);
	TextDrawBoxColor(PanoramaDown1,0xFFFA6666);
	TextDrawTextSize(PanoramaDown1,646.000000,0.000000);
	TextDrawUseBox(PanoramaDown2,1);
	TextDrawBoxColor(PanoramaDown2,0x000000ff);
	TextDrawTextSize(PanoramaDown2,650.000000,0.000000);
	TextDrawAlignment(PanoramaDown1,0);
	TextDrawAlignment(PanoramaDown2,0);
	TextDrawBackgroundColor(PanoramaDown1,0x000000ff);
	TextDrawBackgroundColor(PanoramaDown2,0x000000ff);
	TextDrawFont(PanoramaDown1,3);
	TextDrawLetterSize(PanoramaDown1,1.000000,8.399993);
	TextDrawFont(PanoramaDown2,3);
	TextDrawLetterSize(PanoramaDown2,1.000000,7.999994);
	TextDrawColor(PanoramaDown1,0xffffffff);
	TextDrawColor(PanoramaDown2,0xffffffff);
	TextDrawSetOutline(PanoramaDown1,1);
	TextDrawSetOutline(PanoramaDown2,1);
	TextDrawSetProportional(PanoramaDown1,1);
	TextDrawSetProportional(PanoramaDown2,1);
	TextDrawSetShadow(PanoramaDown1,1);
	TextDrawSetShadow(PanoramaDown2,1);
       
    LogoS1 = TextDrawCreate(5.000000,429.000000,"GoldServer");
	LogoS2 = TextDrawCreate(70.000000,430.000000,"TM");
	LogoS3 = TextDrawCreate(89.000000,433.000000,""VERSION"");
	TextDrawAlignment(LogoS1,0);
	TextDrawAlignment(LogoS2,0);
	TextDrawAlignment(LogoS3,0);
	TextDrawBackgroundColor(LogoS1,0x000000ff);
	TextDrawBackgroundColor(LogoS2,0x000000ff);
	TextDrawBackgroundColor(LogoS3,0x000000ff);
	TextDrawFont(LogoS1,0);
	TextDrawLetterSize(LogoS1,0.499999,1.600000);
	TextDrawFont(LogoS2,2);
	TextDrawLetterSize(LogoS2,0.199999,0.599999);
	TextDrawFont(LogoS3,2);
	TextDrawLetterSize(LogoS3,0.199999,1.000000);
	TextDrawColor(LogoS1,0xFF8800ff);
	TextDrawColor(LogoS2,0xffffffff);
	TextDrawColor(LogoS3,0xffffffff);
	TextDrawSetProportional(LogoS1,1);
	TextDrawSetProportional(LogoS2,1);
	TextDrawSetProportional(LogoS3,1);
	TextDrawSetShadow(LogoS1,1);
	TextDrawSetShadow(LogoS2,1);
	TextDrawSetShadow(LogoS3,1);
       
    new Float:posX = 385.0,Float:posY = 442.0;
	for(new x=0;x<13;x++)
		PasekBox[x] = TextDrawCreate(posX,posY, "_");
		TextDrawAlignment(PasekBox[x], 2);
		TextDrawBackgroundColor(PasekBox[x], 255);
		TextDrawFont(PasekBox[x], 1);
		TextDrawLetterSize(PasekBox[x], 0.500000, 0.104);
		TextDrawColor(PasekBox[x], -1);
		TextDrawSetOutline(PasekBox[x], 0);
		TextDrawSetProportional(PasekBox[x], 1);
		TextDrawSetShadow(PasekBox[x], 1);
		TextDrawUseBox(PasekBox[x], 1);
		TextDrawBoxColor(PasekBox[x], 48);
		TextDrawTextSize(PasekBox[x], 300.000000,-530.000000); //0.000000, 430.0);
		posX += 2.5,posY -= 2.5;
	posX = 567.0,posY = 402.0;
    for(new x=0;x<13;x++)
		LicznikBox[x] = TextDrawCreate(posX,posY,"_");
		TextDrawUseBox(LicznikBox[x],1);
		TextDrawBoxColor(LicznikBox[x],48);
		TextDrawTextSize(LicznikBox[x],23.000000,193.000000);
		TextDrawAlignment(LicznikBox[x],2);
		TextDrawBackgroundColor(LicznikBox[x],255);
		TextDrawFont(LicznikBox[x],3);
		TextDrawLetterSize(LicznikBox[x],0.500000, 0.104);
		TextDrawColor(LicznikBox[x],0xffffffff);
		TextDrawSetOutline(LicznikBox[x],1);
		TextDrawSetProportional(LicznikBox[x],1);
		TextDrawSetShadow(LicznikBox[x],1);
        posX += 2.5,posY -= 2.5;
    posX = 310.0,posY = 402.0;
    for(new x=0;x<13;x++)
	    InfoBox[x] = TextDrawCreate(posX,posY,"_");
		TextDrawUseBox(InfoBox[x],1);
		TextDrawBoxColor(InfoBox[x],48);
		TextDrawTextSize(InfoBox[x],150.000000,305.000000);
		TextDrawAlignment(InfoBox[x],2);
		TextDrawBackgroundColor(InfoBox[x],0x00000066);
		TextDrawFont(InfoBox[x],1);
		TextDrawLetterSize(InfoBox[x],1.399999,0.099999);
		TextDrawColor(InfoBox[x],0xffffffff);
		TextDrawSetOutline(InfoBox[x],1);
		TextDrawSetProportional(InfoBox[x],1);
		TextDrawSetShadow(InfoBox[x],1);
        posX += 2.5,posY -= 2.5;
	tdLevelUp = TextDrawCreate(38.000000,261.000000,"Level UP!");
	TextDrawAlignment(tdLevelUp,0);
	TextDrawBackgroundColor(tdLevelUp,0x00000066);
	TextDrawFont(tdLevelUp,0);
	TextDrawLetterSize(tdLevelUp,1.000000,3.200000);
	TextDrawColor(tdLevelUp,0x00ff00ff);
	TextDrawSetOutline(tdLevelUp,1);
	TextDrawSetProportional(tdLevelUp,1);
	TextDrawSetShadow(tdLevelUp,1);
    CzasTD = TextDrawCreate(546.000000,23.000000,"_");
	TextDrawAlignment(CzasTD,0);
	TextDrawBackgroundColor(CzasTD,0x00000033);
	TextDrawFont(CzasTD,3);
	TextDrawLetterSize(CzasTD,0.399999,1.400000);
	TextDrawColor(CzasTD,0xffffffff);
	TextDrawSetOutline(CzasTD,1);
	TextDrawSetProportional(CzasTD,1);
	TextDrawSetShadow(CzasTD,1);
    DataTD = TextDrawCreate(557.000000,15.000000,"_");
	TextDrawAlignment(DataTD,0);
	TextDrawBackgroundColor(DataTD,0x00000033);
	TextDrawFont(DataTD,1);
	TextDrawLetterSize(DataTD,0.199999,0.799999);
	TextDrawColor(DataTD,0xffffffff);
	TextDrawSetOutline(DataTD,1);
	TextDrawSetProportional(DataTD,1);
	TextDrawSetShadow(DataTD,1);
    AnkietaDraw = TextDrawCreate(219.000000,273.000000,"_");
	TextDrawUseBox(AnkietaDraw,1);
	TextDrawBoxColor(AnkietaDraw,0x00000033);
	TextDrawTextSize(AnkietaDraw,241.000000,0.000000);
	TextDrawAlignment(AnkietaDraw,3);
	TextDrawBackgroundColor(AnkietaDraw,0x00000066);
	TextDrawFont(AnkietaDraw,1);
	TextDrawLetterSize(AnkietaDraw,0.299999,1.000000);
	TextDrawColor(AnkietaDraw,0xffffffff);
	TextDrawSetOutline(AnkietaDraw,1);
	TextDrawSetProportional(AnkietaDraw,1);
	TextDrawSetShadow(AnkietaDraw,1);
    AnnFade = TextDrawCreate(640.0/2, 480.0/2 - 115, #_);
	TextDrawColor(AnnFade, 0xFFFFFFFF);
	TextDrawBackgroundColor(AnnFade, 0x00000040);
	TextDrawFont(AnnFade, 1);
	TextDrawTextSize(AnnFade, 300, 300);
	TextDrawLetterSize(AnnFade, 0.36*1.2, 1.8*1.2);
	TextDrawSetProportional(AnnFade, 1);
	TextDrawAlignment(AnnFade, 2);
    TextDrawSetOutline(AnnFade, 1);
    PasekStringGora = TextDrawCreate(155.000000,415.000000,"Chcesz byc VIP-em?    Exp:         Level:     Online:     Gracze:     Ratio:     Portfel:");
	TextDrawAlignment(PasekStringGora,0);
	TextDrawBackgroundColor(PasekStringGora,0x00000033);
	TextDrawFont(PasekStringGora,1);
	TextDrawLetterSize(PasekStringGora,0.299999,1.300000);
	TextDrawColor(PasekStringGora,0x76c805ff);
	TextDrawSetOutline(PasekStringGora,1);
	TextDrawSetProportional(PasekStringGora,1);
	TextDrawSetShadow(PasekStringGora,1);
    GraczeTD = TextDrawCreate(474.000000,427.000000,"1(0/0/0)");
	TextDrawAlignment(GraczeTD,2);
	TextDrawBackgroundColor(GraczeTD,0x00000033);
	TextDrawFont(GraczeTD,1);
	TextDrawLetterSize(GraczeTD,0.299999,1.300000);
	TextDrawColor(GraczeTD,0xffffffff);
	TextDrawSetOutline(GraczeTD,1);
	TextDrawSetProportional(GraczeTD,1);
	TextDrawSetShadow(GraczeTD,1);
    WpiszVIPTD = TextDrawCreate(204.000000,427.000000,"Wpisz /vip");
	TextDrawAlignment(WpiszVIPTD,2);
	TextDrawBackgroundColor(WpiszVIPTD,0x00000033);
	TextDrawFont(WpiszVIPTD,1);
	TextDrawLetterSize(WpiszVIPTD,0.299999,1.300000);
	TextDrawColor(WpiszVIPTD,0xffffffff);
	TextDrawSetOutline(WpiszVIPTD,1);
	TextDrawSetProportional(WpiszVIPTD,1);
	TextDrawSetShadow(WpiszVIPTD,1);
    FreeZone = TextDrawCreate(553.000000,101.000000,"strefa ~r~~h~smierci");
	TextDrawAlignment(FreeZone,2);
	TextDrawBackgroundColor(FreeZone,0x00000066);
	TextDrawFont(FreeZone,3);
	TextDrawLetterSize(FreeZone,0.399999,1.400000);
	TextDrawColor(FreeZone,0xffffffff);
	TextDrawSetOutline(FreeZone,1);
	TextDrawSetProportional(FreeZone,1);
	TextDrawSetShadow(FreeZone,1);
    BezDmZone = TextDrawCreate(553.000000,101.000000,"strefa ~b~~h~bez dm");
	TextDrawAlignment(BezDmZone,2);
	TextDrawBackgroundColor(BezDmZone,0x00000066);
	TextDrawFont(BezDmZone,3);
	TextDrawLetterSize(BezDmZone,0.399999,1.400000);
	TextDrawColor(BezDmZone,0xffffffff);
	TextDrawSetOutline(BezDmZone,1);
	TextDrawSetProportional(BezDmZone,1);
	TextDrawSetShadow(BezDmZone,1);
    ZapisyString = TextDrawCreate(4.000000,326.000000,"/WG~n~~n~/WS~n~~n~/CH~n~~n~/US~n~~n~/PB~n~~n~/SN");
	ZapisyLiczba = TextDrawCreate(12.000000,334.000000,"0/4~n~~n~0/4~n~~n~0/4~n~~n~0/4~n~~n~0/4~n~~n~0/4");
	TextDrawAlignment(ZapisyString,0);
	TextDrawAlignment(ZapisyLiczba,0);
	TextDrawBackgroundColor(ZapisyString,0x00000033);
	TextDrawBackgroundColor(ZapisyLiczba,0x00000033);
	TextDrawFont(ZapisyString,1);
	TextDrawLetterSize(ZapisyString,0.299999,0.899999);
	TextDrawFont(ZapisyLiczba,1);
	TextDrawLetterSize(ZapisyLiczba,0.299999,0.899999);
	TextDrawColor(ZapisyString,0x1B9BE0ff);
	TextDrawColor(ZapisyLiczba,0xFFFFFFFF);
	TextDrawSetOutline(ZapisyString,1);
	TextDrawSetOutline(ZapisyLiczba,1);
	TextDrawSetProportional(ZapisyString,1);
	TextDrawSetProportional(ZapisyLiczba,1);
	TextDrawSetShadow(ZapisyString,1);
	TextDrawSetShadow(ZapisyLiczba,1);
    ChowanyTD = TextDrawCreate(319.000000,371.000000,"~r~~h~Chowany~n~~w~Chowajacych: ~y~5 ~w~Szukajacych: ~y~1");
	TextDrawAlignment(ChowanyTD,2);
	TextDrawBackgroundColor(ChowanyTD,0x00000033);
	TextDrawFont(ChowanyTD,1);
	TextDrawLetterSize(ChowanyTD,0.299999,1.700000);
	TextDrawColor(ChowanyTD,0xffffffff);
	TextDrawSetOutline(ChowanyTD,1);
	TextDrawSetProportional(ChowanyTD,1);
	TextDrawSetShadow(ChowanyTD,1);
    PBTD = TextDrawCreate(319.000000,371.000000,"_");
	TextDrawAlignment(PBTD,2);
	TextDrawBackgroundColor(PBTD,0x00000033);
	TextDrawFont(PBTD,1);
	TextDrawLetterSize(PBTD,0.299999,1.700000);
	TextDrawColor(PBTD,0xffffffff);
	TextDrawSetOutline(PBTD,1);
	TextDrawSetProportional(PBTD,1);
	TextDrawSetShadow(PBTD,1);
    KodTD = TextDrawCreate(254.000000,357.000000,"_");
	TextDrawAlignment(KodTD,0);
	TextDrawBackgroundColor(KodTD,0x00000066);
	TextDrawFont(KodTD,1);
	TextDrawLetterSize(KodTD,0.299999,1.400000);
	TextDrawColor(KodTD,0xffffffff);
	TextDrawSetOutline(KodTD,1);
	TextDrawSetProportional(KodTD,1);
	TextDrawSetShadow(KodTD,1);
    print("[GoldServer] Trwa ladowanie prywatnych samochodow");
	LoadPrivateVehicles();
    for(new x; x < MAX_PLAYERS; x++)
        LicznikNazwa[x] = TextDrawCreate(569.000000,374.000000,"Bloodring Banger");
		TextDrawAlignment(LicznikNazwa[x],2);
		TextDrawBackgroundColor(LicznikNazwa[x],0x00000033);
		TextDrawFont(LicznikNazwa[x],1);
		TextDrawLetterSize(LicznikNazwa[x],0.299999,1.300000);
		TextDrawColor(LicznikNazwa[x],0x76c805ff);
		TextDrawSetOutline(LicznikNazwa[x],1);
		TextDrawSetProportional(LicznikNazwa[x],1);
		TextDrawSetShadow(LicznikNazwa[x],1);
	    ExpTD[x] = TextDrawCreate(291.000000,427.000000,"1148/1176");
		TextDrawAlignment(ExpTD[x],2);
		TextDrawBackgroundColor(ExpTD[x],0x00000033);
		TextDrawFont(ExpTD[x],1);
		TextDrawLetterSize(ExpTD[x],0.299999,1.300000);
		TextDrawColor(ExpTD[x],0xffffffff);
		TextDrawSetOutline(ExpTD[x],1);
		TextDrawSetProportional(ExpTD[x],1);
		TextDrawSetShadow(ExpTD[x],1);
		LevelTD[x] = TextDrawCreate(355.000000,427.000000,"13");
		TextDrawAlignment(LevelTD[x],2);
		TextDrawBackgroundColor(LevelTD[x],0x00000033);
		TextDrawFont(LevelTD[x],1);
		TextDrawLetterSize(LevelTD[x],0.299999,1.300000);
		TextDrawColor(LevelTD[x],0xffffffff);
		TextDrawSetOutline(LevelTD[x],1);
		TextDrawSetProportional(LevelTD[x],1);
		TextDrawSetShadow(LevelTD[x],1);
        OnlineTD[x] = TextDrawCreate(414.000000,427.000000,"0h 5min");
		TextDrawAlignment(OnlineTD[x],2);
		TextDrawBackgroundColor(OnlineTD[x],0x00000033);
		TextDrawFont(OnlineTD[x],1);
		TextDrawLetterSize(OnlineTD[x],0.299999,1.300000);
		TextDrawColor(OnlineTD[x],0xffffffff);
		TextDrawSetOutline(OnlineTD[x],1);
		TextDrawSetProportional(OnlineTD[x],1);
		TextDrawSetShadow(OnlineTD[x],1);
        RatioTD[x] = TextDrawCreate(531.000000,427.000000,"10.68");
		TextDrawAlignment(RatioTD[x],2);
		TextDrawBackgroundColor(RatioTD[x],0x00000033);
		TextDrawFont(RatioTD[x],1);
		TextDrawLetterSize(RatioTD[x],0.299999,1.300000);
		TextDrawColor(RatioTD[x],0xffffffff);
		TextDrawSetOutline(RatioTD[x],1);
		TextDrawSetProportional(RatioTD[x],1);
		TextDrawSetShadow(RatioTD[x],1);
        PortfelTD[x] = TextDrawCreate(591.000000,427.000000,"0 zl");
		TextDrawAlignment(PortfelTD[x],2);
		TextDrawBackgroundColor(PortfelTD[x],0x00000033);
		TextDrawFont(PortfelTD[x],1);
		TextDrawLetterSize(PortfelTD[x],0.299999,1.300000);
		TextDrawColor(PortfelTD[x],0xffffffff);
		TextDrawSetOutline(PortfelTD[x],1);
		TextDrawSetProportional(PortfelTD[x],1);
		TextDrawSetShadow(PortfelTD[x],1);
        LicznikPredkosc[x] = TextDrawCreate(563.000000,387.000000,"128 km/h___HP: 100/100");
		TextDrawAlignment(LicznikPredkosc[x],2);
		TextDrawBackgroundColor(LicznikPredkosc[x],0x00000033);
		TextDrawFont(LicznikPredkosc[x],1);
		TextDrawLetterSize(LicznikPredkosc[x],0.299999,1.300000);
		TextDrawColor(LicznikPredkosc[x],0xffffffff);
		TextDrawSetOutline(LicznikPredkosc[x],1);
		TextDrawSetProportional(LicznikPredkosc[x],1);
		TextDrawSetShadow(LicznikPredkosc[x],1);
        ArmourTD[x] = TextDrawCreate(583.000000,45.000000,"100%");
		TextDrawAlignment(ArmourTD[x],0);
		TextDrawBackgroundColor(ArmourTD[x],0x00000033);
		TextDrawFont(ArmourTD[x],1);
		TextDrawLetterSize(ArmourTD[x],0.199999,0.799999);
		TextDrawColor(ArmourTD[x],0xffffffff);
		TextDrawSetOutline(ArmourTD[x],1);
		TextDrawSetProportional(ArmourTD[x],1);
		TextDrawSetShadow(ArmourTD[x],1);
        HealthTD[x] = TextDrawCreate(583.000000,67.000000,"~r~~h~100%");
		TextDrawAlignment(HealthTD[x],0);
		TextDrawBackgroundColor(HealthTD[x],0x00000033);
		TextDrawFont(HealthTD[x],1);
		TextDrawLetterSize(HealthTD[x],0.199999,0.799999);
		TextDrawColor(HealthTD[x],0xffffffff);
		TextDrawSetOutline(HealthTD[x],1);
		TextDrawSetProportional(HealthTD[x],1);
		TextDrawSetShadow(HealthTD[x],1);
		RaceStats[x] = TextDrawCreate(319.000000,371.000000,"~r~~h~Wyscig~n~~w~Pozycja: ~y~12/30 ~w~CheckPoint: ~y~1/30");
		TextDrawAlignment(RaceStats[x],2);
		TextDrawBackgroundColor(RaceStats[x],0x00000033);
		TextDrawFont(RaceStats[x],1);
		TextDrawLetterSize(RaceStats[x],0.299999,1.700000);
		TextDrawColor(RaceStats[x],0xffffffff);
		TextDrawSetOutline(RaceStats[x],1);
		TextDrawSetProportional(RaceStats[x],1);
		TextDrawSetShadow(RaceStats[x],1);
        AchievementTextDraw[x] = TextDrawCreate(219.000000,298.000000,"_");
		TextDrawUseBox(AchievementTextDraw[x],1);
		TextDrawBoxColor(AchievementTextDraw[x],0x00000033);
		TextDrawTextSize(AchievementTextDraw[x],420.000000,30.000000);
		TextDrawAlignment(AchievementTextDraw[x],3);
		TextDrawBackgroundColor(AchievementTextDraw[x],0x000000ff);
		TextDrawFont(AchievementTextDraw[x],1);
		TextDrawLetterSize(AchievementTextDraw[x],0.299999,1.200000);
		TextDrawColor(AchievementTextDraw[x],0x00BFFFFF);
		TextDrawSetProportional(AchievementTextDraw[x],1);
		TextDrawSetShadow(AchievementTextDraw[x],1);
        InfoText[x] = TextDrawCreate(323.000000,381.000000,"_");
		TextDrawAlignment(InfoText[x],2);
		TextDrawBackgroundColor(InfoText[x],0x00000033);
		TextDrawFont(InfoText[x],1);
		TextDrawLetterSize(InfoText[x],0.299999,1.300000);
		TextDrawColor(InfoText[x],0xffffffff);
		TextDrawSetOutline(InfoText[x],1);
		TextDrawSetProportional(InfoText[x],1);
		TextDrawSetShadow(InfoText[x],1);
        lExp[x] = Create3DTextLabel(" ", C_GREY, 0.0, 0.0, 0.0, 25.0, 0, 0);
        lDmg[x] = Create3DTextLabel(" ", 0x00ff00FF, 0.0, 0.0, 0.0, 25.0, 0, 0);
        Player[x][gSpectateID] = -1;
        Player[x][Bombus] = -1;
    for(new o; o != sizeof gRandomPlayerSpawns; o ++)
	    new Float:change = 2.5,model = 1239,type = 1;
		CreateDynamicPickup(model, type, gRandomPlayerSpawns[o][0]+change,gRandomPlayerSpawns[o][1],gRandomPlayerSpawns[o][2], 0,  0, -1, 40.0);
		CreateDynamicPickup(model, type, gRandomPlayerSpawns[o][0]-change,gRandomPlayerSpawns[o][1],gRandomPlayerSpawns[o][2], 0,  0, -1, 40.0);
        CreateDynamicPickup(model, type, gRandomPlayerSpawns[o][0],gRandomPlayerSpawns[o][1]+change,gRandomPlayerSpawns[o][2], 0,  0, -1, 40.0);
        CreateDynamicPickup(model, type,  gRandomPlayerSpawns[o][0],gRandomPlayerSpawns[o][1]-change,gRandomPlayerSpawns[o][2], 0,  0, -1, 40.0);
		switch(random(3))
			case 0:
                CreateDynamic3DTextLabel("Chcesz zakupić konto VIP? Wpisz "W"/VIP{44a428}.", 0x44a428FF, gRandomPlayerSpawns[o][0]+change,gRandomPlayerSpawns[o][1],gRandomPlayerSpawns[o][2], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 30.0);
				//CreateDynamic3DTextLabel("Aby zrespawnować pojazd wpisz "W"/Cars"O".", 0x44a428FF, gRandomPlayerSpawns[o][0]+change,gRandomPlayerSpawns[o][1],gRandomPlayerSpawns[o][2], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 30.0);
		        CreateDynamic3DTextLabel("Wszystkie komendy znajdziesz pod "W"/CMD{44a428}.", 0x44a428FF, gRandomPlayerSpawns[o][0]-change,gRandomPlayerSpawns[o][1],gRandomPlayerSpawns[o][2], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 30.0);
		        CreateDynamic3DTextLabel("Nieznasz teleportów? Wpisz "W"/Teles{44a428}.", 0x44a428FF, gRandomPlayerSpawns[o][0],gRandomPlayerSpawns[o][1]+change,gRandomPlayerSpawns[o][2], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 30.0);
		        CreateDynamic3DTextLabel("Wszystkie atrakcje serwera pod "W"/Atrakcje{44a428}.", 0x44a428FF, gRandomPlayerSpawns[o][0],gRandomPlayerSpawns[o][1]-change,gRandomPlayerSpawns[o][2], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 30.0);
			case 1:
                CreateDynamic3DTextLabel("Chcesz doładować swój portfel? Wpisz "W"/Portfel{44a428}.", 0x44a428FF, gRandomPlayerSpawns[o][0]+change,gRandomPlayerSpawns[o][1],gRandomPlayerSpawns[o][2], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 30.0);
				CreateDynamic3DTextLabel("Nie posiadasz broni? Wpisz komendę "W"/Bronie{44a428}.", 0x44a428FF, gRandomPlayerSpawns[o][0]-change,gRandomPlayerSpawns[o][1],gRandomPlayerSpawns[o][2], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 30.0);
		        CreateDynamic3DTextLabel("Poznaj broń dnia! "W"/GunDay{44a428}.", 0x44a428FF, gRandomPlayerSpawns[o][0],gRandomPlayerSpawns[o][1]+change,gRandomPlayerSpawns[o][2], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 30.0);
		        CreateDynamic3DTextLabel("Wszystkie atrakcje serwera pod "W"/Atrakcje{44a428}.", 0x44a428FF, gRandomPlayerSpawns[o][0],gRandomPlayerSpawns[o][1]-change,gRandomPlayerSpawns[o][2], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 30.0);
			case 2:
                CreateDynamic3DTextLabel("Szukasz gangu? Wpisz komendę "W"/Gang{44a428} :)", 0x44a428FF, gRandomPlayerSpawns[o][0]+change,gRandomPlayerSpawns[o][1],gRandomPlayerSpawns[o][2], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 30.0);
				CreateDynamic3DTextLabel("Nie posiadasz broni? Wpisz komendę "W"/Bronie{44a428}.", 0x44a428FF, gRandomPlayerSpawns[o][0]-change,gRandomPlayerSpawns[o][1],gRandomPlayerSpawns[o][2], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 30.0);
		        CreateDynamic3DTextLabel("Prywatny pojazd? Tylko u nas "W"/Pojazd{44a428}.", 0x44a428FF, gRandomPlayerSpawns[o][0],gRandomPlayerSpawns[o][1]+change,gRandomPlayerSpawns[o][2], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 30.0);
		        CreateDynamic3DTextLabel("Wszystkie atrakcje serwera pod "W"/Atrakcje{44a428}.", 0x44a428FF, gRandomPlayerSpawns[o][0],gRandomPlayerSpawns[o][1]-change,gRandomPlayerSpawns[o][2], 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 30.0);
    TextBalonLV[0] = CreateDynamic3DTextLabel(""G"[Balon]\n"W"Balon wylatuje do wojska.",0xFFFFFFFF,2177.6726,944.3609,15.8062, 40.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 40.0);
    TextBalonLV[1] = CreateDynamic3DTextLabel(""G"[Balon]\n"W"Balon przylatuje z LV.",0xFFFFFFFF,197.7027,1879.5608,17.7562, 40.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 40.0);
    CreateDynamic3DTextLabel(""B"[Spadochron]\n"W"Wpisz /Parachute.",0xFFFFFFFF,4026.5078,-1940.8304,2382.1765, 40.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 40.0);
    CreateDynamic3DTextLabel(""Y"Witamy na arenie solówek!\n\n"W"Aby kogos wyzwać wpisz /Solowyzwij.",0xFFFFFFFF,-1476.9022,352.5599,35.7872, 40.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 40.0);
    CreateDynamic3DTextLabel(""Y"Klatka solówek\n\n"W"Tutaj odbywają się solówki.",0xFFFFFFFF,-1407.2821,388.9196,36.5097, 40.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 40.0);
    CreateDynamic3DTextLabel(""Y"["W"Przygotuj"Y"]",0xFFFFFFFF,3626.0090,-1761.8671,230.4747, 40.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 40.0);
	CreateDynamic3DTextLabel(""Y"["W"się"Y"]",0xFFFFFFFF,3552.8623,-1761.7328,184.9313, 40.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 50.0);
    CreateDynamic3DTextLabel(""Y"["W"na"Y"]",0xFFFFFFFF,3489.5400,-1761.5603,145.3976, 40.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 50.0);
    CreateDynamic3DTextLabel(""Y"["W"odbicie!"Y"]",0xFFFFFFFF,3409.7195,-1761.6958,95.5887, 40.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 50.0);
    CreateDynamic3DTextLabel(""O"[Żołnierz]\n"W"Dołącz do wojska.",0xFFFFFFFF,23.7660,1864.5850,19.9094, 40.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 40.0);
    brama = CreateObject(980,1534.6999512,2773.5000000,12.5000000,0.0000000,0.0000000,90.0000000); //Pozycja bramy zamkniętej lub otwartej, zależy jaką chcemy mieć przy odpaleniu serwera.
    print("[GoldServer] Elementy graficzne zostaly zaladowane.");
	print("[GoldServer] Przygotowywanie do procesu ladowania domow...");
	LoadHouses();
	print("[GoldServer] Przygotowywanie do procesu ladowania biznesow...");
	LoadBiznes();
    print("[GoldServer] Przygotowywanie do procesu ladowania gangow..");
	LoadGangs();
    SetTimer("VehicleUpdateAndMain", 499, true);
	SetTimer("TimerSekunda",1000,true);
    SetTimer("Spam",2650,true);
	SetTimer("PlayerUpdate",5000,true);
    SetTimer("Timer10Minut",600000,true);
	SetTimer("TimerMinuta",59500,true);
	SetTimer("RespektScore",72000, true);
    SetTimer("TimerGodzina",3600000,true);
    TimerReaction = SetTimer("ReactionTest", 600000, false);
    print("[GoldServer] Timery serwera wystartowały.");
    CreateDynamicEntrance(1,19135,-1479.7813,311.1683,7.1875,"Arena Solo",0); //Arena Solo Wejście
    CreateDynamicEntrance(2,19135,-1480.1351,347.0241,30.0820,"null",0); //Arena Solo Wyjście
    print("[GoldServer] Dynamiczne wejscia stworzone.");
	//Pojazdy serwera
	DerbyCar[0] = AddStaticVehicle(444,-189.3335,-612.0821,63.7825,272.4385,32,32); //
	DerbyCar[1] = AddStaticVehicle(444,-128.6777,-610.3533,47.9714,91.0741,32,36); //
	DerbyCar[2] = AddStaticVehicle(444,-158.3339,-578.9396,55.7017,179.7889,32,14); //
	DerbyCar[3] = AddStaticVehicle(444,-155.7805,-641.2036,55.0360,6.9555,32,53); //
	DerbyCar[4] = AddStaticVehicle(444,-188.1995,-599.5789,63.4914,248.7901,32,36); //
	DerbyCar[5] = AddStaticVehicle(444,-131.2628,-621.7962,48.6449,69.8603,32,32); //
	DerbyCar[6] = AddStaticVehicle(444,-147.0963,-582.7581,52.7723,159.0907,32,42); //
	DerbyCar[7] = AddStaticVehicle(444,-165.7696,-640.3754,57.6418,343.8235,32,53); //
	DerbyCar[8] = AddStaticVehicle(444,-185.9509,-624.5323,62.9007,295.9437,32,42); //
	DerbyCar[9] = AddStaticVehicle(444,-131.8944,-599.3342,48.8112,113.5459,32,53); //
	DerbyCar[10] = AddStaticVehicle(444,-169.0654,-582.7039,58.5010,202.8040,32,14); //
	DerbyCar[11] = AddStaticVehicle(444,-147.1512,-636.6563,52.7866,22.6119,32,66); //
	DerbyCar[12] = AddStaticVehicle(444,-178.5293,-636.4559,60.9678,323.1482,32,66); //
	DerbyCar[13] = AddStaticVehicle(444,-137.0095,-589.4589,50.1445,137.5518,32,42); //
	DerbyCar[14] = AddStaticVehicle(444,-181.1408,-587.8377,61.6472,222.2664,32,66); //
	DerbyCar[15] = AddStaticVehicle(444,-139.0930,-631.4850,50.6860,43.4002,32,14); //
    DerbyCar2[0] = AddStaticVehicle(415,-4243.60600000,-2194.44920000,4.10000000,0.00000000,-1,-1); //Cheetah
	DerbyCar2[1] = AddStaticVehicle(415,-4216.15230000,-2194.25980000,4.10000000,0.00000000,-1,-1); //Cheetah
	DerbyCar2[2] = AddStaticVehicle(415,-4123.53170000,-2136.46750000,4.10000000,90.00000000,-1,-1); //Cheetah
	DerbyCar2[3] = AddStaticVehicle(415,-4122.97460000,-2098.07810000,4.10000000,90.00000000,-1,-1); //Cheetah
	DerbyCar2[4] = AddStaticVehicle(415,-4177.14060000,-2049.82180000,4.10000000,180.00000000,-1,-1); //Cheetah
	DerbyCar2[5] = AddStaticVehicle(415,-4216.27150000,-2048.88840000,4.10000000,180.00000000,-1,-1); //Cheetah
	DerbyCar2[6] = AddStaticVehicle(415,-4244.15330000,-2047.93620000,4.10000000,180.00000000,-1,-1); //Cheetah
	DerbyCar2[7] = AddStaticVehicle(415,-4303.24370000,-2069.59520000,4.10000000,270.00000000,-1,-1); //Cheetah
	DerbyCar2[8] = AddStaticVehicle(415,-4294.32910000,-2169.87600000,4.10000000,270.00000000,-1,-1); //Cheetah
	DerbyCar2[9] = AddStaticVehicle(415,-4144.36670000,-2191.07370000,4.10000000,0.00000000,-1,-1); //Cheetah
	DerbyCar2[10] = AddStaticVehicle(415,-4330.69970000,-2202.42260000,4.10000000,270.00000000,-1,-1); //Cheetah
	DerbyCar2[11] = AddStaticVehicle(415,-4277.13920000,-2250.12480000,4.10000000,0.00000000,-1,-1); //Cheetah
	DerbyCar2[12] = AddStaticVehicle(415,-4177.63040000,-2253.71360000,4.10000000,0.00000000,-1,-1); //Cheetah
	DerbyCar2[13] = AddStaticVehicle(415,-4091.69290000,-2235.64620000,4.10000000,90.00000000,-1,-1); //Cheetah
	DerbyCar2[14] = AddStaticVehicle(415,-4090.64360000,-2189.10060000,4.10000000,90.00000000,-1,-1); //Cheetah
	DerbyCar2[15] = AddStaticVehicle(415,-4144.53660000,-2049.62430000,4.10000000,180.00000000,-1,-1); //Cheetah
    //KSS
	LinkVehicleToInterior(
	AddStaticVehicle(444,-1492.4644,1621.9382,1052.9025,270.3307,32,14),14); //
	LinkVehicleToInterior(
	AddStaticVehicle(468,-1493.8662,1607.5486,1052.1970,271.0642,3,3),14); //
	LinkVehicleToInterior(
	AddStaticVehicle(468,-1494.0038,1608.9308,1052.1760,273.6895,6,6),14); //
	LinkVehicleToInterior(
	AddStaticVehicle(468,-1494.1541,1610.4962,1052.1995,278.0568,46,46),14);//
	LinkVehicleToInterior(
	AddStaticVehicle(522,-1494.0809,1612.6964,1052.0991,275.1321,3,8),14); //
	LinkVehicleToInterior(
	AddStaticVehicle(522,-1493.8159,1614.7366,1052.1011,268.8207,3,8),14); //
	LinkVehicleToInterior(
	AddStaticVehicle(522,-1493.8563,1616.8672,1052.1039,272.0705,3,8),14); //
//DB
	LinkVehicleToInterior(
	AddStaticVehicle(468,-1437.9542,-646.6154,1050.0419,248.6400,53,53),4); //
	LinkVehicleToInterior(
	AddStaticVehicle(468,-1437.4786,-645.0378,1049.7626,248.6887,3,3),4); //
	LinkVehicleToInterior(
	AddStaticVehicle(468,-1437.0680,-643.5625,1049.5391,247.1457,6,6),4); //
	LinkVehicleToInterior(
	AddStaticVehicle(468,-1436.2480,-642.2493,1049.4943,257.7117,46,46),4); //
	LinkVehicleToInterior(
	AddStaticVehicle(471,-1436.2731,-639.8793,1048.7136,250.3959,103,111),4); //
	LinkVehicleToInterior(
	AddStaticVehicle(471,-1435.1364,-635.9240,1049.1923,250.2289,74,91),4); //
	LinkVehicleToInterior(
	AddStaticVehicle(471,-1435.6688,-637.8844,1048.6672,250.8790,120,114),4); //
//DD
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1352.9280,938.3043,1036.2068,17.7235,57,38), 15); // dd:auto-1
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1490.0773,952.5486,1036.6932,331.2003,14,1), 15); // dd-auto
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1499.1383,961.6018,1036.8599,321.4333,65,9), 15); // dd-auto
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1505.7516,972.4949,1037.0544,301.0165,34,9), 15); // dd-auto
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1511.3676,986.8600,1037.3036,294.6465,45,29), 15); // dd-auto
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1512.7253,999.1296,1037.5059,263.3817,57,38), 15); // dd-auto
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1507.5730,1017.6364,1037.8011,241.7172,51,39), 15); // dd-auto
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1499.8105,1027.1980,1037.9489,228.5874,26,1), 15); // dd-auto
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1484.5031,1038.5229,1038.1136,215.4444,12,9), 15); // dd-auto
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1469.1527,1045.6360,1038.1989,212.7548,14,1), 15); // dd-auto
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1453.5883,1051.7992,1038.2715,202.6581,65,9), 15); // dd-auto
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1435.9102,1055.0287,1038.3020,199.4608,34,9), 15); // dd-auto
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1417.3086,1056.3545,1038.2883,187.5230,45,29), 15); // dd-auto
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1397.2771,1056.7366,1038.2618,185.7977,57,38), 15); // dd-auto
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1380.6863,1057.2357,1038.2456,181.8720,51,39), 15); // dd-auto
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1365.6376,1055.9902,1038.1979,180.2804,26,1), 15); // dd-auto
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1344.1788,1052.7750,1038.1049,174.5971,12,9), 15); // dd-auto
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1325.6730,1047.2588,1037.9476,154.9616,14,1), 15); // dd-auto
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1307.6199,1034.2521,1037.7346,156.8991,65,9), 15); // dd-auto
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1293.9332,1020.8791,1037.4844,138.6608,34,9), 15); // dd-auto
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1285.2561,1001.3178,1037.1443,110.3759,51,39), 15); // dd-auto
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1285.2317,989.4346,1036.9491,89.2480,45,29), 15); // dd-auto
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1296.1692,967.5569,1036.5953,74.3806,26,1), 15); // dd-auto
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1313.5422,953.1486,1036.3883,63.7932,34,9), 15); // dd-auto
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1329.2750,944.7968,1036.2806,53.3132,12,9), 15); // dd-auto
	LinkVehicleToInterior(
	AddStaticVehicle(504,-1352.9280,938.3043,1036.2068,17.7226,57,38), 15); // dd-auto
	for(new x=0;x<16;x++)
		SetVehicleVirtualWorld(DerbyCar[x],2);
        SetVehicleVirtualWorld(DerbyCar2[x],2);
	//Pociagi
	AddStaticVehicle(537,2853.6042,1185.6418,12.2245,338.5605,1,1); // pociąg towarowy
	AddStaticVehicle(537,2815.8640,1109.3875,12.3495,329.9603,1,1); // pociąg towarowy
	AddStaticVehicle(537,2771.4868,1043.4888,12.9124,331.8430,1,1); // pociąg towarowy
    // Zjazd
	CreateVehicle(411,1201.59830000,2229.84840000,511.71240000,163.97250000,116,1,5); //Infernus
	CreateVehicle(411,1193.59690000,2201.99410000,511.71240000,163.96770000,116,1,5); //Infernus
	CreateVehicle(411,1174.99910000,2206.47780000,511.71240000,343.94580000,116,1,5); //Infernus
	CreateVehicle(411,1183.20730000,2235.00150000,511.71240000,343.94580000,116,1,5); //Infernus
	//PKS
	CreateVehicle(431,1091.62440000,1341.04930000,10.91320000,237.40990000,75,59,10); //Bus
	CreateVehicle(431,1091.14450000,1329.47220000,10.92480000,234.73550000,59,83,10); //Bus
	CreateVehicle(431,1091.42600000,1316.71740000,10.92070000,232.74580000,71,87,10); //Bus
	CreateVehicle(431,1091.64320000,1303.64760000,10.92450000,235.18990000,47,74,10); //Bus
	CreateVehicle(431,1092.39330000,1290.66270000,10.92180000,233.13520000,92,72,10); //Bus
	//Gokart ---------------------------------------------------
	CreateVehicle(571,-434.31020000,1188.75240000,1.00560000,278.43910000,1,1,1); //Kart
	CreateVehicle(571,-437.53370000,1188.25500000,1.00590000,279.61720000,1,1,1); //Kart
	CreateVehicle(571,-440.76970000,1187.81140000,1.00600000,279.41700000,1,1,1); //Kart
	CreateVehicle(571,-434.57000000,1190.88670000,1.00590000,277.74600000,1,1,1); //Kart
	CreateVehicle(571,-437.87070000,1190.42300000,1.00600000,278.73140000,1,1,1); //Kart
	CreateVehicle(571,-441.13780000,1189.95390000,1.00600000,278.57760000,1,1,1); //Kart
	CreateVehicle(571,-434.87670000,1193.38720000,1.00610000,278.56120000,1,1,1); //Kart
	CreateVehicle(571,-438.18060000,1192.96750000,1.00590000,277.49150000,1,1,1); //Kart
	CreateVehicle(571,-441.54340000,1192.50740000,1.00590000,278.43470000,1,1,1); //Kart
	//Tube
	CreateVehicle(402,64.68600000,2412.09010000,83.80400000,-90.00000000,-1,-1,1); //Buffalo
	CreateVehicle(411,64.80790000,2416.30860000,83.80400000,-90.00000000,-1,-1,1); //Infernus
	CreateVehicle(415,65.05310000,2421.03880000,83.80400000,-90.00000000,-1,-1,1); //Cheetah
	CreateVehicle(424,65.10320000,2426.11720000,83.80400000,-90.00000000,-1,-1,1); //BF Injection
	CreateVehicle(429,65.05910000,2430.46460000,83.80400000,-90.00000000,-1,-1,1); //Banshee
	CreateVehicle(434,64.99440000,2435.47310000,83.80400000,-90.00000000,-1,-1,1); //Hotknife
	CreateVehicle(451,65.48870000,2440.32420000,83.80400000,-90.00000000,-1,-1,1); //Turismo
	CreateVehicle(461,65.38330000,2445.39820000,83.80400000,-90.00000000,-1,-1,1); //PCJ-600
	//Stunt
	CreateVehicle(494,1728.70790000,-2661.39160000,13.44230000,89.41990000,36,13,5); //Hotring
	CreateVehicle(502,1728.99080000,-2664.33200000,13.43850000,91.54120000,36,88,5); //Hotring Racer A
	CreateVehicle(503,1728.89490000,-2667.66550000,13.44120000,89.84400000,87,75,5); //Hotring Racer B
	CreateVehicle(522,1706.05430000,-2643.57280000,13.11540000,265.15680000,-1,1,5); //NRG-500
	CreateVehicle(522,1706.06540000,-2644.42380000,13.11620000,265.23430000,3,3,5); //NRG-500
	CreateVehicle(522,1706.08700000,-2645.13940000,13.11680000,269.31070000,3,8,5); //NRG-500
	CreateVehicle(522,1706.06820000,-2646.01930000,13.12000000,270.52990000,6,25,5); //NRG-500
	CreateVehicle(522,1706.13920000,-2646.82420000,13.11670000,267.40560000,7,79,5); //NRG-500
	CreateVehicle(522,1706.06570000,-2647.77200000,13.11920000,271.84630000,8,82,5); //NRG-500
	CreateVehicle(522,1706.04770000,-2648.75830000,13.11810000,269.71750000,36,105,5); //NRG-500
	CreateVehicle(522,1706.04130000,-2649.64210000,13.11740000,268.44790000,39,106,5); //NRG-500
	CreateVehicle(411,1707.43640000,-2652.96560000,13.27430000,273.39650000,116,1,5); //Infernus
	CreateVehicle(411,1707.47230000,-2657.09770000,13.27520000,274.76410000,112,1,5); //Infernus
	CreateVehicle(556,1728.80640000,-2649.64230000,13.92450000,88.05070000,1,1,5); //Monster A
	CreateVehicle(557,1728.88810000,-2654.23660000,13.92190000,93.06060000,1,1,5); //Monster B
	CreateVehicle(471,1705.77550000,-2662.28300000,13.02640000,270.74550000,120,114,5); //Quad
	//LV
	AddStaticVehicle(411,2120.0310,2391.0613,23.3891,272.3686,116,1); //
	AddStaticVehicle(542,2120.5151,2386.7197,23.4085,271.0517,32,92); //
	AddStaticVehicle(444,2129.3706,2394.0835,24.0333,181.0053,32,42); //
	AddStaticVehicle(556,2134.3479,2394.1133,24.0370,177.6361,1,1); //
	AddStaticVehicle(522,2118.9866,2377.2107,23.2350,265.4512,3,3); //
	AddStaticVehicle(468,2118.7085,2375.2061,23.3343,266.2809,46,46); //
	AddStaticVehicle(509,2138.5244,2377.5334,23.1715,143.8098,74,1); //
	AddStaticVehicle(471,2140.3445,2376.5527,23.1429,148.3700,103,111); //
	AddStaticVehicle(586,2142.1252,2374.8613,23.1822,153.1551,122,1); //
	AddStaticVehicle(411,2119.8306,2371.9917,23.3907,269.6763,106,1); //
	//Pojazdy baza2 By Haker
	AddStaticVehicle(411,-31.7872,-296.9952,5.1568,270.3548,80,1); //
	AddStaticVehicle(411,-32.0684,-290.2795,5.1552,271.4906,75,1); //
	AddStaticVehicle(411,-32.3426,-283.4390,5.1533,270.3608,12,1); //
	AddStaticVehicle(411,-32.6501,-276.6409,5.1499,270.6209,64,1); //
	AddStaticVehicle(520,-56.2855,-314.3882,8.6899,270.9465,0,0); //
	AddStaticVehicle(522,-31.7516,-293.6053,4.9940,269.4690,39,106); //
	AddStaticVehicle(522,-32.1380,-286.7272,4.9999,273.2685,51,118); //
	AddStaticVehicle(522,-32.2250,-279.9850,4.9951,269.2466,3,3); //
	AddStaticVehicle(522,-43.6436,-377.3857,4.9900,180.2418,3,8); //
	AddStaticVehicle(471,-49.7988,-377.2050,4.9110,181.1604,120,112); //
	AddStaticVehicle(556,-56.5489,-376.0706,5.8047,179.8025,1,1); //
	AddStaticVehicle(562,-46.6063,-377.6372,5.0875,180.7040,116,1); //
	AddStaticVehicle(521,-52.9265,-376.6219,4.9949,179.4065,75,13); //
	//pojazdy na /szklo
	CreateVehicle(402,1724.7078000,-1756.0773000,979.0060000,134.2953000,-1,-1,2); //Buffalo
	CreateVehicle(402,1726.8396000,-1758.5685000,979.0060000,134.1398000,-1,-1,2); //Buffalo
	CreateVehicle(402,1740.4576000,-1772.0128000,979.0060000,132.5276000,-1,-1,2); //Buffalo
	CreateVehicle(402,1749.5966000,-1781.0044000,979.0060000,136.9123000,-1,-1,2); //Buffalo
	CreateVehicle(402,1747.3260000,-1778.8901000,979.0060000,135.6423000,-1,-1,2); //Buffalo
	CreateVehicle(402,1744.8451000,-1776.5823000,979.0060000,133.1735000,-1,-1,2); //Buffalo
	CreateVehicle(424,1761.4193000,-1810.0198000,978.9550000,47.2133000,-1,-1,2); //BF Injection
	CreateVehicle(424,1757.1620000,-1814.2855000,978.9567000,45.9550000,-1,-1,2); //BF Injection
	CreateVehicle(424,1752.9105000,-1818.3904000,978.9550000,47.2331000,-1,-1,2); //BF Injection
	CreateVehicle(439,1716.9840000,-1790.9198000,979.0699000,315.5244000,-1,-1,2); //Stallion
	CreateVehicle(439,1712.9698000,-1785.8019000,979.0690000,316.4672000,-1,-1,2); //Stallion
	CreateVehicle(539,1697.6017000,-1769.4202000,978.5333000,215.9162000,-1,-1,2); //Vortex
	//Pojazd na /Baza1
    AddStaticVehicle(560,2115.5491,1625.4564,10.5236,119.5742,6,0); //
    AddStaticVehicle(522,2107.9795,1568.8569,10.3939,86.0207,54,62); //
	//pojazdy na /tor2
	CreateVehicle(494,-1487.5239000,691.4603000,7.0753000,90.3391000,-1,-1,5); //Hotring
	CreateVehicle(494,-1486.9136000,696.2278000,7.0748000,90.3011000,-1,-1,5); //Hotring
	CreateVehicle(494,-1487.8604000,702.5979000,7.0747000,88.2661000,-1,-1,5); //Hotring
	CreateVehicle(494,-1487.2626000,707.0149000,7.0747000,89.4515000,-1,-1,5); //Hotring
	//pojazdy na /woda
	CreateVehicle(539,2338.9087000,-266.8125000,1148.1498000,348.7639000,-1,-1,1); //Vortex
	//Pojazdy na /Zjazd3
	CreateVehicle(411,263.2791000,-950.6171000,470.4791000,0.8294000,-1,-1,2); //Infernus
	CreateVehicle(411,272.8048000,-950.3740000,470.4715000,0.6484000,-1,-1,2); //Infernus
	CreateVehicle(411,282.5271000,-950.4838000,470.4715000,358.0695000,-1,-1,2); //Infernus
	CreateVehicle(411,292.0658000,-950.5536000,470.4715000,359.4301000,-1,-1,2); //Infernus
	CreateVehicle(411,300.1464000,-922.5526000,470.4714000,181.2887000,-1,-1,2); //Infernus
	CreateVehicle(411,282.5329000,-920.5471000,470.4714000,178.9334000,-1,-1,2); //Infernus
	//pojazdy na /nascar
    CreateVehicle(502,1952.8441000,-6667.4849000,21.1534000,357.0677000,-1,-1,3); //Hotring Racer A
	CreateVehicle(502,1953.0117000,-6659.0874000,21.1458000,359.8882000,-1,-1,3); //Hotring Racer A
	CreateVehicle(494,1953.2491000,-6646.3013000,21.1450000,358.5279000,-1,-1,3); //Hotring
	CreateVehicle(494,1953.3956000,-6634.5176000,21.1451000,2.1351000,-1,-1,3); //Hotring
	//Pojazdy na /warsztat
	CreateVehicle(525,-1560.38770000,-2740.29130000,48.42120000,145.19880000,-1,-1,5); //Tow Truck
	CreateVehicle(525,-1569.00100000,-2734.64160000,48.42450000,144.77620000,-1,-1,5); //Tow Truck
	CreateVehicle(463,-1616.32040000,-2695.79860000,48.07700000,147.85570000,-1,-1,5); //Freeway
	//Pojazdy na /domek
	AddStaticVehicle(522,1367.2335,-464.9336,52.9739,243.2826,39,106); //
	//Pojazdy na /pipe
	AddStaticVehicle(539,1393.8579,-2449.5710,524.9896,0.7019,70,86); //
	AddStaticVehicle(539,1389.2224,-2407.6904,524.9879,183.8092,6,0); //
	AddStaticVehicle(539,1377.4915,-2428.8428,524.9913,273.8578,8,0); //
	AddStaticVehicle(539,1410.8489,-2441.8416,524.9913,92.0648,8,0); //
	AddStaticVehicle(539,1386.7704,-2449.2656,524.9911,359.2145,8,0); //
	//Pojazdy na /wyspa2
	AddStaticVehicle(452,743.5690,-2807.0391,-0.4879,19.0319,1,5); //
	AddStaticVehicle(452,818.5233,-2750.1416,-0.9433,352.9289,1,5); //
	//Pojazdy na /gora
	CreateVehicle(560,-2347.32960000,-1605.39790000,483.34790000,248.45390000,6,6,7); //Sultan
	CreateVehicle(560,-2350.94950000,-1613.10360000,483.34060000,256.48930000,3,3,7); //Sultan
	CreateVehicle(593,-2337.17240000,-1662.19760000,484.12860000,315.58070000,58,8,7); //Dodo
	CreateVehicle(476,-2319.41870000,-1681.19850000,483.06710000,320.61390000,7,6,7); //Rustler
	CreateVehicle(522,-2290.16890000,-1663.39950000,482.33110000,76.97500000,51,118,7); //NRG-500
	CreateVehicle(522,-2289.05830000,-1666.80940000,482.16880000,73.75000000,6,6,7); //NRG-500
    AddStaticVehicle(497,2128.1907,932.2115,10.9970,88.8267,0,1); // Helikopter na /LV
    AddStaticVehicle(487,2249.4080,1119.7999,33.6995,151.8078,6,0); // Helikopter na /LV na górze
    //Stunt w SF
    AddStaticVehicle(513,-1347.3307,-240.3823,14.7055,226.2546,44,0); //
	AddStaticVehicle(522,-1355.6545,-246.0852,13.6961,224.2868,6,0); //
	AddStaticVehicle(522,-1358.7405,-248.2687,13.7177,229.2748,2,0); //
	//Wojsko
	CreateVehicle(425,345.92100000,1911.01100000,18.70500000,72.27530000,43,-1,10); //Hunter
	CreateVehicle(425,348.28410000,1928.55490000,18.69210000,75.52490000,43,-1,10); //Hunter
	CreateVehicle(425,352.26090000,1948.83810000,18.69900000,82.53540000,43,-1,10); //Hunter
	CreateVehicle(433,355.63490000,1968.98690000,18.07690000,89.27550000,43,-1,10); //Barracks
	CreateVehicle(433,355.59500000,1974.69230000,18.15780000,91.46480000,43,-1,10); //Barracks
	CreateVehicle(470,328.36060000,1983.41110000,17.57430000,84.03630000,43,-1,10); //Patriot
	CreateVehicle(470,329.01840000,1990.02270000,17.57490000,82.68330000,43,-1,10); //Patriot
	CreateVehicle(432,277.19050000,1958.40520000,17.82510000,271.06120000,43,-1,10); //Rhino
	CreateVehicle(432,278.37870000,2024.27360000,17.82760000,273.40780000,43,-1,10); //Rhino
	CreateVehicle(520,303.08940000,2056.16800000,18.36380000,176.84820000,-1,-1,10); //Hydra
	CreateVehicle(520,315.41660000,2056.83670000,18.32010000,175.34610000,-1,-1,10); //Hydra
	CreateVehicle(476,200.15310000,1951.15260000,18.34720000,305.78390000,7,6,10); //Rustler
	CreateVehicle(568,192.15070000,1996.50870000,17.50970000,271.55370000,9,39,10); //Bandito
	//Salon SF i /SF autobus
	AddStaticVehicle(437,-1992.9752,145.5421,27.6726,180.7467,87,7); //
	AddStaticVehicle(562,-1989.6091,275.6466,34.8321,267.2755,6,3); //
	AddStaticVehicle(439,-1990.9313,263.9406,35.0705,265.3597,2,2); //
	AddStaticVehicle(560,-1947.5863,264.7843,35.1769,41.7000,55,55); //
	//Dodatkowe pojazdy na /LV
    AddStaticVehicle(480,2202.3589,936.5234,10.5930,182.8428,6,6); //
	AddStaticVehicle(448,2197.1846,924.4677,10.4194,271.5142,3,6); //
	AddStaticVehicle(448,2196.5415,927.1602,10.4194,271.8966,3,6); //
	AddStaticVehicle(571,2171.7424,1016.0912,10.1039,91.0275,36,2); //
	AddStaticVehicle(523,2131.9275,1025.7759,10.3912,269.4667,0,0); //
	AddStaticVehicle(539,2163.4331,952.1673,15.0320,273.0404,79,74); //
	AddStaticVehicle(539,2163.7180,932.6743,15.0329,269.1725,8,2); //
	//Pojazdy do willi
    AddStaticVehicle(402,1490.5803,-689.8135,94.5817,181.0937,13,13); //
	//Motory na /tornrg
	CreateVehicle(522,3111.42820000,-1993.64150000,22.59870000,0.15280000,39,106,15); //NRG-500
	CreateVehicle(522,3114.64650000,-1993.64820000,22.60110000,1.44750000,6,1,15); //NRG-500
	CreateVehicle(522,3088.99120000,-1973.65480000,22.61480000,181.24040000,51,118,15); //NRG-500
	CreateVehicle(522,3089.21800000,-2004.05750000,22.61540000,0.07530000,8,1,15); //NRG-500
	//Pojazdy na /bagno
	CreateVehicle(495,-863.68770000,-1991.78100000,19.33900000,285.58510000,119,122,8); //Sandking
	CreateVehicle(495,-867.20620000,-1985.05630000,18.70420000,299.35060000,-1,1,8); //Sandking
	CreateVehicle(495,-868.44840000,-1979.90910000,18.17210000,289.97130000,9,-1,8); //Sandking
	CreateVehicle(539,-808.41940000,-1930.30900000,6.00800000,229.77950000,61,98,8); //Vortex
	CreateVehicle(539,-788.79710000,-1953.34730000,5.67350000,335.12940000,-1,1,8); //Vortex
	//Pojazdy na /plaza
	AddStaticVehicle(424,287.8593,-1879.3362,1.8954,176.5971,3,2); //
	//Pojazdy na /molo
	AddStaticVehicle(462,850.7995,-1867.4626,12.4662,89.7378,12,12); //
	AddStaticVehicle(462,850.7023,-1924.8486,12.4664,88.8904,6,0); //
	AddStaticVehicle(462,851.1052,-1977.0779,12.4659,92.5123,4,0); //
	AddStaticVehicle(462,822.1592,-2005.0697,12.4658,269.6569,7,0); //
	//Pojazdy na /Tereno
	CreateVehicle(495,2903.73730000,1689.26920000,11.17200000,104.84680000,6,-1,15); //Sandking
	CreateVehicle(495,2906.43360000,1678.07020000,11.20250000,111.39300000,5,-1,15); //Sandking
	//Pojazdy na /miniport
	CreateVehicle(454,1072.62260000,-2685.22920000,0.26600000,1.28280000,26,26,3); //Tropic
	new total_vehicles_from_files=0;
	total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/lv_law.txt");
	total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/lv_airport.txt");
	total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/lv_gen.txt");
	total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/sf_law.txt");
	total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/ls_law.txt");
	total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/ls_gen_inner.txt");
	total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/ls_gen_outer.txt");
	total_vehicles_from_files += LoadStaticVehiclesFromFile("vehicles/red_county.txt");
	printf("[GoldServer] Zaladowano %d pojazdow z pliku i inne.",total_vehicles_from_files);
    BalonLV = CreateObject(19335, 2177.63, 944.26, 14.66,   0.00, 0.00, 0.00);
	//Obiekty serwera:
	//skocznia adama małysza
	AddStaticVehicleEx(559,3423.2045898,50.9771118,212.6306152,0.0000000,-1,-1,15); //Jester
	//Dodatkowe obiekty na /wojsko
	//Zjazd 3 zjazd3 zjazd /zjazd3 /zjazd
	//Tor wyscigowy race na sf san fierro torsf tor2
	//Wodospad
	//Woda
	//Szkło
	//STATEK2
	//Odbij
    CreateVehicle(480,3641.46362305,-1773.09106445,234.34071350,0.00000000,-1,-1,5); //Comet
    CreateVehicle(506,3645.22900391,-1772.92065430,234.28282166,0.00000000,-1,-1,5); //Super GT
    //Parkour
	//rury obiekty 0.3c nad /lv las venturas lv
    //Kulki
	CreateVehicle(444,-1793.87290000,544.04140000,235.26040000,59.49970000,32,66,7); //Monster
	CreateVehicle(444,-1789.53770000,552.18040000,235.25900000,62.18110000,32,66,7); //Monster
	CreateVehicle(444,-1818.50600000,545.83610000,235.26010000,297.81580000,32,66,7); //Monster
	CreateVehicle(444,-1823.40320000,552.86550000,235.26030000,306.09060000,32,66,7); //Monster
	CreateVehicle(444,-1818.64180000,576.05190000,235.26190000,208.73290000,32,66,7); //Monster
	CreateVehicle(444,-1801.70390000,576.42770000,235.26130000,177.38800000,32,66,7); //Monster
	//Sky SkyDive /Sky /SkyDive
	//Chilliad
	//Baza obok kasyna casina calligula calliguli calligulas caliguli 2 kasyno
    // Zjazd2
    // Zjazd
	//Obiekty przystosowane do balonów w LV i barierki na ammunation na lv
    // Tor
	//Fence barierki na /LV Las Venturas
	//Wyspa3
    AddStaticVehicle(487,3424.7156,2356.6560,6.3602,93.7533,29,42); //Maverick
    AddStaticVehicle(539,3489.4153,2268.6064,1.6724,4.3987,86,70); //Vortex
	AddStaticVehicle(539,3418.9685,2303.8342,4.6507,306.9218,86,70); //Vortex
	AddStaticVehicle(539,3336.5613,2321.3750,2.1492,70.0882,86,70); //Vortex
	/*
	Objects converted: 406
	Vehicles converted: 0
	Vehicle models found: 0
	----------------------
	In the time this conversion took to finish the US national debt has risen by about $1,601.14!
	*/
	//Warsztat2
	/*
	Objects converted: 64
	Vehicles converted: 0
	Vehicle models found: 0
	----------------------
	In the time this conversion took to finish 0.01 micro-fortnights have passed!
	*/
/*
	//obiekty na ls los santos obiekty ls
*/
	//Obiekty na /Drift3 Nowe DH Driftu z barierkami i kwiatami
	//Dorabiane na afganistanie i obok wojska adama
    //WOJSKO ADAMA
    // Wysćigowy stadion NASCAR
    //Alcatraz - obiekty więzienia w /jail
	//Drift 8
	AddStaticVehicle(562,1104.68180000,1357.11720000,10.73890000,270.00000000,-1,-1); //Elegy
	AddStaticVehicle(562,1104.94700000,1346.11450000,10.73890000,270.00000000,-1,-1); //Elegy
	//Warsztat
	//Zioło Ziolo /Ziolo /Zioło marichuana pole maryśki
	AddStaticVehicle(532,732.31250000,-114.28027344,22.10971832,1.99951172,-1,-1); //Combine
	AddStaticVehicle(532,723.26043701,-114.80392456,22.10971832,1.99951172,-1,-1); //Combine
	AddStaticVehicle(609,727.05303955,-127.12979889,21.19417572,0.00000000,-1,-1); //Boxville
	AddStaticVehicle(499,721.06549072,-126.66499329,21.09097672,0.00000000,-1,-1); //Benson
	AddStaticVehicle(463,747.53631592,-118.52293396,21.50051880,0.00000000,-1,-1); //Freeway
	//----
	//----
	//Las na las venturas obiekty na lv
	//Las Venturas /LV baza zamiast remove building
    CreateVehicle(470, 2109.5696, 893.6804, 10.7962, 0.0000, -1, -1, 100);
	CreateVehicle(470, 2122.4268, 893.9872, 10.7962, 0.0000, -1, -1, 100);
	//Derby arena 2
	//Arena Solo
	//domek na ls
	//Wyspa
	//czarnobyl
	//restauracja
	//Stunt SF Lot
	//TorNrg
	//LV Centrum.................
	//Bagno
	//minigun
	//skyroad
	//PKS
	//gokart
	//LS-lot -Stunt
	//Tube
	// Wyspa
	// Freeway
	//Domek.na.drzewie
	//Patfinder Tereno 2
	//Baza2
	//FunPark
	//PIPE
	//Afganistan
    CreateVehicle(433,84.9798000,1883.2759000,18.1261000,91.2434000,43,-1,15); //Barracks
	CreateVehicle(433,85.5638000,1875.0757000,18.1015000,91.9189000,43,-1,15); //Barracks
	CreateVehicle(433,86.6852000,1846.8700000,18.0774000,91.8509000,43,-1,15); //Barracks
	//SPAWN Z SERVERA PPS STOCZNIA /miniport
	//Water Land BY XERXES
	//Impra
	//Baza na LV na sklepie w centrum
    printf("[GoldServer] Zaladowano %d obiektow w streamerze.",CountDynamicObjects());
    ZapisyUpdate();
    MaxPojazdow = CreateVehicle(411, 0, 0, 0, 0, 0, 0, 1000); DestroyVehicleEx(MaxPojazdow);
    OnedeLabel = Create3DTextLabel("Najlepsi na /Onede\n\n{FFFFFF}Trwa aktualizacja...", 0xff5219FF, 228.7005,148.4579,1004.6, 15.0, 10, 0);
    MinigunLabel = Create3DTextLabel("Najlepsi na /Minigun\n\n{FFFFFF}Trwa aktualizacja...", 0xff5219FF, 2621.6140,2731.9199,26.1576, 150.0, 10, 0);
    RPGLabel = Create3DTextLabel("Najlepsi na /RPG\n\n{FFFFFF}Trwa aktualizacja...", 0xff5219FF, 707.7961,914.2433,-17.6179, 150.0, 10, 0);
    DriftLabel = Create3DTextLabel("Najlepsi drifterzy\n\n{FFFFFF}Trwa aktualizacja...", 0xff5219FF, -1484.5365,691.7266,12.2119, 150.0, 0, 0);
    KillLabel = Create3DTextLabel("Najlepsi zabójcy w San Andreas\n\n{FFFFFF}Trwa aktualizacja...", 0xff5219FF, 2107.2295,997.9907,34.6180, 150.0, 0, 0);
	new PlateString[50];
    for(new v=0; v<MAX_VEHICLES; v++)
        format(PlateString,sizeof(PlateString),"{000000}GS %04d",v);
	    SetVehicleNumberPlate(v, PlateString);
        vNeon[v] = {-1, -1};
    new Data[3];
	getdate(Data[0],Data[1],Data[2]);
	format(PlateString,sizeof(PlateString), "~w~~h~%02d~y~.~w~~h~%02d~y~.~w~~h~%04d",Data[2],Data[1],Data[0]);
	TextDrawSetString(DataTD, PlateString);
	print("[GoldServer] Funkcje dodatkowe zaladowane.");
	print("[GoldServer] Finalizacja ładowania GameModa zakończona.\n\n\n\n\n\n\n\n\n\n");
    LoadTime = (tickcount()-Tick)/1000.0;
	return 1;
public OnGameModeExit()
    if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	SaveStatistics();
	SaveConfigs();
	foreach(Player,x)
        SavePlayer(x);
		SCM(x, C_WHITE, ""I" "W"Uwaga nastąpił restart serwera. Prosimy ponownie wejść na serwer.");
        SCM(x, C_WHITE, ""I" "W"W razie problemów prosimy skontaktować się z administracją bądź napisać na "WWW".");
		Kick(x);
	new String[255];
    for(new x=0;x<MAX_PRIVATE_VEHICLES;x++)
		format(String,sizeof(String),"UPDATE `"PREFIX"Vehicles` SET vPrzebieg='%d' WHERE `vID` = %d",vInfo[x][vPrzebieg],x);
		mysql_query(String);
    for(new x=0;x<MAX_HOUSES;x++)
		format(String,sizeof(String),"UPDATE `"PREFIX"Houses` SET hOwner='%s',hName='%s',hWaznosc='%d',hLocked='%d' WHERE `gID` = %d",hInfo[x][hOwner],hInfo[x][hName],hInfo[x][hWaznosc],hInfo[x][hLocked],x);
		mysql_query(String);
	SendRconCommand("gmx");
	return 1;
CMD:rejestracja(playerid)
	return cmd_register(playerid);
CMD:zarejestruj(playerid)
	return cmd_register(playerid);
CMD:register(playerid)
    if(Player[playerid][Registered])
        return SCM(playerid, C_WHITE, ""E" "W"Jesteś już zarejestrowany(a).");
	SPD(playerid, D_REGISTER, DIALOG_STYLE_PASSWORD, "{00BFFF}Rejestracja "W"(1/2)", "Dziękujemy za poddanie konta rejestracji.\nPo rejestracji konta twoje staty będą zapisywane.\n\nPoniżej podaj swoje hasło:", "Rejestruj", "Zamknij");
	return 1;
CMD:nowynick(playerid)
	return cmd_zmiennick(playerid);
CMD:nowehaslo(playerid)
	return cmd_zmienhaslo(playerid);
CMD:zmiennick(playerid)
    if(!Player[playerid][Registered] && !Player[playerid][Logged])
        return SCM(playerid, C_WHITE, ""E" "W"Musisz być zarejestrowany(a).");
	if(Player[playerid][Nicked] > 0)
		return SCM(playerid, C_WHITE, ""E" "W"Zmiana nicku możliwa jest co 5 minut!");
	SPD(playerid, D_SETNICK, DIALOG_STYLE_INPUT, "{00BFFF}Zmiana Nicku "W"(1/2)", "Aby zmienić swój nick na nowy\nWymyśl swój nick i wpisz go poniżej:", "Dalej", "Zamknij");
	return 1;
CMD:zmienhaslo(playerid)
    if(!Player[playerid][Registered] && !Player[playerid][Logged])
        return SCM(playerid, C_WHITE, ""E" "W"Musisz być zarejestrowany(a).");
	SPD(playerid, D_SETPASS, DIALOG_STYLE_PASSWORD, "{00BFFF}Zmiana Hasła "W"(1/2)", "Aby zmienić hasło do swojego konta\nWymyśl swoje hasło po czym wpisz je poniżej:", "Dalej", "Zamknij");
	return 1;
CMD:alogin(playerid,cmdtext[])
 	if(Player[playerid][Admin1]) return SCM(playerid, C_WHITE, ""E" "W"Jesteś już administratorem!");
    new haslo[64];
	if(sscanf(cmdtext,"s[64]",haslo))
	    SCM(playerid, C_WHITE,""I" "W"/Alogin [Hasło]");
		return 1;
    if(!Player[playerid][Logged])
		SCM(playerid,C_WHITE,""E" "W"Musisz być zalogowany aby tego użyć!");
		return 1;
    if(strfind(MD5_Hash(haslo),AdminPass,true) == 0)
        CheckAdmin(playerid);
	else
        SCM(playerid,C_WHITE,""E" "W"Podano błędne hasło!");
	return 1;
CMD:specsn(playerid)
	if(!Player[playerid][Admin1])
        SCM(playerid,C_WHITE,""E" "W"Nie posiadasz uprawnień do używania tej komendy.");
		return 1;
	if(!SNON)
        SCM(playerid,C_WHITE,""E" "W"Tej komendy możesz użyć tylko, gdy sianko trwa.");
		return 1;
	SCM(playerid, C_WHITE, ""E" "W"Specujesz sianko. Aby wyłączyć specowanie wpisz /SpecSNOff");
	SetPlayerCameraLookAt(playerid,-6.6943,-2076.5205,302.536);
	SetPlayerCameraPos(playerid,27.6305,-2041.6407,302.5360);
    SetPlayerVirtualWorld(playerid,13);
	return 1;
CMD:specsnoff(playerid)
	if(!Player[playerid][Admin1])
        SCM(playerid,C_WHITE,""E" "W"Nie posiadasz uprawnień do używania tej komendy.");
		return 1;
	SCM(playerid, C_WHITE, ""E" "W"Specujesz sianko. Aby wyłączyć specowanie wpisz /SpecSNOff");
	SetCameraBehindPlayer(playerid);
    SetPlayerVirtualWorld(playerid,0);
	return 1;
CMD:alogout(playerid)
	if(IsPlayerAdmin(playerid))
        SCM(playerid,C_WHITE,""E" "W"Nie możesz się wylogować z funkcji RCON!");
		return 1;
	if(Player[playerid][Admin1])
	    SCM(playerid, C_WHITE, ""I" Zostałeś wylogowany z funkcji administratora. Ponowne zalogowanie: /AlogIn");
		Player[playerid][Admin1] = false;
		Player[playerid][Admin2] = false;
		OnlineAdmins --;
		return 1;
	SCM(playerid, C_WHITE, ""E" "W"Nie posiadasz uprawnień do używania tej komendy.");
	return 1;
CMD:acmd(playerid)
    Player[playerid][UsedPomoc] = false;
	SPD(playerid, D_ACMD, DIALOG_STYLE_LIST, "{00BFFF}Komendy Admina", "› Komendy poziomu 1\n"GUI2"› Komendy poziomu 2\n"W"› Komendy poziomu 3","Wybierz","Zamknij");
	return 1;
CMD:pomoc(playerid)
	return SPD(playerid, D_POMOC, DIALOG_STYLE_LIST, "{00BFFF}Pomoc", "› Komendy gracza\n"GUI2"› Komendy admina\n"W"› Komendy moderatora\n"GUI2"› Informacje o koncie VIP\n"W"› Teleporty\n"GUI2"› Atrakcje\n"W"› Animacje\n"GUI2"› Autorzy GameModa\n"W"› Panel TextDrawów\n"GUI2"› Regulamin\n"W"› Poradnik o serwerze","Wybierz","Zamknij");
CMD:impreza(playerid)
	return cmd_impra(playerid);
CMD:stylwalki(playerid)
	return cmd_stylewalki(playerid);
CMD:kupno(playerid)
	return cmd_vip(playerid);
CMD:areny(playerid)
	new String[128];
	format(String,sizeof(String), "› Minigun (%d/20)\n"GUI2"› RPG (%d/20)\n"W"› Onede (%d/10)\n"GUI2"› Combat (%d/10)", MinigunUsers, RPGUsers, OnedeUsers, CombatUsers);
	SPD(playerid, D_ARENY, DIALOG_STYLE_LIST, "{00BFFF}Areny serwera", String,"Wybierz","Zamknij");
	return 1;
CMD:tutorial(playerid)
	InterpolateCameraPos(playerid, -1551.161254, 592.266540, 108.464462, -2783.023193, 2103.675537, 91.013908, 30000);
	InterpolateCameraLookAt(playerid, -1554.390747, 596.082092, 108.355407, -2780.709960, 2099.244140, 91.123588, 30000);
	SPD(playerid, D_TUTORIAL, DIALOG_STYLE_MSGBOX, "{00BFFF}Tutorial "W"(1/8) - Konto", "Na tym serwerze jest dostępny system zapisywanych kont.\nAby takie mieć należy wpisać /Register.\nPo rejestracji twoje statystyki będą automatycznie zapisywane nawet gdy o tym nie będziesz świadomy :)\nUzyskasz też dostęp do zdobywania osiągnięć ale o tym w kroku 2.","Dalej","Zakończ");
	return 1;
CMD:vip(playerid)
	Player[playerid][UsedPomoc] = false;
	SPD(playerid, D_VIP, DIALOG_STYLE_LIST, "{00BFFF}Konto VIP", "› Kupno konta premium\n"GUI2"› Komendy konta premium\n"W"› Informacje o koncie premium","Wybierz","Zamknij");
	return 1;
CMD:vipinfo(playerid)
	return cmd_vip(playerid);
CMD:przedmioty(playerid)
	SPD(playerid,D_PRZEDMIOTY, DIALOG_STYLE_LIST, "{00BFFF}Przyczepiane przedmioty", "› Czapki\n"GUI2"› Kapelusze\n"W"› Hełmy\n"GUI2"› Maski\n"W"› Inne\n"GUI2"› Usuń", "Wybierz", "Zamknij");
	return 1;
CMD:konto(playerid)
	if(!Player[playerid][Registered]) return SCM(playerid, C_WHITE, ""E" "W"Musisz się zarejestrować!");
	new string[330],MaKask[45],Rampa[45],Skok[45],tpVip[45],tpIdzdo[45];
	if(Player[playerid][KaskON])
	    format(MaKask,sizeof(MaKask), "\n› Kask na motorach {1DEB02}(ON)");
	else
	    format(MaKask,sizeof(MaKask), "\n› Kask na motorach {CC0E00}(OFF)");
    if(Player[playerid][WlaczylRampy] >= 1)
	    format(Rampa,sizeof(Rampa), "\n› Rampy w pojazdach {1DEB02}(ON)");
	else
	    format(Rampa,sizeof(Rampa), "\n› Rampy w pojazdach {CC0E00}(OFF)");
    if(Player[playerid][AirON])
	    format(Skok,sizeof(Skok), "\n› Podwójny skok {1DEB02}(ON)");
	else
	    format(Skok,sizeof(Skok), "\n› Podwójny skok {CC0E00}(OFF)");
    if(Player[playerid][TpVipON])
	    format(tpVip,sizeof(tpVip), "\n› Teleportowanie vipów {1DEB02}(ON)");
	else
	    format(tpVip,sizeof(tpVip), "\n› Teleportowanie vipów {CC0E00}(OFF)");
    if(Player[playerid][IdzdoON])
	    format(tpIdzdo,sizeof(tpIdzdo), "\n› Prośby o teleport idzdo {1DEB02}(ON)");
	else
	    format(tpIdzdo,sizeof(tpIdzdo), "\n› Prośby o teleport idzdo {CC0E00}(OFF)");
    strcat(string,"› Zmiana Nicku\n› Zmiana Hasła\n› Osiągnięcia\n› Statystyki");
    strcat(string,MaKask);
    strcat(string,Rampa);
    strcat(string,Skok);
    strcat(string,tpVip);
    strcat(string,tpIdzdo);
  
	SPD(playerid, D_KONTO, DIALOG_STYLE_LIST, "{00BFFF}Panel Konta", string,"Wybierz","Zamknij");
	return 1;
CMD:staty(playerid)
	return cmd_statystyki(playerid);
CMD:stats(playerid)
	return cmd_statystyki(playerid);
CMD:statystyki(playerid)
	return SPD(playerid,D_STATY,DIALOG_STYLE_LIST,"{00BFFF}Statystyki","› Twoje statystyki\n"GUI2"› Statystyki serwera\n"W"› Listy TOP-10","Wybierz","Zamknij");
CMD:mcmd(playerid)
    Player[playerid][UsedPomoc] = false;
	if(!Player[playerid][Mod] && !Player[playerid][Admin1])
		SCM(playerid, C_ERROR, ""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
		return 1;
	new string[920];
	strcat(string,""G"/Kick [ID] "W"- Wyrzucasz gracza z serwera.\n");
	strcat(string,""G"/Explode [ID] "W"- Wysadzasz gracza.\n");
	strcat(string,""G"/Spec [ID] "W"- Podglądasz gracza.\n");
    strcat(string,""G"/SpecOff  "W"- Wyłączasz podgląd gracza.\n");
	strcat(string,""G"/Heal [ID] "W"- Uzdrawiasz gracza.\n");
	strcat(string,""G"/ArmorID [ID] "W"- Dajesz graczu kamizelkę.\n");
	strcat(string,""G"/SetTime [Godzina] "W"- Zmieniasz godzinę na serwerze.\n");
	strcat(string,""G"/Weather [ID Pogody] "W"- Zmieniasz pogodę na serwerze.\n");
	strcat(string,""G"/Repair [ID] "W"- Naprawiasz pojazd graczowi.\n");
	strcat(string,""G"/Remove [ID] "W"- Wyrzucasz gracza z pojazdu.\n");
    strcat(string,""G"/Podkowa [Kasa] [Podpowiedź] "W"- Stawiasz podkowę.\n");
    strcat(string,""G"/Prezent [Podpowiedź] "W"- Stawiasz prezent.\n");
	strcat(string,""G"/SetIP [ID] [Interior] "W"- Zmieniasz interior gracza.\n");
	strcat(string,""G"/SetWorld [ID] [Virtual World] "W"- Zmieniasz VirtualWorld gracza.\n");
    strcat(string,""G"/CZ "W"- Czyścisz cały czat.\n");
    strcat(string,""G"/mGod "W"- Nieśmiertelność.\n");
    strcat(string,""G"/mWaznosc "W"- Ważność konta premium.\n");
    strcat(string,""G"/Reports "W"- Lista raportów zgłaszanych przez graczy.\n");
    strcat(string,""G"/ClickMap "W"- Kliknięcie na mapie powoduje teleportację.\n");
	SPD(playerid,D_NONE,0,"{00BFFF}Komendy Moderatora",string,"Zamknij","");
	return 1;
CMD:faq(playerid)
	new string[1800];
	strcat(string,""W"FAQ - Czyli najczęściej zadawane pytania przez naszych graczy.\n\n");
	strcat(string,""W"Co to jest CK (Car Kill)?\n");
	strcat(string,"{44a428}- Car Kill jest to zabicie/zabijanie kogoś przy pomocy pojazdu.\n\n");
    strcat(string,""W"Co to jest DB (Drive By)?\n");
	strcat(string,"{44a428}- Drive By jest to zabicie kogoś z okna kierowcy w aucie.\n\n");
    strcat(string,""W"Co to jest DT (Drive Thru)?\n");
	strcat(string,"{44a428}- Drive Thru jest to zabicie kogoś z okna pasażera.\n\n");
    strcat(string,""W"Co to jest SP (Spawn Kill)?\n");
	strcat(string,"{44a428}- Spawn Kill jest to zabijanie cały czas na spawnie.\n\n");
    strcat(string,""W"Co to jest TK (Team Kill)?\n");
	strcat(string,"{44a428}- Team Kill jest to zabijanie osób ze swojej drużyny.\n\n");
    strcat(string,""W"Dostałem bana, co robić?\n");
	strcat(string,"{44a428}- Należy jak najszybciej udać się na forum naszego serwera, i napisać podanie o unban.\n\n");
    strcat(string,""W"Jak szybko zdobyć exp/level?\n");
	strcat(string,"{44a428}- Najprościej jest zabijać innych graczy. Można też uczęszczać w zabawach zorganizowanych/eventach.\n\n");
    strcat(string,""W"Dlaczego jak wszedłem/am na serwer to jestem w więzieniu?\n");
	strcat(string,"{44a428}- Prawdopodobnie zostałeś/aś uwięziony podczas swojego ostatniego pobytu na serwerze, i musisz odczekać karę.\n\n");
    strcat(string,""W"Dlaczego jak wszedłem/am na serwer to jestem uciszony/a?\n");
	strcat(string,"{44a428}- Podczas swojego ostatniego pobytu na serwerze zostałeś/aś uciszony przez serwer/administrację.\n\n");
    strcat(string,""W"Czy gamemode tego serwera był pisany od 0?\n");
	strcat(string,"{44a428}- Tak, nasz programista napisał tego gamemoda od pierwszych linijek kodu.\n\n");
    strcat(string,""W"Co zrobić, gdy ktoś nas obraża, lub jak widzimy cheatera itp?\n");
	strcat(string,"{44a428}- Należy to zgłosić jak najszybciej administracji! /Raport [ID] [Powód].\n\n");
    strcat(string,""W"Jak zmienić nick/hasło do konta bez utraty statystyk?\n");
	strcat(string,"{44a428}- Należy użyć komendy /ZmienNick bądź /ZmienHaslo i kierować się dalszymi opcjami.\n\n");
    strcat(string,""W"Jak zostać adminem?\n");
	strcat(string,"{44a428}- Należy często przebywać na serwerze oraz wygrać rekrutację na administratora.");
	SPD(playerid,D_NONE,0,"{00BFFF}FAQ - Najczęściej zadawane pytania",string,"Zamknij","");
	return 1;
CMD:regulamin(playerid)
    Player[playerid][UsedPomoc] = false;
	new string[1150];
	strcat(string,""W"1. {44a428}Zabrania się podszywania/prób logowania na Admina/Moderatora.\n");
	strcat(string,""W"2. {44a428}Zakaz używania progamów ułatwiających grę (s0beit, v0lgez oraz mody CLEO które umożliwiają latanie itp.)\n");
	strcat(string,""W"3. {44a428}Wszelkie treści obraźliwe i rasistowskie będą karane.\n");
	strcat(string,""W"4. {44a428}Nie używaj wulgarnego słownictwa.\n");
	strcat(string,""W"5. {44a428}Zakaz reklamowania innych serwerów.\n");
	strcat(string,""W"6. {44a428}Zakaz floodowania, spamowania, bugowania.\n");
	strcat(string,""W"7. {44a428}HK, CK itp. za strefą śmierci zabronione! (/faq)\n");
    strcat(string,""W"8. {44a428}Zabrania się reklamowania innych serwerów itp.\n");
    strcat(string,""W"9. {44a428}Zakaz nieuczciwego zdobywania exp.\n");
    strcat(string,""W"10. {44a428}Zakaz uciekania z więzennej wyspy.\n");
    strcat(string,""W"11. {44a428}Zakaz przeszkadzania w zabawach zorganizowanych.\n");
    strcat(string,""W"12. {44a428}Zakaz przeszkadzania w zabawach zorganizowanych.\n\n");
	strcat(string,""W"Nieznajomość regulaminu nie usprawiedliwia Cię.\n");
	strcat(string,""W"Wchodząc na serwer akceptujesz ustalone przez nas zasady.\n");
    strcat(string,""W"Jeżeli ich nie czytałeś to twoja wina i zostaniesz ukarany nawet jeżeli łamałeś regulamin nieświadomie.\n\n");
	strcat(string,"{FF0000}Administracja zastrzega sobie prawo do zmiany regulaminu w każdej chwili.");
	SPD(playerid,D_NONE,0,"{00BFFF}Regulamin serwera",string,"Zamknij","");
	return 1;
CMD:gunday(playerid)
	new String[300];
	format(String,sizeof(String),"Aktualna broń dnia to: %s!\n\nOtrzymujesz dwa razy więcej exp za zabójstwo tą bronią.",GetRealWeaponName(GunDay));
	SPD(playerid,D_NONE,0,"{00BFFF}Broń dnia",String,"Zamknij","");
	return 1;
CMD:kod(playerid)
	new string[300];
	strcat(string,"Co 10 minut na serwerze na środku ekranu ujawnia się kod.\n");
	strcat(string,"Ten, kto pierwszy wpisze go na czat otrzymuje nagrodę w postaci exp + kasa.\n");
	strcat(string,"Wszystkie (twoje) przepisane kody zapisują się do twoich statystyk.\n");
	strcat(string,"Zachęcamy do przepisywania kodów ze względu na TOP-10 kodów :) (/Staty)\n");
	SPD(playerid,D_NONE,0,"{00BFFF}Kod do przepisania",string,"Zamknij","");
	return 1;
CMD:tdpanel(playerid)
	return cmd_paneltd(playerid);
CMD:hud(playerid)
	return cmd_paneltd(playerid);
CMD:panel(playerid)
	return cmd_konto(playerid);
CMD:aexit(playerid)
	return cmd_arenaexit(playerid);
CMD:paneltd(playerid)
	new string[500],PasekStan[45],LogoStan[45],PodpowiedziStan[45],ZegarStan[45],LicznikStan[45],ZapisyStan[45],allstan[45];
                                              
	if(Player[playerid][PasekON])
		format(PasekStan, sizeof(PasekStan), "› Pasek stanu {1DEB02}(ON)\n");
	else
		format(PasekStan, sizeof(PasekStan), ""W"› Pasek stanu {CC0E00}(OFF)\n");
	if(Player[playerid][LogoON])
		format(LogoStan, sizeof(LogoStan), ""W"› Logo serwera {1DEB02}(ON)\n");
	else
		format(LogoStan, sizeof(LogoStan), ""W"› Logo serwera {CC0E00}(OFF)\n");
	if(Player[playerid][PodpowiedziON])
		format(PodpowiedziStan, sizeof(PodpowiedziStan), ""W"› Podpowiedzi {1DEB02}(ON)\n");
	else
		format(PodpowiedziStan, sizeof(PodpowiedziStan), ""W"› Podpowiedzi {CC0E00}(OFF)\n");
	if(Player[playerid][ZegarON])
		format(ZegarStan, sizeof(ZegarStan), ""W"› Zegar i data {1DEB02}(ON)\n");
	else
		format(ZegarStan, sizeof(ZegarStan), ""W"› Zegar i data {CC0E00}(OFF)\n");
	if(Player[playerid][LicznikON])
		format(LicznikStan, sizeof(LicznikStan), ""W"› Licznik {1DEB02}(ON)\n");
	else
		format(LicznikStan, sizeof(LicznikStan), ""W"› Licznik {CC0E00}(OFF)\n");
	if(Player[playerid][ZapisyON])
		format(ZapisyStan, sizeof(ZapisyStan), ""W"› Tabela zapisów {1DEB02}(ON)\n");
	else
		format(ZapisyStan, sizeof(ZapisyStan), ""W"› Tabela zapisów {CC0E00}(OFF)\n");
    if(Player[playerid][AllTD])
		format(allstan, sizeof(allstan), ""W"› Wszystkie {1DEB02}(ON)\n");
	else
		format(allstan, sizeof(allstan), ""W"› Wszystkie {CC0E00}(OFF)\n");
	strcat(string,PasekStan);
	strcat(string,LogoStan);
	strcat(string,PodpowiedziStan);
	strcat(string,ZegarStan);
	strcat(string,LicznikStan);
	strcat(string,ZapisyStan);
	strcat(string,allstan);
	SPD(playerid,D_PANELTD,DIALOG_STYLE_LIST,"{00BFFF}Panel TextDrawów",string,"Wybierz","Zamknij");
	return 1;
CMD:autor(playerid)
    Player[playerid][UsedPomoc] = false;
	new string[600];
	strcat(string,""W"PL|GoldServer™ "VERSION"\n\n");
	strcat(string,"{44a428}Programista silnika: "W""AUTHOR_NICK" & Maly\n\n");
	strcat(string,"{44a428}Obiekter serwera: "W"Serek & Kajuss\n\n");
	strcat(string,"{44a428}Podziękowania dla autorów pluginów/include:\n\n");
	strcat(string,""W"StrickenKid {44a428}- MySQL plugin\n");
	strcat(string,""W"Y_Less {44a428}- Sscanf plugin & foreach\n");
	strcat(string,""W"ZeeX {44a428}- ZCMD\n");
	strcat(string,""W"Incognito {44a428}- Multi Streamer\n\n");
	strcat(string,""W"© GoldServer™ 2010 - 2013\n");
	strcat(string,""W"Wszelkie prawa zastrzeżone.\n");
	SPD(playerid,D_NONE,0,"{00BFFF}O Autorach",string,"Zamknij","");
	return 1;
CMD:nowosci(playerid)
	new string[600];
	strcat(string,""W"Nowości na serwerze "VERSION":\n\n");
	strcat(string,"{44a428}- Dodano możliwość używania animacji w domach.\n");
	strcat(string,"- Zresetowano konta graczy.\n");
    strcat(string,"- Naprawiono bugi.\n");
    strcat(string,"- Ulepszono zabezpieczenia.\n");
    strcat(string,"- Poprawiono wydajność serwera.\n");
   
	SPD(playerid,D_NONE,0,"{00BFFF}Nowości",string,"Zamknij","");
	return 1;
/*
// BLOWJOBZ
      case 1: ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_START_W", 4.0, 1, 1, 1, 1, 0);
      case 2: ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_START_P", 4.0, 1, 1, 1, 1, 0);
   case 3: ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_W", 4.0, 1, 1, 1, 1, 0);
      case 4: ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_P", 4.0, 1, 1, 1, 1, 0);
      case 5: ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_END_W", 4.0, 1, 1, 1, 1, 0);
      case 6: ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_END_P", 4.0, 1, 1, 1, 1, 0);
      case 7: ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_START_W", 4.0, 1, 1, 1, 1, 0);
      case 8: ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_START_P", 4.0, 1, 1, 1, 1, 0);
      case 9: ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_W", 4.0, 1, 1, 1, 1, 0);
      case 10: ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_P", 4.0, 1, 1, 1, 1, 0);
      case 11: ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_END_W", 4.0, 1, 1, 1, 1, 0);
      case 12: ApplyAnimation(playerid, "BLOWJOBZ", "BJ_STAND_END_P", 4.0, 1, 1, 1, 1, 0);
      case 13: ApplyAnimation(playerid, "BLOWJOBZ", "BJ_CAR_START_W", 4.0, 1, 1, 1, 1, 0);
      case 14: ApplyAnimation(playerid, "BLOWJOBZ", "BJ_CAR_START_P", 4.0, 1, 1, 1, 1, 0);
      case 15: ApplyAnimation(playerid, "BLOWJOBZ", "BJ_CAR_LOOP_W", 4.0, 1, 1, 1, 1, 0);
            case 16: ApplyAnimation(playerid, "BLOWJOBZ", "BJ_CAR_LOOP_P", 4.0, 1, 1, 1, 1, 0);
            case 17: ApplyAnimation(playerid, "BLOWJOBZ", "BJ_CAR_END_W", 4.0, 1, 1, 1, 1, 0);
            case 18: ApplyAnimation(playerid, "BLOWJOBZ", "BJ_CAR_END_P", 4.0, 1, 1, 1, 1, 0);
// SNM
            case 1: ApplyAnimation(playerid, "SNM", "SPANKING_IDLEW", 4.0, 1, 1, 1, 1, 0);
            case 2: ApplyAnimation(playerid, "SNM", "SPANKING_IDLEP", 4.0, 1, 1, 1, 1, 0);
            case 3: ApplyAnimation(playerid, "SNM", "SPANKINGW", 4.0, 1, 1, 1, 1, 0);
            case 4: ApplyAnimation(playerid, "SNM", "SPANKINGP", 4.0, 1, 1, 1, 1, 0);
            case 5: ApplyAnimation(playerid, "SNM", "SPANKEDW", 4.0, 1, 1, 1, 1, 0);
            case 6: ApplyAnimation(playerid, "SNM", "SPANKEDP", 4.0, 1, 1, 1, 1, 0);
            case 7: ApplyAnimation(playerid, "SNM", "SPANKING_ENDW", 4.0, 1, 1, 1, 1, 0);
            case 8: ApplyAnimation(playerid, "SNM", "SPANKING_ENDP", 4.0, 1, 1, 1, 1, 0);
// SEX
            case 1: ApplyAnimation(playerid, "SEX", "SEX_1_W", 4.0, 1, 1, 1, 1, 0);
            case 2: ApplyAnimation(playerid, "SEX", "SEX_1_P", 4.0, 1, 1, 1, 1, 0);
            case 3: ApplyAnimation(playerid, "SEX", "SEX_1_CUM_W", 4.0, 1, 1, 1, 1, 0);
            case 4: ApplyAnimation(playerid, "SEX", "SEX_1_CUM_P", 4.0, 1, 1, 1, 1, 0);
            case 5: ApplyAnimation(playerid, "SEX", "SEX_1_FAIL_W", 4.0, 1, 1, 1, 1, 0);
            case 6: ApplyAnimation(playerid, "SEX", "SEX_1_FAIL_P", 4.0, 1, 1, 1, 1, 0);
            case 7: ApplyAnimation(playerid, "SEX", "SEX_1TO2_P", 4.0, 1, 1, 1, 1, 0);
            case 8: ApplyAnimation(playerid, "SEX", "SEX_1TO2_W", 4.0, 1, 1, 1, 1, 0);
            case 9: ApplyAnimation(playerid, "SEX", "SEX_2_W", 4.0, 1, 1, 1, 1, 0);
            case 10: ApplyAnimation(playerid, "SEX", "SEX_2_P", 4.0, 1, 1, 1, 1, 0);
            case 11: ApplyAnimation(playerid, "SEX", "SEX_2_FAIL_W", 4.0, 1, 1, 1, 1, 0);
            case 12: ApplyAnimation(playerid, "SEX", "SEX_2_FAIL_P", 4.0, 1, 1, 1, 1, 0);
            case 13: ApplyAnimation(playerid, "SEX", "SEX_2TO3_P", 4.0, 1, 1, 1, 1, 0);
            case 14: ApplyAnimation(playerid, "SEX", "SEX_2TO3_W", 4.0, 1, 1, 1, 1, 0);
            case 15: ApplyAnimation(playerid, "SEX", "SEX_3_W", 4.0, 1, 1, 1, 1, 0);
            case 16: ApplyAnimation(playerid, "SEX", "SEX_3_P", 4.0, 1, 1, 1, 1, 0);
            case 17: ApplyAnimation(playerid, "SEX", "SEX_3_FAIL_W", 4.0, 1, 1, 1, 1, 0);
            case 18: ApplyAnimation(playerid, "SEX", "SEX_3_FAIL_P", 4.0, 1, 1, 1, 1, 0);
            case 19: ApplyAnimation(playerid, "SEX", "SEX_3TO1_W", 4.0, 1, 1, 1, 1, 0);
            case 20: ApplyAnimation(playerid, "SEX", "SEX_3TO1_P", 4.0, 1, 1, 1, 1, 0);
21:47:16
*/
CMD:animacje(playerid)
	return cmd_anims(playerid);
CMD:animations(playerid)
	return cmd_anims(playerid);
CMD:animlist(playerid)
	return cmd_anims(playerid);
CMD:vipcmd(playerid)
	return cmd_vip(playerid);
CMD:anims(playerid)
    Player[playerid][UsedPomoc] = false;
	new string[810];
	strcat(string,""W"Wszystkie animacje serwera:\n\n");
	strcat(string,"{44a428}/Rece     /Rece2    /Rece3    /Rece4 \n");
	strcat(string,"/Rece5    /Rece6    /Bar2     /Bar3 \n");
	strcat(string,"/Szafka   /Zegarek  /Lez      /Hide\n");
	strcat(string,"/Rzygaj   /Grubas   /Grubas2  /Taichi\n");
	strcat(string,"/Siadaj   /Chat     /Ratunku  /Kopniak\n");
	strcat(string,"/Dance    /Fucku    /Cellin   /Cellout\n");
	strcat(string,"/Pij      /Smoke    /Fsmoke   /Krzeslo\n");
	strcat(string,"/Krzeslo2 /Calus    /Trup     /Trup2\n");
	strcat(string,"/Wankin   /Wankout  /Deal     /Boks\n");
	strcat(string,"/Lol      /Bomba    /Aresztuj /Opalaj\n");
	strcat(string,"/Opalaj2  /Opalaj3  /Turlaj   /Klaps\n");
	strcat(string,"/Kradnij  /Kaleka   /Swat     /Swat2\n");
	strcat(string,"/Swat3    /Piwo     /Drunk    /Rap\n");
	strcat(string,"/Lookout  /Napad    /Papieros /Cpun\n");
	strcat(string,"/Cpun2    /Cpun3    /Cpun4    /Cpun5\n");
	strcat(string,"/Skok2    /Skok3    /Jedz     /Jedz2\n");
	strcat(string,"/Jedz3    /Wino     /Taniec   /Taniec2\n");
	strcat(string,"/Taniec3  /Taniec4  /Taniec5  /Taniec6\n");
	strcat(string,"/Taniec7  /Rolki    /Sprunk   /Inbedleft\n");
	strcat(string,"/Inbedright /Poddajsie  /Aresztowany  /Aresztuj2");
	SPD(playerid,D_NONE,0,"{00BFFF}Animacje Serwera",string,"Zamknij","");
	return 1;
CMD:atrakcje(playerid)
	Player[playerid][UsedPomoc] = false;
	new string[900];
	strcat(string,""W"Atrakcje Główne\n\n");
    strcat(string,"{44a428}/nBronie   /Laser   /Neony   /Fryzura\n");
    strcat(string,"/FPS   /Radio   /Teles   /Portfel\n");
    strcat(string,"/Kod   /Pojazd   /DomPomoc   /Hitman\n");
    strcat(string,"/Randka   /IdzDo   /Portfel   /Anims\n");
    strcat(string,"/Losowanie   /HUD   /TuneMenu   /Tune\n");
    strcat(string,"/Przedmioty   /GunDay\n");
	strcat(string,"/Auto   /Areny   /Lotto   /nBronie\n\n");
    strcat(string,""W"Areny DeathMatch\n\n");
    strcat(string,"{44a428}/Minigun   /RPG   /Onede   /Combat\n\n");
    strcat(string,""W"Atrakcje obiektowe\n\n");
    strcat(string,"{44a428}/Drift7   /Drift8   /Warsztat   /Woda\n");
    strcat(string,"/Ziolo   /Tube   /SkyRoad   /Zjazd3\n");
    strcat(string,"/Gora   /WaterLand   /PiPe   /Wodospad\n");
    strcat(string,"/Stunt   /PKS   /PodWoda   /Tor2\n");
    strcat(string,"/Lost   /Wyspa   /Baza   /Statek2\n");
    strcat(string,"/Domek   /Odbij   /Impra1   /Szklo\n");
    strcat(string,"/Impra2   /Impra3   /TorNrg1   /TorNrg2\n");
    strcat(string,"/Kula   /FunPark   /Nascar    /SFLot\n");
    strcat(string,"/MiniPort   /LS   /Bagno   /Basen\n");
    strcat(string,"/Gokarty   /Lost   /Wyspa2   /Parkour\n");
    strcat(string,"/Wyspa3   /Tor   /Zjazd   /Kulki\n");
    strcat(string,"/Zjazd2   /Tokyo   /SkyDive   /Baza1-3\n");
    strcat(string,"/Skocznia\n");
	SPD(playerid,D_NONE,0,"{00BFFF}Atrakcje serwera",string,"Zamknij","");
	return 1;
CMD:teles(playerid)
	new string[1200];
	strcat(string,""W"Teleporty Główne\n\n");
	strcat(string,"{44a428}/LSLot   /SFLot   /LVLot\n");
	strcat(string,"/LS   /LV   /SF\n");
	strcat(string,"/Wojsko   /Wojsko2   /G1-4\n");
	strcat(string,"/SilowniaLS   /SilowniaSF   /SilowniaLV\n");
	strcat(string,"/PeronLS   /PeronSF   /PeronLV\n");
	strcat(string,"/CentrumLS   /CentrumSF   /CentrumLV\n");
	strcat(string,"/BS1-9   /CB1-10   /Pizzeria1-10\n");
	strcat(string,"/SzkolaJazdy1-4   /Binco1-4   /Zip1-4\n");
	strcat(string,"/SzpitalLS   /SzpitalSF   /SzpitalLV\n");
	strcat(string,"/BurdelLS   /BurdelSF   /BurdelLV\n");
	strcat(string,"/TuneLS   /TuneSF   /TuneLV\n\n");
	strcat(string,""W"Teleporty na wsie i miasteczka\n\n");
	strcat(string,"{44a428}/PalomimoCreek   /MontGomery   /Dillimore\n");
	strcat(string,"/BlueBerry   /AngelPine   /FortCarson\n");
	strcat(string,"/LasBarrancas   /LasPayasadas   /ElCastillo\n");
	strcat(string,"/ElQuelbrados   /BaySide   /BoneCountry\n\n");
	strcat(string,""W"Inne teleporty\n\n");
	strcat(string,"{44a428}/Molo   /Wiezowiec   /SkatePark\n");
	strcat(string,"/Osiedle1-5   /Tama   /OdLudzie\n");
	strcat(string,"/Salon   /Kosciol   /Gora\n");
	strcat(string,"/Plaza   /PlazaSF   /PGR\n");
	strcat(string,"/Bagno   /Statek   /FourDragons\n");
	strcat(string,"/Skok1-8   /Drift1-7   /Dirt\n");
	strcat(string,"/Piramida   /Pustynia   /Willa\n");
	strcat(string,"/CPN   /AmmuNation   /Emmet\n\n");
	strcat(string,""W"Teleporty do wnętrz\n\n");
	strcat(string,"{44a428}/RCShop   /CJGarage   /Calligula\n");
	strcat(string,"/WoozieBed   /WOC   /JaysDin\n");
	strcat(string,"/TSDin   /WH   /WH2\n");
	strcat(string,"/Bar   /Restauracja   /Andromeda\n");
	strcat(string,"/Lot   /Lot2   /ViceStadium\n");
	strcat(string,"/DirtBike   /KSS   /DemolotionDerby\n\n");
	strcat(string,""W"Teleporty na atrakcje znajdziesz pod komendą /Atrakcje.");
	SPD(playerid,D_NONE,0,"{00BFFF}Teleporty serwera",string,"Zamknij","");
	return 1;
CMD:cmd(playerid)
    new string[2100];
	strcat(string,"{44a428}/Teles "W"- Lista teleportów serwera.\n");
	strcat(string,"{44a428}/Atrakcje "W"- Lista Atrakcji serwera.\n");
	strcat(string,"{44a428}/Regulamin "W"- Wyświetla regulamin serwera.\n");
	strcat(string,"{44a428}/CarDive "W"- Wystrzeliwujesz w górę pojazd i spadasz.\n");
	strcat(string,"{44a428}/100hp "W"- Uzdrawiasz się kosztem 2500$.\n");
	strcat(string,"{44a428}/Armour "W"- Kupujesz kamizelkę kosztem 3000$.\n");
	strcat(string,"{44a428}/Cars "W"- Lista pojazdów do zrespawnowania.\n");
	strcat(string,"{44a428}/Dotacja "W"- Otrzymujesz jednorazowo 250.000$\n");
	strcat(string,"{44a428}/NRG "W"- Otrzymujesz prywatny NRG-500.\n");
	strcat(string,"{44a428}/Kill "W"- Popełniasz samobójstwo.\n");
	strcat(string,"{44a428}/Tune /TuneMenu "W"- Tuning pojazdu.\n");
	strcat(string,"{44a428}/Flip "W"- Ustawiasz pojazd na koła.\n");
	strcat(string,"{44a428}/ZW /JJ "W"- Informujesz graczy o swoim statusie.\n");
	strcat(string,"{44a428}/Siema /Nara /Czesc /Witam /Pa "W"- Wiadomo...\n");
	strcat(string,"{44a428}/Napraw "W"- Naprawiasz swój pojazd.\n");
	strcat(string,"{44a428}/SP /LP "W"- Zapisujesz / Wczytujesz pozycję.\n");
	strcat(string,"{44a428}/SavePos /Telpos "W"- Chwilowe Teleporty.\n");
	strcat(string,"{44a428}/Raport [ID] [Powód] "W"- Raportujesz gracza.\n");
	strcat(string,"{44a428}/Odlicz "W"- Włączasz odliczanie.\n");
	strcat(string,"{44a428}/Pogoda "W"- Zmieniasz swoją pogodę.\n");
	strcat(string,"{44a428}/StyleWalki "W"- Lista styli walki.\n");
	strcat(string,"{44a428}/Rozbroj "W"- Rozbrajasz się.\n");
	strcat(string,"{44a428}/Autor "W"- Informacje o autorze GameModa.\n");
	strcat(string,"{44a428}/Vip "W"- Informacje o koncie premium (VIP).\n");
	strcat(string,"{44a428}/Skin [ID Skina] "W"- Zmieniasz swój skin.\n");
	strcat(string,"{44a428}/KolorAuto "W"- Zmieniasz na losowy kolor auta.\n");
    strcat(string,"{44a428}/Pos "W"- Sprawdzasz swoją pozycję na mapie.\n");
	strcat(string,"{44a428}/Statystyki "W"- Wyświetla statystyki.\n");
	strcat(string,"{44a428}/C4 /Zdetonuj "W"- Podkładasz C4 / Detonujesz C4.\n");
	strcat(string,"{44a428}/GiveCash [ID] [Kwota] "W"- Oddajesz kasę.\n");
	strcat(string,"{44a428}/Hitman [ID] [Kwota] "W"- Wystawiasz zlecenie.\n");
	strcat(string,"{44a428}/Bounty [ID] "W"- Sprawdzasz nagrodę za głowę.\n");
	strcat(string,"{44a428}/Admins /Vips /Mods "W"- Lista premium OnLine.\n");
	strcat(string,"{44a428}/PM [ID] [Treść] "W"- Wysyłasz prywatną wiadomość.\n");
	strcat(string,"{44a428}/Lock /Unlock "W"- Kontrola drzwi pojazdu.\n");
	strcat(string,"{44a428}/Dystans [ID] "W"- Sprawdzasz dystans gracza do ciebie.\n");
	strcat(string,"{44a428}/Skok [500-20000] "W"- Skaczesz z nieba.\n");
	SPD(playerid,D_CMDS_1,0,"{00BFFF}Komendy Gracza",string,"Dalej","Zamknij");
	return 1;
CMD:logi(playerid)
	if(!IsPlayerAdmin(playerid)) return SCM(playerid, C_WHITE, ""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
	SPD(playerid,D_NONE,DIALOG_STYLE_LIST,"{00BFFF}Ostatnie 15 logów serwera","Ten modół nie jest obecnie zainstalowany.","Zamknij","");
	return 1;
CMD:vipall(playerid,cmdtext[])
	if(!IsPlayerAdmin(playerid)) return SCM(playerid, C_WHITE, ""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
    new waznosc,String[512];
	if(sscanf(cmdtext,"d",waznosc))
	    SCM(playerid, C_WHITE, ""I" "W"/VipAll [Waznosc]");
		return 1;
	foreach(Player,x)
		if(Player[x][Registered])
			SCM(x,C_ORANGE,"{00BFFF}(VIP) "W"Otrzymujesz konto vip od serwera! Aby sprawdzić komendy itd. wpisz /VIP.");
			Player[x][Vip] = true;
			if(VipExists(Player[x][Name]))
				format(String,sizeof(String),"UPDATE "PREFIX"Vips SET Waznosc = Waznosc + %d WHERE Name='%s'",waznosc,Player[x][Name]);
			else
			    format(String,sizeof(String),"INSERT INTO "PREFIX"Vips VALUES ('%s','%d','0')",Player[x][Name],waznosc);
			mysql_query(String);
	SPD(playerid,D_NONE,DIALOG_STYLE_LIST,"{00BFFF}Vip dla zarejestrowanych","Wszyscy zarejestrowani użytkownicy OnLine\nDostali vip.","Zamknij","");
	return 1;
CMD:setadmin(playerid,cmdtext[])
	if(!IsPlayerAdmin(playerid)) return SCM(playerid, C_WHITE, ""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz,waznosc,level;
	if(sscanf(cmdtext,"idd",gracz,level,waznosc))
	    SCM(playerid, C_WHITE, ""I" "W"/SetAdmin [ID] [Level] [Waznosc]");
		return 1;
	if(!Player[gracz][Registered])
        SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest zarejestrowany!");
		return 1;
    if(level < 0 || level > 3)
        SCM(playerid, C_WHITE, ""E" "W"Level musi być od 1 do 3!");
		return 1;
	if(Player[gracz][WaznoscAdmin] > 0)
        SCM(playerid, C_WHITE, ""E" "W"Ten gracz posiada już konto admina!");
		return 1;
	if(level == 1)
        Player[gracz][Admin1] = true;
    if(level == 2)
        Player[gracz][Admin2] = true;
        Player[gracz][Admin1] = true;
	Player[gracz][AdminLevel] = level;
	Player[gracz][WaznoscAdmin] = waznosc;
    new String[256];
    if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	format(String,sizeof(String), "INSERT INTO "PREFIX"Admins (Name,Level,Waznosc,Suspension) VALUES ('%s','%d','%d','0')",Player[gracz][Name],level,waznosc);
	mysql_query(String);
	format(String,sizeof(String), ""I" "W"%s przyznał ci konto administratorskie na %d dni!", Player[playerid][Name],waznosc);
	SCM(gracz,C_WHITE, String);
	SCM(playerid, C_WHITE,""I" "W"Przyznano graczu konto administratorskie.");
   
	return 1;
CMD:setvip(playerid,cmdtext[])
	if(!IsPlayerAdmin(playerid)) return SCM(playerid, C_WHITE, ""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz,waznosc;
	if(sscanf(cmdtext,"id",gracz,waznosc))
	    SCM(playerid, C_WHITE, ""I" "W"/SetVip [ID] [Waznosc]");
		return 1;
	if(!Player[gracz][Registered])
        SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest zarejestrowany!");
		return 1;
	if(Player[gracz][WaznoscVip] > 0)
        SCM(playerid, C_WHITE, ""E" "W"Ten gracz posiada już konto premium!");
		return 1;
	Player[gracz][Vip] = true;
	Player[gracz][WaznoscVip] = waznosc;
    new String[256];
    if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	format(String,sizeof(String), "INSERT INTO "PREFIX"Vips (Name,Waznosc,Suspension) VALUES ('%s','%d','0')",Player[gracz][Name],waznosc);
	mysql_query(String);
	format(String,sizeof(String), ""I" "W"%s przyznał ci konto premium (VIP) na %d dni!", Player[playerid][Name],waznosc);
	SCM(gracz,C_WHITE, String);
	SCM(playerid, C_WHITE,""I" "W"Przyznano graczu konto premium (VIP).");
	return 1;
CMD:setmod(playerid,cmdtext[])
	if(!IsPlayerAdmin(playerid)) return SCM(playerid, C_WHITE, ""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz,waznosc;
	if(sscanf(cmdtext,"id",gracz,waznosc))
	    SCM(playerid, C_WHITE, ""I" "W"/SetMod [ID] [Waznosc]");
		return 1;
	if(!Player[gracz][Registered])
        SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest zarejestrowany!");
		return 1;
	if(Player[gracz][WaznoscMod] > 0)
        SCM(playerid, C_WHITE, ""E" "W"Ten gracz posiada już konto premium!");
		return 1;
	Player[gracz][Mod] = true;
	Player[gracz][WaznoscMod] = waznosc;
    new String[256];
    if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	format(String,sizeof(String), "INSERT INTO "PREFIX"Mods (Name,Waznosc,Suspension) VALUES ('%s','%d','0')",Player[gracz][Name],waznosc);
	mysql_query(String);
	format(String,sizeof(String), ""I" "W"%s przyznał ci konto premium (Moderator) na %d dni!", Player[playerid][Name],waznosc);
	SCM(gracz,C_WHITE, String);
	SCM(playerid, C_WHITE,""I" "W"Przyznano graczu konto premium (Moderator).");
	return 1;
CMD:degradeadmin(playerid,cmdtext[])
	if(!IsPlayerAdmin(playerid)) return SCM(playerid, C_WHITE, ""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" /DegradeAdmin [ID]");
		return 1;
    if(!Player[gracz][Registered])
        SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest zarejestrowany!");
		return 1;
	if(IsPlayerAdmin(gracz))
        SCM(playerid, C_WHITE, ""E" "W"Ten posiada head administratora!");
		return 1;
    if(Player[gracz][WaznoscAdmin] <= 0)
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie posiada administratora!");
		return 1;
    new String[256];
    if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	format(String,sizeof(String), "DELETE FROM "PREFIX"Admins WHERE Name='%s'",Player[gracz][Name]);
	mysql_query(String);
	format(String,sizeof(String), ""I" "W"Twoje konto administratora zostało ci odebrane przez %s.", Player[playerid][Name]);
	SCM(gracz,C_WHITE, String);
    format(String,sizeof(String), ""I" "W"Konto administratorskie gracza %s zostało zdegradowane.", Player[gracz][Name]);
	SCM(playerid, C_WHITE,String);
	Player[gracz][Admin1] = false;
    Player[gracz][Admin2] = false;
	Player[gracz][WaznoscAdmin] = 0;
   
	return 1;
CMD:degradevip(playerid,cmdtext[])
	if(!IsPlayerAdmin(playerid)) return SCM(playerid, C_WHITE, ""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" /DegradeVip [ID]");
		return 1;
    if(!Player[gracz][Registered])
        SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest zarejestrowany!");
		return 1;
    if(Player[gracz][WaznoscVip] <= 0)
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie posiada Vipa!");
		return 1;
    new String[256];
    if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	format(String,sizeof(String), "DELETE FROM "PREFIX"Vips WHERE Name='%s'",Player[gracz][Name]);
	mysql_query(String);
	format(String,sizeof(String), ""I" "W"Twoje konto premium (VIP) zostało ci odebrane przez %s.", Player[playerid][Name]);
	SCM(gracz,C_WHITE, String);
    format(String,sizeof(String), ""I" "W"Konto premium (VIP) gracza %s zostało zdegradowane.", Player[gracz][Name]);
	SCM(playerid, C_WHITE,String);
	Player[gracz][Vip] = false;
	Player[gracz][WaznoscVip] = 0;
	return 1;
CMD:degrademod(playerid,cmdtext[])
	if(!IsPlayerAdmin(playerid)) return SCM(playerid, C_WHITE, ""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" /DegradeMod [ID]");
		return 1;
    if(!Player[gracz][Registered])
        SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest zarejestrowany!");
		return 1;
    if(Player[gracz][WaznoscMod] <= 0)
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie posiada moderatora!");
		return 1;
    new String[256];
    if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	format(String,sizeof(String), "DELETE FROM "PREFIX"Mods WHERE Name='%s'",Player[gracz][Name]);
	mysql_query(String);
	format(String,sizeof(String), ""I" "W"Twoje konto premium (Moderator) zostało ci odebrane przez %s.", Player[playerid][Name]);
	SCM(gracz,C_WHITE, String);
    format(String,sizeof(String), ""I" "W"Konto premium (Moderator) gracza %s zostało zdegradowane.", Player[gracz][Name]);
	SCM(playerid, C_WHITE,String);
	Player[gracz][Mod] = false;
	Player[gracz][WaznoscMod] = 0;
	return 1;
CMD:setroom(playerid,cmdtext[])
	if(!Player[playerid][Admin1]) return SCM(playerid, C_WHITE, ""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz,romek;
	if(sscanf(cmdtext,"id",gracz,romek))
	    SCM(playerid, C_WHITE, ""I" /SetRoom [ID] [Room]");
		return 1;
    if(romek <= 0)
 		SCM(playerid,C_RED,""WE" "R"Room musi być większy od 0!");
		return 1;
	if(romek > 99)
 		SCM(playerid,C_RED,""WE" "R"Room musi być mniejszy od 99!");
		return 1;
	GetPlayerRoom(gracz) = romek;
    new String[256];
	format(String,sizeof(String), ""I" "W"Administrator %s zmienił(a) ci room na %d.",Player[playerid][Name],romek);
	SCM(gracz,C_WHITE, String);
    format(String,sizeof(String), ""I" "W"Zmieniłeś room gracza %s na %d.", Player[gracz][Name],romek);
	SCM(playerid, C_WHITE,String);
	return 1;
CMD:roomall(playerid, cmdtext[])
    if(!IsPlayerAdmin(playerid)) return SCM(playerid, C_WHITE, ""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
	foreach(Player,x)
		GetPlayerRoom(x) = 0;
	SCMA(C_YELLOW, "*(ROOM) Administrator zmienił wszystkim room na domyslny!");
	return 1;
CMD:suspensionadmin(playerid,cmdtext[])
	if(!IsPlayerAdmin(playerid)) return SCM(playerid, C_WHITE, ""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz,days;
	if(sscanf(cmdtext,"id",gracz,days))
	    SCM(playerid, C_WHITE, ""I" /SuspensionAdmin [ID] [Liczba_Dni]");
		return 1;
    if(!Player[gracz][Registered])
        SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest zarejestrowany!");
		return 1;
	if(Player[gracz][WaznoscAdmin] <= 0)
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie posiada administratora!");
		return 1;
    Player[gracz][Admin2] = false;
	Player[gracz][Admin1] = false;
	Player[gracz][SuspensionAdmin] = days;
   
    new String[256];
    if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	format(String,sizeof(String), "UPDATE "PREFIX"Admins SET Suspension='%d' WHERE Name='%s'",days,Player[gracz][Name]);
	mysql_query(String);
    if(days == 0)
        format(String,sizeof(String), ""I" "W"Twoje konto administratorskie zostało odwieszone przez %s.",Player[playerid][Name]);
		SCM(gracz, C_WHITE, String);
        format(String,sizeof(String), ""I" "W"Konto administratorskie gracza %s zostało odwieszone!.",Player[gracz][Name]);
		SCM(playerid, C_WHITE,String);
		return 1;
	format(String,sizeof(String), ""I" "W"Twoje konto admina zostało zawieszone na %d dni przez %s", days, Player[playerid][Name]);
	SCM(gracz,C_WHITE, String);
    format(String,sizeof(String), ""I" "W"Konto admina gracza %s zostało zawieszone na %d dni.", Player[gracz][Name],days);
	SCM(playerid, C_WHITE,String);
	return 1;
CMD:suspensionvip(playerid,cmdtext[])
	if(!IsPlayerAdmin(playerid)) return SCM(playerid, C_WHITE, ""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz,days;
	if(sscanf(cmdtext,"id",gracz,days))
	    SCM(playerid, C_WHITE, ""I" /SuspensionVip [ID] [Liczba_Dni]");
		return 1;
    if(!Player[gracz][Registered])
        SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest zarejestrowany!");
		return 1;
	if(Player[gracz][WaznoscVip] <= 0)
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie posiada Vipa!");
		return 1;
	Player[gracz][Vip] = false;
    Player[gracz][SuspensionVip] = days;
    new String[256];
    if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	format(String,sizeof(String), "UPDATE "PREFIX"Vips SET Suspension='%d' WHERE Name='%s'",days,Player[gracz][Name]);
	mysql_query(String);
    if(days == 0)
        format(String,sizeof(String), ""I" "W"Twoje konto premium (VIP) zostało odwieszone przez %s.",Player[playerid][Name]);
		SCM(gracz, C_WHITE, String);
        format(String,sizeof(String), ""I" "W"Konto premium (VIP) gracza %s zostało odwieszone!.",Player[gracz][Name]);
		SCM(playerid, C_WHITE,String);
		return 1;
	format(String,sizeof(String), ""I" "W"Twoje konto premium (VIP) zostało zawieszone na %d dni przez %s", days, Player[playerid][Name]);
	SCM(gracz,C_WHITE, String);
    format(String,sizeof(String), ""I" "W"Konto premium (VIP) gracza %s zostało zawieszone na %d dni.", Player[gracz][Name],days);
	SCM(playerid, C_WHITE,String);
	return 1;
CMD:suspensionmod(playerid,cmdtext[])
	if(!IsPlayerAdmin(playerid)) return SCM(playerid, C_WHITE, ""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz,days;
	if(sscanf(cmdtext,"id",gracz,days))
	    SCM(playerid, C_WHITE, ""I" /SuspensionMod [ID] [Liczba_Dni]");
		return 1;
    if(!Player[gracz][Registered])
        SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest zarejestrowany!");
		return 1;
	if(Player[gracz][WaznoscMod] <= 0)
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie posiada moderatora!");
		return 1;
	Player[gracz][Mod] = false;
    Player[gracz][SuspensionMod] = days;
    new String[256];
    if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	format(String,sizeof(String), "UPDATE "PREFIX"Mods SET Suspension='%d' WHERE Name='%s'",days,Player[gracz][Name]);
	mysql_query(String);
    if(days == 0)
        format(String,sizeof(String), ""I" "W"Twoje konto premium (Moderator) zostało odwieszone przez %s.",Player[playerid][Name]);
		SCM(gracz, C_WHITE, String);
        format(String,sizeof(String), ""I" "W"Konto premium (Moderator) gracza %s zostało odwieszone!.",Player[gracz][Name]);
		SCM(playerid, C_WHITE,String);
		return 1;
	format(String,sizeof(String), ""I" "W"Twoje konto premium (Moderator) zostało zawieszone na %d dni przez %s", days, Player[playerid][Name]);
	SCM(gracz,C_WHITE, String);
    format(String,sizeof(String), ""I" "W"Konto premium (Moderator) gracza %s zostało zawieszone na %d dni.", Player[gracz][Name],days);
	SCM(playerid, C_WHITE,String);
	return 1;
CMD:onlineadmin(playerid,cmdtext[])
	if(!IsPlayerAdmin(playerid)) return SCM(playerid, C_WHITE, ""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/OnlineAdmin [ID]");
		return 1;
	Player[gracz][Admin1] = true;
	new String[128];
	format(String,sizeof(String), ""I" "W"%s dał ci admina online!", Player[playerid][Name]);
	SCM(gracz,C_WHITE, String);
	SCM(playerid, C_WHITE,""I" "W"Przyznano graczu konto administratorskie online.");
	return 1;
CMD:onlinevip(playerid,cmdtext[])
	if(!IsPlayerAdmin(playerid)) return SCM(playerid, C_WHITE, ""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/OnlineVip [ID]");
		return 1;
	Player[gracz][Vip] = true;
    new String[128];
	format(String,sizeof(String), ""I" "W"%s dał ci vip'a online!", Player[playerid][Name]);
	SCM(gracz,C_WHITE, String);
	SCM(playerid, C_WHITE,""I" "W"Przyznano graczu konto vip online.");
	return 1;
CMD:onlinemod(playerid,cmdtext[])
	if(!IsPlayerAdmin(playerid)) return SCM(playerid, C_WHITE, ""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/OnlineMod [ID]");
		return 1;
	Player[gracz][Mod] = true;
    new String[128];
	format(String,sizeof(String), ""I" "W"%s dał ci mod'a online!", Player[playerid][Name]);
	SCM(gracz,C_WHITE, String);
	SCM(playerid, C_WHITE,""I" "W"Przyznano graczu konto moderator online.");
	return 1;
CMD:onlineadminoff(playerid,cmdtext[])
	if(!IsPlayerAdmin(playerid)) return SCM(playerid, C_WHITE, ""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/OnlineAdminOff [ID]");
		return 1;
	Player[gracz][Admin1] = false;
	Player[gracz][WaznoscAdmin] = 0;
    new String[128];
	format(String,sizeof(String), ""I" "W"%s zabrał ci admina online!", Player[playerid][Name]);
	SCM(gracz,C_WHITE, String);
	SCM(playerid, C_WHITE,""I" "W"Odebrano online admina!");
	return 1;
CMD:onlinevipoff(playerid,cmdtext[])
	if(!IsPlayerAdmin(playerid)) return SCM(playerid, C_WHITE, ""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/OnlineVipOff [ID]");
		return 1;
	Player[gracz][Vip] = false;
    new String[128];
	format(String,sizeof(String), ""I" "W"%s zabrał ci vipa online!", Player[playerid][Name]);
	SCM(gracz,C_WHITE, String);
	SCM(playerid, C_WHITE,""I" "W"Odebrano online vipa!");
	return 1;
CMD:onlinemodoff(playerid,cmdtext[])
	if(!IsPlayerAdmin(playerid)) return SCM(playerid, C_WHITE, ""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"d",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/OnlineModOff [ID]");
		return 1;
	Player[gracz][Mod] = false;
    new String[128];
	format(String,sizeof(String), ""I" "W"%s zabrał ci moderatora online!", Player[playerid][Name]);
	SCM(gracz,C_WHITE, String);
	SCM(playerid, C_WHITE,""I" "W"Odebrano online moderatora!");
	return 1;
CMD:b(playerid,cmdtext[])
	return cmd_ban(playerid,cmdtext);
CMD:k(playerid,cmdtext[])
	return cmd_kick(playerid,cmdtext);
CMD:ban(playerid,cmdtext[])
	if(!Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new giveplayerid, powod[128];
	if(!sscanf(cmdtext, "ds[128]", giveplayerid, powod))
	    if(!IsPlayerConnected(giveplayerid))
			return SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
	    if(playerid == giveplayerid)
			return SCM(playerid, C_WHITE, ""E" "W"Nie możesz zbanować siebie!");
        if(Player[playerid][Mod] || Player[playerid][Admin1] && Player[giveplayerid][Admin2] || IsPlayerAdmin(giveplayerid)) return SCM(playerid, C_WHITE, ""E" "W"Ten gracz posiada wyższą rangę!");
		if(Player[playerid][Admin2] && IsPlayerAdmin(giveplayerid)) return SCM(playerid, C_WHITE, ""E" "W"Ten gracz posiada wyższą rangę!");
		new String[256];
		format(String,sizeof(String), ""W"*(B) "R2"%s "R"został zbanowany przez admina "R2"%s"R": "R2"%s", Player[giveplayerid][Name], Player[playerid][Name], powod);
		SCMA(C_ERROR, String);
	    GMBan(giveplayerid, Player[playerid][Name], powod, Player[giveplayerid][IP]);
	else
		SCM(playerid, C_WHITE, ""E" "W"/Ban [ID] [Powód]");
	return 1;
CMD:unban(playerid,cmdtext[])
	if(!Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
    new nicker[MAX_PLAYER_NAME];
	if(sscanf(cmdtext,"s[24]",nicker))
	    SCM(playerid, C_WHITE, ""I" "W"/UnBan [Nick]");
		return 1;
	new Query[128];
	if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	if(BanExists(nicker))
 		format(Query, sizeof(Query), "DELETE FROM "PREFIX"Bans WHERE Nick='%s'", nicker);
   		mysql_query(Query);
		format(Query,sizeof(Query), ""WI" "G"Nick "G2"%s "G"został prawidłowo usunięty z plików banów!",nicker);
		SCM(playerid, C_GREEN, Query);
	else
		format(Query,sizeof(Query), ""WE" "R"Nick "R2"%s "R"nie został odnaleziony!",nicker);
		SCM(playerid, C_RED, Query);
	return 1;
CMD:kick(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz,powod[64];
	if(sscanf(cmdtext,"ds[64]",gracz,powod))
	    SCM(playerid, C_WHITE, ""I" "W"/Kick [ID] [powód]");
		return 1;
    if(playerid == gracz)
		return SCM(playerid, C_WHITE, ""E" "W"Nie możesz wyrzucić siebie!");
	if(gracz < 0 || gracz >= MAX_PLAYERS) return SCM(playerid, C_WHITE, ""E" "W"Niepoprawne id gracza!");
	if(!IsPlayerConnected(gracz)) return SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
	if(Player[playerid][Mod] && Player[playerid][Admin1] || Player[gracz][Admin2] || IsPlayerAdmin(gracz)) return SCM(playerid, C_WHITE, ""E" "W"Ten gracz posiada wyższą rangę!");
	if(Player[playerid][Admin2] && IsPlayerAdmin(gracz)) return SCM(playerid, C_WHITE, ""E" "W"Ten gracz posiada wyższą rangę!");
	new tmp[185];
	format(tmp, sizeof(tmp), ""W"*(K) "R2"%s "R"został wyrzucony(a) z serwera przez "R2"%s"R": "R2"%s", Player[gracz][Name],Player[playerid][Name], powod);
	SCMA(C_ERROR, tmp);
	Player[gracz][Kicks] ++;
	GlobalKicks ++;
	Kick(gracz);
	return 1;
CMD:warn(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new userid, Reason[255];
	if(sscanf(cmdtext, "ds[255]", userid, Reason))
	    SCM(playerid, C_WHITE, ""I" "W"/warn [id gracza] [powód]");
	    return 1;
	if(userid == INVALID_PLAYER_ID)
	    SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony.");
	    return 1;
    if(Player[playerid][Mod] || Player[playerid][Admin1] && Player[userid][Admin2] || IsPlayerAdmin(userid)) return SCM(playerid, C_WHITE, ""E" "W"Ten gracz posiada wyższą rangę!");
	if(Player[playerid][Admin2] && IsPlayerAdmin(userid)) return SCM(playerid, C_WHITE, ""E" "W"Ten gracz posiada wyższą rangę!");
	Player[userid][Warns]++;
	new String[255];
	format(String, sizeof(String), ""WI" "R"%s (%d) otrzymał ostrzeżenie od admina %s.", Player[userid][Name], userid, Player[playerid][Name]);
	SCMA(C_RED, String);
	format(String, sizeof(String), ""WI" "R"Powód: %s. Ostrzeżeń: %d/3.", Reason, Player[userid][Warns]);
	SCMA(C_RED, String);
	SavePlayer(userid);
	if(Player[userid][Warns] >= 3)
		GMBan(userid,Player[playerid][Name], "Warn X3", Player[userid][IP]);
    return 1;
CMD:unwarn(playerid,cmdtext[])
	if(!Player[playerid][Admin2]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new userid;
	if(sscanf(cmdtext, "i", userid))
	    SCM(playerid, C_WHITE, ""I" "W"/unwarn [id gracza]");
	    return 1;
    if(userid == INVALID_PLAYER_ID)
	    SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony.");
	    return 1;
	if(Player[userid][Warns] <= 0)
	    SCM(playerid, C_WHITE, ""I" "W"Ten gracz nie ma ostrzeżeń.");
	    return 1;
	Player[userid][Warns] --;
	new String[255];
	format(String, sizeof(String), ""WI" "G"%s zdjął ci ostrzeżenie. Pozostało ostrzeżeń: %d/3.", Player[playerid][Name], Player[userid][Warns]);
	SCM(userid, C_GREEN, String);
	format(String, sizeof(String), ""WI" "G"Zdjąłeś ostrzeżenie graczowi %s. Pozostało ostrzeżeń: %d/3.", Player[userid][Name], Player[userid][Warns]);
	SCM(playerid, C_GREEN, String);
	return 1;
CMD:warnkick(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new userid, Reason[255];
	if(sscanf(cmdtext, "ds[255]", userid, Reason))
	    SCM(playerid, C_WHITE, ""I" "W"/warnkick [id gracza] [powód]");
	    return 1;
	if(userid == INVALID_PLAYER_ID)
	    SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony.");
	    return 1;
    if(Player[playerid][Mod] || Player[playerid][Admin1] && Player[userid][Admin2] || IsPlayerAdmin(userid)) return SCM(playerid, C_WHITE, ""E" "W"Ten gracz posiada wyższą rangę!");
	if(Player[playerid][Admin2] && IsPlayerAdmin(userid)) return SCM(playerid, C_WHITE, ""E" "W"Ten gracz posiada wyższą rangę!");
	Player[userid][WarnsKick]++;
	new String[255];
	format(String, sizeof(String), ""WI" "R"%s (%d) otrzymał ostrzeżenie od admina %s.", Player[userid][Name], userid, Player[playerid][Name]);
	SCMA(C_RED, String);
	format(String, sizeof(String), ""WI" "R"Powód: %s. Ostrzeżeń: %d/3.", Reason, Player[userid][WarnsKick]);
	SCMA(C_RED, String);
	if(Player[userid][WarnsKick] >= 3)
		Kick(userid);
    return 1;
CMD:jail(playerid, cmdtext[])
	return cmd_wiez(playerid, cmdtext);
CMD:unjail(playerid, cmdtext[])
	return cmd_unwiez(playerid, cmdtext);
CMD:wiez(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz,czas,powod[32];
	if(sscanf(cmdtext,"ids",gracz,czas,powod))
	    SCM(playerid, C_WHITE, ""I" "W"/wiez [ID] [Czas(min)] [Powód]");
		return 1;
	if(!IsPlayerConnected(gracz) || gracz < 0 || gracz >= MAX_PLAYERS) return SCM(playerid, C_RED, ""WE" "R"Ten gracz nie jest podłączony!");
	if(czas < 1 || czas > 60) return SCM(playerid, C_RED, ""WI" "R"Czas od 1 do 60 minut.");
	Wiezien[gracz] = true;
	new tmp[312];
	format(tmp, sizeof(tmp), ""WI" "R"%s trafił(a) do więziennej wyspy przez: %s na %d min za: %s", Player[gracz][Name],Player[playerid][Name],czas,powod);
	SCMA(C_RED, tmp);
	new rand = random(sizeof(CelaSpawn));
	SetPlayerPos(gracz, CelaSpawn[rand][0], CelaSpawn[rand][1], CelaSpawn[rand][2]);
	SetPlayerInterior(gracz,0);
	TogglePlayerControllable(gracz,0);
	ResetPlayerWeapons(gracz);
	SetTimerEx("JailUnfreeze",2000,0,"i",gracz);
	KillTimer(JailTimer[gracz]);
	JailTimer[gracz] = SetTimerEx("UnjailPlayer",czas*60000,0,"i",gracz);
	Player[gracz][Jail] = czas;
	return 1;
CMD:unwiez(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/unwiez [ID]");
		return 1;
	Wiezien[gracz] = false;
	SetPlayerRandomSpawn(gracz);
	new tmp[128];
	format(tmp, sizeof(tmp), "%s zostal(a) uwolniony(a) z więziennej wyspy przez: %s", Player[gracz][Name],Player[playerid][Name]);
	SCMA(C_GREEN, tmp);
	KillTimer(JailTimer[gracz]);
	Player[gracz][Jail] = 0;
	return 1;
CMD:crate(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/Crate [ID]");
		return 1;
	UnCagePlayer(gracz);
	CagePlayer(gracz);
	caged[gracz] = 1;
	new tmp[128];
	format(tmp, sizeof(tmp), ""WI" "R"%s zostal zakratowany przez %s.", Player[gracz][Name],Player[playerid][Name]);
	SCMA(C_RED, tmp);
	return 1;
CMD:uncrate(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/UnCrate [ID]");
		return 1;
	UnCagePlayer(gracz);
	caged[gracz] = 0;
	new tmp[128];
	format(tmp, sizeof(tmp), ""WI" "R"%s zostal odkratowany przez %s.", Player[gracz][Name],Player[playerid][Name]);
	SCMA(C_RED, tmp);
	return 1;
CMD:lockall(playerid)
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	for(new i=0;i<2000;i++)
		VehicleLocked[i] = MAX_PLAYERS+1;
		foreach(Player,j)
			SetVehicleParamsForPlayer(i,j,0,1);
	new string[100];
	format(string, sizeof(string), ""WI" "Y"%s zamknął wszystkie pojazdy!", Player[playerid][Name]);
	SCMA(C_YELLOW, string);
	return 1;
CMD:unlockall(playerid)
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	for(new i=0;i<2000;i++)
	    VehicleLocked[i] = -1;
		foreach(Player,j)
			SetVehicleParamsForPlayer(i,j,0,0);
	new string[100];
	format(string, sizeof(string), ""WI" "Y"%s otworzył(a) wszystkie pojazdy!", Player[playerid][Name]);
	SCMA(C_YELLOW, string);
	return 1;
CMD:invisible(playerid)
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	SetPlayerColor(playerid,0xFFFFFF00);
	SCM(playerid, C_BLUE, ""WI" {44a428}Jesteś niewidoczny(a) na mapie!");
	SCM(playerid,	C_WHITE,"Aby wyłączyć niewidzialność wpisz: /visible");
	return 1;
CMD:delcar(playerid)
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new vehid;
	new bool:block;
	vehid = GetPlayerVehicleID(playerid);
	for(new x=0;x<MAX_PRIVATE_VEHICLES;x++)
		if(vInfo[x][vID] == vehid)
			SCM(playerid,C_RED,""WE" "R" Prywatnego pojazdu nie mozna usunac!");
            PlayerPlaySound(playerid,1085,0.0,0.0,0.0);
			block = true;
			break;
	if(block) return 1;
	if(vehid < MaxPojazdow)
		SCM(playerid,C_RED,""WE" "R"Tego pojazdu nie mozna usunac!");
        PlayerPlaySound(playerid,1085,0.0,0.0,0.0);
		return 1;
	DestroyVehicleEx(vehid);
	SCM(playerid,C_GREEN,""WI" "G"Pojazd usuniety!");
	return 1;
CMD:mute(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz,czas;
	if(sscanf(cmdtext,"dd",gracz,czas))
	    SCM(playerid, C_WHITE, ""I" "W"/Mute [id] [Czas(Min)]");
		return 1;
	Player[gracz][Mute] = czas*60000;
	new tmp[256];
	format(tmp, sizeof(tmp), ""WI" "R2"%s "R"został uciszony przez "R2"%s "R"na "R2"%d "R"min.", Player[gracz][Name],Player[playerid][Name],czas);
	SCMA(C_RED, tmp);
	KillTimer(Player[gracz][MuteTimer]);
	Player[gracz][MuteTimer] = SetTimerEx("UnmutePlayer",czas*60000,0,"d",gracz);
	return 1;
CMD:unmute(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/UnMute [ID]");
		return 1;
	Player[gracz][Mute] = 0;
	new tmp[256];
	format(tmp, sizeof(tmp), ""WI" "G2"%s "G"został odciszony przez "G2"%s"G".", Player[gracz][Name],Player[playerid][Name]);
	SCMA(C_GREEN, tmp);
	KillTimer(Player[gracz][MuteTimer]);
	return 1;
CMD:unmuteall(playerid)
	if(!Player[playerid][Admin2]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	foreach(Player,x)
		Player[x][Mute] = 0;
        KillTimer(Player[x][MuteTimer]);
	new tmp[256];
	format(tmp, sizeof(tmp), ""WI" "G2"%s "G"odciszył(a) wszystkich graczy!",Player[playerid][Name]);
	SCMA(C_GREEN, tmp);
	return 1;
CMD:killp(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/Killp [ID]");
		return 1;
	SetPlayerHealth(gracz, 0);
	new tmp[256];
	format(tmp, sizeof(tmp), ""WI" "G"Zabiłeś gracza %s!", Player[gracz][Name]);
	SCM(playerid, C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G"Zostałeś zabity przez admina "G2"%s"G"!",Player[playerid][Name]);
	SCM(gracz, C_GREEN, tmp);
	return 1;
CMD:p(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new tmp[128];
	if(sscanf(cmdtext,"s[48]",tmp))
	    SCM(playerid, 0xFF0000FF, ""I" "W"/p [Nazwa]");
		return 1;
	new pojazd;
	pojazd = GetVehicleModelIDFromName(tmp);
	if(pojazd < 400 || pojazd > 611)return SCM(playerid, 0xFF0000FF, ""WE" "R"Nie znaleziono takiego pojazdu!");
	new Float:x,Float:y,Float:z;
	new Float:Angle;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,Angle);
	GetXYInFrontOfPlayer(playerid, x, y, 5);
	CreateVehicle(pojazd,x,y,z+2,Angle+90,-1,-1,1000);
	format(tmp,sizeof(tmp),""WI" "G"Utworzono pojazd o nazwie "G2"%s"G".", CarList[pojazd-400]);
	SCM(playerid,C_GREEN,tmp);
	return 1;
CMD:remove(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/Remove [ID]");
		return 1;
	if(!IsPlayerConnected(gracz))
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
		return 1;
	RemovePlayerFromVehicle(gracz);
	new tmp[256];
	format(tmp, sizeof(tmp), ""WI" "G2"%s "G"wyrzucił(a) cię z pojazdu!", Player[playerid][Name]);
	SCM(gracz,C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G"Wyrzuciłeś(aś) za pojazdu gracza "G2"%s"G".", Player[gracz][Name]);
	SCM(playerid,C_GREEN, tmp);
	return 1;
CMD:removeall(playerid)
	if(!Player[playerid][Admin2]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new string2[128];
	foreach(Player,x)
		RemovePlayerFromVehicle(x);
	format(string2, sizeof(string2), ""WI" "G2"%s "G"wyrzucił(a) wszystkich z pojazdów!", Player[playerid][Name]);
	SCMA(C_GREEN, string2);
	return 1;
CMD:agod(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
    SetPlayerHealth(playerid,9999999);
	SCM(playerid, C_GREEN, ""WI" "G"Zrobiłes(aś) się nieśmiertelnym");
	return 1;
CMD:mgod(playerid)
	if(!Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
    SetPlayerHealth(playerid,9999999);
	SCM(playerid, C_GREEN, ""WI" "G"Zrobiłes(aś) się nieśmiertelnym");
	return 1;
CMD:avehgod(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
    SetVehicleHealth(GetPlayerVehicleID(playerid),999999);
	SCM(playerid, C_GREEN, ""WI" "G"Zrobiłes(aś) swój pojazd niesniszczalnym.");
	return 1;
CMD:m(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
    SetPlayerHealth(playerid,100);
	SCM(playerid, C_GREEN, ""WI" "G"Uzdrowiłeś(aś) się!");
	return 1;
CMD:armor(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
    SetPlayerArmour(playerid,100);
	SCM(playerid, C_GREEN, ""WI" "G"Dodałeś(aś) sobie kamizelkę!");
	return 1;
CMD:ann(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new tmp[128], seconds;
	if(sscanf(cmdtext, "ds[128]", seconds, tmp))
	    SCM(playerid, C_WHITE, ""I" "W"/Ann [Czas] [Tekst]");
	    return 1;
    new nieparzyste = 0;
	new i = 0;
	while (tmp[i])
	if (tmp[i++] == '~')
	nieparzyste++;
	nieparzyste %= 2;
	if(nieparzyste)
	return SCM(playerid, C_WHITE, ""E" "W"Ilość tyld musi być parzysta!");
	format(tmp, sizeof tmp, "~h~~h~%s: %s", Player[playerid][Name],tmp);
	TextDrawSetString(AnnFade, tmp);
	foreach(Player,x)
		ShowAndHide(x, AnnFade, 0, 0, seconds*1000);
	return 1;
CMD:spec(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/Spec [ID]");
		return 1;
	if(!IsPlayerConnected(gracz))
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony.");
		return 1;
	if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
		GetPlayerPos(playerid,Player[playerid][SpecPosX],Player[playerid][SpecPosY],Player[playerid][SpecPosZ]);
		Player[playerid][SpecInt] = GetPlayerInterior(playerid);
		Player[playerid][SpecVW] = GetPlayerVirtualWorld(playerid);
	SetPlayerInterior(playerid,GetPlayerInterior(gracz));
	SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(gracz));
	TogglePlayerSpectating(playerid, 1);
	if(!IsPlayerInAnyVehicle(gracz))
		PlayerSpectatePlayer(playerid, gracz);
	else
		PlayerSpectateVehicle(playerid,GetPlayerVehicleID(gracz));
	Player[playerid][gSpectateID] = gracz;
	Player[playerid][gSpectateType] = 1;
	return 1;
CMD:specoff(playerid)
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	TogglePlayerSpectating(playerid, 0);
	Player[playerid][SpecOff] = true;
	Player[playerid][gSpectateID] = -1;
	Player[playerid][gSpectateType] = 0;
	return 1;
CMD:explode(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/Explode [ID]");
		return 1;
	new Float:x,Float:y,Float:z;
	if(IsPlayerConnected(gracz))
        new String[128];
		format(String,sizeof(String),""WI" "R"Zostałeś wysadzony przez %s!",Player[playerid][Name]);
		SCM(gracz,C_RED,String);
		GetPlayerPos(gracz,x,y,z);
		CreateExplosion(x,y,z,2,50);
	else
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
	return 1;
CMD:slap(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/Slap [ID]");
		return 1;
	if(!IsPlayerConnected(gracz))
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
		return 1;
	new Float:zycie;
	GetPlayerHealth(gracz,zycie);
	SetPlayerHealth(gracz,floatround(zycie)-10);
	new tmp[128];
	format(tmp, sizeof(tmp), ""WI" "G2"%s "G"zabrał ci 10 pkt życia!", Player[playerid][Name]);
	SCM(gracz,C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G"Zabrałeś 10 pkt życia graczowi "G2"%s"G".", Player[gracz][Name]);
	SCM(playerid,C_GREEN, tmp);
	return 1;
CMD:heal(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/Heal [ID]");
		return 1;
    if(!IsPlayerConnected(gracz))
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
		return 1;
	SetPlayerHealth(gracz,100);
    Player[gracz][Immunitet] = false;
	new tmp[128];
	format(tmp, sizeof(tmp), ""WI" "G2"%s "G"uzdrowił cię!", Player[playerid][Name]);
	SCM(gracz,C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G"Uzdrowiłeś gracza "G2"%s"G".", Player[gracz][Name]);
	SCM(playerid,C_GREEN, tmp);
	return 1;
CMD:armorid(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/ArmorID [ID]");
		return 1;
	if(!IsPlayerConnected(gracz))
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
		return 1;
	SetPlayerArmour(gracz,100);
	new tmp[128];
	format(tmp, sizeof(tmp), ""WI" "G2"%s "G"dał ci kamizelkę kuloodporną.", Player[playerid][Name]);
	SCM(gracz,C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G"Dałeś pancerz graczowi "G2"%s"G".", Player[gracz][Name]);
	SCM(playerid,C_GREEN, tmp);
	return 1;
CMD:asweapons(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	GivePlayerWeapon(playerid, 24, 9999);
	GivePlayerWeapon(playerid, 27, 9999);
	GivePlayerWeapon(playerid, 31, 9999);
	GivePlayerWeapon(playerid, 38, 9999);
	GivePlayerWeapon(playerid, 39, 9999);
	GivePlayerWeapon(playerid, 42, 9999);
    PlaySoundForPlayer(playerid, 30800);
	return 1;
CMD:clickmap(playerid)
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	if(!Player[playerid][ClickMapON])
        Player[playerid][ClickMapON] = true;
        SCM(playerid,C_WHITE,""I" "W"Od teraz po zaznaczeniu punktu na mapie przeniesiesz się tam. Aby to wyłączyć wpisz ponownie /clickmap.");
	else
        Player[playerid][ClickMapON] = false;
        SCM(playerid,C_WHITE,""I" "W"Teleportowanie po kliknięciu na mapie wyłączone.");
	return 1;
CMD:givecash(playerid,cmdtext[])
	new gracz,kasa;
	if(sscanf(cmdtext,"id",gracz,kasa))
	    SCM(playerid, C_WHITE, ""I" "W"/GiveCash [ID] [Kwota]");
		return 1;
	if(kasa < 0)
	    SCM(playerid,C_WHITE,""I" "W"Niepoprawna kwota!");
		return 1;
    if(kasa > 10000 && !Player[playerid][Admin1] && !Player[playerid][Mod])
	    SCM(playerid,C_WHITE,""I" "W"Jednorazowo możesz dawać po 10.000!");
		return 1;
	if(Player[playerid][Money] < kasa && !Player[playerid][Admin1] && !Player[playerid][Mod])
     	SCM(playerid, C_WHITE, ""I" "W"Nie masz tyle pieniędzy!");
		return 1;
	if(!IsPlayerConnected(gracz))
     	SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
		return 1;
	if(!Player[playerid][Admin1] && !Player[playerid][Mod])
		GivePlayerMoney(playerid, (0 - kasa));
        Player[playerid][Money] += (0- kasa);
	GivePlayerMoney(gracz, kasa);
    Player[gracz][Money] += kasa;
	new tmp[256];
	if(!Player[playerid][Admin1] || !Player[playerid][Mod])
		format(tmp, sizeof(tmp), ""WI" "G"Oddałeś graczowi "G2"%s"G", "G2"%d$ "G"pieniędzy.",Player[gracz][Name],kasa);
		SCM(playerid, C_GREEN, tmp);
		format(tmp, sizeof(tmp), ""WI" "G"Dostałeś "G2"%d$ "G"pieniędzy od gracza "G2"%s"G".", kasa, Player[playerid][Name]);
		SCM(gracz, C_GREEN, tmp);
	else
		format(tmp, sizeof(tmp), ""WI" "G"Dodałeś graczowi "G2"%s"G", "G2"%d$ "G"pieniędzy.",Player[gracz][Name],kasa);
		SCM(playerid, C_GREEN, tmp);
		format(tmp, sizeof(tmp), ""WI" "G"Dostałeś "G2"%d$ "G"pieniędzy od "G2"%s"G".", kasa, Player[playerid][Name]);
		SCM(gracz, C_GREEN, tmp);
	return 1;
CMD:setcash(playerid,cmdtext[])
	if(!Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz,kasa;
	if(sscanf(cmdtext,"id",gracz,kasa))
	    SCM(playerid, C_WHITE, ""I" "W"/SetCash [ID] [Kwota]");
		return 1;
	if(!IsPlayerConnected(gracz))
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
		return 1;
	new kasagracza;
	kasagracza = Player[gracz][Money];
	GivePlayerMoney(gracz,0-kasagracza);
	GivePlayerMoney(gracz,kasa);
    Player[gracz][Money] += 0-kasagracza;
    Player[gracz][Money] += kasa;
	new tmp[128];
	format(tmp, sizeof(tmp), ""WI" "G2"%s "G"ustawił twoje pieniądze na "G2"%d$"G".", Player[playerid][Name],kasa);
	SCM(gracz,C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G"Ustawiłeś graczowi "G2"%s "G"pieniądze na "G2"%d$"G".", Player[gracz][Name],kasa);
	SCM(playerid,C_GREEN, tmp);
	return 1;
CMD:resetcash(playerid,cmdtext[])
	if(!Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/ResetCash [ID]");
		return 1;
	if(!IsPlayerConnected(gracz))
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
		return 1;
	new kasagracza = Player[gracz][Money];
	GivePlayerMoney(gracz,0-kasagracza);
	Player[gracz][Money] += 0-kasagracza;
	new tmp[128];
	format(tmp, sizeof(tmp), ""WI" "G2"%s "G"zresetował ci pieniądze.", Player[playerid][Name]);
	SCM(gracz,C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G"Zresetowałeś(aś) pieniądze graczowi "G2"%s"G".", Player[gracz][Name]);
	SCM(playerid,C_GREEN, tmp);
	return 1;
CMD:jetpack(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
        SCM(playerid, C_WHITE, ""I" "W"/Jetpack [ID]");
		return 1;
	if(!IsPlayerConnected(gracz))
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
		return 1;
	SetPlayerSpecialAction(gracz, 2);
	new tmp[128];
	format(tmp, sizeof(tmp), ""WI" "G2"%s "G"dał ci jetpacka.", Player[playerid][Name]);
	SCM(gracz,C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G"Dałeś jetpacka graczowi "G2"%s"G".", Player[gracz][Name]);
	SCM(playerid,C_GREEN, tmp);
	return 1;
CMD:weather(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new pogoda;
	if(sscanf(cmdtext,"d",pogoda))
	    SCM(playerid, C_WHITE, ""I" "W"/Weather [ID_Pogody]");
		return 1;
	SetWeather(pogoda);
	new tmp[128];
	format(tmp, sizeof(tmp), ""WI" "G2"%s "G"Ustawił(a) pogodę o identyfikatorze "G2"%d"G".", Player[playerid][Name],pogoda);
	SCMA(C_GREEN, tmp);
	return 1;
CMD:settime(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new godzina;
	if(sscanf(cmdtext,"d",godzina))
	    SCM(playerid, C_WHITE, ""I" "W"/SetTime [Godzina]");
		return 1;
	if(godzina > 24 || godzina < 0)
		SCM(playerid, C_WHITE, ""I" "W"Niepoprawna godzina! Od 0 do 24.");
		return 1;
	SetWorldTime(godzina);
	new tmp[128];
	format(tmp, sizeof(tmp), ""WI" "G2"%s "G2"ustawił godzinę na serwerze "G2"%d"G".", Player[playerid][Name],godzina);
	SCMA(C_GREEN, tmp);
	return 1;
CMD:a(playerid,cmdtext[])
	if(!Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new tmp[155];
	if(sscanf(cmdtext,"s[155]",tmp))
		SCM(playerid, C_WHITE, ""I" "W"/A [tekst]");
		return 1;
	format(tmp, sizeof(tmp), "[AdminChat] "W"- %s (%d): {FF0000}%s",Player[playerid][Name],playerid,tmp);
	SendClientMessageToAdmins(C_ERROR, tmp);
	return 1;
CMD:tt(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/TT [ID]");
		return 1;
	new Float:pX, Float:pY, Float:pZ;
	GetPlayerPos(gracz, pX,pY,pZ);
	new inte,world;
	inte = GetPlayerInterior(gracz);
	world = GetPlayerVirtualWorld(gracz);
	SetPlayerPos(playerid, pX,pY,pZ);
	SetPlayerInterior(playerid, inte);
	SetPlayerVirtualWorld(playerid,world);
	new tmp[128];
	format(tmp, sizeof(tmp), ""WI" "G"Teleportowano się do gracza "G2"%s"G".", Player[gracz][Name]);
	SCM(playerid, C_GREEN, tmp);
	return 1;
CMD:th(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
        SCM(playerid, C_WHITE, ""I" "W"/TH [ID]");
		return 1;
	new Float:pX, Float:pY, Float:pZ;
	new inte,world;
	GetPlayerPos(playerid, pX,pY,pZ);
	inte = GetPlayerInterior(playerid);
	world = GetPlayerVirtualWorld(playerid);
	SetPlayerPos(gracz, pX,pY,pZ);
	SetPlayerInterior(gracz, inte);
	SetPlayerVirtualWorld(gracz,world);
	new tmp[128];
	format(tmp, sizeof(tmp), ""WI" "G"Teleportowano do siebie gracza "G2"%s"G".", Player[gracz][Name]);
	SCM(playerid, C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G2"%s"G", teleportował cię do siebie.", Player[playerid][Name]);
	SCM(gracz, C_GREEN, tmp);
	return 1;
CMD:tp(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz1,gracz2;
	if(sscanf(cmdtext,"ii",gracz1,gracz2))
	    SCM(playerid, C_WHITE, ""I" "W"/TP [ID] do [ID]");
		return 1;
	if(!IsPlayerConnected(gracz1))
		SCM(playerid, C_WHITE, ""I" "W"Gracz nr.1 nie jest podłączony!");
		return 1;
	if(!IsPlayerConnected(gracz2))
		SCM(playerid, C_WHITE, ""I" "W"Gracz nr.2 nie jest podłączony!");
		return 1;
    if(Player[gracz1][OnCombat] || Player[gracz1][OnOnede] || Player[gracz1][OnMinigun] || Player[gracz1][OnRPG]) return SCM(playerid, C_WHITE, ""E" "W"Gracz nr.1 jest na arenie!");
    if(Player[gracz2][OnCombat] || Player[gracz2][OnOnede] || Player[gracz2][OnMinigun] || Player[gracz2][OnRPG]) return SCM(playerid, C_WHITE, ""E" "W"Gracz nr.2 jest na arenie!");
    if(Player[playerid][OnOnede] || Player[playerid][OnCombat] || Player[playerid][OnMinigun] || Player[playerid][OnRPG]) return SCM(playerid, C_WHITE, ""E" "W"Musisz wyjść z areny! /ArenaExit.");
	new Float:x,Float:y,Float:z;
	new interior,world;
	GetPlayerPos(gracz2,x,y,z);
	interior = GetPlayerInterior(gracz2);
	world = GetPlayerVirtualWorld(gracz2);
	if(!IsPlayerInAnyVehicle(gracz1))
		SetPlayerPos(gracz1,x,y,z);
		SetPlayerInterior(gracz1,interior);
		SetPlayerVirtualWorld(gracz1,world);
	else{
		SetVehiclePos(GetPlayerVehicleID(gracz1),x,y,z);
		LinkVehicleToInterior(GetPlayerVehicleID(gracz1),interior);
		SetVehicleVirtualWorld(GetPlayerVehicleID(gracz1),world);
	new tmp[155];
	format(tmp, sizeof(tmp), ""WI" "G2"%s "G"teleportował cię do gracza "G2"%s"G".", Player[playerid][Name],Player[gracz2][Name]);
	SCM(gracz1,C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G2"%s "G"teleportował do ciebie gracza "G2"%s"G".", Player[playerid][Name],Player[gracz1][Name]);
	SCM(gracz2,C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G"Teleportowałeś gracza "G2"%s "G"do gracza "G2"%s"G".", Player[gracz1][Name],Player[gracz2][Name]);
	SCM(playerid,C_GREEN, tmp);
	return 1;
CMD:upingp(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz,wysokosc;
	if(sscanf(cmdtext,"id",gracz,wysokosc))
	    SCM(playerid, C_WHITE, ""I" "W"/UpingP [ID] [Wysokosć]");
		return 1;
	if(wysokosc < 0 || wysokosc > 20000)
		SCM(playerid, C_WHITE, ""I" "W"Podaj wysokość od 0 do 20000.");
		return 1;
	if(!IsPlayerConnected(gracz))
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
		return 1;
	new Float:x,Float:y,Float:z;
	GetPlayerPos(gracz,x,y,z);
	if(!IsPlayerInAnyVehicle(gracz))
		SetPlayerPos(gracz,x,y,z+wysokosc);
	else{
		SetVehiclePos(GetPlayerVehicleID(gracz),x,y,z+wysokosc);
	new tmp[128];
	format(tmp, sizeof(tmp), ""WI" "G2"%s "G"zwiększył twoją wysokość o "G2"%d "G"m.", Player[playerid][Name],wysokosc);
	SCM(gracz,C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G"Zwiększyłeś graczowi "G2"%s "G"wysokość o "G2"%d "G"m.", Player[gracz][Name],wysokosc);
	SCM(playerid,C_GREEN, tmp);
	return 1;
CMD:downingp(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz,wysokosc;
	if(sscanf(cmdtext,"id",gracz,wysokosc))
	    SCM(playerid, C_WHITE, ""I" "W"/DowningP [ID] [Wysokość]");
		return 1;
	if(wysokosc < 0 || wysokosc > 20000)
		SCM(playerid, C_WHITE, ""I" "W"Podaj wysokość od 0 do 20000.");
		return 1;
	if(!IsPlayerConnected(gracz))
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
		return 1;
	new Float:x,Float:y,Float:z;
	GetPlayerPos(gracz,x,y,z);
	if(!IsPlayerInAnyVehicle(gracz))
		SetPlayerPos(gracz,x,y,z-wysokosc);
	else{
		SetVehiclePos(GetPlayerVehicleID(gracz),x,y,z-wysokosc);
	new tmp[128];
	format(tmp, sizeof(tmp), ""WI" "G2"%s "G"zmniejszył twoją wysokość o "G2"%d "G"m.", Player[playerid][Name],wysokosc);
	SCM(gracz,C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G"Zmniejszyłeś graczowi "G2"%s "G"wysokość o "G2"%d "G"m.", Player[gracz][Name],wysokosc);
	SCM(playerid,C_GREEN, tmp);
	return 1;
CMD:uping(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new wysokosc;
	if(sscanf(cmdtext,"d",wysokosc))
	    SCM(playerid, C_WHITE, ""I" "W"/Uping [Wysokość]");
		return 1;
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	if(!IsPlayerInAnyVehicle(playerid))
		SetPlayerPos(playerid,x,y,z+wysokosc);
	else{
		SetVehiclePos(GetPlayerVehicleID(playerid),x,y,z+wysokosc);
	new tmp[128];
	format(tmp, sizeof(tmp), ""WI" "G"Zwiększyłeś sobie wysokość o "G2"%d "G"m.", wysokosc);
	SCM(playerid,C_GREEN, tmp);
	return 1;
CMD:downing(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new wysokosc;
	if(sscanf(cmdtext,"d",wysokosc))
	    SCM(playerid, C_WHITE, ""I" "W"/Downing [Wysokość]");
		return 1;
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	if(!IsPlayerInAnyVehicle(playerid))
		SetPlayerPos(playerid,x,y,z-wysokosc);
	else{
		SetVehiclePos(GetPlayerVehicleID(playerid),x,y,z-wysokosc);
	new tmp[128];
	format(tmp, sizeof(tmp), ""WI" "G"Zmniejszyłeś sobie wysokość o "G2"%d "G"m.", wysokosc);
	SCM(playerid,C_GREEN, tmp);
	return 1;
CMD:setip(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz,interior;
	if(sscanf(cmdtext,"id",gracz,interior))
	    SCM(playerid, C_WHITE, ""I" "W"/SetIP [ID] [Interior]");
		return 1;
	if(interior < 0)
		SCM(playerid, C_WHITE, ""I" "W"Podałeś(aś) złe id interioru!");
		return 1;
	if(!IsPlayerConnected(gracz))
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
		return 1;
	SetPlayerInterior(gracz,interior);
	new tmp[128];
	format(tmp, sizeof(tmp), ""WI" "G2"%s "G"przerzucił cię do interioru "G2"%d"G".", Player[playerid][Name],interior);
	SCM(gracz,C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G"Przerzuciłeś gracza "G2"%s "G"do interioru "G2"%d"G".", Player[gracz][Name],interior);
	SCM(playerid,C_GREEN, tmp);
	return 1;
CMD:repair(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/Repair [ID]");
		return 1;
	if(!IsPlayerConnected(gracz))
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
		return 1;
	if(!IsPlayerInAnyVehicle(gracz))
	    SCM(playerid, C_WHITE, ""I" "W"Ten gracz nie jest w pojeździe!");
		return 1;
	new veh = GetPlayerVehicleID(gracz);
	RepairVehicle(veh);
	new tmp[128];
	format(tmp, sizeof(tmp), ""WI" "G2"%s "G"naprawił twój pojazd.", Player[playerid][Name]);
	SCM(gracz,C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G"Naprawiłeś pojazd graczowi "G2"%s"G".", Player[gracz][Name]);
	SCM(playerid,C_GREEN, tmp);
	return 1;
CMD:setworld(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz,world;
	if(sscanf(cmdtext,"id",gracz,world))
	    SCM(playerid, C_WHITE, ""I" "W"/SetWorld [ID] [VirtualWorld]");
		return 1;
	if(world < 0)
		SCM(playerid, C_WHITE, ""I" "W"Podałeś(aś) złe id VirtualWorlda.");
		return 1;
	if(!IsPlayerConnected(gracz))
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
		return 1;
	SetPlayerVirtualWorld(gracz,world);
	new tmp[155];
	format(tmp, sizeof(tmp), ""WI" "G2"%s "G"zmienił ci Virtual Worlda na "G2"%d"G".", Player[playerid][Name],world);
	SCM(gracz,C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G"Zmieniłeś Vitrual World graczowi "G2"%s "G"na "G2"%d"G".", Player[gracz][Name],world);
	SCM(playerid,C_GREEN, tmp);
	return 1;
CMD:skinp(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz,myskin;
	if(sscanf(cmdtext,"id",gracz,myskin))
	    SCM(playerid, C_WHITE, ""I" "W"/SkinP [ID] [Skin]");
		return 1;
	if(myskin == 74 || myskin == 268 || myskin < 0 || myskin > 299)
		SCM(playerid, C_WHITE, ""I" "W"Niepoprawne ID Skina!");
		return 1;
	if(!IsPlayerConnected(gracz))
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
		return 1;
	SetPlayerSkin(gracz,myskin);
	new tmp[80];
	format(tmp, sizeof(tmp), ""WI" "G"%s zmienił ci skina na %d.", Player[playerid][Name],myskin);
	SCM(gracz,C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G"Zmieniłeś graczowi %s skina na %d.", Player[gracz][Name],myskin);
	SCM(playerid,C_GREEN, tmp);
	return 1;
CMD:freeze(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/Freeze [ID]");
		return 1;
	TogglePlayerControllable(gracz,0);
	new tmp[128];
	format(tmp, sizeof(tmp), ""WI" "G"%s zamroził cię!", Player[playerid][Name]);
	SCM(gracz,C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G"Zamroziłeś gracza %s.", Player[gracz][Name]);
	SCM(playerid,C_GREEN, tmp);
    Player[gracz][Freeze] = true;
	return 1;
CMD:unfreeze(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/UnFreeze [ID]");
		return 1;
	TogglePlayerControllable(gracz,1);
	new tmp[128];
	format(tmp, sizeof(tmp), ""WI" "G"%s odmroził cię!", Player[playerid][Name]);
	SCM(gracz,C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G"Odmroziłeś gracza %s.", Player[gracz][Name]);
	SCM(playerid,C_GREEN, tmp);
    Player[gracz][Freeze] = false;
	return 1;
CMD:acolor(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new colorplayer,color;
	if(sscanf(cmdtext,"dd",colorplayer,color))
	    SCM(playerid, C_WHITE, ""I" "W"/Acolor [ID] [ID Koloru]");
		return 1;
	if(color == 1)
		SetPlayerColor(colorplayer, C_GREY);
		Player[colorplayer][Color] = C_GREY;
        format(Player[colorplayer][ChatColor],15,HexToString(Player[colorplayer][Color]));
	else if(color == 2)
		SetPlayerColor(colorplayer, C_LIGHTGREEN);
        Player[colorplayer][Color] = C_LIGHTGREEN;
        format(Player[colorplayer][ChatColor],15,HexToString(Player[colorplayer][Color]));
	else if(color == 3)
		SetPlayerColor(colorplayer, C_RED);
        Player[colorplayer][Color] = C_RED;
        format(Player[colorplayer][ChatColor],15,HexToString(Player[colorplayer][Color]));
	else if(color == 4)
		SetPlayerColor(colorplayer, C_YELLOW);
        Player[colorplayer][Color] = C_YELLOW;
        format(Player[colorplayer][ChatColor],15,HexToString(Player[colorplayer][Color]));
	else if(color == 5)
		SetPlayerColor(colorplayer, C_WHITE);
        Player[colorplayer][Color] = C_WHITE;
        format(Player[colorplayer][ChatColor],15,HexToString(Player[colorplayer][Color]));
	else if(color == 6)
		SetPlayerColor(colorplayer, C_BLUE);
        Player[colorplayer][Color] = C_BLUE;
        format(Player[colorplayer][ChatColor],15,HexToString(Player[colorplayer][Color]));
	else if(color == 7)
		SetPlayerColor(colorplayer, C_ORANGE);
        Player[colorplayer][Color] = C_ORANGE;
        format(Player[colorplayer][ChatColor],15,HexToString(Player[colorplayer][Color]));
	else if(color == 8)
		SetPlayerColor(colorplayer, C_PINK);
        Player[colorplayer][Color] = C_PINK;
        format(Player[colorplayer][ChatColor],15,HexToString(Player[colorplayer][Color]));
	else if(color == 9)
		SetPlayerColor(colorplayer, 0xFFFFFF00);
        Player[colorplayer][Color] = 0xFFFFFF00;
        format(Player[colorplayer][ChatColor],15,HexToString(Player[colorplayer][Color]));
	else if(color == 10)
		SetPlayerColor(colorplayer, C_VIOLET);
        Player[colorplayer][Color] = C_VIOLET;
        format(Player[colorplayer][ChatColor],15,HexToString(Player[colorplayer][Color]));
	else if(color == 11)
		SetPlayerColor(colorplayer, C_BLACK);
	    Player[colorplayer][Color] = C_BLACK;
        format(Player[colorplayer][ChatColor],15,HexToString(Player[colorplayer][Color]));
	else if(color == 12)
		SetPlayerColor(colorplayer, C_BROWN);
        Player[colorplayer][Color] = C_BROWN;
        format(Player[colorplayer][ChatColor],15,HexToString(Player[colorplayer][Color]));
	else if(color == 13)
		SetPlayerColor(colorplayer, C_LIGHTBLUE);
        Player[colorplayer][Color] = C_LIGHTBLUE;
        format(Player[colorplayer][ChatColor],15,HexToString(Player[colorplayer][Color]));
	else if(color == 14)
		SetPlayerColor(colorplayer, C_GREEN);
        Player[colorplayer][Color] = C_GREEN;
        format(Player[colorplayer][ChatColor],15,HexToString(Player[colorplayer][Color]));
	else if(color == 15)
		SetPlayerColor(colorplayer, C_KREM);
        Player[colorplayer][Color] = C_KREM;
        format(Player[colorplayer][ChatColor],15,HexToString(Player[colorplayer][Color]));
	else if(color == 16)
		SetPlayerColor(colorplayer, C_ERROR);
        Player[colorplayer][Color] = C_ERROR;
        format(Player[colorplayer][ChatColor],15,HexToString(Player[colorplayer][Color]));
	else
		SCM(playerid, C_WHITE, ""I" "W"Niepoprawny kolor! Od 1 do 16.");
	new tmp[140];
	format(tmp, sizeof(tmp), ""WI" "G"Zmieniłeś kolor graczowi %s na %d.",Player[colorplayer][Name], color);
	SCM(playerid,C_GREEN,tmp);
	format(tmp, sizeof(tmp), ""WI" "G"%s zmienił ci kolor nicku.",Player[playerid][Name]);
	SCM(colorplayer,C_GREEN,tmp);
	return 1;
CMD:god(playerid,cmdtext[])
	if(!Player[playerid][Admin2]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/God [ID]");
		return 1;
	if(!IsPlayerConnected(gracz))
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
		return 1;
 	SetPlayerHealth(gracz,9999999);
    Player[gracz][Immunitet] = true;
	new tmp[90];
	format(tmp, sizeof(tmp), ""WI" "G"%s zrobił cię nieśmiertelnym.", Player[playerid][Name]);
	SCM(gracz,C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G"Dałeś nieśmiertelność graczowi %s.", Player[gracz][Name]);
	SCM(playerid,C_GREEN, tmp);
	return 1;
CMD:godall(playerid)
	if(!Player[playerid][Admin2]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	foreach(Player,x)
		SetPlayerHealth(x,9999999);
	new string2[90];
	format(string2, sizeof(string2), ""WI" "G"%s dał nieśmiertelność wszystkim graczom!", Player[playerid][Name]);
	SCMA(C_GREEN, string2);
	return 1;
CMD:giveexp(playerid, cmdtext[])
	if(!Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new userid, nExp;
	if(sscanf(cmdtext, "id", userid, nExp))
		SCM(playerid, C_WHITE, ""I" "W"/GiveExp [ID] [Ilość]");
		return 1;
	if(userid == INVALID_PLAYER_ID)
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
		return 1;
	if(nExp < -99999 || nExp > 99999)
		SCM(playerid, C_WHITE, ""I" "W"Niepoprawna ilość exp!");
		return 1;
	Player[userid][Exp] += nExp;
	Player[userid][Level] = GetPlayerLevel(userid);
	new String[255];
	format(String, sizeof(String), ""WI" "G"Dodano %d Exp graczowi %s (%d).", nExp, Player[userid][Name], userid);
	SCM(playerid, C_GREEN, String);
	format(String, sizeof(String), ""WI" "G"Administrator %s (%d) dodał Ci %d Exp.", Player[playerid][Name], playerid, nExp);
	SCM(userid, C_GREEN, String);
	return 1;
CMD:setexp(playerid, cmdtext[])
	if(!Player[playerid][Admin2]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new userid, nExp;
	if(sscanf(cmdtext, "id", userid, nExp))
		SCM(playerid, C_WHITE, ""I" "W"/SetExp [ID] [Ilość]");
		return 1;
	if(userid == INVALID_PLAYER_ID)
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
		return 1;
	if(nExp < -99999 || nExp > 99999)
		SCM(playerid, C_WHITE, ""I" "W"Niepoprawna ilość exp!");
		return 1;
	Player[userid][Exp] = nExp;
	Player[userid][Level] = GetPlayerLevel(userid);
	new String[150];
	format(String, sizeof(String), ""WI" "G"Zmieniłeś(aś) Exp graczowi %s (%d) na %d.", Player[userid][Name], userid, nExp);
	SCM(playerid, C_GREEN, String);
	format(String, sizeof(String), ""WI" "G"Administrator %s (%d) zmienił Ci exp na %d.", Player[playerid][Name], playerid, nExp);
	SCM(userid, C_GREEN, String);
	return 1;
CMD:giveexpall(playerid, cmdtext[])
	if(!Player[playerid][Admin2]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new GiveExp;
	if(sscanf(cmdtext, "d", GiveExp))
	    SCM(playerid, C_WHITE, ""I" "W"/GiveExpAll [Ilość]");
	    return 1;
	/*
	if(GiveExp < 1)
	    SCM(playerid, C_WHITE, ""I" "W"Niepoprawna ilość exp.");
	    return 1;
	*/
	foreach(Player,x)
		Player[x][Exp] += GiveExp;
        Player[x][Level] = GetPlayerLevel(x);
	new String[150];
	format(String, sizeof(String), ""WI" "G"Administrator %s (%d) dał wszystkim %d exp.", Player[playerid][Name], playerid, GiveExp);
	SCMA(C_GREEN, String);
    return 1;
CMD:da50(playerid)
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new string2[100];
	format(string2, sizeof(string2), ""WI" "G"Zostałeś rozbrojony przez %s.",Player[playerid][Name]);
	foreach(Player,x)
		if(GetDistanceBetweenPlayers(playerid,x) <= 50)
			ResetPlayerWeapons(x);
			SCM(x,C_GREEN, string2);
	SCM(playerid,C_GREEN,""WI" "G"Rozbrojono graczy w zasięgu 50 metrów.");
	return 1;
CMD:l(playerid,cmdtext[])
    new tmp[135];
	if(sscanf(cmdtext, "s[135]", tmp))
	    SCM(playerid, C_WHITE, ""I" "W"/L [Tekst]");
	    return 1;
	format(tmp, sizeof(tmp), "[Czat 50m] %s: "W"%s",Player[playerid][Name],tmp);
	foreach(Player,x)
		if(GetDistanceBetweenPlayers(playerid,x) <= 50)
			SCM(x,0xE80000FF, tmp);
	return 1;
CMD:sound50(playerid,cmdtext[])
	if(!IsPlayerAdmin(playerid)) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new string2[255];
	format(string2, sizeof(string2), ""WI" "G"Włączono muzykę przez %s.",Player[playerid][Name]);
	foreach(Player,x)
		if(GetDistanceBetweenPlayers(playerid,x) <= 50)
			PlayAudioStreamForPlayer(x, cmdtext);
			SCM(x,C_GREEN, string2);
	return 1;
CMD:giveexp50(playerid,cmdtext[])
	if(!Player[playerid][Admin2]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
    new GiveExp;
	if(sscanf(cmdtext, "d", GiveExp))
	    SCM(playerid, C_WHITE, ""I" "W"/GiveExp50 [Ilość]");
	    return 1;
	if(GiveExp < 1)
	    SCM(playerid, C_WHITE, ""I" "W"Niepoprawna ilość exp.");
	    return 1;
	new string2[120];
	format(string2, sizeof(string2), ""WI" "G"Dostałeś(aś) %d exp od admina %s.",GiveExp,Player[playerid][Name]);
	foreach(Player,x)
		if(GetDistanceBetweenPlayers(playerid,x) <= 50)
			Player[x][Exp] += GiveExp;
        	Player[x][Level] = GetPlayerLevel(x);
			SCM(x,C_GREEN, string2);
	SCM(playerid,C_GREEN,""WI" "G"Dodano exp graczom w zasięgu 50 metrów.");
	return 1;
CMD:giveportfel(playerid, cmdtext[])
	if(!IsPlayerAdmin(playerid)) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new userid, nPortfel;
	if(sscanf(cmdtext, "id", userid, nPortfel))
		SCM(playerid, C_WHITE, ""I" "W"/GivePortfel [ID] [Ilość]");
		return 1;
	if(userid == INVALID_PLAYER_ID)
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
		return 1;
	if(nPortfel < -10 || nPortfel > 10)
		SCM(playerid, C_WHITE, ""I" "W"Niepoprawna ilość pieniędzy!");
		return 1;
	Player[userid][Portfel] += nPortfel;
	new String[255];
    if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	format(String, sizeof(String), "UPDATE "PREFIX"Users SET Portfel='%d' WHERE Name='%s'",Player[userid][Portfel],Player[userid][Name]);
	mysql_query(String);
	format(String, sizeof(String), ""WI" "G"Dodano %d pieniędzy do portfela graczowi %s (%d).", nPortfel, Player[userid][Name], userid);
	SCM(playerid, C_GREEN, String);
	format(String, sizeof(String), ""WI" "G"Administrator %s (%d) zasilił(a) twój portfel kwotą %d zł.", Player[playerid][Name], playerid, nPortfel);
	SCM(userid, C_GREEN, String);
  
	return 1;
CMD:maxping(playerid, cmdtext[])
	if(!IsPlayerAdmin(playerid)) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new ping;
	if(sscanf(cmdtext, "d", ping))
		SCM(playerid, C_WHITE, ""I" "W"/MaxPing [Maksymalny Ping]");
		return 1;
	if(ping < 100 || ping > 10000)
		SCM(playerid, C_WHITE, ""I" "W"Niepoprawny ping! (100-10000) Domyślnie: 550.");
		return 1;
	MaxPing = ping;
    SaveConfigs();
	new String[128];
	format(String, sizeof(String), ""WI" "G"Admin %s zmienił(a) maksymalny ping na %d.", Player[playerid][Name], ping);
	SCMA(C_GREEN, String);
	return 1;
CMD:setadminpass(playerid, cmdtext[])
	if(!IsPlayerAdmin(playerid)) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new haselko[32];
	if(sscanf(cmdtext, "s", haselko))
		SCM(playerid, C_WHITE, ""I" "W"/NewAdminPass [Hasło]");
		return 1;
	if(strlen(haselko) <= 5 || strlen(haselko) > 32)
		SCM(playerid, C_WHITE, ""I" "W"Niepoprawna ilość znaków w haśle! (5-32)");
		return 1;
	format(AdminPass,32,MD5_Hash(haselko));
    SaveConfigs();
	new String[128];
	format(String, sizeof(String), ""WI" "G"%s zmienił(a) hasło administratorskie na: %s", Player[playerid][Name], haselko);
	SendClientMessageToAdmins(C_GREEN, String);
	return 1;
CMD:setrconpass(playerid, cmdtext[])
	if(!IsPlayerAdmin(playerid)) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new haselko[32];
	if(sscanf(cmdtext, "s", haselko))
		SCM(playerid, C_WHITE, ""I" "W"/NewRconPass [Hasło]");
		return 1;
	if(strlen(haselko) <= 5 || strlen(haselko) > 32)
		SCM(playerid, C_WHITE, ""I" "W"Niepoprawna ilość znaków w haśle! (5-32)");
		return 1;
	format(RconPass,32,MD5_Hash(haselko));
    SaveConfigs();
	new String[128];
	format(String, sizeof(String), ""WI" "G"Zmieniłeś(aś) 2 hasło rcon na: %s",haselko);
	SCM(playerid, C_GREEN, String);
	return 1;
CMD:tp50here(playerid)
	if(!Player[playerid][Admin2]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new string2[100];
	format(string2, sizeof(string2), ""WI" "G"Zostałeś teleportowany do %s.",Player[playerid][Name]);
    new interior = GetPlayerInterior(playerid);
	new Float:x2,Float:y,Float:z;
	GetPlayerPos(playerid,x2,y,z);
	foreach(Player,x)
		if(GetDistanceBetweenPlayers(playerid,x) <= 50)
			SetPlayerInterior(x,interior);
			SetPlayerPos(x,x2,y,z);
			SCM(x,C_GREEN, string2);
	SCM(playerid,C_GREEN,""WI" "G"Teleportowano do siebie graczy w zasięgu 50 metrów.");
	return 1;
CMD:vehgod(playerid,cmdtext[])
	if(!Player[playerid][Admin2]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/VehGod [ID]");
		return 1;
	if(!IsPlayerConnected(gracz))
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
		return 1;
	new veh = GetPlayerVehicleID(gracz);
	RepairVehicle(veh);
	SetVehicleHealth(veh,999999);
	new tmp[110];
	format(tmp, sizeof(tmp), ""WI" "G"%s zrobił twój pojazd niezniszczalnym.", Player[playerid][Name]);
	SCM(gracz,C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G"Pojazd gracza %s stał się niezniszczalny.", Player[gracz][Name]);
	SCM(playerid,C_GREEN, tmp);
	return 1;
CMD:vehgodall(playerid)
	if(!Player[playerid][Admin2]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new string2[100];
	foreach(Player,x)
		if(IsPlayerInAnyVehicle(x))
			SetVehicleHealth(GetPlayerVehicleID(x),999999);
	format(string2, sizeof(string2), ""WI" "G"%s zrobił wszystkim niezniszczalne pojazdy!", Player[playerid][Name]);
	SCMA(C_GREEN, string2);
	return 1;
CMD:disarmall(playerid)
	if(!Player[playerid][Admin2]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new string2[90];
	foreach(Player,x)
		ResetPlayerWeapons(x);
	format(string2, sizeof(string2), ""WI" "G"%s  rozbroił(a) wszystkich graczy!", Player[playerid][Name]);
	SCMA(C_GREEN, string2);
	return 1;
CMD:givecashall(playerid,cmdtext[])
	if(!Player[playerid][Admin2]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
    new GiveCash;
	if(sscanf(cmdtext, "d", GiveCash))
	    SCM(playerid, C_WHITE, ""I" "W"/GiveCashAll [Ilość]");
	    return 1;
	if(GiveCash < 1)
	    SCM(playerid, C_WHITE, ""I" "W"Niepoprawna ilość pieniędzy.");
	    return 1;
	new string2[120];
	format(string2, sizeof(string2), ""WI" "G"Dostałeś(aś) %d pieniędzy od admina %s.",GiveCash,Player[playerid][Name]);
	foreach(Player,x)
		GivePlayerMoney(x, GiveCash);
        Player[x][Money] += GiveCash;
		SCM(x,C_GREEN, string2);
	SCM(playerid,C_GREEN,""WI" "G"Dodano pieniądze wszystkim graczom!");
	return 1;
CMD:healall(playerid,cmdtext[])
	if(!Player[playerid][Admin2]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new string2[120];
	format(string2, sizeof(string2), ""WI" "G"%s uzdrowił wszystkich graczy!",Player[playerid][Name]);
    SCMA(C_GREEN, string2);
	foreach(Player,x)
		if(!Player[playerid][OnOnede])
			SetPlayerHealth(x, 100);
	        Player[x][Immunitet] = false;
	SCM(playerid,C_GREEN,""WI" "G"Uzdrowiono wszystkich graczy!");
	return 1;
CMD:armorall(playerid,cmdtext[])
	if(!Player[playerid][Admin2]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new string2[120];
	format(string2, sizeof(string2), ""WI" "G"Dostałeś(aś) kamizelkę od %s.",Player[playerid][Name]);
	foreach(Player,x)
		SetPlayerArmour(x, 100);
		SCM(x,C_GREEN, string2);
	SCM(playerid,C_GREEN,""WI" "G"Dodano kamizelki wszystkim graczom!");
	return 1;
//------------------------------------------------------------------------------
CMD:ls(playerid)
    if(Wiezien[playerid])
		SCM(playerid, C_RED, ""WE" "R"Masz zablokowaną możliwość wpisywania komend! Wyjąteki: /l [tekst], /Raport");
  		PlaySoundForPlayer(playerid,1085);
		return 1;
	switch(random(2))
	    case 0: CarTeleport(playerid,0,2503.2910,-1670.5448,13.3623,"LOS SANTOS",1);
		case 1: CarTeleport(playerid,0,2457.5132,-1678.3092,13.5053,"LOS SANTOS",1);
	return 1;
CMD:sf(playerid)
    if(Wiezien[playerid])
		SCM(playerid, C_RED, ""WE" "R"Masz zablokowaną możliwość wpisywania komend! Wyjątek: /l [tekst] /Raport");
  		PlaySoundForPlayer(playerid,1085);
		return 1;
	switch(random(2))
	    case 0: CarTeleport(playerid,0,-2036.8722,133.9763,28.8359,"SAN FIERRO",1);
		case 1: CarTeleport(playerid,0,-2052.5449,125.2895,28.4406,"SAN FIERRO",1);
	return 1;
CMD:lv(playerid)
    if(Wiezien[playerid])
		SCM(playerid, C_RED, ""WE" "R"Masz zablokowaną możliwość wpisywania komend! Wyjątek: /l [tekst], /Raport");
  		PlaySoundForPlayer(playerid,1085);
		return 1;
	switch(random(2))
	    case 0: CarTeleport(playerid,0,2140.6675,993.1967,10.5248,"LAS VENTURAS",1);
	    case 1: CarTeleport(playerid,0,2154.2263,1034.9930,10.8203,"LAS VENTURAS",1);
	return 1;
CMD:lc(playerid)
	SetPlayerFacingAngle(playerid,1);
	PlayerTeleport(playerid,1,-785.0116,506.4748,1381.6016,"LIBERTY CITY",1);
	return 1;
CMD:bank(playerid)
	CarTeleport(playerid,0,2187.1436,1991.9537,10.8203,"BANK",1);
	return 1;
CMD:lslot(playerid)
    CarTeleport(playerid,0,1953.5204,-2290.1130,13.5469,"LOTNISKO LS",1);
	return 1;
CMD:nascar(playerid)
	CarTeleport(playerid,0,1982.3100,-6631.4500,23.7500,"NASCAR",1);
	return 1;
// statek2 szkło
CMD:statek2(playerid)
	PlayerTeleport(playerid,0,-8197.8604,-1200.8539,8.7385,"STATEK",1);
	return 1;
CMD:basen(playerid)
	PlayerTeleport(playerid,0,2529.4939,1575.1974,12.5105,"BASEN",1);
	return 1;
CMD:szklo(playerid)
	CarTeleport(playerid,0,1717.068115, -1770.235352, 983.685242,"SZKLO",1);
	return 1;
CMD:woda(playerid)
	CarTeleport(playerid,0,2341.363037, -247.674118, 1151.390503,"WODA",1);
	return 1;
CMD:wodospad(playerid)
	PlayerTeleport(playerid,0,-233.24346923828, -8301.138671875, 46.235500335693,"WODOSPAD",1);
	return 1;
CMD:tokyo(playerid)
	PlayerTeleport(playerid,0,3280.3330,-1646.8104,26.4978,"TOKYO DRIFT",1);
	return 1;
CMD:zjazd3(playerid)
    PlayerTeleport(playerid,0,273.3236,-934.7064,470.9164,"ZJAZD",1);
	return 1;
CMD:zjazd2(playerid)
    PlayerTeleport(playerid,0,-1879.5569,-72.1220,693.2439,"ZJAZD",1);
	return 1;
CMD:zjazd(playerid)
    PlayerTeleport(playerid,0,1214.8420,2205.0249,511.9854,"ZJAZD",1);
	return 1;
CMD:kula(playerid)
    CarTeleport(playerid,0,-929.6306,296.2192,14.6761,"KULA",1);
	return 1;
CMD:baza1(playerid)
    CarTeleport(playerid,0,2073.6895,1574.7092,10.6719,"BAZA NR.1",1);
	return 1;
CMD:baza2(playerid)
    CarTeleport(playerid,0,-7.9788,-333.2255,5.4297,"BAZA NR.2",1);
	return 1;
CMD:baza3(playerid)
    PlayerTeleport(playerid,0,2056.7085,2056.1362,26.5230,"BAZA NR.3",1);
	return 1;
CMD:skydive(playerid)
    PlayerTeleport(playerid,0,4027.4741,-1926.0981,2382.1765,"SKY DIVE",1);
	SetPlayerFacingAngle(playerid,175.2060);
	return 1;
CMD:ziolo(playerid)
    CarTeleport(playerid,0,709.9035,-132.6756,21.2761,"POLE ZIOLA",1);
	return 1;
CMD:warsztat(playerid)
    CarTeleport(playerid,0,-1588.4055,-2724.9880,48.5391,"WARSZTAT",1);
	return 1;
CMD:funpark(playerid)
    PlayerTeleport(playerid,0,2663.888183, -2642.952636, 115.669692,"FUN PARK",1);
	return 1;
CMD:jump(playerid)
    PlayerTeleport(playerid,0,-507.13882446, 1453.73193359, 985.72094727,"JUMP",1);
	return 1;
CMD:freeway(playerid)
    PlayerTeleport(playerid,0,-2847.246338, 2185.518311, 799.000000,"FREE WAY",1);
	return 1;
CMD:patfinder(playerid)
    PlayerTeleport(playerid,0,2878.4743, 1733.3472, -3.9511,"PAT FINDER",1);
	return 1;
CMD:rod(playerid)
    PlayerTeleport(playerid,0,-26.204660, -273.111969, 10.923664,"ROD",1);
	return 1;
CMD:sflot(playerid)
    CarTeleport(playerid,0,-1538.8635,-422.9142,5.8516,"LOTNISKO SF",1);
	return 1;
CMD:lvlot(playerid)
    CarTeleport(playerid,0,1319.5250,1259.7314,10.8203,"LOTNISKO LV",1);
	return 1;
CMD:wojsko(playerid)
	CarTeleport(playerid,0,351.3806,1786.0936,17.9556,"WOJSKO",1);
	return 1;
CMD:wojsko2(playerid)
	CarTeleport(playerid,0,72.7191,1917.2032,17.8172,"WOJSKO",1);
	return 1;
CMD:silownials(playerid)
	PlayerTeleport(playerid,0,2223.9558,-1723.8124,13.5625,"SILOWNIA",1);
	return 1;
CMD:silowniasf(playerid)
	PlayerTeleport(playerid,0,-2267.8413,-152.6703,35.3203,"SILOWNIA",1);
	return 1;
CMD:silownialv(playerid)
	PlayerTeleport(playerid,0,1953.9572,2294.4358,10.8203,"SILOWNIA",1);
	return 1;
CMD:policelv(playerid)
	PlayerTeleport(playerid,0,2314.5398,2448.5171,10.8203,"KOMENDA PD",1);
	return 1;
CMD:policels(playerid)
	PlayerTeleport(playerid,0,1543.4082,-1669.2240,13.5564,"KOMENDA PD",1);
	return 1;
CMD:policesf(playerid)
	PlayerTeleport(playerid,0,-1663.3905,682.0554,14.1446,"KOMENDA PD",1);
	return 1;
CMD:centrumsf(playerid)
	CarTeleport(playerid,0,-1982.2820,883.7844,45.2031,"CENTRUM",1);
	return 1;
CMD:centrumlv(playerid)
	CarTeleport(playerid,0,2160.3159,2362.0916,23.6620,"CENTRUM",1);
	return 1;
CMD:centrumls(playerid)
	CarTeleport(playerid,0,484.2705,-1504.1769,20.4113,"CENTRUM",1);
	return 1;
CMD:remizasf(playerid)
	CarTeleport(playerid,0,-2064.5056,93.3215,28.3906,"REMIZA",1);
	return 1;
CMD:remizalv(playerid)
	CarTeleport(playerid,0,1736.1882,2076.2971,10.8203,"REMIZA",1);
	return 1;
CMD:remizals(playerid)
	CarTeleport(playerid,0,1793.5614,-1431.1442,13.5859,"REMIZA",1);
	return 1;
CMD:stadionlv(playerid)
	CarTeleport(playerid,0,1356.4915,2150.0994,11.0156,"STADION",1);
	return 1;
CMD:stadionsf(playerid)
	CarTeleport(playerid,0,-2323.6658,188.3307,35.3125,"STADION",1);
	return 1;
CMD:stadionls(playerid)
	CarTeleport(playerid,0,756.0032,-1282.5631,13.5569,"STADION",1);
	return 1;
CMD:bs1(playerid)
	PlayerTeleport(playerid,0,1176.9360,-912.9376,43.2937,"BURGER SHOT",1);
	return 1;
CMD:bs2(playerid)
	PlayerTeleport(playerid,0,788.5140,-1633.5393,13.3828,"BURGER SHOT",1);
	return 1;
CMD:bs3(playerid)
	PlayerTeleport(playerid,0,-2345.7166,986.5507,50.7029,"BURGER SHOT",1);
	return 1;
CMD:bs4(playerid)
	PlayerTeleport(playerid,0,-2321.4570,-133.8795,35.3203,"BURGER SHOT",1);
	return 1;
CMD:bs5(playerid)
	PlayerTeleport(playerid,0,-1917.2186,830.8969,35.8776,"BURGER SHOT",1);
	return 1;
CMD:bs6(playerid)
	PlayerTeleport(playerid,0,2152.3296,2811.8232,10.8203,"BURGER SHOT",1);
	return 1;
CMD:bs7(playerid)
	PlayerTeleport(playerid,0,2446.4048,2021.7684,10.8203,"BURGER SHOT",1);
	return 1;
CMD:bs8(playerid)
	PlayerTeleport(playerid,0,1895.4552,2085.5784,10.8203,"BURGER SHOT",1);
	return 1;
CMD:bs9(playerid)
	PlayerTeleport(playerid,0,1130.6729,2087.5901,10.8203,"BURGER SHOT",1);
	return 1;
CMD:cb1(playerid)
	PlayerTeleport(playerid,0,2378.3508,2018.9689,10.8203,"CLUCKIN BELL",1);
	return 1;
CMD:cb2(playerid)
	PlayerTeleport(playerid,0,176.6615,1163.2347,14.7578,"CLUCKIN BELL",1);
	return 1;
CMD:cb3(playerid)
	PlayerTeleport(playerid,0,-1197.0116,1829.8041,41.7188,"CLUCKIN BELL",1);
	return 1;
CMD:cb4(playerid)
	PlayerTeleport(playerid,0,-2680.6721,274.7386,4.3359,"CLUCKIN BELL",1);
	return 1;
CMD:cb5(playerid)
	PlayerTeleport(playerid,0,-1820.9708,616.1251,35.1719,"CLUCKIN BELL",1);
	return 1;
CMD:cb6(playerid)
	PlayerTeleport(playerid,0,939.6403,-1334.5259,13.5469,"CLUCKIN BELL",1);
	return 1;
CMD:cb7(playerid)
	PlayerTeleport(playerid,0,2397.1824,-1488.6631,23.8281,"CLUCKIN BELL",1);
	return 1;
CMD:cb8(playerid)
	PlayerTeleport(playerid,0,2633.0840,1669.0948,10.8203,"CLUCKIN BELL",1);
	return 1;
CMD:cb9(playerid)
	PlayerTeleport(playerid,0,2104.9409,2232.5623,11.0234,"CLUCKIN BELL",1);
	return 1;
CMD:cb10(playerid)
	PlayerTeleport(playerid,0,-2166.8921,-2459.0413,30.6250,"CLUCKIN BELL",1);
	return 1;
CMD:pizzeria1(playerid)
	PlayerTeleport(playerid,0,2094.0210,-1814.6328,13.3828,"PIZZERIA",1);
	return 1;
CMD:pizzeria2(playerid)
	PlayerTeleport(playerid,0,-1721.5541,1349.6080,7.1937,"PIZZERIA",1);
	return 1;
CMD:pizzeria3(playerid)
	PlayerTeleport(playerid,0,203.9641,-210.7526,1.4315,"PIZZERIA",1);
	return 1;
CMD:pizzeria4(playerid)
	PlayerTeleport(playerid,0,-1803.9325,942.1923,24.8906,"PIZZERIA",1);
	return 1;
CMD:pizzeria5(playerid)
	PlayerTeleport(playerid,0,2760.7449,2462.7268,10.8203,"PIZZERIA",1);
	return 1;
CMD:pizzeria6(playerid)
	PlayerTeleport(playerid,0,2087.8787,2221.0916,10.8203,"PIZZERIA",1);
	return 1;
CMD:pizzeria7(playerid)
	PlayerTeleport(playerid,0,2087.8787,2221.0916,10.8203,"PIZZERIA",1);
	return 1;
CMD:pizzeria8(playerid)
	PlayerTeleport(playerid,0,2633.7356,1844.5304,10.8203,"PIZZERIA",1);
	return 1;
CMD:pizzeria9(playerid)
	PlayerTeleport(playerid,0,2357.7742,2529.7769,10.8203,"PIZZERIA",1);
	return 1;
CMD:pizzeria10(playerid)
	PlayerTeleport(playerid,0,1361.4526,255.2263,19.5669,"PIZZERIA",1);
	return 1;
CMD:burdells(playerid)
	PlayerTeleport(playerid,0,2420.6746,-1228.3464,24.8686,"BURDEL",1);
	return 1;
CMD:burdelsf(playerid)
	PlayerTeleport(playerid,0,-2619.2266,1407.1125,7.0938,"BURDEL",1);
	GameTextForPlayer(playerid, "~g~~h~BURDEL",2500,3);
	return 1;
CMD:burdellv(playerid)
	PlayerTeleport(playerid,0,2510.5579,2125.8772,10.8203,"BURDEL",1);
	return 1;
CMD:palomimocreek(playerid)
	PlayerTeleport(playerid,0,2319.3064,65.0970,26.4845,"PALOMIMO CREEK",1);
	return 1;
CMD:montgomery(playerid)
	PlayerTeleport(playerid,0,1269.0137,266.2460,19.5469,"MONTGOMERY",1);
	return 1;
CMD:dillimore(playerid)
	PlayerTeleport(playerid,0,661.8469,-546.9734,16.3359,"DILLIMORE",1);
	return 1;
CMD:blueberry(playerid)
	PlayerTeleport(playerid,0,264.9110,-149.0728,1.5781,"BLUEBERRY",1);
	return 1;
CMD:angelpine(playerid)
	PlayerTeleport(playerid,0,-2105.8655,-2340.9958,30.6250,"ANGEL PINE",1);
	return 1;
CMD:fortcarson(playerid)
	PlayerTeleport(playerid,0,-154.2796,1112.4421,19.7422,"FORT CARSON",1);
	return 1;
CMD:lasbarrancas(playerid)
	PlayerTeleport(playerid,0,-781.4839,1588.7283,27.1172,"LAS BARRANCAS",1);
	return 1;
CMD:laspayasadas(playerid)
	PlayerTeleport(playerid,0,-220.8926,2616.4495,62.7307,"LAS PAYASADAS",1);
	return 1;
CMD:elcastillo(playerid)
	PlayerTeleport(playerid,0,-368.9631,2228.7065,42.4844,"EL CASTILLO",1);
	return 1;
CMD:elquelbrados(playerid)
	PlayerTeleport(playerid,0,-1481.1409,2630.6558,58.7813,"EL QUELBRADOS",1);
	return 1;
CMD:bayside(playerid)
	PlayerTeleport(playerid,0,-2506.9585,2361.9810,4.9860,"BAYSIDE",1);
	return 1;
CMD:bonecountry(playerid)
	PlayerTeleport(playerid,0,725.3641,1876.1255,5.6822,"BONE COUNTRY",1);
	return 1;
CMD:szkolajazdy1(playerid)
	PlayerTeleport(playerid,0,1174.1415,1367.3441,10.8203,"SZKOLA JAZDY",1);
	return 1;
CMD:szkolajazdy2(playerid)
	PlayerTeleport(playerid,0,-2188.4851,2407.8232,4.9755,"SZKOLA JAZDY",1);
	return 1;
CMD:szkolajazdy3(playerid)
	PlayerTeleport(playerid,0,-2020.6652,-99.4087,35.1641,"SZKOLA JAZDY",1);
	return 1;
CMD:szkolajazdy4(playerid)
	PlayerTeleport(playerid,0,408.4536,2539.1897,16.5469,"SZKOLA JAZDY",1);
	return 1;
CMD:binco1(playerid)
	PlayerTeleport(playerid,0,2250.4666,-1665.3075,15.4690,"BINCO",1);
	return 1;
CMD:binco2(playerid)
	PlayerTeleport(playerid,0,-2377.5938,904.0258,45.4453,"BINCO",1);
	return 1;
CMD:binco3(playerid)
	PlayerTeleport(playerid,0,2103.7539,2244.4629,11.0234,"BINCO",1);
	return 1;
CMD:binco4(playerid)
	PlayerTeleport(playerid,0,1654.2345,1727.7847,10.8203,"BINCO",1);
	return 1;
CMD:zip1(playerid)
	PlayerTeleport(playerid,0,2573.1255,1898.0491,10.8280,"ZIP",1);
	return 1;
CMD:zip2(playerid)
	PlayerTeleport(playerid,0,2090.2344,2218.7715,10.8203,"ZIP",1);
	return 1;
CMD:zip3(playerid)
	PlayerTeleport(playerid,0,-1887.5531,870.9766,35.1641,"ZIP",1);
	return 1;
CMD:zip4(playerid)
	PlayerTeleport(playerid,0,1454.1543,-1144.7914,24.0587,"ZIP",1);
	return 1;
CMD:szpitalls(playerid)
	PlayerTeleport(playerid,0,2027.9742,-1410.1027,16.9922,"SZPITAL",1);
	return 1;
CMD:szpitalsf(playerid)
	PlayerTeleport(playerid,0,-2647.7581,633.0165,14.4545,"SZPITAL",1);
	return 1;
CMD:szpitallv(playerid)
	PlayerTeleport(playerid,0,1602.3915,1824.2205,10.8203,"SZPITAL",1);
	return 1;
CMD:tunelv(playerid)
	CarTeleport(playerid,0,2387.0808,1016.9999,10.5459,"TUNING LV",1);
	return 1;
CMD:tunesf(playerid)
	CarTeleport(playerid,0,-2694.8188,216.2327,4.3564,"TUNING SF",1);
	return 1;
CMD:tunels(playerid)
	CarTeleport(playerid,0,2660.1042,-2002.1769,13.5595,"TUNING LS",1);
	return 1;
CMD:molo(playerid)
	CarTeleport(playerid,0,834.5790,-1858.1664,12.8672,"MOLO",1);
	return 1;
CMD:wiezowiec(playerid)
	CarTeleport(playerid,0,1545.9459,-1353.5649,329.6513,"WIEZOWIEC",1);
	return 1;
CMD:skatepark(playerid)
	CarTeleport(playerid,0,1874.0300,-1386.2402,13.7218,"SKATE PARK",1);
	return 1;
CMD:g1(playerid)
	CarTeleport(playerid,0,2264.2097,1398.7369,42.5925,"PARKING G1",1);
	return 1;
CMD:g2(playerid)
	CarTeleport(playerid,0,2008.1486,1732.1975,18.9339,"PARKING G2",1);
	return 1;
CMD:g3(playerid)
	CarTeleport(playerid,0,2074.0437,2416.8750,49.5234,"PARKING G3",1);
	return 1;
CMD:g4(playerid)
	CarTeleport(playerid,0,1700.6284,1194.1071,34.7891,"PARKING G4",1);
	return 1;
CMD:osiedle1(playerid)
	PlayerTeleport(playerid,0,1431.2542,2590.4102,10.6719,"OSIEDLE",1);
	return 1;
CMD:osiedle2(playerid)
	PlayerTeleport(playerid,0,1602.2233,2733.3799,10.6719,"OSIEDLE",1);
	return 1;
CMD:osiedle3(playerid)
	PlayerTeleport(playerid,0,1993.9541,2743.2903,10.6719,"OSIEDLE",1);
	return 1;
CMD:osiedle4(playerid)
	PlayerTeleport(playerid,0,1946.4294,939.1719,10.3921,"OSIEDLE",1);
	return 1;
CMD:osiedle5(playerid)
	PlayerTeleport(playerid,0,2149.3955,715.5646,10.8304,"OSIEDLE",1);
	return 1;
CMD:tama(playerid)
	CarTeleport(playerid,0,-912.1113,2005.2953,60.4852,"TAMA",1);
	return 1;
CMD:odludzie(playerid)
	CarTeleport(playerid,0,-1383.3280,-1507.3010,102.2328,"ODLUDZIE",1);
	return 1;
CMD:salon(playerid)
	CarTeleport(playerid,0,-1987.7372,288.7828,34.5681,"SALON",1);
	return 1;
CMD:kosciol(playerid)
	CarTeleport(playerid,0,2495.2578,936.2213,10.8280,"KOSCIOL",1);
	return 1;
CMD:gora(playerid)
	CarTeleport(playerid,0,-2321.1321,-1634.2689,483.8788,"GORA",1);
	return 1;
CMD:plazasf(playerid)
	CarTeleport(playerid,0,-2896.8655,144.7969,4.9552,"PLAZA",1);
	return 1;
CMD:plaza(playerid)
	CarTeleport(playerid,0,330.1647,-1798.5216,4.7001,"PLAZA",1);
	return 1;
CMD:farma(playerid)
	CarTeleport(playerid,0,-85.2571,-10.2401,3.1094,"FARMA",1);
	return 1;
CMD:pgr(playerid)
	CarTeleport(playerid,0,66.4972,-224.9516,1.7548,"PGR",1);
	return 1;
CMD:bagno(playerid)
	CarTeleport(playerid,0,-858.9744,-1941.0603,15.1729,"BAGNO",1);
	return 1;
CMD:tereno(playerid)
	CarTeleport(playerid,0,2900.4480,1702.4181,10.8203,"TERENO",1);
	return 1;
CMD:peronlv(playerid)
	PlayerTeleport(playerid, 0,2850.3589, 1291.7593, 11.3906,"PERON LV",1);
	return 1;
CMD:peronls(playerid)
	PlayerTeleport(playerid, 0,1738.9878, -1948.4301, 14.1172,"PERON LS",1);
	return 1;
CMD:peronsf(playerid)
	PlayerTeleport(playerid, 0,-1938.1156, 143.1689, 26.2813,"PERON SF",1);
	return 1;
CMD:statek(playerid)
	PlayerTeleport(playerid,0,2001.6912,1544.4111,13.5859,"STATEK",1);
	return 1;
CMD:fourdragons(playerid)
	PlayerTeleport(playerid,0,2023.6055,1008.2421,10.3642,"FOUR DRAGONS",1);
	return 1;
CMD:cpn(playerid)
	PlayerTeleport(playerid,0,666.2331,-572.6985,16.3359,"CPN",1);
	return 1;
CMD:ammunation(playerid)
	PlayerTeleport(playerid,7,302.2929,-143.1391,1004.0625,"AMMUNATION",1);
	return 1;
CMD:emmet(playerid)
	PlayerTeleport(playerid,0,2443.8984,-1974.8905,13.5469,"EMMET",1);
	return 1;
CMD:rcshop(playerid)
	PlayerTeleport(playerid,6,-2239.5710,130.0224,1035.4141,"RC SHOP",1);
	return 1;
CMD:cjgarage(playerid)
	PlayerTeleport(playerid,1,-2048.6060,162.0934,28.8359,"CJ GARAGE",1);
	return 1;
CMD:calligula(playerid)
	PlayerTeleport(playerid,1,2172.0037,1620.7543,999.9792,"CALLIGULA",1);
	return 1;
CMD:wooziebed(playerid)
	PlayerTeleport(playerid,1,-2158.7200,641.2880,1052.3817,"WOOZIE BED",1);
	return 1;
CMD:jaysdin(playerid)
	PlayerTeleport(playerid,4,460.1000,-88.4285,999.5547,"BAR",1);
	return 1;
CMD:woc(playerid)
	PlayerTeleport(playerid,1,451.6645,-18.1390,1001.1328,"RESTAURACJA",1);
	return 1;
CMD:tsdin(playerid)
	PlayerTeleport(playerid,1,681.4750,-451.1510,-25.6172,"BAR",1);
	return 1;
CMD:wh(playerid)
	PlayerTeleport(playerid,1,1412.6399,-1.7875,1000.9244,"WARE HOUSE",1);
	return 1;
CMD:wh2(playerid)
	PlayerTeleport(playerid,18,1302.5199,-1.7875,1001.0283,"WARE HOUSE",1);
	return 1;
CMD:bar(playerid)
	SetPlayerFacingAngle(playerid,1);
	PlayerTeleport(playerid,1,-794.9943,492.0277,1376.1953,"BAR LC",1);
	return 1;
CMD:andromeda(playerid)
	PlayerTeleport(playerid,9,315.8185,984.2496,1959.0851,"ANDROMEDA",1);
	return 1;
CMD:lot(playerid)
	PlayerTeleport(playerid,14,-1827.1473,7.2074,1061.1436,"AIR PORT",1);
	return 1;
CMD:lot2(playerid)
	PlayerTeleport(playerid,14,-1855.5687,41.2632,1061.1436,"AIR PORT",1);
	return 1;
CMD:vicestadium(playerid)
	PlayerTeleport(playerid,1,-1396.3193,86.3535,1032.4810,"VICE STADIUM",1);
	return 1;
CMD:dirtbike(playerid)
	PlayerTeleport(playerid,4,-1433.8196,-653.9620,1051.5610,"DIRT BIKE",1);
	return 1;
CMD:kss(playerid)
	PlayerTeleport(playerid,14,-1475.9512,1640.5054,1052.5313,"KS STADIUM",1);
	return 1;
CMD:demolotionderby(playerid)
	PlayerTeleport(playerid,15,-1405.4443,946.1092,1030.0840,"DEMOLOTION DERBY",1);
	return 1;
CMD:skok1(playerid)
	PlayerTeleport(playerid,0,-1791.0409, 567.7134, 332.8019,"null",1);
	SCM(playerid, C_BLUE, ""WI" {44a428}Życzymy miłych lotów!");
    GivePlayerWeapon(playerid, 46, 1);
	return 1;
CMD:skok2(playerid)
	PlayerTeleport(playerid,0,1452.4982, -1072.8849, 213.3828,"null",1);
	SCM(playerid, C_BLUE, ""WI" {44a428}Życzymy miłych lotów!");
    GivePlayerWeapon(playerid, 46, 1);
	return 1;
CMD:skok3(playerid)
	PlayerTeleport(playerid,0,1481.1073, -1790.5154, 156.7533,"null",1);
	SCM(playerid, C_BLUE, ""WI" {44a428}Życzymy miłych lotów!");
    GivePlayerWeapon(playerid, 46, 1);
	return 1;
CMD:skok4(playerid)
	PlayerTeleport(playerid,0,-1753.6823,885.5562,295.8750,"null",1);
	SCM(playerid, C_BLUE, ""WI" {44a428}Życzymy miłych lotów!");
    GivePlayerWeapon(playerid, 46, 1);
	return 1;
CMD:skok5(playerid)
	PlayerTeleport(playerid,0,-1278.9236,976.3959,139.2734,"null",1);
	SCM(playerid, C_BLUE, ""WI" {44a428}Życzymy miłych lotów!");
    GivePlayerWeapon(playerid, 46, 1);
	return 1;
CMD:skok6(playerid)
	PlayerTeleport(playerid,0,1966.3888,1912.6749,130.9375,"null",1);
	SCM(playerid, C_BLUE, ""WI" {44a428}Życzymy miłych lotów!");
    GivePlayerWeapon(playerid, 46, 1);
	return 1;
CMD:skok7(playerid)
	PlayerTeleport(playerid,0,2054.8530,2428.6870,165.6172,"null",1);
	SCM(playerid, C_BLUE, ""WI" {44a428}Życzymy miłych lotów!");
    GivePlayerWeapon(playerid, 46, 1);
	return 1;
CMD:skok8(playerid)
	PlayerTeleport(playerid,0,-2873.0127,2718.6343,275.6272,"null",1);
	SCM(playerid, C_BLUE, ""WI" {44a428}Życzymy miłych lotów!");
    GivePlayerWeapon(playerid, 46, 1);
	return 1;
CMD:stunt(playerid)
    CarTeleport(playerid,0,1718.0747,-2674.3906,13.5469,"STUNT",1);
	return 1;
CMD:skocznia(playerid)
    PlayerTeleport(playerid,0,3414.4734,11.1966,212.8766,"SKOCZNIA",1);
	return 1;
CMD:gokarty(playerid)
    PlayerTeleport(playerid,0,-427.6374,1187.4662,1.7222,"GOKARTY",1);
	return 1;
CMD:skyroad(playerid)
    PlayerTeleport(playerid,0,2294.1531,-810.7403,1501.0563,"SKY ROAD",1);
	return 1;
CMD:pipe(playerid)
    PlayerTeleport(playerid,0,1388.5200,-2426.3049,525.6313,"PIPE",1);
	return 1;
CMD:pks(playerid)
    PlayerTeleport(playerid,0,1046.1104,1336.3427,10.8203,"PKS",1);
	return 1;
CMD:podwoda(playerid)
	CarTeleport(playerid,0,5840.928711, -4529.442871, -60,"PODWODA",1);
	return 1;
CMD:miasto(playerid)
    PlayerTeleport(playerid, 0,2493,-1682,30460,"MIASTO",1);
	return 1;
CMD:lost(playerid)
	PlayerTeleport(playerid, 0,1503,6342,6,"LOST",1);
    return 1;
CMD:afganistan(playerid)
	CarTeleport(playerid,0,-24.7265,1838.4039,17.1216,"AFGANISTAN",1);
	return 1;
CMD:waterland(playerid)
	PlayerTeleport(playerid,0,2571.8450,-2941.2422,205.2634,"PARK WODNY",1);
	return 1;
CMD:miniport(playerid)
	PlayerTeleport(playerid,0,1071.7703,-2697.8354,11.2657,"PORT",1);
	return 1;
CMD:domek(playerid)
	PlayerTeleport(playerid,0,1362.587891, -477.100677, 70.992393,"DOMEK",1);
	return 1;
CMD:czarnobyl(playerid)
	PlayerTeleport(playerid,0,4301.3960,-2058.4963,1.6819,"CZARNOBYL",1);
	return 1;
CMD:restauracja(playerid)
	PlayerTeleport(playerid,0,316.7266,-1881.3896,2.2236,"RESTAURACJA",1);
	return 1;
CMD:wyspa(playerid)
	PlayerTeleport(playerid,0,4741.7563476563,-4899.0366210938,8.4952936172485,"WYSPA",1);
	return 1;
CMD:wyspa2(playerid)
	PlayerTeleport(playerid,0,778.163024 , -2848.560791 , 5.262573,"WYSPA",1);
	return 1;
CMD:wyspa3(playerid)
	PlayerTeleport(playerid,0,3374.0193,2338.2019,2.5313,"WYSPA",1);
	return 1;
CMD:tube(playerid)
	PlayerTeleport(playerid,0,83.4930,2433.8430,83.9585,"TUBA",1);
	return 1;
CMD:tor(playerid)
	PlayerTeleport(playerid,0,2205.0712,-4014.3115,9.8170,"TOR",1);
	return 1;
CMD:tor2(playerid)
	CarTeleport(playerid,0,-1494.9581,686.1584,7.1833,"TOR SF",1); //267.0135
	return 1;
CMD:warsztat2(playerid)
	PlayerTeleport(playerid,0,1011.0331,-1306.1213,13.3828,"WARSZTAT",1);
	return 1;
CMD:tornrg(playerid)
	PlayerTeleport(playerid,0,3067.1479,-1987.0001,23.0410,"TOR NRG",1);
	return 1;
CMD:tornrg2(playerid)
	PlayerTeleport(playerid,0,-2231.2891,942.1437,97.1250,"TOR NRG",1);
	SetPlayerFacingAngle(playerid,2.5810);
	return 1;
CMD:odbij(playerid)
	PlayerTeleport(playerid,0,3636.92358398, -1772.81677246, 234.34071350,"ODBIJ",1);
    SetCameraBehindPlayer(playerid);
	return 1;
CMD:parkour(playerid)
    PlayerTeleport(playerid,0,1544.9849,-1353.7681,329.4735,"PARKOUR",1);
	SetCameraBehindPlayer(playerid);
	return 1;
CMD:kulki(playerid)
	CarTeleport(playerid,0,-1785.6355,581.3128,234.8906,"KULKI",1);
    SetCameraBehindPlayer(playerid);
	return 1;
CMD:impra2(playerid)
	PlayerTeleport(playerid,0,-1499.8582,762.8007,7.1875,"IMPRA",1);
	return 1;
CMD:impra3(playerid)
	PlayerTeleport(playerid,0,-1279.2175,462.8168,7.1809,"IMPRA",1);
	return 1;
CMD:impra(playerid)
	PlayerTeleport(playerid,0,2394.6265,1111.0751,11.6147,"IMPRA",1);
	return 1;
CMD:dirt(playerid)
	PlayerTeleport(playerid,0,2360.7957,-647.9197,128.1740,"DIRT",1);
	return 1;
CMD:drift1(playerid)
	CarTeleport(playerid,0,1962.7166, 1778.4757, 18.9338,"DRIFT",1);
	return 1;
CMD:drift2(playerid)
	CarTeleport(playerid,0,-1226.5265,2189.3992,186.6741,"DRIFT",1);
	return 1;
CMD:drift3(playerid)
	CarTeleport(playerid,0,-2447.7688,-619.6808,132.7393,"DRIFT",1);
	return 1;
CMD:drift4(playerid)
	CarTeleport(playerid,0,-337.1577,1526.1979,75.3570,"DRIFT",1);
	return 1;
CMD:drift5(playerid)
	CarTeleport(playerid,0,-1260.3335,-1374.8666,119.1694,"DRIFT",1);
	return 1;
CMD:drift6(playerid)
	CarTeleport(playerid,0,-574.3944,-1052.9753,23.7313,"DRIFT",1);
	return 1;
CMD:drift7(playerid)
	CarTeleport(playerid,0,2071.9150,2434.2551,49.5234,"DRIFT",1);
	return 1;
CMD:drift8(playerid)
	CarTeleport(playerid,0,1121.1410,1353.5417,10.8203,"DRIFT",1);
	return 1;
CMD:piramida(playerid)
	PlayerTeleport(playerid,0,2323.7397, 1283.1893, 97.6086,"PIRAMIDA",1);
	return 1;
CMD:willa(playerid)
	PlayerTeleport(playerid,0,1260.4903, -804.1359, 88.3125,"WILLA",1);
	return 1;
CMD:pustynia(playerid)
	CarTeleport(playerid,0,428.4866,2533.7695,16.5045,"PUSTYNIA",1);
	return 1;
//Animacje
CMD:lol(playerid)
	LoopingAnim(playerid, "RAPPING", "Laugh_01", 4.0, 1, 0, 0, 0, 0); // Laugh
	SCM(playerid,C_GREEN, ""WI" "G" Śmiejesz się.");
	return 1;
CMD:aresztuj2(playerid)
	ApplyAnimation(playerid, "POLICE", "plc_drgbst_01", 4.0, 0, 0, 0, 0, 0); // Arrest
	SCM(playerid,C_GREEN, ""WI" "G" Aresztujesz kogoś.");
	return 1;
CMD:aresztowany(playerid)
	ApplyAnimation(playerid, "POLICE", "crm_drgbst_01", 4.0, 0, 0, 0, 0, 0); // Arrested
	SCM(playerid,C_GREEN, ""WI" "G" Zostałeś aresztowany.");
	return 1;
CMD:kaleka(playerid)
	LoopingAnim(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0); // Injured
	SCM(playerid,C_GREEN, ""WI" "G" Udajesz kalekę.");
	return 1;
CMD:klaps(playerid)
	ApplyAnimation(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0); // Ass Slapping
	SCM(playerid,C_GREEN, ""WI" "G" Dałeś komuś klapsa");
	return 1;
CMD:bar2(playerid)
	LoopingAnim(playerid, "BAR", "Barserve_bottle", 4.000000, 0, 1, 1, 1, -1);
	SCM(playerid, C_GREEN, ""WI" "G" Serwujesz zimne piwko.");
	return 1;
CMD:bar3(playerid)
	LoopingAnim(playerid, "BAR", "Barserve_give", 4.000000, 0, 1, 1, 1, -1);
	SCM(playerid, C_GREEN, ""WI" "G" Podajesz zimne piwko.");
	return 1;
CMD:opalaj(playerid)
	LoopingAnim(playerid, "BEACH", "ParkSit_W_loop", 4.000000, 0, 1, 1, 1, -1);
	SCM(playerid, C_GREEN, ""WI" "G" Opalasz się.");
	return 1;
CMD:opalaj2(playerid)
	LoopingAnim(playerid, "BEACH", "SitnWait_loop_W", 4.000000, 0, 1, 1, 1, -1);
	SCM(playerid, C_GREEN, ""WI" "G" Opalasz się.");
	return 1;
CMD:rozmowaauto(playerid)
	LoopingAnim(playerid, "CAR_CHAT", "car_talkm_loop", 4.000000, 0, 1, 1, 1, -1);
	SCM(playerid, C_GREEN, ""WI" "G" Prowadzisz rozmowę w aucie.");
	return 1;
CMD:szafka(playerid)
	LoopingAnim(playerid, "COP_AMBIENT", "Copbrowse_nod", 4.000000, 0, 1, 1, 1, 0);
	SCM(playerid, C_GREEN, ""WI" "G" Szukasz czegoś w szawce.");
	return 1;
CMD:zegarek(playerid)
	LoopingAnim(playerid, "COP_AMBIENT", "Coplook_nod", 4.000000, 0, 1, 1, 1, 0);
	SCM(playerid, C_GREEN, ""WI" "G" Patrzysz na zegarek.");
	return 1;
CMD:cpun2(playerid)
	LoopingAnim(playerid, "CRACK", "crckdeth1", 4.000000, 0, 1, 1, 1, 0);
	SCM(playerid, C_GREEN, ""WI" "G" Leżysz jak ćpun.");
	return 1;
CMD:cpun3(playerid)
	LoopingAnim(playerid, "CRACK", "crckdeth3", 4.000000, 0, 1, 1, 1, 0);
	SCM(playerid, C_GREEN, ""WI" "G" Leżysz jak ćpun.");
	return 1;
CMD:cpun4(playerid)
	LoopingAnim(playerid, "CRACK", "crckdeth4", 4.000000, 0, 1, 1, 1, 0);
	SCM(playerid, C_GREEN, ""WI" "G" Leżysz jak ćpun.");
	return 1;
CMD:cpun5(playerid)
	LoopingAnim(playerid, "CRACK", "crckidle4", 4.000000, 0, 1, 1, 1, 0);
	SCM(playerid, C_GREEN, ""WI" "G" Leżysz jak ćpun.");
	return 1;
CMD:rolki(playerid)
	LoopingAnim(playerid, "SKATE", "skate_sprint", 4.0999, 1, 1, 1, 1, 1);
	SCM(playerid, C_GREEN, ""WI" "G" Jeździsz na rolkach.");
	return 1;
CMD:skocz(playerid)
	LoopingAnim(playerid, "DAM_JUMP", "Jump_Roll", 4.000000, 0, 1, 1, 1, 0);
	SCM(playerid, C_GREEN, ""WI" "G" Próbujesz wykonać skok.");
	return 1;
CMD:taniec(playerid)
	LoopingAnim(playerid, "DANCING", "bd_clap", 4.000000, 1, 1, 1, 1, 1);
	SCM(playerid, C_GREEN, ""WI" "G" Tańczysz.");
	return 1;
CMD:taniec2(playerid)
	LoopingAnim(playerid, "DANCING", "bd_clap1", 4.000000, 1, 1, 1, 1, 1);
	SCM(playerid, C_GREEN, ""WI" "G" Tańczysz.");
	return 1;
CMD:taniec3(playerid)
	LoopingAnim(playerid, "DANCING", "DAN_Down_A", 4.000000, 1, 1, 1, 1, 1);
	SCM(playerid, C_GREEN, ""WI" "G" Tańczysz.");
	return 1;
CMD:taniec4(playerid)
	LoopingAnim(playerid, "DANCING", "DAN_Left_A", 4.000000, 1, 1, 1, 1, 1);
	SCM(playerid, C_GREEN, ""WI" "G" Tańczysz.");
	return 1;
CMD:taniec5(playerid)
	LoopingAnim(playerid, "DANCING", "DAN_Right_A", 4.000000, 1, 1, 1, 1, 1);
	SCM(playerid, C_GREEN, ""WI" "G" Tańczysz.");
	return 1;
CMD:taniec6(playerid)
	LoopingAnim(playerid, "DANCING", "DAN_Up_A", 4.000000, 1, 1, 1, 1, 1);
	SCM(playerid, C_GREEN, ""WI" "G" Tańczysz.");
	return 1;
CMD:taniec7(playerid)
	LoopingAnim(playerid, "DANCING", "dnce_M_a", 4.000000, 1, 1, 1, 1, 1);
	SCM(playerid, C_GREEN, ""WI" "G" Tańczysz.");
	return 1;
CMD:grubas(playerid)
	LoopingAnim(playerid, "FAT", "FatWalk", 4.000000, 1, 1, 1, 1, 1);
	SCM(playerid, C_GREEN, ""WI" "G" Idziesz jak grubas.");
	return 1;
CMD:grubas2(playerid)
	LoopingAnim(playerid, "FAT", "FatRun", 4.000000, 1, 1, 1, 1, 1);
	SCM(playerid, C_GREEN, ""WI" "G" Biegniesz jak grubas.");
	return 1;
CMD:jedz2(playerid)
	LoopingAnim(playerid, "FOOD", "FF_Die_Bkw", 4.000000, 0, 1, 1, 1, 0);
	SCM(playerid, C_GREEN, ""WI" "G" Jesz coś.");
	return 1;
CMD:jedz3(playerid)
	LoopingAnim(playerid, "FOOD", "FF_Sit_Eat1", 4.000000, 0, 1, 1, 1, 0);
	SCM(playerid, C_GREEN, ""WI" "G" Jesz coś.");
	return 1;
CMD:rece4(playerid)
	LoopingAnim(playerid, "GANGS", "hndshkfa", 4.000000, 0, 1, 1, 1, 0);
	SCM(playerid, C_GREEN, ""WI" "G" Wymachujesz rękami.");
	return 1;
CMD:rece5(playerid)
	LoopingAnim(playerid, "GHANDS", "gsign1", 4.000000, 0, 1, 1, 1, 0);
	SCM(playerid, C_GREEN, ""WI" "G" Wymachujesz rękami.");
	return 1;
CMD:rece6(playerid)
	LoopingAnim(playerid, "GHANDS", "gsign1LH", 4.000000, 0, 1, 1, 1, 0);
	SCM(playerid, C_GREEN, ""WI" "G" Wymachujesz rękami.");
	return 1;
CMD:krzeslo2(playerid)
	LoopingAnim(playerid, "JST_BUISNESS", "girl_02", 4.000000, 1, 1, 1, 1, 0);
	SCM(playerid, C_GREEN, ""WI" "G" Siadasz na krześle w stylu kobiety.");
	return 1;
CMD:turlaj(playerid)
	LoopingAnim(playerid, "MD_CHASE", "MD_BIKE_Lnd_Roll_F", 4.000000, 1, 1, 1, 1, 0);
	SCM(playerid, C_GREEN, ""WI" "G" Turlasz sie!");
	return 1;
CMD:boks(playerid)
	LoopingAnim(playerid, "GYMNASIUM", "GYMshadowbox", 4.000000, 1, 1, 1, 1, 0);
	SCM(playerid, C_GREEN, ""WI" "G" Robisz trening boksu.");
	return 1;
CMD:kopniak(playerid)
	LoopingAnim(playerid, "POLICE", "Door_Kick", 4.000000, 0, 1, 1, 1, 0);
	SCM(playerid, C_GREEN, ""WI" "G" Zasadziłes solidnego kopniaka.");
	return 1;
CMD:opalaj3(playerid)
	LoopingAnim(playerid, "SUNBATHE", "ParkSit_W_idleA", 4.000000, 0, 1, 1, 1, 0);
	SCM(playerid, C_GREEN, ""WI" "G" Opalasz się.");
	return 1;
CMD:swat(playerid)
	LoopingAnim(playerid, "SWAT", "swt_breach_01", 4.000000, 0, 1, 1, 1, 0);
	SCM(playerid, C_GREEN, ""WI" "G" Biegniesz jak SWAT.");
	return 1;
CMD:swat2(playerid)
	LoopingAnim(playerid, "SWAT", "swt_breach_02", 4.000000, 0, 1, 1, 1, 0);
	SCM(playerid, C_GREEN, ""WI" "G" Biegniesz jak SWAT.");
	return 1;
CMD:swat3(playerid)
	LoopingAnim(playerid, "SWAT", "swt_breach_03", 4.000000, 0, 1, 1, 1, 0);
	SCM(playerid, C_GREEN, ""WI" "G" Biegniesz jak SWAT.");
	return 1;
CMD:skocz2(playerid)
	LoopingAnim(playerid, "DAM_JUMP","DAM_Launch",4.1,0,1,1,1,1); // Umierasz
	SCM(playerid, C_GREEN, ""WI" "G" Robisz kaskaderski skok.");
	return 1;
CMD:trup2(playerid)
	LoopingAnim(playerid, "SWAT","gnstwall_injurd",4.0,1,0,0,0,0); // Umierasz
	SCM(playerid, C_GREEN, ""WI" "G" Udajesz trupa.");
	return 1;
CMD:ratunku(playerid)
	LoopingAnim(playerid,"BD_FIRE","BD_Panic_03",4.0,1,0,0,0,0); // Ratunku
	SCM(playerid, C_GREEN, ""WI" "G" Machasz o pomoc.");
	return 1;
CMD:trup(playerid)
	LoopingAnim(playerid, "WUZI", "CS_Dead_Guy", 4.1,0,1,1,1,1); // Umierasz
	SCM(playerid, C_GREEN, ""WI" "G" Gryziesz ziemię.");
	return 1;
CMD:calus(playerid)
	LoopingAnim(playerid, "KISSING", "Playa_Kiss_02", 4.0,0,0,0,0,0); // kissing
	SCM(playerid, C_GREEN, ""WI" "G" Całujesz kogoś.");
	return 1;
CMD:sikaj(playerid)
	SetPlayerSpecialAction(playerid,68);
	SCM(playerid, C_GREEN, ""WI" "G" Odlewasz się.");
	return 1;
CMD:krzeslo(playerid)
	LoopingAnim(playerid,"INT_OFFICE","OFF_Sit_Idle_Loop",4.0,1,0,0,0,0); // Krzeslo
	SCM(playerid, C_GREEN, ""WI" "G" Siadasz na krześle.");
	return 1;
CMD:rece(playerid)
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
	SCM(playerid, C_GREEN, ""WI" "G" Poddajesz się.");
	return 1;
CMD:wankin(playerid)
	LoopingAnim(playerid, "PAULNMAC", "wank_loop", 4.0,1,0,0,0,0); // Walenie konia
	SCM(playerid, C_GREEN, ""WI" "G" Zwalasz konia.");
	return 1;
CMD:wankout(playerid)
	LoopingAnim(playerid, "PAULNMAC", "wank_out", 4.0, 0, 0, 0, 0, 0); // Wytrysk
	SCM(playerid, C_GREEN, ""WI" "G" Masturbujesz się.");
	return 1;
CMD:cellin(playerid)
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
	SCM(playerid, C_GREEN, ""WI" "G" Dzwonisz do kogoś.");
	return 1;
CMD:piwo(playerid)
	SetPlayerDrunkLevel(playerid,1000000);
	KillTimer(DrunkTimer[playerid]);
	DrunkTimer[playerid] = SetTimerEx("NotDrunk",30000,0,"i",playerid);
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_BEER);
	SCM(playerid, C_GREEN, ""WI" "G" Pijesz zimne piwko.");
	return 1;
CMD:wino(playerid)
	SetPlayerDrunkLevel(playerid,1000000);
	KillTimer(DrunkTimer[playerid]);
	DrunkTimer[playerid] = SetTimerEx("NotDrunk",60000,0,"i",playerid);
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_WINE);
	SCM(playerid, C_GREEN, ""WI" "G" Pijesz zimne winko.");
	return 1;
CMD:papieros(playerid)
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_SMOKE_CIGGY);
	SCM(playerid, C_GREEN, ""WI" "G" Palisz papierosa.");
	return 1;
CMD:sprunk(playerid)
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_SPRUNK);
	SCM(playerid, C_GREEN, ""WI" "G" Pijesz zielonego sprunka.");
	return 1;
CMD:cellout(playerid)
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
	SCM(playerid, C_GREEN, ""WI" "G" Odkładasz telefon.");
	return 1;
CMD:drunk(playerid)
	LoopingAnim(playerid,"PED","WALK_DRUNK",4.0,1,1,1,1,1);
	SCM(playerid, C_GREEN, ""WI" "G" Chodzisz jak pijak.");
	return 1;
CMD:bomb(playerid)
	ClearAnimations(playerid);
	OnePlayAnim(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0); // Podkladasz bombe.
	SCM(playerid, C_GREEN, ""WI" "G" Podkładasz bombę na niby.");
	return 1;
CMD:aresztuj(playerid)
	LoopingAnim(playerid,"ped", "ARRESTgun", 4.0, 0, 1, 1, 1, -1); // aresztujesz kogos.
	SCM(playerid, C_GREEN, ""WI" "G" Aresztujesz kogoś.");
	return 1;
CMD:rap(playerid)
	LoopingAnim(playerid, "RAPPING", "RAP_B_Loop", 4.0,1,0,0,0,0); // Rapujesz
	SCM(playerid, C_GREEN, ""WI" "G" Rapujesz piosenkę.");
	return 1;
CMD:lookout(playerid)
	OnePlayAnim(playerid, "SHOP", "ROB_Shifty", 4.0, 0, 0, 0, 0, 0); // Patrzysz czy nie ma policji.
	SCM(playerid, C_GREEN, ""WI" "G" Rozglądasz się.");
	return 1;
CMD:napad(playerid)
	LoopingAnim(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 1, 0, 0, 0, 0); // Napad
	SCM(playerid, C_GREEN, ""WI" "G" Zrobiłeś napad.");
	return 1;
CMD:rece2(playerid)
	LoopingAnim(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, -1); // Rece
	SCM(playerid, C_GREEN, ""WI" "G" Zakładasz ręce.");
	return 1;
CMD:lez(playerid)
	LoopingAnim(playerid,"SUNBATHE","batherdown",4.1,0,1,1,1,1); // Lez
	SCM(playerid, C_GREEN, ""WI" "G" Leżysz :D");
	return 1;
CMD:hide(playerid)
	LoopingAnim(playerid, "ped", "cower", 3.0, 1, 0, 0, 0, 0); // Oslaniasz sie.
	SCM(playerid, C_GREEN, ""WI" "G" Osłaniasz się.");
	return 1;
CMD:rzygaj(playerid)
	OnePlayAnim(playerid, "FOOD", "EAT_Vomit_P", 3.0, 0, 0, 0, 0, 0); // Rzygasz
	SCM(playerid, C_GREEN, ""WI" "G" Wymiotujesz.");
	return 1;
CMD:jedz(playerid)
	OnePlayAnim(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0); // jesz buregera
	SCM(playerid, C_GREEN, ""WI" "G" Jesz chamburgera.");
	return 1;
CMD:deal(playerid)
	OnePlayAnim(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0); // Dilujesz
	SCM(playerid, C_GREEN, ""WI" "G" Dealujesz z kimś.");
	return 1;
CMD:cpun(playerid)
	LoopingAnim(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0); // Cpun
	SCM(playerid, C_GREEN, ""WI" "G" Leżysz jak ćpun.");
	return 1;
CMD:smoke(playerid)
	LoopingAnim(playerid,"SMOKING","M_smklean_loop",4.0, 1, 0, 0, 0, 0); // Palisz
	SCM(playerid, C_GREEN, ""WI" "G" Palisz papierosa.");
	return 1;
CMD:fsmoke(playerid)
	LoopingAnim(playerid,"SMOKING","F_smklean_loop",4.0, 1, 0, 0, 0, 0); // Palisz
	SCM(playerid, C_GREEN, ""WI" "G" Palisz papierosa jak kobieta.");
	return 1;
CMD:smoke2(playerid)
	LoopingAnim(playerid,"SMOKING","M_smkstnd_loop",4.0, 1, 0, 0, 0, 0); // Palisz
	SCM(playerid, C_GREEN, ""WI" "G" Palisz papierosa.");
	return 1;
CMD:rece3(playerid)
	LoopingAnim(playerid,"DAM_JUMP","DAM_Dive_Loop",4.0, 1, 0, 0, 0, 0); // Palisz
	SCM(playerid, C_GREEN, ""WI" "G" Stoisz na rękach");
	return 1;
CMD:siadaj(playerid)
	LoopingAnim(playerid,"BEACH", "ParkSit_M_loop", 4.0, 1, 0, 0, 0, 0); // Siadasz
	SCM(playerid, C_GREEN, ""WI" "G" Usiadłeś.");
	return 1;
CMD:chatanim(playerid)
	LoopingAnim(playerid,"PED","IDLE_CHAT", 4.0,1,0,0,0,0);
	SCM(playerid, C_GREEN, ""WI" "G" Rozmawiasz z kimś.");
	return 1;
CMD:fucku(playerid)
	OnePlayAnim(playerid,"PED","fucku",4.0,0,0,0,0,0);
	SCM(playerid, C_GREEN, ""WI" "G" Pokazujesz aby ktoś wypier*alał.");
	return 1;
CMD:taichi(playerid)
	LoopingAnim(playerid,"PARK","Tai_Chi_Loop",4.0,1,0,0,0,0);
	SCM(playerid, C_GREEN, ""WI" "G" Nauczyłes się takewonda.");
	return 1;
CMD:pij(playerid)
	LoopingAnim(playerid,"BAR","dnk_stndF_loop",4.0,1,0,0,0,0);
	SCM(playerid, C_GREEN, ""WI" "G" Pijesz coś.");
	return 1;
CMD:inbedright(playerid)
	LoopingAnim(playerid,"INT_HOUSE","BED_In_R",4.1,0,1,1,1,1);
	SCM(playerid, C_GREEN, ""WI" "G" Idziesz spać.");
	return 1;
CMD:inbedleft(playerid)
	LoopingAnim(playerid,"INT_HOUSE","BED_In_L",4.1,0,1,1,1,1);
	SCM(playerid, C_GREEN, ""WI" "G" Wstajesz z łóżka");
	return 1;
CMD:dance(playerid,cmdtext[])
	new dance;
	if(sscanf(cmdtext,"d",dance))
	    SCM(playerid,C_LIGHTRED,""I" "W"/dance [1-4]");
		return 1;
	if(dance < 1 || dance > 4)
		SCM(playerid,C_LIGHTRED,""I" "W"/dance [1-4]");
		return 1;
	if(dance == 1)
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
	else if(dance == 2)
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
	else if(dance == 3)
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
 	else if(dance == 4)
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
	return 1;
CMD:astop(playerid)
	return ClearAnimations(playerid);
CMD:animstop(playerid)
	return cmd_astop(playerid);
CMD:wal(playerid)
	return cmd_wankin(playerid);
//------------------------------------------------------------------------------
CMD:100hp(playerid)
	if(Player[playerid][Money] >= 2500)
        if(Player[playerid][KupilZycie] > 0)
			new String[90];
			format(String,sizeof(String),""WE" "R"Tej komendy możesz użyć dopiero za %d sekund.",Player[playerid][KupilZycie]);
			SCM(playerid, C_RED, String);
			return 1;
		GivePlayerMoney(playerid, -2500);
        Player[playerid][Money] -= 2500;
		ApplyAnimation(playerid,"FOOD","EAT_Burger",4.1,0,0,0,0,0);
		Player[playerid][HealthTimer] = SetTimerEx("Uleczenie", 10000, 0, "i" ,playerid);
        SCM(playerid, C_GREEN, ""WI" "G"Zostaniesz uzdrowiony za 10 sekund...");
		/*
		new tmp[140];
		format(tmp, sizeof(tmp), ""WI" "G"%s uzupełnił życie komendą "G2"/100hp"G".", Player[playerid][Name]);
		SCMA(C_GREEN, tmp);
		SoundForAll(1150);*/
        Player[playerid][KupilZycie] = 60;
	else
		SCM(playerid, C_RED, ""WE" "R"Życie kosztuje 2500$! Nie posiadasz tyle!");
	return 1;
CMD:kamizelka(playerid)
	return cmd_armour(playerid);
CMD:zycie(playerid)
	return cmd_100hp(playerid);
CMD:zdrowie(playerid)
	return cmd_100hp(playerid);
CMD:kasa(playerid)
	return cmd_dotacja(playerid);
CMD:armour(playerid)
	if(Player[playerid][Money] >= 5000)
        if(Player[playerid][KupilArmour] > 0)
			new String[90];
			format(String,sizeof(String),""WE" "R"Tej komendy możesz użyć dopiero za %d sekund.",Player[playerid][KupilArmour]);
			SCM(playerid, C_RED, String);
			return 1;
		GivePlayerMoney(playerid, -4000);
	    Player[playerid][Money] -= 4000;
		Player[playerid][KupilArmour] = 60;
		Player[playerid][ArmourTimer] = SetTimerEx("Armor", 5000, 0, "i" ,playerid);
		SCM(playerid, C_GREEN, ""WI" "G"Trwa zakładanie kamizelki...");
        /*new tmp[140];
		format(tmp, sizeof(tmp), ""WI" "G"%s uzupełnił kamizelkę komendą "G2"/Armour"G".", Player[playerid][Name]);
		SCMA(C_GREEN, tmp);
        SoundForAll(1150);*/
	else
		SCM(playerid, C_RED, ""WE" "R"Kamizelka kosztuje 4000! Nie posiadasz tyle!");
	return 1;
CMD:napraw(playerid)
	if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid,C_WHITE,""WE" "R"Musisz być w pojeździe!");
	if(Player[playerid][Naprawil] > 0 && !Player[playerid][Vip] && !Player[playerid][Mod] && !Player[playerid][Admin1])
		new String[55];
		format(String,sizeof(String),"Musisz odczekac %d sekund aby naprawic pojazd.",Player[playerid][Naprawil]);
		ShowInfoBox(playerid,String,3);
		return 1;
	RepairVehicle(GetPlayerVehicleID(playerid));
	ShowInfoBox(playerid,"Pojazd naprawiony!",3);
	PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
 	Player[playerid][Naprawil] = 10;
 	return 1;
CMD:flip(playerid)
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
	new VehicleID, Float:aX, Float:aY, Float:aZ, Float:Angle;
	GetPlayerPos(playerid, aX, aY, aZ);
	VehicleID = GetPlayerVehicleID(playerid);
	GetVehicleZAngle(VehicleID,Angle);
	SetVehiclePos(VehicleID,aX, aY, aZ);
	SetVehicleZAngle(VehicleID,Angle);
	return 1;
CMD:kolorauto(playerid)
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		SCM(playerid,C_ERROR,""WI" "R"Musisz być w pojeździe aby tego użyć.");
		return 1;
	new rand1 = random(405);
	new rand2 = random(405);
	ChangeVehicleColor(GetPlayerVehicleID(playerid),rand1,rand2);
	SCM(playerid, C_GREEN, ""WI" "G"Kolor twojego pojazdu zostal losowo zmieniony.");
	return 1;
CMD:zw(playerid)
	if(!Player[playerid][SiemaBlock])
		new string[100];
		Player[playerid][SiemaBlock] = true;
		SetTimerEx("SiemaUnlock", 5000, 0,"i",playerid);
		format(string, sizeof(string), ""WI" "G"Gracz "G2"%s "G"zaraz wraca.",Player[playerid][Name]);
		SCMA(C_GREEN,string);
        SoundForAll(1150);
	return 1;
CMD:gs(playerid)
	if(!Player[playerid][SiemaBlock])
		new string[100];
		Player[playerid][SiemaBlock] = true;
		SetTimerEx("SiemaUnlock", 5000, 0,"i",playerid);
		format(string, sizeof(string), ""WI" "G"Gracz "G2"%s "G"oddał(a) życie za GoldServer!",Player[playerid][Name]);
		SCMA(C_GREEN,string);
		SetPlayerHealth(playerid, 0);
        SoundForAll(1150);
	return 1;
CMD:gg(playerid)
	if(!Player[playerid][SiemaBlock])
		new string[100];
		Player[playerid][SiemaBlock] = true;
		SetTimerEx("SiemaUnlock", 5000, 0,"i",playerid);
		format(string, sizeof(string), ""WI" "G"Gracz "G2"%s "G"idzie na Gadu-Gadu.",Player[playerid][Name]);
		SCMA(C_GREEN,string);
        SoundForAll(1150);
	return 1;
CMD:skype(playerid)
	if(!Player[playerid][SiemaBlock])
		new string[100];
		Player[playerid][SiemaBlock] = true;
		SetTimerEx("SiemaUnlock", 5000, 0,"i",playerid);
		format(string, sizeof(string), ""WI" "G"Gracz "G2"%s "G"idzie na Skype.",Player[playerid][Name]);
		SCMA(C_GREEN,string);
        SoundForAll(1150);
	return 1;
CMD:jj(playerid)
	if(!Player[playerid][SiemaBlock])
		new string[100];
		Player[playerid][SiemaBlock] = true;
		SetTimerEx("SiemaUnlock", 5000, 0,"i",playerid);
		format(string, sizeof(string), ""WI" "G"Gracz "G2"%s "G"już jest!",Player[playerid][Name]);
		SCMA(C_GREEN,string);
	    SoundForAll(1150);
	return 1;
CMD:siema(playerid)
	if(!Player[playerid][SiemaBlock])
		new string[100];
		Player[playerid][SiemaBlock] = true;
		SetTimerEx("SiemaUnlock", 5000, 0,"i",playerid);
		format(string, sizeof(string), ""WI" "G"Gracz "G2"%s "G"mówi siema!",Player[playerid][Name]);
		SCMA(C_GREEN,string);
        SoundForAll(1150);
	return 1;
CMD:nara(playerid)
	if(!Player[playerid][SiemaBlock])
		new string[100];
		Player[playerid][SiemaBlock] = true;
		SetTimerEx("SiemaUnlock", 5000, 0,"i",playerid);
		format(string, sizeof(string), ""WI" "G"Gracz "G2"%s "G"mówi nara!",Player[playerid][Name]);
		SCMA(C_GREEN,string);
        SoundForAll(1150);
	return 1;
CMD:czesc(playerid)
	if(!Player[playerid][SiemaBlock])
		new string[100];
		Player[playerid][SiemaBlock] = true;
		SetTimerEx("SiemaUnlock", 5000, 0,"i",playerid);
		format(string, sizeof(string), ""WI" "G"Gracz "G2"%s "G"mówi cześć!",Player[playerid][Name]);
		SCMA(C_GREEN,string);
        SoundForAll(1150);
	return 1;
CMD:pa(playerid)
	if(!Player[playerid][SiemaBlock])
		new string[100];
		Player[playerid][SiemaBlock] = true;
		SetTimerEx("SiemaUnlock", 5000, 0,"i",playerid);
		format(string, sizeof(string), ""WI" "G"Gracz "G2"%s "G"mówi pa pa.",Player[playerid][Name]);
		SCMA(C_GREEN,string);
        SoundForAll(1150);
	return 1;
CMD:cardive(playerid)
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
	if(Player[playerid][Money] < 2000)
		SCM(playerid, C_WHITE, ""E" "W"Potrzebujesz 2000$ aby to zrobić.");
		return 1;
	if(IsPlayerInAnyVehicle(playerid))
		new Float:aX,Float:aY,Float:aZ,VehicleID;
		GetPlayerPos(playerid, aX, aY, aZ);
		VehicleID = GetPlayerVehicleID(playerid);
		GivePlayerMoney(playerid, -1500);
        Player[playerid][Money] += -1500;
		SetVehiclePos(VehicleID,aX, aY, aZ + 900.00);
		GivePlayerWeapon(playerid,46,1);
	else
		SCM(playerid, C_RED, ""WE" "R"Nie jesteś w pojeździe!");
	return 1;
CMD:v(playerid)
	return cmd_cars(playerid);
CMD:pojazdy(playerid)
	return cmd_cars(playerid);
CMD:cars(playerid)
	return SPD(playerid, D_CARS, DIALOG_STYLE_LIST, "{00BFFF}Wybierz typ pojazdu", "› Salony\n"GUI2"› Motory\n"W"› Rowery\n"GUI2"› Kabriolety\n"W"› Dostawcze\n"GUI2"› LowRidery\n"W"› Terenowe\n"GUI2"› Użyteczności publicznej\n"W"› Sportowe\n"GUI2"› Combi\n"W"› Łodzie\n"GUI2"› Samoloty/Helikoptery\n"W"› Unikalne\n"GUI2"› Zabawki RC", "Wybierz", "Anuluj");
CMD:car(playerid)
	return cmd_cars(playerid);
CMD:lasery(playerid)
	return cmd_laser(playerid);
CMD:pojazd(playerid)
    if(!Player[playerid][Registered]) return SCM(playerid, C_ERROR, ""WE" "R"Nie jesteś zarejestrowany!");
	if(!Player[playerid][Vip])
		if(Player[playerid][Exp] < 1500 && Player[playerid][pVeh] <= 0) return SCM(playerid, C_ERROR, ""WE" "R"Aby zakupić prywatny pojazd musisz mieć conajmniej 1500 exp!");
	else
        if(Player[playerid][Exp] < 500 && Player[playerid][pVeh] <= 0) return SCM(playerid, C_ERROR, ""WE" "R"Ponieważ jesteś vip'em musisz posiadać 500 exp.");
	if(Player[playerid][pVeh] <= 0) return SPD(playerid, D_PVEH, DIALOG_STYLE_INPUT, "{00BFFF}Prywatny pojazd "W"- nazwa", "Wprowadź mazwę bądź część nazwy auta\n\n(Nazwy pojazdów znajdują się pod komendą /cars)", "Dalej", "Zamknij");
	SPD(playerid, D_PVEH_CONTROL, DIALOG_STYLE_LIST, "{00BFFF}Panel pojazdu", "› Teleportuj do siebie\n"GUI2"› Zaparkuj\n"W"› Respawnuj na parking\n"GUI2"› Zmień model pojazdu\n"W"› Zapisz pojazd\n"GUI2"› Wczytaj tuning", "Wybierz", "Anuluj");
	return 1;
CMD:guns(playerid)
	return cmd_bronie(playerid);
CMD:weapons(playerid)
	return cmd_bronie(playerid);
CMD:bronie(playerid)
	SPD(playerid, D_WEAPON, DIALOG_STYLE_LIST,
	"Kupno broni", "› Kastet - 1000$\n› Kij Golfowy - 1500$\n› Pałka Policyjna - 2500$\n› Nóż - 2000$\n› Pałka Golfowa - 3000$\n› Łopata - 3000$\n› Katana - 5000$\n› Piła Łańcuchowa - 6000$\n› Kwiaty - 500$\n› Pistolet (9-MM) - 4000$\n› Shotgun - 5000$\n› Combat Shotgun - 5500$\n› Sawn Off Shotgun - 7000$\n› Uzi - 5000$\n› TEC9 - 5000$\n› Wiatrówka - 3500$\n› Sniper-Rifle - 10000$\n› Spray - 3000$\n› Aparat - 500$\n› M4 - 12000$\n› AK-47 - 8000$\n› MP5 - 5500$\n› Desert Eagle - 4000$", "Wybierz", "Anuluj");
	return 1;
CMD:dotacja(playerid)
	if(Player[playerid][Dotacja][0])
		SCM(playerid, C_ERROR, ""WE" "R"Już raz użyłeś(aś) tej komendy!");
		return 1;
	if(Player[playerid][TimePlay] < 30)
        SCM(playerid, C_ERROR, ""WE" "R"Musisz przegrać conajmniej 30 minut na serwerze!");
		return 1;
	Player[playerid][Dotacja][0] = true;
	GivePlayerMoney(playerid, 250000);
    Player[playerid][Money] += 250000;
	SCM(playerid, C_GREEN, ""WI" "G"Dostajesz 250 000$.");
	return 1;
CMD:vdotacja(playerid)
	if(!Player[playerid][Vip] && !Player[playerid][Mod] && !Player[playerid][Admin1]) return SCM(playerid, C_ERROR, ""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	if(Player[playerid][Dotacja][1])
		SCM(playerid, C_ERROR, ""WE" "R"Już raz użyłeś(aś) tej komendy!");
		return 1;
	Player[playerid][Dotacja][1] = true;
	GivePlayerMoney(playerid, 1000000);
    Player[playerid][Money] += 1000000;
	SCM(playerid, C_GREEN, ""WI" "G"Dostajesz 1 mln $ z dotacji dla vipa.");
	return 1;
CMD:nrg(playerid)
	if(GetPlayerInterior(playerid) != 0)
		SCM(playerid,C_RED,""WE" "R"Nrg można spawnować tylko na dworze!");
		return 1;
    if(IsPlayerInAnyVehicle(playerid))
        SCM(playerid,C_ERROR,""WE" "R"Wysiądź z obecnego pojazdu!");
		return 1;
	if(Player[playerid][Nrgs] < 6)
		new Float:s[3];
		new Float:Angle;
		GetPlayerFacingAngle(playerid,Angle);
		GetPlayerPos(playerid,s[0],s[1],s[2]);
		if(!IsVehicleInUse(Player[playerid][Nrg500]))
			DestroyVehicleEx(Player[playerid][Nrg500]);
		else
			Player[playerid][Nrgs] ++;
		Player[playerid][Nrg500] = CreateVehicle(522,s[0],s[1],s[2],Angle,-1,-1,10000);
		PutPlayerInVehicle(playerid, Player[playerid][Nrg500],0);
	else
		SCM(playerid,C_RED,""WE" Zrespawnowałeś zbyt dużo nrg! Poczekaj na usunięcie pojazdów.");
	return 1;
CMD:kill(playerid)
	return SetPlayerHealth(playerid, 0);
CMD:tuning(playerid)
	return cmd_tune(playerid);
CMD:tune(playerid)
	if(Player[playerid][Money] < 5000)
        SCM(playerid, C_RED, ""WE" "R"Musisz mieć 5000$ aby stuningować pojazd!");
		return 1;
	if(IsPlayerInAnyVehicle(playerid))
		PlayerPlaySound(playerid, 1134, 0, 0, 0);
		TuneCar(GetPlayerVehicleID(playerid));
		GivePlayerMoney(playerid, -5000);
        Player[playerid][Money] += -5000;
		SCM(playerid, C_GREEN, ""WI" "G"Twoj pojazd zostal ztuningowany za 5000$!");
	else
		SCM(playerid, C_RED, ""WE" "R"Musisz byc w pojezdzie aby go ztuningowac!");
	return 1;
CMD:tunemenu(playerid)
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SCM(playerid, C_ERROR, ""WE" "R"Nie jesteś kierowcą lub nie jesteś w pojeździe!");
	SPD(playerid, D_TUNE, DIALOG_STYLE_LIST, "{00BFFF}Tuning Menu", "› Felgi\n"GUI2"› Kolory\n"W"› Hydraulika\n"GUI2"› Nitro\n"W"› Stereo\n"GUI2"› Paint Job\n"W"› Neony", "Wybierz", "Anuluj");
	return 1;
CMD:sp(playerid)
	GetPlayerPos(playerid,Player[playerid][pLocX],Player[playerid][pLocY], Player[playerid][pLocZ]);
	SCM(playerid,C_GREEN,""WI" "G"Utworzyłeś(aś) prywatny teleport dla siebie! (/lp)");
	return 1;
CMD:lp(playerid)
	if(SNON) return SCM(playerid,C_RED,""WE" "R"Nie możesz używać tej komendy, gdy sianko trwa.");
	if(Player[playerid][pLocX] == 0.0 && Player[playerid][pLocY] == 0.0 && Player[playerid][pLocZ] == 0.0)
		SCM(playerid,C_ERROR,""WE" "R"Brak zapisanego teleportu!");
	else
		if(IsPlayerInAnyVehicle(playerid))
			new VehicleID = GetPlayerVehicleID(playerid);
			SetVehiclePos(VehicleID, Player[playerid][pLocX],Player[playerid][pLocY], Player[playerid][pLocZ]);
		else
			SetPlayerPos(playerid,Player[playerid][pLocX],Player[playerid][pLocY], Player[playerid][pLocZ]);
		SCM(playerid,C_GREEN,""WI" "G"Teleportowałeś(aś) się do prywatnego teleportu.");
	return 1;
CMD:savepos(playerid)
	GetPlayerPos(playerid,LocX, LocY, LocZ);
	SCM(playerid,C_GREEN,""WI" "G"Utworzyłeś(aś) chwilowy teleport dla wszystkich! (/telpos)");
	return 1;
CMD:telpos(playerid)
    if(SNON) return SCM(playerid,C_RED,""WE" "R"Nie możesz używać tej komendy, gdy sianko trwa.");
	if(LocX == 0.0 && LocY == 0.0 && LocZ == 0.0)
		SCM(playerid,C_ERROR,""WE" "R"Brak zapisanego teleportu!");
	else
		if(IsPlayerInAnyVehicle(playerid))
			new VehicleID = GetPlayerVehicleID(playerid);
			SetVehiclePos(VehicleID, LocX, LocY, LocZ);
		else
			SetPlayerPos(playerid,LocX, LocY, LocZ);
		SCM(playerid,C_GREEN,""WI" "G"Teleportowałeś(aś) się do chwilowego teleportu.");
	return 1;
CMD:pogoda(playerid)
	SPD(playerid,D_POGODA,DIALOG_STYLE_LIST,"{00BFFF}Wybierz swoją pogodę","› Słonecznie\n"GUI2"› Deszczowo\n"W"› Matrix\n"GUI2"› Czarnobyl\n"W"› Mgła\n"GUI2"› Armagedon\n","Wybierz","Anuluj");
	return 1;
CMD:stylewalki(playerid)
	SPD(playerid, D_STYLEWALKI, DIALOG_STYLE_LIST, "{00BFFF}Wybierz swój styl walki", "› Normalny styl walki\n"GUI2"› Boks\n"W"› KungFu\n"GUI2"› KneeHead\n"W"› GrabKick\n"GUI2"› ElBow", "Wybierz", "Anuluj");
	return 1;
CMD:radio(playerid)
	SPD(playerid,D_RADIO,DIALOG_STYLE_LIST,"{00BFFF}Radio Internetowe","› AntyRadio\n› RMF Maxxx\n"GUI2"› Radio Party\n"GUI2"› Radio ESKA\n"W"› Disco Party\n"GUI2"› Radio ZET\n"W"› RMF FM\n"GUI2"› GoldStacja\n"W"› Orange Music - Rock\n"GUI2"› Wyłącz radio","Wybierz","Zamknij");
	return 1;
CMD:spadochron(playerid)
	return cmd_parachute(playerid);
CMD:parachute(playerid)
	GivePlayerWeapon(playerid, 46, 1);
	SCM(playerid, C_GREEN, ""WI" "G"Otrzymałeś(aś) spadochron.");
	return 1;
CMD:rozbroj(playerid)
	ResetPlayerWeapons(playerid);
	SCM(playerid,C_GREEN,""WI" "G"Zostałeś(aś) rozbrojony(a)!");
	return 1;
CMD:skin(playerid,cmdtext[])
	new skinx;
	if(sscanf(cmdtext,"d",skinx))
	    SCM(playerid, C_WHITE, ""I" "W"/Skin [ID skina]");
		return 1;
	if(skinx == 74 || skinx == 268 || skinx < 0 || skinx > 299)
		SCM(playerid, C_WHITE, ""I" "W"Niepoprawne ID Skina.");
		return 1;
	SetPlayerSkin(playerid,skinx);
	new tmp[90];
	format(tmp, sizeof(tmp), ""WI" "G"Zmieniłeś sobie skina na: %d",skinx);
	SCM(playerid,C_GREEN, tmp);
	return 1;
CMD:bombyoff(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	SCM(playerid,C_GREEN,""WI" "G"Wyłączyłeś(aś) możliwość podkładania bomb!");
	Bombs = false;
	foreach(Player,x)
		DestroyPickup(Player[x][Bombus]);
		Player[x][Bomber] = false;
	return 1;
CMD:bombyon(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	SCM(playerid,C_GREEN,""WI" "G"Włączyłeś(aś) możliwość podkładania bomb!");
	Bombs = true;
	return 1;
CMD:c4(playerid)
	if(!Bombs)
		SCM(playerid,C_ERROR,""WE" "R"Aktualnie wyłączona jest opcja podkładania bomb!");
		return 1;
	if(Player[playerid][Exp] < 300 && !Player[playerid][Vip] && !Player[playerid][Admin1])
	    SCM(playerid,C_ERROR,"Musisz mieć co najmniej 300 exp aby podkładać bomby!");
	    return 1;
    if(IsPlayerInBezDmZone(playerid))
	    SCM(playerid,C_ERROR,"Nie możesz podkładać bomb w strefie bez-dm!");
	    return 1;
	if(GetPlayerInterior(playerid) != 0)
        SCM(playerid,C_ERROR,"Nie możesz podkładać bomb we wnętrzu!");
	    return 1;
	if(!Player[playerid][Bomber])
		Player[playerid][MozeDetonowac] = false;
		SetTimerEx("DetonUnlock", 10000,0,"i",playerid);
		KillTimer(Player[playerid][Detonacjaa]);
		Player[playerid][Detonacjaa] = SetTimerEx("Detonacja", 120000, 0, "i", playerid);
		Player[playerid][Bomber] = true;
		GetPlayerPos(playerid, Player[playerid][BombX], Player[playerid][BombY], Player[playerid][BombZ]);
		Player[playerid][Bombus] = CreatePickup(1252,1,Player[playerid][BombX],Player[playerid][BombY],Player[playerid][BombZ]);
		SCM(playerid, C_GREEN, ""WI" "G"Aby wysadzić bombę w powietrze wpisz /Zdetonuj.");
	else
		SCM(playerid, C_RED, ""WE" "R"Już podłożyłeś(aś) jedną bombę!");
	return 1;
CMD:zdetonuj(playerid)
	if(Player[playerid][MozeDetonowac])
		if (Player[playerid][Bomber])
			Player[playerid][MozeDetonowac] = true;
			KillTimer(Player[playerid][Detonacjaa]);
			Player[playerid][Bomber] = false;
			SCM(playerid, C_ERROR, ""I" "R"Bomba explodowała!");
			CreateExplosion(Player[playerid][BombX], Player[playerid][BombY], Player[playerid][BombZ], 6, 20.0);
			DestroyPickup(Player[playerid][Bombus]);
	else{
			SCM(playerid, C_RED, ""WE" "R"Nie podłożyłeś(aś) żadnej bomby!");			}
	else{
		SCM(playerid, C_RED, ""WE" "R"Musisz odczekac 10 sekund aby zdetonować.");
	return 1;
CMD:dystans(playerid,cmdtext[])
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid,C_WHITE,""I" "W"/dystans [idgracza]");
		return 1;
	if(!IsPlayerConnected(gracz))
		SCM(playerid,C_RED,"Nie ma takiego gracza!");
		return 1;
	new dis = GetDistanceBetweenPlayers(playerid,gracz);
	new tmp[90];
	format(tmp,sizeof(tmp),""WI" "G"Dystans gracza %s od ciebie wynosi %d metrów.",Player[gracz][Name],dis);
	SCM(playerid,C_GREEN,tmp);
	return 1;
CMD:vc(playerid,cmdtext[])
    new kolor,kolor2;
	if(sscanf(cmdtext,"dd",kolor,kolor2))
	    SCM(playerid, C_GREEN, ""I" "W"/VC [Id Koloru 1] [ID Koloru 2]");
		return 1;
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SCM(playerid, C_RED, ""WE" "R"Musisz być kierowcą pojazdu!");
	if(kolor < 0 || kolor > 255) return SCM(playerid, C_RED, ""WE" "R"Niepoprawne ID koloru nr. 1!");
    if(kolor < 0 || kolor > 255) return SCM(playerid, C_RED, ""WE" "R"Niepoprawne ID koloru nr. 2!");
	ChangeVehicleColor(GetPlayerVehicleID(playerid), kolor, kolor2);
	return 1;
CMD:skok(playerid,cmdtext[])
	new wysokosc;
	if(sscanf(cmdtext,"d",wysokosc))
	    SCM(playerid, C_WHITE, ""I" "W"/Skok [wysokosc w metrach]");
		return 1;
	if(wysokosc > 20000 || wysokosc < 500) {
		SCM(playerid, C_RED, ""WE" "R"Podaj wysokosc z zakresu od 500 do 20000 m!");
		return 1;
	new tmp[90];
	format(tmp, sizeof(tmp), ""WI" "G"Wykonujesz skok spadochronowy z wysokosci %d m!", wysokosc);
	SCM(playerid, C_GREEN, tmp);
	new Float:x;
	new Float:y;
	new Float:z;
	GivePlayerWeapon(playerid,46,1);
	GetPlayerPos(playerid,x,y,z);
	SetPlayerPos(playerid,x,y,z+wysokosc);
	return 1;
CMD:lock(playerid)
	if(IsPlayerInAnyVehicle(playerid))
		PlaySoundForPlayer(playerid,1147);
		GameTextForPlayer(playerid,"~r~~h~POJAZD ZAMKNIETY",3000,3);
		new veh = GetPlayerVehicleID(playerid);
		foreach(Player,x)
			if(x != playerid) {
				SetVehicleParamsForPlayer(veh,x, 0, 1);
				VehicleLocked[veh] = x;
		SCM(playerid,C_RED,""WI" "R"Pojazd zamkniety!");
	else
		SCM(playerid,C_RED,""WE" "R"Nie jestes w pojezdzie!");
	return 1;
CMD:unlock(playerid)
	if(IsPlayerInAnyVehicle(playerid))
		PlaySoundForPlayer(playerid,1147);
		GameTextForPlayer(playerid,"~g~~h~POJAZD OTWARTY",3000,3);
		new veh = GetPlayerVehicleID(playerid);
		foreach(Player,x)
			SetVehicleParamsForPlayer(veh,x, 0, 0);
			VehicleLocked[veh] = -1;
		SCM(playerid,C_GREEN,""WI" "G"Pojazd otwarty!");
	else
		SCM(playerid,C_RED,""WE" "R"Nie jesteś w pojeździe!");
	return 1;
CMD:kolor(playerid)
	Player[playerid][Color] = SelectPlayerColor(random(100));
    format(Player[playerid][ChatColor],15,HexToString(Player[playerid][Color]));
	SetPlayerColor(playerid, Player[playerid][Color]);
	SCM(playerid, C_GREEN, ""WI" "G"Zmieniłeś(aś) kolor!");
	return 1;
CMD:noc(playerid)
	SetPlayerTime(playerid,0,0); //północ
	SCM(playerid, C_BLUE, ""WI" {44a428}Zmieniłeś swój czas gry na noc!");
	return 1;
CMD:dzien(playerid)
	SetPlayerTime(playerid,12,0); //północ
	SCM(playerid, C_BLUE, ""WI" {44a428}Zmieniłeś swój czas gry na dzień!");
	return 1;
CMD:vwaznosc(playerid)
	if(!Player[playerid][Vip]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new String[128];
	if(Player[playerid][WaznoscVip] == 1 && Player[playerid][SuspensionVip] <= 0)
 		SPD(playerid, D_NONE, DIALOG_STYLE_MSGBOX,"{00BFFF}Konto premium","Informujemy, iż ważność twojego konta premium (VIP) wygaza za 1 dzień.","Zamknij","");
	else if(Player[playerid][WaznoscVip] > 0 && Player[playerid][SuspensionVip] <= 0)
	 	format(String,sizeof(String), "Informujemy, iż ważność twojego konta premium (VIP) wygasa za %d dni.",Player[playerid][WaznoscVip]);
		SPD(playerid, D_NONE, DIALOG_STYLE_MSGBOX,"{00BFFF}Konto premium",String,"Zamknij","");
                
	return 1;
CMD:awaznosc(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new String[128];
	if(Player[playerid][WaznoscAdmin] == 1 && Player[playerid][SuspensionAdmin] <= 0)
 		SPD(playerid, D_NONE, DIALOG_STYLE_MSGBOX,"{00BFFF}Konto premium","Informujemy, iż ważność twojego konta premium (Admin) wygaza za 1 dzień.","Zamknij","");
	else if(Player[playerid][WaznoscAdmin] > 0 && Player[playerid][SuspensionAdmin] <= 0)
	 	format(String,sizeof(String), "Informujemy, iż ważność twojego konta premium (Admin) wygasa za %d dni.",Player[playerid][WaznoscAdmin]);
		SPD(playerid, D_NONE, DIALOG_STYLE_MSGBOX,"{00BFFF}Konto premium",String,"Zamknij","");
	return 1;
CMD:mwaznosc(playerid)
	if(!Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new String[128];
	if(Player[playerid][WaznoscMod] == 1 && Player[playerid][SuspensionMod] <= 0)
 		SPD(playerid, D_NONE, DIALOG_STYLE_MSGBOX,"{00BFFF}Konto premium","Informujemy, iż ważność twojego konta premium (Moderator) wygaza za 1 dzień.","Zamknij","");
	else if(Player[playerid][WaznoscMod] > 0 && Player[playerid][SuspensionMod] <= 0)
	 	format(String,sizeof(String), "Informujemy, iż ważność twojego konta premium (Moderator) wygasa za %d dni.",Player[playerid][WaznoscMod]);
		SPD(playerid, D_NONE, DIALOG_STYLE_MSGBOX,"{00BFFF}Konto premium",String,"Zamknij","");
	return 1;
CMD:vcar(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod] && !Player[playerid][Vip]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new nazwa[32];
	if(sscanf(cmdtext,"s[32]",nazwa))
	    SCM(playerid, C_WHITE, ""I" "W"/Vcar [Nazwa]");
		return 1;
	new pojazd = GetVehicleModelIDFromName(nazwa);
	if(pojazd < 400 || pojazd > 611)return SCM(playerid, C_RED, ""WE" "R"Nie znaleziono takiego pojazdu!");
    if(pojazd == 520 || pojazd == 432 || pojazd == 447 || pojazd == 425 && !IsPlayerInFreeZone(playerid))
	    SCM(playerid, C_GREEN, ""E" "W"Ten pojazd możesz zrespawnować tylko w strefie śmierci.");
		return 1;
	new Float:x,Float:y,Float:z;
	new Float:Angle;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,Angle);
	GetXYInFrontOfPlayer(playerid, x, y, 5);
	CreateVehicle(pojazd,x,y,z+2,Angle+90,-1,-1,1000);
	new tmp[90];
	format(tmp,sizeof(tmp),""WI" "G"Utworzono pojazd o nazwie %s.", CarList[pojazd-400]);
	SCM(playerid,C_GREEN,tmp);
	return 1;
CMD:vjetpack(playerid)
	if(!Player[playerid][Vip] && !Player[playerid][Mod] && !Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
    if(IsPlayerNearAnyone(playerid, 17.0))
		SPD(playerid, D_NONE, DIALOG_STYLE_MSGBOX, "{00BFFF}Jetpack", "Niestety nie możesz tego zrobić!\nPrawdobodobnie próbujesz oszukiwać w walce.\n\nAby temu zaradzić odjedź na pewną odlgegłość\nod graczy obok ciebie.", "Zamknij", "");
	    return 1;
	SetPlayerSpecialAction(playerid, 2);
	SCM(playerid,C_GREEN,""W" "G"Otrzymałeś(aś) jetpacka!");
	return 1;
CMD:vgivecash(playerid,cmdtext[])
	if(!Player[playerid][Vip] && !Player[playerid][Mod] && !Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz,kasa;
	if(sscanf(cmdtext,"id",gracz,kasa))
	    SCM(playerid, C_WHITE, ""I" "W"/vGivecash [ID] [kwota]");
		return 1;
	if(kasa > 10000 || kasa < 0)
	    SCM(playerid,C_WHITE,""E" "W"Jednorazowo możesz dawać max. po $10 000");
		return 1;
	if(Player[gracz][Money] > 30000 && !Player[gracz][Vip])
	    SCM(playerid,C_WHITE,""E" "W"Ten gracz ma już ponad 30.000$.");
	    return 1;
	new tmp[90];
	format(tmp, sizeof(tmp), ""WI" "G"Dodałeś(aś) $%d graczowi %s.",kasa, Player[gracz][Name]);
	SCM(playerid, C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G"Vip %s dodał ci $%d.",Player[playerid][Name],kasa);
	SCM(gracz, C_GREEN, tmp);
	GivePlayerMoney(gracz, kasa);
    Player[gracz][Money] += kasa;
	return 1;
CMD:vsettime(playerid,cmdtext[])
	if(!Player[playerid][Vip] && !Player[playerid][Mod] && !Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new godzina;
	if(sscanf(cmdtext,"d",godzina))
	    SCM(playerid, C_WHITE, ""I" "W"/Vsettime [godzina]");
		return 1;
	if(godzina > 24 || godzina < 0) {
		SCM(playerid, C_WHITE, ""I" "W"Niepoprawna godzina! Od 0 do 24.");
		return 1;
	if(Player[playerid][ZmienialTime] > 0)
        SCM(playerid, C_WHITE, ""I" "W"Tej komendy możesz używać co 10 minut.");
		return 1;
    Player[playerid][ZmienialTime] = 10;
	new tmp[115];
	format(tmp, sizeof(tmp), ""WI" "G"Godzina na serwerze została zmieniona na %d przez vipa %s.", godzina, Player[playerid][Name]);
	SCMA(C_GREEN,tmp);
	SetWorldTime(godzina);
	return true;
CMD:vtp(playerid,cmdtext[])
	if(!Player[playerid][Vip] && !Player[playerid][Mod] && !Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz1,gracz2;
	if(sscanf(cmdtext,"ii",gracz1,gracz2))
	    SCM(playerid, C_WHITE, ""I" "W"/vTp [ID 1 gracza] [do ID 2 gracza]");
		return 1;
	if(!IsPlayerConnected(gracz1))
	    SCM(playerid,C_WHITE,""E" "W"Gracz nr.1 nie jest podłączony!");
		return 1;
	if(!IsPlayerConnected(gracz2))
	    SCM(playerid,C_WHITE,""E" "W"Gracz nr.2 nie jest podłączony!");
		return 1;
	if(!Player[gracz1][TpVipON] && gracz1 != playerid)
        SCM(playerid,C_WHITE,""E" "W"Gracz nr.1 nie zezwala na teleporty vipów.");
		return 1;
    if(!Player[gracz2][TpVipON] && gracz2 != playerid)
        SCM(playerid,C_WHITE,""E" "W"Gracz nr.2 nie zezwala na teleporty vipów.");
		return 1;
    if(Player[playerid][VTPUsed] > 0)
		new String[115];
		format(String,sizeof(String),""E" "W"Możesz tego użyć dopiero za %d minut(y).",Player[playerid][VTPUsed]);
		SCM(playerid,C_WHITE,String);
		return 1;
    Player[playerid][VTPUsed] = 5;
	new Float:pX,Float:pY,Float:pZ;
	GetPlayerPos(gracz2, pX,pY,pZ);
	new Interiorr;
	Interiorr = GetPlayerInterior(gracz2);
	SetPlayerInterior(gracz1, Interiorr);
	SetPlayerPos(gracz1, pX,pY,pZ);
	new tmp[115];
	format(tmp, sizeof(tmp), ""WI" "G"Teleportowałeś(aś) %s do %s.", Player[gracz1][Name],Player[gracz2][Name]);
	SCM(playerid, C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G"Zostałeś teleportowany do %s.",Player[gracz2][Name]);
	SCM(gracz1, C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G"Teleportowano do ciebie gracza %s.",Player[gracz1][Name]);
	SCM(gracz2, C_GREEN, tmp);
	return 1;
CMD:vheal(playerid,cmdtext[])
	if(!Player[playerid][Vip] && !Player[playerid][Mod] && !Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
		SCM(playerid, C_WHITE, ""I" "W"/Vheal [id gracza]");
		return 1;
	if(!IsPlayerConnected(gracz))
	    SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
		return 1;
    Player[gracz][Immunitet] = false;
	SetPlayerHealth(gracz, 100.0);
	new tmp[90];
	format(tmp, sizeof(tmp), ""WI" "G"Uzdrowiłeś(aś) gracza %s.",Player[gracz][Name]);
	SCM(playerid, C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G"Zostałeś(aś) uzdrowiony(a) przez vipa %s.",Player[playerid][Name]);
	SCM(gracz, C_GREEN, tmp);
	return 1;
CMD:varmor(playerid,cmdtext[])
	if(!Player[playerid][Vip] && !Player[playerid][Mod] && !Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
		SCM(playerid, C_WHITE, ""I" "W"/Varmor [id gracza]");
		return 1;
	if(!IsPlayerConnected(gracz))
	    SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
		return 1;
	SetPlayerArmour(gracz, 100.0);
	new tmp[90];
	format(tmp, sizeof(tmp), ""WI" "G"Dałeś(aś) kamizelkę graczu %s.",Player[gracz][Name]);
	SCM(playerid, C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G"Dostałeś(aś) kamizelkę od vipa %s.",Player[playerid][Name]);
	SCM(gracz, C_GREEN, tmp);
	return 1;
CMD:vsay(playerid,cmdtext[])
	if(!Player[playerid][Vip] && !Player[playerid][Mod] && !Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new wiadomosc[128];
	if(sscanf(cmdtext,"s[128]",wiadomosc))
	    SCM(playerid, C_WHITE, ""I" "W"/Vsay [text]");
		return 1;
    if(AntiAdvertisement(wiadomosc))
        GMBan(playerid, "SERWER", "Reklama", Player[playerid][IP]);
		return 1;
	format(wiadomosc, sizeof(wiadomosc), "(VIP %s): "W"%s",Player[playerid][Name], wiadomosc);
	SCMA(C_YELLOW,wiadomosc);
	SoundForAll(1150);
	return 1;
CMD:pmv(playerid,cmdtext[])
	if(!Player[playerid][Vip] && !Player[playerid][Mod] && !Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new wiadomosc[128];
	if(sscanf(cmdtext,"s[128]",wiadomosc))
	    SCM(playerid, C_WHITE, ""I" "W"/Pmv [text]");
		return 1;
	format(wiadomosc, sizeof(wiadomosc), "(PMV %s): "W"%s",Player[playerid][Name], wiadomosc);
	SendClientMessageToVip(C_YELLOW, wiadomosc);
	return 1;
CMD:vrepair(playerid,cmdtext[])
	if(!Player[playerid][Vip] && !Player[playerid][Mod] && !Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/Vrepair [id gracza]");
		return 1;
	if(!IsPlayerConnected(gracz))
	    SCM(playerid,C_WHITE,""E" "W"Ten gracz nie jest podłączony!");
		return 1;
	SetVehicleHealth(GetPlayerVehicleID(gracz), 1000.0);
	new tmp[80];
	format(tmp, sizeof(tmp), ""WI" "G"Naprawiłeś(aś) pojazd graczowi %s.", Player[gracz][Name]);
	SCM(playerid, C_GREEN, tmp);
	format(tmp, sizeof(tmp), ""WI" "G"Vip %s (%d) naprawił ci pojazd.", Player[playerid][Name],playerid);
	SCM(gracz, C_GREEN, tmp);
	return 1;
CMD:vzestaw(playerid)
	if(!Player[playerid][Vip] && !Player[playerid][Mod] && !Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	GivePlayerWeapon(playerid, 24, 5000);
	GivePlayerWeapon(playerid, 9, 1);
	GivePlayerWeapon(playerid, 26, 5000);
	GivePlayerWeapon(playerid, 30, 5000);
	GivePlayerWeapon(playerid, 34, 5000);
    PlaySoundForPlayer(playerid, 30800);
	return 1;
CMD:vcolor(playerid)
	if(!Player[playerid][Vip] && !Player[playerid][Mod] && !Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	SetPlayerColor(playerid,0xFFFF00FF);
    Player[playerid][Color] = 0xFFFF00FF;
    format(Player[playerid][ChatColor],15,HexToString(Player[playerid][Color]));
	SCM(playerid,C_YELLOW,""WI" "Y"Otrzymałeś(aś) kolor vipa!");
	return 1;
CMD:vlistabroni(playerid)
	if(!Player[playerid][Vip] && !Player[playerid][Mod] && !Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
    SCM(playerid, 0xFFFF00AA, " ");
	SCM(playerid, 0xFFFF00AA, "* Lista Broni:");
	SCM(playerid, 0xFFFFFFAA, "* 1-Kastet | 2-Kij golfowy | 3-Palka policyjna | 4-Noz | 5-Bassketball | 6-lopata");
	SCM(playerid, 0xFFFFFFAA, "* 7-Kij bilardowy | 8-Katana | 9-Pila lantuchowa | 10-Gumowiec1 | 11- Gumowiec2");
	SCM(playerid, 0xFFFFFFAA, "* 12- Gumowiec3 | 13-Gumowiec4 | 14-Kwiaty | 15-Laska | 16-Granat | 17-Gaz dymny");
	SCM(playerid, 0xFFFFFFAA, "* 18-Koktail molotowa | 22-Pistolet | 23-Pistolet z tlumikiem | 24-Desert Eagle");
	SCM(playerid, 0xFFFFFFAA, "* 25-Shoutgun | 26-SawnOfShoutgun | 27-Combat Shoutgun | 28-UZI | 29-MP5 | 30-Ak47");
	SCM(playerid, 0xFFFFFFAA, "* 31-M4 | 32-TEC9 | 33-Strzelba | 34-Sniperka | 35-Wyrzutnia Rakiet | 36-BazookaRPG");
	SCM(playerid, 0xFFFFFFAA, "* 37-Miotacz ognia | 38-Minigun | 39-C4 | 40-Detonator | 41-Spray | 42-Gasnica");
	SCM(playerid, 0xFFFFFFAA, "* 43-Aparat | 44-Google podczerwieni | 45-Google termowizyjne | 46-Spadochron");
    SCM(playerid, 0xFFFF00AA, " ");
	return 1;
CMD:vbron(playerid,cmdtext[])
	if(!Player[playerid][Vip] && !Player[playerid][Mod] && !Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new bron,ammo;
	if(sscanf(cmdtext,"dd",bron,ammo))
 		SCM(playerid,C_WHITE,""I" "W"/vbron [ID broni] [Amunicja]");
		return 1;
	if(bron > 46 || bron < 0) {
		SCM(playerid,C_WHITE,""E" "W"Niepoprawne ID Broni!");
		return 1;
	if(ammo > 999999999) {
	    SCM(playerid,C_WHITE,""E" "W"Niepoprawna ilość amunicji!");
		return 1;
	new bool:Moze = true;
	for(new b=0; b<sizeof(Abronie); b++)
		if(Abronie[b]==bron)
			SCM(playerid,C_WHITE,""E" "W"Ta broń jest niedozwolona!");
			Moze = false;
			break;
	if(!Moze) return 1;
	GivePlayerWeapon(playerid,bron,ammo);
    PlaySoundForPlayer(playerid, 30800);
	new tmp[90];
	format(tmp, sizeof(tmp), ""WI" "G"Dałeś(aś) sobie broń %s i %d amunicji.",ReturnWeaponName(bron),ammo);
	SCM(playerid,C_GREEN,tmp);
	return 1;
CMD:arenaexit(playerid)
	ResetPlayerWeapons(playerid);
    SetPlayerInterior(playerid,0);
	SetPlayerRandomSpawn(playerid);
	SetPlayerHealth(playerid, 100.0);
	Player[playerid][OnOnede] = false;
    Player[playerid][OnCombat] = false;
	Player[playerid][OnRPG] = false;
    Player[playerid][OnMinigun] = false;
    UpdatePlayerScore(playerid);
	DestroyObject(OnedeObject[0][playerid]);
 	DestroyObject(OnedeObject[1][playerid]);
	DestroyObject(OnedeObject[2][playerid]);
	SetPlayerWorldBounds(playerid,20000.0000,-20000.0000,20000.0000,-20000.0000); //Reset world to player
	return 1;
CMD:rpg(playerid)
    if(IsPlayerNearAnyone(playerid, 15.0))
		SPD(playerid, D_NONE, DIALOG_STYLE_MSGBOX, "{00BFFF}Teleport", "Niestety nie możesz tego zrobić!\nPrawdobodobnie próbujesz uciec z walki.\n\nAby temu zaradzić odjedź na pewną odlgegłość\nod graczy obok ciebie.", "Zamknij", "");
	    return 1;
    if(GetPlayerPing(playerid) > 150)
		SCM(playerid, C_ERROR, ""WE" "R"Twój ping jest zbyt wysoki! Limit to 150.");
		return 1;
    if(RPGUsers >= 20)
        SCM(playerid, C_ERROR, ""WE" "R"Na tej arenie jest już maksymalna ilość osób! Spróbuj później.");
		return 1;
	new string[128];
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid,35,1000);
    PlaySoundForPlayer(playerid, 30800);
	GameTextForPlayer(playerid, "~w~Arena~n~~b~~h~RPG",800,1);
	if(!RPGText)
		format(string, sizeof(string), ""WI" {E6E339}%s dołączył(a) do areny /RPG!",Player[playerid][Name]);
		SCMA(0xE6E339FF,string);
		RPGText = true;
        SoundForAll(1150);
		SetTimer("RPGTextUnlock",10000,0);
    Update3DTextLabelText(lExp[playerid], 0xFFFFFF00, " ");
	new Arenarand = random(sizeof(RPGSpawn));
	PlayerTeleport(playerid,0,RPGSpawn[Arenarand][0], RPGSpawn[Arenarand][1], RPGSpawn[Arenarand][2],"null",0);
    SetPlayerVirtualWorld(playerid, 10);
	Player[playerid][OnRPG] = true;
	return 1;
CMD:minigun(playerid)
    if(IsPlayerNearAnyone(playerid, 15.0))
		SPD(playerid, D_NONE, DIALOG_STYLE_MSGBOX, "{00BFFF}Teleport", "Niestety nie możesz tego zrobić!\nPrawdobodobnie próbujesz uciec z walki.\n\nAby temu zaradzić odjedź na pewną odlgegłość\nod graczy obok ciebie.", "Zamknij", "");
	    return 1;
    if(GetPlayerPing(playerid) > 150)
		SCM(playerid, C_ERROR, ""WE" "R"Twój ping jest zbyt wysoki! Limit to 150.");
		return 1;
	if(MinigunUsers >= 20)
        SCM(playerid, C_ERROR, ""WE" "R"Na tej arenie jest już maksymalna ilość osób! Spróbuj później.");
		return 1;
	new string[128];
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid,38,1000);
    PlaySoundForPlayer(playerid, 30800);
	GameTextForPlayer(playerid, "~w~arena~n~~b~~h~minigun",800,1);
	if(!MinigunText)
		format(string, sizeof(string), ""WI" {E6E339}%s dołączył(a) do areny /Minigun!",Player[playerid][Name]);
		SCMA(0xE6E339FF,string);
		MinigunText = true;
        SoundForAll(1150);
		SetTimer("MinigunTextUnlock",10000,0);
    Update3DTextLabelText(lExp[playerid], 0xFFFFFF00, " ");
	new Arenarand = random(sizeof(MinigunSpawn));
	PlayerTeleport(playerid,0,MinigunSpawn[Arenarand][0], MinigunSpawn[Arenarand][1], MinigunSpawn[Arenarand][2],"null",0);
    SetPlayerVirtualWorld(playerid, 10);
	Player[playerid][OnMinigun] = true;
	return 1;
CMD:onede(playerid)
    if(IsPlayerNearAnyone(playerid, 15.0))
		SPD(playerid, D_NONE, DIALOG_STYLE_MSGBOX, "{00BFFF}Teleport", "Niestety nie możesz tego zrobić!\nPrawdobodobnie próbujesz uciec z walki.\n\nAby temu zaradzić odjedź na pewną odlgegłość\nod graczy obok ciebie.", "Zamknij", "");
	    return 1;
	if(GetPlayerPing(playerid) > 150)
		SCM(playerid, C_ERROR, ""WE" "R"Twój ping jest zbyt wysoki! Limit to 150.");
		return 1;
    if(OnedeUsers >= 10)
        SCM(playerid, C_ERROR, ""WE" "R"Na tej arenie jest już maksymalna ilość osób! Spróbuj później.");
		return 1;
	new string[128];
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid,24,1000);
    PlaySoundForPlayer(playerid, 30800);
	GameTextForPlayer(playerid, "~w~arena~n~~r~one~r~~h~de",800,1);
	if(!OnedeText)
		format(string, sizeof(string), ""WI" {E6E339}%s dołączył(a) do areny /Onede!",Player[playerid][Name]);
		SCMA(0xE6E339FF,string);
		OnedeText = true;
        SoundForAll(1150);
		SetTimer("OnedeTextUnlock",10000,0);
    KillTimer(Player[playerid][HealthTimer]);
    KillTimer(Player[playerid][ArmourTimer]);
	new Arenarand = random(sizeof(OnedeSpawn));
	PlayerTeleport(playerid,3,OnedeSpawn[Arenarand][0], OnedeSpawn[Arenarand][1], OnedeSpawn[Arenarand][2],"null",0);
	SetPlayerVirtualWorld(playerid, 10);
	Player[playerid][OnOnede] = true;
	SetPlayerHealth(playerid, 10.0);
    SetPlayerArmour(playerid, 0);
    Update3DTextLabelText(lExp[playerid], 0xFFFFFF00, " ");
	OnedeObject[0][playerid] = CreatePlayerObject(playerid,3095,238.54489136,140.66554260,1002.02343750,90.00000000,180.00000000,180.00000000); //object(a51_jetdoor) (1)
	OnedeObject[1][playerid] = CreatePlayerObject(playerid,3095,288.88345337,169.71290588,1006.17187500,90.00000000,0.00000000,0.00000000); //object(cn2_savgardr2_) (2)
	OnedeObject[2][playerid] = CreatePlayerObject(playerid,3095,238.54296875,140.16503906,1002.02343750,90.00000000,179.99450684,179.99450684); //object(cn2_savgardr2_) (3)
	return 1;
CMD:combat(playerid)
    if(IsPlayerNearAnyone(playerid, 15.0))
		SPD(playerid, D_NONE, DIALOG_STYLE_MSGBOX, "{00BFFF}Teleport", "Niestety nie możesz tego zrobić!\nPrawdobodobnie próbujesz uciec z walki.\n\nAby temu zaradzić odjedź na pewną odlgegłość\nod graczy obok ciebie.", "Zamknij", "");
	    return 1;
	if(GetPlayerPing(playerid) > 150)
		SCM(playerid, C_ERROR, ""WE" "R"Twój ping jest zbyt wysoki! Limit to 150.");
		return 1;
    if(CombatUsers >= 10)
        SCM(playerid, C_ERROR, ""WE" "R"Na tej arenie jest już maksymalna ilość osób! Spróbuj później.");
		return 1;
	new string[128];
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid,27,1000);
    PlaySoundForPlayer(playerid,30800);
	GameTextForPlayer(playerid, "~w~arena~n~~b~combat",800,1);
	if(!CombatText)
		format(string, sizeof(string), ""WI" {E6E339}%s dołączył(a) do areny /Combat!",Player[playerid][Name]);
		SCMA(0xE6E339FF,string);
		CombatText = true;
        SoundForAll(1150);
		SetTimer("CombatTextUnlock",10000,0);
	new Arenarand = random(sizeof(CombatSpawn));
	PlayerTeleport(playerid,0,CombatSpawn[Arenarand][0], CombatSpawn[Arenarand][1], CombatSpawn[Arenarand][2],"null",0);
	SetPlayerVirtualWorld(playerid, 10);
	Player[playerid][OnCombat] = true;
	SetPlayerHealth(playerid, 100.0);
    SetPlayerArmour(playerid, 0);
    Update3DTextLabelText(lExp[playerid], 0xFFFFFF00, " ");
    SetPlayerWorldBounds(playerid,-32.6583,-119.1507,-1526.4750,-1621.7223);
	return 1;
CMD:osiagniecia(playerid)
	new string[500],oRegistered[45],oTrofea[45],oDoscTego[45],oKask[45],oJestemLepszy[45],oJestemMistrzem[45],oPilot[45],o24Godziny[45],oDoOstatniegoTchu[45];
	new oCelneOko[45],oZwinnePalce[45];
    if(AchievementGet[playerid][aRegistered] >= 1)
		format(oRegistered, sizeof(oRegistered), "0. {1DEB02}Witamy! - Zakończony\n");
	else
		format(oRegistered, sizeof(oRegistered), "0. Witamy! - 0/1\n");
    if(AchievementGet[playerid][aTrofea] >= 7)
		format(oTrofea, sizeof(oTrofea), "1. {1DEB02}Trofea - Zakończony\n");
	else
		format(oTrofea, sizeof(oTrofea), "1. Trofea - %d/7\n",AchievementGet[playerid][aTrofea]);
    if(AchievementGet[playerid][aDoscTego] >= 10)
		format(oDoscTego, sizeof(oDoscTego), "2. {1DEB02}Dosc Tego! - Zakończony\n");
	else
		format(oDoscTego, sizeof(oDoscTego), "2. Dosc Tego! - %d/Tajne\n",AchievementGet[playerid][aDoscTego]);
	if(AchievementGet[playerid][aKask] >= 1)
		format(oKask, sizeof(oKask), "3. {1DEB02}Potrzebuje kask - Zakończony\n");
	else
		format(oKask, sizeof(oKask), "3. Potrzebuje kask - 0/1\n");
    if(AchievementGet[playerid][aJestemLepszy] >= 1)
		format(oJestemLepszy, sizeof(oJestemLepszy), "4. {1DEB02}Jestem lepszy! - Zakończony\n");
	else
		format(oJestemLepszy, sizeof(oJestemLepszy), "4. Jestem lepszy! - 0/1\n");
    if(AchievementGet[playerid][aJestemMistrzem] >= 1)
		format(oJestemMistrzem, sizeof(oJestemMistrzem), "5. {1DEB02}Jestem mistrzem! - Zakończony\n");
	else
		format(oJestemMistrzem, sizeof(oJestemMistrzem), "5. Jestem mistrzem! - 0/1\n");
    if(AchievementGet[playerid][aPilot] >= 60)
		format(oPilot, sizeof(oPilot), "6. {1DEB02}Pilot - Zakończony\n");
	else
		format(oPilot, sizeof(oPilot), "6. Pilot - %d/60\n",AchievementGet[playerid][aPilot]);
    if(AchievementGet[playerid][a24Godziny] >= 1)
		format(o24Godziny, sizeof(o24Godziny), "7. {1DEB02}24 godziny - Zakończony\n");
	else
		format(o24Godziny, sizeof(o24Godziny), "7. 24 godziny - 0/1\n");
    if(AchievementGet[playerid][aDoOstatniegoTchu] >= 1)
		format(oDoOstatniegoTchu, sizeof(oDoOstatniegoTchu), "8. {1DEB02}Do ostatniego tchu - Zakończony\n");
	else
		format(oDoOstatniegoTchu, sizeof(oDoOstatniegoTchu), "8. Do ostatniego tchu - 0/1\n");
    if(AchievementGet[playerid][aCelneOko] >= 100)
		format(oCelneOko, sizeof(oCelneOko), "8. {1DEB02}Celne Oko - Zakończony\n");
	else
		format(oCelneOko, sizeof(oCelneOko), "8. Celne Oko - %d/100\n",AchievementGet[playerid][aCelneOko]);
    if(AchievementGet[playerid][aZwinnePalce] >= 100)
		format(oZwinnePalce, sizeof(oZwinnePalce), "9. {1DEB02}Zwinne Palce - Zakończony\n");
	else
		format(oZwinnePalce, sizeof(oZwinnePalce), "9. Zwinne Palce - %d/100\n",AchievementGet[playerid][aZwinnePalce]);
	strcat(string,oRegistered);
    strcat(string,oTrofea);
    strcat(string,oDoscTego);
    strcat(string,oKask);
	strcat(string,oJestemLepszy);
    strcat(string,oJestemMistrzem);
    strcat(string,oPilot);
    strcat(string,o24Godziny);
    strcat(string,oDoOstatniegoTchu);
    strcat(string,oCelneOko);
    strcat(string,oZwinnePalce);
    strcat(string,""R"Dalej");
	SPD(playerid,D_OSIAGNIECIA_1,DIALOG_STYLE_LIST,"{00BFFF}Osiągnięcia "W"- Strona 1",string,"Wybierz","Zamknij");
	return 1;
CMD:idzdo(playerid,cmdtext[])
	new userid;
	if(sscanf(cmdtext, "i", userid))
	    SCM(playerid, C_WHITE, ""I" "W"/idzdo [id gracza]");
	    return 1;
	if(userid == INVALID_PLAYER_ID)
	    SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
	    return 1;
	if(playerid == userid)
	    SCM(playerid, C_WHITE, ""I" "W"Podałeś(aś) swoje id!");
	    return 1;
    if(Player[playerid][TPRefused] > 0)
		new String[90];
		format(String,sizeof(String),""WE" "R"Tej komendy możesz użyć dopiero za %d sekund.",Player[playerid][TPRefused]);
		SCM(playerid, C_RED, String);
		return 1;
	GoTo(playerid, userid);
	return 1;
CMD:randka(playerid, cmdtext[])
	new userid;
	if(sscanf(cmdtext, "i", userid))
	    SCM(playerid, C_WHITE, ""I" "W"/randka [id gracza]");
	    return 1;
	if(userid == INVALID_PLAYER_ID)
	    SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
	    return 1;
	if(playerid == userid)
	    SCM(playerid, C_WHITE, ""E" "W"Podałeś(aś) swoje id!");
	    return 1;
 	if(Player[playerid][TPRefused] > 0)
		new String[90];
		format(String,sizeof(String),""WE" "R"Odczekaj %d sekund.",Player[playerid][TPRefused]);
		SCM(playerid, C_RED, String);
		return 1;
    if(Chowany[userid] || Szukajacy[userid] && ChWystartowala)
		SCM(playerid, C_ERROR, ""WE" "R"Ten gracz jest na evencie!");
		return 1;
    if(DerbyMen[userid] && DerbyON)
		SCM(playerid, C_ERROR, ""WE" "R"Ten gracz jest na evencie!");
		return 1;
    if(WGTeam[userid] == 1 || WGTeam[userid] == 2)
		SCM(playerid, C_ERROR, ""WE" "R"Ten gracz jest na evencie!");
		return 1;
    if(PBTeam[userid] == 1 || PBTeam[userid] == 2)
		SCM(playerid, C_ERROR, ""WE" "R"Ten gracz jest na evencie!");
		return 1;
    if(RaceWystartowal && WyscigUczestnik[userid])
		SCM(playerid, C_ERROR, ""WE" "R"Ten gracz jest na evencie!");
		return 1;
    if(userid == RywalSolo[0] || userid == RywalSolo[1])
		SCM(playerid, C_ERROR, ""WE" "R"Ten gracz odbywa solówkę!");
		return 1;
    if(Player[userid][OnOnede] || Player[userid][OnMinigun] || Player[userid][OnRPG] || Player[userid][OnCombat] && GetPlayerVirtualWorld(userid) == 10)
  	 	SCM(playerid, C_ERROR, ""WE" "R"Ten gracz jest na arenie!");
   		PlaySoundForPlayer(playerid,1085);
		return 1;
	Player[playerid][TPTo] = userid;
	GivePlayerWeapon(playerid, 14, 1);
	new String[230];
	format(String, sizeof(String), "Gracz "W"%s (%d) "GUI"chce się umowic sie z Toba na randke w ciemno.\nWyrażasz na to zgodę?\n\nGoldServer zasponsoruje wam kwiaty ;)", Player[playerid][Name], playerid);
	SPD(userid, D_TP, DIALOG_STYLE_MSGBOX, "{00BFFF}Randka", String, "Akceptuj", "Odrzuć");
	SCM(playerid, C_GREEN, ""WI" "G"Zaproszenie zostało wysłane, powodzenia. ;)");
	return 1;
CMD:soloexit(playerid)
	if(RywalSolo[0] == playerid || RywalSolo[1] == playerid)
		new strong[100];
		if(RywalSolo[0] == playerid)
	   		foreach(Player,x)
				if(IsPlayerInArea(x,-1486.0240,-1343.8665,335.8203,446.1019))
					format(strong,sizeof(strong),"(Solo) Wyzwanie wygrywa %s! (Przeciwnik zrezygnował)",Player[RywalSolo[1]][Name]);
					SCM(x, C_YELLOW, strong);
			Achievement(RywalSolo[1], "aJestemLepszy");
			new Float:hp,Float:arm;
			GetPlayerHealth(RywalSolo[1], hp);
            GetPlayerArmour(RywalSolo[1], arm);
			if(hp == 100.0 && arm == 100.0)
				Achievement(RywalSolo[1], "aJestemMistrzem");
			SoloEnd(-1);
		else if(RywalSolo[1] == playerid)
			foreach(Player,x)
				if(IsPlayerInArea(x,-1486.0240,-1343.8665,335.8203,446.1019))
					format(strong,sizeof(strong),"(Solo) Wyzwanie wygrywa %s! (Przeciwnik zrezygnował)",Player[RywalSolo[0]][Name]);
					SCM(x, C_YELLOW, strong);
            Achievement(RywalSolo[0], "aJestemLepszy");
            new Float:hp,Float:arm;
			GetPlayerHealth(RywalSolo[0], hp);
            GetPlayerArmour(RywalSolo[0], arm);
			if(hp == 100.0 && arm == 100.0)
				Achievement(RywalSolo[0], "aJestemMistrzem");
			SoloEnd(-1);
	else{
		SCM(playerid,C_WHITE,""E" "W"Aby zrezygnować z solówki musisz być jej uczestnikiem!");
	return 1;
CMD:soloend(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	foreach(Player,x)
		if(IsPlayerInArea(x, -1486.0240,-1343.8665,335.8203,446.1019))
			SCM(x,C_YELLOW,"(Solo) Administrator zakończył rozgrywkę solo!");
	SoloEnd(-1);
	return 1;
CMD:arenasolo(playerid)
    PlayerTeleport(playerid,0,-1468.4532,344.1803,30.0820,"ARENA SOLO",1);
	return 1;
CMD:solowyzwij(playerid,cmdtext[])
    if(!IsPlayerInArea(playerid, -1486.0240,-1343.8665,335.8203,446.1019)) return SCM(playerid, C_WHITE, ""E" "W"Musisz być na arenie solowek!");
    if(SoloON) return SCM(playerid,C_WHITE,""E" "W"Aktualnie odbywa się jakaś solówka!");
    new gracz,bron;
	if(sscanf(cmdtext,"id",gracz,bron))
	    SCM(playerid, C_WHITE, ""I" "W"/SoloWyzwij [ID] [ID_broni]");
		return 1;
	if(!IsPlayerConnected(gracz))
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
		return 1;
	if(gracz == playerid)
		SCM(playerid, C_WHITE, ""E" "W"Nie możesz wyzwać siebie na solo!");
		return 1;
	if(bron < 0 || bron > 46)
		SCM(playerid, C_WHITE, ""E" "W"Dozwolona broń od 0 do 46.");
		return 1;
	if(!IsPlayerInArea(playerid, -1486.0240,-1343.8665,335.8203,446.1019)) return SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest na arenie solówek!");
    new bool:Moze = true;
	for(new b=0; b<sizeof(Abronie); b++)
		if(Abronie[b]==bron)
			SCM(playerid,C_WHITE,""E" "W"Ta broń jest niedozwolona!");
			Moze = false;
			break;
	if(!Moze) return 1;
    Player[gracz][SoloWyzywa] = playerid;
	Player[playerid][SoloBron] = bron;
	new tmp[128];
	format(tmp,sizeof(tmp),"Gracz %s wyzywa cię na solówkę bronią %s!\n\nAkceptujesz wyzwanie?",Player[playerid][Name],ReturnWeaponName(bron));
	SPD(gracz,D_SOLO,0,"{00BFFF}Solówka",tmp,"Tak","Nie");
	format(tmp, sizeof(tmp), ""WI" "G"Wyzwałeś(aś) gracza %s na solowke bronią %s.", Player[gracz][Name],ReturnWeaponName(bron));
	SCM(playerid,C_GREEN, tmp);
	return 1;
CMD:wg(playerid)
	if(WGON)
		SCM(playerid,C_RED,""WE" "R"Wojna Gangów juz wystartowala!");
		return 1;
	if(WGKandydat[playerid])
		SCM(playerid,C_RED,""WE" "R"Jesteś juz zapisany(a) na Wojne Gangów!");
		return 1;
	if(WGGlos[playerid])
		SCM(playerid,C_RED,""WE" "R"Wycofałeś(aś) sie z tej rundy WG.");
		return 1;
	WGLiczba ++;
	WGKandydat[playerid] = true;
	WGGlos[playerid] = true;
    SPD(playerid,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Wojna Gangów","Zapisałeś(aś) się na wojnę gangów.","Zamknij","");
	//SCM(playerid,C_GREEN,""W"*(WG) "G"Zapisałeś(aś) się na "G2"Wojnę Gangów! "G"Aby się wypisać wpisz "G2"/wgexit"G".");
	ZapisyUpdate();
	PlayerPlaySound(playerid,1150,0.0,0.0,0.0);
	if(WGLiczba == 4 && !WGStarted) //4
	    WGStarted = true;
		WGKandydat[playerid] = true;
		ZabawaWG = SetTimer("WGStart",20000,0);
		SCMA(C_WHITE," {00C7D1}*(WG) "W"Wojna Gangów wystartuje za {00C7D1}20 sek. "W"(Zapisy nadal trwają!)");
		KillTimer(WGTimer);
		WGTimer = SetTimer("WGoff",240000,0);
		return 1;
	return 1;
CMD:wgexit(playerid)
	if(WGON && WGTeam[playerid] > 0)
		SetPlayerActualInfo(playerid);
	WGTeam[playerid] = 0;
	WGKandydat[playerid] = false;
	//PlayerSetColor(playerid);
	SetPlayerTeam(playerid,playerid+10);
	SetPlayerHealth(playerid, 100);
	SCM(playerid,C_GREEN," "W"*(WG) "G"Wypisałeś(aś) się z WG.");
	return 1;
CMD:wgend(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_RED,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
    KillTimer(ZabawaWG);
	WGoff();
	SCMA(C_RED,""WI" "R"Wojna Gangów zakonczona przez Admina!");
	return 1;
CMD:pb(playerid)
	if(PBON)
		SCM(playerid,C_RED,""WE" "R"Paintball już wystartował!");
		return 1;
	if(PBKandydat[playerid])
		SCM(playerid,C_RED,""WE" "R"Jesteś juz zapisany(a) na paintball!");
		return 1;
	if(PBGlos[playerid])
		SCM(playerid,C_RED,""WE" "R"Wycofałeś(aś) sie z tej rundy paintball'u.");
		return 1;
	PBLiczba ++;
	PBKandydat[playerid] = true;
	PBGlos[playerid] = true;
    SPD(playerid,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Paintball","Zapisałeś(aś) się na paintball drużynowy.","Zamknij","");
	//SCM(playerid,C_GREEN,""W"*(PB) "G"Zapisałeś(aś) się na "G2"Paintball! "G"Aby się wypisać wpisz "G2"/pbexit"G".");
	ZapisyUpdate();
    PlayerPlaySound(playerid,1150,0.0,0.0,0.0);
	if(PBLiczba == 4 && !PBStarted) //4
	    PBStarted = true;
		PBKandydat[playerid] = true;
		ZabawaPB = SetTimer("PBStart",20000,0);
		SCMA(C_WHITE," {00C7D1}*(PB) "W"Paintball wystartuje za {00C7D1}20 sek. "W"(Zapisy nadal trwają!)");
		KillTimer(PBTimer);
		PBTimer = SetTimer("PBoff",240000,0);
		return 1;
	return 1;
CMD:pbexit(playerid)
	if(PBON && PBTeam[playerid] > 0)
		SetPlayerActualInfo(playerid);
		TextDrawHideForPlayer(playerid, PBTD);
	PBTeam[playerid] = 0;
	PBKandydat[playerid] = false;
	SetPlayerTeam(playerid,playerid+10);
	SCM(playerid,C_GREEN," "W"*(PB) "G"Wypisałeś(aś) się z PB.");
	return 1;
CMD:pbend(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_RED,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
    KillTimer(ZabawaPB);
	PBoff();
	SCMA(C_RED,""WI" "R"PaintBall zakończony przez Admina!");
	return 1;
CMD:usexit(playerid)
	if(DerbyMen[playerid] && DerbyON)
	    SetPlayerActualInfo(playerid);
	DerbyMen[playerid] = false;
	SCM(playerid,C_GREEN,""WI" "G"Wypisałeś(aś) się z US.");
	return 1;
CMD:usend(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_RED,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
    KillTimer(ZabawaUS);
	DerbyEnd();
	SCMA(C_RED,""WI" "R"Uważaj Spadasz przerwane przez admina!");
	return 1;
CMD:us(playerid)
	if(DerbyON)
	    SCM(playerid,C_RED,""WE" "R"Uważaj Spadasz już wystartowało!");
	    return 1;
	if(DerbyMen[playerid])
		SCM(playerid,C_RED,""WE" "R"Jesteś już zapisany(a) na US!");
		return 1;
	if(DerbyZaglosowal[playerid])
	    SCM(playerid,C_RED,""WE" "R"Wypisałeś(aś) się już z tej rundy US!");
	    return 1;
	new licz;
	foreach(Player,x)
		if(IsPlayerConnected(x) && DerbyMen[x])
			licz ++;
	if(licz >= 16)
	    SCM(playerid,C_RED,""WE" "R"Mamy już max. zapisanych, spróbuj następnym razem!");
		return 1;
    SPD(playerid,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Uważaj Spadasz","Zapisałeś(aś) się na Uważaj Spadasz.","Zamknij","");
	//SCM(playerid,C_GREEN,""W"*(US) "G"Zapisałeś(aś) się na "G2"Uważaj Spadasz"G". Aby się wypisać wpisz "G2"/usexit"G".");
    PlayerPlaySound(playerid,1150,0.0,0.0,0.0);
	DerbyMen[playerid] = true;
	DerbyZaglosowal[playerid] = true;
	new LiczbaDerb = 0;
	foreach(Player,x)
		if(DerbyMen[x] && IsPlayerConnected(x))
			LiczbaDerb ++;
	ZapisyUpdate();
	if(LiczbaDerb == 4 && !DerbyStartON)
        DerbyRand = random(2);
		if(DerbyRand != 0 && DerbyRand != 1)
            DerbyRand = 1;
		if(DerbyRand == 0)
 			SCMA(C_WHITE," {00C7D1}*(US) "W"Uważaj Spadasz wystartuje za 20 sek. {00C7D1}Arena: Derby1 - Monster "W"(Zapisy nadal trwają!)");
		if(DerbyRand == 1)
            SCMA(C_WHITE," {00C7D1}*(US) "W"Uważaj Spadasz wystartuje za 20 sek. {00C7D1}Arena: Derby2 - Cheetach "W"(Zapisy nadal trwają!)");
		ZabawaUS = SetTimer("DerbyStart",20000,0);
        DerbyStartON = true;
	return 1;
CMD:chend(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_RED,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	SCMA(C_RED," "W"*(CH) "R"Zabawa w chowanego przerwana przez Admina!");
    KillTimer(ZabawaCH);
	ChowanyEnd();
	return 1;
CMD:ch(playerid)
	if(Szukajacy[playerid])
		SCM(playerid,C_RED,""WE" "R"Jesteś już zapisany(a) jako szukający!");
		return 1;
	if(ChWystartowala)
		SCM(playerid,C_RED,""WE" "R"Zabawa już wystartowała!");
		return 1;
	if(ChowanyZapisany[playerid])
		SCM(playerid,C_RED,""WE" "R"Zapisałeś(aś) się już na chowanego!");
		return 1;
	if(ChNum > -1 && ChNum < 50)
		ChowanyKandydat[ChNum] = playerid;
		ChowanyZapisany[playerid] = true;
		ChNum ++;
		SPD(playerid,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Chowany","Zapisałeś(aś) się na zabawę w chowanego.","Zamknij","");
		//SCM(playerid,C_GREEN,""W"*(CH) "G"Zapisałeś się na zabawę w "G2"chowanego"G"! Aby się wypisać wpisz "G2"/chexit"G".");
		ZapisyUpdate();
        PlayerPlaySound(playerid,1150,0.0,0.0,0.0);
 	else
		SCM(playerid,C_RED,""WE" "R"Zapisało się 50 garczy i jest to maksimum! Spróbuj następnym razem");
	if(ChNum == 5 && !ChStarted)
		SCMA(C_WHITE," {00C7D1}*(CH) "W"Chowany wystartuje za {00C7D1}20 sek. "W"(Zapisy nadal trwają!)");
		KillTimer(ChEndTimer);
		ChEndTimer = SetTimer("ChowanyAutoEnd",600000,false);
		ZabawaCH = SetTimer("ChowanyWyznaczArene",20000,false);
		ChStarted = true;
	return 1;
CMD:chexit(playerid)
	SCM(playerid,C_GREEN,""WI" "G"Wypisałeś(aś) się z zabawy w chowanego!");
	if(Szukajacy[playerid])
        SCM(playerid,C_RED,""WE" "R"Jesteś szukającym i nie możesz wypisać się z chowanego!");
		return 1;
	if(Chowany[playerid] && ChWystartowala)
		SetPlayerHealth(playerid,100);
		SetPlayerVirtualWorld(playerid,0);
		SetPlayerActualInfo(playerid);
		ResetPlayerWeapons(playerid);
	Chowany[playerid] = false;
	Szukajacy[playerid] = false;
	for(new x=0;x<50;x++)
		if(ChowanyKandydat[x] == playerid)
			ChowanyKandydat[x] = -1;
			break;
	return 1;
CMD:wsend(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_RED,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	SCMA(C_RED," "W"*(WS) "R"Wyścig został zakończony przez admina!");
	KillTimer(ZabawaWS);
	TotalRaceEnd();
	return 1;
CMD:wsexit(playerid)
	SCM(playerid,C_GREEN," "W"*(WS) "G"Wypisałeś(aś) się z wyścigu!");
	if(RaceWystartowal && WyscigUczestnik[playerid])
		SetPlayerVirtualWorld(playerid,0);
		DisablePlayerRaceCheckpoint(playerid);
	WyscigUczestnik[playerid] = false;
    TextDrawHideForPlayer(playerid, RaceStats[playerid]);
	WSMans = 0;
	foreach(Player,x)
		if(WyscigUczestnik[x])
			WSMans ++;
	if(WSMans <= 0 && RaceWystartowal)
		SCMA(C_GREEN," "W"*(WS) "G"Wyścig zakończony!");
        SoundForAll(1150);
		TotalRaceEnd();
	return 1;
CMD:ws(playerid)
	WSMans = 0;
	foreach(Player,x)
		if(WyscigUczestnik[x])
			WSMans ++;
	if(RaceWystartowal)
		SCM(playerid,C_RED,""WE" "R"Wyścig już wystarował!");
		return 1;
	if(WyscigUczestnik[playerid])
		SCM(playerid,C_RED,""WE" "R"Już jesteś zapisany(a) na ten wyścig!");
		return 1;
	if(WSMans >= 10)
		SCM(playerid,C_RED,""WE" "R"Mamy już pierwszych 10 kandydatów, może następnym razem ci sie uda");
		return 1;
	WyscigUczestnik[playerid] = true;
	WyscigStatus[playerid] = 0;
	WSMans ++;
	if(WSMans == 4)
		SCMA(C_WHITE," {00C7D1}*(WS) "W"Wyścig wystartuje za {00C7D1}20 sek. "W"(Zapisy nadal trwają!)");
        ZabawaWS = SetTimer("RaceAutoStart",20000,0);
    SPD(playerid,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Wyścigi","Zapisałeś(aś) się na wyścigi.","Zamknij","");
	//SCM(playerid,C_GREEN,""W"*(WS) "G"Zapisałeś się na "G2"wyścig! "G"Aby się wypisać wpisz "G2"/wsexit"G".");
    PlayerPlaySound(playerid,1150,0.0,0.0,0.0);
	ZapisyUpdate();
	return 1;
CMD:sn(playerid)
	if(SNON)
		SCM(playerid,C_RED,""WE" "R"Sianko już wystartowało!");
		return 1;
	if(SNKandydat[playerid])
		SCM(playerid,C_RED,""WE" "R"Jesteś juz zapisany(a) na Sianko!");
		return 1;
	if(SNGlos[playerid])
		SCM(playerid,C_RED,""WE" "R"Wycofałeś(aś) sie z tej rundy sianka.");
		return 1;
	SNLiczba ++;
	SNKandydat[playerid] = true;
	SNGlos[playerid] = true;
    SPD(playerid,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Sianko","Zapisałeś(aś) się na sianko.","Zamknij","");
	ZapisyUpdate();
	PlayerPlaySound(playerid,1150,0.0,0.0,0.0);
	if(SNLiczba == 4 && !SNStarted) //4
	    SNStarted = true;
		SNKandydat[playerid] = true;
		ZabawaSN = SetTimer("SNStart",20000,0);
		SCMA(C_WHITE," {00C7D1}*(SN) "W"Sianko wystartuje za {00C7D1}20 sek. "W"(Zapisy nadal trwają!)");
		KillTimer(SNTimer);
		SNTimer = SetTimer("SNoff",240000,0);
		return 1;
	return 1;
CMD:snexit(playerid)
	if(SNON)
		SetPlayerActualInfo(playerid);
	SNKandydat[playerid] = false;
	SetPlayerTeam(playerid,playerid+10);
	SetPlayerHealth(playerid, 100);
	SCM(playerid,C_GREEN," "W"*(SN) "G"Wypisałeś(aś) się z sianka.");
	return 1;
CMD:snend(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_RED,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
    KillTimer(ZabawaSN);
	SNoff();
	SCMA(C_RED,""WI" "R"Sianko zakonczone przez Admina!");
	return 1;
CMD:pmon(playerid)
	SCM(playerid,C_GREEN,""WI" "G"Odblokowałeś(aś) prywatne wiadomości do ciebie.");
	ChcePM[playerid] = true;
	return 1;
CMD:pmoff(playerid)
	SCM(playerid,C_GREEN,""WI" "G"Zablokowałeś(aś) prywatne wiadomości do ciebie.");
	ChcePM[playerid] = false;
	return 1;
CMD:pm(playerid,cmdtext[])
	new Wiadomosc[128];
	new string[150];
	new gracz;
	if(sscanf(cmdtext,"is[128]",gracz,Wiadomosc))
	    SCM(playerid, C_WHITE, ""I" "W"/pm [ID_gracza] [Wiadomość]");
	    return 1;
    if(gracz == playerid)
	    SCM(playerid, C_WHITE, ""E" "W"Nie możesz pisać do siebie!");
	    return 1;
	if(gracz < 0 || gracz >= MAX_PLAYERS || !IsPlayerConnected(gracz)) return SCM(playerid, C_RED, ""WE" "R"Ten gracz nie jest podłączony!");
	if(!ChcePM[gracz]) return SCM(playerid, C_RED, ""WE" "R"Ten gracz ma zablokowane prywatne wiadomości");
	pmid1 = playerid;
	pmid2 = gracz;
	format(string, sizeof(string), " >> PM od {FFCC66}%s(%d){FFCC22}: %s", Player[playerid][Name],playerid,Wiadomosc);
	SCM(gracz,0xFFCC2299, string);
	format(string, sizeof(string), " >> PM wysłano do {FFCC66}%s(%d){FFCC22}: %s", Player[gracz][Name],gracz,Wiadomosc);
	SCM(playerid,0xFFCC2299, string);
	if(podgladPM == 1)
		format(string, sizeof(string), "%s(%d) -> %s(%d): %s", Player[playerid][Name],playerid,Player[gracz][Name],gracz,Wiadomosc);
		SendClientMessageToAdminsPM(C_YELLOW,string);
	PlayerPlaySound(gracz, 1139, 0, 0, 0);
	GameTextForPlayer(gracz, "~y~dostales ~h~pm", 2000, 1);
	return 1;
CMD:podgladpmon(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_RED,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	podgladPM = 1;
	SendClientMessageToAdmins(C_GREEN,""WI" "G"Podglad prywatnych wiadomosci włączony!");
	return 1;
CMD:podgladpmoff(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_RED,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	podgladPM = 0;
	SendClientMessageToAdmins(C_GREEN,""WI" "G"Podglad prywatnych wiadomosci wyłączony!");
	return 1;
CMD:delauta(playerid)
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_RED,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
 	foreach(Player,x)
		Player[x][Nrgs] = 0;
	DelPojazdy();
	return 1;
CMD:deltrailers(playerid)
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_RED,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	DelTrailers();
	return 1;
CMD:rsptrailers(playerid)
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_RED,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	for(new v=0; v<MAX_VEHICLES; v++)
		if(IsTrailer(v))
			SetVehicleToRespawn(v);
	SCMA(C_YELLOW, ""WI" "Y"Nastąpił respawn nie używanych wagonów!");
	return 1;
CMD:rspauta(playerid)
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_RED,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	for(new v=0; v<MAX_VEHICLES; v++)
		if(!IsVehicleInUse(v) && !IsTrailer(v))
			SetVehicleToRespawn(v);
    new String[128];
	format(String,sizeof(String),""WI" "Y"%s zrobił respawn nie używanych pojazdów!",Player[playerid][Name]);
	SCMA(C_YELLOW, String);
	return 1;
CMD:ecmd(playerid)
	new string[300];
	strcat(string,""W"/eKasa "GUI"- dostajesz $50000  (25 exp)\n");
	strcat(string,""W"/eJetpack "GUI"- dostajesz jetpack (300 exp)\n");
	strcat(string,""W"/eZestaw "GUI"- dostajesz MEGA zestaw broni (100 exp)\n");
	strcat(string,""W"/eInvisible "GUI"- niewidzialnosc na mapie (20 exp)\n");
	strcat(string,""W"/eHP "GUI"- Masz 200 HP. (250 exp)\n");
	SPD(playerid,D_NONE,0,"{00BFFF}Komendy za Exp",string,"Zamknij","");
	return 1;
CMD:ekasa(playerid)
	if(Player[playerid][Exp] < 25) return SCM(playerid, C_ERROR, ""WE" "R" Nie masz wystarczającej ilości respektu!");
	GivePlayerMoney(playerid, 50000);
	Player[playerid][Exp] -= 25;
    Player[playerid][Money] += 50000;
    GameTextForPlayer(playerid,"~w~Exp - ~b~~h~25", 1000, 1);
    SCM(playerid,C_ERROR,""WE" "R" Dostałeś kasę kosztem 25 pkt respektu.");
	return 1;
CMD:ejetpack(playerid)
	if(Player[playerid][Exp] < 300) return SCM(playerid, C_ERROR, ""WE" "R" Nie masz wystarczającej ilości respektu!");
	SetPlayerSpecialAction(playerid, 2);
	Player[playerid][Exp] -= 300;
    SCM(playerid,C_ERROR,""WE" "R" Dostałeś jetpacka kosztem 300 pkt respektu.");
    GameTextForPlayer(playerid,"~w~Exp - ~b~~h~300", 1000, 1);
	return 1;
CMD:ezestaw(playerid)
	if(Player[playerid][Exp] < 100) return SCM(playerid, C_ERROR, ""WE" "R" Nie masz wystarczającej ilości respektu!");
	GivePlayerWeapon(playerid, 24, 5000);
	GivePlayerWeapon(playerid, 31, 5000);
	GivePlayerWeapon(playerid, 34, 5000);
	GivePlayerWeapon(playerid, 9, 5000);
	GivePlayerWeapon(playerid, 28, 5000);
	Player[playerid][Exp] -= 100;
    PlaySoundForPlayer(playerid, 30800);
    SCM(playerid,C_ERROR,""WE" "R" Dostałeś super zestaw kosztem 100 pkt respektu.");
    GameTextForPlayer(playerid,"~w~Exp - ~b~~h~100", 1000, 1);
	return 1;
CMD:einvisible(playerid)
	if(Player[playerid][Exp] < 20) return SCM(playerid, C_ERROR, ""WE" "R" Nie masz wystarczającej ilości respektu!");
	Player[playerid][Exp] -= 20;
    Player[playerid][Color] = 0xFFFFFF00;
    format(Player[playerid][ChatColor],15,HexToString(Player[playerid][Color]));
	SetPlayerColor(playerid,0xFFFFFF00);
    SCM(playerid,C_ERROR,""WE" "R" Twój nick nad głową i marker na mapie został ukryty. Kolor na czacie jednak pozostał.");
    GameTextForPlayer(playerid,"~w~Exp - ~b~~h~20", 1000, 1);
	return 1;
CMD:ehp(playerid)
	if(Player[playerid][Exp] < 250) return SCM(playerid, C_ERROR, ""WE" "R" Nie masz wystarczającej ilości respektu!");
	SetPlayerHealth(playerid, 200);
	Player[playerid][Exp] -= 250;
    SCM(playerid,C_ERROR,""WE" "R" Otrzymałeś 200 hp kosztem 250 pkt respektu.");
    GameTextForPlayer(playerid,"~w~Exp - ~b~~h~250", 1000, 1);
	return 1;
CMD:laser(playerid)
	SPD(playerid,D_LASER,DIALOG_STYLE_LIST,"{00BFFF}Wybierz Kolor Laseru",""R"› Czerwony\n"B"› Niebieski\n{E01BD0}› Fioletowy\n{FFA600}› Pomarańczowy\n"G"› Zielony\n"Y"› Żółty\n"W"› Usuń Laser","Wybierz","Zamknij");
	return 1;
CMD:nbronie(playerid)
	SPD(playerid, D_NBRONIE, DIALOG_STYLE_LIST, "{00BFFF}Modele Broni", "› Nowy MP5\n"GUI2"› Nowa Pałka Basketballowy\n"W"› Nowy AK-47\n"GUI2"› Bio Laser\n"W"› Normalne bronie", "Wybierz", "Anuluj");
	return 1;
CMD:neony(playerid)
	if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, C_WHITE, ""E" "W"Musisz być w pojeździe aby tego użyć!");
	SPD(playerid,D_NEONY,DIALOG_STYLE_LIST,"{00BFFF}Wybierz Kolor Neonu","› Czerwony\n› Zielony\n› Biały\n› Fioletowy\n› Żółty\n› Błękitny\n› Jasnoniebieski\n› Różowy\n› Pomarańczowy\n› Jasnozielony\n› Niebieski\n› Żółty\n"GUI2"› Usuń neon","Wybierz","Zamknij");
	return 1;
CMD:neon(playerid)
	return cmd_neony(playerid);
CMD:auto(playerid)
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		SPD(playerid,D_AUTO,DIALOG_STYLE_LIST,"{00BFFF}Kontrola Pojazdu","› Silnik\n"GUI2"› Światła\n"W"› Alarm\n"GUI2"› Drzwi\n"W"› Bagażnik\n"GUI2"› Maska\n"W"› Tablica Rejestracyjna","Wybierz","Zamknij");
	else
        SCM(playerid, C_RED, ""WI" "R" Musisz być w pojeździe aby użyć tej komendy.");
	return 1;
CMD:ms(playerid)
	if(!Player[playerid][FirstSpawn]) return SCM(playerid, C_RED, ""WE" "R"Możesz tego użyć tylko przy wchodzeniu na serwer!");
	if(Player[playerid][Registered] && !Player[playerid][Logged])
        SCM(playerid, C_RED, ""WE" "R"Najpierw zaloguj się na swoje konto!");
		return 1;
	SetSpawnInfo(playerid,0,Player[playerid][Skin],0,0,0,0,4,1,24,3000,29,3000);
    PlayerPlaySound(playerid,1188,0.0,0.0,0.0);
	UnPanorama(playerid);
	TextDrawShowForPlayer(playerid, CzasTD);
    TextDrawShowForPlayer(playerid, DataTD);
    TextDrawShowForPlayer(playerid, HealthTD[playerid]);
	TextDrawShowForPlayer(playerid, ArmourTD[playerid]);
	TextDrawShowForPlayer(playerid, ZapisyString);
	TextDrawShowForPlayer(playerid, ZapisyLiczba);
    for(new x=0;x<13;x++)
		TextDrawShowForPlayer(playerid,PasekBox[x]);
	TextDrawShowForPlayer(playerid,PasekStringGora);
 	TextDrawShowForPlayer(playerid,ExpTD[playerid]);
 	TextDrawShowForPlayer(playerid,LevelTD[playerid]);
	TextDrawShowForPlayer(playerid,OnlineTD[playerid]);
	TextDrawShowForPlayer(playerid,RatioTD[playerid]);
	TextDrawShowForPlayer(playerid,PortfelTD[playerid]);
	TextDrawShowForPlayer(playerid,GraczeTD);
    TextDrawShowForPlayer(playerid,WpiszVIPTD);
	SpawnPlayer(playerid);
	SCM(playerid, C_WHITE, ""I" "W"Wczytałeś swojego poprzedniego skina.");
	return 1;
CMD:givegun(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_RED,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz,bron,ammo;
	if(sscanf(cmdtext,"idd",gracz,bron,ammo))
	    SCM(playerid,C_WHITE,""I" "W"/givegun [ID] [ID broni] [Amunicja]");
		return 1;
	if(gracz < 0 || gracz >= MAX_PLAYERS || !IsPlayerConnected(gracz))
	    SCM(playerid,C_WHITE,""E" "W"Ten gracz nie jest podłaczony!");
		return 1;
	if(bron < 0 || bron > 46)
	    SCM(playerid,C_WHITE,""E" "W"Niepoprawne ID broni!");
		return 1;
	if(ammo < 1 || ammo > 9999999)
	    SCM(playerid,C_WHITE,""E" "W"Niepoprawna ilość amunicji!");
		return 1;
	GivePlayerWeapon(gracz,bron,ammo);
    PlaySoundForPlayer(gracz, 30800);
	new tmp[128];
	format(tmp, sizeof(tmp), ""WI" "G"Dałeś(aś) broń %s i %d amunicji graczowi %s.",ReturnWeaponName(bron),ammo,Player[gracz][Name]);
	SCM(playerid,C_GREEN,tmp);
	format(tmp, sizeof(tmp), ""WI" "G"%s dał(a) ci broń %s i %d amunicji.",Player[playerid][Name],ReturnWeaponName(bron),ammo);
	SCM(gracz,C_GREEN,tmp);
	return 1;
CMD:givegunall(playerid,cmdtext[])
	if(!Player[playerid][Admin1]) return SCM(playerid,C_RED,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new bron,ammo;
	if(sscanf(cmdtext,"dd",bron,ammo))
	    SCM(playerid,C_WHITE,""I" "W"/givegun [ID broni] [Amunicja]");
		return 1;
	if(bron < 0 || bron > 46)
	    SCM(playerid,C_WHITE,""E" "W"Niepoprawne ID broni!");
		return 1;
	if(ammo < 1 || ammo > 9999999)
	    SCM(playerid,C_WHITE,""E" "W"Niepoprawna ilość amunicji!");
		return 1;
	foreach(Player,x)
		if(!IsPlayerOnEvent(x))
			GivePlayerWeapon(x,bron,ammo);
	  		PlaySoundForPlayer(x, 30800);
	new tmp[128];
	format(tmp, sizeof(tmp), ""WI" "G"%s dał(a) wszystkim graczom broń: %s i %d amunicji.",Player[playerid][Name],ReturnWeaponName(bron),ammo);
	SCMA(C_GREEN,tmp);
	return 1;
CMD:admins(playerid)
	new string[1000];
	if(OnlineAdmins == 0)
		SCM(playerid,C_WHITE,""E" "W"Na serwerze obecnie żaden administrator nie jest online!");
		return 1;
	foreach(Player,x)
		if(Player[x][Admin1])
		    if(IsPlayerAdmin(x))
	            if(Player[x][AFK])
	                format(string,sizeof(string),"%s\n{FF1F39}(HA)	{00E865}(AFK)	{FFCC00}%21s	(%d)",string,Player[x][Name],x);
				else
	                format(string,sizeof(string),"%s\n{FF1F39}(HA)	{00E865}(GRA)	{FFCC00}%21s	(%d)",string,Player[x][Name],x);
			else
	        	if(Player[x][AFK])
                    format(string,sizeof(string),"%s\n{FF1F39}(A)	{00E865}(AFK)	{FFCC00}%21s	(%d)",string,Player[x][Name],x);
	            else
                    format(string,sizeof(string),"%s\n{FF1F39}(A)	{00E865}(GRA)	{FFCC00}%21s	(%d)",string,Player[x][Name],x);
	SPD(playerid,D_NONE,0,"{00BFFF}Administracja online:",string,"Zamknij","");
	return 1;
CMD:vgranaty(playerid)
    if(!Player[playerid][Vip]) return SCM(playerid,C_RED,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	if(Player[playerid][Exp] < 20)
	    SCM(playerid, C_ERROR, ""WE" "R"Granaty kosztują 20 exp.");
	    return 1;
	SPD(playerid, D_VGRANATY, DIALOG_STYLE_MSGBOX, "{00BFFF}Potwierdzenie", "Czy na pewno chcesz kupić 30 granatów za 20 Exp?", "Tak", "Anuluj");
	return 1;
CMD:vipy(playerid)
	return cmd_vips(playerid);
CMD:mody(playerid)
	return cmd_mods(playerid);
CMD:vips(playerid)
	new string[800];
	if(OnlineVips == 0)
		SCM(playerid,C_WHITE,""E" "W"Na serwerze obecnie żaden vip nie jest online!");
		return 1;
	foreach(Player,x)
		if(Player[x][Vip])
  			if(Player[x][AFK])
     			format(string,sizeof(string),"%s\n"W"("Y"VIP"W") (AFK) (id: %d) %s",string,x,Player[x][Name]);
			else
   				format(string,sizeof(string),"%s\n"W"("Y"VIP"W") ("G"OnLine"W") (id: %d) %s",string,x,Player[x][Name]);
	SPD(playerid,D_NONE,0,""Y"Vipy {00BFFF}online:",string,"Zamknij","");
	return 1;
CMD:mods(playerid)
	new string[800];
	if(OnlineMods == 0)
		SCM(playerid,C_WHITE,""E" "W"Na serwerze obecnie żaden moderator nie jest online!");
		return 1;
	foreach(Player,x)
		if(IsPlayerConnected(x) && Player[x][Mod])
  			if(Player[x][AFK])
     			format(string,sizeof(string),"%s\n"W"("G"Moderator"W") (AFK) (id: %d) %s",string,x,Player[x][Name]);
			else
   				format(string,sizeof(string),"%s\n"W"("G"Moderator"W") ("G"OnLine"W") (id: %d) %s",string,x,Player[x][Name]);
	SPD(playerid,D_NONE,0,""G"Moderacja {00BFFF}online:",string,"Zamknij","");
	return 1;
CMD:walizka(playerid, cmdtext[])
	if(!Player[playerid][Admin1]) return SCM(playerid,C_RED,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new Cash, Hint[255];
	if(sscanf(cmdtext, "ds[255]", Cash, Hint))
	    SCM(playerid, C_WHITE, ""I" "W"/Walizka [kasa] [podpowiedź]");
	    return 1;
	if(Cash < 1 || Cash > 10000000)
	    SCM(playerid, C_WHITE, ""E" "W"Niepoprawna suma.");
	    return 1;
	if(BagEnabled)
		DestroyPickup(BagPickup);
	new Float:PlayerPos[3];
	GetPlayerPos(playerid, PlayerPos[0], PlayerPos[1], PlayerPos[2]);
	BagPickup = CreatePickup(1210, 23, PlayerPos[0] + 2.0,PlayerPos[1] + 1.0, PlayerPos[2]);
	BagEnabled = true;
	BagCash = Cash;
	new String[255];
	format(String, sizeof(String), ""WI" "Y"%s (%d) zgubił walizkę! Jeśli ją znajdziesz, zgarniesz wszystko. Podpowiedź: %s.", Player[playerid][Name], playerid, Hint);
	SCMA(C_ERROR, String);
	format(String, sizeof(String), "Walizka jest na mapie!~n~Podpowiedz: ~r~~h~%s", Hint);
	TextDrawSetString(AnnFade, String);
	foreach(Player,x)
		ShowAndHide(x, AnnFade, 0, 0, 7*1000);
	return 1;
CMD:podkowa(playerid, cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_RED,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new Cash, Hint[255];
	if(sscanf(cmdtext, "ds[255]", Cash, Hint))
	    SCM(playerid, C_WHITE, ""I" "W"/Podkowa [kasa] [podpowiedź]");
	    return 1;
	if(Cash < 1 || Cash > 10000000)
	    SCM(playerid, C_WHITE, ""E" "W"Niepoprawna suma.");
	    return 1;
	if(PodkowaEnabled)
		DestroyPickup(PodkowaPickup);
	new Float:PlayerPos[3];
	GetPlayerPos(playerid, PlayerPos[0], PlayerPos[1], PlayerPos[2]);
	PodkowaPickup = CreatePickup(954, 23, PlayerPos[0] + 2.0,PlayerPos[1] + 1.0, PlayerPos[2]);
	PodkowaEnabled = true;
	PodkowaCash = Cash;
	new String[255];
	format(String, sizeof(String), ""WI" "Y"%s (%d) zgubił podkowę! Jeśli ją znajdziesz, zgarniesz szczęście! Podpowiedź: %s.", Player[playerid][Name], playerid, Hint);
	SCMA(C_ERROR, String);
	format(String, sizeof(String), "Podkowa jest na mapie!~n~Podpowiedz: ~b~%s", Hint);
	TextDrawSetString(AnnFade, String);
	foreach(Player,x)
		ShowAndHide(x, AnnFade, 0, 0, 7*1000);
	return 1;
CMD:prezent(playerid, cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_RED,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new Hint[255];
	if(sscanf(cmdtext, "s[255]",Hint))
	    SCM(playerid, C_WHITE, ""I" "W"/Prezent [podpowiedź]");
	    return 1;
	if(PrezentEnabled)
		DestroyPickup(PrezentPickup);
	new Float:PlayerPos[3];
	GetPlayerPos(playerid, PlayerPos[0], PlayerPos[1], PlayerPos[2]);
	PrezentPickup = CreatePickup(19055, 23, PlayerPos[0] + 2.0,PlayerPos[1] + 1.0, PlayerPos[2]);
	PrezentEnabled = true;
	new String[255];
	format(String, sizeof(String), ""WI" "Y"%s (%d) zgubił prezent! Jeśli go znajdziesz, otrzymasz go. Podpowiedź: %s", Player[playerid][Name], playerid, Hint);
	SCMA(C_ERROR, String);
	format(String, sizeof(String), "Prezent jest na mapie!~n~Podpowiedz: ~g~~h~%s", Hint);
	TextDrawSetString(AnnFade, String);
	foreach(Player,x)
		ShowAndHide(x, AnnFade, 0, 0, 7*1000);
	return 1;
CMD:cz(playerid)
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_RED,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	for(new i=0; i<101; i++)
		SCMA(0x000000AA, " ");
	new String[128];
	format(String,sizeof(String),""WI" "R"%s wyczyścił cały czat!",Player[playerid][Name]);
	SCMA(C_RED,String);
	return 1;
CMD:info(playerid,cmdtext[])
	if(!IsPlayerAdmin(playerid)) return SCM(playerid,C_RED,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new gracz;
	if(sscanf(cmdtext,"i",gracz))
	    SCM(playerid, C_WHITE, ""I" "W" /info [ID]");
		return 1;
	if(!IsPlayerConnected(gracz))
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
		return 1;
	new tmp[255];
	format(tmp,sizeof(tmp),""WI" "Y"%s - ID: %d , IP: %s, Portfel: %d, Warny: %d, AID Konta: %d",Player[gracz][Name],gracz,Player[gracz][IP],Player[gracz][Portfel],Player[gracz][Warns],Player[gracz][AID]);
	SCM(playerid,C_YELLOW,tmp);
	return 1;
CMD:id(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_RED,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new tmp[25];
	if(sscanf(cmdtext,"s[25]",tmp))
	    SCM(playerid, C_WHITE, ""I" "W"/ID [Nick]");
		return 1;
	new string[90];
	new bool:done = false;
	foreach(Player,x)
		if(strfind(Player[x][Name],tmp,true) > -1)
			format(string,sizeof(string),""I" "W"%s jest graczem o identyfikatorze %d.",Player[x][Name],x);
			SCM(playerid,C_WHITE,string);
			done = true;
			break;
	if(!done)
		format(string,sizeof(string),"Nie ma gracza o nicku podobnym do wyrażenia %s.",tmp);
		SCM(playerid,C_ERROR,string);
	return 1;
CMD:checkroom(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_RED,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new tmp[25];
	if(sscanf(cmdtext,"s[25]",tmp))
	    SCM(playerid, C_WHITE, ""I" "W"/CheckRoom [Nick]");
		return 1;
	new string[64];
	new name[MAX_PLAYER_NAME];
	new bool:done = false;
	foreach(Player,x)
		GetPlayerName(x,name,sizeof(name));
		if(strfind(name,tmp,true) > -1)
			format(string,sizeof(string),"*(ROOM) %s (%d) jest w roomie: %d",name,x,GetPlayerRoom(x));
			SCM(playerid,C_ORANGE,string);
			done = true;
			break;
	if(!done)
		format(string,sizeof(string),"Wyrażenie: %s , nie pasuje do żadnego nicku gracza",tmp);
		SCM(playerid,C_ERROR,string);
	return 1;
CMD:de(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WI" "G" Nie posiadasz uprawnień do używania tej komendy.");
	foreach(Player,x)
		if(IsPlayerConnected(x))
			GivePlayerWeapon(x,24,1000);
            PlaySoundForPlayer(x, 30800);
	SCM(playerid,C_GREEN,""WI" "G" Administrator dał wszystkim broń Desert Eagle!");
	return 1;
CMD:so(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WI" "G" Nie posiadasz uprawnień do używania tej komendy.");
	foreach(Player,x)
		if(IsPlayerConnected(x))
			GivePlayerWeapon(x,26,1000);
            PlaySoundForPlayer(x, 30800);
	SCM(playerid,C_GREEN,""WI" "G" Administrator dał wszystkim broń Sawn Off Shotgun!");
	return 1;
CMD:mp5(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WI" "G" Nie posiadasz uprawnień do używania tej komendy.");
	foreach(Player,x)
		if(IsPlayerConnected(x))
			GivePlayerWeapon(x,29,3000);
            PlaySoundForPlayer(x, 30800);
	SCM(playerid,C_GREEN,""WI" "G" Administrator dał wszystkim broń MP5!");
	return 1;
CMD:m4(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WI" "G" Nie posiadasz uprawnień do używania tej komendy.");
	foreach(Player,x)
		if(IsPlayerConnected(x))
			GivePlayerWeapon(x,31,3000);
            PlaySoundForPlayer(x, 30800);
	SCM(playerid,C_GREEN,""WI" "G" Administrator dał wszystkim broń M4!");
	return 1;
CMD:sniper(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WI" "G" Nie posiadasz uprawnień do używania tej komendy.");
	foreach(Player,x)
		if(IsPlayerConnected(x))
			GivePlayerWeapon(x,34,1000);
            PlaySoundForPlayer(x, 30800);
	SCM(playerid,C_GREEN,""WI" "G" Administrator dał wszystkim broń Sniper Rifle!");
	return 1;
CMD:shotgun(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WI" "G" Nie posiadasz uprawnień do używania tej komendy.");
	foreach(Player,x)
		if(IsPlayerConnected(x))
			GivePlayerWeapon(x,25,1000);
            PlaySoundForPlayer(x, 30800);
	SCM(playerid,C_GREEN,""WI" "G" Administrator dał wszystkim broń Shotgun!");
	return 1;
CMD:combatshotgun(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WI" "G" Nie posiadasz uprawnień do używania tej komendy.");
	foreach(Player,x)
		if(IsPlayerConnected(x))
			GivePlayerWeapon(x,27,1000);
            PlaySoundForPlayer(x, 30800);
 	SCM(playerid,C_GREEN,""WI" "G" Administrator dał wszystkim broń Combat Shotgun!");
	return 1;
CMD:tec(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WI" "G" Nie posiadasz uprawnień do używania tej komendy.");
	foreach(Player,x)
		if(IsPlayerConnected(x))
			GivePlayerWeapon(x,32,3000);
            PlaySoundForPlayer(x, 30800);
	SCM(playerid,C_GREEN,""WI" "G" Administrator dał wszystkim broń TEC9!");
	return 1;
CMD:granaty(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_ERROR,""WI" "G" Nie posiadasz uprawnień do używania tej komendy.");
	foreach(Player,x)
		if(IsPlayerConnected(x))
			GivePlayerWeapon(x,16,1000);
            PlaySoundForPlayer(x, 30800);
	SCM(playerid,C_GREEN,""WI" "G" Administrator dał wszystkim Granaty!");
	return 1;
CMD:fps(playerid)
	if(!Player[playerid][FPSMode])
		AttachObjectToPlayer(Player[playerid][CameraFirstPerson], playerid, 0.0, 0.15, 0.65, 0.0, 0.0, 0.0);
		AttachCameraToObject(playerid, Player[playerid][CameraFirstPerson]);
		Player[playerid][FPSMode] = true;
        SCM(playerid, C_GREEN, ""WI" "G"Tryb FPS włączony. Aby go wyłączyć wpisz ponownie /FPS.");
	else
        SetCameraBehindPlayer(playerid);
		Player[playerid][FPSMode] = false;
        SCM(playerid, C_GREEN, ""WI" "G"Tryb FPS wyłączony.");
	return 1;
CMD:wyjdz(playerid)
	if(!Player[playerid][InHouse])
	    SCM(playerid, C_ERROR, ""WE" "R"Nie jesteś w domu.");
	    return 1;
	SCM(playerid, C_GREEN, ""WI" "G"Opuściłeś(aś) dom.");
	if(Player[playerid][ObokHouse])
		PlayerLeaveHouse(playerid, Player[playerid][House]);
	else
        PlayerLeaveHouse(playerid, Player[playerid][HouseOwn]);
	return 1;
CMD:nh(playerid)
	return cmd_newhouse(playerid);
CMD:dh(playerid)
	return cmd_delhouse(playerid);
CMD:newhouse(playerid)
    if(!IsPlayerAdmin(playerid)) return SCM(playerid, C_WHITE, ""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
	if(TotalHouses+1 >= MAX_HOUSES)
        SCM(playerid, C_RED, ""WE" "R"Wykorzystano limit prywatnych domków.");
		return 1;
    SCM(playerid, C_GREEN, ""WI" "G"Rozpoczęto tworzenie domku.");
	SCM(playerid, C_GREEN, ""WI" "G"Idź do miejsca, w którym ma być nowy dom i wpisz /dalej .");
    Player[playerid][HouseStep] = 1;
	return 1;
CMD:delhouse(playerid)
    if(!IsPlayerAdmin(playerid)) return SCM(playerid, C_WHITE, ""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
    new String[255];
    for(new HouseId=0;HouseId<MAX_HOUSES;HouseId++)
		if(IsPlayerInRangeOfPoint(playerid, 1.0, hInfo[HouseId][hOutX], hInfo[HouseId][hOutY], hInfo[HouseId][hOutZ]))
		    SCM(playerid, C_GREEN, ""WI" "G"Domek został usunięty.");
			TotalHouses --;
			format(String,sizeof(String),"DELETE FROM `"PREFIX"Houses` WHERE hID='%d'",HouseId);
			mysql_query(String);
			DestroyDynamicPickup(hInfo[HouseId][hPickup]);
			DestroyDynamicMapIcon(hInfo[HouseId][hIcon]);
			DestroyDynamic3DTextLabel(hInfo[HouseId][hLabel]);
            format(String,sizeof(String),"UPDATE `"PREFIX"Users` SET House='-1',HouseSpawn='0' WHERE Name='%s'",hInfo[HouseId][hOwner]);
			mysql_query(String);
			if(hInfo[HouseId][hOwner] != 0)
	            new userid = GetPlayerIdFromName(hInfo[HouseId][hOwner]);
		        if(Player[userid][InHouse] && IsPlayerConnected(userid))
	                SCM(userid, C_WHITE, ""I" "W"Zostałeś(aś) wyrzucony(a) z domu ponieważ został on usunięty!");
					SPD(userid, D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Informacja","Twój dom został usunięty przez administratora!", "Zamknij", "");
					PlaySoundForPlayer(userid, 1150);
					PlayerLeaveHouse(userid, hInfo[HouseId][hID]);
					Player[userid][HouseOwn] = -1;
                    Player[userid][CheckHouseSpawn] = 0;
			format(hInfo[HouseId][hOwner],24,"-1");
			format(hInfo[HouseId][hName],24,"-1");
			hInfo[HouseId][hWaznosc] = 0;
			hInfo[HouseId][hCzynsz] = 0;
			hInfo[HouseId][hOutX] = EOS;
			hInfo[HouseId][hOutY] = EOS;
			hInfo[HouseId][hOutZ] = EOS;
			hInfo[HouseId][hInX] = EOS;
			hInfo[HouseId][hInY] = EOS;
			hInfo[HouseId][hInZ] = EOS;
			Player[playerid][ObokDelHouse] = false;
	return 1;
CMD:dalej(playerid)
    if(!IsPlayerAdmin(playerid)) return SCM(playerid, C_WHITE, ""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
	if(Player[playerid][HouseStep] == 0)
	    SCM(playerid, C_ERROR, ""WE" "R"Nie rozpoczęto tworzenie domu.");
	    return 1;
	if(Player[playerid][HouseStep] == 1)
        Player[playerid][HouseStep] = 2;
        GetPlayerPos(playerid, Player[playerid][NewHouseOutX],Player[playerid][NewHouseOutY],Player[playerid][NewHouseOutZ]);
        SCM(playerid, C_GREEN, ""WI" "G"Zapisano. Idź do miejsca, w którym ma być wnętrze domu (interior) i wpisz /dalej.");
		return 1;
	if(Player[playerid][HouseStep] == 2)
        Player[playerid][HouseStep] = 3;
        GetPlayerPos(playerid, Player[playerid][NewHouseInX],Player[playerid][NewHouseInY],Player[playerid][NewHouseInZ]);
        GetPlayerFacingAngle(playerid, Player[playerid][NewHouseAngle]);
        Player[playerid][NewHouseInterior] = GetPlayerInterior(playerid);
        SCM(playerid, C_GREEN, ""WI" "G"Zapisano.");
	    SPD(playerid, D_CREATE_HOUSE, DIALOG_STYLE_INPUT, "{00BFFF}Nowy dom", "Podaj nazwę nowego domu:", "Zapisz", "Anuluj");
		return 1;
	return 1;
CMD:newbiznes(playerid)
    if(!IsPlayerAdmin(playerid)) return SCM(playerid, C_WHITE, ""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
	if(TotalBiznes+1 >= MAX_BIZNES)
        SCM(playerid, C_RED, ""WE" "R"Wykorzystano limit biznesów.");
		return 1;
	if(GetPlayerInterior(playerid) != 0)
        SCM(playerid, C_RED, ""WE" "R"Biznesy można tworzyć tylko na dworze.");
		return 1;
    SCM(playerid, C_GREEN, ""WI" "G"Rozpoczęto tworzenie biznesu.");
	SCM(playerid, C_GREEN, ""WI" "G"Idź do miejsca, w którym ma być nowy biznes i wpisz /bNext.");
    Player[playerid][BiznesStep] = 1;
	return 1;
CMD:bnext(playerid)
	if(Player[playerid][BiznesStep] == 1)
		GetPlayerPos(playerid, Player[playerid][BiznesPosX],Player[playerid][BiznesPosY],Player[playerid][BiznesPosZ]);
        Player[playerid][BiznesStep] = 2;
        SPD(playerid, D_BIZNES_NAZWA, DIALOG_STYLE_INPUT, "{00BFFF}Nowy Biznes", "Podaj nazwę nowego biznesu", "Dalej", "Zamknij");
		return 1;
	return 1;
CMD:tpdom(playerid)
	return cmd_idzdom(playerid);
CMD:idzdom(playerid)
    if(Player[playerid][HouseOwn] <= -1)
	    SCM(playerid, C_ERROR, ""WE" "R"Nie posiadasz domku.");
	    return 1;
	PlayerEnterHouse(playerid, Player[playerid][HouseOwn]);
	return 1;
CMD:losowanie(playerid)
    Losowanko(playerid);
	return 1;
CMD:sv(playerid)
	SavePlayer(playerid);
 	SCM(playerid, C_WHITE, ""I" "W"Zapisałeś(aś) swoje statystyki!");
    return 1;
CMD:svall(playerid)
    if(!Player[playerid][Mod] && !Player[playerid][Admin1])
		SCM(playerid, C_ERROR, ""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
		return 1;
	if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	foreach(Player,x)
        SavePlayer(x);
		SCM(x, C_WHITE, ""I" "W"Statystyki wszystkich graczy zostały zapisane przez admina.");
	return 1;
CMD:portfel(playerid)
	SPD(playerid, D_PORTFEL, DIALOG_STYLE_LIST,"{00BFFF}Wirtualny Portfel", "› Zasil swój portfel\n"GUI2"› Informacje","Wybierz","Anuluj");
	return 1;
CMD:report(playerid, cmdtext[])
	return cmd_raport(playerid,cmdtext);
CMD:reports(playerid)
	return cmd_raports(playerid);
CMD:raport(playerid,cmdtext[])
	if(RaportBlock[playerid])
	    SCM(playerid,C_RED,""WE" "R"Możesz wysyłać raport co 1 min.");
		return 1;
	new gracz,powod[32];
	if(sscanf(cmdtext,"is[32]",gracz,powod))
		SCM(playerid, C_WHITE, ""I" "W"/Raport [ID] [Powód]");
		return 1;
	if(gracz < 0 || gracz >= MAX_PLAYERS) return SCM(playerid, C_RED, ""WE" "R"Ten gracz nie jest podłączony!");
	if(!IsPlayerConnected(gracz)) return SCM(playerid, C_RED, ""WE" "R"Ten gracz nie jest podłączony!");
	if(strlen(powod) >= 32)
	    SCM(playerid,C_RED,""WE" "R"Powód nie może mieć więcej niż 32 znaki!");
		return 1;
	new bool:ret;
	for(new x=0;x<10;x++)
		if(RaportID[x] == gracz)
		    SCM(playerid,C_RED,""WE" "R"Ten gracz już został zgłoszony administracji przez innego gracza! Odczekaj trochę.");
			ret = true;
			break;
	if(ret) return 1;
	RaportBlock[playerid] = true;
	SetTimerEx("RaportUnlock",60000,0,"i",playerid);
	SCM(playerid, C_GREEN, ""WI" "G"Raport został wysłany!");
	new tmp[64];
	format(tmp,sizeof(tmp),"%s (%d) przysyła raport! Sprawdź /Reports",Player[playerid][Name],playerid);
	RaportCD ++;
	if(RaportCD >= 10) RaportCD = 0;
	format(Raport[RaportCD],32,"%s",powod);
	RaportID[RaportCD] = gracz;
    foreach(Player,a)
		if(Player[a][Admin1] || Player[a][Mod])
			PlayerPlaySound(a, 1147, 0, 0, 0);
			SCM(a,C_LIGHTRED,tmp);
			GameTextForPlayer(a, "~r~~h~RAPORT!", 2000, 1);
	return 1;
CMD:raports(playerid)
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_ERROR,""WE" "R"Nie posiadasz uprawnień do używania tej komendy!");
	new str[800];
	for(new x=0;x<10;x++)
		new name[25];
		if(RaportID[x] < 0)
			format(str,sizeof(str),"%s\n"GUI"Brak Raportu",str);
		else
			GetPlayerName(RaportID[x],name,sizeof(name));
			format(str,sizeof(str),"%s\n"W"%s(%d) "R">> "W"%s",str,name,RaportID[x],Raport[x]);
	strins(str,"\nWyjdz",strlen(str),sizeof(str));
	SPD(playerid,D_RAPORT,2,"{00BFFF}Lista Raportow",str,"Spec","Usun");
	return 1;
CMD:room(playerid)
	SPD(playerid, D_WYBOR_ROOM, DIALOG_STYLE_LIST, "{00BFFF}Wybierz opcję", "› Czat globalny (Wszystkie wiadomości są widoczne)\n"GUI2"› Wybierz pokój (Wiadomości do graczy w tym samym pokoju)", "Wybierz", "Zamknij");
	return 1;
CMD:czat(playerid)
	return cmd_room(playerid);
CMD:chat(playerid)
	return cmd_room(playerid);
CMD:pos(playerid)
	new Float:pX,Float:pY,Float:pZ;
	GetPlayerPos(playerid, pX,pY,pZ);
	new String[128];
	format(String,sizeof(String),"(POS) - Twoja pozycja na mapie to: %f,%f,%f",pX,pY,pZ);
	SCM(playerid, 0xFFAE6BFF, String);
	return 1;
CMD:me(playerid, cmdtext[])
	new PAction[255];
	if(sscanf(cmdtext, "s[255]", PAction))
	    SCM(playerid, C_WHITE, ""I" "W"/me [czynność]");
	    return 1;
	if(Player[playerid][Mute] > 0)
	    SCM(playerid,C_WHITE,""E" "W"Jesteś uciszony(a)!");
	    return 1;
    if(AntiAdvertisement(PAction))
        GMBan(playerid, "SERWER", "Reklama", Player[playerid][IP]);
		return 1;
	format(PAction, sizeof(PAction), " (me) %s %s", Player[playerid][Name], PAction);
	SCMA(0x9EE01BFF, PAction);
	return 1;
CMD:zlecenie(playerid,cmdtext[])
	return cmd_hitman(playerid,cmdtext);
CMD:hitman(playerid,cmdtext[])
	new gracz,kasa;
	if(sscanf(cmdtext,"id",gracz,kasa))
	    SCM(playerid, C_WHITE, ""I" "W"/hitman [idgracza] [kwota]");
		return 1;
	if(kasa > Player[playerid][Money])
		SCM(playerid, C_WHITE, ""E" "W"Nie masz tyle pieniędzy!");
		return 1;
	if(kasa < 5000)
		SCM(playerid, C_WHITE, ""E" "W"Zbyt niska kwota! (Minimum 5000$)");
		return 1;
	if(!IsPlayerConnected(gracz))
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłaczony!");
		return 1;
	if(!Player[playerid][HitmanBlock])
		Player[playerid][HitmanBlock] = true;
		SetTimerEx("HitmanUnlock", 10000, 0,"i",playerid);
		new pierwszyraz = false;
        if(Player[gracz][bounty] <= 0)
			pierwszyraz = true;
		if(Player[gracz][bounty]+kasa <= 2147483647)
			Player[gracz][bounty]+=kasa;
			GivePlayerMoney(playerid, 0-kasa);
			Player[playerid][Money] -= kasa;
	else{
			Player[gracz][bounty] = 2147483647;
			GivePlayerMoney(playerid, 0-kasa);
			Player[playerid][Name] -= kasa;
		new tmp[255];
        if(pierwszyraz)
			format(tmp, sizeof(tmp), ""WI" {E36600}%s (%d) wyznacza nagrodę za głowę gracza %s (%d) w wysokości: %d$ (/Hitman)", Player[playerid][Name],playerid, Player[gracz][Name], gracz,kasa);
			SCMA(0xE36633FF, tmp);
		else
            format(tmp, sizeof(tmp), ""WI" {E36600}%s (%d) zwiększa stawkę za głowę gracza %s (%d)! Łączna suma: %d$ (/Hitman)", Player[playerid][Name],playerid, Player[gracz][Name], gracz,Player[gracz][bounty]);
			SCMA(0xE36633FF, tmp);
		format(tmp, sizeof(tmp), ""WI" "R"Jesteś poszukiwany za %d$! Twoja śmierć oznacza wzbogacenie twego zabójcy.",kasa);
		SCM(gracz, C_RED, tmp);
        GameTextForAll("~r~~h~] ~w~ZLECENIE ~r~~h~]",5000,3);
	return 1;
CMD:bounty(playerid,cmdtext[])
	new gracz;
	if(sscanf(cmdtext,"d",gracz))
	    SCM(playerid, C_WHITE, ""I" "W"/bounty [idgracza]");
		return 1;
	if(IsPlayerConnected(gracz))
		new tmp[80];
		format(tmp, sizeof(tmp), "(Bounty) %s (id: %d) - nagroda za tego gracza to $%d ", Player[gracz][Name],gracz,Player[gracz][bounty]);
		SCM(playerid, C_YELLOW, tmp);
	else
		SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłączony!");
	return 1;
CMD:bounties(playerid)
	new string[512];
	new cd;
	foreach(Player,x)
	    if(Player[x][bounty] > 0)
	        new name[25];
	        GetPlayerName(x,name,sizeof(name));
	        format(string,sizeof(string),"%s\n%s ($%d)",string,name,Player[x][bounty]);
	        cd ++;
	        if(cd >= 10) break;
	SPD(playerid,D_NONE,0,"{00BFFF}Nagrody za głowę",string,"Zamknij","");
	return 1;
CMD:premium(playerid)
	new TotalPremium;
	foreach(Player,x)
		if(IsPlayerAdmin(x))
			TotalPremium ++;
		else if(Player[x][Admin1])
            TotalPremium ++;
		else if(Player[x][Mod])
            TotalPremium ++;
		else if(Player[x][Vip])
            TotalPremium ++;
	if(TotalPremium == 0)
		SCM(playerid, C_WHITE, ""I" "W"Na serwerze nie ma aktualnie żadnego użytkownika z kontem premium!");
		return 1;
	new tmp[128];
	format(tmp,sizeof(tmp),"Aktualnie %d użytkowników z kontem premium jest OnLine.",TotalPremium);
	SPD(playerid, D_NONE, DIALOG_STYLE_MSGBOX, "{00BFFF}Premium OnLine", tmp, "Zamknij", "");
	return 1;
CMD:exp(playerid)
	SPD(playerid,D_EXP,DIALOG_STYLE_LIST,"{00BFFF}Panel "W"- Exp","› Przelew exp\n"GUI2"› Informacje","Wybierz","Zamknij");
	return 1;
CMD:dompomoc(playerid)
	new String[430];
	format(String,sizeof(String),""W"Co to jest prywatny dom?\n\n"GUI"Prywatny dom to twoje miejsce zamieszkania.\nNa całej mapie jest wiele domków do wyboru.\nDom po kupnie jest zapisywany.\n\n");
	format(String,sizeof(String),"%s "W"Jakie są korzyści z kupna domu?\n\n"GUI"- Po wejściu do domu otrzymujesz zdrowie i pełną kamizelkę.\n- Możliwość spawnowania się w domu po śmierci.\n- Wkrótce: Możliwość kupowania mebli do domu itd.\n\n"W"Czynsz domu opłacamy co tydzień.", String);
	SPD(playerid, D_NONE, DIALOG_STYLE_MSGBOX, "{00BFFF}Prywatny domek "W"- Informacje",String,"Zamknij","");
	return 1;
CMD:level(playerid)
	return cmd_exp(playerid);
CMD:levelhelp(playerid)
	return cmd_exp(playerid);
CMD:exphelp(playerid)
	return cmd_exp(playerid);
CMD:air(playerid)
	if(Player[playerid][AirON])
		Player[playerid][AirON] = false;
        SCM(playerid, C_WHITE, ""I" "W"Podwójny skok wyłączony! Aby go włączyć wpisz ponownie /Air.");
	else
		Player[playerid][AirON] = true;
        SCM(playerid, C_WHITE, ""I" "W"Podwójny skok włączony! Aby go wyłączyć wpisz ponownie /Air.");
	return 1;
CMD:kask(playerid)
	if(Player[playerid][KaskON])
		Player[playerid][KaskON] = false;
        SetPlayerAttachedObject(playerid,SLOT_KASK,0,2,0.05,0.01,0.00,3.0,82.0,87.0,1.00,1.00,1.00);
		SCM(playerid, C_WHITE, ""I" "W"Kask wyłączony! Aby go włączyć wpisz ponownie /Kask.");
	else
		Player[playerid][KaskON] = true;
        if(Player[playerid][OnBike])
            if(IsPlayerAttachedObjectSlotUsed(playerid,SLOT_PRZEDMIOT_GLOWA))
				SCM(playerid,C_WHITE,""I" "W"Kask nie został założony, ponieważ posiadasz przedmioty na głowie.");
				return 1;
			else
	  			SetPlayerAttachedObject(playerid,SLOT_KASK,18645,2,0.05,0.01,0.00,3.0,82.0,87.0,1.00,1.00,1.00);
			Achievement(playerid,"aKask");
		SCM(playerid, C_WHITE, ""I" "W"Kask włączony! Aby go wyłączyć wpisz ponownie /Kask.");
	return 1;
CMD:ramp(playerid)
	if(Player[playerid][WlaczylRampy] >= 1)
		Player[playerid][WlaczylRampy] = 0;
        SCM(playerid, C_WHITE, ""I" "W"Rampy wyłączone! Aby je włączyć wpisz ponownie /Ramp.");
	else
		Player[playerid][WlaczylRampy] = 1;
        SCM(playerid, C_WHITE, ""I" "W"Rampy włączone! Aby je wyłączyć wpisz ponownie /Ramp.");
	return 1;
CMD:tak(playerid)
	if(!AnkietaON)
		SCM(playerid,C_RED,""WE" "R"Aktualnie nie ma głosowania!");
		return 1;
	if(Zaglosowal[playerid])
		SCM(playerid,C_RED,""WE" "R"Już oddałeś(aś) swój głos!");
		return 1;
    if(AnkietaPozostalo <= 0)
        SCM(playerid,C_RED,""WE" "R"Czas oddawania głosów się skończył!");
		return 1;
	Zaglosowal[playerid] = true;
	LiczbaTak ++;
	new string[128];
    format(string, sizeof(string), "%s ~n~~y~%d ~w~I ~g~~h~/TAK ~w~- %d ~r~~h~/NIE ~w~- %d",AnkietaPytanie,AnkietaPozostalo,LiczbaTak,LiczbaNie);
	TextDrawSetString(AnkietaDraw,string);
	return 1;
CMD:nie(playerid)
	if(!AnkietaON)
		SCM(playerid,C_RED,""WE" "R"Aktualnie nie ma głosowania!");
		return 1;
	if(Zaglosowal[playerid])
		SCM(playerid,C_RED,""WE" "R"Już oddałeś(aś) swój głos!");
		return 1;
    if(AnkietaPozostalo <= 0)
        SCM(playerid,C_RED,""WE" "R"Czas oddawania głosów się skończył!");
		return 1;
	Zaglosowal[playerid] = true;
	LiczbaNie ++;
    new string[128];
    format(string, sizeof(string), "%s ~n~~y~%d ~w~I ~g~~h~/TAK ~w~- %d ~r~~h~/NIE ~w~- %d",AnkietaPytanie,AnkietaPozostalo,LiczbaTak,LiczbaNie);
	TextDrawSetString(AnkietaDraw,string);
	return 1;
CMD:stopvote(playerid)
	if(!Player[playerid][Admin1]) return SCM(playerid,C_WHITE,""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
	AnkietaWylacz();
	SCMA(C_RED,""WI" "R"Admin wyłączył głosowanie!");
	return 1;
CMD:startvote(playerid,cmdtext[])
	if(!Player[playerid][Admin1]) return SCM(playerid,C_WHITE,""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
	if(AnkietaON)
		SCM(playerid,C_RED,""WE" "R"Poczekaj aż skończy się aktualne głosowanie!");
		return 1;
	new pytanie[51];
	if(sscanf(cmdtext,"s[51]",pytanie)){
	    SCM(playerid, C_WHITE, ""I" "W"/startAnkieta [Pytanie do Głosowania]");
		return 1;
	if(strlen(pytanie) > 40){
		SCM(playerid,C_WHITE,""I" "W"Max. 40 znaków w pytaniu!");
		return 1;
	AnkietaWylacz();
	AnkietaON = true;
	foreach(Player,x)
		Zaglosowal[x] = false;
		TextDrawShowForPlayer(x,AnkietaDraw);
	LiczbaTak = 0;
	LiczbaNie = 0;
	format(AnkietaPytanie,40,pytanie);
	AnkietaPozostalo = 15;
	new string[100];
    format(string, sizeof(string), "%s ~n~~y~%d ~w~I ~g~~h~/TAK ~w~- %d ~r~~h~/NIE ~w~- %d",pytanie,AnkietaPozostalo,LiczbaTak,LiczbaNie);
	TextDrawSetString(AnkietaDraw,string);
	SetTimer("CountNext",1000,0);
	return 1;
CMD:odlicz(playerid)
	new string[64];
	if(CDText)
		SCM(playerid,C_WHITE,""E" "W"Odczekaj 15 sekund na następne odliczanie.");
		return 1;
    if(CountDowning == 1)
		SCM(playerid, C_WHITE, ""E" "W"Już trwa jedno odliczanie!");
		return 1;
	if(Count1 >= 3)
		format(string, sizeof(string), ""WI" "G"%s (%d) włączył(a) odliczanie!",Player[playerid][Name],playerid);
		SCMA(C_GREEN,string);
		SCM(playerid, 0xFF0000FF, ""WI" "R"Odliczanie rozpoczęte!");
		CDText = true;
		SetTimer("CDTextUnlock",15000,0);
		CountDown();
		return 1;
	else
		SCM(playerid,0xFF0000FF , ""WI" "R"Poczekaj aż skończy się aktualne odliczanie.");
	return 1;
CMD:cd(playerid,cmdtext[])
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_WHITE,""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
	new czas,zamro;
	if(sscanf(cmdtext,"dd",czas,zamro))
	    SCM(playerid, C_WHITE, ""I" "W"/Cd [Czas] [zamrozenie(0/1)]");
		return 1;
	if(czas > 1000 || czas < 0)
		SCM(playerid, C_WHITE, ""E" "W"Czas od 0 do 1000 sek.");
		return 1;
	if(zamro > 1 || zamro < 0)
		SCM(playerid, C_WHITE, ""E" "W"Zamrożenie  1- tak  0- nie");
		return 1;
	if(CountDowning == 1)
		SCM(playerid, C_WHITE, ""E" "W"Już trwa jedno odliczanie!");
		return 1;
	CountDowning = 1;
	if(zamro == 1)
		foreach(Player,x)
            if(GetDistanceBetweenPlayers(playerid,x) <= 50)
				TogglePlayerControllable(x,0);
	Count2 = czas;
	CountDownAS();
	new tmp[80];
	format(tmp, sizeof(tmp), ""WI" "G"%s ustawił(a) odliczanie na %d sekund.", Player[playerid][Name],czas);
	SCMA(C_GREEN, tmp);
	return 1;
CMD:stopcd(playerid)
	if(!Player[playerid][Admin1] && !Player[playerid][Mod]) return SCM(playerid,C_WHITE,""E" "W"Nie posiadasz uprawnień do używania tej komendy!");
	new string2[64];
	format(string2, sizeof(string2), ""WI" "G"%s zakończył(a) odliczanie!", Player[playerid][Name]);
	SCMA(C_GREEN, string2);
	Count2 = -1;
	CountDowning = 0;
	return 1;
ranclass(minnum = cellmin,maxnum = cellmax) return random(maxnum - minnum + 1) + minnum;
public OnPlayerRequestClass(playerid, classid)
	if(Player[playerid][FirstRequest])
        SetPlayerPos(playerid,489.3238,-1792.7379,6.0625);
		SetPlayerFacingAngle(playerid,354.3279);
		SetPlayerCameraPos(playerid,485.9425+ranclass(-1, 1), -1786.0959+ranclass(-1, 1), 8.3840+ranclass(-1, 1));
		SetPlayerCameraLookAt(playerid,489.3238,-1792.7379,6.0625,1);
		Player[playerid][FirstRequest] = false;
		if(Player[playerid][Registered])
			SPD(playerid, D_LOGIN, DIALOG_STYLE_PASSWORD, "{00BFFF}Panel Logowania", ""W"To konto jest zarejestrowane na serwerze.\n\nAby na nim grać podaj hasło do konta:", "Zaloguj", "Anuluj");
	else
		SetPlayerPos(playerid,489.3238,-1792.7379,6.0625);
        SetPlayerFacingAngle(playerid,354.3279);
		SetPlayerCameraPos(playerid,485.9425+ranclass(-1, 1), -1786.0959+ranclass(-1, 1), 8.3840+ranclass(-1, 1));
		SetPlayerCameraLookAt(playerid,489.3238,-1792.7379,6.0625,1);
	PlaySoundForPlayer(playerid, 1132);
    new str[55];
    if(classid < 0 || classid > 0)
        format(str,55,"~n~~n~~n~~n~~n~~n~~n~~w~SKIN: %d",GetPlayerSkin(playerid));
		GameTextForPlayer(playerid,str, 3000, 3);
    else if(classid == 0)
        GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~w~~<~ KOBIETY I MEZCZYZNI ~>~", 3000, 3);
	switch(random(8))
	  	case 0: ApplyAnimation(playerid,"DANCING", "DAN_Down_A", 4.000000, 1, 1, 1, 1, 1); // Taichi
 		case 1: ApplyAnimation(playerid, "DANCING", "DAN_Left_A", 4.000000, 1, 1, 1, 1, 1); // Dilujesz
	  	case 2: ApplyAnimation(playerid, "DANCING", "DAN_Right_A", 4.000000, 1, 1, 1, 1, 1); // Ręce
	  	case 3: ApplyAnimation( playerid,"DANCING", "DAN_Up_A", 4.000000, 1, 1, 1, 1, 1); // Fuck
	  	case 4: ApplyAnimation(playerid, "DANCING", "dnce_M_a", 4.000000, 1, 1, 1, 1, 1); // Lookout
	  	case 5: ApplyAnimation(playerid, "RAPPING", "Laugh_01", 4.0, 1, 0, 0, 0, 0); // Laugh
	  	case 6: ApplyAnimation(playerid, "RAPPING", "RAP_B_Loop", 4.0,1,0,0,0,0); // Rapujesz
	  	case 7: ApplyAnimation(playerid, "DANCING", "DAN_Right_A", 4.000000, 1, 1, 1, 1, 1); //Taniec
	return 1;
public OnPlayerConnect(playerid)
    if(playerid > MAX_PLAYERS)
		return Kick(playerid);
	if(playerid < 0)
		return Kick(playerid);
	if(IsPlayerNPC(playerid)) return Kick(playerid);
	GetPlayerIp(playerid, Player[playerid][IP], 16);
	new compare_IP[16];
	new number_IP = 0;
	foreach(Player,i)
 		GetPlayerIp(i,compare_IP,16);
	 	if(!strcmp(compare_IP,Player[playerid][IP])) number_IP++;
	if((GetTickCount() - Join_Stamp) < Time_Limit)
	    exceed=1;
	else
	    exceed=0;
 	if(strcmp(ban_s, Player[playerid][IP], false) == 0 && exceed == 1 )
 	    Same_IP++;
 	    if(Same_IP > SAME_IP_CONNECT)
	   		Ban(playerid);
 			Same_IP=0;
 	else
 		Same_IP=0;
	if(number_IP > IP_LIMIT)
	    Kick(playerid);
	GetStampIP(playerid);
  
    GetPlayerName(playerid, Player[playerid][Name], MAX_PLAYER_NAME);
    new Query[530],String[530];
    if(CheckBanExists(Player[playerid][Name],Player[playerid][IP]))
        new admin[24],data[16],godzina[16],powod[80];
		format(Query,sizeof(Query),"SELECT `Admin`,`Data`,`Godzina`,`Powod` FROM "PREFIX"Bans WHERE `Nick` = '%s' LIMIT 1",Player[playerid][Name]);
	    mysql_query(Query);
		mysql_store_result();
		mysql_fetch_row(String);
		sscanf(String, "p<|>s[24]s[16]s[16]s[80]",admin,data,godzina,powod);
		mysql_free_result();
		format(String,sizeof(String), "Twój nick: %s\nTwoje IP: %s\nNick Admina: %s\nData: %s\nGodzina: %s\n\nPowód: %s",Player[playerid][Name],Player[playerid][IP],admin,data,godzina,powod);
		SPD(playerid, D_NONE, DIALOG_STYLE_MSGBOX, ""R"Jesteś zbanowany", String, "Zamknij", "");
		format(String,sizeof(String), "*(B) Nick %s (IP: %s) próbuje wejść na serwer ale jest zbanowany za %s.",Player[playerid][Name],Player[playerid][IP],powod);
		SendClientMessageToAdmins(0xFF0000FF,String);
		Kick(playerid);
		return 1;
    if(AntiAdvertisement(Player[playerid][Name]))
        GMBan(playerid, "SERWER", "Reklama", Player[playerid][IP]);
		return 1;
	Player[playerid][WygranychWG] = 0;
	Player[playerid][WygranychWS] = 0;
	Player[playerid][WygranychCH] = 0;
	Player[playerid][WygranychSN] = 0;
	Player[playerid][WygranychUS] = 0;
	Player[playerid][WygranychPB] = 0;
	Player[playerid][MinigunScore] = 0;
	Player[playerid][OnedeScore] = 0;
	Player[playerid][CombatScore] = 0;
	Player[playerid][RPGScore] = 0;
	Player[playerid][Exp] = 0;
	Player[playerid][Money] = 0;
	Player[playerid][Kills] = 0;
	Player[playerid][Deaths] = 0;
	Player[playerid][Suicides] = 0;
	Player[playerid][Row_Kills] = 0;
	Player[playerid][Bans] = 0;
	Player[playerid][Kicks] = 0;
	Player[playerid][Kodow] = 0;
	Player[playerid][Portfel] = 0;
	Player[playerid][Skin] = 0;
	Player[playerid][Bank] = 0;
	Player[playerid][AdminLevel] = 0;
	Player[playerid][WaznoscVip] = -1;
	Player[playerid][WaznoscMod] = -1;
	Player[playerid][WaznoscAdmin] = -1;
    Player[playerid][SuspensionAdmin] = -1;
	Player[playerid][InfoTime] = 0;
	Player[playerid][SuspensionVip] = -1;
    Player[playerid][SuspensionMod] = -1;
	Player[playerid][BadPassword] = 4;
	Player[playerid][Godz] = 0;
	Player[playerid][Min] = 0;
    Player[playerid][Level] = 1;
	Player[playerid][Nrgs] = 0;
    Player[playerid][Jail] = 0;
	KillTimer(JailTimer[playerid]);
    Player[playerid][ClickedPlayer] = -1;
	Player[playerid][TutID] = 0;
	Player[playerid][KillTime] = 0;
	Player[playerid][Freeze] = false;
    Player[playerid][KaskON] = true;
    Player[playerid][WlaczylRampy] = 1;
	Player[playerid][RampCoords] = 1655;
    Player[playerid][SoloScore] = 0;
    Player[playerid][DamageText] = 0;
	Player[playerid][TotalDamage] = 0;
	Player[playerid][FloatDeath] = false;
	Player[playerid][PBGod] = 0;
    ChcePM[playerid] = true;
	Player[playerid][AllTD] = true;
	Player[playerid][OnOnede] = false;
	Player[playerid][OnCombat] = false;
	Player[playerid][OnMinigun] = false;
    Player[playerid][OnRPG] = false;
    Player[playerid][DeathsSecond] = 0;
	Player[playerid][DriftScore] = 0;
	Player[playerid][InHouse] = false;
	Player[playerid][HouseStep] = 0;
    Player[playerid][DBWarnings] = 0;
	Player[playerid][CKWarnings] = 0;
	Player[playerid][HKWarnings] = 0;
	Player[playerid][HouseOwn] = -1;
	Player[playerid][CheckHouseSpawn] = 0;
    Player[playerid][pVeh] = 0;
	Player[playerid][Zapukal] = 0;
    Wiezien[playerid] = false;
    Player[playerid][WeaponPickup] = -1;
	Player[playerid][WeaponPickupTime] = 0;
	KillTimer(Player[playerid][HouseTimer]);
    Player[playerid][Biznes] = 0;
    Player[playerid][MaDochod] = false;
	Player[playerid][BiznesTime] = 0;
    Player[playerid][ObokHouse] = false;
    Player[playerid][NearHouse] = false;
	Player[playerid][ObokDelHouse] = false;
 	Player[playerid][PlaySound] = 0;
    Player[playerid][GunWarning] = 0;
    Player[playerid][Immunitet] = false;
    Player[playerid][Nicked] = 0;
    Zaglosowal[playerid] = false;
    Player[playerid][Zajety] = false;
    Player[playerid][Warns] = 0;
    Player[playerid][HouseAction] = 0;
    Player[playerid][SiedzibaAction] = 0;
	Player[playerid][BiznesAction] = 0;
    Player[playerid][TpVipON] = true;
    Player[playerid][FKWarnings] = 0;
	Player[playerid][TuneWarnings] = 0;
	Player[playerid][PrzelewExpId] = -1;
    Player[playerid][IdzdoON] = true;
    DerbyZaglosowal[playerid] = false;
   	DerbyMen[playerid] = false;
    Player[playerid][Santa] = false;
    Player[playerid][KupilArmour] = 0;
    Player[playerid][KupilZycie] = 0;
    Player[playerid][Skin] = 0;
    Player[playerid][JestSzefem] = false;
    Player[playerid][PrzelalExp] = 0;
    Player[playerid][Naprawil] = 0;
    Player[playerid][VTPUsed] = 0;
    Player[playerid][InGang] = -1;
    Player[playerid][gZapro] = -1;
    Player[playerid][gAkceptEnabled] = false;
    Player[playerid][gAkceptInteriorEnabled] = false;
    Player[playerid][TimePlay] = 0;
    Player[playerid][ClickMapON] = false;
    KillTimer(EndDriftTimer[playerid]);
    KillTimer(Player[playerid][MuteTimer]);
   
    AchievementGet[playerid][aTrofea] = 0;
    AchievementGet[playerid][aRegistered] = 0;
	AchievementGet[playerid][aDoscTego] = 0;
	AchievementGet[playerid][aKask] = 0;
    AchievementGet[playerid][aJestemLepszy] = 0;
    AchievementGet[playerid][aJestemMistrzem] = 0;
    AchievementGet[playerid][aPilot] = 0;
    AchievementGet[playerid][a24Godziny] = 0;
    AchievementGet[playerid][aDoOstatniegoTchu] = 0;
    AchievementGet[playerid][aCelneOko] = 0;
    AchievementGet[playerid][aZwinnePalce] = 0;
    AchievementGet[playerid][aPodroznik] = 0;
    AchievementGet[playerid][aDrifter] = 0;
    AchievementGet[playerid][aKrolDriftu] = 0;
	AchievementGet[playerid][aStreetKing] = 0;
    AchievementGet[playerid][aNowaTozsamosc] = 0;
    AchievementGet[playerid][aDomownik] = 0;
    AchievementGet[playerid][aWlasne4] = 0;
    AchievementGet[playerid][aZzzz] = 0;
	Player[playerid][Room] = 0;
	Player[playerid][AirON] = true;
	Player[playerid][InArena] = false;
	Player[playerid][OnBike] = false;
    Player[playerid][Update] = true;
	Player[playerid][Bombus] = -1;
	Player[playerid][Dotacja][0] = false;
	Player[playerid][Dotacja][1] = false;
    Player[playerid][AFK] = false;
	Player[playerid][AFKChecker] = false;
	Player[playerid][PasekON] = true;
	Player[playerid][LicznikON] = true;
	Player[playerid][ZegarON] = true;
	Player[playerid][ZapisyON] = true;
	Player[playerid][PodpowiedziON] = true;
	Player[playerid][LogoON] = true;
    Player[playerid][SiemaBlock] = false;
	Player[playerid][UsedPomoc] = false;
	Player[playerid][FirstSpawn] = true;
	Player[playerid][FirstRequest] = true;
    Player[playerid][Logged] = false;
	Player[playerid][Registered] = false;
	Player[playerid][Vip] = false;
	Player[playerid][Mod] = false;
    Player[playerid][Admin1] = false;
    Player[playerid][Admin2] = false;
    Player[playerid][SpecOff] = false;
	Player[playerid][SpecVW] = 0;
	Player[playerid][SpecInt] = 0;
	Player[playerid][Bomber] = false;
 	Player[playerid][TPRefused] = 0;
    InAir[playerid] = 0;
	Player[playerid][TotalArm] = 0;
    Pinger[playerid] = 0;
    GSTag[playerid] = false;
    Player[playerid][RespektPremia] = 0;
    Player[playerid][Drift] = 0;
	Player[playerid][DriftCombo] = 0;
	Player[playerid][DriftCount] = 0;
	Player[playerid][DriftEnabled] = false;
    LaserID[playerid] = 0;
    Player[playerid][BiznesStep] = 0;
    Player[playerid][ZmienialTime] = 0;
    Player[playerid][FPSMode] = false;
    Player[playerid][MaDochod] = false;
  
    CreateDynamicMapIcon(2253.2166,2453.9294,10.8203, 30,0,0,0,playerid,250.0);
	CreateDynamicMapIcon(2191.4653,1991.2842,11.7748, 52,0,0,0,playerid,250.0);
	CreateDynamicMapIcon(2454.5457,2064.0178,10.8203, 52,0,0,0,playerid,250.0);
    CreateDynamicMapIcon(2023.6055,1008.2421,10.3642, 43,0,0,0,playerid,250.0);
    CreateDynamicMapIcon(3045.9048,971.1270,708.5760, 52,0,0,0,playerid,250.0);
    CreateDynamicMapIcon(2571.8450,-2941.2422,205.2634, 46,0,0,0,playerid,250.0);
    CreateDynamicMapIcon(-544.5546,-480.4810,25.5178, 51,0,0,0,playerid,250.0);
    CreateDynamicMapIcon(2172.0037,1620.7543,999.9792, 44,0,0,0,playerid,250.0);
    CreateDynamicMapIcon(-1987.7372,288.7828,34.5681, 36,0,0,0,playerid,250.0);
    CreateDynamicMapIcon(2237.2031,-1717.2285,22.8527, 54,0,0,0,playerid,250.0); //Siłownie
    CreateDynamicMapIcon(1958.2408,2299.4490,21.7280, 54,0,0,0,playerid,250.0);
    CreateDynamicMapIcon(-2276.8953,-159.3267,46.2813, 54,0,0,0,playerid,250.0);
    CreateDynamicMapIcon(-2354.0466,-151.5577,40.5791, 10,0,0,0,playerid,250.0); //Burger Shoty
    CreateDynamicMapIcon(-2342.5105,1009.1888,55.9150, 10,0,0,0,playerid,250.0);
    CreateDynamicMapIcon(-1922.8597,819.6209,76.9141, 10,0,0,0,playerid,250.0);
    CreateDynamicMapIcon(799.8196,-1619.7946,19.5388, 10,0,0,0,playerid,250.0);
    CreateDynamicMapIcon(1190.9974,-917.2220,43.2077, 10,0,0,0,playerid,250.0);
	CreateDynamicMapIcon(-319.4577,1049.8263,20.3403, 22,0,0,0,playerid,250.0); //Szpitale
    CreateDynamicMapIcon(1172.4885,-1323.1099,15.4025, 22,0,0,0,playerid,250.0);
    CreateDynamicMapIcon(2034.3552,-1404.5022,17.2577, 22,0,0,0,playerid,250.0);
    CreateDynamicMapIcon(-2639.0107,638.8161,14.4531, 22,0,0,0,playerid,250.0);
    CreateDynamicMapIcon(2177.5488,941.4527,25.0981, 6,0,0,0,playerid,250.0); //AmmuNation
    CreateDynamicMapIcon(1386.5803,-1283.9615,33.4856, 6,0,0,0,playerid,250.0); //AmmuNation
    CreateDynamicMapIcon(2390.3362,-1994.0963,18.5529, 6,0,0,0,playerid,250.0); //AmmuNation
    CreateDynamicMapIcon(1570.6339,-1703.6871,5.7861, 30,0,0,0,playerid,250.0); //Police LS
    CreateDynamicMapIcon(-1633.0677,706.6133,48.9375, 30,0,0,0,playerid,250.0); //Police SF
	CreateDynamicMapIcon(1375.6439,240.7949,28.2266, 29,0,0,0,playerid,250.0); //Pizza
    CreateDynamicMapIcon(-1717.9935,1359.8541,17.2500, 29,0,0,0,playerid,250.0); //Pizza
    CreateDynamicMapIcon(934.0592,-1349.8695,23.0713, 14,0,0,0,playerid,250.0); //Cluckin' Bell
    CreateDynamicMapIcon(2391.5735,-1906.8853,21.4602, 14,0,0,0,playerid,250.0); //Cluckin' Bell
    CreateDynamicMapIcon(1732.3727,-1462.4307,33.0234, 20,0,0,0,playerid,250.0); //Fire Dept Los Santos
    CreateDynamicMapIcon(-2035.0851,68.8523,36.0985, 20,0,0,0,playerid,250.0); //Fire Dept San Fierro
    CreateDynamicMapIcon(2195.7256,1685.8405,12.3672, 25,0,0,0,playerid,250.0); //Calligula's Casino
    CreateDynamicMapIcon(2448.1860,-1973.3778,13.5469, 18,0,0,0,playerid,250.0); //Emmet
    CreateDynamicMapIcon(2313.3035,-1638.8582,18.5078, 49,0,0,0,playerid,250.0); //Drunk
    CreateDynamicMapIcon(-1937.9418,242.8015,41.0469, 27,0,0,0,playerid,250.0); //Mod garage San Fierro
    CreateDynamicMapIcon(2386.0403,1053.0532,18.3189, 27,0,0,0,playerid,250.0); //Mod garage Las Venturas
    CreateDynamicMapIcon(-2730.0979,217.6517,16.7736, 27,0,0,0,playerid,250.0); //Mod garage San Fierro Wheels Angel
    CreateDynamicMapIcon(2643.2285,-2043.7399,21.3213, 27,0,0,0,playerid,250.0); //Mod garage Los Santos LowRider
    CreateDynamicMapIcon(1046.5599,-1018.5216,41.5676, 27,0,0,0,playerid,250.0); //Mod garage Los Santos
    DestroyObject(Player[playerid][CameraFirstPerson]);
	Player[playerid][CameraFirstPerson] = CreateObject(19300, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
    SetPlayerWorldBounds(playerid,20000.0000,-20000.0000,20000.0000,-20000.0000); //Reset world to player
	WGGlos[playerid] = false;
	WyscigUczestnik[playerid] = false;
	WyscigStatus[playerid] = 0;
	Chowany[playerid] = false;
	Szukajacy[playerid] = false;
	WGKandydat[playerid] = false;
    SNKandydat[playerid] = false;
	WGTeam[playerid] = 0;
    PBTeam[playerid] = 0;
	PBGlos[playerid] = false;
	PBKandydat[playerid] = false;
    if(strfind(Player[playerid][Name],SERVER_TAG,true)==0)
		GSTag[playerid] = true;
	Panorama(playerid);
	Player[playerid][TPTo] = INVALID_PLAYER_ID;
    PlayerPlaySound(playerid,1185,0.0,0.0,0.0);
	GlobalJoins ++;
    OnlinePlayers ++;
    if(OnlinePlayers > RekordGraczy)
		RekordGraczy = OnlinePlayers;
		new Strong[128];
		format(Strong,sizeof(Strong), ""WI" {44a428}Nowy rekord graczy online! "W"%d{44a428}.",RekordGraczy);
		SCMA(C_BLUE,Strong);
		SoundForAll(3200);
    SCM(playerid,C_WHITE,"");
	SCM(playerid,C_WHITE,"");
	SCM(playerid,C_WHITE,"{707070}* {FF8800}PL|GoldServer "VERSION" - Profesjonalny polski serwer freeroam/dm!");
    SCM(playerid,C_WHITE,"");
	SCM(playerid,C_BLUE,"{707070}* {FF8800}Skiny kobiece znajdują się po {707070}lewej {FF8800}a skiny męskie po {707070}prawej {FF8800}stronie wybierałki.");
    SCM(playerid,C_WHITE,"");
    SCM(playerid,C_WHITE,"");
	if(AccountExists(Player[playerid][Name]))
		format(Query, 470, "SELECT * FROM `"PREFIX"Users` WHERE `Name`='%s' LIMIT 1", Player[playerid][Name]);
		mysql_query(Query);
		mysql_store_result();
		mysql_fetch_row(String,"|");
		sscanf(String, "p<|>ds[24]s[40]ddddddddddddddddddddddddddddddddd",
		Player[playerid][AID],Player[playerid][Name],
		Player[playerid][Password],Player[playerid][Exp],Player[playerid][Money],Player[playerid][Kills],
		Player[playerid][Deaths],Player[playerid][Suicides],Player[playerid][Row_Kills],Player[playerid][TimePlay],Player[playerid][Warns],Player[playerid][Mute],Player[playerid][Jail],Player[playerid][Bank],Player[playerid][Kodow],Player[playerid][Kicks],Player[playerid][Bans],
		Player[playerid][Portfel],Player[playerid][Skin],Player[playerid][SoloScore],Player[playerid][OnedeScore],Player[playerid][MinigunScore],Player[playerid][RPGScore],Player[playerid][DriftScore],Player[playerid][HouseOwn],Player[playerid][CheckHouseSpawn],Player[playerid][pVeh],
		Player[playerid][Onlined],Player[playerid][WaznoscPriv],Player[playerid][CombatScore],Player[playerid][WygranychWG],Player[playerid][WygranychWS],Player[playerid][WygranychCH],Player[playerid][WygranychPB],Player[playerid][WygranychUS],Player[playerid][WygranychSN]);
		if(VipExists(Player[playerid][Name]))
	        format(Query,150, "SELECT Waznosc,Suspension FROM `"PREFIX"Vips` WHERE `Name`='%s' LIMIT 1", Player[playerid][Name]);
			mysql_query(Query);
			mysql_store_result();
			mysql_fetch_row(String,"|");
			sscanf(String, "p<|>dd",Player[playerid][WaznoscVip],Player[playerid][SuspensionVip]);
        mysql_free_result();
        Player[playerid][Level] = GetPlayerLevel(playerid);
		Player[playerid][Registered] = true;
		if(Player[playerid][Mute] > 0)
        	Player[playerid][MuteTimer] = SetTimerEx("UnmutePlayer",Player[playerid][Mute],0,"i",playerid);
	else
        GameTextForPlayer(playerid,"~w~Exp + ~b~~h~1", 1000, 1);
		Player[playerid][Exp] ++;
        Player[playerid][Jail] = 0;
	if(Player[playerid][WaznoscVip] > 0 && Player[playerid][SuspensionVip] <= 0)
		SoundForAll(1150);
		new Strong[185];
		format(Strong,sizeof(Strong), "*({FFFF00}VIP{C0C0C0}) %s (%d) dołączył do serwera.",Player[playerid][Name],playerid);
		SendClientMessageToPlayers(0xC0C0C0FF,Strong);
        format(Strong,sizeof(Strong), "*({FFFF00}VIP{C0C0C0}) %s (%d) dołączył do serwera. IP: %s",Player[playerid][Name],playerid,Player[playerid][IP]);
		SendClientMessageToAdmins(0xC0C0C0FF,Strong);
	else
        //SoundForAll(1056);
		new Strong[180];
        format(Strong,sizeof(Strong), " *** {858585}%s (%d) {C0C0C0}dołączył do serwera.",Player[playerid][Name],playerid);
		SendClientMessageToPlayers(0xC0C0C0FF,Strong);
		format(Strong,sizeof(Strong), " *** {858585}%s (%d) {C0C0C0}dołączył do serwera. {858585}IP: %s",Player[playerid][Name],playerid,Player[playerid][IP]);
		SendClientMessageToAdmins(0xC0C0C0FF,Strong);
//----- Funkcje uzupełniające
    if(Player[playerid][Skin] != 0)
        SCM(playerid,0xFAE098FF," ");
		format(String,sizeof(String),""WI" {FAE098}Twój zapisany skin to: {FFD359}%d{FAE098}. Aby go wczytać wpisz {FFD359}/MS{FAE098}.",Player[playerid][Skin]);
		SCM(playerid,0xFAE098FF,String);
    Player[playerid][KolejkaSpawn] = random(sizeof(gRandomPlayerSpawns));
	Player[playerid][Color] = SelectPlayerColor(random(100));
    SetPlayerColor(playerid, Player[playerid][Color]);
	format(Player[playerid][ChatColor],15,HexToString(Player[playerid][Color]));
    SendDeathMessage(255,playerid,200);
	Attach3DTextLabelToPlayer(lExp[playerid], playerid, 0.0, 0.0, 0.4);
    Attach3DTextLabelToPlayer(lDmg[playerid], playerid, 0.0, 0.0, 0.6);
	UpdatePlayerScore(playerid);
	if(caged[playerid] == 1)
		UnCagePlayer(playerid);
	//--------------------------------------------------------------------------------
	 //LV
 	RemoveBuildingForPlayer(playerid, 8498, 2231.8047, 1035.7188, 46.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 8705, 2231.8047, 1035.7188, 46.8203, 0.25);
    RemoveBuildingForPlayer(playerid, 8889, 2137.8672, 1038.9141, 10.3594, 0.25);
    RemoveBuildingForPlayer(playerid, 9169, 2117.1250, 923.4453, 12.9219, 0.25);
    RemoveBuildingForPlayer(playerid, 9192, 2136.1641, 944.1328, 15.0547, 0.25);
    RemoveBuildingForPlayer(playerid, 3465, 2120.8203, 925.5078, 11.2578, 0.25);
    RemoveBuildingForPlayer(playerid, 3465, 2114.9063, 925.5078, 11.2578, 0.25);
    RemoveBuildingForPlayer(playerid, 3465, 2109.0469, 925.5078, 11.2578, 0.25);
    RemoveBuildingForPlayer(playerid, 3465, 2120.8203, 914.7188, 11.2578, 0.25);
    RemoveBuildingForPlayer(playerid, 3465, 2114.9063, 914.7188, 11.2578, 0.25);
    RemoveBuildingForPlayer(playerid, 3465, 2109.0469, 914.7188, 11.2578, 0.25);
    RemoveBuildingForPlayer(playerid, 1267, 2100.2656, 902.8516, 25.7656, 0.25);
    RemoveBuildingForPlayer(playerid, 1261, 2100.2656, 902.8516, 25.7656, 0.25);
    RemoveBuildingForPlayer(playerid, 9184, 2097.4609, 900.7734, 31.7578, 0.25);
    RemoveBuildingForPlayer(playerid, 9170, 2117.1250, 923.4453, 12.9219, 0.25);
    RemoveBuildingForPlayer(playerid, 762, 2446.5547, -1681.0703, 12.3828, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, 2468.3516, -1680.9844, 13.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3593, 2457.8672, -1679.6719, 12.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, 2465.6953, -1676.4453, 13.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, 2463.8672, -1671.5156, 13.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 2447.3438, -1686.9531, 12.4297, 0.25);
	RemoveBuildingForPlayer(playerid, 8229, 1142.0313, 1362.5000, 12.4844, 0.25); //Szkoła jazdy LV brama
	//Miejsce do ustawki na /SF obok CPN
    RemoveBuildingForPlayer(playerid, 1411, -1817.7734, 94.5938, 15.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -1817.6172, 99.8594, 15.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -1817.4609, 105.1172, 15.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -1817.3047, 110.3828, 15.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -1817.3828, 115.6563, 15.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -1817.6641, 120.9141, 15.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -1818.2500, 131.4297, 15.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -1817.9531, 126.1797, 15.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -1818.5156, 136.6797, 15.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -1818.7500, 141.9375, 15.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -1818.9766, 147.1953, 15.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -1819.2031, 152.4609, 15.7031, 0.25);
	//Warsztat2
	RemoveBuildingForPlayer(playerid, 5945, 988.2734, -1289.6328, 15.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 6003, 954.6875, -1305.7734, 30.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 1266, 952.6406, -1293.7578, 19.2500, 0.25);
	RemoveBuildingForPlayer(playerid, 1266, 996.7109, -1295.4766, 20.2500, 0.25);
	RemoveBuildingForPlayer(playerid, 1261, 953.4922, -1232.5703, 24.1328, 0.25);
	RemoveBuildingForPlayer(playerid, 1261, 1038.5547, -1300.3984, 24.1328, 0.25);
	RemoveBuildingForPlayer(playerid, 5818, 954.6875, -1305.7734, 30.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 1267, 1038.5547, -1300.3984, 24.1328, 0.25);
	RemoveBuildingForPlayer(playerid, 1260, 996.7109, -1295.4766, 20.2500, 0.25);
	RemoveBuildingForPlayer(playerid, 1260, 952.6406, -1293.7578, 19.2500, 0.25);
	RemoveBuildingForPlayer(playerid, 5784, 988.2734, -1289.6328, 15.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 5820, 1010.8828, -1270.2656, 18.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1267, 953.4922, -1232.5703, 24.1328, 0.25);
//--------------------------------------------------------------------------------
    RemovePlayerAttachedObject(playerid, SLOT_FRYZURA);
	RemovePlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA);
	RemovePlayerAttachedObject(playerid, SLOT_PRZEDMIOT_INNE);
	RemovePlayerAttachedObject(playerid, SLOT_PRZEDMIOT_RECE);
	return 1;
SavePlayer(playerid)
    if(Player[playerid][Logged] && Player[playerid][Registered])
		new String[700];
		format(String,sizeof(String), "UPDATE "PREFIX"Users SET Exp='%d',Money='%i',Kills='%d',Deaths='%d',Suicides='%d',Row_Kills='%d',TimePlay='%d',Warns='%d',Mute='%d',Jail='%d',Bank='%d',Kodow='%d',Kicks='%d',Bans='%d',Skin='%d',SoloScore='%d',OnedeScore='%d',MinigunScore='%d',RPGScore='%d',DriftScore='%d',HouseSpawn='%d',CombatScore='%d',WygranychWG='%d',WygranychWS='%d',WygranychCH='%d',WygranychPB='%d',WygranychUS='%d',WygranychSN='%d' WHERE Name='%s'",
		Player[playerid][Exp],Player[playerid][Money],Player[playerid][Kills],Player[playerid][Deaths],Player[playerid][Suicides],Player[playerid][Row_Kills],
		Player[playerid][TimePlay],Player[playerid][Warns],Player[playerid][Mute],Player[playerid][Jail],Player[playerid][Bank],Player[playerid][Kodow],Player[playerid][Kicks],Player[playerid][Bans],GetPlayerSkin(playerid),Player[playerid][SoloScore],Player[playerid][OnedeScore],Player[playerid][MinigunScore],Player[playerid][RPGScore],Player[playerid][DriftScore],Player[playerid][CheckHouseSpawn],Player[playerid][CombatScore],
		Player[playerid][WygranychWG],Player[playerid][WygranychWS],Player[playerid][WygranychCH],Player[playerid][WygranychPB],Player[playerid][WygranychUS],Player[playerid][WygranychSN],Player[playerid][Name]);
		mysql_query(String);
public OnPlayerDisconnect(playerid, reason)
    if(Player[playerid][pVeh] > 0)
		SetVehicleVirtualWorld(vInfo[Player[playerid][pVeh]][vID],17);
	SavePlayer(playerid);
	if(caged[playerid] == 1)
		UnCagePlayer(playerid);
	new string[180];
	OnlinePlayers --;
    DestroyObject(Player[playerid][DeathObject]);
    DestroyObject(Player[playerid][CameraFirstPerson]);
	SendDeathMessage(255,playerid,201);
    Player[playerid][gSpectateID] = -1;
    switch(reason)
		case 0:
			format(string, sizeof(string), " *** {858585}%s (%d) {C0C0C0}opuścił serwer (%d h %d min) (Crash).", Player[playerid][Name],playerid,Player[playerid][Godz],Player[playerid][Min]);
			SendClientMessageToPlayers(0xC0C0C0FF, string);
            format(string, sizeof(string), " *** {858585}%s (%d) {C0C0C0}opuścił serwer (%d h %d min) (Crash) (%s)", Player[playerid][Name],playerid,Player[playerid][Godz],Player[playerid][Min],Player[playerid][IP]);
			SendClientMessageToAdmins(0xC0C0C0FF, string);
		case 1:
			format(string, sizeof(string), " *** {858585}%s (%d) {C0C0C0}opuścił serwer (%d h %d min) (Wyszedł)", Player[playerid][Name],playerid,Player[playerid][Godz],Player[playerid][Min]);
			SendClientMessageToPlayers(0xC0C0C0FF, string);
            format(string, sizeof(string), " *** {858585}%s (%d) {C0C0C0}opuścił serwer (%d h %d min) (Wyszedł) (%s)", Player[playerid][Name],playerid,Player[playerid][Godz],Player[playerid][Min],Player[playerid][IP]);
			SendClientMessageToAdmins(0xC0C0C0FF, string);
    if(Player[playerid][StworzylRampy])
		DestroyPlayerObject(playerid, Player[playerid][Ramp]);
		Player[playerid][StworzylRampy] = false;
	Player[playerid][WlaczylRampy] = 0;
	Player[playerid][RampCoords] = 0;
    if(RywalSolo[0] == playerid)
		foreach(Player,x)
			if(IsPlayerInArea(x, -1486.0240,-1343.8665,335.8203,446.1019))
				new string2[80];
				format(string2,sizeof(string2),"(Solo) Wyzwanie wygrywa %s! (Przeciwnik wyszedł z serwera)",Player[RywalSolo[1]][Name]);
				SCM(x, C_YELLOW, string2);
        Achievement(RywalSolo[1], "aJestemLepszy");
        new Float:hp,Float:arm;
		GetPlayerHealth(RywalSolo[1], hp);
  		GetPlayerArmour(RywalSolo[1], arm);
		if(hp == 100.0 && arm == 100.0)
			Achievement(RywalSolo[1], "aJestemMistrzem");
		SoloEnd(playerid);
	else if(RywalSolo[1] == playerid)
		foreach(Player,x)
			if(IsPlayerInArea(x, -1486.0240,-1343.8665,335.8203,446.1019))
			    new string2[80];
				format(string2,sizeof(string2),"(Solo) Wyzwanie wygrywa %s! (Przeciwnik wyszedł z serwera)",Player[RywalSolo[0]][Name]);
				SCM(x, C_YELLOW, string2);
        Achievement(RywalSolo[0], "aJestemLepszy");
        new Float:hp,Float:arm;
		GetPlayerHealth(RywalSolo[0], hp);
  		GetPlayerArmour(RywalSolo[0], arm);
		if(hp == 100.0 && arm == 100.0)
			Achievement(RywalSolo[0], "aJestemMistrzem");
		SoloEnd(playerid);
    Chowany[playerid] = false;
	ChowanyZapisany[playerid] = false;
	Szukajacy[playerid] = false;
	WGTeam[playerid] = 0;
	WGKandydat[playerid] = false;
    SNKandydat[playerid] = false;
	WGGlos[playerid] = false;
	WyscigUczestnik[playerid] = false;
	WyscigStatus[playerid] = 0;
	Szukajacy[playerid] = false;
	WGTeam[playerid] = 0;
    Player[playerid][WygranychWG] = 0;
	Player[playerid][WygranychWS] = 0;
	Player[playerid][WygranychCH] = 0;
	Player[playerid][WygranychSN] = 0;
	Player[playerid][WygranychUS] = 0;
	Player[playerid][WygranychPB] = 0;
	Player[playerid][MinigunScore] = 0;
	Player[playerid][OnedeScore] = 0;
	Player[playerid][CombatScore] = 0;
	Player[playerid][RPGScore] = 0;
	Player[playerid][Exp] = 0;
	Player[playerid][Money] = 0;
	Player[playerid][Kills] = 0;
	Player[playerid][Deaths] = 0;
	Player[playerid][Suicides] = 0;
	Player[playerid][Row_Kills] = 0;
	Player[playerid][Bans] = 0;
	Player[playerid][Kicks] = 0;
	Player[playerid][Kodow] = 0;
	Player[playerid][Portfel] = 0;
	Player[playerid][Skin] = 0;
	Player[playerid][Bank] = 0;
	Player[playerid][AdminLevel] = 0;
	Player[playerid][WaznoscVip] = -1;
	Player[playerid][WaznoscMod] = -1;
	Player[playerid][WaznoscAdmin] = -1;
    Player[playerid][SuspensionAdmin] = -1;
	Player[playerid][InfoTime] = 0;
	Player[playerid][SuspensionVip] = -1;
    Player[playerid][SuspensionMod] = -1;
	Player[playerid][BadPassword] = 4;
	Player[playerid][Godz] = 0;
	Player[playerid][Min] = 0;
    Player[playerid][Level] = 1;
	Player[playerid][Nrgs] = 0;
    Player[playerid][Jail] = 0;
	KillTimer(JailTimer[playerid]);
    Player[playerid][ClickedPlayer] = -1;
	Player[playerid][TutID] = 0;
	Player[playerid][KillTime] = 0;
	Player[playerid][Freeze] = false;
    Player[playerid][KaskON] = true;
    Player[playerid][WlaczylRampy] = 1;
	Player[playerid][RampCoords] = 1655;
    Player[playerid][SoloScore] = 0;
    Player[playerid][DamageText] = 0;
	Player[playerid][TotalDamage] = 0;
	Player[playerid][FloatDeath] = false;
	Player[playerid][PBGod] = 0;
    ChcePM[playerid] = true;
	Player[playerid][AllTD] = true;
	Player[playerid][OnOnede] = false;
	Player[playerid][OnCombat] = false;
	Player[playerid][OnMinigun] = false;
    Player[playerid][OnRPG] = false;
    Player[playerid][DeathsSecond] = 0;
	Player[playerid][DriftScore] = 0;
	Player[playerid][InHouse] = false;
	Player[playerid][HouseStep] = 0;
    Player[playerid][DBWarnings] = 0;
	Player[playerid][CKWarnings] = 0;
	Player[playerid][HKWarnings] = 0;
	Player[playerid][HouseOwn] = -1;
	Player[playerid][CheckHouseSpawn] = 0;
    Player[playerid][pVeh] = 0;
	Player[playerid][Zapukal] = 0;
    Wiezien[playerid] = false;
    Player[playerid][WeaponPickup] = -1;
	Player[playerid][WeaponPickupTime] = 0;
	KillTimer(Player[playerid][HouseTimer]);
    Player[playerid][Biznes] = 0;
    Player[playerid][MaDochod] = false;
	Player[playerid][BiznesTime] = 0;
    Player[playerid][ObokHouse] = false;
    Player[playerid][NearHouse] = false;
	Player[playerid][ObokDelHouse] = false;
 	Player[playerid][PlaySound] = 0;
    Player[playerid][GunWarning] = 0;
    Player[playerid][Immunitet] = false;
    Player[playerid][Nicked] = 0;
    Zaglosowal[playerid] = false;
    Player[playerid][Zajety] = false;
    Player[playerid][Warns] = 0;
    Player[playerid][HouseAction] = 0;
    Player[playerid][SiedzibaAction] = 0;
	Player[playerid][BiznesAction] = 0;
    Player[playerid][TpVipON] = true;
    Player[playerid][FKWarnings] = 0;
	Player[playerid][TuneWarnings] = 0;
	Player[playerid][PrzelewExpId] = -1;
    Player[playerid][IdzdoON] = true;
    DerbyZaglosowal[playerid] = false;
   	DerbyMen[playerid] = false;
    Player[playerid][Santa] = false;
    Player[playerid][KupilArmour] = 0;
    Player[playerid][KupilZycie] = 0;
    Player[playerid][Skin] = 0;
    Player[playerid][JestSzefem] = false;
    Player[playerid][PrzelalExp] = 0;
    Player[playerid][Naprawil] = 0;
    Player[playerid][VTPUsed] = 0;
    Player[playerid][InGang] = -1;
    Player[playerid][gZapro] = -1;
    Player[playerid][gAkceptEnabled] = false;
    Player[playerid][gAkceptInteriorEnabled] = false;
    Player[playerid][TimePlay] = 0;
    Player[playerid][ClickMapON] = false;
    KillTimer(EndDriftTimer[playerid]);
    KillTimer(Player[playerid][MuteTimer]);
    AchievementGet[playerid][aTrofea] = 0;
    AchievementGet[playerid][aRegistered] = 0;
	AchievementGet[playerid][aDoscTego] = 0;
	AchievementGet[playerid][aKask] = 0;
    AchievementGet[playerid][aJestemLepszy] = 0;
    AchievementGet[playerid][aJestemMistrzem] = 0;
    AchievementGet[playerid][aPilot] = 0;
    AchievementGet[playerid][a24Godziny] = 0;
    AchievementGet[playerid][aDoOstatniegoTchu] = 0;
    AchievementGet[playerid][aCelneOko] = 0;
    AchievementGet[playerid][aZwinnePalce] = 0;
    AchievementGet[playerid][aPodroznik] = 0;
    AchievementGet[playerid][aDrifter] = 0;
    AchievementGet[playerid][aKrolDriftu] = 0;
	AchievementGet[playerid][aStreetKing] = 0;
    AchievementGet[playerid][aNowaTozsamosc] = 0;
    AchievementGet[playerid][aDomownik] = 0;
    AchievementGet[playerid][aWlasne4] = 0;
    AchievementGet[playerid][aZzzz] = 0;
	Player[playerid][Room] = 0;
	Player[playerid][AirON] = true;
	Player[playerid][InArena] = false;
	Player[playerid][OnBike] = false;
    Player[playerid][Update] = true;
	Player[playerid][Bombus] = -1;
	Player[playerid][Dotacja][0] = false;
	Player[playerid][Dotacja][1] = false;
    Player[playerid][AFK] = false;
	Player[playerid][AFKChecker] = false;
	Player[playerid][PasekON] = true;
	Player[playerid][LicznikON] = true;
	Player[playerid][ZegarON] = true;
	Player[playerid][ZapisyON] = true;
	Player[playerid][PodpowiedziON] = true;
	Player[playerid][LogoON] = true;
    Player[playerid][SiemaBlock] = false;
	Player[playerid][UsedPomoc] = false;
	Player[playerid][FirstSpawn] = true;
	Player[playerid][FirstRequest] = true;
    Player[playerid][Logged] = false;
	Player[playerid][Registered] = false;
	Player[playerid][Vip] = false;
	Player[playerid][Mod] = false;
    Player[playerid][Admin1] = false;
    Player[playerid][Admin2] = false;
    Player[playerid][SpecOff] = false;
	Player[playerid][SpecVW] = 0;
	Player[playerid][SpecInt] = 0;
	Player[playerid][Bomber] = false;
 	Player[playerid][TPRefused] = 0;
    InAir[playerid] = 0;
	Player[playerid][TotalArm] = 0;
    Pinger[playerid] = 0;
    GSTag[playerid] = false;
    Player[playerid][RespektPremia] = 0;
    Player[playerid][Drift] = 0;
	Player[playerid][DriftCombo] = 0;
	Player[playerid][DriftCount] = 0;
	Player[playerid][DriftEnabled] = false;
    LaserID[playerid] = 0;
    Player[playerid][BiznesStep] = 0;
    Player[playerid][ZmienialTime] = 0;
    Player[playerid][FPSMode] = false;
	return 1;
public OnPlayerSpawn(playerid)
    Player[playerid][FloatDeath] = false;
    DestroyObject(Player[playerid][DeathObject]);
    if(PBTeam[playerid] == 1)
		new randx = random(10);
		new randy = random(10);
		SetPlayerPos(playerid,PBTeam1SpawnX-5+randx,PBTeam1SpawnY-5+randy,PBTeam1SpawnZ);
	    ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid,23,1000);
        PlaySoundForPlayer(playerid, 30800);
		SetPlayerArmour(playerid,0);
		SetPlayerHealth(playerid, 9999999);
		Player[playerid][PBGod] = 3;
        SetPlayerSkin(playerid, 287);
		return 1;
    if(PBTeam[playerid] == 2)
		new randx = random(10);
		new randy = random(10);
		SetPlayerPos(playerid,PBTeam2SpawnX-5+randx,PBTeam2SpawnY-5+randy,PBTeam2SpawnZ);
        ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid,23,1000);
        PlaySoundForPlayer(playerid, 30800);
		SetPlayerArmour(playerid,0);
        SetPlayerHealth(playerid, 9999999);
		Player[playerid][PBGod] = 3;
        SetPlayerSkin(playerid, 287);
      
		return 1;
	if(Player[playerid][OnMinigun])
        new Arenarand = random(sizeof(MinigunSpawn));
		SetPlayerPos(playerid,MinigunSpawn[Arenarand][0], MinigunSpawn[Arenarand][1], MinigunSpawn[Arenarand][2]);
	    SetPlayerVirtualWorld(playerid, 10);
        ResetPlayerWeapons(playerid);
        PlaySoundForPlayer(playerid, 30800);
		GivePlayerWeapon(playerid,38,1000);
		return 1;
    if(Player[playerid][OnRPG])
        new Arenarand = random(sizeof(RPGSpawn));
		SetPlayerPos(playerid,RPGSpawn[Arenarand][0], RPGSpawn[Arenarand][1], RPGSpawn[Arenarand][2]);
	    SetPlayerVirtualWorld(playerid, 10);
        ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid,35,1000);
        PlaySoundForPlayer(playerid, 30800);
		return 1;
    if(Player[playerid][OnOnede])
        SetPlayerInterior(playerid, 3);
        SetPlayerVirtualWorld(playerid, 10);
		new Arenarand = random(sizeof(OnedeSpawn));
		SetPlayerPos(playerid,OnedeSpawn[Arenarand][0], OnedeSpawn[Arenarand][1], OnedeSpawn[Arenarand][2]);
        ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid,24,1000);
		SetPlayerHealth(playerid, 10.0);
        PlaySoundForPlayer(playerid, 30800);
		return 1;
    if(Player[playerid][OnCombat])
        SetPlayerVirtualWorld(playerid, 10);
		new Arenarand = random(sizeof(CombatSpawn));
		SetPlayerPos(playerid,CombatSpawn[Arenarand][0], CombatSpawn[Arenarand][1], CombatSpawn[Arenarand][2]);
        ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid,27,1000);
		SetPlayerHealth(playerid, 100.0);
        PlaySoundForPlayer(playerid, 30800);
		return 1;
    if(Player[playerid][Jail] > 0 && Player[playerid][FirstSpawn])
		JailPlayer(playerid,"Odczekaj karę",Player[playerid][Jail]);
	else
		SetPlayerRandomSpawn(playerid);
		GivePlayerMoney(playerid, 25000);
        Player[playerid][Money] += 25000;
	if(Player[playerid][FirstSpawn])
        Player[playerid][FirstSpawn] = false;
		UnPanorama(playerid);
		if(!Player[playerid][Registered])
	        SCM(playerid, C_RED,""I" "W"To konto nie jest zarejestrowane. Aby się zarejestrować wpisz {FFA200}/Register"W".");
	        SCM(playerid,C_WHITE,"");
	if(Player[playerid][SpecOff])
		SetPlayerVirtualWorld(playerid,Player[playerid][SpecVW]);
		SetPlayerInterior(playerid,Player[playerid][SpecInt]);
		SetPlayerPos(playerid,Player[playerid][SpecPosX],Player[playerid][SpecPosY],Player[playerid][SpecPosZ]);
		Player[playerid][SpecVW] = 0;
		Player[playerid][SpecInt] = 0;
		Player[playerid][SpecOff] = false;
		return 1;
	Player[playerid][SpecOff] = false;
    SetPlayerHealth(playerid,9999999);
    Player[playerid][AntySpawnKill] = 4;
	return 1;
public OnPlayerShootPlayer(Shooter,Target,Float:HealthLost,Float:ArmourLost)
    if(!IsPlayerConnected(Shooter) || !IsPlayerConnected(Target)) return 0;
	if(IsPlayerNPC(Shooter) || IsPlayerNPC(Target)) return 1;
	new Float:hp,Float:arm;
	GetPlayerHealth(Target, hp);
	GetPlayerArmour(Target, arm);
    new String[10];
	if(arm <= 0)
		if(IsPlayerInBezDmZone(Shooter) && HealthLost > 5)
            JailPlayer(Shooter,"zamieszki w strefie bez-dm",3);
		Player[Target][TotalDamage] += HealthLost;
        format(String,sizeof(String),"- %.0f hp",Player[Target][TotalDamage]);
		Update3DTextLabelText(lDmg[Target],0x00ff00FF,String);
	else
        if(IsPlayerInBezDmZone(Shooter) && ArmourLost > 5)
            JailPlayer(Shooter,"zamieszki w strefie bez-dm",3);
		Player[Target][TotalArm] += ArmourLost;
        format(String,sizeof(String),"- %.0f ap",Player[Target][TotalArm]);
		Update3DTextLabelText(lDmg[Target],0xFFFFFFFF,String);
	Player[Target][DamageText] = 4;
	return 1;
public OnVehicleMod(playerid,vehicleid,componentid)
    Player[playerid][TuneWarnings] ++;
    if(Player[playerid][TuneWarnings] > 4)
        GMBan(playerid, "SERWER", "Tune Hack", Player[playerid][IP]);
	return 1;
public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
	if(Player[playerid][Admin1] || Player[playerid][Mod] && Player[playerid][ClickMapON])
		SetPlayerPosFindZ(playerid, fX, fY, fZ);
        SCM(playerid, C_WHITE, ""I" "W"Przeniosłeś się kliknięciem na mapce. Aby to wyłączyć wpisz /ClickMap.");
	return 1;
public OnPlayerDeath(playerid, killerid, reason)
    Player[playerid][FKWarnings] ++;
    if(Player[playerid][FKWarnings] > 4)
        GMBan(playerid, "SERWER", "Fake Kill", Player[playerid][IP]);
	Player[playerid][Deaths] ++;
	GlobalDeaths ++;
	Player[playerid][FloatDeath] = true;
    Player[playerid][InHouse] = false;
	ResetPlayerMoney(playerid);
    new Float:X2,Float:Y2,Float:Z2;
    GetPlayerPos(playerid, X2,Y2,Z2);
    Player[playerid][DeathObject] = CreateObject(18668, X2,Y2,Z2-2, 0.0, 0.0, 96.0); //Krew po śmierci
	if(Player[playerid][Deaths] > 5)
		Achievement(playerid, "aDoscTego");
    if(killerid == INVALID_PLAYER_ID)
		SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
		Player[playerid][Suicides] ++;
		if(Player[playerid][Admin1] || Player[playerid][Vip] || Player[playerid][Mod])
            SCM(playerid, C_RED, ""WI" "R"Nie straciłeś(aś) exp ponieważ posiadasz konto premium.");
		else
            SCM(playerid, C_RED, ""WI" "R"Straciłeś(aś) 3 pkt exp za popełnienie samobójstwa.");
			Player[playerid][Exp] -= 3;
            GameTextForPlayer(playerid,"~w~Exp - ~b~~h~3", 1000, 1);
	else
		SendDeathMessage(killerid,playerid,reason);
		Player[killerid][Kills] ++;
		GlobalKills ++;
		GivePlayerMoney(killerid,5000);
	    Player[killerid][Money] += 5000;
	    if(IsPlayerAdmin(playerid))
			Achievement(killerid, "aTrofea");
	    if(GetPlayerWeapon(killerid) == 31)
            Achievement(killerid, "aWyborowy");
		if(GetPlayerWeapon(killerid) == 4)
            Achievement(killerid, "aKomandos");
	    if(Player[killerid][OnOnede])
			Achievement(killerid, "aCelneOko");
			Player[killerid][OnedeScore] ++;
			PlaySoundForPlayer(killerid, 17802);
		if(Player[killerid][OnCombat])
			Player[killerid][CombatScore] ++;
			PlaySoundForPlayer(killerid, 17802);
	    if(Player[killerid][OnMinigun])
			Player[killerid][MinigunScore] ++;
            PlaySoundForPlayer(killerid, 17802);
	    if(Player[killerid][OnRPG])
			Player[killerid][RPGScore] ++;
            PlaySoundForPlayer(killerid, 17802);
	    new Float:zycie,Float:ap;
		GetPlayerHealth(killerid,zycie);
	    GetPlayerArmour(killerid,ap);
		new String[155];
		format(String,sizeof(String), ""WI" {FF0000}Zostałeś(aś) zabity przez gracza %s ("W"%.0f HP, %.0f AP{FF0000}).",Player[killerid][Name],zycie,ap);
		SCM(playerid,0xFF0000FF, String);
		if(zycie <= 2.0)
			Achievement(killerid, "aDoOstatniegoTchu");
        if(Player[playerid][Admin1] || Player[playerid][Vip] || Player[playerid][Mod])
			Player[killerid][Exp] += 2;
   			if(Player[killerid][Level] < GetPlayerLevel(killerid))
				LevelUp(killerid);
			GameTextForPlayer(killerid,"~w~Exp + ~b~~h~2", 1000, 1);
		else
            new weaponx = GetPlayerWeapon(playerid);
			if(weaponx == GunDay)
                Player[killerid][Exp] += 2;
	            if(Player[killerid][Level] < GetPlayerLevel(killerid))
					LevelUp(killerid);
				GameTextForPlayer(killerid,"~w~Exp + ~b~~h~2", 1000, 1);
			else
				Player[killerid][Exp] ++;
	            if(Player[killerid][Level] < GetPlayerLevel(killerid))
					LevelUp(killerid);
				GameTextForPlayer(killerid,"~w~Exp + ~b~~h~1", 1000, 1);
        TogglePlayerSpectating(playerid, 1);
 		PlayerSpectatePlayer(playerid, killerid);
		Player[playerid][KillTime] = 3;
        if(IsPlayerInBezDmZone(killerid))
            JailPlayer(killerid,"zamieszki w strefie bez-dm",3);
        if(GetPlayerState(killerid) == PLAYER_STATE_DRIVER && (reason == WEAPON_UZI || reason == WEAPON_MP5 || reason == WEAPON_TEC9) && !IsPlayerInAnyVehicle(playerid))
		    Player[killerid][DBWarnings]++;
		    if(Player[killerid][DBWarnings] >= 2)
		        JailPlayer(killerid,"drive-by",2);
			else
			    format(String, sizeof(String), ""WI" "RED"Nie zabijaj z drive-by! Ostrzeżeń: %d/2", Player[killerid][DBWarnings]);
				SCM(killerid, C_ERROR, String);
		else if(GetPlayerState(killerid) == PLAYER_STATE_DRIVER && !IsPlayerInAnyVehicle(playerid) && reason == WEAPON_VEHICLE)
		    Player[killerid][CKWarnings]++;
		    if(Player[killerid][CKWarnings] >= 2)
		        JailPlayer(killerid,"car-kill",2);
			else
			    format(String, sizeof(String), ""WI" "RED"Nie zabijaj z car-kill! Ostrzeżeń: %d/2", Player[killerid][CKWarnings]);
				SCM(killerid, C_ERROR, String);
		else if(GetPlayerState(killerid) == PLAYER_STATE_DRIVER && !IsPlayerInAnyVehicle(playerid) && reason == 50)
		    Player[killerid][HKWarnings]++;
		    if(Player[killerid][HKWarnings] >= 2)
		        JailPlayer(killerid,"heli-kill",2);
			else
			    format(String, sizeof(String), ""WI" "RED"Nie zabijaj z heli-kill! Ostrzeżeń: %d/2", Player[killerid][HKWarnings]);
				SCM(killerid, C_ERROR, String);
    if(RywalSolo[0] == playerid)
		foreach(Player,x)
			if(IsPlayerInArea(x,-1486.0240,-1343.8665,335.8203,446.1019))
				new string2[80];
				format(string2,sizeof(string2),"(Solo) Wyzwanie wygrywa %s!",Player[RywalSolo[1]][Name]);
				SCM(x, C_YELLOW, string2);
		Achievement(RywalSolo[1], "aJestemLepszy");
        new Float:hp,Float:arm;
		GetPlayerHealth(RywalSolo[1], hp);
  		GetPlayerArmour(RywalSolo[1], arm);
		if(hp == 100.0 && arm == 100.0)
			Achievement(RywalSolo[1], "aJestemMistrzem");
		SetTimerEx("SoloEnd",2000,0,"i",playerid);
	else if(RywalSolo[1] == playerid)
		foreach(Player,x)
			if(IsPlayerInArea(x, -1486.0240,-1343.8665,335.8203,446.1019))
				new string2[80];
				format(string2,sizeof(string2),"(Solo) Wyzwanie wygrywa %s!",Player[RywalSolo[0]][Name]);
				SCM(x, C_YELLOW, string2);
		Achievement(RywalSolo[0], "aJestemLepszy");
        new Float:hp,Float:arm;
		GetPlayerHealth(RywalSolo[0], hp);
  		GetPlayerArmour(RywalSolo[0], arm);
		if(hp == 100.0 && arm == 100.0)
			Achievement(RywalSolo[0], "aJestemMistrzem");
		SetTimerEx("SoloEnd",2000,0,"i",playerid);
    if(RaceWystartowal && WyscigUczestnik[playerid])
		WyscigUczestnik[playerid] = false;
		TextDrawHideForPlayer(playerid, RaceStats[playerid]);
		WSMans = 0;
		foreach(Player,x)
			if(WyscigUczestnik[x])
				WSMans ++;
		if(WSMans <= 0)
			SCMA(C_GREEN," {FFFFFF}*(WS) "G"Wyścig zakończony!");
			TotalRaceEnd();
	if(DerbyON)
		DerbyMen[playerid] = false;
	if(WGTeam[playerid] > 0)
		WGPlayerEnd(playerid);
    if(PBTeam[playerid] == 1)
		PBPoints1 ++;
    if(PBTeam[playerid] == 2)
        PBPoints2 ++;
	if(ChWystartowala)
	    if(Chowany[killerid] || Chowany[playerid])
			Chowany[playerid] = false;
			SetPlayerPos(playerid, 2140.6675,993.1867,10.5248);
			if(Chowany[killerid])
				Chowany[killerid] = false;
           
				SCM(killerid,C_RED," {FFFFFF}*(CH) "R"Zostałeś(aś) usunięty(a) z zabawy za zabijanie!");
                SetPlayerActualInfo(killerid);
    if(Player[playerid][bounty] > 0)
		new String[128];
		format(String,sizeof(String),""WI" {E36600}%s zdobył głowę gracza %s! Otrzymuje on %d$! (/Hitman)",Player[killerid][Name],Player[playerid][Name],Player[playerid][bounty]);
		SCMA(0xE36600FF,String);
		Player[killerid][Money] += Player[playerid][bounty];
		GivePlayerMoney(killerid, Player[playerid][bounty]);
		Player[playerid][bounty] = 0;
	return 1;
public OnVehicleDeath(vehicleid, killerid)
	DestroyNeon(vehicleid);
	return 1;
public OnVehicleSpawn(vehicleid)
    DestroyNeon(vehicleid);
	for(new VehicleId=0;VehicleId<MAX_PRIVATE_VEHICLES;VehicleId++)
		if(vehicleid == VehicleId)
			SetVehiclePos(vInfo[VehicleId][vID],vInfo[VehicleId][vPosX],vInfo[VehicleId][vPosY],vInfo[VehicleId][vPosZ]);
			SetVehicleZAngle(vInfo[VehicleId][vID],vInfo[VehicleId][vAngle]);
			Attach3DTextLabelToVehicle(vInfo[VehicleId][vLabel],vInfo[VehicleId][vID],0.0, 0.0, 0.5);
            AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][SPOILER]);
		    AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][HOOD]);
		    AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][ROOF]);
			AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][SIDESKIRT]);
		    AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][LAMPS]);
		    AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][EXHAUST]);
		    AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][WHEELS]);
		    AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][STEREO]);
		    AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][HYDRAULICS]);
		    AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][FRONT_BUMPER]);
		    AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][REAR_BUMPER]);
		    AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][VENT_RIGHT]);
		    AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][VENT_LEFT]);
			ChangeVehiclePaintjob(vInfo[VehicleId][vID], vInfo[VehicleId][vPaintJob]);
	return 1;
public OnPlayerText(playerid, text[])   
    if(TestReaction == 1 && !strcmp(STRReaction, text))
		new zmienna = random(15),strx[155];
		format(strx, sizeof strx, "{FF0066}* {D9D9D9}Gracz %s wpisał jako pierwszy poprawnie kod! Otrzymuje {FF0066}$%d {D9D9D9}i {FF0066}%d exp{D9D9D9}. (%d kod).", Player[playerid][Name],5000+zmienna,15+zmienna,Player[playerid][Kodow]);
		SendClientMessageToAll(0xD9D9D9FF, strx);
		Player[playerid][Money] += 5000+zmienna;
		GivePlayerMoney(playerid, 5000+zmienna);
		Player[playerid][Exp] += 15+zmienna;
        if(Player[playerid][Level] < GetPlayerLevel(playerid))
			LevelUp(playerid);
		Player[playerid][Kodow] ++;
        Achievement(playerid, "aZwinnePalce");
		ReactionTimeout();
	    return 0;
	if(AntiAdvertisement(text))
        GMBan(playerid, "SERWER", "Reklama", Player[playerid][IP]);
		return 0;
    if(Player[playerid][Zajety])
        SCM(playerid,C_RED,""WI" "R"Wpisz 2 hasło rcon!");
		return 0;
	if(Player[playerid][Mute] > 0)
		SCM(playerid, C_RED, ""WE" "R"Jesteś uciszony(a). Odczekaj karę aż będziesz mógł pisać.");
        PlaySoundForPlayer(playerid,1085);
		return 0;
    if(Wiezien[playerid])
        SCM(playerid,C_RED,""WI" "R"Jesteś w więzieniu! Masz zablokowaną możliwość pisania na czacie. Wyjątek: /l [tekst], /Raport.");
		return 0;
    if(Player[playerid][SpamStrings] >= 12) {
		SCM(playerid,C_RED,""WE" "W"Zostałeś wyrzucony z powodu użycia spamera!");
		Kick(playerid);
		return 0;
	Player[playerid][SpamStrings] ++;
	if(Player[playerid][SpamStrings] >= 2 && !Player[playerid][Admin1]) {
		SCM(playerid,C_WHITE,""WE" "R"Nie spamuj! Możliwość pisania chwilowo zablokowana.");
        PlaySoundForPlayer(playerid,1085);
		return 0;
	if(!Player[playerid][Logged] && Player[playerid][Registered])
		SCM(playerid,C_WHITE,""E" "W"Aby pisać na czacie musisz się zalogować.");
        PlaySoundForPlayer(playerid,1085);
		SPD(playerid, D_LOGIN, DIALOG_STYLE_PASSWORD, "{00BFFF}Panel Logowania", ""W"To konto jest zarejestrowane na serwerze.\n\nAby na nim grać podaj hasło do konta:", "Zaloguj", "Anuluj");
		return 0;
    if(!Chowany[playerid] && !Szukajacy[playerid])
		SetPlayerChatBubble(playerid, text, 0xFFFFFF77, 13.5, 5000);
    new string[380];
	if(IsPlayerAdmin(playerid))
 		format(string, sizeof(string), "{666666}%d {%s}%s {FFFFFF}({BF1515}HA"W"): %s",playerid,Player[playerid][ChatColor],Player[playerid][Name], text);
	 	
		foreach(Player,x)
			if(GetPlayerRoom(x) == GetPlayerRoom(playerid))
				SCM(x, Player[playerid][Color], string);
	 	return 0;
    if(Player[playerid][Admin1])
 		format(string, sizeof(string), "{666666}%d {%s}%s {FFFFFF}({BF1515}A"W"): %s",playerid,Player[playerid][ChatColor],Player[playerid][Name], text);
        foreach(Player,x)
			if(GetPlayerRoom(x) == GetPlayerRoom(playerid))
				SCM(x, Player[playerid][Color], string);
		return 0;
    if(Player[playerid][Mod])
 		format(string, sizeof(string), "{666666}%d {%s}%s {FFFFFF}({57AD00}M"W"): %s",playerid,Player[playerid][ChatColor],Player[playerid][Name], text);
        foreach(Player,x)
			if(GetPlayerRoom(x) == GetPlayerRoom(playerid))
				SCM(x, Player[playerid][Color], string);
		return 0;
    if(Player[playerid][Vip])
 		format(string, sizeof(string), "{666666}%d {%s}%s {FFFFFF}({C9DB00}VIP"W"): %s",playerid,Player[playerid][ChatColor],Player[playerid][Name], text);
        foreach(Player,x)
			if(GetPlayerRoom(x) == GetPlayerRoom(playerid))
				SCM(x, Player[playerid][Color], string);
		return 0;
    if(!Player[playerid][Registered])
 		format(string, sizeof(string), "{666666}%d {%s}%s: {E3E3E3}%s",playerid,Player[playerid][ChatColor],Player[playerid][Name],text);
	 	
        foreach(Player,x)
			if(GetPlayerRoom(x) == GetPlayerRoom(playerid))
				SCM(x, Player[playerid][Color], string);
		return 0;
    format(string, sizeof(string), "{666666}%d {%s}%s: {FFFFFF}%s",playerid,Player[playerid][ChatColor],Player[playerid][Name],text);
    foreach(Player,x)
		if(GetPlayerRoom(x) == GetPlayerRoom(playerid))
			SCM(x, Player[playerid][Color], string);
	return 0;
stock IsVehicleInRangeOfPoint(vehicleid, Float:range, Float:x, Float:y, Float:z)
	new Float:px,Float:py,Float:pz;
	GetVehiclePos(vehicleid,px,py,pz);
	px -= x;
	py -= y;
	pz -= z;
	return ((px * px) + (py * py) + (pz * pz)) < (range * range);
public OnPlayerCommandPerformed(playerid, cmdtext[], success)
	if(!success)
		SCM(playerid, C_WHITE, ""E" "W"Nie znaleziono podanej komendy. Sprawdź "R"/Pomoc"W".");
        PlaySoundForPlayer(playerid,1085);
	return 1;
stock IsAnimation(cmdtext[])
    if(strfind(cmdtext,"/rece",true) == 0 || strfind(cmdtext,"/rece2",true) == 0) return 1;
    if(strfind(cmdtext,"/rece3",true) == 0 || strfind(cmdtext,"/rece4",true) == 0) return 1;
    if(strfind(cmdtext,"/rece5",true) == 0 || strfind(cmdtext,"/rece6",true) == 0) return 1;
    if(strfind(cmdtext,"/bar2",true) == 0 || strfind(cmdtext,"/bar3",true) == 0) return 1;
    if(strfind(cmdtext,"/szafka",true) == 0 || strfind(cmdtext,"/zegarek",true) == 0) return 1;
    if(strfind(cmdtext,"/lez",true) == 0 || strfind(cmdtext,"/hide",true) == 0) return 1;
    if(strfind(cmdtext,"/rzygaj",true) == 0 || strfind(cmdtext,"/grubas",true) == 0) return 1;
    if(strfind(cmdtext,"/grubas2",true) == 0 || strfind(cmdtext,"/taichi",true) == 0) return 1;
    if(strfind(cmdtext,"/siadaj",true) == 0 || strfind(cmdtext,"/chat",true) == 0) return 1;
    if(strfind(cmdtext,"/ratunku",true) == 0 || strfind(cmdtext,"/kopniak",true) == 0) return 1;
    if(strfind(cmdtext,"/cellin",true) == 0 || strfind(cmdtext,"/cellout",true) == 0) return 1;
    if(strfind(cmdtext,"/pij",true) == 0 || strfind(cmdtext,"/smoke",true) == 0) return 1;
    if(strfind(cmdtext,"/fsmoke",true) == 0 || strfind(cmdtext,"/krzeslo",true) == 0) return 1;
    if(strfind(cmdtext,"/krzeslo2",true) == 0 || strfind(cmdtext,"/calus",true) == 0) return 1;
    if(strfind(cmdtext,"/trup",true) == 0 || strfind(cmdtext,"/trup2",true) == 0) return 1;
    if(strfind(cmdtext,"/wankin",true) == 0 || strfind(cmdtext,"/wankout",true) == 0) return 1;
    if(strfind(cmdtext,"/deal",true) == 0 || strfind(cmdtext,"/boks",true) == 0) return 1;
    if(strfind(cmdtext,"/lol",true) == 0 || strfind(cmdtext,"/bomba",true) == 0) return 1;
    if(strfind(cmdtext,"/aresztuj",true) == 0 || strfind(cmdtext,"/opalaj",true) == 0) return 1;
    if(strfind(cmdtext,"/opalaj2",true) == 0 || strfind(cmdtext,"/opalaj3",true) == 0) return 1;
    if(strfind(cmdtext,"/turlaj",true) == 0 || strfind(cmdtext,"/klaps",true) == 0) return 1;
    if(strfind(cmdtext,"/kradnij",true) == 0 || strfind(cmdtext,"/kaleka",true) == 0) return 1;
    if(strfind(cmdtext,"/swat",true) == 0 || strfind(cmdtext,"/swat2",true) == 0) return 1;
    if(strfind(cmdtext,"/swat3",true) == 0 || strfind(cmdtext,"/piwo",true) == 0) return 1;
    if(strfind(cmdtext,"/drunk",true) == 0 || strfind(cmdtext,"/rap",true) == 0) return 1;
    if(strfind(cmdtext,"/lookout",true) == 0 || strfind(cmdtext,"/napad",true) == 0) return 1;
    if(strfind(cmdtext,"/papieros",true) == 0 || strfind(cmdtext,"/cpun",true) == 0) return 1;
    if(strfind(cmdtext,"/cpun2",true) == 0 || strfind(cmdtext,"/cpun3",true) == 0) return 1;
    if(strfind(cmdtext,"/cpun4",true) == 0 || strfind(cmdtext,"/cpun5",true) == 0) return 1;
    if(strfind(cmdtext,"/skok2",true) == 0 || strfind(cmdtext,"/skok3",true) == 0) return 1;
    if(strfind(cmdtext,"/jedz",true) == 0 || strfind(cmdtext,"/jedz2",true) == 0) return 1;
    if(strfind(cmdtext,"/jedz3",true) == 0 || strfind(cmdtext,"/taniec",true) == 0) return 1;
    if(strfind(cmdtext,"/wino",true) == 0 || strfind(cmdtext,"/taniec2",true) == 0) return 1;
    if(strfind(cmdtext,"/taniec3",true) == 0 || strfind(cmdtext,"/taniec4",true) == 0) return 1;
    if(strfind(cmdtext,"/taniec5",true) == 0 || strfind(cmdtext,"/taniec6",true) == 0) return 1;
    if(strfind(cmdtext,"/aresztowany",true) == 0 || strfind(cmdtext,"/aresztuj2",true) == 0) return 1;
    if(strfind(cmdtext,"/inbedright",true) == 0 || strfind(cmdtext,"/poddajsie",true) == 0) return 1;
    return 0;
public OnPlayerCommandReceived(playerid, cmdtext[])
	if(Player[playerid][Zajety])
        SCM(playerid,C_RED,""WI" "R"Wpisz 2 hasło rcon!");
		return 0;
    if(Player[playerid][Registered] && !Player[playerid][Logged])
        SCM(playerid,C_RED,""WI" "R"Musisz się zalogować aby używać komend!");
		return 0;
    if(GetPlayerVirtualWorld(playerid) == Player[playerid][InGang]+MAX_HOUSES)
		if(strfind(cmdtext,"/siedzibaexit",true) == 0 || strfind(cmdtext,"/exit",true) == 0) return 1;
        if(IsAnimation(cmdtext)) return 1;
		SCM(playerid,C_RED,""WE" "R"W siedzibie gangu nie możesz używać komend.");
		GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~w~/EXIT", 3000, 3);
  		PlaySoundForPlayer(playerid,1085);
		return 0;
	if(!Player[playerid][Admin1])
        if(Player[playerid][CMDSpam] >= 10) {
			SCM(playerid,C_RED,""WI" "R"Zostałeś wyrzucony z powodu użycia spamera!");
			Kick(playerid);
			return 0;
		Player[playerid][CMDSpam] ++;
		if(Player[playerid][CMDSpam] >= 4) {
			SCM(playerid,C_RED,""WI" "R"Nie spamuj komendami! Komendy zostały chwilowo zablokowane.");
            PlaySoundForPlayer(playerid,1085);
			return 0;
		if(Wiezien[playerid])
            if(strfind(cmdtext,"/l",true) == 0 || strfind(cmdtext,"/raport",true) == 0) return 1;
            if(IsAnimation(cmdtext)) return 1;
			SCM(playerid, C_RED, ""WE" "R"Masz zablokowaną możliwość wpisywania komend! Wyjątek: /l [tekst], /Raport");
            PlaySoundForPlayer(playerid,1085);
			return 0;
		if(Player[playerid][FloatDeath])
            SCM(playerid, C_RED, ""WE" "R"Poczekaj aż zrespawnujesz!");
            PlaySoundForPlayer(playerid,1085);
			return 0;
		if(Player[playerid][InHouse])
            if(strfind(cmdtext,"/wyjdz",true) == 0) return 1;
            if(IsAnimation(cmdtext)) return 1;
			SCM(playerid, C_RED, ""WE" "R"Musisz wyjść z domu aby używać komend. /Wyjdz.");
            PlaySoundForPlayer(playerid,1085);
			return 0;
        if(Player[playerid][OnOnede] || Player[playerid][OnMinigun] || Player[playerid][OnRPG] || Player[playerid][OnCombat] && GetPlayerVirtualWorld(playerid) == 10)
            if(strfind(cmdtext,"/arenaexit",true) == 0 || strfind(cmdtext,"/aexit",true) == 0) return 1;
			GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~w~/ARENAEXIT", 3000, 3);
            PlaySoundForPlayer(playerid,1085);
			return 0;
		if(playerid == RywalSolo[0] || playerid == RywalSolo[1])
            if(strfind(cmdtext,"/soloexit",true) == 0) return 1;
			SCM(playerid, C_RED, ""WE" "R"Na solówce nie wolno używać komend! Wyjątek: /SoloExit.");
            PlaySoundForPlayer(playerid,1085);
			return 0;
        if(Chowany[playerid] || Szukajacy[playerid] && ChWystartowala)
			if(strfind(cmdtext,"/chexit",true) == 0) return 1;
			SCM(playerid,C_RED,""WE" "R"Na Chowanym nie można używać komend! Wyjątek: /CHexit.");
			return 0;
		if(DerbyMen[playerid] && DerbyON)
			if(strfind(cmdtext,"/usexit",true) == 0) return 1;
			SCM(playerid,C_RED,""WE" "R"Na Derbach nie można używać komend! Wyjątek: /UsExit.");
			return 0;
        if(SNKandydat[playerid] && SNON)
			if(strfind(cmdtext,"/snexit",true) == 0) return 1;
			SCM(playerid,C_RED,""WE" "R"Na sianku nie można używać komend! Wyjątek: /SnExit.");
			return 0;
		if(WGTeam[playerid] == 1 || WGTeam[playerid] == 2)
			if(strfind(cmdtext,"/wgexit",true) == 0) return 1;
			SCM(playerid,C_RED,""WE" "R"Na Wojnie Gangów nie można używać komend! Wyjątek: /WGexit.");
			return 0;
		if(PBTeam[playerid] == 1 || PBTeam[playerid] == 2)
			if(strfind(cmdtext,"/pbexit",true) == 0) return 1;
			SCM(playerid,C_RED,""WE" "R"Na paintballu nie można używać komend! Wyjątek: /PBexit.");
			return 0;
		if(RaceWystartowal && WyscigUczestnik[playerid])
			if(strfind(cmdtext,"/wsexit",true) == 0 || strfind(cmdtext,"/flip",true) == 0 || strfind(cmdtext,"/napraw",true) == 0) return 1;
			SCM(playerid, C_RED, ""WE" "R"Na wyścigu nie można używać komend! Wyjątki: /Flip, /WSExit, /Napraw.");
			return 0;
	return 1;
public OnPlayerExitVehicle(playerid, vehicleid)
	if(GetVehicleModel(vehicleid) == 520 && !IsPlayerInFreeZone(playerid))
	    SCM(playerid, C_GREEN, ""WI" "G"Wysiadłeś z Hydry, została ona zrespawnowana. Nie byłeś w strefie śmierci.");
		SetVehicleToRespawn(vehicleid);
	return 1;
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
	if(vInfo[vehicleid][vID] != Player[playerid][pVeh] && vehicleid <= MAX_PRIVATE_VEHICLES)
        if(ispassenger)
			return 1;
		if(IsPlayerAdmin(playerid))
  			return 1;
		SCM(playerid, C_ERROR, ""WE" "R"To nie jest twój prywatny pojazd!");
  		SCM(playerid, C_ERROR, ""WI" "R"Możesz taki mieć kupując go w panelu "W"/Pojazd"R".");
		new Float:fx,Float:y,Float:z;
		GetPlayerPos(playerid,fx,y,z);
		SetPlayerPos(playerid,fx,y,z+2);
	return 1;
public OnPlayerStateChange(playerid, newstate, oldstate)
    if(newstate == PLAYER_STATE_DRIVER)
        if(Player[playerid][LicznikON])
			for(new x=0;x<13;x++)
		        TextDrawShowForPlayer(playerid,LicznikBox[x]);
            TextDrawShowForPlayer(playerid,LicznikNazwa[playerid]);
			TextDrawShowForPlayer(playerid,LicznikPredkosc[playerid]);
        SCM(playerid,C_GREEN," {FF0000}* "G"Jesteś w pojeździe. Wypróbuj: /Auto, /Neony, /Tune, /TuneMenu, /Lock, /Unlock oraz /Drift.");
		new Model = GetVehicleModel(GetPlayerVehicleID(playerid)),String[70];
		format(String,sizeof(String),"~g~~h~0 ~w~~h~km/h___HP: %d/100",GetRealVehicleHealth(playerid));
        TextDrawSetString(LicznikPredkosc[playerid],String);
		TextDrawSetString(LicznikNazwa[playerid], CarList[Model-400]);
		if(Model == 462 || Model == 448 || Model == 581 || Model == 522 || Model == 461 || Model == 521 || Model == 523 || Model == 463 || Model == 586 || Model == 468 || Model == 471 && GetPlayerSkin(playerid) != 27)
            if(Player[playerid][KaskON] && !Player[playerid][Santa])
				Player[playerid][OnBike] = true;
                if(IsPlayerAttachedObjectSlotUsed(playerid,SLOT_PRZEDMIOT_GLOWA))
					SCM(playerid,C_WHITE,""I" "W"Kask nie został założony, ponieważ posiadasz przedmioty na głowie.");
				else
                    SetPlayerAttachedObject(playerid,SLOT_KASK,18645,2,0.05,0.01,0.00,3.0,82.0,87.0,1.00,1.00,1.00);
					Achievement(playerid, "aKask");
    if(newstate == PLAYER_STATE_ONFOOT)
		for(new x=0;x<13;x++)
  			TextDrawHideForPlayer(playerid,LicznikBox[x]);
		TextDrawHideForPlayer(playerid,LicznikNazwa[playerid]);
		TextDrawHideForPlayer(playerid,LicznikPredkosc[playerid]);
		if(Player[playerid][OnBike])
            Player[playerid][OnBike] = false;
			RemovePlayerAttachedObject(playerid,SLOT_KASK);
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
		foreach(Player,x)
			if(Player[x][gSpectateID] == playerid && GetPlayerState(x) == PLAYER_STATE_SPECTATING)
				PlayerSpectateVehicle(x,GetPlayerVehicleID(playerid));
		return 1;
    if(oldstate == PLAYER_STATE_DRIVER && newstate != PLAYER_STATE_PASSENGER || oldstate == PLAYER_STATE_PASSENGER && newstate != PLAYER_STATE_DRIVER)
		foreach(Player,x)
			if(Player[x][gSpectateID] == playerid && GetPlayerState(x) == PLAYER_STATE_SPECTATING)
				PlayerSpectatePlayer(x, playerid);
		return 1;
	return 1;
public OnPlayerEnterCheckpoint(playerid)
    Player[playerid][IsPlayerInCheckPoint] = true;
    if(IsPlayerInArea(playerid, -102.0093,488.8185, 1661.8014, 2204.8889)) //Wojsko
		SPD(playerid, D_BRONIES_CP, DIALOG_STYLE_MSGBOX,"{00BFFF}Bronie Specjalne", "Czy chcesz zakupić bronie specjalne?", "Tak", "Zamknij");
	if(IsPlayerInArea(playerid, 392.2149,782.6511,716.4636,1049.3254)) //Wojsko x2
        SPD(playerid, D_BRONIES_CP, DIALOG_STYLE_MSGBOX,"{00BFFF}Bronie Specjalne", "Czy chcesz zakupić bronie specjalne?", "Tak", "Zamknij");
    if(IsPlayerInArea(playerid, -56.4757,97.0263,1791.5306,1930.1420)) //Wojak na afganistanie
        SPD(playerid, D_PRACA_WOJAK, DIALOG_STYLE_MSGBOX,"{00BFFF}Wojskowy", "Czy chcesz zostać żołnierzem?", "Tak", "Nie");
	if(IsPlayerInArea(playerid, -36.6350,-17.2657,-57.9944,-49.0046)) //Bank
		SPD(playerid, D_BANK, DIALOG_STYLE_LIST, "{00BFFF}Bank","› Wpłać\n"GUI2"› Wypłać\n"W"› Stan Konta\n"GUI2"› Przelew", "Wybierz", "Zamknij");
	return 1;
public OnPlayerLeaveCheckpoint(playerid)
	return Player[playerid][IsPlayerInCheckPoint] = false;
public OnPlayerEnterRaceCheckpoint(playerid)
	if(WyscigUczestnik[playerid])
		new status = WyscigStatus[playerid];
		Pozycja[status] ++;
		WyscigStatus[playerid] ++;
		ActualPos[playerid] = Pozycja[status];
		WSMans = 0;
		foreach(Player,x)
			if(WyscigUczestnik[x])
				WSMans ++;
		if(WyscigStatus[playerid] == CPliczba)
			new string[100];
			NaMecieMiejsce ++;
			format(string,sizeof(string)," "W"*(WS) {FF0066}%s id(%d) dotarł(a) na metę wyścigu > %d Miejsce",Player[playerid][Name],playerid,NaMecieMiejsce);
        
			if(NaMecieMiejsce == 1)
            	SetPlayerActualInfo(playerid);
				Player[playerid][Exp] += 20;
				Player[playerid][WygranychWS] ++;
				if(Player[playerid][Level] < GetPlayerLevel(playerid))
					LevelUp(playerid);
                Player[playerid][Money] += 5000;
                GivePlayerMoney(playerid, 5000);
				GameTextForPlayer(playerid,"~w~Exp + ~b~~h~20", 1000, 1);
                PlayCompleteMissionSound(playerid);
				Achievement(playerid, "aStreetKing");
                
			if(NaMecieMiejsce == 2)
                SetPlayerActualInfo(playerid);
                Player[playerid][Exp] += 15;
                Player[playerid][Money] += 3000;
                PlayCompleteMissionSound(playerid);
				GivePlayerMoney(playerid, 3000);
				if(Player[playerid][Level] < GetPlayerLevel(playerid))
					LevelUp(playerid);
				GameTextForPlayer(playerid,"~w~Exp + ~b~~h~15", 1000, 1);
			if(NaMecieMiejsce == 3)
                SetPlayerActualInfo(playerid);
                Player[playerid][Exp] += 10;
                Player[playerid][Money] += 2000;
                GivePlayerMoney(playerid, 2000);
                PlayCompleteMissionSound(playerid);
				if(Player[playerid][Level] < GetPlayerLevel(playerid))
					LevelUp(playerid);
				GameTextForPlayer(playerid,"~w~Exp + ~b~~h~10", 1000, 1);
			foreach(Player,x)
				if(PlayerToPoint(100,x,CPx[CPliczba-1],CPy[CPliczba-1],CPz[CPliczba-1]) || WyscigUczestnik[x])
					SCM(x,C_PINK,string);
			WyscigUczestnik[playerid] = false;
			DisablePlayerRaceCheckpoint(playerid);
			DestroyVehicleEx(GetPlayerVehicleID(playerid));
            TextDrawHideForPlayer(playerid, RaceStats[playerid]);
			if(WSMans <= 2)
				SCMA(C_GREEN," "W"*(WS) "G"Wyścig zakończony!");
				TotalRaceEnd();
			return 1;
		if(WyscigStatus[playerid] == CPliczba-1)
			PlayerPlaySound(playerid, 1139, 0, 0, 0);
			SetPlayerRaceCheckpoint(playerid,CPType+1,CPx[WyscigStatus[playerid]],CPy[WyscigStatus[playerid]],CPz[WyscigStatus[playerid]],CPx[WyscigStatus[playerid]],CPy[WyscigStatus[playerid]],CPz[WyscigStatus[playerid]],CPSize);
		else
			PlayerPlaySound(playerid, 1139, 0, 0, 0);
			SetPlayerRaceCheckpoint(playerid,CPType,CPx[WyscigStatus[playerid]],CPy[WyscigStatus[playerid]],CPz[WyscigStatus[playerid]],CPx[WyscigStatus[playerid]+1],CPy[WyscigStatus[playerid]+1],CPz[WyscigStatus[playerid]+1],CPSize);
		return 1;
	return 1;
public OnPlayerRequestSpawn(playerid)
	if(!Player[playerid][Logged] && Player[playerid][Registered])
		SCM(playerid, C_WHITE, ""E" "W"Musisz się zalogować aby móc grać pod tym nickiem.");
        SPD(playerid, D_LOGIN, DIALOG_STYLE_PASSWORD, "{00BFFF}Panel Logowania", ""W"To konto jest zarejestrowane na serwerze.\n\nAby na nim grać podaj hasło do konta:", "Zaloguj", "Anuluj");
		return 0;
	PlayerPlaySound(playerid,1188,0.0,0.0,0.0);
   
	UnPanorama(playerid);
	TextDrawShowForPlayer(playerid, CzasTD);
    TextDrawShowForPlayer(playerid, DataTD);
	TextDrawShowForPlayer(playerid, HealthTD[playerid]);
	TextDrawShowForPlayer(playerid, ArmourTD[playerid]);
	TextDrawShowForPlayer(playerid, ZapisyString);
	TextDrawShowForPlayer(playerid, ZapisyLiczba);
    for(new x=0;x<13;x++)
		TextDrawShowForPlayer(playerid,PasekBox[x]);
	TextDrawShowForPlayer(playerid,PasekStringGora);
 	TextDrawShowForPlayer(playerid,ExpTD[playerid]);
 	TextDrawShowForPlayer(playerid,LevelTD[playerid]);
	TextDrawShowForPlayer(playerid,OnlineTD[playerid]);
	TextDrawShowForPlayer(playerid,RatioTD[playerid]);
	TextDrawShowForPlayer(playerid,PortfelTD[playerid]);
	TextDrawShowForPlayer(playerid,GraczeTD);
    TextDrawShowForPlayer(playerid,WpiszVIPTD);
	return 1;
public OnPlayerPickUpPickup(playerid, pickupid)
    if(BagEnabled && BagPickup == pickupid && !Player[playerid][Admin1])
	    GivePlayerMoney(playerid, BagCash);
        Player[playerid][Money] += BagCash;
		new BagExp = 15+random(25);
	    Player[playerid][Exp] += BagExp;
		if(Player[playerid][Level] < GetPlayerLevel(playerid))
			LevelUp(playerid);
        new String[255];
        format(String, sizeof(String), ""WI" "R"%s (%d) znalazł walizkę. Zgarnia %d$ i %d exp.", Player[playerid][Name], playerid, BagCash, BagExp);
		SCMA(C_RED, String);
        DestroyPickup(BagPickup);
		BagCash = 0;
        BagEnabled = false;
        Achievement(playerid,"aPoszukiwacz");
		format(String,sizeof(String),"~w~Exp + ~b~~h~%d",BagExp);
		GameTextForPlayer(playerid,String, 1000, 1);
		return 1;
    if(PodkowaEnabled && PodkowaPickup == pickupid && !Player[playerid][Admin1] && !Player[playerid][Mod])
	    GivePlayerMoney(playerid, PodkowaCash);
        Player[playerid][Money] += PodkowaCash;
		new PodkowaExp = 15+random(25);
	    Player[playerid][Exp] += PodkowaExp;
		if(Player[playerid][Level] < GetPlayerLevel(playerid))
			LevelUp(playerid);
        Achievement(playerid,"aPoszukiwacz");
        new String[255];
        format(String, sizeof(String), ""WI" "R"%s (%d) znalazł podkowę. Zgarnia szczęście oraz %d$ i %d exp.", Player[playerid][Name], playerid, PodkowaCash, PodkowaExp);
		SCMA(C_RED, String);
        DestroyPickup(PodkowaPickup);
		PodkowaCash = 0;
        PodkowaEnabled = false;
        format(String,sizeof(String),"~w~Exp + ~b~~h~%d",PodkowaExp);
		GameTextForPlayer(playerid,String, 1000, 1);
		return 1;
    if(PrezentEnabled && PrezentPickup == pickupid && !Player[playerid][Admin1])
		switch(random(8))
		    case 0:
                GivePlayerMoney(playerid, 5000);
                Player[playerid][Exp] += 20;
                if(Player[playerid][Level] < GetPlayerLevel(playerid))
					LevelUp(playerid);
				Player[playerid][Money] += 5000;
				SPD(playerid,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Prezent!","Otrzymujesz:\n\n- 5000$\n- 10 exp\n- M4 (5000 ammo)","Zamknij","");
				GameTextForPlayer(playerid,"~w~Exp + ~b~~h~20",1000, 1);
		    case 1:
                GivePlayerMoney(playerid, 20000);
                Player[playerid][Exp] += 15;
                if(Player[playerid][Level] < GetPlayerLevel(playerid))
					LevelUp(playerid);
				Player[playerid][Money] += 20000;
                SetPlayerAttachedObject(playerid,SLOT_KASK,18645,2,0.05,0.01,0.00,3.0,82.0,87.0,1.00,1.00,1.00);
				SPD(playerid,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Prezent!","Otrzymujesz:\n\n- 20000$\n- 15 exp\n- Kask","Zamknij","");
                GameTextForPlayer(playerid,"~w~Exp + ~b~~h~15",1000, 1);
			case 2:
                GivePlayerMoney(playerid, 10000);
                Player[playerid][Exp] += 5;
                if(Player[playerid][Level] < GetPlayerLevel(playerid))
					LevelUp(playerid);
				Player[playerid][Money] += 10000;
                SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_INNE, 2976, 6, -0.100000, 0.000000, 0.100000, 0.000000, 80.000000, 0.000000, 1.000000, 1.000000, 1.500000 ); // green_gloop - Replaces Spas
				SPD(playerid,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Prezent!","Otrzymujesz:\n\n- 10000$\n- 5 exp\n- Laser","Zamknij","");
                GameTextForPlayer(playerid,"~w~Exp + ~b~~h~5",1000, 1);
			case 3:
                new Float:x,Float:y,Float:z;
				GetPlayerPos(playerid,x,y,z);
				CreateExplosion(x,y,z,2,50);
				SPD(playerid,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Bombowy prezent!","Otrzymujesz:\n\n- Bombę","Zamknij","");
                GameTextForPlayer(playerid,"~r~B~w~OMBA!",1000, 1);
			case 4:
                RegeneratePlayer(playerid);
				SPD(playerid,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Prezent!","Otrzymujesz:\n\n- Regenerację zdrowia","Zamknij","");
            case 5:
                Player[playerid][Exp] += 10;
                GivePlayerCar(playerid, 531);
				if(Player[playerid][Level] < GetPlayerLevel(playerid))
					LevelUp(playerid);
				SPD(playerid,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Prezent!","Otrzymujesz:\n\n- Traktor\n- 10 exp","Zamknij","");
                GameTextForPlayer(playerid,"~w~Exp + ~b~~h~10",1000, 1);
            case 6:
                Player[playerid][Exp] += 5;
                GivePlayerCar(playerid, 464);
				if(Player[playerid][Level] < GetPlayerLevel(playerid))
					LevelUp(playerid);
				SPD(playerid,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Prezent!","Otrzymujesz:\n\n- Zabawkę\n- 5 exp","Zamknij","");
                GameTextForPlayer(playerid,"~w~Exp + ~b~~h~5",1000, 1);
			case 7:
                Player[playerid][Exp] += 15;
                GivePlayerCar(playerid, 432);
				if(Player[playerid][Level] < GetPlayerLevel(playerid))
					LevelUp(playerid);
				SPD(playerid,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Prezent!","Otrzymujesz:\n\n- Czołg\n- 15 exp","Zamknij","");
                GameTextForPlayer(playerid,"~w~Exp + ~b~~h~15",1000, 1);
        Achievement(playerid,"aPoszukiwacz");
        new String[255];
        format(String, sizeof(String), ""WI" "R"%s (%d) znalazł prezent! Zgarnia on jego zawartość.", Player[playerid][Name], playerid);
		SCMA(C_RED, String);
        DestroyPickup(PrezentPickup);
        PrezentEnabled = false;
		return 1;
	return 1;
public OnPlayerPickUpDynamicPickup(playerid, pickupid)
	for(new HouseId = 0; HouseId < MAX_HOUSES; HouseId++)
        if(pickupid == hInfo[HouseId][hPickup] && Player[playerid][HouseAction] == 0 && !Player[playerid][NearHouse])
            Player[playerid][House] = HouseId;
            Player[playerid][ObokHouse] = true;
            Player[playerid][NearHouse] = true;
			if(hInfo[HouseId][hOwner] == '0')
				SPD(playerid,D_HOUSE_NIEKUPIONY,DIALOG_STYLE_LIST,hInfo[HouseId][hName],"› Zakup dom\n"GUI2"› Obejrzyj dom","Wybierz","Zamknij");
			else
                if(strcmp(Player[playerid][Name],hInfo[HouseId][hOwner])==0)
					SPD(playerid,D_HOUSE_KUPIONY_OWNER,DIALOG_STYLE_LIST,hInfo[HouseId][hName],"› Wejdź\n"GUI2"› Sprzedaj\n"W"› Zmień spawn\n"GUI2"› Zapłać czynsz\n"W"› Otwórz/Zamknij drzwi\n"GUI2"› Sprawdź ważność","Wybierz","Zamknij");
				else
    				SPD(playerid,D_HOUSE_KUPIONY,DIALOG_STYLE_LIST,hInfo[HouseId][hName],"› Zapukaj\n"GUI2"› Wejdź","Wybierz","Zamknij");
			Player[playerid][HouseAction] = 7;
			return 1;
	for(new BizId = 0; BizId < MAX_BIZNES; BizId++)
        if(pickupid == bInfo[BizId][bPickup] && Player[playerid][BiznesAction] == 0)
			Player[playerid][Biznes] = BizId;
			if(bInfo[BizId][bOwner] == '0')
				new String[200];
				format(String,sizeof(String), "Ten biznes jest na sprzedaż.\nJeżeli go kupisz będzie on twoją własnością do czasu\ngdy ktoś inny nie odkupi go od ciebie.\n\nPo kupnie będziesz regularnie otrzymywać %d$ do banku.",bInfo[BizId][bCash]);
				SPD(playerid,D_BIZNES_NIEKUPIONY,DIALOG_STYLE_MSGBOX,bInfo[BizId][bName],String,"Zakup","Zamknij");
			else
                if(strcmp(Player[playerid][Name], bInfo[BizId][bOwner])==0)
					SPD(playerid,D_BIZNES_KUPIONY_OWNER,DIALOG_STYLE_LIST,bInfo[BizId][bName],"› Sprzedaj ten biznes","Wybierz","Zamknij");
				else
					new String[128];
					format(String,sizeof(String),"Czy chcesz odkupić ten biznes za %d$?",bInfo[BizId][bCash]);
					SPD(playerid,D_BIZNES_KUPIONY,DIALOG_STYLE_MSGBOX,bInfo[BizId][bName],String,"Odkup","Zamknij");
            Player[playerid][BiznesAction] = 8;
			return 1;
    for(new GangId = 0; GangId < MAX_GANGS; GangId++)
        if(pickupid == gInfo[GangId][gEnterPickup] && Player[playerid][SiedzibaAction] == 0)
			if(Player[playerid][InGang] != GangId)
				SCM(playerid,C_RED,""WE" "R"Nie możesz wejść do siedziby tego gangu.");
                Player[playerid][SiedzibaAction] = 7;
				return 1;
			SPD(playerid,D_ENTER_SIEDZIBA,DIALOG_STYLE_MSGBOX,"Siedziba","Czy chcesz wejść do siedziby?","Tak","Nie");
			Player[playerid][SiedzibaAction] = 7;
			return 1;
    if(pickupid == Entrance[1])
		return SetPlayerPos(playerid,-1468.4532,344.1803,30.0820);
	if(pickupid == Entrance[2])
		return SetPlayerPos(playerid,-1470.2970,311.1587,7.1875);
	return 1;
public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
	new VehicleId = Player[playerid][pVeh];
	if(vehicleid == vInfo[VehicleId][vID])
		vInfo[VehicleId][vPaintJob] = paintjobid;
	return 1;
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
	if(newkeys == 1 || newkeys == 9 || newkeys == 33 && oldkeys != 1 || oldkeys != 9 || oldkeys != 33)
	    if(IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0)
			new CarId = GetPlayerVehicleID(playerid);
			new ModelIdx = GetVehicleModel(CarId);
			switch(ModelIdx)
				case 611: return 0;
			AddVehicleComponent(CarId, 1010);
	if(newkeys == 32 && Player[playerid][AirON] && !IsPlayerOnEvent(playerid))
		if(!IsPlayerInAnyVehicle(playerid))
			new Float:x,Float:y,Float:z;
			GetPlayerVelocity(playerid,x,y,z);
			if(InAir[playerid] == 0 && z == 0)
				JestNaZiemi[playerid] = 1;
				InAir[playerid] = 1;
				SkoczylDwaRazy[playerid] = 0;
			else
				if(SkoczylDwaRazy[playerid] == 1) return 1;
				if(z <= 0)
					SetPlayerVelocity(playerid,x,y,4);
					SkoczylDwaRazy[playerid] = 1;
				else
					SetPlayerVelocity(playerid,x,y,z+4);
					SkoczylDwaRazy[playerid] = 1;
    if(Player[playerid][WlaczylRampy] == 1 && !IsPlayerOnEvent(playerid))
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0 && (newkeys == KEY_ACTION || newkeys == 9))
			new Buffer = GetPlayerVehicleID(playerid);
			switch(GetVehicleModel(Buffer))
				case 592,577,511,512,593,520,553,476,519,460,513,487,488,548,425,417,497,563,447,469:
				return 1;
			if(Player[playerid][StworzylRampy] == true)
				KillTimer(Player[playerid][RampTimer]);
				DestroyPlayerObject(playerid, Player[playerid][Ramp]);
			new Float:pX, Float:pY, Float:pZ, Float:vA;
			GetVehiclePos(Buffer, pX, pY, pZ);
			GetVehicleZAngle(Buffer, vA);
			Player[playerid][Ramp] = CreatePlayerObject(playerid, Player[playerid][RampCoords], pX + (25.0 * floatsin(-vA, degrees)), pY + (25.0 * floatcos(-vA, degrees)), pZ, 0, 0, vA);
			Player[playerid][StworzylRampy] = true;
			Player[playerid][RampTimer] = SetTimerEx("DestroyRamp", 4000, 0, "d", playerid);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && PRESSED(KEY_SUBMISSION) && !IsPlayerOnEvent(playerid))
        if(Player[playerid][Naprawil] > 0 && !Player[playerid][Vip] && !Player[playerid][Mod] && !Player[playerid][Admin1])
			new String[55];
			format(String,sizeof(String),"Musisz odczekac %d sekund aby naprawic pojazd.",Player[playerid][Naprawil]);
			ShowInfoBox(playerid,String,3);
			return 1;
		RepairVehicle(GetPlayerVehicleID(playerid));
        
        ShowInfoBox(playerid,"Pojazd naprawiony!",3);
		PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
        Player[playerid][Naprawil] = 10;
 	return 1;
public OnRconLoginAttempt(ip[], password[], success)
    new AJPI[16];
	if(success)
  		for(new x; x < MAX_PLAYERS; x++)
			if(!IsPlayerConnected(x))
				continue;
			GetPlayerIp(x, AJPI, 16);
			if(!strcmp(ip, AJPI))
                CheckRconFirstAdmin(x);
				SPD(x, D_RCON, DIALOG_STYLE_PASSWORD, "{00BFFF}Panel "R"RCON", "Aby zalogować się na konto administratorskie [RCON]\nnależy znać hasło dostępu.\n\nPoniżej podaj hasło administratorskie [RCON]:", "Zaloguj", "Kick");
		        Player[x][Zajety] = true;
				return 1;
	return 1;
public OnPlayerUpdate(playerid)
    if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
        new Float:vec[3];
        GetPlayerCameraFrontVector(playerid, vec[0], vec[1], vec[2]);
        new bool:possible_crasher = false;
        for (new i = 0; !possible_crasher && i < sizeof(vec); i++)
            if (floatabs(vec[i]) > 10.0)
                possible_crasher = true;
        if (possible_crasher)
            return 0; //do not send fake data, prevents crash
	Player[playerid][AFKChecker] = true;
    if(JestNaZiemi[playerid] == 1)
		if(!IsPlayerInAnyVehicle(playerid))
		    new Float:x,Float:y,Float:z;
		    GetPlayerVelocity(playerid,x,y,z);
		    if(z == 0)
		        if(WaitForJump[playerid] == 1)
		            WaitForJump[playerid] = 0;
		            InAir[playerid] = 0;
		            return 1;
		        WaitForJump[playerid] = 1;
		        if(x > 0 || x < 0 || y > 0 || y < 0)
		            return 1;
				else
				    InAir[playerid] = 0;
				    SkoczylDwaRazy[playerid] = 0;
	if(LaserID[playerid] == 1)
    	switch(GetPlayerWeapon(playerid))
		    case 0..21:
				RemovePlayerAttachedObject(playerid, SLOT_LASER);
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
    		case 22:
				SetPlayerAttachedObject(playerid, SLOT_LASER, 18643, 5, 0.140000, 0.019999, -0.090000, 0.000000, 7.000000, -3.000000, 1.000000, 1.000000, 1.000000);
				SetPlayerAttachedObject(playerid, SLOT_LASER2, 18643, 6, 0.100000, 0.029999, 0.090000, 0.000000, -9.000000, 3.000000, 1.000000, 1.000000, 1.000000);
			case 23:
			 	RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid, SLOT_LASER, 18643, 6, 0.100000, 0.029999, 0.079999, 0.000000, -10.000000, 4.000000, 1.000000, 1.000000, 1.000000);
			case 24:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
				SetPlayerAttachedObject(playerid, SLOT_LASER, 18643, 6, 0.139999, 0.019999, 0.079999, 0.000000, 3.000000, 0.000000, 1.000000, 1.000000, 1.000000);
			case 25:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
				SetPlayerAttachedObject(playerid, SLOT_LASER, 18643, 6, 0.400000, -0.000000, 0.110000, 0.000000, -9.000000, -6.000000, 1.000000, 1.000000, 1.000000);
			case 26:
				SetPlayerAttachedObject(playerid, SLOT_LASER, 18643, 5, 0.389999, 0.019999, -0.119999, 0.000000, 5.000000, 2.000000, 1.000000, 1.000000, 1.000000);
				SetPlayerAttachedObject(playerid, SLOT_LASER2, 18643, 6, 0.299999, 0.019999, 0.119999, 0.000000, -6.000000, -1.000000, 1.000000, 1.000000, 1.000000);
			case 27:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid, SLOT_LASER, 18643, 6, 0.200000, 0.019999, 0.139999, 0.000000, -8.000000, -6.000000, 1.000000, 1.000000, 1.000000);
			case 28:
				SetPlayerAttachedObject(playerid, SLOT_LASER, 18643, 6, -0.000000, 0.019999, 0.080000, 0.000000, -4.000000, -5.000000, 1.000000, 1.000000, 1.000000);
				SetPlayerAttachedObject(playerid, SLOT_LASER2, 18643, 5, 0.089999, 0.029999, -0.080000, 0.000000, 3.000000, 6.000000, 1.000000, 1.000000, 1.000000);
			case 29:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid, SLOT_LASER, 18643, 6, 0.200000, 0.000000, 0.159999, 0.000000, -6.000000, -6.000000, 1.000000, 1.000000, 1.000000);
			case 30:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid, SLOT_LASER, 18643, 6, 0.200000, 0.010000, 0.089999, 0.000000, -3.000000, -5.000000, 1.000000, 1.000000, 1.000000);
			case 31:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid, SLOT_LASER, 18643, 6, 0.200000, 0.010000, 0.089999, 0.000000, -3.000000, -5.000000, 1.000000, 1.000000, 1.000000);
			case 32:
				SetPlayerAttachedObject(playerid, SLOT_LASER, 18643, 6, 0.100000, 0.039999, 0.099999, 0.000000, -3.000000, -3.000000, 1.000000, 1.000000, 1.000000);
				SetPlayerAttachedObject(playerid, SLOT_LASER2, 18643, 5, 0.200000, 0.009999, -0.099999, 0.000000, 4.000000, 3.000000, 1.000000, 1.000000, 1.000000);
			case 33:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid, SLOT_LASER, 18643, 6, 0.300000, 0.010000, 0.109999, 0.000000, -9.000000, -6.800000, 1.000000, 1.000000, 1.000000);
			case 34:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid, SLOT_LASER, 18643, 6, -0.199999, 0.050000, 0.040000, 0.000000, -7.000000, -5.000000, 1.000000, 1.000000, 1.000000);
			case 35:
			 	RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid, SLOT_LASER, 18643, 6, -0.289999, 0.039999, 0.109999, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
			case 36:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid, SLOT_LASER, 18643, 6, -0.400000, 0.039999, 0.139999, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
			case 37:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid, SLOT_LASER, 18643, 6, 0.600000, 0.009999, 0.190000, 0.000000, -29.000000, -4.000000, 1.000000, 1.000000, 1.000000);
			case 38:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid, SLOT_LASER, 18643, 6, 0.400000, 0.029999, -0.009999, 0.000000, -29.000000, -4.000000, 1.000000, 1.000000, 1.000000);
			case 39..46:
				RemovePlayerAttachedObject(playerid, SLOT_LASER);
			    RemovePlayerAttachedObject(playerid, SLOT_LASER2);
	else if(LaserID[playerid] == 2)
	    switch(GetPlayerWeapon(playerid))
		    case 0..21:
				RemovePlayerAttachedObject(playerid, SLOT_LASER);
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
    		case 22:
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19080, 5, 0.140000, 0.019999, -0.090000, 0.000000, 7.000000, -3.000000, 1.000000, 1.000000, 1.000000);
				SetPlayerAttachedObject(playerid,SLOT_LASER2, 19080, 6, 0.100000, 0.029999, 0.090000, 0.000000, -9.000000, 3.000000, 1.000000, 1.000000, 1.000000);
			case 23:
			 	RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid,SLOT_LASER, 19080, 6, 0.100000, 0.029999, 0.079999, 0.000000, -10.000000, 4.000000, 1.000000, 1.000000, 1.000000);
			case 24:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19080, 6, 0.139999, 0.019999, 0.079999, 0.000000, 3.000000, 0.000000, 1.000000, 1.000000, 1.000000);
			case 25:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19080, 6, 0.400000, -0.000000, 0.110000, 0.000000, -9.000000, -6.000000, 1.000000, 1.000000, 1.000000);
			case 26:
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19080, 5, 0.389999, 0.019999, -0.119999, 0.000000, 5.000000, 2.000000, 1.000000, 1.000000, 1.000000);
				SetPlayerAttachedObject(playerid,SLOT_LASER2, 19080, 6, 0.299999, 0.019999, 0.119999, 0.000000, -6.000000, -1.000000, 1.000000, 1.000000, 1.000000);
			case 27:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid,SLOT_LASER, 19080, 6, 0.200000, 0.019999, 0.139999, 0.000000, -8.000000, -6.000000, 1.000000, 1.000000, 1.000000);
			case 28:
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19080, 6, -0.000000, 0.019999, 0.080000, 0.000000, -4.000000, -5.000000, 1.000000, 1.000000, 1.000000);
				SetPlayerAttachedObject(playerid,SLOT_LASER2, 19080, 5, 0.089999, 0.029999, -0.080000, 0.000000, 3.000000, 6.000000, 1.000000, 1.000000, 1.000000);
			case 29:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19080, 6, 0.200000, 0.000000, 0.159999, 0.000000, -6.000000, -6.000000, 1.000000, 1.000000, 1.000000);
			case 30:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19080, 6, 0.200000, 0.010000, 0.089999, 0.000000, -3.000000, -5.000000, 1.000000, 1.000000, 1.000000);
			case 31:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19080, 6, 0.200000, 0.010000, 0.089999, 0.000000, -3.000000, -5.000000, 1.000000, 1.000000, 1.000000);
			case 32:
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19080, 6, 0.100000, 0.039999, 0.099999, 0.000000, -3.000000, -3.000000, 1.000000, 1.000000, 1.000000);
				SetPlayerAttachedObject(playerid,SLOT_LASER2, 19080, 5, 0.200000, 0.009999, -0.099999, 0.000000, 4.000000, 3.000000, 1.000000, 1.000000, 1.000000);
			case 33:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19080, 6, 0.300000, 0.010000, 0.109999, 0.000000, -9.000000, -6.800000, 1.000000, 1.000000, 1.000000);
			case 34:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19080, 6, -0.199999, 0.050000, 0.040000, 0.000000, -7.000000, -5.000000, 1.000000, 1.000000, 1.000000);
			case 35:
			 	RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid,SLOT_LASER, 19080, 6, -0.289999, 0.039999, 0.109999, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
			case 36:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid,SLOT_LASER, 19080, 6, -0.400000, 0.039999, 0.139999, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
			case 37:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19080, 6, 0.600000, 0.009999, 0.190000, 0.000000, -29.000000, -4.000000, 1.000000, 1.000000, 1.000000);
			case 38:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid,SLOT_LASER, 19080, 6, 0.400000, 0.029999, -0.009999, 0.000000, -29.000000, -4.000000, 1.000000, 1.000000, 1.000000);
			case 39..46:
				RemovePlayerAttachedObject(playerid, SLOT_LASER);
			    RemovePlayerAttachedObject(playerid, SLOT_LASER2);
	else if(LaserID[playerid] == 3)
	    switch(GetPlayerWeapon(playerid))
		    case 0..21:
				RemovePlayerAttachedObject(playerid, SLOT_LASER);
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
		    case 22:
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19081, 5, 0.140000, 0.019999, -0.090000, 0.000000, 7.000000, -3.000000, 1.000000, 1.000000, 1.000000);
				SetPlayerAttachedObject(playerid,SLOT_LASER2, 19081, 6, 0.100000, 0.029999, 0.090000, 0.000000, -9.000000, 3.000000, 1.000000, 1.000000, 1.000000);
			case 23:
			 	RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid,SLOT_LASER, 19081, 6, 0.100000, 0.029999, 0.079999, 0.000000, -10.000000, 4.000000, 1.000000, 1.000000, 1.000000);
			case 24:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19081, 6, 0.139999, 0.019999, 0.079999, 0.000000, 3.000000, 0.000000, 1.000000, 1.000000, 1.000000);
			case 25:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19081, 6, 0.400000, -0.000000, 0.110000, 0.000000, -9.000000, -6.000000, 1.000000, 1.000000, 1.000000);
			case 26:
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19081, 5, 0.389999, 0.019999, -0.119999, 0.000000, 5.000000, 2.000000, 1.000000, 1.000000, 1.000000);
				SetPlayerAttachedObject(playerid,SLOT_LASER2, 19081, 6, 0.299999, 0.019999, 0.119999, 0.000000, -6.000000, -1.000000, 1.000000, 1.000000, 1.000000);
			case 27:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid,SLOT_LASER, 19081, 6, 0.200000, 0.019999, 0.139999, 0.000000, -8.000000, -6.000000, 1.000000, 1.000000, 1.000000);
			case 28:
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19081, 6, -0.000000, 0.019999, 0.080000, 0.000000, -4.000000, -5.000000, 1.000000, 1.000000, 1.000000);
				SetPlayerAttachedObject(playerid,SLOT_LASER2, 19081, 5, 0.089999, 0.029999, -0.080000, 0.000000, 3.000000, 6.000000, 1.000000, 1.000000, 1.000000);
			case 29:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19081, 6, 0.200000, 0.000000, 0.159999, 0.000000, -6.000000, -6.000000, 1.000000, 1.000000, 1.000000);
			case 30:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19081, 6, 0.200000, 0.010000, 0.089999, 0.000000, -3.000000, -5.000000, 1.000000, 1.000000, 1.000000);
			case 31:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19081, 6, 0.200000, 0.010000, 0.089999, 0.000000, -3.000000, -5.000000, 1.000000, 1.000000, 1.000000);
			case 32:
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19081, 6, 0.100000, 0.039999, 0.099999, 0.000000, -3.000000, -3.000000, 1.000000, 1.000000, 1.000000);
				SetPlayerAttachedObject(playerid,SLOT_LASER2, 19081, 5, 0.200000, 0.009999, -0.099999, 0.000000, 4.000000, 3.000000, 1.000000, 1.000000, 1.000000);
			case 33:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19081, 6, 0.300000, 0.010000, 0.109999, 0.000000, -9.000000, -6.800000, 1.000000, 1.000000, 1.000000);
			case 34:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19081, 6, -0.199999, 0.050000, 0.040000, 0.000000, -7.000000, -5.000000, 1.000000, 1.000000, 1.000000);
			case 35:
			 	RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid,SLOT_LASER, 19081, 6, -0.289999, 0.039999, 0.109999, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
			case 36:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid,SLOT_LASER, 19081, 6, -0.400000, 0.039999, 0.139999, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
			case 37:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19081, 6, 0.600000, 0.009999, 0.190000, 0.000000, -29.000000, -4.000000, 1.000000, 1.000000, 1.000000);
			case 38:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid,SLOT_LASER, 19081, 6, 0.400000, 0.029999, -0.009999, 0.000000, -29.000000, -4.000000, 1.000000, 1.000000, 1.000000);
			case 39..46:
				RemovePlayerAttachedObject(playerid, SLOT_LASER);
			    RemovePlayerAttachedObject(playerid, SLOT_LASER2);
	else if(LaserID[playerid] == 4)
	    switch(GetPlayerWeapon(playerid))
		    case 0..21:
				RemovePlayerAttachedObject(playerid, SLOT_LASER);
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
		    case 22:
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19082, 5, 0.140000, 0.019999, -0.090000, 0.000000, 7.000000, -3.000000, 1.000000, 1.000000, 1.000000);
				SetPlayerAttachedObject(playerid,SLOT_LASER2, 19082, 6, 0.100000, 0.029999, 0.090000, 0.000000, -9.000000, 3.000000, 1.000000, 1.000000, 1.000000);
			case 23:
			 	RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid,SLOT_LASER, 19082, 6, 0.100000, 0.029999, 0.079999, 0.000000, -10.000000, 4.000000, 1.000000, 1.000000, 1.000000);
			case 24:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19082, 6, 0.139999, 0.019999, 0.079999, 0.000000, 3.000000, 0.000000, 1.000000, 1.000000, 1.000000);
			case 25:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19082, 6, 0.400000, -0.000000, 0.110000, 0.000000, -9.000000, -6.000000, 1.000000, 1.000000, 1.000000);
			case 26:
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19082, 5, 0.389999, 0.019999, -0.119999, 0.000000, 5.000000, 2.000000, 1.000000, 1.000000, 1.000000);
				SetPlayerAttachedObject(playerid,SLOT_LASER2, 19082, 6, 0.299999, 0.019999, 0.119999, 0.000000, -6.000000, -1.000000, 1.000000, 1.000000, 1.000000);
			case 27:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid,SLOT_LASER, 19082, 6, 0.200000, 0.019999, 0.139999, 0.000000, -8.000000, -6.000000, 1.000000, 1.000000, 1.000000);
			case 28:
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19082, 6, -0.000000, 0.019999, 0.080000, 0.000000, -4.000000, -5.000000, 1.000000, 1.000000, 1.000000);
				SetPlayerAttachedObject(playerid,SLOT_LASER2, 19082, 5, 0.089999, 0.029999, -0.080000, 0.000000, 3.000000, 6.000000, 1.000000, 1.000000, 1.000000);
			case 29:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19082, 6, 0.200000, 0.000000, 0.159999, 0.000000, -6.000000, -6.000000, 1.000000, 1.000000, 1.000000);
			case 30:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19082, 6, 0.200000, 0.010000, 0.089999, 0.000000, -3.000000, -5.000000, 1.000000, 1.000000, 1.000000);
			case 31:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19082, 6, 0.200000, 0.010000, 0.089999, 0.000000, -3.000000, -5.000000, 1.000000, 1.000000, 1.000000);
			case 32:
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19082, 6, 0.100000, 0.039999, 0.099999, 0.000000, -3.000000, -3.000000, 1.000000, 1.000000, 1.000000);
				SetPlayerAttachedObject(playerid,SLOT_LASER2, 19082, 5, 0.200000, 0.009999, -0.099999, 0.000000, 4.000000, 3.000000, 1.000000, 1.000000, 1.000000);
			case 33:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19082, 6, 0.300000, 0.010000, 0.109999, 0.000000, -9.000000, -6.800000, 1.000000, 1.000000, 1.000000);
			case 34:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19082, 6, -0.199999, 0.050000, 0.040000, 0.000000, -7.000000, -5.000000, 1.000000, 1.000000, 1.000000);
			case 35:
			 	RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid,SLOT_LASER, 19082, 6, -0.289999, 0.039999, 0.109999, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
			case 36:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid,SLOT_LASER, 19082, 6, -0.400000, 0.039999, 0.139999, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
			case 37:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19082, 6, 0.600000, 0.009999, 0.190000, 0.000000, -29.000000, -4.000000, 1.000000, 1.000000, 1.000000);
			case 38:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid,SLOT_LASER, 19082, 6, 0.400000, 0.029999, -0.009999, 0.000000, -29.000000, -4.000000, 1.000000, 1.000000, 1.000000);
			case 39..46:
				RemovePlayerAttachedObject(playerid, SLOT_LASER);
			    RemovePlayerAttachedObject(playerid, SLOT_LASER2);
	else if(LaserID[playerid] == 5)
	    switch(GetPlayerWeapon(playerid))
		    case 0..21:
				RemovePlayerAttachedObject(playerid, SLOT_LASER);
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
		    case 22:
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19083, 5, 0.140000, 0.019999, -0.090000, 0.000000, 7.000000, -3.000000, 1.000000, 1.000000, 1.000000);
				SetPlayerAttachedObject(playerid,SLOT_LASER2, 19083, 6, 0.100000, 0.029999, 0.090000, 0.000000, -9.000000, 3.000000, 1.000000, 1.000000, 1.000000);
			case 23:
			 	RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid,SLOT_LASER, 19083, 6, 0.100000, 0.029999, 0.079999, 0.000000, -10.000000, 4.000000, 1.000000, 1.000000, 1.000000);
			case 24:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19083, 6, 0.139999, 0.019999, 0.079999, 0.000000, 3.000000, 0.000000, 1.000000, 1.000000, 1.000000);
			case 25:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19083, 6, 0.400000, -0.000000, 0.110000, 0.000000, -9.000000, -6.000000, 1.000000, 1.000000, 1.000000);
			case 26:
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19083, 5, 0.389999, 0.019999, -0.119999, 0.000000, 5.000000, 2.000000, 1.000000, 1.000000, 1.000000);
				SetPlayerAttachedObject(playerid,SLOT_LASER2, 19083, 6, 0.299999, 0.019999, 0.119999, 0.000000, -6.000000, -1.000000, 1.000000, 1.000000, 1.000000);
			case 27:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid,SLOT_LASER, 19083, 6, 0.200000, 0.019999, 0.139999, 0.000000, -8.000000, -6.000000, 1.000000, 1.000000, 1.000000);
			case 28:
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19083, 6, -0.000000, 0.019999, 0.080000, 0.000000, -4.000000, -5.000000, 1.000000, 1.000000, 1.000000);
				SetPlayerAttachedObject(playerid,SLOT_LASER2, 19083, 5, 0.089999, 0.029999, -0.080000, 0.000000, 3.000000, 6.000000, 1.000000, 1.000000, 1.000000);
			case 29:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19083, 6, 0.200000, 0.000000, 0.159999, 0.000000, -6.000000, -6.000000, 1.000000, 1.000000, 1.000000);
			case 30:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19083, 6, 0.200000, 0.010000, 0.089999, 0.000000, -3.000000, -5.000000, 1.000000, 1.000000, 1.000000);
			case 31:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19083, 6, 0.200000, 0.010000, 0.089999, 0.000000, -3.000000, -5.000000, 1.000000, 1.000000, 1.000000);
			case 32:
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19083, 6, 0.100000, 0.039999, 0.099999, 0.000000, -3.000000, -3.000000, 1.000000, 1.000000, 1.000000);
				SetPlayerAttachedObject(playerid,SLOT_LASER2, 19083, 5, 0.200000, 0.009999, -0.099999, 0.000000, 4.000000, 3.000000, 1.000000, 1.000000, 1.000000);
			case 33:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19083, 6, 0.300000, 0.010000, 0.109999, 0.000000, -9.000000, -6.800000, 1.000000, 1.000000, 1.000000);
			case 34:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19083, 6, -0.199999, 0.050000, 0.040000, 0.000000, -7.000000, -5.000000, 1.000000, 1.000000, 1.000000);
			case 35:
			 	RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid,SLOT_LASER, 19083, 6, -0.289999, 0.039999, 0.109999, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
			case 36:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid,SLOT_LASER, 19083, 6, -0.400000, 0.039999, 0.139999, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
			case 37:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19083, 6, 0.600000, 0.009999, 0.190000, 0.000000, -29.000000, -4.000000, 1.000000, 1.000000, 1.000000);
			case 38:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid,SLOT_LASER, 19083, 6, 0.400000, 0.029999, -0.009999, 0.000000, -29.000000, -4.000000, 1.000000, 1.000000, 1.000000);
			case 39..46:
				RemovePlayerAttachedObject(playerid, SLOT_LASER);
			    RemovePlayerAttachedObject(playerid, SLOT_LASER2);
	else if(LaserID[playerid] == 6)
	    switch(GetPlayerWeapon(playerid))
		    case 0..21:
				RemovePlayerAttachedObject(playerid, SLOT_LASER);
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
		    case 22:
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19084, 5, 0.140000, 0.019999, -0.090000, 0.000000, 7.000000, -3.000000, 1.000000, 1.000000, 1.000000);
				SetPlayerAttachedObject(playerid,SLOT_LASER2, 19084, 6, 0.100000, 0.029999, 0.090000, 0.000000, -9.000000, 3.000000, 1.000000, 1.000000, 1.000000);
			case 23:
			 	RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid,SLOT_LASER, 19084, 6, 0.100000, 0.029999, 0.079999, 0.000000, -10.000000, 4.000000, 1.000000, 1.000000, 1.000000);
			case 24:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19084, 6, 0.139999, 0.019999, 0.079999, 0.000000, 3.000000, 0.000000, 1.000000, 1.000000, 1.000000);
			case 25:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19084, 6, 0.400000, -0.000000, 0.110000, 0.000000, -9.000000, -6.000000, 1.000000, 1.000000, 1.000000);
			case 26:
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19084, 5, 0.389999, 0.019999, -0.119999, 0.000000, 5.000000, 2.000000, 1.000000, 1.000000, 1.000000);
				SetPlayerAttachedObject(playerid,SLOT_LASER2, 19084, 6, 0.299999, 0.019999, 0.119999, 0.000000, -6.000000, -1.000000, 1.000000, 1.000000, 1.000000);
			case 27:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid,SLOT_LASER, 19084, 6, 0.200000, 0.019999, 0.139999, 0.000000, -8.000000, -6.000000, 1.000000, 1.000000, 1.000000);
			case 28:
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19084, 6, -0.000000, 0.019999, 0.080000, 0.000000, -4.000000, -5.000000, 1.000000, 1.000000, 1.000000);
				SetPlayerAttachedObject(playerid,SLOT_LASER2, 19084, 5, 0.089999, 0.029999, -0.080000, 0.000000, 3.000000, 6.000000, 1.000000, 1.000000, 1.000000);
			case 29:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19084, 6, 0.200000, 0.000000, 0.159999, 0.000000, -6.000000, -6.000000, 1.000000, 1.000000, 1.000000);
			case 30:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19084, 6, 0.200000, 0.010000, 0.089999, 0.000000, -3.000000, -5.000000, 1.000000, 1.000000, 1.000000);
			case 31:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19084, 6, 0.200000, 0.010000, 0.089999, 0.000000, -3.000000, -5.000000, 1.000000, 1.000000, 1.000000);
			case 32:
				SetPlayerAttachedObject(playerid,SLOT_LASER, 19084, 6, 0.100000, 0.039999, 0.099999, 0.000000, -3.000000, -3.000000, 1.000000, 1.000000, 1.000000);
				SetPlayerAttachedObject(playerid,SLOT_LASER2, 19084, 5, 0.200000, 0.009999, -0.099999, 0.000000, 4.000000, 3.000000, 1.000000, 1.000000, 1.000000);
			case 33:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19084, 6, 0.300000, 0.010000, 0.109999, 0.000000, -9.000000, -6.800000, 1.000000, 1.000000, 1.000000);
			case 34:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			    SetPlayerAttachedObject(playerid,SLOT_LASER, 19084, 6, -0.199999, 0.050000, 0.040000, 0.000000, -7.000000, -5.000000, 1.000000, 1.000000, 1.000000);
			case 35:
			 	RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid,SLOT_LASER, 19084, 6, -0.289999, 0.039999, 0.109999, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
			case 36:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid,SLOT_LASER, 19084, 6, -0.400000, 0.039999, 0.139999, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
			case 37:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
   				SetPlayerAttachedObject(playerid,SLOT_LASER, 19084, 6, 0.600000, 0.009999, 0.190000, 0.000000, -29.000000, -4.000000, 1.000000, 1.000000, 1.000000);
			case 38:
				RemovePlayerAttachedObject(playerid, SLOT_LASER2);
			 	SetPlayerAttachedObject(playerid,SLOT_LASER, 19084, 6, 0.400000, 0.029999, -0.009999, 0.000000, -29.000000, -4.000000, 1.000000, 1.000000, 1.000000);
			case 39..46:
				RemovePlayerAttachedObject(playerid, SLOT_LASER);
			    RemovePlayerAttachedObject(playerid, SLOT_LASER2);
    if(IsPlayerInBezDmZone(playerid) && !Player[playerid][Mod] && !Player[playerid][Admin1])
        SetPlayerArmedWeapon(playerid,0);
	return 1;
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
	if(response)
		PlayerPlaySound(playerid,1054,0.0,0.0,0.0);
	else
	    PlayerPlaySound(playerid,1055,0.0,0.0,0.0);
	A_CHAR(inputtext);
  
	if(dialogid == D_REGISTER && response)
        if(FindSQLInjection(inputtext))
	        SCM(playerid, C_WHITE, ""E" "W"Hasło nie może zawierać zapytań oraz znaków specjalnych!");
			return 1;
		if(strlen(inputtext) < 4 || strlen(inputtext) > 32)
	        SCM(playerid, C_WHITE, ""E" "W"Hasło musi posiadać od 4 do 32 znaków.");
			SPD(playerid, D_REGISTER, DIALOG_STYLE_PASSWORD, "{00BFFF}Rejestracja "W"(1/2)", "Dziękujemy za poddanie konta rejestracji.\nPo rejestracji konta twoje staty będą zapisywane.\n\nPoniżej podaj swoje hasło:", "Rejestruj", "Zamknij");
			return 1;
		if(mysql_ping() == -1)
			mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
		GlobalUsers ++;
		new Query[470],String[470];
		format(Query, sizeof(Query),"INSERT INTO "PREFIX"Users VALUES ('%d','%s',MD5('%s'),'%d','%d','%d','%d','%d','%d','%d','%d','%d','0','%d','%d','0','0','0','%d','%d','%d','%d','%d','%d','-1','0','0','0','0','%d','0','0','0','0','0','0')",
		GlobalUsers,Player[playerid][Name],inputtext,Player[playerid][Exp],Player[playerid][Money],Player[playerid][Kills],Player[playerid][Deaths],Player[playerid][Suicides],Player[playerid][Row_Kills],Player[playerid][TimePlay],Player[playerid][Warns],Player[playerid][Mute],Player[playerid][Bank],
		Player[playerid][Kodow],GetPlayerSkin(playerid),Player[playerid][SoloScore],Player[playerid][OnedeScore],Player[playerid][MinigunScore],Player[playerid][RPGScore],Player[playerid][DriftScore],Player[playerid][CombatScore]);
		//21 - %d %s itd
		//35 - Global
		mysql_query(Query);
		Player[playerid][AID] = GlobalUsers;
       	format(String, sizeof(String), "Rejestracja przebiegła prawidłowo!\n\nNick: %s\nHasło: %s\n\nAID Konta: %d", Player[playerid][Name],inputtext,GlobalUsers);
		SPD(playerid, D_NONE, DIALOG_STYLE_MSGBOX, "{00BFFF}Rejestracja "W"(2/2)", String, "Zamknij", "");
		format(String,sizeof(String),""WI" {00E1FF}Mamy nowego zarejestrowanego gracza! "W"%s {00E1FF}- Witamy!",Player[playerid][Name]);
		SCMA(0x00E1FFFF, String);
		format(Query,sizeof(Query), "INSERT INTO "PREFIX"Achievements VALUES ('%s','0','0','0','0','0','0','0','0','0','0','%d','0','0','0','0','0','0','0','0','0','0','0','0','0')",Player[playerid][Name],Player[playerid][Kodow]);
        mysql_query(Query);
		Player[playerid][Registered] = true;
        Player[playerid][Logged] = true;
        Achievement(playerid, "aRegistered");
    if(dialogid == D_LOGIN && response)
        if(FindSQLInjection(inputtext))
	        SCM(playerid, C_WHITE, ""E" "W"Hasło nie może zawierać zapytań oraz znaków specjalnych!");
			return 1;
		new String[525],Query[525];
		if(strlen(inputtext) == 0)
			Player[playerid][BadPassword] --;
			if(Player[playerid][BadPassword] == 0)
                SCM(playerid, C_WHITE, ""I" "W"Zostałeś wyrzucony(a) z serwera za przekroczenie ilości błędnych logowań.");
				Panorama(playerid);
				Kick(playerid);
			SPD(playerid, D_LOGIN, DIALOG_STYLE_PASSWORD, "{00BFFF}Panel Logowania", ""W"To konto jest zarejestrowane na serwerze.\n\nAby na nim grać podaj hasło do konta:", "Zaloguj", "Anuluj");
			format(String,sizeof(String), ""E" "W"Podane hasło jest nieprawidłowe. Pozostało prób: "R"%d/4"W".",Player[playerid][BadPassword]);
		 	SCM(playerid, C_WHITE, String);
			return 1;
        if(strfind(MD5_Hash(inputtext), Player[playerid][Password],true) == 0)
		  	ResetPlayerMoney(playerid);
			if(Player[playerid][Money] <= 0)
				GivePlayerMoney(playerid, 25000);
                Player[playerid][Money] += 25000;
			else
				GivePlayerMoney(playerid, Player[playerid][Money]);
			Player[playerid][Logged] = true;
            Player[playerid][Exp] ++;
			if(Player[playerid][Level] < GetPlayerLevel(playerid))
				LevelUp(playerid);
            if(mysql_ping() == -1)
				mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
			if(Player[playerid][Skin] != 1)
                SCM(playerid, C_WHITE, ""I" "W"Możesz wczytać swojego zapisanego skina wpisując /MS.");
            
			SCM(playerid, C_WHITE, ""I" "W"Zostałeś(aś) poprawnie zalogowany(a)! Otrzymujesz punkt exp.");
            if(Player[playerid][pVeh] > 0)
				SetVehicleVirtualWorld(vInfo[Player[playerid][pVeh]][vID],0);
            if(GangAccountExists(Player[playerid][Name]))
				format(Query,sizeof(Query), "SELECT gID,gZapro FROM `"PREFIX"Gangi_Users` WHERE gMember='%s' LIMIT 1",Player[playerid][Name]);
				mysql_query(Query);
				mysql_store_result();
				mysql_fetch_row(String,"|");
				sscanf(String, "p<|>dd",Player[playerid][InGang],Player[playerid][gZapro]);
			if(AdminExists(Player[playerid][Name]))
	            format(Query, 255, "SELECT Level,Waznosc,Suspension FROM `"PREFIX"Admins` WHERE `Name`='%s' LIMIT 1", Player[playerid][Name]);
				mysql_query(Query);
				mysql_store_result();
				mysql_fetch_row(String,"|");
				sscanf(String, "p<|>ddd",Player[playerid][AdminLevel],Player[playerid][WaznoscAdmin],Player[playerid][SuspensionAdmin]);
			if(ModExists(Player[playerid][Name]))
	            format(Query, 255, "SELECT Waznosc,Suspension FROM `"PREFIX"Mods` WHERE `Name`='%s' LIMIT 1", Player[playerid][Name]);
				mysql_query(Query);
				mysql_store_result();
				mysql_fetch_row(String,"|");
				sscanf(String, "p<|>dd",Player[playerid][WaznoscMod],Player[playerid][SuspensionMod]);
			Query[0] = EOS;
            format(Query,sizeof(Query),"SELECT * FROM "PREFIX"Achievements WHERE Name='%s' LIMIT 1",Player[playerid][Name]);
			mysql_query(Query);
			mysql_store_result();
			mysql_fetch_row(String,"|");
			sscanf(String, "p<|>s[24]dddddddddddddddddddddddd",Player[playerid][Name],
			AchievementGet[playerid][aRegistered],AchievementGet[playerid][aTrofea],
			AchievementGet[playerid][aDoscTego],AchievementGet[playerid][aKask],AchievementGet[playerid][aJestemLepszy],
			AchievementGet[playerid][aJestemMistrzem],AchievementGet[playerid][aPilot],AchievementGet[playerid][a24Godziny],
			AchievementGet[playerid][aDoOstatniegoTchu],AchievementGet[playerid][aCelneOko],AchievementGet[playerid][aZwinnePalce],
			AchievementGet[playerid][aPodroznik],AchievementGet[playerid][aDrifter],AchievementGet[playerid][aKrolDriftu],
			AchievementGet[playerid][aStreetKing],AchievementGet[playerid][aNowaTozsamosc],AchievementGet[playerid][aDomownik],
			AchievementGet[playerid][aWlasne4],AchievementGet[playerid][aZzzz],AchievementGet[playerid][aWyborowy],
			AchievementGet[playerid][aKomandos],AchievementGet[playerid][aWedkarz],AchievementGet[playerid][aStalyGracz],
			AchievementGet[playerid][aPoszukiwacz]);
            mysql_free_result();
            if(Player[playerid][Onlined] <= 0)
	            SCM(playerid, C_WHITE,""I" "W"Otrzymałeś(aś) {FFA200}10 pkt exp "W"za dzisiejsze pierwsze wejście na serwer.");
				Player[playerid][Exp] += 10;
				if(Player[playerid][Level] < GetPlayerLevel(playerid))
					LevelUp(playerid);
				GameTextForPlayer(playerid,"~w~Exp + ~b~~h~10", 1000, 1);
				Player[playerid][Onlined] = 1;
				format(String,sizeof(String),"UPDATE "PREFIX"Users SET Onlined='1' WHERE Name='%s'",Player[playerid][Name]);
				mysql_query(String);
				Achievement(playerid,"aStalyGracz");
			if(Player[playerid][WaznoscPriv] > 0)
				if(Player[playerid][WaznoscPriv] != 5)
                    format(String,sizeof(String),"UPDATE "PREFIX"Users SET WaznoscPriv='5' WHERE Name='%s'",Player[playerid][Name]);
					mysql_query(String);
                Player[playerid][WaznoscPriv] = 5;
            if(Player[playerid][WaznoscMod] == 1 && Player[playerid][SuspensionMod] <= 0)
				SPD(playerid, D_NONE, DIALOG_STYLE_MSGBOX,"{00BFFF}Konto premium","Informujemy, iż ważność twojego konta premium (Moderator) wygaza za 1 dzień.","Zamknij","");
				Player[playerid][Mod] = true;
				format(String,sizeof(String),"{e53e00} *** {ac3e00}%s {e53e00}zalogował się na moderatora.",Player[playerid][Name]);
				SCMA(0xac3e00FF,String);
                SoundForAll(1133);
			else if(Player[playerid][WaznoscMod] > 0 && Player[playerid][SuspensionMod] <= 0)
                format(String,sizeof(String), "Informujemy, iż ważność twojego konta premium (Moderator) wygasa za %d dni.",Player[playerid][WaznoscMod]);
				SPD(playerid, D_NONE, DIALOG_STYLE_MSGBOX,"{00BFFF}Konto premium",String,"Zamknij","");
                Player[playerid][Mod] = true;
                format(String,sizeof(String),"{e53e00} *** {ac3e00}%s {e53e00}zalogował się na moderatora.",Player[playerid][Name]);
				SCMA(0xac3e00FF,String);
                SoundForAll(1133);
			else if(Player[playerid][WaznoscVip] == 1 && Player[playerid][SuspensionVip] <= 0)
                SPD(playerid, D_NONE, DIALOG_STYLE_MSGBOX,"{00BFFF}Konto premium","Informujemy, iż ważność twojego konta premium (VIP) wygaza za 1 dzień.","Zamknij","");
                Player[playerid][Vip] = true;
			else if(Player[playerid][WaznoscVip] > 0 && Player[playerid][SuspensionVip] <= 0)
                format(String,sizeof(String), "Informujemy, iż ważność twojego konta premium (VIP) wygasa za %d dni.",Player[playerid][WaznoscVip]);
				SPD(playerid, D_NONE, DIALOG_STYLE_MSGBOX,"{00BFFF}Konto premium",String,"Zamknij","");
                Player[playerid][Vip] = true;
		else
			Player[playerid][BadPassword] --;
			if(Player[playerid][BadPassword] == 0)
                SCM(playerid, C_WHITE, ""I" "W"Zostałeś wyrzucony(a) z serwera za przekroczenie ilości błędnych logowań.");
				Panorama(playerid);
				Kick(playerid);
			SPD(playerid, D_LOGIN, DIALOG_STYLE_PASSWORD, "{00BFFF}Panel Logowania", ""W"To konto jest zarejestrowane na serwerze.\n\nAby na nim grać podaj hasło do konta:", "Zaloguj", "Anuluj");
			format(String,sizeof(String), ""E" "W"Podane hasło jest nieprawidłowe. Pozostało prób: "R"%d/4"W".",Player[playerid][BadPassword]);
		 	SCM(playerid, C_WHITE, String);
        
	if(dialogid == D_SETNICK)
		if(response)
            if(FindSQLInjection(inputtext))
		        SCM(playerid, C_WHITE, ""E" "W"Nick nie może zawierać zapytań oraz znaków specjalnych!");
				return 1;
			if(strlen(inputtext) < 3 || strlen(inputtext) > 20)
		        SCM(playerid, C_WHITE, ""E" "W"Nick musi posiadać od 3 do 20 znaków.");
				SPD(playerid, D_SETNICK, DIALOG_STYLE_INPUT, "{00BFFF}Zmiana Nicku "W"(1/2)", "Aby zmienić swój nick na nowy\nWymyśl swój nick i wpisz go poniżej:", "Dalej", "Zamknij");
				return 1;
			if(!FindValidText(inputtext))
	            SCM(playerid, C_WHITE, ""E" "W"Nick nie może posiadać spacji oraz znaków specjalnych. Wyjątek: \"_\".");
	            
				SPD(playerid, D_SETNICK, DIALOG_STYLE_INPUT, "{00BFFF}Zmiana Nicku "W"(1/2)", "Aby zmienić swój nick na nowy\nWymyśl swój nick i wpisz go poniżej:", "Dalej", "Zamknij");
				return 1;
			if(AccountExists(inputtext))
	            SCM(playerid, C_WHITE, ""E" "W"Ten nick jest już zajęty! Podaj inny nick.");
	           
				SPD(playerid, D_SETNICK, DIALOG_STYLE_INPUT, "{00BFFF}Zmiana Nicku "W"(1/2)", "Aby zmienić swój nick na nowy\nWymyśl swój nick i wpisz go poniżej:", "Dalej", "Zamknij");
				return 1;
			format(Player[playerid][NewNick], MAX_PLAYER_NAME,inputtext);
			new String[100];
			format(String,sizeof(String), "Czy napewno chcesz zmienić nick na nowy?\n\nNowy nick: %s",inputtext);
			SPD(playerid, D_CONFIRM_SETNICK, DIALOG_STYLE_MSGBOX,"{00BFFF}Zmiana Nicku "W"(2/2)", String, "Tak","Cofnij");
	if(dialogid == D_CONFIRM_SETNICK)
		if(response)
			if(mysql_ping() == -1)
				mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
			Achievement(playerid, "aNowaTozsamosc");
            new String[512];
		   	format(String, sizeof(String), "UPDATE "PREFIX"Users SET Name='%s' WHERE Name='%s'", Player[playerid][NewNick], Player[playerid][Name]);
		   	mysql_query(String);
			format(String,sizeof(String), "UPDATE "PREFIX"Achievements SET Name='%s' WHERE Name='%s'",Player[playerid][NewNick], Player[playerid][Name]);
			mysql_query(String);
            mysql_free_result();
            Player[playerid][Nicked] = 5;
			if(Player[playerid][WaznoscAdmin] > 0)
                format(String, sizeof(String), "UPDATE "PREFIX"Admins SET Name='%s' WHERE Name='%s'", Player[playerid][NewNick], Player[playerid][Name]);
		   		mysql_query(String);
            if(Player[playerid][WaznoscVip] > 0)
                format(String, sizeof(String), "UPDATE "PREFIX"Vips SET Name='%s' WHERE Name='%s'", Player[playerid][NewNick], Player[playerid][Name]);
		   		mysql_query(String);
            if(Player[playerid][WaznoscMod] > 0)
                format(String, sizeof(String), "UPDATE "PREFIX"Mods SET Name='%s' WHERE Name='%s'", Player[playerid][NewNick], Player[playerid][Name]);
		   		mysql_query(String);
			if(Player[playerid][pVeh] != -1)
                format(String,sizeof(String),"UPDATE `"PREFIX"Vehicles` SET vOwner='%s' WHERE vOwner='%s'",Player[playerid][NewNick],Player[playerid][Name]);
				mysql_query(String);
				format(vInfo[Player[playerid][pVeh]][vOwner], MAX_PLAYER_NAME, Player[playerid][NewNick]);
                format(String,sizeof(String),"Właściciel: {9eae41}%s\n{c3c3c3}Przebieg: {9eae41}%.1f km.",vInfo[Player[playerid][pVeh]][vOwner],vInfo[Player[playerid][pVeh]][vPrzebieg]/1000.0);
            	Update3DTextLabelText(vInfo[Player[playerid][pVeh]][vLabel], 0xc3c3c3FF, String);
			if(Player[playerid][HouseOwn] != -1)
	            format(String,sizeof(String),"UPDATE "PREFIX"Houses SET hOwner='%s' WHERE hOwner='%s'",Player[playerid][NewNick],Player[playerid][Name]);
				mysql_query(String);
				format(hInfo[Player[playerid][HouseOwn]][hOwner],MAX_PLAYER_NAME,Player[playerid][NewNick]);
                format(String,sizeof(String),"%s\nWłaściciel: %s",hInfo[Player[playerid][HouseOwn]][hName],hInfo[Player[playerid][HouseOwn]][hOwner]);
				UpdateDynamic3DTextLabelText(hInfo[Player[playerid][HouseOwn]][hLabel], 0xFFB400FF, String);
			if(IsPlayerInAnyGang(playerid))
				format(String,sizeof(String),"UPDATE "PREFIX"Gangi_Users SET gMember='%s' WHERE gMember='%s'",Player[playerid][NewNick],Player[playerid][Name]);
				mysql_query(String);
				if(IsPlayerGangSzef(playerid))
					format(String,sizeof(String),"UPDATE "PREFIX"Gangi SET gSzef='%s' WHERE gSzef='%s'",Player[playerid][NewNick],Player[playerid][Name]);
					mysql_query(String);
					format(gInfo[Player[playerid][InGang]][gSzef],32,Player[playerid][NewNick]);
                if(IsPlayerGangVice(playerid))
					format(String,sizeof(String),"UPDATE "PREFIX"Gangi SET gVice='%s' WHERE gVice='%s'",Player[playerid][NewNick],Player[playerid][Name]);
					mysql_query(String);
					format(gInfo[Player[playerid][InGang]][gVice],32,Player[playerid][NewNick]);
            for(new x=0;x<MAX_BIZNES;x++)
                if(strcmp(Player[playerid][Name],bInfo[x][bOwner])==0)
					format(bInfo[x][bOwner],MAX_PLAYER_NAME,Player[playerid][NewNick]);
					format(String,sizeof(String),"UPDATE "PREFIX"Biznesy SET bOwner='%s' WHERE bID='%d'",Player[playerid][NewNick],x);
					mysql_query(String);
					format(String,sizeof(String),"[BIZNES]\n{61C900}%s - %d$\nWłaściciel: %s",bInfo[x][bName],bInfo[x][bCash],Player[playerid][NewNick]);
					UpdateDynamic3DTextLabelText(bInfo[x][bLabel], 0xFFFFFFFF, String);
			format(String,sizeof(String), ""I" "W"Gracz %s zmienił(a) swój nick na %s.",Player[playerid][Name],Player[playerid][NewNick]);
			SCMA(C_WHITE,String);
            format(Player[playerid][Name],MAX_PLAYER_NAME,Player[playerid][NewNick]);
            SavePlayer(playerid);
            for(new i=0; i<101; i++)
				SCM(playerid,0x000000AA, " ");
            format(String,sizeof(String), ""I" "W"Staty przeniesione. Wejdź na serwer pod nowym nickiem: %s",Player[playerid][NewNick]);
			SCM(playerid, C_WHITE, String);
		    Kick(playerid);
        
		else
			SPD(playerid, D_SETNICK, DIALOG_STYLE_INPUT, "{00BFFF}Zmiana Nicku "W"(1/2)", "Aby zmienić swój nick na nowy\nWymyśl swój nick i wpisz go poniżej:", "Dalej", "Zamknij");
    if(dialogid == D_SETPASS)
		if(response)
            if(FindSQLInjection(inputtext))
		        SCM(playerid, C_WHITE, ""E" "W"Hasło nie może zawierać zapytań oraz znaków specjalnych!");
				return 1;
			if(strlen(inputtext) < 3 || strlen(inputtext) > 24)
		        SCM(playerid, C_WHITE, ""E" "W"Hasło musi posiadać od 3 do 24 znaków.");
				SPD(playerid, D_SETPASS, DIALOG_STYLE_PASSWORD, "{00BFFF}Zmiana Hasła "W"(1/2)", "Aby zmienić hasło do swojego konta\nWymyśl swoje hasło po czym wpisz je poniżej:", "Dalej", "Zamknij");
				return 1;
			if(!FindValidText(inputtext))
	            SCM(playerid, C_WHITE, ""E" "W"Hasło nie może posiadać spacji oraz znaków specjalnych. Wyjątek: \"_\".");
	            
				SPD(playerid, D_SETPASS, DIALOG_STYLE_PASSWORD, "{00BFFF}Zmiana Hasła "W"(1/2)", "Aby zmienić hasło do swojego konta\nWymyśl swoje hasło po czym wpisz je poniżej:", "Dalej", "Zamknij");
				return 1;
			Player[playerid][NewPass][0] = EOS;
			format(Player[playerid][NewPass], 32,inputtext);
			new String[100];
			format(String,sizeof(String), "Czy napewno chcesz zmienić hasło na nowe?\n\nNowe hasło: %s",inputtext);
			SPD(playerid, D_CONFIRM_SETPASS, DIALOG_STYLE_MSGBOX,"{00BFFF}Zmiana Hasła "W"(2/2)", String, "Tak","Cofnij");
	if(dialogid == D_CONFIRM_SETPASS)
		if(response)
			if(mysql_ping() == -1)
				mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
			new String[255];
		   	format(String, sizeof(String), "UPDATE "PREFIX"Users SET Password=MD5('%s') WHERE Name='%s'", Player[playerid][NewPass], Player[playerid][Name]);
		   	mysql_query(String);
            mysql_free_result();
			format(String,sizeof(String), ""I" "W"Twoje hasło zostało automatycznie zmienione! Nowe hasło: %s.",Player[playerid][NewPass]);
			SCM(playerid, C_WHITE, String);
			Player[playerid][Password][0] = EOS;
            format(Player[playerid][Password],32,Player[playerid][NewPass]);
        
		else
			SPD(playerid, D_SETPASS, DIALOG_STYLE_PASSWORD, "{00BFFF}Zmiana Hasła "W"(1/2)", "Aby zmienić hasło do swojego konta\nWymyśl swoje hasło po czym wpisz je poniżej:", "Dalej", "Zamknij");
    if(dialogid == D_RCON)
	    if(response)
	        if(strlen(inputtext) == 0)
	            SCM(playerid, C_WHITE, ""E" "W"Podano błędne hasło!");
                SPD(playerid, D_RCON, DIALOG_STYLE_PASSWORD, "{00BFFF}Panel "R"RCON", "Aby zalogować się na konto administratorskie [RCON]\nnależy znać hasło dostępu.\n\nPoniżej podaj hasło administratorskie [RCON]:", "Zaloguj", "Kick");
				return 1;
			if(strfind(MD5_Hash(inputtext),RconPass,true) == 0)
			    CheckRconAdmin(playerid);
			else
			    SPD(playerid, D_RCON, DIALOG_STYLE_PASSWORD, "{00BFFF}Panel "R"RCON", "Aby zalogować się na konto administratorskie [RCON]\nnależy znać hasło dostępu.\n\nPoniżej podaj hasło administratorskie [RCON]:", "Zaloguj", "KICK");
                SCM(playerid, C_WHITE, ""E" "W"Podano błędne hasło!");
		if(!response)
			Kick(playerid);
	if(dialogid == D_ACMD)
		if(response)
			switch(listitem)
				case 0:
	                if(!Player[playerid][Admin1] && !Player[playerid][Admin2] && !IsPlayerAdmin(playerid))
						SCM(playerid, C_ERROR, ""WE" "R"Nie posiadasz do tego uprawnień!");
                        Player[playerid][UsedPomoc] = false;
						return 1;
					new string[2200];
					strcat(string,""R"/Kick [ID] [Powód] "W"- Wyrzucasz gracza z serwera.\n");
					strcat(string,""R"/Ban [ID] [Powód] "W"- Banujesz gracza z serwera.\n");
					strcat(string,""R"/Warn [ID] [Powód] "W"- Dajesz ostrzeżenie graczowi.\n");
     				strcat(string,""R"/WarnKick [ID] [Powód] "W"- Dajesz ostrzeżenie graczowi na kick.\n");
					strcat(string,""R"/Mute [ID] [Czas(min)] [Powód] "W"- Uciszasz gracza.\n");
					strcat(string,""R"/UnMute [ID] "W"- Odciszasz gracza.\n");
					strcat(string,""R"/aGod "W"- Dajesz sobie goda.\n");
					strcat(string,""R"/M "W"- Uzdrawiasz się.\n");
					strcat(string,""R"/Armor "W"- Dodajesz sobie kamizelkę.\n");
					strcat(string,""R"/Spec [ID] "W"- Podglądasz gracza.\n");
                    strcat(string,""R"/SpecOff "W"- Wyłączasz podgląd gracza.\n");
					strcat(string,""R"/Explode [ID] "W"- Wysadzasz gracza.\n");
					strcat(string,""R"/Slap [ID] "W"- Odebierasz 10 HP graczowi.\n");
					strcat(string,""R"/Raports "W"- Sprawdzasz raporty.\n");
					strcat(string,""R"/Heal [ID] "W"- Uzdrawiasz gracza.\n");
					strcat(string,""R"/ArmorID [ID] "W"- Dajesz kamizelkę.\n");
					strcat(string,""R"/AsWeapons "W"- Zestaw broni admina.\n");
					strcat(string,""R"/GiveCash [ID] "W"- Dajesz kasę.\n");
					strcat(string,""R"/SetCash [ID] "W"- Zmieniasz komuś ilość kasy.\n");
	   				strcat(string,""R"/ResetCash [ID] "W"- Resetujesz graczu pieniądze.\n");
					strcat(string,""R"/Ann [Czas] [Tekst] "W"- Ogłoszenie na środku ekranu.\n");
					strcat(string,""R"/Jetpack [ID] "W"- Dajesz komuś jetpacka.\n");
					strcat(string,""R"/Weather [ID_Pogody] "W"- Zmieniasz pogodę serwera.\n");
					strcat(string,""R"/SetTime [Godzina] "W"- Zmieniasz godzinę na serwerze.\n");
					strcat(string,""R"/Jail [ID] [Czas(min)] [Powód] "W"- Dajesz do więzienia.\n");
					strcat(string,""R"/UnJail [ID] "W"- Uwalniasz gracza z więzienia.\n");
	   				strcat(string,""R"/A [Tekst] "W"- Piszesz na Admin-Chat.\n");
			    	strcat(string,""R"/TP [ID] [Do_ID] "W"- Teleportujesz graczy.\n");
			    	strcat(string,""R"/TH [ID] "W"- Teleportujesz gracza do siebie.\n");
			    	strcat(string,""R"/TT [ID] "W"- Teleportujesz się do gracza.\n");
	                strcat(string,""R"/UnBan [Nick] "W"- Odbanowujesz gracza.\n");
					strcat(string,""R"/DowningP [ID] [Wysokość] "W"- Obniżasz gracza.\n");
					SPD(playerid,D_ACMD_1,0,"{00BFFF}Komendy Admina "W"1/2",string,"Dalej","Cofnij");
				case 1:
	                if(!Player[playerid][Admin2] && !IsPlayerAdmin(playerid))
						SCM(playerid, C_ERROR, ""WE" "R"Nie posiadasz do tego uprawnień!");
                        Player[playerid][UsedPomoc] = false;
						return 1;
					new string[900];
			    	strcat(string,""R"/God [ID] "W"- Dajesz goda graczowi.\n");
	                strcat(string,""R"/GodAll "W"- Dajesz wszystkim goda.\n");
	                strcat(string,""R"/GiveExp [ID] [Ilość] "W"- Dajesz graczowi exp.\n");
	                strcat(string,""R"/SetExp [ID] [Ilość] "W"- Zmieniasz exp graczowi.\n");
	                strcat(string,""R"/GiveExpAll [Ilość] "W"- Dajesz exp wszystkim.\n");
	                strcat(string,""R"/GiveExp50 [Ilość] "W"- Dajesz exp graczom w promieniu 50 metrów.\n");
	                strcat(string,""R"/VehGod [ID] "W"- Robisz komuś niezniszczalny pojazd.\n");
	                strcat(string,""R"/VehGodAll "W"- Robisz wszystkim niezniszczalny pojazd.\n");
	                strcat(string,""R"/Tp50Here "W"- Teleportujesz graczy w promieniu 50 metrów do siebie.\n");
	                strcat(string,""R"/DisarmAll "W"- Rozbrajasz wszystkich.\n");
	                strcat(string,""R"/GiveCashAll [Kwota] "W"- Dajesz wszystkim kase.\n");
	                strcat(string,""R"/HealAll "W"- Uzdrawiasz wszystkich.\n");
	                strcat(string,""R"/ArmorAll "W"- Dajesz wszystkim kamizelkę.\n");
                    strcat(string,""R"/UnWarn [ID] "W"- Zdejmujesz ostrzeżenie graczowi.\n");
                    strcat(string,""R"/ClickMap "W"- Kliknięcie na mapie powoduje teleportację.\n");
					SPD(playerid,D_ACMD_2,0,"{00BFFF}Komendy Admina",string,"Zamknij","Cofnij");
				case 2:
	                if(!IsPlayerAdmin(playerid))
						SCM(playerid, C_ERROR, ""WE" "R"Nie posiadasz do tego uprawnień!");
                        Player[playerid][UsedPomoc] = false;
						return 1;
					new string[2000];
			    	strcat(string,""R"/SetVip [ID] [Ważność(dni)] "W"- Dajesz graczu vipa.\n");
	                strcat(string,""R"/SetMod [ID] [Ważność(dni)] "W"- Dajesz graczu moderatora.\n");
	                strcat(string,""R"/SetAdmin [ID] [Level] [Ważność(dni)] "W"- Dajesz graczu admina.\n");
	                strcat(string,""R"/SuspensionVip [ID] [Czas(dni)] "W"- Zawieszasz graczu vipa.\n");
	                strcat(string,""R"/SuspensionMod [ID] [Czas(dni)] "W"- Zawieszasz graczu moderatora.\n");
	                strcat(string,""R"/SuspensionAdmin [ID] [Czas(dni)] "W"- Zawieszasz graczu admina.\n");
	                strcat(string,""R"/DegradeVip [ID] "W"- Zabierasz graczu vipa.\n");
	                strcat(string,""R"/DegradeMod [ID] "W"- Zabierasz graczu moderatora.\n");
	                strcat(string,""R"/DegradeAdmin [ID] "W"- Zabierasz graczu admina.\n");
                    strcat(string,""R"/GivePortfel [ID] [Kwota] "W"- Zasilasz graczu Wirtualny Portfel.\n");
					strcat(string,""R"/Rcon GMX "W"- Robisz restart serwera.\n");
	                strcat(string,""R"/Rcon SAY [Tekst] "W"- Piszesz jako server-admin.\n");
                    strcat(string,""R"/MaxPing [Ilośc] "W"- Zmieniasz maksymalny ping.\n");
	                strcat(string,""R"/SetAdminPass [Hasło] "W"- Zmieniasz hasło administratorskie.\n");
                    strcat(string,""R"/SetRconPass [Hasło] "W"- Zmieniasz 2 hasło rcon.\n");
                    strcat(string,""R"/OnlineAdmin [ID] "W"- Logujesz gracza tymczasowo na LVL 1.\n");
					strcat(string,""R"/OnlineVip [ID] "W"- Logujesz gracza tymczasowo na vipa.\n");
	                strcat(string,""R"/OnlineMod [ID] "W"- Logujesz gracza tymczasowo na moderatora.\n");
                    strcat(string,""R"/OnlineAdminOff [ID] "W"- Odebierasz graczu admina lvl 1 online.\n");
	                strcat(string,""R"/OnlineVipOff [ID] "W"- Odebierasz vipa tymczasowo.\n");
                    strcat(string,""R"/OnlineModOff [ID] "W"- Odebierasz moderatora tymczasowo.\n");
                    strcat(string,""R"/NewHouse "W"- Tworzysz domek.\n");
                    strcat(string,""R"/DelHouse "W"- Usuwasz domek (Tylko w pickupie domku).\n");
                    strcat(string,""R"/DelPriv "W"- Usuwasz prywatny pojazd (Tylko w pojeździe).\n");
                    strcat(string,""R"/Logi "W"- Sprawdzasz logi serwera.\n");
					SPD(playerid,D_ACMD_3,0,"{00BFFF}Komendy Admina",string,"Zamknij","Cofnij");
		else
			if(Player[playerid][UsedPomoc])
                SPD(playerid, D_POMOC, DIALOG_STYLE_LIST, "{00BFFF}Pomoc", "› Komendy gracza\n"GUI2"› Komendy admina\n"W"› Komendy moderatora\n"GUI2"› Informacje o koncie VIP\n"W"› Teleporty\n"GUI2"› Atrakcje\n"W"› Animacje\n"GUI2"› Autorzy GameModa\n"W"› Panel TextDrawów\n"GUI2"› Regulamin\n"W"› Poradnik o serwerze","Wybierz","Zamknij");
	if(dialogid == D_ACMD_1)
		if(response)
            new string[1700];
            strcat(string,""R"/Downing [Wysokość] "W"- Obniżasz się.\n");
            strcat(string,""R"/Uping [Wysokość] "W"- Podnosisz się.\n");
            strcat(string,""R"/UpingP [ID] [Wysokość] "W"- Podnosisz gracza.\n");
			strcat(string,""R"/SetWorld [ID] [ID VW] "W"- Zmieniasz graczu Virtual-World.\n");
            strcat(string,""R"/Acolor [ID] [ID Koloru] "W"- Zmieniasz komuś kolor nicku.\n");
			strcat(string,""R"/SetIp [ID] [Interior] "W"- Zmieniasz graczu Interior.\n");
			strcat(string,""R"/Repair [ID] "W"- Naprawiasz graczu pojazd.\n");
			strcat(string,""R"/Walizka [Kasa] [Podpowiedź] "W"- Stawiasz walizkę.\n");
            strcat(string,""R"/Podkowa [Kasa] [Podpowiedź] "W"- Stawiasz podkowę.\n");
            strcat(string,""R"/Prezent [Podpowiedź] - Stawiasz prezent.\n");
			strcat(string,""R"/SkinP [ID] "W"- Zmieniasz graczu skina.\n");
			strcat(string,""R"/Freeze [ID] "W"- Zamrażasz gracza.\n");
			strcat(string,""R"/UnFreeze [ID] "W"- Odmrażasz gracza.\n");
			strcat(string,""R"/CD [Sekundy] [Zamrożenie] "W"- Startujesz odliczanie.\n");
			strcat(string,""R"/aVehGod "W"- Robisz swój pojazd nieśmiertelnym.\n");
			strcat(string,""R"/StopCD "W"- Zakańczasz odliczanie.\n");
			strcat(string,""R"/DA50 "W"- Rozbrajasz w promieniu 50 metrów.\n");
			strcat(string,""R"/Disarm [ID] "W"- Rozbrajasz gracza.\n");
			strcat(string,""R"/Heal50 "W"- Uzdrawiasz w promieniu 50 metrów.\n");
			strcat(string,""R"/Armor50 "W"- Dajesz kamizelkę w promieniu 50 metrów.\n");
			strcat(string,""R"/GiveExp "W"- Dajesz exp.\n");
			strcat(string,""R"/SetRoom [ID] [Room] "W"- Zmieniasz room graczu (Przydatne dla obcokrajowców).\n");
			strcat(string,""R"/aWaznosc "W"- Sprawdzasz ważność konta premium.\n");
			strcat(string,""R"/SpecSN /SpecSNOff "W"- Włączasz/Wyłączasz specowanie sianka.\n");
			SPD(playerid,D_ACMD_1_2,0,"Komendy Admina "W"2/2",string,"Zamknij","Cofnij");
		else
            if(Player[playerid][UsedPomoc])
	            SPD(playerid, D_ACMD, DIALOG_STYLE_LIST, "{00BFFF}Komendy Admina", "› Komendy poziomu 1\n"GUI2"› Komendy poziomu 2\n"W"› Komendy poziomu 3","Wybierz","Cofnij");
			else
				SPD(playerid, D_ACMD, DIALOG_STYLE_LIST, "{00BFFF}Komendy Admina", "› Komendy poziomu 1\n"GUI2"› Komendy poziomu 2\n"W"› Komendy poziomu 3","Wybierz","Zamknij");
	if(dialogid == D_ACMD_1_2)
		if(response)
            Player[playerid][UsedPomoc] = false;
		else
			new string[2200];
			strcat(string,""R"/Kick [ID] [Powód] "W"- Wyrzucasz gracza z serwera.\n");
			strcat(string,""R"/Ban [ID] [Powód] "W"- Banujesz gracza z serwera.\n");
			strcat(string,""R"/Warn [ID] [Powód] "W"- Dajesz ostrzeżenie graczowi.\n");
			strcat(string,""R"/Mute [ID] [Czas(min)] [Powód] "W"- Uciszasz gracza.\n");
			strcat(string,""R"/UnMute [ID] "W"- Odciszasz gracza.\n");
			strcat(string,""R"/aGod "W"- Dajesz sobie goda.\n");
			strcat(string,""R"/M "W"- Uzdrawiasz się.\n");
			strcat(string,""R"/Armor "W"- Dodajesz sobie kamizelkę.\n");
			strcat(string,""R"/Spec [ID] "W"- Podglądasz gracza.\n");
	        strcat(string,""R"/SpecOff "W"- Wyłączasz podgląd gracza.\n");
			strcat(string,""R"/Explode [ID] "W"- Wysadzasz gracza.\n");
			strcat(string,""R"/Slap [ID] "W"- Odebierasz 10 HP graczowi.\n");
			strcat(string,""R"/Raports "W"- Sprawdzasz raporty.\n");
			strcat(string,""R"/Heal [ID] "W"- Uzdrawiasz gracza.\n");
			strcat(string,""R"/ArmorID [ID] "W"- Dajesz kamizelkę.\n");
			strcat(string,""R"/AsWeapons "W"- Zestaw broni admina.\n");
			strcat(string,""R"/GiveCash [ID] "W"- Dajesz kasę.\n");
			strcat(string,""R"/SetCash [ID] "W"- Zmieniasz komuś ilość kasy.\n");
			strcat(string,""R"/ResetCash [ID] "W"- Resetujesz graczu pieniądze.\n");
			strcat(string,""R"/Ann [Czas] [Tekst] "W"- Ogłoszenie na środku ekranu.\n");
			strcat(string,""R"/Jetpack [ID] "W"- Dajesz komuś jetpacka.\n");
			strcat(string,""R"/Weather [ID_Pogody] "W"- Zmieniasz pogodę serwera.\n");
			strcat(string,""R"/SetTime [Godzina] "W"- Zmieniasz godzinę na serwerze.\n");
			strcat(string,""R"/Jail [ID] [Czas(min)] [Powód] "W"- Dajesz do więzienia.\n");
			strcat(string,""R"/UnJail [ID] "W"- Uwalniasz gracza z więzienia.\n");
			strcat(string,""R"/A [Tekst] "W"- Piszesz na Admin-Chat.\n");
	    	strcat(string,""R"/TP [ID] [Do_ID] "W"- Teleportujesz graczy.\n");
	    	strcat(string,""R"/TH [ID] "W"- Teleportujesz gracza do siebie.\n");
	    	strcat(string,""R"/TT [ID] "W"- Teleportujesz się do gracza.\n");
	        strcat(string,""R"/UnBan [Nick] "W"- Odbanowujesz gracza.\n");
			strcat(string,""R"/DowningP [ID] [Wysokość] "W"- Obniżasz gracza.\n");
			SPD(playerid,D_ACMD_1,0,"{00BFFF}Komendy Admina "W"1/2",string,"Dalej","Cofnij");
	if(dialogid == D_ACMD_2)
		if(response)
            Player[playerid][UsedPomoc] = false;
		else
			if(Player[playerid][UsedPomoc])
	            SPD(playerid, D_ACMD, DIALOG_STYLE_LIST, "{00BFFF}Komendy Admina", "› Komendy poziomu 1\n"GUI2"› Komendy poziomu 2\n"W"› Komendy poziomu 3","Wybierz","Cofnij");
			else
				SPD(playerid, D_ACMD, DIALOG_STYLE_LIST, "{00BFFF}Komendy Admina", "› Komendy poziomu 1\n"GUI2"› Komendy poziomu 2\n"W"› Komendy poziomu 3","Wybierz","Zamknij");
    if(dialogid == D_ACMD_3 && !response)
		if(response)
            Player[playerid][UsedPomoc] = false;
		else
			if(Player[playerid][UsedPomoc])
	            SPD(playerid, D_ACMD, DIALOG_STYLE_LIST, "{00BFFF}Komendy Admina", "› Komendy poziomu 1\n"GUI2"› Komendy poziomu 2\n"W"› Komendy poziomu 3","Wybierz","Cofnij");
			else
				SPD(playerid, D_ACMD, DIALOG_STYLE_LIST, "{00BFFF}Komendy Admina", "› Komendy poziomu 1\n"GUI2"› Komendy poziomu 2\n"W"› Komendy poziomu 3","Wybierz","Zamknij");
	if(dialogid == D_POMOC)
		if(response)
			Player[playerid][UsedPomoc] = true;
			switch(listitem)
				case 0:
                    new string[2100];
					strcat(string,"{44a428}/Teles "W"- Lista teleportów serwera.\n");
					strcat(string,"{44a428}/Atrakcje "W"- Lista Atrakcji serwera.\n");
					strcat(string,"{44a428}/Regulamin "W"- Wyświetla regulamin serwera.\n");
					strcat(string,"{44a428}/CarDive "W"- Wystrzeliwujesz w górę pojazd i spadasz.\n");
					strcat(string,"{44a428}/100hp "W"- Uzdrawiasz się kosztem 2500$.\n");
					strcat(string,"{44a428}/Armour "W"- Kupujesz kamizelkę kosztem 3000$.\n");
					strcat(string,"{44a428}/Cars "W"- Lista pojazdów do zrespawnowania.\n");
					strcat(string,"{44a428}/Dotacja "W"- Otrzymujesz jednorazowo 250.000$\n");
					strcat(string,"{44a428}/NRG "W"- Otrzymujesz prywatny NRG-500.\n");
					strcat(string,"{44a428}/Kill "W"- Popełniasz samobójstwo.\n");
					strcat(string,"{44a428}/Tune /TuneMenu "W"- Tuning pojazdu.\n");
					strcat(string,"{44a428}/Flip "W"- Ustawiasz pojazd na koła.\n");
					strcat(string,"{44a428}/ZW /JJ "W"- Informujesz graczy o swoim statusie.\n");
					strcat(string,"{44a428}/Siema /Nara /Czesc /Witam /Pa "W"- Wiadomo...\n");
					strcat(string,"{44a428}/Napraw "W"- Naprawiasz swój pojazd.\n");
					strcat(string,"{44a428}/SP /LP "W"- Zapisujesz / Wczytujesz pozycję.\n");
					strcat(string,"{44a428}/SavePos /Telpos "W"- Chwilowe Teleporty.\n");
					strcat(string,"{44a428}/Raport [ID] [Powód] "W"- Raportujesz gracza.\n");
					strcat(string,"{44a428}/Odlicz "W"- Włączasz odliczanie.\n");
					strcat(string,"{44a428}/Pogoda "W"- Zmieniasz swoją pogodę.\n");
					strcat(string,"{44a428}/StyleWalki "W"- Lista styli walki.\n");
					strcat(string,"{44a428}/Rozbroj "W"- Rozbrajasz się.\n");
					strcat(string,"{44a428}/Autor "W"- Informacje o autorze GameModa.\n");
					strcat(string,"{44a428}/Vip "W"- Informacje o koncie premium (VIP).\n");
					strcat(string,"{44a428}/Skin [ID Skina] "W"- Zmieniasz swój skin.\n");
					strcat(string,"{44a428}/KolorAuto "W"- Zmieniasz na losowy kolor auta.\n");
				    strcat(string,"{44a428}/Pos "W"- Sprawdzasz swoją pozycję na mapie.\n");
					strcat(string,"{44a428}/Statystyki "W"- Wyświetla statystyki.\n");
					strcat(string,"{44a428}/C4 /Zdetonuj "W"- Podkładasz C4 / Detonujesz C4.\n");
					strcat(string,"{44a428}/GiveCash [ID] [Kwota] "W"- Oddajesz kasę.\n");
					strcat(string,"{44a428}/Hitman [ID] [Kwota] "W"- Wystawiasz zlecenie.\n");
					strcat(string,"{44a428}/Bounty [ID] "W"- Sprawdzasz nagrodę za głowę.\n");
					strcat(string,"{44a428}/Admins /Vips /Mods "W"- Lista premium OnLine.\n");
					strcat(string,"{44a428}/PM [ID] [Treść] "W"- Wysyłasz prywatną wiadomość.\n");
					strcat(string,"{44a428}/Lock /Unlock "W"- Kontrola drzwi pojazdu.\n");
					strcat(string,"{44a428}/Dystans [ID] "W"- Sprawdzasz dystans gracza do ciebie.\n");
					strcat(string,"{44a428}/Skok [500-20000] "W"- Skaczesz z nieba.\n");
					SPD(playerid,D_CMDS_1,0,"{00BFFF}Komendy Gracza",string,"Dalej","Zamknij");
					SPD(playerid,D_CMDS_1,0,"{00BFFF}Komendy Gracza",string,"Zamknij","Cofnij");
				case 1:
	                SPD(playerid, D_ACMD, DIALOG_STYLE_LIST, "{00BFFF}Komendy Admina", "› Komendy poziomu 1\n"GUI2"› Komendy poziomu 2\n"W"› Komendy poziomu 3","Wybierz","Cofnij");
				case 2:
					if(!Player[playerid][Mod] && !Player[playerid][Admin1])
						SCM(playerid, C_ERROR, ""WE" "R"Nie posiadasz do tego uprawnień!");
                        Player[playerid][UsedPomoc] = false;
						return 1;
					new string[920];
					strcat(string,""G"/Kick [ID] "W"- Wyrzucasz gracza z serwera.\n");
					strcat(string,""G"/Explode [ID] "W"- Wysadzasz gracza.\n");
					strcat(string,""G"/Spec [ID] "W"- Podglądasz gracza.\n");
				    strcat(string,""G"/SpecOff  "W"- Wyłączasz podgląd gracza.\n");
					strcat(string,""G"/Heal [ID] "W"- Uzdrawiasz gracza.\n");
					strcat(string,""G"/ArmorID [ID] "W"- Dajesz graczu kamizelkę.\n");
					strcat(string,""G"/SetTime [Godzina] "W"- Zmieniasz godzinę na serwerze.\n");
					strcat(string,""G"/Weather [ID Pogody] "W"- Zmieniasz pogodę na serwerze.\n");
					strcat(string,""G"/Repair [ID] "W"- Naprawiasz pojazd graczowi.\n");
					strcat(string,""G"/Remove [ID] "W"- Wyrzucasz gracza z pojazdu.\n");
                    strcat(string,""G"/Podkowa [Kasa] [Podpowiedź] "W"- Stawiasz podkowę.\n");
                    strcat(string,""G"/Prezent [Podpowiedź] "W"- Stawiasz prezent.\n");
					strcat(string,""G"/SetIP [ID] [Interior] "W"- Zmieniasz interior gracza.\n");
					strcat(string,""G"/SetWorld [ID] [Virtual World] "W"- Zmieniasz VirtualWorld gracza.\n");
                    strcat(string,""G"/CZ "W"- Czyścisz cały czat.\n");
                    strcat(string,""G"/mGod "W"- Nieśmiertelność.\n");
                    strcat(string,""G"/mWaznosc "W"- Ważność konta premium.\n");
                    strcat(string,""G"/Reports "W"- Lista raportów zgłaszanych przez graczy.\n");
                    
					SPD(playerid,D_MCMD,0,"{00BFFF}Komendy "G"Moderatora",string,"Zamknij","Cofnij");
				case 3:
                    SPD(playerid, D_VIP, DIALOG_STYLE_LIST, "{00BFFF}Konto "Y"VIP", "› Kupno konta premium\n"GUI2"› Komendy konta premium\n"W"› Informacje o koncie premium","Wybierz","Cofnij");
				case 4:
                    new string[1200];
					strcat(string,""W"Teleporty Główne\n\n");
					strcat(string,"{44a428}/LSLot   /SFLot   /LVLot\n");
					strcat(string,"/LS   /LV   /SF\n");
					strcat(string,"/Wojsko   /Wojsko2   /G1-4\n");
					strcat(string,"/SilowniaLS   /SilowniaSF   /SilowniaLV\n");
					strcat(string,"/PeronLS   /PeronSF   /PeronLV\n");
					strcat(string,"/CentrumLS   /CentrumSF   /CentrumLV\n");
					strcat(string,"/BS1-9   /CB1-10   /Pizzeria1-10\n");
					strcat(string,"/SzkolaJazdy1-4   /Binco1-4   /Zip1-4\n");
					strcat(string,"/SzpitalLS   /SzpitalSF   /SzpitalLV\n");
					strcat(string,"/BurdelLS   /BurdelSF   /BurdelLV\n");
					strcat(string,"/TuneLS   /TuneSF   /TuneLV\n\n");
					strcat(string,""W"Teleporty na wsie i miasteczka\n\n");
					strcat(string,"{44a428}/PalomimoCreek   /MontGomery   /Dillimore\n");
					strcat(string,"/BlueBerry   /AngelPine   /FortCarson\n");
					strcat(string,"/LasBarrancas   /LasPayasadas   /ElCastillo\n");
					strcat(string,"/ElQuelbrados   /BaySide   /BoneCountry\n\n");
					strcat(string,""W"Inne teleporty\n\n");
					strcat(string,"{44a428}/Molo   /Wiezowiec   /SkatePark\n");
					strcat(string,"/Osiedle1-5   /Tama   /OdLudzie\n");
					strcat(string,"/Salon   /Kosciol   /Gora\n");
					strcat(string,"/Plaza   /PlazaSF   /PGR\n");
					strcat(string,"/Bagno   /Statek   /FourDragons\n");
					strcat(string,"/Skok1-8   /Drift1-7   /Dirt\n");
					strcat(string,"/Piramida   /Pustynia   /Willa\n");
					strcat(string,"/CPN   /AmmuNation   /Emmet\n\n");
					strcat(string,""W"Teleporty do wnętrz\n\n");
					strcat(string,"{44a428}/RCShop   /CJGarage   /Calligula\n");
					strcat(string,"/WoozieBed   /WOC   /JaysDin\n");
					strcat(string,"/TSDin   /WH   /WH2\n");
					strcat(string,"/Bar   /Restauracja   /Andromeda\n");
					strcat(string,"/Lot   /Lot2   /ViceStadium\n");
					strcat(string,"/DirtBike   /KSS   /DemolotionDerby\n\n");
					strcat(string,""W"Teleporty na atrakcje znajdziesz pod komendą /Atrakcje.");
					SPD(playerid,D_TELES,0,"{00BFFF}Teleporty serwera",string,"Zamknij","Cofnij");
				case 5:
					new string[900];
					strcat(string,""W"Atrakcje Główne\n\n");
				    strcat(string,"{44a428}/nBronie   /Laser   /Neony   /Fryzura\n");
				    strcat(string,"/FPS   /Radio   /Teles   /Portfel\n");
				    strcat(string,"/Kod   /Pojazd   /DomPomoc   /Hitman\n");
				    strcat(string,"/Randka   /IdzDo   /Portfel   /Anims\n");
				    strcat(string,"/Losowanie   /HUD   /TuneMenu   /Tune\n");
					strcat(string,"/Auto   /Areny   /Lotto   /nBronie\n\n");
				    strcat(string,""W"Areny DeathMatch\n\n");
				    strcat(string,"{44a428}/Minigun   /RPG   /Onede   /Combat\n\n");
				    strcat(string,""W"Atrakcje obiektowe\n\n");
				    strcat(string,"{44a428}/Drift7   /Drift8   /Warsztat   /Woda\n");
				    strcat(string,"/Ziolo   /Tube   /SkyRoad   /Zjazd3\n");
				    strcat(string,"/Gora   /WaterLand   /PiPe   /Wodospad\n");
				    strcat(string,"/Stunt   /PKS   /PodWoda   /Tor2\n");
				    strcat(string,"/Lost   /Wyspa   /Baza   /Statek2\n");
				    strcat(string,"/Domek   /Odbij   /Impra1   /Szklo\n");
				    strcat(string,"/Impra2   /Impra3   /TorNrg1   /TorNrg2\n");
				    strcat(string,"/Kula   /FunPark   /Nascar    /SFLot\n");
				    strcat(string,"/MiniPort   /LS   /Bagno   /Basen\n");
				    strcat(string,"/Gokarty   /Lost   /Wyspa2   /Parkour\n");
				    strcat(string,"/Wyspa3   /Tor   /Zjazd   /Kulki\n");
				    strcat(string,"/Zjazd2   /Tokyo   /SkyDive   /Baza1-3\n");
                    strcat(string,"/Skocznia\n");
					SPD(playerid,D_ATRAKCJE,0,"{00BFFF}Atrakcje serwera",string,"Zamknij","Cofnij");
				case 6:
                    new string[810];
                    strcat(string,""W"Wszystkie animacje serwera:\n\n");
					strcat(string,"{44a428}/Rece     /Rece2    /Rece3    /Rece4 \n");
					strcat(string,"/Rece5    /Rece6    /Bar2     /Bar3 \n");
					strcat(string,"/Szafka   /Zegarek  /Lez      /Hide\n");
					strcat(string,"/Rzygaj   /Grubas   /Grubas2  /Taichi\n");
					strcat(string,"/Siadaj   /Chat     /Ratunku  /Kopniak\n");
					strcat(string,"/Dance    /Fucku    /Cellin   /Cellout\n");
					strcat(string,"/Pij      /Smoke    /Fsmoke   /Krzeslo\n");
					strcat(string,"/Krzeslo2 /Calus    /Trup     /Trup2\n");
					strcat(string,"/Wankin   /Wankout  /Deal     /Boks\n");
					strcat(string,"/Lol      /Bomba    /Aresztuj /Opalaj\n");
					strcat(string,"/Opalaj2  /Opalaj3  /Turlaj   /Klaps\n");
					strcat(string,"/Kradnij  /Kaleka   /Swat     /Swat2\n");
					strcat(string,"/Swat3    /Piwo     /Drunk    /Rap\n");
					strcat(string,"/Lookout  /Napad    /Papieros /Cpun\n");
					strcat(string,"/Cpun2    /Cpun3    /Cpun4    /Cpun5\n");
					strcat(string,"/Skok2    /Skok3    /Jedz     /Jedz2\n");
					strcat(string,"/Jedz3    /Wino     /Taniec   /Taniec2\n");
					strcat(string,"/Taniec3  /Taniec4  /Taniec5  /Taniec6\n");
					strcat(string,"/Taniec7  /Rolki    /Sprunk   /Inbedleft\n");
					strcat(string,"/Inbedright /Poddajsie  /Aresztowany  /Aresztuj2");
					SPD(playerid,D_ANIMS,0,"{00BFFF}Animacje Serwera",string,"Zamknij","Cofnij");
                case 7:
	                new string[600];
					strcat(string,""W"PL|GoldServer™ "VERSION"\n\n");
					strcat(string,"{44a428}Programista silnika: "W""AUTHOR_NICK"\n\n");
					strcat(string,"{44a428}Obiekter serwera: "W"Serek & Kajuss\n\n");
					strcat(string,"{44a428}Podziękowania dla autorów pluginów/include:\n\n");
					strcat(string,""W"StrickenKid {44a428}- MySQL plugin\n");
					strcat(string,""W"Y_Less {44a428}- Sscanf plugin & foreach\n");
					strcat(string,""W"ZeeX {44a428}- ZCMD\n");
					strcat(string,""W"Incognito {44a428}- Multi Streamer\n\n");
					strcat(string,""W"© GoldServer™ 2010 - 2013\n");
					strcat(string,""W"Wszelkie prawa zastrzeżone.\n");
					SPD(playerid,D_AUTHOR,0,"{00BFFF}O Autorach",string,"Zamknij","Cofnij");
				case 8:
					new string[500],PasekStan[45],LogoStan[45],PodpowiedziStan[45],ZegarStan[45],LicznikStan[45],ZapisyStan[45],allstan[45];
					if(Player[playerid][PasekON])
						format(PasekStan, sizeof(PasekStan), "› Pasek stanu {1DEB02}(ON)\n");
					else
						format(PasekStan, sizeof(PasekStan), ""W"› Pasek stanu {CC0E00}(OFF)\n");
					if(Player[playerid][LogoON])
						format(LogoStan, sizeof(LogoStan), ""W"› Logo serwera {1DEB02}(ON)\n");
					else
						format(LogoStan, sizeof(LogoStan), ""W"› Logo serwera {CC0E00}(OFF)\n");
					if(Player[playerid][PodpowiedziON])
						format(PodpowiedziStan, sizeof(PodpowiedziStan), ""W"› Podpowiedzi {1DEB02}(ON)\n");
					else
						format(PodpowiedziStan, sizeof(PodpowiedziStan), ""W"› Podpowiedzi {CC0E00}(OFF)\n");
					if(Player[playerid][ZegarON])
						format(ZegarStan, sizeof(ZegarStan), ""W"› Zegar {1DEB02}(ON)\n");
					else
						format(ZegarStan, sizeof(ZegarStan), ""W"› Zegar {CC0E00}(OFF)\n");
					if(Player[playerid][LicznikON])
						format(LicznikStan, sizeof(LicznikStan), ""W"› Licznik {1DEB02}(ON)\n");
					else
						format(LicznikStan, sizeof(LicznikStan), ""W"› Licznik {CC0E00}(OFF)\n");
					if(Player[playerid][ZapisyON])
						format(ZapisyStan, sizeof(ZapisyStan), ""W"› Tabela zapisów {1DEB02}(ON)\n");
					else
						format(ZapisyStan, sizeof(ZapisyStan), ""W"› Tabela zapisów {CC0E00}(OFF)\n");
				    if(Player[playerid][AllTD])
						format(allstan, sizeof(allstan), ""W"› Wszystkie {1DEB02}(ON)\n");
					else
						format(allstan, sizeof(allstan), ""W"› Wszystkie {CC0E00}(OFF)\n");
					strcat(string,PasekStan);
					strcat(string,LogoStan);
					strcat(string,PodpowiedziStan);
					strcat(string,ZegarStan);
					strcat(string,LicznikStan);
					strcat(string,ZapisyStan);
					strcat(string,allstan);
					SPD(playerid,D_PANELTD,DIALOG_STYLE_LIST,"{00BFFF}Panel TextDrawów",string,"Wybierz","Cofnij");
				case 9:
					new string[1150];
					strcat(string,""W"1. {44a428}Zabrania się podszywania/prób logowania na Admina/Moderatora.\n");
					strcat(string,""W"2. {44a428}Zakaz używania progamów ułatwiających grę (s0beit, v0lgez oraz mody CLEO które umożliwiają latanie itp.)\n");
					strcat(string,""W"3. {44a428}Wszelkie treści obraźliwe i rasistowskie będą karane.\n");
					strcat(string,""W"4. {44a428}Nie używaj wulgarnego słownictwa.\n");
					strcat(string,""W"5. {44a428}Zakaz reklamowania innych serwerów.\n");
					strcat(string,""W"6. {44a428}Zakaz floodowania, spamowania, bugowania.\n");
					strcat(string,""W"7. {44a428}HK, CK itp. za strefą śmierci zabronione! (/faq)\n");
				    strcat(string,""W"8. {44a428}Zabrania się reklamowania innych serwerów itp.\n");
				    strcat(string,""W"9. {44a428}Zakaz nieuczciwego zdobywania exp.\n");
				    strcat(string,""W"10. {44a428}Zakaz uciekania z więzennej wyspy.\n");
				    strcat(string,""W"11. {44a428}Zakaz przeszkadzania w zabawach zorganizowanych.\n");
				    strcat(string,""W"12. {44a428}Zakaz przeszkadzania w zabawach zorganizowanych.\n\n");
					strcat(string,""W"Nieznajomość regulaminu nie usprawiedliwia Cię.\n");
					strcat(string,""W"Wchodząc na serwer akceptujesz ustalone przez nas zasady.\n");
				    strcat(string,""W"Jeżeli ich nie czytałeś to twoja wina i zostaniesz ukarany nawet jeżeli łamałeś regulamin nieświadomie.\n\n");
					strcat(string,"{FF0000}Administracja zastrzega sobie prawo do zmiany regulaminu w każdej chwili.");
					SPD(playerid,D_REGULAMIN,0,"{00BFFF}Regulamin serwera",string,"Zamknij","Cofnij");
				case 10:
					cmd_tutorial(playerid);
		else
			Player[playerid][UsedPomoc] = false;
	if(dialogid == D_CMD)
		if(response)
            Player[playerid][UsedPomoc] = false;
		else
			SPD(playerid, D_POMOC, DIALOG_STYLE_LIST, "{00BFFF}Pomoc", "› Komendy gracza\n"GUI2"› Komendy admina\n"W"› Komendy moderatora\n"GUI2"› Informacje o koncie VIP\n"W"› Teleporty\n"GUI2"› Atrakcje\n"W"› Animacje\n"GUI2"› Autorzy GameModa\n"W"› Panel TextDrawów\n"GUI2"› Regulamin\n"W"› Poradnik o serwerze","Wybierz","Zamknij");
	if(dialogid == D_TELES)
		if(response)
            Player[playerid][UsedPomoc] = false;
		else
            SPD(playerid, D_POMOC, DIALOG_STYLE_LIST, "{00BFFF}Pomoc", "› Komendy gracza\n"GUI2"› Komendy admina\n"W"› Komendy moderatora\n"GUI2"› Informacje o koncie VIP\n"W"› Teleporty\n"GUI2"› Atrakcje\n"W"› Animacje\n"GUI2"› Autorzy GameModa\n"W"› Panel TextDrawów\n"GUI2"› Regulamin\n"W"› Poradnik o serwerze","Wybierz","Zamknij");
	if(dialogid == D_MCMD)
		if(response)
            Player[playerid][UsedPomoc] = false;
		else
            SPD(playerid, D_POMOC, DIALOG_STYLE_LIST, "{00BFFF}Pomoc", "› Komendy gracza\n"GUI2"› Komendy admina\n"W"› Komendy moderatora\n"GUI2"› Informacje o koncie VIP\n"W"› Teleporty\n"GUI2"› Atrakcje\n"W"› Animacje\n"GUI2"› Autorzy GameModa\n"W"› Panel TextDrawów\n"GUI2"› Regulamin\n"W"› Poradnik o serwerze","Wybierz","Zamknij");
	if(dialogid == D_ANIMS)
        if(response)
            Player[playerid][UsedPomoc] = false;
		else
            SPD(playerid, D_POMOC, DIALOG_STYLE_LIST, "{00BFFF}Pomoc", "› Komendy gracza\n"GUI2"› Komendy admina\n"W"› Komendy moderatora\n"GUI2"› Informacje o koncie VIP\n"W"› Teleporty\n"GUI2"› Atrakcje\n"W"› Animacje\n"GUI2"› Autorzy GameModa\n"W"› Panel TextDrawów\n"GUI2"› Regulamin\n"W"› Poradnik o serwerze","Wybierz","Zamknij");
	if(dialogid == D_VIP)
		if(response)
		    switch(listitem)
				case 0:
					for(new i = 0; i < 10; i++)
					    Kod[playerid][i] = Letters[random(60)];
					new String[380];
					format(String,sizeof(String),"Aby zakupić konto premium VIP:\n\n- Musisz posiadać w wirtualnym portfelu min. 5 zł\n\n"W"Portfel możesz doładować wpisując komendę /Portfel.\n\n"GUI"Poniżej znajduje się kod który musisz przepisać aby zakupić konto premium.\nPo kupnie z twojego portfela automatycznie ubędzie 5 zł.\nVip po kupnie jest ważny na 31 dni.\n\nKod do przepisania: {FFFFFF}%s",Kod[playerid]);
					SPD(playerid, D_KUPNO_VIP, DIALOG_STYLE_INPUT,"{00BFFF}Kupno "Y"VIP", String,"Zakup", "Cofnij");
				case 1:
					new string[1100];
					strcat(string,""Y"/vWaznosc "W"- Sprawdzasz ważność swojego konta VIP.\n");
					strcat(string,""Y"/vCar [Nazwa] "W"- Spawnujesz dowolny pojazd podając jego nazwę.\n");
                    strcat(string,""Y"/vJetpack "W"- Otrzymujesz jetpacka.\n");
                    strcat(string,""Y"/vGranaty "W"- Granaty dla vipa.\n");
					strcat(string,""Y"/vDotacja "W"- Otrzymujesz jednorazowo 1.000.000 $.\n");
					strcat(string,""Y"/vGiveCash [ID] [Kwota] "W"- Dajesz graczom kasę.\n");
					strcat(string,""Y"/vSetTime "W"- Zmieniasz godzinę na serwerze.\n");
					strcat(string,""Y"/vBron [ID Broni] [Ammo] "W"- Dostajesz broń.\n");
					strcat(string,""Y"/vListaBroni "W"- Lista broni dla vipa.\n");
					strcat(string,""Y"/vSay [Tekst] "W"- Piszesz na czacie jako vip.\n");
                    strcat(string,""Y"/vZestaw "W"- Prywatny zestaw broni dla VIP'a.\n");
					strcat(string,""Y"/Pmv "W"- Prywatny czat adminów i vipów.\n");
					strcat(string,""Y"/vRepair [ID] "W"- Naprawiasz graczowi pojazd.\n");
					strcat(string,""Y"/vColor "W"- Dajesz sobie żółty kolor nicku.\n");
					strcat(string,""Y"/vHeal [ID] "W"- Uzdrawiasz gracza.\n");
					strcat(string,""Y"/vArmor [ID] "W"- Dajesz graczowi kamizelkę.\n");
					strcat(string,""Y"/vTP [ID] [Do_ID] "W"- Teleportujesz graczy.\n");
					SPD(playerid,D_VCMD,0,"{00BFFF}Komendy "Y"Vipa",string,"Zamknij","Cofnij");
				case 2:
                    new string[810];
					strcat(string,""W"Konto premium "Y"(VIP) "W"to same korzyści!\n");
					strcat(string,"Dzięki niemu zyskujesz takie przywileje jak:\n\n");
					strcat(string,""Y"- "W"Nie tracisz exp za samobójstwo.\n");
                    strcat(string,""Y"- "W"Możesz zaparkować prywatny pojazd gdzie kolwiek chcesz!\n");
					strcat(string,""Y"- "W"Przeciwnicy otrzymują 2x więcej exp za twoje zabojstwo!\n");
                    strcat(string,""Y"- "W"Posiadasz zniżkę na zakup prywatnego pojazdu (500 exp).\n");
                    strcat(string,""Y"- "W"Na czacie jesteś wyróżniony specjalną rangą.\n");
                    strcat(string,""Y"- "W"Masz dostęp do tajnych dodatkowych komend.\n");
                    strcat(string,""Y"- "W"Masz szacunek od innych graczy.\n");
                    strcat(string,""Y"- "W"Nie musisz czekać 10 sekund na naprawę pojazdu.\n");
                    strcat(string,""Y"- "W"Możliwość posiadania plecaka rakietowego! (Jetpack).\n");
					SPD(playerid,D_VINFO,0,"{00BFFF}Vip "W"- Informacje",string,"Zamknij","Cofnij");
		else
            if(Player[playerid][UsedPomoc])
                SPD(playerid, D_POMOC, DIALOG_STYLE_LIST, "{00BFFF}Pomoc", "› Komendy gracza\n"GUI2"› Komendy admina\n"W"› Komendy moderatora\n"GUI2"› Informacje o koncie VIP\n"W"› Teleporty\n"GUI2"› Atrakcje\n"W"› Animacje\n"GUI2"› Autorzy GameModa\n"W"› Panel TextDrawów\n"GUI2"› Regulamin\n"W"› Poradnik o serwerze","Wybierz","Zamknij");
	if(dialogid == D_KUPNO_VIP)
		if(response)
            Player[playerid][UsedPomoc] = false;
			if(strlen(inputtext) == 0)
	            SCM(playerid, C_WHITE, ""E" "W"Podano błędny kod! Autoryzacja zakończona niepowodzeniem.");
                Kod[playerid][0] = EOS;
             
				return 1;
			if(strcmp(inputtext,Kod[playerid]) == 0)
    			Kod[playerid][0] = EOS;
				if(Player[playerid][Mod])
                    SCM(playerid, C_WHITE, ""E" "W"Nie możesz zakupić VIP'a, gdyż masz Moderatora!");
					return 1;
				if(Player[playerid][Portfel] < 5)
                    SCM(playerid, C_WHITE, ""E" "W"Zasil wirtualny portfel kwotą 5 zł! /Portfel > Doładuj Portfel.");
					return 1;
				PlayerBuyVip(playerid, 5, 31);
			else
                SCM(playerid, C_WHITE, ""E" "W"Podano błędny kod! Autoryzacja zakończona niepowodzeniem.");
		else
            SPD(playerid, D_VIP, DIALOG_STYLE_LIST, "{00BFFF}Konto "Y"VIP", "› Kupno konta premium\n"GUI2"› Komendy konta premium\n"W"› Informacje o koncie premium","Wybierz","Cofnij");
	if(dialogid == D_VCMD)
		if(response)
            Player[playerid][UsedPomoc] = false;
		else
            SPD(playerid, D_VIP, DIALOG_STYLE_LIST, "{00BFFF}Konto "Y"VIP", "› Kupno konta premium\n"GUI2"› Komendy konta premium\n"W"› Informacje o koncie premium","Wybierz","Cofnij");
    if(dialogid == D_VINFO)
		if(response)
            Player[playerid][UsedPomoc] = false;
		else
            SPD(playerid, D_VIP, DIALOG_STYLE_LIST, "{00BFFF}Konto "Y"VIP", "› Kupno konta premium\n"GUI2"› Komendy konta premium\n"W"› Informacje o koncie premium","Wybierz","Zamknij");
	if(dialogid == D_AUTHOR)
		if(response)
            Player[playerid][UsedPomoc] = false;
		else
            SPD(playerid, D_POMOC, DIALOG_STYLE_LIST, "{00BFFF}Pomoc", "› Komendy gracza\n"GUI2"› Komendy admina\n"W"› Komendy moderatora\n"GUI2"› Informacje o koncie VIP\n"W"› Teleporty\n"GUI2"› Atrakcje\n"W"› Animacje\n"GUI2"› Autorzy GameModa\n"W"› Panel TextDrawów\n"GUI2"› Regulamin\n"W"› Poradnik o serwerze","Wybierz","Zamknij");
    if(dialogid == D_ATRAKCJE)
		if(response)
            Player[playerid][UsedPomoc] = false;
		else
            SPD(playerid, D_POMOC, DIALOG_STYLE_LIST, "{00BFFF}Pomoc", "› Komendy gracza\n"GUI2"› Komendy admina\n"W"› Komendy moderatora\n"GUI2"› Informacje o koncie VIP\n"W"› Teleporty\n"GUI2"› Atrakcje\n"W"› Animacje\n"GUI2"› Autorzy GameModa\n"W"› Panel TextDrawów\n"GUI2"› Regulamin\n"W"› Poradnik o serwerze","Wybierz","Zamknij");
	if(dialogid == D_PANELTD)
		if(response)
			switch(listitem)
			    case 0:
					if(Player[playerid][PasekON])
						SCM(playerid, C_GREEN, ""WI" "G"Pasek stanu wyłączony!");
						Player[playerid][PasekON] = false;
						for(new x=0;x<13;x++)
							TextDrawHideForPlayer(playerid,PasekBox[x]);
					    TextDrawHideForPlayer(playerid,PasekStringGora);
					    TextDrawHideForPlayer(playerid,ExpTD[playerid]);
					    TextDrawHideForPlayer(playerid,LevelTD[playerid]);
					    TextDrawHideForPlayer(playerid,OnlineTD[playerid]);
					    TextDrawHideForPlayer(playerid,RatioTD[playerid]);
					    TextDrawHideForPlayer(playerid,PortfelTD[playerid]);
					    TextDrawHideForPlayer(playerid,WpiszVIPTD);
						TextDrawHideForPlayer(playerid,GraczeTD);
					else
                    	SCM(playerid, C_GREEN, ""WI" "G"Pasek stanu włączony!");
						Player[playerid][PasekON] = true;
                        for(new x=0;x<13;x++)
							TextDrawShowForPlayer(playerid,PasekBox[x]);
					    TextDrawShowForPlayer(playerid,PasekStringGora);
					    TextDrawShowForPlayer(playerid,ExpTD[playerid]);
					    TextDrawShowForPlayer(playerid,LevelTD[playerid]);
					    TextDrawShowForPlayer(playerid,OnlineTD[playerid]);
					    TextDrawShowForPlayer(playerid,RatioTD[playerid]);
					    TextDrawShowForPlayer(playerid,PortfelTD[playerid]);
				        TextDrawShowForPlayer(playerid,WpiszVIPTD);
						TextDrawShowForPlayer(playerid,GraczeTD);
				case 1:
                    if(Player[playerid][LogoON])
						SCM(playerid, C_GREEN, ""WI" "G"Logo serwera wyłączone!");
						Player[playerid][LogoON] = false;
					else
                    	SCM(playerid, C_GREEN, ""WI" "G"Logo serwera włączone!");
						Player[playerid][LogoON] = true;
						if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
				case 2:
                    if(Player[playerid][PodpowiedziON])
						SCM(playerid, C_GREEN, ""WI" "G"Podpowiedzi wyłączone!");
						Player[playerid][PodpowiedziON] = false;
					else
                    	SCM(playerid, C_GREEN, ""WI" "G"Podpowiedzi włączone!");
						Player[playerid][PodpowiedziON] = true;
                case 3:
                    if(Player[playerid][ZegarON]) 
						SCM(playerid, C_GREEN, ""WI" "G"Zegar i data wyłączony!");
						Player[playerid][ZegarON] = false;
						TextDrawHideForPlayer(playerid, CzasTD);
                        TextDrawHideForPlayer(playerid, DataTD);
					else
                    	SCM(playerid, C_GREEN, ""WI" "G"Zegar i data włączony!");
						Player[playerid][ZegarON] = true;
                        TextDrawShowForPlayer(playerid, CzasTD);
                        TextDrawShowForPlayer(playerid, DataTD);
				case 4:
                    if(Player[playerid][LicznikON]) 
						SCM(playerid, C_GREEN, ""WI" "G"Licznik wyłączony!");
						Player[playerid][LicznikON] = false;
                        for(new x=0;x<13;x++)
					        TextDrawHideForPlayer(playerid,LicznikBox[x]);
						TextDrawHideForPlayer(playerid,LicznikNazwa[playerid]);
    					TextDrawHideForPlayer(playerid,LicznikPredkosc[playerid]);
					else
                    	SCM(playerid, C_GREEN, ""WI" "G"Licznik włączony!");
						Player[playerid][LicznikON] = true;
						if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
							for(new x=0;x<13;x++)
						        TextDrawShowForPlayer(playerid,LicznikBox[x]);
							TextDrawShowForPlayer(playerid,LicznikNazwa[playerid]);
	    					TextDrawShowForPlayer(playerid,LicznikPredkosc[playerid]);
				case 5:
                    if(Player[playerid][ZapisyON]) 
						SCM(playerid, C_GREEN, ""WI" "G"Zapisy wyłączone!");
						Player[playerid][ZapisyON] = false;
                        TextDrawHideForPlayer(playerid, ZapisyString);
        				TextDrawHideForPlayer(playerid, ZapisyLiczba);
					else
                    	SCM(playerid, C_GREEN, ""WI" "G"Zapisy włączone!");
						Player[playerid][ZapisyON] = true;
                        TextDrawShowForPlayer(playerid, ZapisyString);
        				TextDrawShowForPlayer(playerid, ZapisyLiczba);
				case 6:
					if(Player[playerid][AllTD])
                        SCM(playerid, C_GREEN, ""WI" "G"Wszystkie TextDrawy wyłączone!");
                        Player[playerid][PasekON] = false;
                        for(new x=0;x<13;x++)
							TextDrawHideForPlayer(playerid,PasekBox[x]);
					    TextDrawHideForPlayer(playerid,PasekStringGora);
					    TextDrawHideForPlayer(playerid,ExpTD[playerid]);
					    TextDrawHideForPlayer(playerid,LevelTD[playerid]);
					    TextDrawHideForPlayer(playerid,OnlineTD[playerid]);
					    TextDrawHideForPlayer(playerid,RatioTD[playerid]);
					    TextDrawHideForPlayer(playerid,PortfelTD[playerid]);
					    TextDrawHideForPlayer(playerid,WpiszVIPTD);
						TextDrawHideForPlayer(playerid,GraczeTD);
						Player[playerid][AllTD] = false;
                        Player[playerid][LogoON] = false;
						Player[playerid][PodpowiedziON] = false;
                    
                        Player[playerid][ZegarON] = false;
						TextDrawHideForPlayer(playerid, CzasTD);
                        TextDrawHideForPlayer(playerid, DataTD);
						Player[playerid][LicznikON] = false;
						for(new x=0;x<13;x++)
      						TextDrawHideForPlayer(playerid,LicznikBox[x]);
						TextDrawHideForPlayer(playerid,LicznikNazwa[playerid]);
 						TextDrawHideForPlayer(playerid,LicznikPredkosc[playerid]);
						Player[playerid][ZapisyON] = false;
                        TextDrawHideForPlayer(playerid, ZapisyString);
        				TextDrawHideForPlayer(playerid, ZapisyLiczba);
                        Player[playerid][ZapisyON] = false;
                        TextDrawHideForPlayer(playerid, ZapisyString);
        				TextDrawHideForPlayer(playerid, ZapisyLiczba);
					else
                        SCM(playerid, C_GREEN, ""WI" "G"Wszystkie TextDrawy włączone!");
                        Player[playerid][PasekON] = true;
					    for(new x=0;x<13;x++)
							TextDrawShowForPlayer(playerid,PasekBox[x]);
					    TextDrawShowForPlayer(playerid,PasekStringGora);
					    TextDrawShowForPlayer(playerid,ExpTD[playerid]);
					    TextDrawShowForPlayer(playerid,LevelTD[playerid]);
					    TextDrawShowForPlayer(playerid,OnlineTD[playerid]);
					    TextDrawShowForPlayer(playerid,RatioTD[playerid]);
					    TextDrawShowForPlayer(playerid,PortfelTD[playerid]);
					    TextDrawShowForPlayer(playerid,WpiszVIPTD);
						TextDrawShowForPlayer(playerid,GraczeTD);
						Player[playerid][AllTD] = true;
						Player[playerid][PodpowiedziON] = true;
                   
                        Player[playerid][ZegarON] = true;
						TextDrawShowForPlayer(playerid, CzasTD);
                        TextDrawShowForPlayer(playerid, DataTD);
						Player[playerid][LicznikON] = true;
                        Player[playerid][LogoON] = true;
						if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
							for(new x=0;x<13;x++)
	      						TextDrawShowForPlayer(playerid,LicznikBox[x]);
							TextDrawShowForPlayer(playerid,LicznikNazwa[playerid]);
	 						TextDrawShowForPlayer(playerid,LicznikPredkosc[playerid]);
						else
						Player[playerid][ZapisyON] = true;
                        TextDrawShowForPlayer(playerid, ZapisyString);
        				TextDrawShowForPlayer(playerid, ZapisyLiczba);
                        Player[playerid][ZapisyON] = true;
                        TextDrawShowForPlayer(playerid, ZapisyString);
        				TextDrawShowForPlayer(playerid, ZapisyLiczba);
			cmd_paneltd(playerid);
		else
			if(Player[playerid][UsedPomoc])
				SPD(playerid, D_POMOC, DIALOG_STYLE_LIST, "{00BFFF}Pomoc", "› Komendy gracza\n"GUI2"› Komendy admina\n"W"› Komendy moderatora\n"GUI2"› Informacje o koncie VIP\n"W"› Teleporty\n"GUI2"› Atrakcje\n"W"› Animacje\n"GUI2"› Autorzy GameModa\n"W"› Panel TextDrawów\n"GUI2"› Regulamin\n"W"› Poradnik o serwerze","Wybierz","Zamknij");
	if(dialogid == D_KONTO && response)
		switch(listitem)
		    case 0:
				if(!Player[playerid][Registered])
			        return SCM(playerid, C_WHITE, ""E" "W"Musisz być zarejestrowany(a).");
				SPD(playerid, D_SETNICK, DIALOG_STYLE_INPUT, "{00BFFF}Zmiana Nicku "W"(1/2)", "Aby zmienić swój nick na nowy\nWymyśl swój nick i wpisz go poniżej:", "Dalej", "Zamknij");
		    case 1:
                if(!Player[playerid][Registered])
			        return SCM(playerid, C_WHITE, ""E" "W"Musisz być zarejestrowany(a).");
				SPD(playerid, D_SETPASS, DIALOG_STYLE_PASSWORD, "{00BFFF}Zmiana Hasła "W"(1/2)", "Aby zmienić hasło do swojego konta\nWymyśl swoje hasło po czym wpisz je poniżej:", "Dalej", "Zamknij");
		    case 2:
				cmd_osiagniecia(playerid);
		    case 3:
				ShowPlayerStats(playerid,playerid);
			case 4:
				if(Player[playerid][KaskON])
					Player[playerid][KaskON] = false;
                    SetPlayerAttachedObject(playerid,1,0,2,0.05,0.01,0.00,3.0,82.0,87.0,1.00,1.00,1.00);
					cmd_konto(playerid);
				else
                    Player[playerid][KaskON] = true;
					if(Player[playerid][OnBike] && !Player[playerid][Santa])
                        SetPlayerAttachedObject(playerid,1,18645,2,0.05,0.01,0.00,3.0,82.0,87.0,1.00,1.00,1.00);
						Achievement(playerid, "aKask");
					cmd_konto(playerid);
			case 5:
                if(Player[playerid][WlaczylRampy] >= 1)
					Player[playerid][WlaczylRampy] = false;
					cmd_konto(playerid);
				else
                    Player[playerid][WlaczylRampy] = 1;
                    cmd_konto(playerid);
			case 6:
                if(Player[playerid][AirON])
					Player[playerid][AirON] = false;
					cmd_konto(playerid);
				else
                    Player[playerid][AirON] = true;
                    cmd_konto(playerid);
			case 7:
                if(Player[playerid][TpVipON])
                    Player[playerid][TpVipON] = false;
                    cmd_konto(playerid);
					SCM(playerid, C_GREEN, ""WI" "G"Od teraz vipy nie mogą się do ciebie teleportować bez pytania.");
				else
                    Player[playerid][TpVipON] = true;
                    cmd_konto(playerid);
                    SCM(playerid, C_GREEN, ""WI" "G"Od teraz vipy mogą się do ciebie teleportować bez pytania.");
            case 8:
                if(Player[playerid][IdzdoON])
                    Player[playerid][IdzdoON] = false;
                    cmd_konto(playerid);
					SCM(playerid, C_GREEN, ""WI" "G"Od teraz gracze nie mogą do ciebie używać /idzdo.");
				else
                    Player[playerid][IdzdoON] = true;
                    cmd_konto(playerid);
                    SCM(playerid, C_GREEN, ""WI" "G"Od teraz gracze mogą do ciebie używać /idzdo.");
	if(dialogid == D_REGULAMIN)
		if(response)
            Player[playerid][UsedPomoc] = false;
		else
            SPD(playerid, D_POMOC, DIALOG_STYLE_LIST, "{00BFFF}Pomoc", "› Komendy gracza\n"GUI2"› Komendy admina\n"W"› Komendy moderatora\n"GUI2"› Informacje o koncie VIP\n"W"› Teleporty\n"GUI2"› Atrakcje\n"W"› Animacje\n"GUI2"› Autorzy GameModa\n"W"› Panel TextDrawów\n"GUI2"› Regulamin\n"W"› Poradnik o serwerze","Wybierz","Zamknij");
    if(dialogid == D_CARS && response)
	    switch(listitem)
		    case 0: SPD(playerid, D_SALONY, DIALOG_STYLE_LIST, "{00BFFF}Wybierz model pojazdu", "› Admiral\n› Bloodring Banger\n› Bravura\n› Buccaneer\n› Cadrona\n› Clover\n› Elegant\n› Elegy\n› Emperor\n› Esperanto\n› Fortune\n› Glendale Shit\n› Glendale\n› Greenwood\n› Hermes\n› Intruder\n› Majestic\n› Manana\n› Merit\n› Nebula\n› Oceanic\n› Premier\n› Previon\n› Primo\n› Sentinel\n› Stafford\n› Sultan\n› Sunrise\n› Tampa\n› Vincent\n› Virgo\n› Willard\n› Washington", "Wybierz", "Cofnij");
			case 1: SPD(playerid, D_MOTORY, DIALOG_STYLE_LIST, "{00BFFF}Wybierz model pojazdu", "› Faggio\n› Pizzaboy\n› BF-400\n› NRG-500\n› PCJ-600\n› FCR-900\n› HPV-1000\n› Freeway\n› Wayfarer\n› Sanchez\n› Quad", "Wybierz", "Cofnij");
		    case 2: SPD(playerid, D_ROWERY, DIALOG_STYLE_LIST, "{00BFFF}Wybierz model pojazdu", "› Rower\n› BMX\n› Rower Górski", "Wybierz", "Cofnij");
		    case 3: SPD(playerid, D_KABRIOLETY, DIALOG_STYLE_LIST, "{00BFFF}Wybierz model pojazdu", "› Comet\n› Feltzer\n› Stallion\n› Windsor", "Wybierz", "Cofnij");
		    case 4: SPD(playerid, D_DOSTAWCZE, DIALOG_STYLE_LIST, "{00BFFF}Wybierz model pojazdu", "› Benson\n› Bobcat\n› Buritto\n› Boxville\n› Boxburg\n› Cement Truck\n› DFT-30\n› Flatbed\n› Linerunner\n› Mule\n› Newsvan\n› Packer\n› Petrol Tanker\n› Picador\n› Pony\n› Roadtrain\n› Rumpo\n› Sadler\n› Sadler Shit\n› Topfun\n› Tractor\n› Trashmaster\n› Utility Van\n› Walton\n› Yankee\n› Yosemite", "Wybierz", "Cofnij");
		    case 5: SPD(playerid, D_LOWRIDERY, DIALOG_STYLE_LIST, "{00BFFF}Wybierz model pojazdu", "› Blade\n› Broadway\n› Remington\n› Savanna\n› Slamvan\n› Tahoma\n› Tornado\n› Voodoo", "Wybierz", "Cofnij");
            case 6: SPD(playerid, D_TERENOWE, DIALOG_STYLE_LIST, "{00BFFF}Wybierz model pojazdu", "› Bandito\n› BF Injection\n› Dune\n› Huntley\n› Landstalker\n› Mesa\n› Monster\n› Monster A\n› Monster B\n› Patriot\n› Rancher\n› Sandking", "Wybierz", "Cofnij");
            case 7: SPD(playerid, D_PUBLICZNE, DIALOG_STYLE_LIST, "{00BFFF}Wybierz model pojazdu", "› Ambulance\n› Barracks\n› Bus\n› Cabbie\n› Coach\n› Enforcer\n› FBI Rancher\n› FBI Truck\n› Firetruck\n› Firetruck LA\n› Police Car (LSPD)\n› Police Car (LVPD)\n› Police Car (SFPD)\n› Ranger\n› Rhino\n› Police Rhino\n› Taxi", "Wybierz", "Cofnij");
            case 8: SPD(playerid, D_SPORTOWE, DIALOG_STYLE_LIST, "{00BFFF}Wybierz model pojazdu", "› Alpha\n› Banshee\n› Blista Compact\n› Buffalo\n› Bullet\n› Cheetah\n› Club\n› Euros\n› Flash\n› Hotring A\n› Hotring B\n› Hotring C\n› Infernus\n› Jester\n› Phoenix\n› Sabre\n› Super GT\n› Turismo\n› Uranus\n› ZR-350", "Wybierz", "Cofnij");
            case 9: SPD(playerid, D_COMBI, DIALOG_STYLE_LIST, "{00BFFF}Wybierz model pojazdu", "› Moonbearn\n› Perenniel\n› Regina\n› Solair\n› Stratum", "Wybierz", "Cofnij");
            case 10: SPD(playerid, D_LODZIE, DIALOG_STYLE_LIST, "{00BFFF}Wybierz model pojazdu", "› Coastguard\n› Dinghy\n› Jetmax\n› Launch\n› Marquis\n› Predator\n› Reefer\n› Speeder\n› Squallo\n› Tropic", "Wybierz", "Cofnij");
            case 11: SPD(playerid, D_SAMOLOTY, DIALOG_STYLE_LIST, "{00BFFF}Wybierz model pojazdu", "› Andromada\n› AT-400\n› Beagle\n› Cropduster\n› Dodo\n› Nevada\n› Rustler\n› Shamal\n› Skimmel\n› Stuntplane\n› Cargobob\n› Hunter\n› Leviathan\n› Maverick\n› News Maverick\n› Police Maverick\n› Raindance\n› Seasparrow\n› Sparrow\n› Hydra", "Wybierz", "Cofnij");
            case 12: SPD(playerid, D_UNIKALNE, DIALOG_STYLE_LIST, "{00BFFF}Wybierz model pojazdu", "› Baggage\n› Caddy\n› Camper\n› Combine\n› Dozer\n› Dumper\n› Forklift\n› Hotknife\n› Hustler\n› HotDog\n› Journey\n› Kart\n› Mover\n› Mr Whoopee\n› Romero\n› Securicar\n› Stretch\n› Sweeper\n› Tram\n› Towtruck\n› Tug\n› Vortex", "Wybierz", "Cofnij");
            case 13: SPD(playerid, D_RC, DIALOG_STYLE_LIST, "{00BFFF}Wybierz model pojazdu", "› RC Bandit\n› RC Baron\n› RC Raider\n› RC Goblin\n› RC Tiger\n› RC Cam", "Wybierz", "Cofnij");
	if(dialogid == D_SALONY)
	    if(response)
	        switch(listitem)
				case 0: GivePlayerCar(playerid, 445);
                case 1: GivePlayerCar(playerid, 504);
                case 2: GivePlayerCar(playerid, 401);
                case 3: GivePlayerCar(playerid, 518);
                case 4: GivePlayerCar(playerid, 527);
                case 5: GivePlayerCar(playerid, 542);
                case 6: GivePlayerCar(playerid, 507);
                case 7: GivePlayerCar(playerid, 562);
                case 8: GivePlayerCar(playerid, 585);
                case 9: GivePlayerCar(playerid, 419);
                case 10: GivePlayerCar(playerid, 526);
                case 11: GivePlayerCar(playerid, 604);
                case 12: GivePlayerCar(playerid, 466);
                case 13: GivePlayerCar(playerid, 492);
                case 14: GivePlayerCar(playerid, 474);
                case 15: GivePlayerCar(playerid, 546);
                case 16: GivePlayerCar(playerid, 517);
                case 17: GivePlayerCar(playerid, 410);
                case 18: GivePlayerCar(playerid, 551);
                case 19: GivePlayerCar(playerid, 516);
                case 20: GivePlayerCar(playerid, 467);
                case 21: GivePlayerCar(playerid, 426);
                case 22: GivePlayerCar(playerid, 436);
                case 23: GivePlayerCar(playerid, 547);
                case 24: GivePlayerCar(playerid, 405);
                case 25: GivePlayerCar(playerid, 580);
                case 26: GivePlayerCar(playerid, 560);
                case 27: GivePlayerCar(playerid, 550);
                case 28: GivePlayerCar(playerid, 549);
                case 29: GivePlayerCar(playerid, 540);
                case 30: GivePlayerCar(playerid, 491);
                case 31: GivePlayerCar(playerid, 529);
                case 32: GivePlayerCar(playerid, 421);
		if(!response)
            SPD(playerid, D_CARS, DIALOG_STYLE_LIST, "{00BFFF}Wybierz typ pojazdu", "› Salony\n"GUI2"› Motory\n"W"› Rowery\n"GUI2"› Kabriolety\n"W"› Dostawcze\n"GUI2"› LowRidery\n"W"› Terenowe\n"GUI2"› Użyteczności publicznej\n"W"› Sportowe\n"GUI2"› Combi\n"W"› Łodzie\n"GUI2"› Samoloty/Helikoptery\n"W"› Unikalne\n"GUI2"› Zabawki RC", "Wybierz", "Anuluj");
	if(dialogid == D_MOTORY)
	    if(response)
	        switch(listitem)
				case 0: GivePlayerCar(playerid, 462);
                case 1: GivePlayerCar(playerid, 448);
                case 2: GivePlayerCar(playerid, 581);
                case 3: GivePlayerCar(playerid, 522);
                case 4: GivePlayerCar(playerid, 461);
                case 5: GivePlayerCar(playerid, 521);
                case 6: GivePlayerCar(playerid, 523);
                case 7: GivePlayerCar(playerid, 463);
                case 8: GivePlayerCar(playerid, 586);
                case 9: GivePlayerCar(playerid, 468);
                case 10: GivePlayerCar(playerid, 471);
		if(!response)
            SPD(playerid, D_CARS, DIALOG_STYLE_LIST, "{00BFFF}Wybierz typ pojazdu", "› Salony\n"GUI2"› Motory\n"W"› Rowery\n"GUI2"› Kabriolety\n"W"› Dostawcze\n"GUI2"› LowRidery\n"W"› Terenowe\n"GUI2"› Użyteczności publicznej\n"W"› Sportowe\n"GUI2"› Combi\n"W"› Łodzie\n"GUI2"› Samoloty/Helikoptery\n"W"› Unikalne\n"GUI2"› Zabawki RC", "Wybierz", "Anuluj");
	if(dialogid == D_ROWERY)
	    if(response)
	        switch(listitem)
				case 0: GivePlayerCar(playerid, 509);
                case 1: GivePlayerCar(playerid, 481);
                case 2: GivePlayerCar(playerid, 510);
		if(!response)
            SPD(playerid, D_CARS, DIALOG_STYLE_LIST, "{00BFFF}Wybierz typ pojazdu", "› Salony\n"GUI2"› Motory\n"W"› Rowery\n"GUI2"› Kabriolety\n"W"› Dostawcze\n"GUI2"› LowRidery\n"W"› Terenowe\n"GUI2"› Użyteczności publicznej\n"W"› Sportowe\n"GUI2"› Combi\n"W"› Łodzie\n"GUI2"› Samoloty/Helikoptery\n"W"› Unikalne\n"GUI2"› Zabawki RC", "Wybierz", "Anuluj");
	if(dialogid == D_KABRIOLETY)
	    if(response)
	        switch(listitem)
				case 0: GivePlayerCar(playerid, 480);
                case 1: GivePlayerCar(playerid, 533);
                case 2: GivePlayerCar(playerid, 439);
                case 3: GivePlayerCar(playerid, 555);
		if(!response)
            SPD(playerid, D_CARS, DIALOG_STYLE_LIST, "{00BFFF}Wybierz typ pojazdu", "› Salony\n"GUI2"› Motory\n"W"› Rowery\n"GUI2"› Kabriolety\n"W"› Dostawcze\n"GUI2"› LowRidery\n"W"› Terenowe\n"GUI2"› Użyteczności publicznej\n"W"› Sportowe\n"GUI2"› Combi\n"W"› Łodzie\n"GUI2"› Samoloty/Helikoptery\n"W"› Unikalne\n"GUI2"› Zabawki RC", "Wybierz", "Anuluj");
	if(dialogid == D_DOSTAWCZE)
	    if(response)
	        switch(listitem)
				case 0: GivePlayerCar(playerid, 499);
                case 1: GivePlayerCar(playerid, 422);
                case 2: GivePlayerCar(playerid, 482);
                case 3: GivePlayerCar(playerid, 498);
                case 4: GivePlayerCar(playerid, 609);
                case 5: GivePlayerCar(playerid, 524);
                case 6: GivePlayerCar(playerid, 578);
                case 7: GivePlayerCar(playerid, 455);
                case 8: GivePlayerCar(playerid, 403);
                case 9: GivePlayerCar(playerid, 414);
                case 10: GivePlayerCar(playerid, 582);
                case 11: GivePlayerCar(playerid, 443);
                case 12: GivePlayerCar(playerid, 514);
                case 13: GivePlayerCar(playerid, 600);
                case 14: GivePlayerCar(playerid, 413);
                case 15: GivePlayerCar(playerid, 515);
                case 16: GivePlayerCar(playerid, 440);
                case 17: GivePlayerCar(playerid, 543);
                case 18: GivePlayerCar(playerid, 605);
                case 19: GivePlayerCar(playerid, 459);
                case 20: GivePlayerCar(playerid, 531);
                case 21: GivePlayerCar(playerid, 408);
                case 22: GivePlayerCar(playerid, 552);
                case 23: GivePlayerCar(playerid, 478);
                case 24: GivePlayerCar(playerid, 456);
                case 25: GivePlayerCar(playerid, 554);
		if(!response)
            SPD(playerid, D_CARS, DIALOG_STYLE_LIST, "{00BFFF}Wybierz typ pojazdu", "› Salony\n"GUI2"› Motory\n"W"› Rowery\n"GUI2"› Kabriolety\n"W"› Dostawcze\n"GUI2"› LowRidery\n"W"› Terenowe\n"GUI2"› Użyteczności publicznej\n"W"› Sportowe\n"GUI2"› Combi\n"W"› Łodzie\n"GUI2"› Samoloty/Helikoptery\n"W"› Unikalne\n"GUI2"› Zabawki RC", "Wybierz", "Anuluj");
	if(dialogid == D_LOWRIDERY)
	    if(response)
	        switch(listitem)
				case 0: GivePlayerCar(playerid, 536);
                case 1: GivePlayerCar(playerid, 575);
                case 2: GivePlayerCar(playerid, 534);
                case 3: GivePlayerCar(playerid, 567);
                case 4: GivePlayerCar(playerid, 535);
                case 5: GivePlayerCar(playerid, 566);
                case 6: GivePlayerCar(playerid, 576);
                case 7: GivePlayerCar(playerid, 412);
		if(!response)
            SPD(playerid, D_CARS, DIALOG_STYLE_LIST, "{00BFFF}Wybierz typ pojazdu", "› Salony\n"GUI2"› Motory\n"W"› Rowery\n"GUI2"› Kabriolety\n"W"› Dostawcze\n"GUI2"› LowRidery\n"W"› Terenowe\n"GUI2"› Użyteczności publicznej\n"W"› Sportowe\n"GUI2"› Combi\n"W"› Łodzie\n"GUI2"› Samoloty/Helikoptery\n"W"› Unikalne\n"GUI2"› Zabawki RC", "Wybierz", "Anuluj");
	if(dialogid == D_TERENOWE)
	    if(response)
	        switch(listitem)
				case 0: GivePlayerCar(playerid, 568);
                case 1: GivePlayerCar(playerid, 424);
                case 2: GivePlayerCar(playerid, 573);
                case 3: GivePlayerCar(playerid, 579);
                case 4: GivePlayerCar(playerid, 400);
                case 5: GivePlayerCar(playerid, 500);
                case 6: GivePlayerCar(playerid, 444);
                case 7: GivePlayerCar(playerid, 556);
                case 8: GivePlayerCar(playerid, 557);
                case 9: GivePlayerCar(playerid, 470);
                case 10: GivePlayerCar(playerid, 489);
                case 11: GivePlayerCar(playerid, 495);
		if(!response)
            SPD(playerid, D_CARS, DIALOG_STYLE_LIST, "{00BFFF}Wybierz typ pojazdu", "› Salony\n"GUI2"› Motory\n"W"› Rowery\n"GUI2"› Kabriolety\n"W"› Dostawcze\n"GUI2"› LowRidery\n"W"› Terenowe\n"GUI2"› Użyteczności publicznej\n"W"› Sportowe\n"GUI2"› Combi\n"W"› Łodzie\n"GUI2"› Samoloty/Helikoptery\n"W"› Unikalne\n"GUI2"› Zabawki RC", "Wybierz", "Anuluj");
	if(dialogid == D_PUBLICZNE)
	    if(response)
	        switch(listitem)
				case 0: GivePlayerCar(playerid, 416);
                case 1: GivePlayerCar(playerid, 433);
                case 2: GivePlayerCar(playerid, 431);
                case 3: GivePlayerCar(playerid, 438);
                case 4: GivePlayerCar(playerid, 437);
                case 5: GivePlayerCar(playerid, 427);
                case 6: GivePlayerCar(playerid, 490);
                case 7: GivePlayerCar(playerid, 528);
                case 8: GivePlayerCar(playerid, 407);
                case 9: GivePlayerCar(playerid, 544);
                case 10: GivePlayerCar(playerid, 596);
                case 11: GivePlayerCar(playerid, 598);
                case 12: GivePlayerCar(playerid, 597);
                case 13: GivePlayerCar(playerid, 599);
                case 14: GivePlayerCar(playerid, 432);
                case 15: GivePlayerCar(playerid, 601);
                case 16: GivePlayerCar(playerid, 420);
		if(!response)
            SPD(playerid, D_CARS, DIALOG_STYLE_LIST, "{00BFFF}Wybierz typ pojazdu", "› Salony\n"GUI2"› Motory\n"W"› Rowery\n"GUI2"› Kabriolety\n"W"› Dostawcze\n"GUI2"› LowRidery\n"W"› Terenowe\n"GUI2"› Użyteczności publicznej\n"W"› Sportowe\n"GUI2"› Combi\n"W"› Łodzie\n"GUI2"› Samoloty/Helikoptery\n"W"› Unikalne\n"GUI2"› Zabawki RC", "Wybierz", "Anuluj");
	if(dialogid == D_SPORTOWE)
	    if(response)
	        switch(listitem)
				case 0: GivePlayerCar(playerid, 602);
                case 1: GivePlayerCar(playerid, 429);
                case 2: GivePlayerCar(playerid, 496);
                case 3: GivePlayerCar(playerid, 402);
                case 4: GivePlayerCar(playerid, 541);
                case 5: GivePlayerCar(playerid, 415);
                case 6: GivePlayerCar(playerid, 589);
                case 7: GivePlayerCar(playerid, 587);
                case 8: GivePlayerCar(playerid, 565);
                case 9: GivePlayerCar(playerid, 494);
                case 10: GivePlayerCar(playerid, 502);
                case 11: GivePlayerCar(playerid, 503);
                case 12: GivePlayerCar(playerid, 411);
                case 13: GivePlayerCar(playerid, 559);
                case 14: GivePlayerCar(playerid, 603);
                case 15: GivePlayerCar(playerid, 475);
                case 16: GivePlayerCar(playerid, 506);
                case 17: GivePlayerCar(playerid, 451);
                case 18: GivePlayerCar(playerid, 558);
                case 19: GivePlayerCar(playerid, 477);
		if(!response)
            SPD(playerid, D_CARS, DIALOG_STYLE_LIST, "{00BFFF}Wybierz typ pojazdu", "› Salony\n"GUI2"› Motory\n"W"› Rowery\n"GUI2"› Kabriolety\n"W"› Dostawcze\n"GUI2"› LowRidery\n"W"› Terenowe\n"GUI2"› Użyteczności publicznej\n"W"› Sportowe\n"GUI2"› Combi\n"W"› Łodzie\n"GUI2"› Samoloty/Helikoptery\n"W"› Unikalne\n"GUI2"› Zabawki RC", "Wybierz", "Anuluj");
	if(dialogid == D_COMBI)
	    if(response)
	        switch(listitem)
				case 0: GivePlayerCar(playerid, 418);
                case 1: GivePlayerCar(playerid, 404);
                case 2: GivePlayerCar(playerid, 479);
                case 3: GivePlayerCar(playerid, 458);
                case 4: GivePlayerCar(playerid, 561);
		if(!response)
            SPD(playerid, D_CARS, DIALOG_STYLE_LIST, "{00BFFF}Wybierz typ pojazdu", "› Salony\n"GUI2"› Motory\n"W"› Rowery\n"GUI2"› Kabriolety\n"W"› Dostawcze\n"GUI2"› LowRidery\n"W"› Terenowe\n"GUI2"› Użyteczności publicznej\n"W"› Sportowe\n"GUI2"› Combi\n"W"› Łodzie\n"GUI2"› Samoloty/Helikoptery\n"W"› Unikalne\n"GUI2"› Zabawki RC", "Wybierz", "Anuluj");
	if(dialogid == D_LODZIE)
	    if(response)
	        switch(listitem)
				case 0: GivePlayerCar(playerid, 472);
                case 1: GivePlayerCar(playerid, 473);
                case 2: GivePlayerCar(playerid, 493);
                case 3: GivePlayerCar(playerid, 595);
                case 4: GivePlayerCar(playerid, 484);
                case 5: GivePlayerCar(playerid, 430);
                case 6: GivePlayerCar(playerid, 453);
                case 7: GivePlayerCar(playerid, 452);
                case 8: GivePlayerCar(playerid, 446);
                case 9: GivePlayerCar(playerid, 454);
		if(!response)
            SPD(playerid, D_CARS, DIALOG_STYLE_LIST, "{00BFFF}Wybierz typ pojazdu", "› Salony\n"GUI2"› Motory\n"W"› Rowery\n"GUI2"› Kabriolety\n"W"› Dostawcze\n"GUI2"› LowRidery\n"W"› Terenowe\n"GUI2"› Użyteczności publicznej\n"W"› Sportowe\n"GUI2"› Combi\n"W"› Łodzie\n"GUI2"› Samoloty/Helikoptery\n"W"› Unikalne\n"GUI2"› Zabawki RC", "Wybierz", "Anuluj");
	if(dialogid == D_SAMOLOTY)
	    if(response)
	        switch(listitem)
				case 0: GivePlayerCar(playerid, 592);
                case 1: GivePlayerCar(playerid, 577);
                case 2: GivePlayerCar(playerid, 511);
                case 3: GivePlayerCar(playerid, 512);
                case 4: GivePlayerCar(playerid, 593);
                case 5: GivePlayerCar(playerid, 553);
                case 6: GivePlayerCar(playerid, 476);
                case 7: GivePlayerCar(playerid, 519);
                case 8: GivePlayerCar(playerid, 460);
                case 9: GivePlayerCar(playerid, 513);
                case 10: GivePlayerCar(playerid, 548);
                case 11: GivePlayerCar(playerid, 425);
                case 12: GivePlayerCar(playerid, 417);
                case 13: GivePlayerCar(playerid, 487);
                case 14: GivePlayerCar(playerid, 488);
                case 15: GivePlayerCar(playerid, 497);
                case 16: GivePlayerCar(playerid, 563);
                case 17: GivePlayerCar(playerid, 447);
                case 18: GivePlayerCar(playerid, 469);
                case 19: GivePlayerCar(playerid, 520);
		if(!response)
            SPD(playerid, D_CARS, DIALOG_STYLE_LIST, "{00BFFF}Wybierz typ pojazdu", "› Salony\n"GUI2"› Motory\n"W"› Rowery\n"GUI2"› Kabriolety\n"W"› Dostawcze\n"GUI2"› LowRidery\n"W"› Terenowe\n"GUI2"› Użyteczności publicznej\n"W"› Sportowe\n"GUI2"› Combi\n"W"› Łodzie\n"GUI2"› Samoloty/Helikoptery\n"W"› Unikalne\n"GUI2"› Zabawki RC", "Wybierz", "Anuluj");
	if(dialogid == D_UNIKALNE)
	    if(response)
	        switch(listitem)
				case 0: GivePlayerCar(playerid, 485);
                case 1: GivePlayerCar(playerid, 457);
                case 2: GivePlayerCar(playerid, 483);
                case 3: GivePlayerCar(playerid, 532);
                case 4: GivePlayerCar(playerid, 486);
                case 5: GivePlayerCar(playerid, 406);
                case 6: GivePlayerCar(playerid, 530);
                case 7: GivePlayerCar(playerid, 434);
                case 8: GivePlayerCar(playerid, 545);
                case 9: GivePlayerCar(playerid, 588);
                case 10: GivePlayerCar(playerid, 508);
                case 11: GivePlayerCar(playerid, 571);
                case 12: GivePlayerCar(playerid, 572);
                case 13: GivePlayerCar(playerid, 423);
                case 14: GivePlayerCar(playerid, 442);
                case 15: GivePlayerCar(playerid, 428);
                case 16: GivePlayerCar(playerid, 409);
                case 17: GivePlayerCar(playerid, 574);
                case 18: GivePlayerCar(playerid, 449);
                case 19: GivePlayerCar(playerid, 525);
                case 20: GivePlayerCar(playerid, 583);
                case 21: GivePlayerCar(playerid, 539);
		if(!response)
            SPD(playerid, D_CARS, DIALOG_STYLE_LIST, "{00BFFF}Wybierz typ pojazdu", "› Salony\n"GUI2"› Motory\n"W"› Rowery\n"GUI2"› Kabriolety\n"W"› Dostawcze\n"GUI2"› LowRidery\n"W"› Terenowe\n"GUI2"› Użyteczności publicznej\n"W"› Sportowe\n"GUI2"› Combi\n"W"› Łodzie\n"GUI2"› Samoloty/Helikoptery\n"W"› Unikalne\n"GUI2"› Zabawki RC", "Wybierz", "Anuluj");
	if(dialogid == D_RC)
	    if(response)
	        switch(listitem)
				case 0: GivePlayerCar(playerid, 441);
                case 1: GivePlayerCar(playerid, 464);
                case 2: GivePlayerCar(playerid, 465);
                case 3: GivePlayerCar(playerid, 501);
                case 4: GivePlayerCar(playerid, 564);
                case 5: GivePlayerCar(playerid, 594);
		if(!response)
            SPD(playerid, D_CARS, DIALOG_STYLE_LIST, "{00BFFF}Wybierz typ pojazdu", "› Salony\n"GUI2"› Motory\n"W"› Rowery\n"GUI2"› Kabriolety\n"W"› Dostawcze\n"GUI2"› LowRidery\n"W"› Terenowe\n"GUI2"› Użyteczności publicznej\n"W"› Sportowe\n"GUI2"› Combi\n"W"› Łodzie\n"GUI2"› Samoloty/Helikoptery\n"W"› Unikalne\n"GUI2"› Zabawki RC", "Wybierz", "Anuluj");
    if(dialogid == D_TUNE)
		if(response)
		    new vehicleid = GetPlayerVehicleID(playerid);
		    switch(listitem)
		        case 0: SPD(playerid, D_TUNE2, DIALOG_STYLE_LIST, "{00BFFF}Felgi", "› Switch\n› Mega\n› Cutter\n› Offroad\n› Shadow\n› Rimshine\n› Wires\n› Classic\n› Twist\n› Grove\n› Import\n› Dollar\n› Trance\n› Atomic\n› Ahab\n› Virtual\n› Access\n", "Wybierz", "Wróć");
		        case 1: SPD(playerid, D_TUNE3, DIALOG_STYLE_LIST, "{00BFFF}Kolory", "› Czarny\n› Bialy\n› Szary\n› Zolty\n› Niebieski\n› Blekitny\n› Granatowy\n› Brązowy\n› Czerwony\n› Morski\n› Zielony\n› Rozowy", "Wybierz", "Wróć");
				case 2:
					PlayerPlaySound(playerid, 1133, 0, 0, 0);
					AddVehicleComponent(vehicleid, 1087);
					SPD(playerid, D_TUNE, DIALOG_STYLE_LIST, "{00BFFF}Tuning Menu", "› Felgi\n"GUI2"› Kolory\n"W"› Hydraulika\n"GUI2"› Nitro\n"W"› Stereo\n"GUI2"› Paint Job", "Wybierz", "Anuluj");
		        case 3:
					PlayerPlaySound(playerid, 1133, 0, 0, 0);
					AddVehicleComponent(vehicleid, 1010);
					SPD(playerid, D_TUNE, DIALOG_STYLE_LIST, "{00BFFF}Tuning Menu", "› Felgi\n"GUI2"› Kolory\n"W"› Hydraulika\n"GUI2"› Nitro\n"W"› Stereo\n"GUI2"› Paint Job", "Wybierz", "Anuluj");
		        case 4:
					PlayerPlaySound(playerid, 1133, 0, 0, 0);
					AddVehicleComponent(vehicleid, 1086);
					SPD(playerid, D_TUNE, DIALOG_STYLE_LIST, "{00BFFF}Tuning Menu", "› Felgi\n"GUI2"› Kolory\n"W"› Hydraulika\n"GUI2"› Nitro\n"W"› Stereo\n"GUI2"› Paint Job", "Wybierz", "Anuluj");
		        case 5: SPD(playerid, D_TUNE4, DIALOG_STYLE_LIST, "{00BFFF}Paint Job", "› Paint Job 1\n› Paint Job 2\n› Paint Job 3\n› Usun Paint Job'a", "Wybierz", "Wróć");
				case 6: cmd_neony(playerid);
		return 1;
	if(dialogid == D_TUNE2)
		if(response == 1)
		    new vehicleid = GetPlayerVehicleID(playerid);
			PlayerPlaySound(playerid, 1133, 0, 0, 0);
			switch(listitem)
			    case 0: AddVehicleComponent(vehicleid, 1080); //Switch
			    case 1: AddVehicleComponent(vehicleid, 1074); //Mega
			    case 2: AddVehicleComponent(vehicleid, 1079); //Cutter
			    case 3: AddVehicleComponent(vehicleid, 1025); //Offroad
			    case 4: AddVehicleComponent(vehicleid, 1073); //Shadow
			    case 5: AddVehicleComponent(vehicleid, 1075); //Rimshine
			    case 6: AddVehicleComponent(vehicleid, 1076); //Wires
			    case 7: AddVehicleComponent(vehicleid, 1077); //Classic
			    case 8: AddVehicleComponent(vehicleid, 1078); //Twist
			    case 9: AddVehicleComponent(vehicleid, 1081); //Grove
			    case 10: AddVehicleComponent(vehicleid, 1082); //Import
			    case 11: AddVehicleComponent(vehicleid, 1083); //Dollar
			    case 12: AddVehicleComponent(vehicleid, 1084); //Trance
			    case 13: AddVehicleComponent(vehicleid, 1085); //Atomic
			    case 14: AddVehicleComponent(vehicleid, 1096); //Ahab
			    case 15: AddVehicleComponent(vehicleid, 1097); //Virtual
			    case 16: AddVehicleComponent(vehicleid, 1098); //Access
			SPD(playerid, D_TUNE2, DIALOG_STYLE_LIST, "{00BFFF}Felgi", "› Switch\n› Mega\n› Cutter\n› Offroad\n› Shadow\n› Rimshine\n› Wires\n› Classic\n› Twist\n› Grove\n› Import\n› Dollar\n› Trance\n› Atomic\n› Ahab\n› Virtual\n› Access\n", "Wybierz", "Wróć");
	else{
			SPD(playerid, D_TUNE, DIALOG_STYLE_LIST, "{00BFFF}Tuning Menu", "› Felgi\n"GUI2"› Kolory\n"W"› Hydraulika\n"GUI2"› Nitro\n"W"› Stereo\n"GUI2"› Paint Job\n"W"› Neony", "Wybierz", "Anuluj");
		return 1;
	if(dialogid == D_TUNE3)
		if(response == 1)
			PlayerPlaySound(playerid, 1134, 0, 0, 0);
			new vehicleid = GetPlayerVehicleID(playerid);
			switch(listitem)
			    case 0: ChangeVehicleColor(vehicleid, 0, 0);
			    case 1: ChangeVehicleColor(vehicleid, 1, 1);
			    case 2: ChangeVehicleColor(vehicleid, 33, 33);
			    case 3: ChangeVehicleColor(vehicleid, 6, 6);
			    case 4: ChangeVehicleColor(vehicleid, 108, 108);
			    case 5: ChangeVehicleColor(vehicleid, 7, 7);
			    case 6: ChangeVehicleColor(vehicleid, 79, 79);
			    case 7: ChangeVehicleColor(vehicleid, 405, 405);
			    case 8: ChangeVehicleColor(vehicleid, 3, 3);
			    case 9: ChangeVehicleColor(vehicleid, 166, 166);
			    case 10: ChangeVehicleColor(vehicleid, 16, 16);
			    case 11: ChangeVehicleColor(vehicleid, 146, 146);
			SPD(playerid, D_TUNE3, DIALOG_STYLE_LIST, "{00BFFF}Kolory", "› Czarny\n› Bialy\n› Szary\n› Zolty\n› Niebieski\n› Blekitny\n› Granatowy\n› Brązowy\n› Czerwony\n› Morski\n› Zielony\n› Rozowy", "Wybierz", "Wróć");		}
	else{
			SPD(playerid, D_TUNE, DIALOG_STYLE_LIST, "{00BFFF}Tuning Menu", "› Felgi\n"GUI2"› Kolory\n"W"› Hydraulika\n"GUI2"› Nitro\n"W"› Stereo\n"GUI2"› Paint Job\n"W"› Neony", "Wybierz", "Anuluj");
		return 1;
    if(dialogid == D_TUNE4)
	    if(response)
		    new vehicleid = GetPlayerVehicleID(playerid);
	    	ChangeVehicleColor(vehicleid,1,1);
	    	switch(listitem)
	    	    case 0: ChangeVehiclePaintjob(vehicleid,0);
	    	    case 1: ChangeVehiclePaintjob(vehicleid,1);
	    	    case 2: ChangeVehiclePaintjob(vehicleid,2);
	    	    case 3: ChangeVehiclePaintjob(vehicleid,3);
	    	    case 4: ChangeVehiclePaintjob(vehicleid,4);
	    	SPD(playerid, D_TUNE4, DIALOG_STYLE_LIST, "{00BFFF}Paint Job", "› Paint Job 1\n› Paint Job 2\n› Paint Job 3\n› Usun Paint Job'a", "Wybierz", "Wróć");
	else{
			SPD(playerid, D_TUNE, DIALOG_STYLE_LIST, "{00BFFF}Tuning Menu", "› Felgi\n"GUI2"› Kolory\n"W"› Hydraulika\n"GUI2"› Nitro\n"W"› Stereo\n"GUI2"› Paint Job\n"W"› Neony", "Wybierz", "Anuluj");
		return 1;
	if(dialogid == D_STYLEWALKI && response)
		switch(listitem)
		    case 0:
                SetPlayerFightingStyle(playerid, FIGHT_STYLE_NORMAL); //Normalny
                SCM(playerid, C_WHITE, ""I" "W"Przywróciłeś sobie normalny styl walki.");
			case 1:
                SetPlayerFightingStyle(playerid, FIGHT_STYLE_BOXING); //Boks
                SCM(playerid, C_WHITE, ""I" "W"Twój nowy styl walki to boks.");
			case 2:
                SetPlayerFightingStyle(playerid, FIGHT_STYLE_KUNGFU); //KungFu
                SCM(playerid, C_WHITE, ""I" "W"Twój nowy styl walki to KungFu.");
			case 3:
                SetPlayerFightingStyle(playerid, FIGHT_STYLE_KNEEHEAD); //KneeHead
                SCM(playerid, C_WHITE, ""I" "W"Twój nowy styl walki to KneeHead.");
			case 4:
                SetPlayerFightingStyle(playerid, FIGHT_STYLE_GRABKICK); //GrabKick
                SCM(playerid, C_WHITE, ""I" "W"Twój nowy styl walki to GrabKick.");
	        case 5:
                SetPlayerFightingStyle(playerid, FIGHT_STYLE_ELBOW); //ElBow
                SCM(playerid, C_WHITE, ""I" "W"Twój nowy styl walki to ElBow.");
   		return 1;
	if(dialogid == D_POGODA && response)
	    switch(listitem)
	        case 0:
     			SetPlayerWeather(playerid, 11);
                SCM(playerid, C_WHITE, ""I" "W"Zmieniłeś swoją pogodę na słoneczną.");
	        case 1:
                SetPlayerWeather(playerid, 16); //deszcz
                SCM(playerid, C_WHITE, ""I" "W"Zmieniłeś swoją pogodę na deszczową.");
	        case 2:
                SetPlayerWeather(playerid, 44);
                SCM(playerid, C_WHITE, ""I" "W"Zmieniłeś swoją pogodę na matrix.");
	        case 3:
                SetPlayerWeather(playerid, 43);
                SCM(playerid, C_WHITE, ""I" "W"Zmieniłeś swoją pogodę na czarnobyl.");
			case 4:
                SetPlayerWeather(playerid, 9);
                SCM(playerid, C_WHITE, ""I" "W"Zmieniłeś swoją pogodę na mgłę.");
            case 5:
                SetPlayerWeather(playerid, 250);
                SCM(playerid, C_WHITE, ""I" "W"Zmieniłeś swoją pogodę na armagedon.");
    if(dialogid == D_RADIO && response)
        switch(listitem)
            case 0:
         		PlayAudioStreamForPlayer(playerid, "http://213.251.138.121:7000/listen.pls"); //Antyradio
				SCM(playerid, 0x00FFFFFF, ""I" "W"Wybrano AntyRadio. Miłego słuchania!");
			case 1:
         		PlayAudioStreamForPlayer(playerid, "http://www.miastomuzyki.pl/n/rmfmaxxx.pls"); //RMF Maxxx
				SCM(playerid, 0x00FFFFFF, ""I" "W"Wybrano RMF Maxxx. Miłego słuchania!");
			case 2:
 				PlayAudioStreamForPlayer(playerid, "http://radioparty.pl/play/glowny_48.m3u"); //Radio Party
                SCM(playerid, 0x00FFFFFF, ""I" "W"Wybrano Radio Party. Miłego słuchania!");
 			case 3:
 				PlayAudioStreamForPlayer(playerid, "http://www.odsluchane.eu/pls/eska.pls"); //Radio ESKA
                SCM(playerid, 0x00FFFFFF, ""I" "W"Wybrano Radio ESKA. Miłego słuchania!");
            case 4:
 				PlayAudioStreamForPlayer(playerid, "http://www.discoparty.pl/player/disco.m3u"); //Disco Party
                SCM(playerid, 0x00FFFFFF, ""I" "W"Wybrano Disco Party. Miłego słuchania!");
            case 5:
 				PlayAudioStreamForPlayer(playerid, "http://91.121.179.221:8050/listen.pls"); //Radio ZET
                SCM(playerid, 0x00FFFFFF, ""I" "W"Wybrano Radio Zet. Miłego słuchania!");
 			case 6:
 				PlayAudioStreamForPlayer(playerid, "http://87.98.222.167:8000/listen.pls"); //RMF FM
                SCM(playerid, 0x00FFFFFF, ""I" "W"Wybrano RMF FM. Miłego słuchania!");
            case 7:
 				PlayAudioStreamForPlayer(playerid, "http://s1.slotex.pl:8064/listen.pls"); //GoldStacja
                SCM(playerid, 0x00FFFFFF, ""I" "W"Wybrano GoldStację. Miłego słuchania!");
		 	case 8:
 				PlayAudioStreamForPlayer(playerid, "http://www.orangemusic.pl:8000/oms-pl_04.mp3"); //Orange Music - Rock
                SCM(playerid, 0x00FFFFFF, ""I" "W"Wybrano GoldStację. Miłego słuchania!");
            case 9:
 				StopAudioStreamForPlayer(playerid);
                SCM(playerid, 0x00FFFFFF, ""I" "W"Radio wyłączone!");
    if(dialogid == D_BRONIES_CP && response)
  		SPD(playerid, D_BRONIES, DIALOG_STYLE_LIST, "{00BFFF}Bronie Specjalne", "Minigun	$1.000.000\nRPG   $500.000\nRPG Auto   $750.000\nMiotacz ognia	$400.000\nMateriały wybuchowe   $200.000\nGranaty   $150.000", "Zakup", "Zamknij");
	if(dialogid == D_BRONIES && response)
        switch(listitem)
			case 0: SellPlayerWeapon(playerid,38,5000,1000000);
			case 1: SellPlayerWeapon(playerid,35,5000,500000);
			case 2: SellPlayerWeapon(playerid,36,5000,750000);
			case 3: SellPlayerWeapon(playerid,37,5000,400000);
			case 4: SellPlayerWeapon(playerid,39,5000,200000);
			case 5: SellPlayerWeapon(playerid,16,100,150000);
	if(dialogid == D_BANK && response)
		switch(listitem)
		    case 0: SPD(playerid, D_WPLAC, DIALOG_STYLE_INPUT, "{00BFFF}Wpłata","Wpisz kwotę którą chcesz wpłacić na konto bankowe:","Wpłać", "Cofnij");
			case 1: SPD(playerid, D_WYPLAC, DIALOG_STYLE_INPUT, "{00BFFF}Wypłata","Wpisz kwotę którą chcesz podjąć z konta bankowego:","Wypłać","Cofnij");
			case 2:
				new String[128];
				format(String,sizeof(String), "Stan twojego konta bankowego wynosi: %d$",Player[playerid][Bank]);
				SPD(playerid, D_STAN, DIALOG_STYLE_MSGBOX, "{00BFFF}Stan",String,"Zamknij","Cofnij");
			case 3: SPD(playerid, D_PRZELEW, DIALOG_STYLE_INPUT, "{00BFFF}Przelew","Wpisz ID odbiorcy:","Wpłać", "Cofnij");
	if(dialogid == D_WPLAC)
	    if(response)
			if(strval(inputtext) <= 0) return SCM(playerid, C_ERROR, ""WE" "R"Wpłata musi być większa od 0.");
			if(Player[playerid][Money] < strval(inputtext)) return SCM(playerid, C_ERROR, ""WE" "R"Nie posiadasz tyle pieniędzy!");
			GivePlayerMoney(playerid, -strval(inputtext));
            Player[playerid][Money] += -strval(inputtext);
			PlayerPlaySound(playerid, 4201, 0.0,0.0,0.0);
			new String[128];
			format(String,sizeof(String), ""WI" "G"Wpłaciłeś na swoje konto bankowe %s$.",inputtext);
			SCM(playerid, C_GREEN, String);
			Player[playerid][Bank] += strval(inputtext);
	    else
            SPD(playerid, D_BANK, DIALOG_STYLE_LIST, "{00BFFF}Bank","› Wpłać\n"GUI2"› Wypłać\n"W"› Stan Konta\n"GUI2"› Przelew", "Wybierz", "Zamknij");
	if(dialogid == D_WYPLAC)
	    if(response)
   			if(strval(inputtext) <= 0) return SCM(playerid, C_ERROR, ""WE" "R"Wpłata musi być większa od 0.");
			if(Player[playerid][Bank] < strval(inputtext)) return SCM(playerid, C_ERROR, ""WE" "R"Na twoim koncie bankowym niema tyle pieniędzy!");
            GivePlayerMoney(playerid, strval(inputtext));
            Player[playerid][Money] += strval(inputtext);
            PlayerPlaySound(playerid, 4201, 0.0,0.0,0.0);
			new String[128];
			format(String,sizeof(String), ""WI" "R"Podjąłeś z konta bankowego kwotę w wysokości %s$.",inputtext);
			SCM(playerid, C_GREEN, String);
			Player[playerid][Bank] -= strval(inputtext);
	    else
            SPD(playerid, D_BANK, DIALOG_STYLE_LIST, "{00BFFF}Bank","› Wpłać\n"GUI2"› Wypłać\n"W"› Stan Konta\n"GUI2"› Przelew", "Wybierz", "Zamknij");
	if(dialogid == D_STAN)
		if(response)
			new String[128];
			format(String,sizeof(String), "Stan twojego konta bankowego wynosi: %d$", Player[playerid][Bank]);
			SPD(playerid, D_STAN2, DIALOG_STYLE_MSGBOX, "{00BFFF}Stan",String, "Zamknij", "Cofnij");
		else
        	SPD(playerid, D_BANK, DIALOG_STYLE_LIST, "{00BFFF}Bank","› Wpłać\n"GUI2"› Wypłać\n"W"› Stan Konta\n"GUI2"› Przelew", "Wybierz", "Zamknij");
	if(dialogid == D_STAN2 && !response)
        SPD(playerid, D_BANK, DIALOG_STYLE_LIST, "{00BFFF}Bank","› Wpłać\n"GUI2"› Wypłać\n"W"› Stan Konta\n"GUI2"› Przeleww", "Wybierz", "Zamknij");
	if(dialogid == D_PRZELEW)
		if(response)
			if(strval(inputtext) == playerid)
                SCM(playerid, C_ERROR, ""WE" "R"Nie możesz podawać swojego ID!");
				return 1;
			if(!IsPlayerConnected(strval(inputtext)))
				SCM(playerid, C_WHITE, ""E" "W"Ten gracz nie jest podłaczony!");
				return 1;
            Player[playerid][PrzelewID] = strval(inputtext);
			new String[128];
			format(String,sizeof(String), "Odbiorca: %s\n\nWprowadź kwotę przelewu:",Player[Player[playerid][PrzelewID]][Name]);
			SPD(playerid, D_PRZELEW2, DIALOG_STYLE_INPUT, "{00BFFF}Przelew",String, "Przelej", "Cofnij");
		else
            SPD(playerid, D_BANK, DIALOG_STYLE_LIST, "{00BFFF}Bank","› Wpłać\n"GUI2"› Wypłać\n"W"› Stan Konta\n"GUI2"› Przelew", "Wybierz", "Zamknij");
	if(dialogid == D_PRZELEW2)
	    if(response)
			if(strval(inputtext) <= 0) return SCM(playerid, C_ERROR, ""WE" "R"Przelew musi być większy od 0.");
			if(Player[playerid][Bank] < strval(inputtext)) return SCM(playerid, C_ERROR, ""WE" "R"Na twoim koncie bankowym niema tyle pieniędzy!");
			Player[Player[playerid][PrzelewID]][Bank] += strval(inputtext);
			PlayerPlaySound(playerid, 4201, 0.0,0.0,0.0);
            PlayerPlaySound(Player[playerid][PrzelewID], 4201, 0.0,0.0,0.0);
			new String[128];
			format(String,sizeof(String), ""WI" "G"%s przelał na twoje konto bankowe %s$!", Player[playerid][Name], inputtext);
			SCM(Player[playerid][PrzelewID], C_GREEN, String);
			SCM(playerid, C_WHITE, ""I" "W"Kwota została pobrana z twojego konta bankowego.");
            SCM(playerid, C_WHITE, ""I" "W"Tranzakcja przebiegła prawidłowo.");
	    else
            SPD(playerid, D_BANK, DIALOG_STYLE_LIST, "{00BFFF}Bank","› Wpłać\n"GUI2"› Wypłać\n"W"› Stan Konta\n"GUI2"› Przelew", "Wybierz", "Zamknij");
	if(dialogid == D_OSIAGNIECIA_1 && response)
		switch(listitem)
			case 0:
				if(AchievementGet[playerid][aRegistered] == 1)
					SPD(playerid, D_SHOW_ACHIEVEMENT_1, DIALOG_STYLE_MSGBOX, "{00BFFF}Witamy!", "{C45941}Witamy!\n\n{3CE01B}Zakończony\n\n{FFFFFF}Zarejestruj swoje konto.", "Zamknij", "Wróć");
				else
                    SPD(playerid, D_SHOW_ACHIEVEMENT_1, DIALOG_STYLE_MSGBOX, "{00BFFF}Witamy!", "{C45941}Witamy!\n\n{FFFFFF}0/1\n\nZarejestruj swoje konto.", "Zamknij", "Wróć");
			case 1:
                if(AchievementGet[playerid][aTrofea] >= 7)
					SPD(playerid, D_SHOW_ACHIEVEMENT_1, DIALOG_STYLE_MSGBOX, "{00BFFF}Trofea", "{C45941}Trofea\n\n{3CE01B}Zakończony\n\n{FFFFFF}Zabij 7 razy Head Admina.", "Zamknij", "Wróć");
				else
					new String[128];
					format(String,sizeof(String), "{C45941}Trofea\n\n{FFFFFF}%d/7\n\nZabij 7 razy Head Admina",AchievementGet[playerid][aTrofea]);
					SPD(playerid, D_SHOW_ACHIEVEMENT_1, DIALOG_STYLE_MSGBOX, "{00BFFF}Trofea", String, "Zamknij", "Wróć");
            case 2:
                if(AchievementGet[playerid][aDoscTego] >= 10)
					SPD(playerid, D_SHOW_ACHIEVEMENT_1, DIALOG_STYLE_MSGBOX, "{00BFFF}Dosc Tego!", "{C45941}Dosc Tego!\n\n{3CE01B}Zakończony\n\n{FFFFFF}Tajne.", "Zamknij", "Wróć");
				else
					new String[128];
					format(String,sizeof(String), "{C45941}Dosc Tego!\n\n{FFFFFF}%d/Tajne\n\nTajne",AchievementGet[playerid][aDoscTego]);
					SPD(playerid, D_SHOW_ACHIEVEMENT_1, DIALOG_STYLE_MSGBOX, "{00BFFF}Dosc Tego!", String, "Zamknij", "Wróć");
            case 3:
				if(AchievementGet[playerid][aKask] == 1)
					SPD(playerid, D_SHOW_ACHIEVEMENT_1, DIALOG_STYLE_MSGBOX, "{00BFFF}Potrzebuje kask", "{C45941}Potrzebuje kask\n\n{3CE01B}Zakończony\n\n{FFFFFF}Wsiądź na motor.", "Zamknij", "Wróć");
				else
                    SPD(playerid, D_SHOW_ACHIEVEMENT_1, DIALOG_STYLE_MSGBOX, "{00BFFF}Potrzebuje kask", "{C45941}Potrzebuje kask\n\n{FFFFFF}0/1\n\nWsiądź na motor.", "Zamknij", "Wróć");
            case 4:
				if(AchievementGet[playerid][aJestemLepszy] == 1)
					SPD(playerid, D_SHOW_ACHIEVEMENT_1, DIALOG_STYLE_MSGBOX, "{00BFFF}Jestem lepszy!", "{C45941}Jestem lepszy!\n\n{3CE01B}Zakończony\n\n{FFFFFF}Wygraj pojedynek przez /ArenaSolo z dowolnym graczem.", "Zamknij", "Wróć");
				else
                    SPD(playerid, D_SHOW_ACHIEVEMENT_1, DIALOG_STYLE_MSGBOX, "{00BFFF}Jestem lepszy!", "{C45941}Jestem lepszy!\n\n{FFFFFF}0/1\n\nWygraj pojedynek przez /ArenaSolo z dowolnym graczem.", "Zamknij", "Wróć");
            case 5:
				if(AchievementGet[playerid][aJestemMistrzem] == 1)
					SPD(playerid, D_SHOW_ACHIEVEMENT_1, DIALOG_STYLE_MSGBOX, "{00BFFF}Jestem mistrzem!", "{C45941}Jestem mistrzem!\n\n{3CE01B}Zakończony\n\n{FFFFFF}Wygraj pojedynek przez /ArenaSolo z dowolnym graczem nie tracąc życia ani kamizelki.", "Zamknij", "Wróć");
				else
                    SPD(playerid, D_SHOW_ACHIEVEMENT_1, DIALOG_STYLE_MSGBOX, "{00BFFF}Jestem mistrzem!", "{C45941}Jestem mistrzem!\n\n{FFFFFF}0/1\n\nWygraj pojedynek przez /ArenaSolo z dowolnym graczem nie tracąc życia ani kamizelki.", "Zamknij", "Wróć");
			case 6:
                if(AchievementGet[playerid][aPilot] >= 60)
					SPD(playerid, D_SHOW_ACHIEVEMENT_1, DIALOG_STYLE_MSGBOX, "{00BFFF}Pilot", "{C45941}Pilot\n\n{3CE01B}Zakończony\n\n{FFFFFF}Przelataj 60 minut samolotem.", "Zamknij", "Wróć");
				else
					new String[128];
					format(String,sizeof(String), "{C45941}Pilot\n\n{FFFFFF}%d/60\n\nPrzelataj 60 minut samolotem.",AchievementGet[playerid][aPilot]);
					SPD(playerid, D_SHOW_ACHIEVEMENT_1, DIALOG_STYLE_MSGBOX, "{00BFFF}Pilot", String, "Zamknij", "Wróć");
            case 7:
                if(AchievementGet[playerid][a24Godziny] == 1)
					SPD(playerid, D_SHOW_ACHIEVEMENT_1, DIALOG_STYLE_MSGBOX, "{00BFFF}24 godziny", "{C45941}24 godziny\n\n{3CE01B}Zakończony\n\n{FFFFFF}Przegraj 24 godziny na serverze.", "Zamknij", "Wróć");
				else
					SPD(playerid, D_SHOW_ACHIEVEMENT_1, DIALOG_STYLE_MSGBOX, "{00BFFF}24 godziny", "{C45941}24 godziny\n\n{FFFFFF}0/1\n\nPrzegraj 24 godziny na serverze.", "Zamknij", "Wróć");
			case 8:
                if(AchievementGet[playerid][aDoOstatniegoTchu] == 1)
					SPD(playerid, D_SHOW_ACHIEVEMENT_1, DIALOG_STYLE_MSGBOX, "{00BFFF}Do ostatniego tchu", "{C45941}Do ostatniego tchu\n\n{3CE01B}Zakończony\n\n{FFFFFF}Zabij dowolnego gracza mając 1 procent życia.", "Zamknij", "Wróć");
				else
                    SPD(playerid, D_SHOW_ACHIEVEMENT_1, DIALOG_STYLE_MSGBOX, "{00BFFF}Do ostatniego tchu", "{C45941}Do ostatniego tchu\n\n{FFFFFF}0/1\n\nZabij dowolnego gracza mając 1 procent życia.", "Zamknij", "Wróć");
            case 9:
                if(AchievementGet[playerid][aCelneOko] >= 100)
					SPD(playerid, D_SHOW_ACHIEVEMENT_1, DIALOG_STYLE_MSGBOX, "{00BFFF}Celne Oko", "{C45941}Celne Oko\n\n{3CE01B}Zakończony\n\n{FFFFFF}Zabij 100 razy przeciwnika na arenie onede.", "Zamknij", "Wróć");
				else
					new String[128];
					format(String,sizeof(String), "{C45941}Celne Oko\n\n{FFFFFF}%d/100\n\nZabij 100 razy przeciwnika na arenie onede.",AchievementGet[playerid][aCelneOko]);
					SPD(playerid, D_SHOW_ACHIEVEMENT_1, DIALOG_STYLE_MSGBOX, "{00BFFF}Celne Oko", String, "Zamknij", "Wróć");
            case 10:
                if(AchievementGet[playerid][aZwinnePalce] >= 10)
					SPD(playerid, D_SHOW_ACHIEVEMENT_1, DIALOG_STYLE_MSGBOX, "{00BFFF}Zwinne Palce", "{C45941}Zwinne Palce\n\n{3CE01B}Zakończony\n\n{FFFFFF}Przepisz poprawnie kod 100 razy.", "Zamknij", "Wróć");
				else
					new String[128];
					format(String,sizeof(String), "{C45941}Zwinne Palce\n\n{FFFFFF}%d/100\n\nPrzepisz poprawnie kod 100 razy.",AchievementGet[playerid][aZwinnePalce]);
					SPD(playerid, D_SHOW_ACHIEVEMENT_1, DIALOG_STYLE_MSGBOX, "{00BFFF}Zwinne Palce", String, "Zamknij", "Wróć");
            case 11:
                Show2ListAchievements(playerid);
	if(dialogid == D_OSIAGNIECIA_2 && response)
		switch(listitem)
			case 0:
				cmd_osiagniecia(playerid);
			case 1:
                if(AchievementGet[playerid][aPodroznik] >= 1)
					SPD(playerid, D_SHOW_ACHIEVEMENT_2, DIALOG_STYLE_MSGBOX, "{00BFFF}Podróżnik", "{C45941}Podróżnik\n\n{3CE01B}Zakończony\n\n{FFFFFF}Przejedź prywatnym pojazdem 50 km.", "Zamknij", "Wróć");
				else
					SPD(playerid, D_SHOW_ACHIEVEMENT_2, DIALOG_STYLE_MSGBOX, "{00BFFF}Podróżnik", "{C45941}Podróżnik\n\n{FFFFFF}0/1\n\nPrzejedź prywatnym pojazdem 50 km.", "Zamknij", "Wróć");
			case 2:
				if(AchievementGet[playerid][aDrifter] == 1)
					SPD(playerid, D_SHOW_ACHIEVEMENT_2, DIALOG_STYLE_MSGBOX, "{00BFFF}Drifter", "{C45941}Drifter\n\n{3CE01B}Zakończony\n\n{FFFFFF}Osiągnij 5000 pkt w driftingu.", "Zamknij", "Wróć");
				else
					SPD(playerid, D_SHOW_ACHIEVEMENT_2, DIALOG_STYLE_MSGBOX, "{00BFFF}Drifter", "{C45941}Drifter\n\n{FFFFFF}0/1\n\nOsiągnij 5000 pkt w driftingu.", "Zamknij", "Wróć");
            case 3:
				if(AchievementGet[playerid][aKrolDriftu] == 1)
					SPD(playerid, D_SHOW_ACHIEVEMENT_2, DIALOG_STYLE_MSGBOX, "{00BFFF}Król Driftu", "{C45941}Król Driftu\n\n{3CE01B}Zakończony\n\n{FFFFFF}Osiągnij rekordowy wynik 20000 pkt w driftingu.", "Zamknij", "Wróć");
				else
					SPD(playerid, D_SHOW_ACHIEVEMENT_2, DIALOG_STYLE_MSGBOX, "{00BFFF}Król Driftu", "{C45941}Król Driftu\n\n{FFFFFF}0/1\n\nOsiągnij rekordowy wynik 20000 pkt w driftingu.", "Zamknij", "Wróć");
			case 4:
                if(AchievementGet[playerid][aStreetKing] >= 10)
					SPD(playerid, D_SHOW_ACHIEVEMENT_2, DIALOG_STYLE_MSGBOX, "{00BFFF}Street King!", "{C45941}Street King!\n\n{3CE01B}Zakończony\n\n{FFFFFF}Wygraj wyścig (/WS) 10 razy na pierwszym miejscu.", "Zamknij", "Wróć");
				else
					new String[128];
					format(String,sizeof(String), "{C45941}Street King!\n\n{FFFFFF}%d/10\n\nWygraj wyścig (/WS) 10 razy na pierwszym miejscu.",AchievementGet[playerid][aStreetKing]);
					SPD(playerid, D_SHOW_ACHIEVEMENT_2, DIALOG_STYLE_MSGBOX, "{00BFFF}Street King!", String, "Zamknij", "Wróć");
            case 5:
				if(AchievementGet[playerid][aNowaTozsamosc] == 1)
					SPD(playerid, D_SHOW_ACHIEVEMENT_2, DIALOG_STYLE_MSGBOX, "{00BFFF}Nowa Tożsamość", "{C45941}Nowa Tożsamość\n\n{3CE01B}Zakończony\n\n{FFFFFF}Zmień nick komendą /zmiennick.", "Zamknij", "Wróć");
				else
					SPD(playerid, D_SHOW_ACHIEVEMENT_2, DIALOG_STYLE_MSGBOX, "{00BFFF}Nowa Tożsamość", "{C45941}Nowa Tożsamość\n\n{FFFFFF}0/1\n\nZmień nick komendą /zmiennick.", "Zamknij", "Wróć");
            case 6:
				if(AchievementGet[playerid][aDomownik] == 1)
					SPD(playerid, D_SHOW_ACHIEVEMENT_2, DIALOG_STYLE_MSGBOX, "{00BFFF}Domownik", "{C45941}Domownik\n\n{3CE01B}Zakończony\n\n{FFFFFF}Posiadaj swój domek.", "Zamknij", "Wróć");
				else
					SPD(playerid, D_SHOW_ACHIEVEMENT_2, DIALOG_STYLE_MSGBOX, "{00BFFF}Domownik", "{C45941}Domownik\n\n{FFFFFF}0/1\n\nPosiadaj swój domek.", "Zamknij", "Wróć");
            case 7:
				if(AchievementGet[playerid][aWlasne4] == 1)
					SPD(playerid, D_SHOW_ACHIEVEMENT_2, DIALOG_STYLE_MSGBOX, "{00BFFF}Własne cztery kółka", "{C45941}Własne cztery kółka\n\n{3CE01B}Zakończony\n\n{FFFFFF}Tajne.", "Zamknij", "Wróć");
				else
					SPD(playerid, D_SHOW_ACHIEVEMENT_2, DIALOG_STYLE_MSGBOX, "{00BFFF}Własne cztery kółka", "{C45941}Własne cztery kółka\n\n{FFFFFF}0/1\n\nTajne.", "Zamknij", "Wróć");
            case 8:
				if(AchievementGet[playerid][aZzzz] == 1)
					SPD(playerid, D_SHOW_ACHIEVEMENT_2, DIALOG_STYLE_MSGBOX, "{00BFFF}Zzzz...", "{C45941}Zzzz...\n\n{3CE01B}Zakończony\n\n{FFFFFF}Bądź na serwerze pomiędzy 3 a 5 rano.", "Zamknij", "Wróć");
				else
					SPD(playerid, D_SHOW_ACHIEVEMENT_2, DIALOG_STYLE_MSGBOX, "{00BFFF}Zzzz...", "{C45941}Zzzz...\n\n{FFFFFF}0/1\n\nBądź na serwerze pomiędzy 3 a 5 rano.", "Zamknij", "Wróć");
            case 9:
                if(AchievementGet[playerid][aWyborowy] >= 100)
					SPD(playerid, D_SHOW_ACHIEVEMENT_2, DIALOG_STYLE_MSGBOX, "{00BFFF}Strzelec Wyborowy", "{C45941}Strzelec Wyborowy\n\n{3CE01B}Zakończony\n\n{FFFFFF}Zabij 100 razy przeciwnika z broni M4.", "Zamknij", "Wróć");
				else
					new String[128];
					format(String,sizeof(String), "{C45941}Strzelec Wyborowy\n\n{FFFFFF}%d/100\n\nZabij 100 razy przeciwnika z broni M4.",AchievementGet[playerid][aWyborowy]);
					SPD(playerid, D_SHOW_ACHIEVEMENT_2, DIALOG_STYLE_MSGBOX, "Strzelec Wyborowy", String, "Zamknij", "Wróć");
            case 10:
                if(AchievementGet[playerid][aKomandos] >= 100)
					SPD(playerid, D_SHOW_ACHIEVEMENT_2, DIALOG_STYLE_MSGBOX, "{00BFFF}Komandos", "{C45941}Komandos\n\n{3CE01B}Zakończony\n\n{FFFFFF}Zabij 100 graczy z noża.", "Zamknij", "Wróć");
				else
					new String[128];
					format(String,sizeof(String), "{C45941}Komandos\n\n{FFFFFF}%d/100\n\nZabij 100 graczy z noża.",AchievementGet[playerid][aKomandos]);
					SPD(playerid, D_SHOW_ACHIEVEMENT_2, DIALOG_STYLE_MSGBOX, "{00BFFF}Komandos", String, "Zamknij", "Wróć");
			case 11:
                Show3ListAchievements(playerid);
    if(dialogid == D_OSIAGNIECIA_3 && response)
		switch(listitem)
			case 0:
				Show2ListAchievements(playerid);
			case 1:
                if(AchievementGet[playerid][aWedkarz] >= 100)
					SPD(playerid, D_SHOW_ACHIEVEMENT_3, DIALOG_STYLE_MSGBOX, "{00BFFF}Wędkarz", "{C45941}Wędkarz\n\n{3CE01B}Zakończony\n\n{FFFFFF}Złów 100 dowolnych rybek na łowiskach.", "Zamknij", "Wróć");
				else
					new String[128];
					format(String,sizeof(String), "{C45941}Wędkarz\n\n{FFFFFF}%d/100\n\nZłów 100 dowolnych rybek na łowiskach.",AchievementGet[playerid][aWedkarz]);
					SPD(playerid, D_SHOW_ACHIEVEMENT_3, DIALOG_STYLE_MSGBOX, "{00BFFF}Wędkarz", String, "Zamknij", "Wróć");
            case 2:
                if(AchievementGet[playerid][aStalyGracz] >= 10)
					SPD(playerid, D_SHOW_ACHIEVEMENT_3, DIALOG_STYLE_MSGBOX, "{00BFFF}Stały Gracz", "{C45941}Stały Gracz\n\n{3CE01B}Zakończony\n\n{FFFFFF}Zaloguj się pierwszy raz w dniu.", "Zamknij", "Wróć");
				else
					new String[128];
					format(String,sizeof(String), "{C45941}Stały Gracz\n\n{FFFFFF}%d/10\n\nZaloguj się pierwszy raz w dniu.",AchievementGet[playerid][aStalyGracz]);
					SPD(playerid, D_SHOW_ACHIEVEMENT_3, DIALOG_STYLE_MSGBOX, "{00BFFF}Wędkarz", String, "Zamknij", "Wróć");
            case 3:
                if(AchievementGet[playerid][aPoszukiwacz] >= 20)
					SPD(playerid, D_SHOW_ACHIEVEMENT_3, DIALOG_STYLE_MSGBOX, "{00BFFF}Poszukiwacz", "{C45941}Stały Gracz\n\n{3CE01B}Zakończony\n\n{FFFFFF}Znajdź walizkę/podkowę/prezent zgubiony przez admina.", "Zamknij", "Wróć");
				else
					new String[128];
					format(String,sizeof(String), "{C45941}Poszukiwacz\n\n{FFFFFF}%d/20\n\nZnajdź walizkę/podkowę/prezent zgubiony przez admina.",AchievementGet[playerid][aPoszukiwacz]);
					SPD(playerid, D_SHOW_ACHIEVEMENT_3, DIALOG_STYLE_MSGBOX, "{00BFFF}Wędkarz", String, "Zamknij", "Wróć");
			case 4:
                Show3ListAchievements(playerid);
	if(dialogid == D_SHOW_ACHIEVEMENT_1 && !response)
		cmd_osiagniecia(playerid);
    if(dialogid == D_SHOW_ACHIEVEMENT_2 && !response)
		Show2ListAchievements(playerid);
    if(dialogid == D_SHOW_ACHIEVEMENT_3 && !response)
		Show3ListAchievements(playerid);
	if(dialogid == D_STATY && response)
        if(mysql_ping() == -1)
			mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
		switch(listitem)
			case 0:
				ShowPlayerStats(playerid,playerid);
			case 1:
				ShowServerStats(playerid);
			case 2:
				new String[450];
				format(String,sizeof(String),
				""W"› Exp\n"GUI2"› Skill\n"W"› Śmierci\n"GUI2"› Czas gry\n"W"› Arena Solo\n"GUI2"› Arena Onede\n"W"› Arena Minigun\n"GUI2"› Arena RPG\n"W"› Drifting\n"GUI2"› Przepisanych Kodów\n"W"› Arena Combat\n"GUI2"› Przebieg\n"W"› Wygranych WG\n"GUI2"› Wygranych WS\n"W"› Wygranych CH\n"GUI2"› Wygranych PB\n"W"› Wygranych US\n"GUI2"› Wygranych SN");
				SPD(playerid,D_STATY_TOP,DIALOG_STYLE_LIST,"{00BFFF}Listy TOP-10",String,"Wybierz","Cofnij");
	if(dialogid == D_STATY_TOP)
		if(response)
			switch(listitem)
				case 0:
					strdel(Top10Text[0],0,512);
					for(new x=0;x<10;x++)
						new str[128];
						new name[25];
						new score[11];
						format(str,sizeof(str),"SELECT Name,Exp FROM "PREFIX"Users ORDER BY `Exp` DESC, `Name` ASC LIMIT %d , %d",x,x+1);
						mysql_query(str);
						mysql_store_result();
						mysql_fetch_row(str, "|");
						new ii=strlen(str);
						for(new i=0;i<ii;i++)
							if(strfind(str[i],"|",false)==0)
								strmid(name,str,0,i);
								strmid(score,str,i+1,ii);
								format(score,sizeof(score),"(%s)",score);
								break;
						mysql_free_result();
						format(Top10Text[0],512,"%s\n%d.	%21s		%11s",Top10Text[0],x+1,name,score);
					SPD(playerid,D_TOP,0,"{00BFFF}Exp "W"TOP-10:",Top10Text[0],"Zamknij","Cofnij");
				case 1:
					strdel(Top10Text[0],0,512);
					for(new x=0;x<10;x++)
						new str[128];
						new name[25];
						new score[11];
						format(str,sizeof(str),"SELECT Name,Kills FROM "PREFIX"Users ORDER BY `Kills` DESC, `Name` ASC LIMIT %d , %d",x,x+1);
						mysql_query(str);
						mysql_store_result();
						mysql_fetch_row(str, "|");
						new ii=strlen(str);
						for(new i=0;i<ii;i++)
							if(strfind(str[i],"|",false)==0)
								strmid(name,str,0,i);
								strmid(score,str,i+1,ii);
								format(score,sizeof(score),"(%s)",score);
								break;
						mysql_free_result();
						format(Top10Text[0],512,"%s\n%d.	%21s		%11s",Top10Text[0],x+1,name,score);
					SPD(playerid,D_TOP,0,"{00BFFF}Skill "W"TOP-10:",Top10Text[0],"Zamknij","Cofnij");
				case 2:
					strdel(Top10Text[0],0,512);
					for(new x=0;x<10;x++)
						new str[128];
						new name[25];
						new score[11];
						format(str,sizeof(str),"SELECT Name,Deaths FROM "PREFIX"Users ORDER BY `Deaths` DESC, `Name` ASC LIMIT %d , %d",x,x+1);
						mysql_query(str);
						mysql_store_result();
						mysql_fetch_row(str, "|");
						new ii=strlen(str);
						for(new i=0;i<ii;i++)
							if(strfind(str[i],"|",false)==0)
								strmid(name,str,0,i);
								strmid(score,str,i+1,ii);
								format(score,sizeof(score),"(%s)",score);
								break;
						mysql_free_result();
						format(Top10Text[0],512,"%s\n%d.	%21s		%11s",Top10Text[0],x+1,name,score);
					SPD(playerid,D_TOP,0,"{00BFFF}Śmierci "W"TOP-10:",Top10Text[0],"Zamknij","Cofnij");
				case 3:
					strdel(Top10Text[4],0,512);
					for(new x=0;x<10;x++)
						new str[128];
						new name[25];
						new score[11];
						format(str,sizeof(str),"SELECT Name,TimePlay FROM "PREFIX"Users ORDER BY `TimePlay` DESC, `Name` ASC LIMIT %d , %d",x,x+1);
						mysql_query(str);
						mysql_store_result();
						mysql_fetch_row(str, "|");
						new ii=strlen(str);
						for(new i=0;i<ii;i++)
							if(strfind(str[i],"|",false)==0)
								strmid(name,str,0,i);
								strmid(score,str,i+1,ii);
								break;
						new Godzz = strval(score);
						new Float:sec = Godzz;
						sec = sec/60;
						Godzz = Godzz/60;
						sec = sec - Godzz;
						sec = 60*sec;
						mysql_free_result();
						format(Top10Text[4],512,"%s\n%d.	%21s		%d godz. , %d min.",Top10Text[4],x+1,name,Godzz,floatround(sec));
					SPD(playerid,D_TOP,0,"{00BFFF}Czas Gry "W"TOP-10:",Top10Text[4],"Zamknij","Cofnij");
				case 4:
	                strdel(Top10Text[0],0,512);
					for(new x=0;x<10;x++)
						new str[128];
						new name[25];
						new score[11];
						format(str,sizeof(str),"SELECT Name,SoloScore FROM "PREFIX"Users ORDER BY `SoloScore` DESC, `Name` ASC LIMIT %d , %d",x,x+1);
						mysql_query(str);
						mysql_store_result();
						mysql_fetch_row(str, "|");
						new ii=strlen(str);
						for(new i=0;i<ii;i++)
							if(strfind(str[i],"|",false)==0)
								strmid(name,str,0,i);
								strmid(score,str,i+1,ii);
								format(score,sizeof(score),"(%s)",score);
								break;
						mysql_free_result();
						format(Top10Text[0],512,"%s\n%d.	%21s		%11s",Top10Text[0],x+1,name,score);
					SPD(playerid,D_TOP,0,"{00BFFF}Arena Solo "W"TOP-10:",Top10Text[0],"Zamknij","Cofnij");
	            case 5:
	                strdel(Top10Text[0],0,512);
					for(new x=0;x<10;x++)
						new str[128];
						new name[25];
						new score[11];
						format(str,sizeof(str),"SELECT Name,OnedeScore FROM "PREFIX"Users ORDER BY `OnedeScore` DESC, `Name` ASC LIMIT %d , %d",x,x+1);
						mysql_query(str);
						mysql_store_result();
						mysql_fetch_row(str, "|");
						new ii=strlen(str);
						for(new i=0;i<ii;i++)
							if(strfind(str[i],"|",false)==0)
								strmid(name,str,0,i);
								strmid(score,str,i+1,ii);
								format(score,sizeof(score),"(%s)",score);
								break;
						mysql_free_result();
						format(Top10Text[0],512,"%s\n%d.	%21s		%11s",Top10Text[0],x+1,name,score);
					SPD(playerid,D_TOP,0,"{00BFFF}Arena Onede "W"TOP-10:",Top10Text[0],"Zamknij","Cofnij");
				case 6:
	                strdel(Top10Text[0],0,512);
					for(new x=0;x<10;x++)
						new str[128];
						new name[25];
						new score[11];
						format(str,sizeof(str),"SELECT Name,MinigunScore FROM "PREFIX"Users ORDER BY `MinigunScore` DESC, `Name` ASC LIMIT %d , %d",x,x+1);
						mysql_query(str);
						mysql_store_result();
						mysql_fetch_row(str, "|");
						new ii=strlen(str);
						for(new i=0;i<ii;i++)
							if(strfind(str[i],"|",false)==0)
								strmid(name,str,0,i);
								strmid(score,str,i+1,ii);
								format(score,sizeof(score),"(%s)",score);
								break;
						mysql_free_result();
						format(Top10Text[0],512,"%s\n%d.	%21s		%11s",Top10Text[0],x+1,name,score);
					SPD(playerid,D_TOP,0,"{00BFFF}Arena Minigun "W"TOP-10:",Top10Text[0],"Zamknij","Cofnij");
	            case 7:
	                strdel(Top10Text[0],0,512);
					for(new x=0;x<10;x++)
						new str[128];
						new name[25];
						new score[11];
						format(str,sizeof(str),"SELECT Name,RPGScore FROM "PREFIX"Users ORDER BY `RPGScore` DESC, `Name` ASC LIMIT %d , %d",x,x+1);
						mysql_query(str);
						mysql_store_result();
						mysql_fetch_row(str, "|");
						new ii=strlen(str);
						for(new i=0;i<ii;i++)
							if(strfind(str[i],"|",false)==0)
								strmid(name,str,0,i);
								strmid(score,str,i+1,ii);
								format(score,sizeof(score),"(%s)",score);
								break;
						mysql_free_result();
						format(Top10Text[0],512,"%s\n%d.	%21s		%11s",Top10Text[0],x+1,name,score);
					SPD(playerid,D_TOP,0,"{00BFFF}Arena RPG "W"TOP-10:",Top10Text[0],"Zamknij","Cofnij");
	            case 8:
	                strdel(Top10Text[0],0,512);
					for(new x=0;x<10;x++)
						new str[128];
						new name[25];
						new score[11];
						format(str,sizeof(str),"SELECT Name,DriftScore FROM "PREFIX"Users ORDER BY `DriftScore` DESC, `Name` ASC LIMIT %d , %d",x,x+1);
						mysql_query(str);
						mysql_store_result();
						mysql_fetch_row(str, "|");
						new ii=strlen(str);
						for(new i=0;i<ii;i++)
							if(strfind(str[i],"|",false)==0)
								strmid(name,str,0,i);
								strmid(score,str,i+1,ii);
								format(score,sizeof(score),"(%s)",score);
								break;
						mysql_free_result();
						format(Top10Text[0],512,"%s\n%d.	%21s		%11s",Top10Text[0],x+1,name,score);
					SPD(playerid,D_TOP,0,"{00BFFF}Drifting "W"TOP-10:",Top10Text[0],"Zamknij","Cofnij");
	            case 9:
	                strdel(Top10Text[0],0,512);
					for(new x=0;x<10;x++)
						new str[128];
						new name[25];
						new score[11];
						format(str,sizeof(str),"SELECT Name,Kodow FROM "PREFIX"Users ORDER BY `Kodow` DESC, `Name` ASC LIMIT %d , %d",x,x+1);
						mysql_query(str);
						mysql_store_result();
						mysql_fetch_row(str, "|");
						new ii=strlen(str);
						for(new i=0;i<ii;i++)
							if(strfind(str[i],"|",false)==0)
								strmid(name,str,0,i);
								strmid(score,str,i+1,ii);
								format(score,sizeof(score),"(%s)",score);
								break;
						mysql_free_result();
						format(Top10Text[0],512,"%s\n%d.	%21s		%11s",Top10Text[0],x+1,name,score);
					SPD(playerid,D_TOP,0,"{00BFFF}Przepisanych Kodów "W"TOP-10:",Top10Text[0],"Zamknij","Cofnij");
	            case 10:
	                strdel(Top10Text[0],0,512);
					for(new x=0;x<10;x++)
						new str[128];
						new name[25];
						new score[11];
						format(str,sizeof(str),"SELECT Name,CombatScore FROM "PREFIX"Users ORDER BY `CombatScore` DESC, `Name` ASC LIMIT %d , %d",x,x+1);
						mysql_query(str);
						mysql_store_result();
						mysql_fetch_row(str, "|");
						new ii=strlen(str);
						for(new i=0;i<ii;i++)
							if(strfind(str[i],"|",false)==0)
								strmid(name,str,0,i);
								strmid(score,str,i+1,ii);
								format(score,sizeof(score),"(%s)",score);
								break;
						mysql_free_result();
						format(Top10Text[0],512,"%s\n%d.	%21s		%11s",Top10Text[0],x+1,name,score);
					SPD(playerid,D_TOP,0,"{00BFFF}Arena Combat "W"TOP-10:",Top10Text[0],"Zamknij","Cofnij");
                case 11:
	                strdel(Top10Text[0],0,530);
					for(new x=0;x<10;x++)
						new str[140];
						new name[25];
						new score[15];
						format(str,sizeof(str),"SELECT vOwner,vPrzebieg FROM "PREFIX"Vehicles ORDER BY `vPrzebieg` DESC, `vOwner` ASC LIMIT %d , %d",x,x+1);
						mysql_query(str);
						mysql_store_result();
						mysql_fetch_row(str, "|");
						new ii=strlen(str);
						for(new i=0;i<ii;i++)
							if(strfind(str[i],"|",false)==0)
								strmid(name,str,0,i);
								strmid(score,str,i+1,ii);
								format(score,sizeof(score),"(%.1f km)",strval(score)/1000.0);
								break;
						mysql_free_result();
						format(Top10Text[0],530,"%s\n%d.	%21s		%11s",Top10Text[0],x+1,name,score);
					SPD(playerid,D_TOP,0,"{00BFFF}Przebieg "W"TOP-10:",Top10Text[0],"Zamknij","Cofnij");
                case 12:
	                strdel(Top10Text[0],0,512);
					for(new x=0;x<10;x++)
						new str[128];
						new name[25];
						new score[11];
						format(str,sizeof(str),"SELECT Name,WygranychWG FROM "PREFIX"Users ORDER BY `WygranychWG` DESC, `Name` ASC LIMIT %d , %d",x,x+1);
						mysql_query(str);
						mysql_store_result();
						mysql_fetch_row(str, "|");
						new ii=strlen(str);
						for(new i=0;i<ii;i++)
							if(strfind(str[i],"|",false)==0)
								strmid(name,str,0,i);
								strmid(score,str,i+1,ii);
								format(score,sizeof(score),"(%s)",score);
								break;
						mysql_free_result();
						format(Top10Text[0],512,"%s\n%d.	%21s		%11s",Top10Text[0],x+1,name,score);
					SPD(playerid,D_TOP,0,"{00BFFF}Wygranych WG "W"TOP-10:",Top10Text[0],"Zamknij","Cofnij");
                case 13:
	                strdel(Top10Text[0],0,512);
					for(new x=0;x<10;x++)
						new str[128];
						new name[25];
						new score[11];
						format(str,sizeof(str),"SELECT Name,WygranychWS FROM "PREFIX"Users ORDER BY `WygranychWS` DESC, `Name` ASC LIMIT %d , %d",x,x+1);
						mysql_query(str);
						mysql_store_result();
						mysql_fetch_row(str, "|");
						new ii=strlen(str);
						for(new i=0;i<ii;i++)
							if(strfind(str[i],"|",false)==0)
								strmid(name,str,0,i);
								strmid(score,str,i+1,ii);
								format(score,sizeof(score),"(%s)",score);
								break;
						mysql_free_result();
						format(Top10Text[0],512,"%s\n%d.	%21s		%11s",Top10Text[0],x+1,name,score);
					SPD(playerid,D_TOP,0,"{00BFFF}Wygranych WS "W"TOP-10:",Top10Text[0],"Zamknij","Cofnij");
                case 14:
	                strdel(Top10Text[0],0,512);
					for(new x=0;x<10;x++)
						new str[128];
						new name[25];
						new score[11];
						format(str,sizeof(str),"SELECT Name,WygranychCH FROM "PREFIX"Users ORDER BY `WygranychCH` DESC, `Name` ASC LIMIT %d , %d",x,x+1);
						mysql_query(str);
						mysql_store_result();
						mysql_fetch_row(str, "|");
						new ii=strlen(str);
						for(new i=0;i<ii;i++)
							if(strfind(str[i],"|",false)==0)
								strmid(name,str,0,i);
								strmid(score,str,i+1,ii);
								format(score,sizeof(score),"(%s)",score);
								break;
						mysql_free_result();
						format(Top10Text[0],512,"%s\n%d.	%21s		%11s",Top10Text[0],x+1,name,score);
					SPD(playerid,D_TOP,0,"{00BFFF}Wygranych CH "W"TOP-10:",Top10Text[0],"Zamknij","Cofnij");
                case 15:
	                strdel(Top10Text[0],0,512);
					for(new x=0;x<10;x++)
						new str[128];
						new name[25];
						new score[11];
						format(str,sizeof(str),"SELECT Name,WygranychPB FROM "PREFIX"Users ORDER BY `WygranychPB` DESC, `Name` ASC LIMIT %d , %d",x,x+1);
						mysql_query(str);
						mysql_store_result();
						mysql_fetch_row(str, "|");
						new ii=strlen(str);
						for(new i=0;i<ii;i++)
							if(strfind(str[i],"|",false)==0)
								strmid(name,str,0,i);
								strmid(score,str,i+1,ii);
								format(score,sizeof(score),"(%s)",score);
								break;
						mysql_free_result();
						format(Top10Text[0],512,"%s\n%d.	%21s		%11s",Top10Text[0],x+1,name,score);
					SPD(playerid,D_TOP,0,"{00BFFF}Wygranych PB "W"TOP-10:",Top10Text[0],"Zamknij","Cofnij");
                case 16:
	                strdel(Top10Text[0],0,512);
					for(new x=0;x<10;x++)
						new str[128];
						new name[25];
						new score[11];
						format(str,sizeof(str),"SELECT Name,WygranychUS FROM "PREFIX"Users ORDER BY `WygranychUS` DESC, `Name` ASC LIMIT %d , %d",x,x+1);
						mysql_query(str);
						mysql_store_result();
						mysql_fetch_row(str, "|");
						new ii=strlen(str);
						for(new i=0;i<ii;i++)
							if(strfind(str[i],"|",false)==0)
								strmid(name,str,0,i);
								strmid(score,str,i+1,ii);
								format(score,sizeof(score),"(%s)",score);
								break;
						mysql_free_result();
						format(Top10Text[0],512,"%s\n%d.	%21s		%11s",Top10Text[0],x+1,name,score);
					SPD(playerid,D_TOP,0,"{00BFFF}Wygranych US "W"TOP-10:",Top10Text[0],"Zamknij","Cofnij");
                case 17:
	                strdel(Top10Text[0],0,512);
					for(new x=0;x<10;x++)
						new str[128];
						new name[25];
						new score[11];
						format(str,sizeof(str),"SELECT Name,WygranychSN FROM "PREFIX"Users ORDER BY `WygranychSN` DESC, `Name` ASC LIMIT %d , %d",x,x+1);
						mysql_query(str);
						mysql_store_result();
						mysql_fetch_row(str, "|");
						new ii=strlen(str);
						for(new i=0;i<ii;i++)
							if(strfind(str[i],"|",false)==0)
								strmid(name,str,0,i);
								strmid(score,str,i+1,ii);
								format(score,sizeof(score),"(%s)",score);
								break;
						mysql_free_result();
						format(Top10Text[0],512,"%s\n%d.	%21s		%11s",Top10Text[0],x+1,name,score);
					SPD(playerid,D_TOP,0,"{00BFFF}Wygranych SN "W"TOP-10:",Top10Text[0],"Zamknij","Cofnij");
		else
			cmd_statystyki(playerid);
	if(dialogid == D_PLAYER && response)
        new userid = Player[playerid][ClickedPlayer];
		switch(listitem)
			case 0:
                if(Player[playerid][TPRefused] > 0)
					new String[90];
					format(String,sizeof(String),""WE" "R"Możesz tego użyć dopiero za %d sekund.",Player[playerid][TPRefused]);
					SCM(playerid, C_RED, String);
					return 1;
    			GoTo(playerid, userid);
				Player[playerid][ClickedPlayer] = -1;
			case 1:
				ShowPlayerStats(playerid, userid);
			case 2:
				SPD(playerid, D_WYSLIJ_KASE, DIALOG_STYLE_INPUT,"{00BFFF}Wysyłanie kasy", "Podaj kwotę do wysłania:", "Wyślij", "Cofnij");
			case 3:
                SPD(playerid, D_WYSLIJ_RAPORT, DIALOG_STYLE_INPUT,"{00BFFF}Raportowanie gracza", "Wpisz powód raportu:", "Wyślij", "Cofnij");
            case 4:
                SPD(playerid, D_WYSLIJ_HITMAN, DIALOG_STYLE_INPUT,"{00BFFF}Nagroda za głowę", "Wpisz kwotę, którą chcesz wysłać jako nagrodę:", "Wyślij", "Cofnij");
    if(dialogid == D_TP)
	    new PlayerTP;
    	foreach(Player,userid)
		    if(Player[userid][TPTo] == playerid)
		        PlayerTP = userid;
		        break;
	    if(response)
			TeleportPlayer(PlayerTP, playerid);
			SCM(PlayerTP, C_GREEN, ""WI" "G"Gracz zaakceptował zaproszenie.");
	    else
   			Player[playerid][TPRefused] = 30;
			SCM(PlayerTP, C_ERROR, ""WI" "R"Gracz odrzucił zaproszenie.");
	    Player[PlayerTP][TPTo] = INVALID_PLAYER_ID;
	    return 1;
	if(dialogid == D_SOLO)
        if(response)
			if(!SoloON)
				SCM(Player[playerid][SoloWyzywa],C_GREEN,""WI" "G"Rywal zaakceptował wyzwanie!");
				new x = Player[playerid][SoloWyzywa];
				StartSolo(playerid,x,Player[x][SoloBron]);
	else{
				SCM(Player[playerid][SoloWyzywa],C_ERROR,""WE" "R"Rywal zaakceptował wyzwanie, jednak ktoś już wcześniej rozpoczął solowkę.");
				SCM(playerid,C_WHITE,""E" "W"Już trwa jakaś solówka!");
	else{
			SCM(Player[playerid][SoloWyzywa],C_WHITE,""E" "W"Przeciwnik nie zaakceptował twojego wyzwania!");
	if(dialogid == D_TUTORIAL)
		if(response)
 			Player[playerid][TutID] ++;
			if(Player[playerid][TutID] == 1)
				InterpolateCameraPos(playerid, -2783.022460, 2103.674560, 91.013916, -1690.793823, 2500.949951, 99.348190, 30000);
				InterpolateCameraLookAt(playerid, -2780.884033, 2099.164794, 91.310615, -1687.567260, 2504.759521, 99.070991, 30000);
	            SPD(playerid, D_TUTORIAL, DIALOG_STYLE_MSGBOX, "{00BFFF}Tutorial "W"(2/8) - Osiągnięcia", "Na serwerze jest też system zdobywania osiągnięć!\nWpisz /Osiagniecia aby zobaczyc listę dostępnych rzeczy do zrobienia.\nZa każde pełne osiągnięcie otrzymujesz premię exp + kasę!\nOsiągnięcia mogą zdobywać tylko zarejestrowani gracze.","Dalej","Zakończ");
			else if(Player[playerid][TutID] == 2)
				InterpolateCameraPos(playerid, -1709.834716, 2508.160156, 103.082077, -290.127807, 1699.173217, 153.249664, 30000);
				InterpolateCameraLookAt(playerid, -1705.250122, 2506.366455, 102.207695, -290.152282, 1694.516479, 151.429214, 30000);
	            SPD(playerid, D_TUTORIAL, DIALOG_STYLE_MSGBOX,
				"{00BFFF}Tutorial "W"(3/8) - Wirtualny Portfel",
				"Jak pewnie zauważyłeś(aś) na pasku jest okienko o nazwie portfel. Co to jest?\nKażdy użytkownik posiada na serwerze swój wirtualny portfel.\nZasilać go można poprzez wysyłanie sms /Portfel > Doładuj portfel.\nDzięki funduszom z wirtualnego portfela można opłacać takie rzeczy jak kupno VIP czy kupno punktów exp.\nŻaden gracz nie zna twojej kwoty w portfelu i kwota po wysłaniu sms aktualizuje się i zapisuje.",
				"Dalej","Zakończ");
            else if(Player[playerid][TutID] == 3)
				InterpolateCameraPos(playerid, -290.128295, 1699.173583, 153.249649, 1415.715209, 2237.243896, 68.606521, 30000);
				InterpolateCameraLookAt(playerid, -290.307067, 1694.530273, 151.403762, 1413.066650, 2233.645996, 66.361610, 30000);
	            SPD(playerid, D_TUTORIAL, DIALOG_STYLE_MSGBOX, "{00BFFF}Tutorial "W"(4/8) - VIP", "Na serwerze jest system kont premum VIP.\nDzięki takiemu kontu można np. otrzymać plecak odrzutowy itd.\nKonto premium kupuje się nie przez sms, ale za wirtualne pieniądze które poznałeś(aś) w poprzednim kroku.\nWięcej informacji znajdziesz pod komendą /vip.","Dalej","Zakończ");
            else if(Player[playerid][TutID] == 4)
				InterpolateCameraPos(playerid, 1415.714965, 2237.243896, 68.606529, 2206.338134, 950.229736, 55.414661, 30000);
				InterpolateCameraLookAt(playerid, 1412.958984, 2233.666748, 66.459884, 2203.096191, 953.339172, 53.218753, 30000);
	            SPD(playerid, D_TUTORIAL, DIALOG_STYLE_MSGBOX,
				"{00BFFF}Tutorial "W"(5/8) - Rozgrywka/DM", "GoldServer jest to typ gry Freeroam/DM.\nCzyli jest to wolna rozgrywka po całym świecie San Andreas aż po dodatkowe obiekty stworzone przez naszych obiekterów.\nNa serwerze istnieją specjalne strefy do DM takie jak np. Strefa Śmierci (Wojsko/RPG/Minigun/Onede) czy też /ArenaSolo.\nMożna tam odbywać solówki z innymi graczami i dostawać się do TOP listy punktów solówek :)\nAby wyzwać gracza wpisz /SoloWyzwij [ID] [ID_Broni]",
				"Dalej","Zakończ");
            else if(Player[playerid][TutID] == 5)
				InterpolateCameraPos(playerid, 2206.338134, 950.229736, 55.414661, 2398.927246, -218.912811, 97.481208, 30000);
				InterpolateCameraLookAt(playerid, 2202.834472, 953.341674, 53.670848, 2396.752929, -214.602432, 96.179954, 30000);
	            SPD(playerid, D_TUTORIAL, DIALOG_STYLE_MSGBOX, "{00BFFF}Tutorial "W"(6/8) - Społeczność WWW", "Strona internetowa naszego serwera to: "WWW"\nZachęcamy serdecznie do rejestracji na forum i do częstego przebywania na nim.\nBędąc na forum będziesz zawsze informowany na bierząco o dostępnych aktualnościach/rekrutacjach na konta premium.","Dalej","Zakończ");
            else if(Player[playerid][TutID] == 6)
				InterpolateCameraPos(playerid, 2398.927246, -218.912231, 97.481185, 1326.757324, -859.138977, 90.864685, 30000);
				InterpolateCameraLookAt(playerid, 2395.910400, -215.143173, 96.179939, 1331.301147, -857.054199, 90.778755, 30000);
	            SPD(playerid, D_TUTORIAL, DIALOG_STYLE_MSGBOX, "{00BFFF}Tutorial "W"(7/8) - Bank", "Chcesz przechować swoje pieniądze? Nie chcesz tracić ich po śmierci?\nSkorzystaj z usług bankowych serwera pod komendą /Bank.\nMożesz tam wplacać/wypłacać swoje pieniądze bez żadnych prowizji/odsetek.\nMożesz również dokonywać przelewów bankowych do innych graczy będących online.\nPieniądze w banku są zapisywane i aktualizowane a przede wszystkim bezpieczne :)","Dalej","Zakończ");
            else if(Player[playerid][TutID] == 7)
				InterpolateCameraPos(playerid, 1326.757690, -859.138793, 90.864685, 2495.427490, -1691.378173, 15.385376, 30000);
				InterpolateCameraLookAt(playerid, 1331.263916, -856.978820, 90.696746, 2495.334228, -1686.401000, 14.917314, 30000);
	            SPD(playerid, D_TUTORIAL, DIALOG_STYLE_MSGBOX,
				"{00BFFF}Tutorial "W"(8/8) - Zakończenie", "No to najważniejsze informacje serwerowe już poznałeś.\nTeraz poznasz kilka przydatnych komend przydających się w życiu:\n\n/NRG - Spawnujesz prywatne nrg\n/Cars - Lista aut do spawnu\n/Bronie - Lista broni do kupienia\n/Atrakcje - Lista atrakcji\n/Teles - Teleporty serwera\n/Konto - Panel zarządzania kontem\n\nŻyczymy miłej gry na serwerze i jak najwięcej wrażeń!\nAdministracja","Zakończ","Zakończ");
            else if(Player[playerid][TutID] == 8)
	            SetCameraBehindPlayer(playerid);
				TogglePlayerControllable(playerid, 1);
			    Player[playerid][TutID] = 0;
		else
			EndTutorialForPlayer(playerid);
    if(dialogid == D_WEAPON && response)
		switch(listitem)
  			case 0: SellPlayerWeapon(playerid,1,1,1000);
			case 1: SellPlayerWeapon(playerid,2,1,1500);
            case 2: SellPlayerWeapon(playerid,3,1,2000);
			case 3: SellPlayerWeapon(playerid,4,1,2000);
			case 4: SellPlayerWeapon(playerid,5,1,3000);
            case 5: SellPlayerWeapon(playerid,6,1,3000);
			case 6: SellPlayerWeapon(playerid,8,1,5000);
			case 7: SellPlayerWeapon(playerid,9,1,6000);
			case 8: SellPlayerWeapon(playerid,14,1,500); //Kwiaty
			case 9: SPD(playerid, D_TLUMIK, DIALOG_STYLE_LIST,"{00BFFF}Typ broni","› Z tłumikiem\n"GUI2"› Bez tłumika","Wybierz","Cofnij"); //9MM
			case 10: SellPlayerWeapon(playerid,25,300,5000);
			case 11: SellPlayerWeapon(playerid,27,500,5500);
			case 12: SellPlayerWeapon(playerid,26,300,7000);
			case 13: SellPlayerWeapon(playerid,28,1000,5000);
			case 14: SellPlayerWeapon(playerid,32,1000,5000);
			case 15: SellPlayerWeapon(playerid,33,200,3500);
			case 16: SellPlayerWeapon(playerid,34,100,10000);
            case 17: SellPlayerWeapon(playerid,41,1000,3000);
			case 18: SellPlayerWeapon(playerid,43,100,500);
			case 19: SellPlayerWeapon(playerid,31,700,12000);
			case 20: SellPlayerWeapon(playerid,30,800,8000);
			case 21: SellPlayerWeapon(playerid,29,900,5500);
			case 22: SellPlayerWeapon(playerid,24,300,4000);
    if(dialogid == D_TLUMIK)
		if(response)
		    switch(listitem)
		    	case 0: SellPlayerWeapon(playerid,23,500,4000);
				case 1: SellPlayerWeapon(playerid,22,500,4000);
		else
            SPD(playerid, D_WEAPON, DIALOG_STYLE_LIST,
			"Kupno broni", "› Kastet - 1000$\n› Kij Golfowy - 1500$\n› Pałka Policyjna - 2500$\n› Nóż - 2000$\n› Pałka Golfowa - 3000$\n› Łopata - 3000$\n› Katana - 5000$\n› Piła Łańcuchowa - 6000$\n› Kwiaty - 500$\n› Pistolet (9-MM) - 4000$\n› Shotgun - 5000$\n› Combat Shotgun - 5500$\n› Sawn Off Shotgun - 7000$\n› Uzi - 5000$\n› TEC9 - 5000$\n› Wiatrówka - 3500$\n› Sniper-Rifle - 10000$\n› Spray - 3000$\n› Aparat - 500$\n› M4 - 12000$\n› AK-47 - 8000$\n› MP5 - 5500$\n› Desert Eagle - 4000$",
			"Wybierz", "Anuluj");
	if(dialogid == D_TOP && !response)
        new String[450];
		format(String,sizeof(String),
		""W"› Exp\n"GUI2"› Skill\n"W"› Śmierci\n"GUI2"› Czas gry\n"W"› Arena Solo\n"GUI2"› Arena Onede\n"W"› Arena Minigun\n"GUI2"› Arena RPG\n"W"› Drifting\n"GUI2"› Przepisanych Kodów\n"W"› Arena Combat\n"GUI2"› Przebieg\n"W"› Wygranych WG\n"GUI2"› Wygranych WS\n"W"› Wygranych CH\n"GUI2"› Wygranych PB\n"W"› Wygranych US\n"GUI2"› Wygranych SN");
		SPD(playerid,D_STATY_TOP,DIALOG_STYLE_LIST,"{00BFFF}Listy TOP-10",String,"Wybierz","Cofnij");
    if(dialogid == D_LASER && response)
	    switch(listitem)
	        case 0:
	            if(LaserID[playerid] == 0 || LaserID[playerid] >= 2)
		            LaserID[playerid] = 1;
		            SCM(playerid,C_LIGHTGREEN,""WI" "G" Zainstalowałeś Czerwony Laser w swojej broni!");
		            TogglePlayerControllable(playerid,1);
	            else
	                SCM(playerid,C_ERROR,""WI" "G" Masz już laser w swojej broni!");
	                TogglePlayerControllable(playerid,1);
			case 1:
                if(LaserID[playerid] <= 1 || LaserID[playerid] >= 3)
		            LaserID[playerid] = 2;
		            SCM(playerid,C_LIGHTGREEN,""WI" "G" Zainstalowałeś Niebieski Laser w swojej broni!");
		            TogglePlayerControllable(playerid,1);
	            else
	                SCM(playerid,C_ERROR,""WI" "G" Masz już laser w swojej broni!");
	                TogglePlayerControllable(playerid,1);
			case 2:
                if(LaserID[playerid] <= 2 || LaserID[playerid] >= 4)
		            LaserID[playerid] = 3;
		            SCM(playerid,C_LIGHTGREEN,"Zainstalowaleś Fioletowy Laser w swojej broni!");
		            TogglePlayerControllable(playerid,1);
	            else
	                SCM(playerid,C_ERROR,""WI" "G" Masz już laser w swojej broni!");
	                TogglePlayerControllable(playerid,1);
			case 3:
                if(LaserID[playerid] <= 3 || LaserID[playerid] >= 5)
		            LaserID[playerid] = 4;
		            SCM(playerid,C_LIGHTGREEN,"Zainstalowaleś Pomaranczowy Laser w swojej broni!");
		            TogglePlayerControllable(playerid,1);
	            else
	                SCM(playerid,C_ERROR,""WI" "G" Masz już laser w swojej broni!");
	                TogglePlayerControllable(playerid,1);
			case 4:
                if(LaserID[playerid] <= 4 || LaserID[playerid] >= 6)
		            LaserID[playerid] = 5;
		            SCM(playerid,C_LIGHTGREEN,"Zainstalowaleś Zielony Laser w swojej broni!");
		            TogglePlayerControllable(playerid,1);
	            else
	                SCM(playerid,C_ERROR,""WI" "G" Masz już laser w swojej broni!");
	                TogglePlayerControllable(playerid,1);
			case 5:
                if(LaserID[playerid] <= 5 || LaserID[playerid] >= 7)
		            LaserID[playerid] = 6;
		            SCM(playerid,C_LIGHTGREEN,"Zainstalowaleś Zółty Laser w swojej broni!");
		            TogglePlayerControllable(playerid,1);
	            else
	                SCM(playerid,C_ERROR,""WI" "G" Masz już laser w swojej broni!");
	                TogglePlayerControllable(playerid,1);
			case 6:
                if(LaserID[playerid] >= 1)
		            LaserID[playerid] = 0;
		            SCM(playerid,C_LIGHTGREEN,""WI" "G" Wyłączyłeślaser w swojej broni!");
		            RemovePlayerAttachedObject(playerid, SLOT_LASER);
	    			RemovePlayerAttachedObject(playerid, SLOT_LASER2);
		            TogglePlayerControllable(playerid,1);
	            else
	                TogglePlayerControllable(playerid,1);
    if(dialogid == D_NBRONIE)
        switch(listitem)
        	case 0:
         		RemovePlayerAttachedObject(playerid,SLOT_NBRONIE);
         		SetPlayerAttachedObject(playerid, SLOT_NBRONIE, 2044, 6, 0.100000, 0.000000, 0.000000, -90.000000, 0.000000, 180.000000, 2.500000, 3.20000, 5.00000 ); // CJ_MP5K - Replaces MP5
			case 1:
 				RemovePlayerAttachedObject(playerid,SLOT_NBRONIE);
 				SetPlayerAttachedObject(playerid, SLOT_NBRONIE, 2045, 6, 0.039999, 0.000000, 0.250000, 90.000000, 0.000000, 0.000000, 3.800000, 1.300000, 3.800000 ); // CJ_BBAT_NAILS - Replaces Bat
			case 2:
 				RemovePlayerAttachedObject(playerid,SLOT_NBRONIE);
 				SetPlayerAttachedObject(playerid, SLOT_NBRONIE, 2036, 6, 0.300000, 0.0000000, 0.020000, 90.000000, 358.000000, 0.000000, 1.000000,1.90000, 3.000000 ); // CJ_psg1 - Replaces ak47
 			case 3:
 				RemovePlayerAttachedObject(playerid,SLOT_NBRONIE);
 				SetPlayerAttachedObject(playerid, SLOT_NBRONIE, 2976, 6, -0.100000, 0.000000, 0.100000, 0.000000, 80.000000, 0.000000, 1.000000, 1.000000, 1.500000 ); // green_gloop - Replaces Spas
			case 4:
                RemovePlayerAttachedObject(playerid,SLOT_NBRONIE);
		return 1;
    if(dialogid == D_NEONY && response)
		if(!response || !IsPlayerInAnyVehicle(playerid)) return 1;
		new vid = GetPlayerVehicleID(playerid);
		DestroyNeon(vid);
		if(listitem == 12) return 1;
		switch(listitem)
  			case 0:
				vNeon[vid][0] = CreateObject(18647,0,0,0,0,0,0, 100.0);
				vNeon[vid][1] = -1;
			case 1:
				vNeon[vid][0] = CreateObject(18649,0,0,0,0,0,0, 100.0);
				vNeon[vid][1] = -1;
			case 2:
				vNeon[vid][0] = CreateObject(18652,0,0,0,0,0,0, 100.0);
				vNeon[vid][1] = -1;
			case 3:
 				vNeon[vid][0] = CreateObject(18651,0,0,0,0,0,0, 100.0);
				vNeon[vid][1] = -1;
			case 4:
 				vNeon[vid][0] = CreateObject(18650,0,0,0,0,0,0, 100.0);
				vNeon[vid][1] = -1;
			case 5:
				vNeon[vid][0] = CreateObject(18648,0,0,0,0,0,0, 100.0);
				vNeon[vid][1] = CreateObject(18649,0,0,0,0,0,0, 100.0);
			case 6:
				vNeon[vid][0] = CreateObject(18648,0,0,0,0,0,0, 100.0);
				vNeon[vid][1] = CreateObject(18652,0,0,0,0,0,0, 100.0);
			case 7:
				vNeon[vid][0] = CreateObject(18647,0,0,0,0,0,0, 100.0);
				vNeon[vid][1] = CreateObject(18652,0,0,0,0,0,0, 100.0);
			case 8:
				vNeon[vid][0] = CreateObject(18647,0,0,0,0,0,0, 100.0);
				vNeon[vid][1] = CreateObject(18650,0,0,0,0,0,0, 100.0);
			case 9:
				vNeon[vid][0] = CreateObject(18649,0,0,0,0,0,0, 100.0);
				vNeon[vid][1] = CreateObject(18652,0,0,0,0,0,0, 100.0);
            case 10:
				vNeon[vid][0] = CreateObject(18648,0,0,0,0,0,0, 100.0);
				vNeon[vid][1] = -1;
			case 11:
				vNeon[vid][0] = CreateObject(18652,0,0,0,0,0,0, 100.0);
				vNeon[vid][1] = CreateObject(18650,0,0,0,0,0,0, 100.0);
		if(vNeon[vid][1] != -1)
			AttachObjectToVehicle(vNeon[vid][1], vid, 0.0, 0.0, -0.70, 0.0, 0.0, 0.0);
		AttachObjectToVehicle(vNeon[vid][0], vid, 0.0, 0.0, -0.70, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, C_WHITE, ""I" "W"Neon zainstalowany!");
		return 1;
	if(dialogid == D_AUTO && response)
	    switch(listitem)
			case 0: SPD(playerid, D_SILNIK, DIALOG_STYLE_MSGBOX, "{00BFFF}Silnik", "Wyłącz lub Odpal silnik:", "Odpal", "Zgaś");
			case 1: SPD(playerid, D_SWIATLA, DIALOG_STYLE_MSGBOX, "{00BFFF}Światła", "Wyłącz lub Włącz światła:\n\n(Światła widoczne są tylko w nocy)", "Włącz", "Wyłącz");
			case 2: SPD(playerid, D_ALARM, DIALOG_STYLE_MSGBOX, "{00BFFF}Alarm", "Wyłącz lub włącz auto alarm:", "Włącz", "Wyłącz");
			case 3: SPD(playerid, D_DRZWI, DIALOG_STYLE_MSGBOX, "{00BFFF}Drzwi", "Zamknij lub otwórz drzwi pojazdu:", "Otwórz", "Zamknij");
			case 4: SPD(playerid, D_BAGAZNIK, DIALOG_STYLE_MSGBOX, "{00BFFF}Maska", "Otwórz lub zamknij maskę.", "Otwórz", "Zamknij");
			case 5: SPD(playerid, D_MASKA, DIALOG_STYLE_MSGBOX, "{00BFFF}Bagażnik", "Otwórz lub zamknij bagażnik.", "Otwórz", "Zamknij");
			case 6: SPD(playerid, D_TABLICA_TEXT,DIALOG_STYLE_INPUT, "{00BFFF}Numery pojazdu", "Wpisz treść tablicy rejestracyjnej:", "Zmień", "Cofnij");
		return 1;
	if(dialogid == D_SILNIK)
	    if(response)
            SCM(playerid, 0x08FD04FF, ""WI" "G" Silnik pojazdu uruchomiony.");
           	GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
            SetVehicleParamsEx(GetPlayerVehicleID(playerid), 1, lights, alarm, doors, bonnet, boot, objective);
	    else
            SCM(playerid, 0x08FD04FF, ""WI" "G" Silnik pojazdu zgaszony.");
           	GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
            SetVehicleParamsEx(GetPlayerVehicleID(playerid), 0, lights, alarm, doors, bonnet, boot, objective);
        SPD(playerid,D_AUTO,DIALOG_STYLE_LIST,"{00BFFF}Kontrola Pojazdu","› Silnik\n"GUI2"› Światła\n"W"› Alarm\n"GUI2"› Drzwi\n"W"› Bagażnik\n"GUI2"› Maska\n"W"› Tablica Rejestracyjna","Wybierz","Zamknij");
    if(dialogid == D_SWIATLA)
	    if(response)
            SCM(playerid, 0x08FD04FF, ""WI" "G" Światła pojazdu zostały włączone.");
           	GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
            SetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, 1, alarm, doors, bonnet, boot, objective);
	    else
            SCM(playerid, 0x08FD04FF, ""WI" "G" Światła pojazdu zostały wyłączone.");
           	GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
            SetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, 0, alarm, doors, bonnet, boot, objective);
        SPD(playerid,D_AUTO,DIALOG_STYLE_LIST,"{00BFFF}Kontrola Pojazdu","› Silnik\n"GUI2"› Światła\n"W"› Alarm\n"GUI2"› Drzwi\n"W"› Bagażnik\n"GUI2"› Maska\n"W"› Tablica Rejestracyjna","Wybierz","Zamknij");
		return 1;
    if(dialogid == D_ALARM)
	    if(response)
            SCM(playerid, 0x08FD04FF, ""WI" "G" Auto Alarm został włączony.");
           	GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
            SetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, 1, doors, bonnet, boot, objective);
	    else
            SCM(playerid, 0x08FD04FF, ""WI" "G" Auto Alarm został wyłączony.");
           	GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
            SetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, 0, doors, bonnet, boot, objective);
        SPD(playerid,D_AUTO,DIALOG_STYLE_LIST,"{00BFFF}Kontrola Pojazdu","› Silnik\n"GUI2"› Światła\n"W"› Alarm\n"GUI2"› Drzwi\n"W"› Bagażnik\n"GUI2"› Maska\n"W"› Tablica Rejestracyjna","Wybierz","Zamknij");
		return 1;
    if(dialogid == D_BAGAZNIK)
	    if(response)
            SCM(playerid, 0x08FD04FF, ""WI" "G" Bagażnik otworzony.");
           	GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
            SetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, 1, objective);
	    else
            SCM(playerid, 0x08FD04FF, ""WI" "G" Bagażnik zamknięty.");
           	GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
            SetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, 0, objective);
        SPD(playerid,D_AUTO,DIALOG_STYLE_LIST,"{00BFFF}Kontrola Pojazdu","› Silnik\n"GUI2"› Światła\n"W"› Alarm\n"GUI2"› Drzwi\n"W"› Bagażnik\n"GUI2"› Maska\n"W"› Tablica Rejestracyjna","Wybierz","Zamknij");
    if(dialogid == D_MASKA)
	    if(response)
            SCM(playerid, 0x08FD04FF, ""WI" "G" Maska otworzona.");
           	GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
            SetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, 1, boot, objective);
	    else
            SCM(playerid, 0x08FD04FF, ""WI" "G" Maska zamknięta.");
           	GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
            SetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, 0, boot, objective);
        SPD(playerid,D_AUTO,DIALOG_STYLE_LIST,"{00BFFF}Kontrola Pojazdu","› Silnik\n"GUI2"› Światła\n"W"› Alarm\n"GUI2"› Drzwi\n"W"› Bagażnik\n"GUI2"› Maska\n"W"› Tablica Rejestracyjna","Wybierz","Zamknij");
    if(dialogid == D_DRZWI)
	    if(response)
            SCM(playerid, 0x08FD04FF, ""WI" "G" Drzwi pojazdu otworzone.");
           	new veh = GetPlayerVehicleID(playerid);
			foreach(Player,i)
				if(i != playerid)
					SetVehicleParamsForPlayer(veh,i, 0, 1);
					VehicleLocked[veh] = i;
	    else
            SCM(playerid, 0x08FD04FF, ""WI" "G" Drzwi pojazdu zamknięte.");
            new veh = GetPlayerVehicleID(playerid);
			foreach(Player,i)
				if(i != playerid)
					SetVehicleParamsForPlayer(veh,i, 0, 0);
					VehicleLocked[veh] = -1;
        SPD(playerid,D_AUTO,DIALOG_STYLE_LIST,"{00BFFF}Kontrola Pojazdu","› Silnik\n"GUI2"› Światła\n"W"› Alarm\n"GUI2"› Drzwi\n"W"› Bagażnik\n"GUI2"› Maska\n"W"› Tablica Rejestracyjna","Wybierz","Zamknij");
	if(dialogid == D_TABLICA_TEXT)
        if(strlen(inputtext) < 1 || strlen(inputtext) > 8) return SCM(playerid, 0x08FD04FF, ""WI" "G" Niepoprawna długość tekstu! Od 1 do 8 znaków.");
		if(GetPlayerVehicleID(playerid) == vInfo[Player[playerid][pVeh]][vID]) return SCM(playerid, 0x08FD04FF, ""WI" "G" Niemożna użyć w prywatnym pojeździe.");
        new Float:Xq, Float:Yq, Float:Zq, Float:angle;
		if(response)
    		SCM(playerid, 0x08FD04FF, ""WI" "G" Numery pojazdu zmienione.");
			GetPlayerPos(playerid, Xq, Yq, Zq);
		    GetPlayerFacingAngle(playerid, angle);
		    SetVehicleNumberPlate(GetPlayerVehicleID(playerid), inputtext);
		    SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			SetVehicleZAngle(GetPlayerVehicleID(playerid), angle);
			PutPlayerInVehicle(playerid, GetPlayerVehicleID(playerid), 0);
			SetVehiclePos(GetPlayerVehicleID(playerid), Xq, Yq, Zq+2);
	    else
            SPD(playerid,D_AUTO,DIALOG_STYLE_LIST,"{00BFFF}Kontrola Pojazdu","› Silnik\n"GUI2"› Światła\n"W"› Alarm\n"GUI2"› Drzwi\n"W"› Bagażnik\n"GUI2"› Maska\n"W"› Tablica Rejestracyjna","Wybierz","Zamknij");
	if(dialogid == D_ARENY && response)
		switch(listitem)
			case 0:
				cmd_minigun(playerid);
			case 1:
                cmd_rpg(playerid);
			case 2:
                cmd_onede(playerid);
			case 3:
				cmd_combat(playerid);
	if(dialogid == D_HOUSE_NIEKUPIONY)
		if(response)
			switch(listitem)
			    case 0:
	                if(!Player[playerid][Registered])
	        			return SCM(playerid, C_WHITE, ""E" "W"Nie jesteś zarejestrowany(a)!");
					PlayerBuyHouse(playerid, Player[playerid][House], hInfo[Player[playerid][House]][hCzynsz]);
			    case 1:
					new HouseId = Player[playerid][House];
					SetPlayerPos(playerid, hInfo[HouseId][hInX],hInfo[HouseId][hInY],hInfo[HouseId][hInZ]);
					SetPlayerInterior(playerid, hInfo[HouseId][hInterior]);
					SetPlayerVirtualWorld(playerid, HouseId);
				    SetPlayerFacingAngle(playerid, hInfo[HouseId][hAngle]);
					SCM(playerid, C_GREEN, ""WI" "G"Jesteś w domu. :)");
					SCM(playerid, C_GREEN, ""WI" "G"Aby opuścić dom wpisz /wyjdz");
					GameTextForPlayer(playerid, "~w~Wpisz /wyjdz~n~by opuscic dom.", 2499, 3);
				    Player[playerid][InHouse] = true;
                    Player[playerid][NearHouse] = false;
    				Player[playerid][ObokHouse] = true;
					KillTimer(Player[playerid][HouseTimer]);
					Player[playerid][HouseTimer] = SetTimerEx("PlayerLeaveHouse",15000,0,"ii",playerid,Player[playerid][House]);
					SCM(playerid, C_GREEN, ""WI" "G"Masz 15 sekund na obejżenie domku.");
		if(!response)
            Player[playerid][ObokHouse] = false;
            Player[playerid][NearHouse] = false;
    if(dialogid == D_CREATE_HOUSE)
	    if(!response)
	        Player[playerid][HouseStep] = 0;
	        return 1;
	    if(Player[playerid][HouseStep] == 3)
            if(FindSQLInjection(inputtext))
		        SPD(playerid, D_CREATE_HOUSE, DIALOG_STYLE_INPUT, "{00BFFF}Nowy dom", "Nazwa nie może posiadać zapytań i znaków specjalnych\n\nPodaj nazwę nowego domu:", "Zapisz", "Anuluj");
			    return 1;
			/*
			if(!FindValidText(inputtext))
	            SPD(playerid, D_CREATE_HOUSE, DIALOG_STYLE_INPUT, "{00BFFF}Nowy dom", "dom nie może posiadać znaków specjalnych\n\nPodaj nazwę nowego domu:", "Zapisz", "Anuluj");
			    return 1;
			*/
			if(strlen(inputtext) < 1)
			    SPD(playerid, D_CREATE_HOUSE, DIALOG_STYLE_INPUT, "{00BFFF}Nowy dom", "Nie podano nazwy domu.\n\nPodaj nazwę nowego domu:", "Zapisz", "Anuluj");
			    return 1;
	        if(strlen(inputtext) > 32)
			    SPD(playerid, D_CREATE_HOUSE, DIALOG_STYLE_INPUT, "{00BFFF}Nowy dom", "Nazwa domu jest za długa.\n\nPodaj nazwę nowego domu (exp):", "Zapisz", "Anuluj");
			    return 1;
			format(Player[playerid][NewHouseName],32,inputtext);
		    Player[playerid][HouseStep] = 4;
			SPD(playerid, D_CREATE_HOUSE, DIALOG_STYLE_INPUT, "{00BFFF}Nowy dom", "Podaj cenę nowego domu:", "Zapisz", "Anuluj");
	        return 1;
		if(Player[playerid][HouseStep] == 4)
		    if(strlen(inputtext) < 1 || strval(inputtext) < 1 || strval(inputtext) > 999999)
				SPD(playerid, D_CREATE_HOUSE, DIALOG_STYLE_INPUT, "{00BFFF}Nowy dom", "Podano niepoprawną sumę\n\nPodaj cenę nowego domu (exp):", "Zapisz", "Anuluj");
		        return 1;
			TotalHouses ++;
			new bool:Block = true;
            for(new x=0;x<MAX_HOUSES;x++)
				if(!HouseExists(x) && Block)
                    new String[270];
				    format(String,sizeof(String), "INSERT INTO "PREFIX"Houses VALUES('%d','%s','0','%f','%f','%f','%f','%f','%f','0','%d','0','%d','%f')",x,Player[playerid][NewHouseName],Player[playerid][NewHouseOutX],Player[playerid][NewHouseOutY],Player[playerid][NewHouseOutZ],Player[playerid][NewHouseInX],Player[playerid][NewHouseInY],Player[playerid][NewHouseInZ],strval(inputtext),Player[playerid][NewHouseInterior],Player[playerid][NewHouseAngle]);
					mysql_query(String);
					Block = false;
			SCM(playerid, C_GREEN, ""WI" "G"Dom został utworzony.");
  			LoadHouses();
		    return 1;
	    return 1;
	if(dialogid == D_HOUSE_KUPIONY)
		if(response)
			switch(listitem)
				case 0:
					if(Player[playerid][Zapukal] > 0)
	                    SCM(playerid, C_WHITE, ""E" "W"Odczekaj 5 sekund zanim zapukasz ponownie!");
						return 1;
					new userid = GetPlayerIdFromName(hInfo[Player[playerid][House]][hOwner]);
					SCM(playerid, C_WHITE, ""I" "W"Pukasz do drzwi...");
                    Player[playerid][ObokHouse] = false;
                    Player[playerid][NearHouse] = false;
	                Player[playerid][Zapukal] = 5;
					PlaySoundForPlayer(playerid, 1150);
	                PlaySoundForPlayer(userid, 1150);
					new String[128];
					format(String,sizeof(String),""I" "W"%s puka do twojego mieszkania! Aby się teleportować wpisz /IdzDom.",Player[playerid][Name]);
					SCM(userid, C_WHITE,String);
				case 1:
					if(hInfo[Player[playerid][House]][hLocked] > 0)
	                    SCM(playerid, C_RED, ""WE" "R"Zamknięte!");
                        Player[playerid][ObokHouse] = false;
                        Player[playerid][NearHouse] = false;
						PlaySoundForPlayer(playerid,1085);
					else
						new HouseId = Player[playerid][House];
						SetPlayerPos(playerid, hInfo[HouseId][hInX],hInfo[HouseId][hInY],hInfo[HouseId][hInZ]);
						SetPlayerInterior(playerid, hInfo[HouseId][hInterior]);
						SetPlayerVirtualWorld(playerid, HouseId);
					    SetPlayerFacingAngle(playerid, hInfo[HouseId][hAngle]);
						SCM(playerid, C_GREEN, ""WI" "G"Jesteś w domu. :)");
						SCM(playerid, C_GREEN, ""WI" "G"Aby opuścić dom wpisz /wyjdz");
						GameTextForPlayer(playerid, "~w~Wpisz /wyjdz~n~by opuscic dom.", 2499, 3);
					    Player[playerid][InHouse] = true;
                        Player[playerid][NearHouse] = false;
	    				Player[playerid][ObokHouse] = true;
  		else
            Player[playerid][ObokHouse] = false;
            Player[playerid][NearHouse] = false;
	if(dialogid == D_HOUSE_KUPIONY_OWNER)
		if(response)
			switch(listitem)
			    case 0: PlayerEnterHouse(playerid, Player[playerid][HouseOwn]);
			    case 1: SPD(playerid, D_SELLHOUSE,DIALOG_STYLE_MSGBOX,hInfo[Player[playerid][HouseOwn]][hName], "Czy napewno chcesz sprzedać swój dom?\nUzyskasz zwrot exp w wysokości połowy opłaconego czynszu domu.","Sprzedaj","Cofnij");
			    case 2: SPD(playerid, D_SPAWN_HOUSE, DIALOG_STYLE_MSGBOX, hInfo[Player[playerid][HouseOwn]][hName], "Chcesz być spawnowany w domu\npo wejściu na serwer oraz po każdym zginięciu?", "Tak", "Nie");
			    case 3: SPD(playerid, D_CZYNSZ_HOUSE, DIALOG_STYLE_LIST, "Opłata czynszu", "› Opłata (EXP)\n"GUI2"› Opłata (Portfel)", "Wybierz", "Cofnij");
				case 4:
					new String[128];
					if(hInfo[Player[playerid][HouseOwn]][hLocked] > 0) //Jeżeli drzwi od domu są zamknięte
						hInfo[Player[playerid][HouseOwn]][hLocked] = 0;
	                    SCM(playerid, C_GREEN, ""WI" "G"Drzwi od domu zostały otwarte.");
	                    SPD(playerid,D_HOUSE_KUPIONY_OWNER,DIALOG_STYLE_LIST,hInfo[Player[playerid][HouseOwn]][hName],"› Wejdź\n"GUI2"› Sprzedaj\n"W"› Zmień spawn\n"GUI2"› Zapłać czynsz\n"W"› Otwórz/Zamknij drzwi\n"GUI2"› Sprawdź ważność","Wybierz","Zamknij");
					else
	                    hInfo[Player[playerid][HouseOwn]][hLocked] = 1;
	                    SCM(playerid, C_GREEN, ""WI" "G"Drzwi od domu zostały zamknięte.");
	                    SPD(playerid,D_HOUSE_KUPIONY_OWNER,DIALOG_STYLE_LIST,hInfo[Player[playerid][HouseOwn]][hName],"› Wejdź\n"GUI2"› Sprzedaj\n"W"› Zmień spawn\n"GUI2"› Zapłać czynsz\n"W"› Otwórz/Zamknij drzwi\n"GUI2"› Sprawdź ważność","Wybierz","Zamknij");
                    format(String,sizeof(String),"UPDATE `"PREFIX"Houses` SET hLocked='%d' WHERE `hID` = %d",hInfo[Player[playerid][HouseOwn]][hLocked],Player[playerid][HouseOwn]);
					mysql_query(String);
				case 5:
    				new String[128];
					format(String,sizeof(String),"Ważność twojego domu wynosi: %d dni.",hInfo[Player[playerid][HouseOwn]][hWaznosc]);
					SPD(playerid, D_WAZNOSC_HOUSE, DIALOG_STYLE_MSGBOX,hInfo[Player[playerid][HouseOwn]][hName], String, "Zamknij","Cofnij");
 		else
            Player[playerid][ObokHouse] = false;
            Player[playerid][NearHouse] = false;
	if(dialogid == D_SPAWN_HOUSE)
		if(response)
            Player[playerid][CheckHouseSpawn] = 1;
            SCM(playerid, C_GREEN, ""WI" "G"Teraz będziesz się spawnował w swoim domu. :)");
            SPD(playerid,D_HOUSE_KUPIONY_OWNER,DIALOG_STYLE_LIST,hInfo[Player[playerid][HouseOwn]][hName],"› Wejdź\n"GUI2"› Sprzedaj\n"W"› Zmień spawn\n"GUI2"› Zapłać czynsz\n"W"› Otwórz/Zamknij drzwi\n"GUI2"› Sprawdź ważność","Wybierz","Zamknij");
		else
            Player[playerid][CheckHouseSpawn] = 0;
            SCM(playerid, C_GREEN, ""WI" "G"Wyłączyłeś(aś) spawn w domu.");
            SPD(playerid,D_HOUSE_KUPIONY_OWNER,DIALOG_STYLE_LIST,hInfo[Player[playerid][HouseOwn]][hName],"› Wejdź\n"GUI2"› Sprzedaj\n"W"› Zmień spawn\n"GUI2"› Zapłać czynsz\n"W"› Otwórz/Zamknij drzwi\n"GUI2"› Sprawdź ważność","Wybierz","Zamknij");
	if(dialogid == D_CZYNSZ_HOUSE)
		if(response)
			switch(listitem)
				case 0: ShowCzynszDoZaplaty(playerid,Player[playerid][HouseOwn]);
				case 1: SPD(playerid,D_CONFIRM_CZYNSZ_HOUSE_PORTFEL,DIALOG_STYLE_MSGBOX, "Opłata czynszu", "Czy napewno chcesz opłacić dom za kwotę z portfela?\nKwota opłaty: 3 zł\nPrzedłużenie: 1 tydzień (7 dni)", "Opłać","Cofnij");
		else
            SPD(playerid,D_HOUSE_KUPIONY_OWNER,DIALOG_STYLE_LIST,hInfo[Player[playerid][HouseOwn]][hName],"› Wejdź\n"GUI2"› Sprzedaj\n"W"› Zmień spawn\n"GUI2"› Zapłać czynsz\n"W"› Otwórz/Zamknij drzwi\n"GUI2"› Sprawdź ważność","Wybierz","Zamknij");
	if(dialogid == D_CONFIRM_CZYNSZ_HOUSE)
		if(response)
			new HouseId = Player[playerid][HouseOwn];
			new String[155];
			if(Player[playerid][Exp] < hInfo[HouseId][hCzynsz])
   				SCM(playerid, C_RED, ""WI" "R"Nie posiadasz exp na opłatę tej kwoty!");
                Player[playerid][ObokHouse] = false;
            	Player[playerid][NearHouse] = false;
				return 1;
			Player[playerid][Exp] -= hInfo[HouseId][hCzynsz];
			hInfo[HouseId][hWaznosc] += 7;
			format(String,sizeof(String),""WI" "G"Opłaciłeś swój domek! Ważność: %d dni.",hInfo[HouseId][hWaznosc]);
			SCM(playerid, C_GREEN, String);
   			SPD(playerid, D_CZYNSZ_HOUSE, DIALOG_STYLE_LIST, "Opłata czynszu", "› Opłata (EXP)\n"GUI2"› Opłata (Portfel)", "Wybierz", "Cofnij");
			format(String,sizeof(String),"UPDATE `"PREFIX"Houses` SET hWaznosc='%d' WHERE hID='%d'",hInfo[HouseId][hWaznosc],HouseId);
			mysql_query(String);
			SavePlayer(playerid);
		else
            SPD(playerid, D_CZYNSZ_HOUSE, DIALOG_STYLE_LIST, "Opłata czynszu", "› Opłata (EXP)\n"GUI2"› Opłata (Portfel)", "Wybierz", "Cofnij");
    if(dialogid == D_CONFIRM_CZYNSZ_HOUSE_PORTFEL)
		if(response)
			new HouseId = Player[playerid][HouseOwn];
			new String[155];
			if(Player[playerid][Portfel] < 3)
   				SCM(playerid, C_RED, ""WI" "R"Nie posiadasz wystarczającej kwoty w portfelu. Doładuj portfel.");
                Player[playerid][ObokHouse] = false;
            	Player[playerid][NearHouse] = false;
				return 1;
			Player[playerid][Portfel] -= 3;
			hInfo[HouseId][hWaznosc] += 7;
			format(String,sizeof(String),""WI" "G"Opłaciłeś swój domek! Ważność: %d dni.",hInfo[HouseId][hWaznosc]);
			SCM(playerid, C_GREEN, String);
   			SPD(playerid, D_CZYNSZ_HOUSE, DIALOG_STYLE_LIST, "Opłata czynszu", "› Opłata (EXP)\n"GUI2"› Opłata (Portfel)", "Wybierz", "Cofnij");
			format(String,sizeof(String),"UPDATE `"PREFIX"Houses` SET hWaznosc='%d' WHERE hID='%d'",hInfo[HouseId][hWaznosc],HouseId);
			mysql_query(String);
            format(String,sizeof(String),"UPDATE `"PREFIX"Users` SET `Portfel` = `Portfel` - 3 WHERE Name='%s'",Player[playerid][Name]);
			mysql_query(String);
		else
            SPD(playerid, D_CZYNSZ_HOUSE, DIALOG_STYLE_LIST, "Opłata czynszu", "› Opłata (EXP)\n"GUI2"› Opłata (Portfel)", "Wybierz", "Cofnij");
	if(dialogid == D_SELLHOUSE)
		if(response)
			if(Player[playerid][HouseOwn] == -1) return 1;
			if(hInfo[Player[playerid][HouseOwn]][hID] != Player[playerid][HouseOwn]) return 1;
			new HouseId = Player[playerid][HouseOwn],ZwrotExp = hInfo[HouseId][hCzynsz]/2,String[255];
			format(String,sizeof(String),"UPDATE `"PREFIX"Houses` SET hOwner='0',hWaznosc='0' WHERE hID='%d'",HouseId);
			mysql_query(String);
			format(String,sizeof(String),"UPDATE "PREFIX"Users SET House='-1',HouseSpawn='0' WHERE Name='%s'",Player[playerid][Name]);
			mysql_query(String);
            format(hInfo[HouseId][hOwner],MAX_PLAYER_NAME,"0");
			Player[playerid][HouseOwn] = -1;
			Player[playerid][CheckHouseSpawn] = 0;
			Player[playerid][Exp] += ZwrotExp;
            if(Player[playerid][Level] < GetPlayerLevel(playerid))
				LevelUp(playerid);
			format(String,sizeof(String),"~w~Exp + ~b~~h~%d",ZwrotExp);
			GameTextForPlayer(playerid,String,1000, 1);
			SCM(playerid, C_BLUE, ""WI" "B"Sprzedałeś(aś) swój dom! Otrzymujesz exp w wysokości połowy czynszu domu.");
            Player[playerid][ObokHouse] = false;
            Player[playerid][NearHouse] = false;
			DestroyDynamicPickup(hInfo[HouseId][hPickup]);
		    DestroyDynamicMapIcon(hInfo[HouseId][hIcon]);
		    hInfo[HouseId][hPickup] = CreateDynamicPickup(1273, 1, hInfo[HouseId][hOutX], hInfo[HouseId][hOutY], hInfo[HouseId][hOutZ], 0, 0, -1, 40.0);
			hInfo[HouseId][hIcon] = CreateDynamicMapIcon(hInfo[HouseId][hOutX], hInfo[HouseId][hOutY], hInfo[HouseId][hOutZ], 31, -1, 0, 0, -1, 1000000.0);
			format(String,sizeof(String),"%s\nKoszt: %d exp",hInfo[HouseId][hName],hInfo[HouseId][hCzynsz]);
			UpdateDynamic3DTextLabelText(hInfo[HouseId][hLabel], 0xFFB400FF, String);
		else
            SPD(playerid,D_HOUSE_KUPIONY_OWNER,DIALOG_STYLE_LIST,hInfo[Player[playerid][HouseOwn]][hName],"› Wejdź\n"GUI2"› Sprzedaj\n"W"› Zmień spawn\n"GUI2"› Zapłać czynsz\n"W"› Otwórz/Zamknij drzwi\n"GUI2"› Sprawdź ważność","Wybierz","Zamknij");
	if(dialogid == D_WAZNOSC_HOUSE)
		if(response)
            Player[playerid][ObokHouse] = false;
            Player[playerid][NearHouse] = false;
		else
			SPD(playerid,D_HOUSE_KUPIONY_OWNER,DIALOG_STYLE_LIST,hInfo[Player[playerid][HouseOwn]][hName],"› Wejdź\n"GUI2"› Sprzedaj\n"W"› Zmień spawn\n"GUI2"› Zapłać czynsz\n"W"› Otwórz/Zamknij drzwi\n"GUI2"› Sprawdź ważność","Wybierz","Zamknij");
	if(dialogid == D_PVEH && response)
        if(TotalPrivCars == MAX_PRIVATE_VEHICLES-1)
	        SCM(playerid, C_ERROR, ""WE" "R"Wykorzystano limit prywatnych pojazdów! Poproś admina o pomoc.");
			return 1;
		new pojazd;
		pojazd = GetVehicleModelIDFromName(inputtext);
		if(pojazd < 400 || pojazd > 611)
			SCM(playerid, C_RED, ""WE" "R"Taki pojazd nie został znaleziony.");
			cmd_pojazd(playerid);
			return 1;
		if(pojazd == 592 || pojazd == 577 || pojazd == 520 || pojazd == 432 || pojazd == 425 || pojazd == 447 || pojazd == 406 || pojazd == 537 || pojazd == 538 || pojazd == 569 || pojazd == 570 || pojazd == 584 || pojazd == 590 || pojazd == 591 || pojazd == 606  || pojazd == 607 || pojazd == 608 || pojazd == 610 || pojazd == 611 || pojazd == 464 || pojazd == 465 || pojazd == 501 || pojazd == 564 || pojazd == 594 && !IsPlayerAdmin(playerid))
  			SCM(playerid, C_RED, ""WE" "R"Ten pojazd jest nie dozwolony!");
			cmd_pojazd(playerid);
			return 1;
		Player[playerid][PrivCarName] = pojazd;
		new String[155];
		format(String,sizeof(String), "Nazwa prywatnego pojazdu: %s\n\nCzy chcesz kontynuować? Jeżeli nie jesteś vipem zostanie ci odebrane 1500 exp.\nAby pojazd nie został skasowany\nmusisz być na serwerze co 5 dni.",CarList[pojazd-400]);
		SPD(playerid, D_CONFIRM_PVEH, DIALOG_STYLE_MSGBOX, "{00BFFF}Kupno Pojazdu", String, "Zakup", "Cofnij");
	if(dialogid == D_CONFIRM_PVEH)
		if(response)
			for(new x=0;x<sizeof(gRandomPlayerSpawns);x++)
				if(PlayerToPoint(50,playerid,gRandomPlayerSpawns[x][0],gRandomPlayerSpawns[x][1],gRandomPlayerSpawns[x][2]))
 					SCM(playerid, C_RED,""WE" "R"Jesteś zbyt blisko spawnu aby kupić prywatny pojazd.");
					return 1;
			Achievement(playerid, "aWlasne4");
            new bool:Block = true,NewVID,String[320];
            if(!Player[playerid][Vip])
				Player[playerid][Exp] -= 1500;
                GameTextForPlayer(playerid,"~w~Exp - ~b~~h~1500",1000, 1);
				SCM(playerid, C_GREEN, ""WI" "G"Zakupiłeś swój prywatny pojazd za 1500 exp! Menu pojazdu pod /pojazd. Pamiętaj aby być na serwerze co 5 dni!");
			else
			    Player[playerid][Exp] -= 500;
                GameTextForPlayer(playerid,"~w~Exp - ~b~~h~500",1000, 1);
				SCM(playerid, C_GREEN, ""WI" "G"Zakupiłeś swój prywatny pojazd za 500 exp! Menu pojazdu pod /pojazd. Pamiętaj aby być na serwerze co 5 dni!");
                         
			new Float:OX,Float:OY,Float:OZ,Float:OA;
			GetPlayerPos(playerid,OX,OY,OZ);
			GetPlayerFacingAngle(playerid,OA);
            for(new x=0;x<MAX_PRIVATE_VEHICLES;x++)
				if(x != 0)
					if(!PrivCarExists(x) && Block)
						format(String,sizeof(String), "INSERT INTO "PREFIX"Vehicles VALUES('%d','%d','%s','%f','%f','%f','%f','-1','-1','0','3','0','0','0','0','0','0','0','0','0','0','0','0','0')",x,Player[playerid][PrivCarName],Player[playerid][Name],OX,OY,OZ,OA);
						mysql_query(String);
	                    NewVID = x;
						Block = false;
			format(String,sizeof(String),"UPDATE `"PREFIX"Users` SET Exp='%d',pVeh='%d',WaznoscPriv='5' WHERE Name='%s'",Player[playerid][Exp],NewVID,Player[playerid][Name]);
			mysql_query(String);
            mysql_query("SELECT vID FROM "PREFIX"Vehicles");
			mysql_store_result();
			new rows = mysql_num_rows();
			mysql_free_result();
			TotalPrivCars = rows;
            Player[playerid][pVeh] = NewVID;
			Player[playerid][WaznoscPriv] = 5;
            vInfo[NewVID][vID] = NewVID;
			vInfo[NewVID][vModel] = Player[playerid][PrivCarName];
			vInfo[NewVID][vPosX] = OX;
            vInfo[NewVID][vPosY] = OY;
            vInfo[NewVID][vPosZ] = OZ;
            vInfo[NewVID][vAngle] = OA;
            vInfo[NewVID][vColor1] = -1;
            vInfo[NewVID][vColor2] = -1;
            format(vInfo[NewVID][vOwner],MAX_PLAYER_NAME,Player[playerid][Name]);
            vInfo[NewVID][vPrzebieg] = 0;
			DestroyVehicleEx(vInfo[NewVID][vID]);
			vInfo[NewVID][vID] = CreateVehicle(vInfo[NewVID][vModel],OX,OY,OZ,OA,vInfo[NewVID][vColor1],vInfo[NewVID][vColor2], 9999);
            SetVehicleVirtualWorld(vInfo[NewVID][vID], 0);
			LinkVehicleToInterior(vInfo[NewVID][vID],0);
			format(String,sizeof(String),"Właściciel: {9eae41}%s\n{c3c3c3}Przebieg: {9eae41}%.1f km.",vInfo[NewVID][vOwner],vInfo[NewVID][vPrzebieg]/1000.0);
			vInfo[NewVID][vLabel] = Create3DTextLabel(String, 0xc3c3c3FF, 0.0, 0.0, 0.0, 10.0, 0, 0);
            Attach3DTextLabelToVehicle(vInfo[NewVID][vLabel], vInfo[NewVID][vID], 0.0, 0.0, 0.5);
			PutPlayerInVehicle(playerid,vInfo[NewVID][vID],0);
		else
			cmd_pojazd(playerid);
	if(dialogid == D_PVEH_CONTROL && response)
		switch(listitem)
            case 0:
				if(GetPlayerInterior(playerid) != 0) return SCM(playerid,C_RED,""WE" "R"Pojazd możesz przywołać tylko na zewnątrz.");
				new VehicleId = Player[playerid][pVeh];
				new Float:PX,Float:PY,Float:PZ,Float:PA;
				SetVehicleVirtualWorld(vInfo[VehicleId][vID], 0);
                LinkVehicleToInterior(vInfo[VehicleId][vID],0);
				GetPlayerPos(playerid, PX,PY,PZ);
				GetPlayerFacingAngle(playerid, PA);
				SetVehiclePos(vInfo[VehicleId][vID], PX,PY,PZ);
				SetVehicleZAngle(vInfo[VehicleId][vID], PA);
				PutPlayerInVehicle(playerid,vInfo[VehicleId][vID],0);
				SCM(playerid, C_GREEN, ""WI" "G"Pojazd teleportowany!");
				PlaySoundForPlayer(playerid, 1150);
			case 1:
				if(!IsInParking(playerid) && !Player[playerid][Vip] && !Player[playerid][Mod] && !Player[playerid][Admin1])
				    SCM(playerid, C_RED, ""WE" "R"Tylko gracze z kontem premium mogą parkować po za parkingami.");
                    SCM(playerid, C_RED, ""WI" "R"Dostępne parkingi: "W"/G1"R","W"/G2"R","W"/G3"R","W"/G4"R".");
					return 1;
               	for(new x=0;x<sizeof(gRandomPlayerSpawns);x++)
					if(PlayerToPoint(60,playerid,gRandomPlayerSpawns[x][0],gRandomPlayerSpawns[x][1],gRandomPlayerSpawns[x][2]))
			   			SCM(playerid, C_RED,""WE" "R"Jesteś zbyt blisko spawnu aby tutaj zaparkować.");
						return 1;
                if(mysql_ping() == -1)
					mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
				new VehicleId = Player[playerid][pVeh],String[155];
				GetVehiclePos(vInfo[VehicleId][vID], vInfo[VehicleId][vPosX],vInfo[VehicleId][vPosY],vInfo[VehicleId][vPosZ]);
				GetVehicleZAngle(vInfo[VehicleId][vID], vInfo[VehicleId][vAngle]);
				format(String,sizeof(String),"UPDATE `"PREFIX"Vehicles` SET vPosX='%f',vPosY='%f',vPosZ='%f',vAngle='%f' WHERE vID='%d'",vInfo[VehicleId][vPosX],vInfo[VehicleId][vPosY],vInfo[VehicleId][vPosZ],vInfo[VehicleId][vAngle],VehicleId);
				mysql_query(String);
				PlaySoundForPlayer(playerid, 1150);
				SCM(playerid, C_GREEN, ""WI" "G"Pojazd zaparkowany!");
			case 2:
				new VehicleId = Player[playerid][pVeh];
				SetVehiclePos(vInfo[VehicleId][vID],vInfo[VehicleId][vPosX],vInfo[VehicleId][vPosY],vInfo[VehicleId][vPosZ]);
				SetVehicleZAngle(vInfo[VehicleId][vID],vInfo[VehicleId][vAngle]);
				PlaySoundForPlayer(playerid, 1150);
				SCM(playerid, C_GREEN, ""WI" "G"Pojazd zrespawnowany na parking!");
			case 3: SPD(playerid, D_SETCAR,DIALOG_STYLE_INPUT, "{00BFFF}Zmiana Modelu Pojazdu", "Wpisz nazwę pojazdu lub jej urywek.\n\n(Lista pojazdów pod /Cars)","Dalej","Cofnij");
			case 4:
                new VehicleId = Player[playerid][pVeh];
                vInfo[VehicleId][SPOILER] = GetVehicleComponentInSlot(vInfo[VehicleId][vID], CARMODTYPE_SPOILER);
				vInfo[VehicleId][HOOD] = GetVehicleComponentInSlot(vInfo[VehicleId][vID], CARMODTYPE_HOOD);
				vInfo[VehicleId][ROOF] = GetVehicleComponentInSlot(vInfo[VehicleId][vID], CARMODTYPE_ROOF);
				vInfo[VehicleId][SIDESKIRT] = GetVehicleComponentInSlot(vInfo[VehicleId][vID], CARMODTYPE_SIDESKIRT);
				vInfo[VehicleId][LAMPS] = GetVehicleComponentInSlot(vInfo[VehicleId][vID], CARMODTYPE_LAMPS);
				vInfo[VehicleId][EXHAUST] = GetVehicleComponentInSlot(vInfo[VehicleId][vID], CARMODTYPE_EXHAUST);
				vInfo[VehicleId][WHEELS] = GetVehicleComponentInSlot(vInfo[VehicleId][vID], CARMODTYPE_WHEELS);
				vInfo[VehicleId][STEREO] = GetVehicleComponentInSlot(vInfo[VehicleId][vID], CARMODTYPE_STEREO);
				vInfo[VehicleId][HYDRAULICS] = GetVehicleComponentInSlot(vInfo[VehicleId][vID], CARMODTYPE_HYDRAULICS);
				vInfo[VehicleId][FRONT_BUMPER] = GetVehicleComponentInSlot(vInfo[VehicleId][vID], CARMODTYPE_FRONT_BUMPER);
				vInfo[VehicleId][REAR_BUMPER] = GetVehicleComponentInSlot(vInfo[VehicleId][vID], CARMODTYPE_REAR_BUMPER);
				vInfo[VehicleId][VENT_RIGHT] = GetVehicleComponentInSlot(vInfo[VehicleId][vID], CARMODTYPE_VENT_RIGHT);
				vInfo[VehicleId][VENT_LEFT] = GetVehicleComponentInSlot(vInfo[VehicleId][vID], CARMODTYPE_VENT_LEFT);
                GetVehicleColor(vInfo[VehicleId][vID], vInfo[VehicleId][vColor1], vInfo[VehicleId][vColor2]);
                if(mysql_ping() == -1)
					mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
				new String[512];
				format(String,sizeof(String),"UPDATE `"PREFIX"Vehicles` SET vColor1='%d',vColor2='%d',vPrzebieg='%d',vPaintJob='%d',SPOILER='%d',HOOD='%d',ROOF='%d',SIDESKIRT='%d',LAMPS='%d',EXHAUST='%d',WHEELS='%d',STEREO='%d',HYDRAULICS='%d',FRONT_BUMPER='%d',REAR_BUMPER='%d',VENT_RIGHT='%d',VENT_LEFT='%d' WHERE vID='%d'",
				vInfo[VehicleId][vColor1],vInfo[VehicleId][vColor2] ,vInfo[VehicleId][vPrzebieg],vInfo[VehicleId][vPaintJob],vInfo[VehicleId][SPOILER],vInfo[VehicleId][HOOD],vInfo[VehicleId][ROOF],vInfo[VehicleId][SIDESKIRT],vInfo[VehicleId][LAMPS],vInfo[VehicleId][EXHAUST],vInfo[VehicleId][WHEELS],vInfo[VehicleId][STEREO],vInfo[VehicleId][HYDRAULICS],vInfo[VehicleId][FRONT_BUMPER],vInfo[VehicleId][REAR_BUMPER],vInfo[VehicleId][VENT_RIGHT],vInfo[VehicleId][VENT_LEFT],VehicleId);
				mysql_query(String);
                SCM(playerid, C_GREEN, ""WI" "G"Dane pojazdu i tuning zapisany! Aby zapisać jego pozycję należy go zaparkować.");
			case 5:
				new VehicleId = Player[playerid][pVeh];
                if(IsVehicleValidComponent(vInfo[VehicleId][vID],vInfo[VehicleId][SPOILER]))
					AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][SPOILER]);
				if(IsVehicleValidComponent(vInfo[VehicleId][vID],vInfo[VehicleId][HOOD]))
					AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][HOOD]);
				if(IsVehicleValidComponent(vInfo[VehicleId][vID],vInfo[VehicleId][ROOF]))
					AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][ROOF]);
				if(IsVehicleValidComponent(vInfo[VehicleId][vID],vInfo[VehicleId][SIDESKIRT]))
					AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][SIDESKIRT]);
				if(IsVehicleValidComponent(vInfo[VehicleId][vID],vInfo[VehicleId][LAMPS]))
					AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][LAMPS]);
				if(IsVehicleValidComponent(vInfo[VehicleId][vID],vInfo[VehicleId][EXHAUST]))
					AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][EXHAUST]);
				if(IsVehicleValidComponent(vInfo[VehicleId][vID],vInfo[VehicleId][WHEELS]))
					AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][WHEELS]);
				if(IsVehicleValidComponent(vInfo[VehicleId][vID],vInfo[VehicleId][STEREO]))
					AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][STEREO]);
				if(IsVehicleValidComponent(vInfo[VehicleId][vID],vInfo[VehicleId][HYDRAULICS]))
					AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][HYDRAULICS]);
				if(IsVehicleValidComponent(vInfo[VehicleId][vID],vInfo[VehicleId][FRONT_BUMPER]))
					AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][FRONT_BUMPER]);
				if(IsVehicleValidComponent(vInfo[VehicleId][vID],vInfo[VehicleId][REAR_BUMPER]))
					AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][REAR_BUMPER]);
				if(IsVehicleValidComponent(vInfo[VehicleId][vID],vInfo[VehicleId][VENT_RIGHT]))
					AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][VENT_RIGHT]);
				if(IsVehicleValidComponent(vInfo[VehicleId][vID],vInfo[VehicleId][VENT_LEFT]))
					AddVehicleComponent(vInfo[VehicleId][vID], vInfo[VehicleId][VENT_LEFT]);
                if(IsVehicleValidPaintJob(vInfo[VehicleId][vID],vInfo[VehicleId][vPaintJob]))
					ChangeVehiclePaintjob(vInfo[VehicleId][vID], vInfo[VehicleId][vPaintJob]);
				SCM(playerid, C_GREEN, ""WI" "G"Tuning pojazdu wczytany!");
	if(dialogid == D_SETCAR)
		if(response)
            new pojazd;
			pojazd = GetVehicleModelIDFromName(inputtext);
			if(pojazd < 400 || pojazd > 611)
				SCM(playerid, C_RED, ""WE" "R"Taki pojazd nie został znaleziony.");
				cmd_pojazd(playerid);
				return 1;
            if(pojazd == 592 || pojazd == 577 || pojazd == 520 || pojazd == 432 || pojazd == 425 || pojazd == 447 || pojazd == 406 || pojazd == 537 || pojazd == 538 || pojazd == 569 || pojazd == 570 || pojazd == 584 || pojazd == 590 || pojazd == 591 || pojazd == 606  || pojazd == 607 || pojazd == 608 || pojazd == 610 || pojazd == 611 || pojazd == 464 || pojazd == 465 || pojazd == 501 || pojazd == 564 || pojazd == 594 && !IsPlayerAdmin(playerid))
	            SCM(playerid, C_RED, ""WE" "R"Ten pojazd jest nie dozwolony!");
				cmd_pojazd(playerid);
				return 1;
			Player[playerid][PrivCarName] = pojazd;
			new String[128];
			format(String,sizeof(String), "Nazwa nowego modelu prywatnego pojazdu: %s\n\nCzy chcesz kontynuować?",CarList[pojazd-400]);
			SPD(playerid, D_CONFIRM_SETCAR, DIALOG_STYLE_MSGBOX, "{00BFFF}Zmiana Modelu Pojazdu", String, "Zmień", "Cofnij");
		else
			cmd_pojazd(playerid);
	if(dialogid == D_CONFIRM_SETCAR)
		if(response)
            if(mysql_ping() == -1)
				mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
			new VehicleId = Player[playerid][pVeh];
			new String[128],Float:pX,Float:pY,Float:pZ,Float:pAngle,pOwner[20];
			format(String,sizeof(String),"UPDATE `"PREFIX"Vehicles` SET vModel='%d' WHERE vID='%d'",Player[playerid][PrivCarName],VehicleId);
			mysql_query(String);
			GetVehiclePos(vInfo[VehicleId][vID],pX,pY,pZ);
			GetVehicleZAngle(vInfo[VehicleId][vID],pAngle);
            vInfo[VehicleId][vModel] = Player[playerid][PrivCarName];
            pOwner = vInfo[VehicleId][vOwner];
			DestroyVehicleEx(vInfo[VehicleId][vID]);
			vInfo[VehicleId][vID] = CreateVehicle(Player[playerid][PrivCarName],pX,pY,pZ,pAngle,-1,-1, 9999);
            Attach3DTextLabelToVehicle(vInfo[VehicleId][vLabel], vInfo[VehicleId][vID], 0.0, 0.0, 0.5);
            PutPlayerInVehicle(playerid,vInfo[VehicleId][vID],0);
            SCM(playerid, C_GREEN, ""I" "W"Model pojazdu został zmieniony!");
		else
            SPD(playerid, D_SETCAR, DIALOG_STYLE_INPUT,"{00BFFF}Zmiana Modelu Pojazdu", "Wpisz nazwę pojazdu lub jej urywek.\n\n(Lista pojazdów pod /Cars)","Dalej","Cofnij");
	if(dialogid == D_TEST && response)
	if(dialogid == D_BIZNES_NIEKUPIONY && response)
		if(!Player[playerid][Registered])
			return SCM(playerid, C_WHITE, ""E" "W"Nie jesteś zarejestrowany(a)!");
		PlayerBuyBiznes(playerid, Player[playerid][Biznes], bInfo[Player[playerid][Biznes]][bCash]);
    if(dialogid == D_BIZNES_KUPIONY_OWNER && response)
		PlayerSellBiznes(playerid, Player[playerid][Biznes]);
	if(dialogid == D_BIZNES_KUPIONY && response)
		if(Player[playerid][Money] < bInfo[Player[playerid][Biznes]][bCash])
            SCM(playerid, C_WHITE, ""E" "W"Nie stać cię na ten biznes!");
			return 1;
        //SCM(playerid,C_WHITE,"Powinno sie wykonac playerbuybiznes.");
        /*new userid = GetPlayerIdFromName(bInfo[Player[playerid][Biznes]][bOwner]);
        if(!Player[userid][Zajety] && IsPlayerConnected(userid))
			new String[128];
	        format(String,sizeof(String), "Twój biznes: %s został odkupiony przez gracza %s!",bInfo[Player[playerid][Biznes]][bName],Player[playerid][Name]);
			SPD(userid, D_NONE, DIALOG_STYLE_MSGBOX, "{00BFFF}Posiadłości", String, "Zamknij", "");*/
        PlayerBuyBiznes(playerid, Player[playerid][Biznes], bInfo[Player[playerid][Biznes]][bCash]);
	if(dialogid == D_BIZNES_NAZWA)
        if(FindSQLInjection(inputtext))
	        SCM(playerid, C_WHITE, ""E" "W"Biznes nie może zawierać zapytań oraz znaków specjalnych!");
			return 1;
		/*
        if(!FindValidText(inputtext))
  			SPD(playerid, D_CREATE_HOUSE, DIALOG_STYLE_INPUT, "{00BFFF}Nowy dom", "Biznes nie może posiadać znaków specjalnych\n\nPodaj nazwę nowego domu:", "Zapisz", "Anuluj");
	    	return 1;
		*/
		if(response)
			format(Player[playerid][BiznesNazwa], 32, inputtext);
			SPD(playerid, D_BIZNES_KASA, DIALOG_STYLE_INPUT, "{00BFFF}Nowy Biznes", "Wpisz ilość dochodów w dolarach ($)", "Stwórz", "Zamknij");
		else
			Player[playerid][BiznesStep] = 0;
	if(dialogid == D_BIZNES_KASA)
	    if(response)
			TotalBiznes ++;
			new Stringe[128];
			format(Stringe,sizeof(Stringe), "INSERT INTO "PREFIX"Biznesy VALUES('%d','%s','0','%s','%f','%f','%f')",TotalBiznes,Player[playerid][BiznesNazwa],inputtext,Player[playerid][BiznesPosX],Player[playerid][BiznesPosY],Player[playerid][BiznesPosZ]);
			mysql_query(Stringe);
			LoadBiznes();
			SCM(playerid, C_WHITE, ""I" "W"Biznes utworzony!");
		else
			Player[playerid][BiznesStep] = 0;
	if(dialogid == D_WYSLIJ_KASE)
        new userid = Player[playerid][ClickedPlayer];
		if(response)
			if(strval(inputtext) <= 0)
                SPD(playerid, D_PLAYER, DIALOG_STYLE_LIST, Player[userid][Name], "› Idź do gracza\n"GUI2"› Statystyki\n"W"› Wyślij kasę\n"GUI2"› Raportuj łamanie regulaminu\n"W"› Wystaw nagrodę za głowę", "Wybierz", "Anuluj");
                SCM(playerid, C_WHITE, ""I" "W"Niepoprawna ilość pieniędzy!");
				return 1;
			if(Player[playerid][Money] < strval(inputtext))
                SPD(playerid, D_PLAYER, DIALOG_STYLE_LIST, Player[userid][Name], "› Idź do gracza\n"GUI2"› Statystyki\n"W"› Wyślij kasę\n"GUI2"› Raportuj łamanie regulaminu\n"W"› Wystaw nagrodę za głowę", "Wybierz", "Anuluj");
                SCM(playerid, C_WHITE, ""I" "W"Nie posiadasz tyle pieniędzy!");
				return 1;
			if(Player[playerid][TimePlay] < 5)
                SPD(playerid, D_PLAYER, DIALOG_STYLE_LIST, Player[userid][Name], "› Idź do gracza\n"GUI2"› Statystyki\n"W"› Wyślij kasę\n"GUI2"› Raportuj łamanie regulaminu\n"W"› Wystaw nagrodę za głowę", "Wybierz", "Anuluj");
                SCM(playerid, C_WHITE, ""I" "W"Musisz zagrać na serwerze conajmniej 5 minut aby z tego skorzystać.");
				return 1;
			GivePlayerMoney(userid, strval(inputtext));
			GivePlayerMoney(playerid, -strval(inputtext));
			Player[playerid][Money] -= strval(inputtext);
			Player[userid][Money] += strval(inputtext);
            if(userid != playerid)
				new String[128];
				format(String, sizeof(String), ""WI" "G"Wysłałeś %d$ graczowi %s.", strval(inputtext), Player[userid][Name]);
				SCM(playerid, C_GREEN, String);
				format(String, sizeof(String), ""WI" "G"Otrzymałeś %d$ od gracza %s.", strval(inputtext), Player[playerid][Name]);
				SCM(userid, C_GREEN, String);
		else
            SPD(playerid, D_PLAYER, DIALOG_STYLE_LIST, Player[userid][Name], "› Idź do gracza\n"GUI2"› Statystyki\n"W"› Wyślij kasę\n"GUI2"› Raportuj łamanie regulaminu\n"W"› Wystaw nagrodę za głowę", "Wybierz", "Anuluj");
	if(dialogid == D_PORTFEL && response)
		switch(listitem)
			case 0:
				//Kod na doładowanie portfela
				if(!Player[playerid][Registered])
                    SCM(playerid,C_RED,""WE" "R"Musisz się zarejestrować!");
					return 1;
				SPD(playerid,D_KWOTY_PORTFEL,DIALOG_STYLE_LIST,"{00BFFF}Kwota zasilenia portfela","› 1 zł (SMS: 1,23zł z VAT)\n"GUI2"› 2 zł (SMS: 2,46zł z VAT)\n"W"› 3 zł (SMS: 3,69zł z VAT)\n"GUI2"› 4 zł (SMS: 4,92zł z VAT)\n"W"› 5 zł (SMS: 6,15zł z VAT)\n"GUI2"› 6 zł (SMS: 7,38zł z VAT)\n"W"› 9 zł (SMS: 11,07zł z VAT)\n"GUI2"› 19 zł (SMS: 23,37zł z VAT)\n"W"› 25 zł (SMS: 30,75zł z VAT)","Wybierz","Cofnij");
				/*cmd_portfel(playerid);
				SCM(playerid, C_ERROR, ""WE" "R"Doładowywanie portfela jest aktualnie wyłączone!");*/
			case 1:
	            new string[900];
				strcat(string,""W"Co to jest tzw. Wirtualny Portfel?\n\n");
				strcat(string,""GUI"Każdy użytkownik serwera posiada swój prywatny własny wirtualny portfel.\n");
				strcat(string,"Jest to prywatna kasa zapisywana na stałe. Jest to jakby waluta GoldServera.\n\n");
				strcat(string,""W"Jak zdobyć gotówkę do portfela?\n\n");
				strcat(string,""GUI"To proste! Należy wpisać komendę "W"/Portfel"GUI" a następnie wybrać opcję "W"Zasil swój portfel"GUI".\n\n");
				strcat(string,""W"Czy jest to legalne?\n\n");
				strcat(string,""GUI"Tak jest to jak najbardziej legalne, to jest zwykła tranzakcja SMS.\n\n");
				strcat(string,""W"Do czego służy portfel? Jakie są zastosowania?\n\n");
				strcat(string,""GUI"Portfel służy do przechowywania kwoty z wysłanych sms'ów.\n");
				strcat(string,"Kwotą z wirtualnego portfela można opłacić np. "W"konto VIP,opłata domku,kupno dodatkowych punktów exp "GUI"itd.\n\n");
	            strcat(string,""W"Co się stanie jak coś pójdzie nie tak?\n\n");
	            strcat(string,""GUI"Nic się nie stanie :) Należy to zgłosić administracji w ciągu 3 dni roboczych od dokonania wpłaty.\n");
				SPD(playerid, D_INFO_PORTFEL, DIALOG_STYLE_MSGBOX,"{00BFFF}Wirtualny Portfel "W"- Info", string,"Zamknij","Cofnij");
	if(dialogid == D_INFO_PORTFEL && !response)
		cmd_portfel(playerid);
    if(dialogid == D_VGRANATY && response)
	    Player[playerid][Exp] -= 20;
        GameTextForPlayer(playerid,"~w~Exp - ~b~~h~20",1000, 1);
		Player[playerid][Level] = GetPlayerLevel(playerid);
		UpdatePlayerScore(playerid);
		GivePlayerWeapon(playerid, 16, 30);
		return 1;
	if(dialogid == D_RAPORT)
 		if(listitem >= 10)
			return 1;
		if(response)
		    if(RaportID[listitem] == -1)
		        SCM(playerid,C_RED,"Ten raport został usunięty lub sprawdzony!");
		    	return 1;
			if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
				GetPlayerPos(playerid,Player[playerid][SpecPosX],Player[playerid][SpecPosY],Player[playerid][SpecPosZ]);
				Player[playerid][SpecInt] = GetPlayerInterior(playerid);
				Player[playerid][SpecVW] = GetPlayerVirtualWorld(playerid);
			new specplayerid = RaportID[listitem];
			SetPlayerInterior(playerid,GetPlayerInterior(specplayerid));
			SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(specplayerid));
			new sss[128];
			format(sss,sizeof(sss),"Oglądasz gracza: %s (%d) z powodu: %s",Player[specplayerid][Name],specplayerid,Raport[listitem]);
			SCM(playerid,C_ORANGE,sss);
			TogglePlayerSpectating(playerid, 1);
			if(!IsPlayerInAnyVehicle(specplayerid))
				PlayerSpectatePlayer(playerid, specplayerid);
			else
				PlayerSpectateVehicle(playerid,GetPlayerVehicleID(specplayerid));
			Player[playerid][gSpectateID] = specplayerid;
			Player[playerid][gSpectateType] = 1;
			RaportID[listitem] = -1;
		else
			RaportID[listitem] = -1;
			SCM(playerid,C_RED,"Raport został anulowany");
			new str[800];
			for(new x=0;x<10;x++)
				new name[25];
				if(RaportID[x] < 0)
					format(str,sizeof(str),"%s\n"GUI"Brak Raportu",str);
				else
					GetPlayerName(RaportID[x],name,sizeof(name));
					format(str,sizeof(str),"%s\n"W"%s(%d) "R">> "W"%s",str,name,RaportID[x],Raport[x]);
			strins(str,"\nWyjdz",strlen(str),sizeof(str));
			SPD(playerid,D_RAPORT,2,"{00BFFF}Lista Raportow",str,"Spec","Usun");
	    return 1;
	if(dialogid == D_WYBOR_ROOM && response)
		switch(listitem)
			case 0:
                GetPlayerRoom(playerid) = 0;
                SCM(playerid,C_YELLOW,"*(ROOM) Twój room został zmieniony na domyslny! (Czat Globalny)");
			case 1:
                SPD(playerid, D_ROOM, DIALOG_STYLE_INPUT,"{00BFFF}Wybierz room", "Room to prywatny czat z innymi w twoim room'ie (pokoju)\nCi gracze co mają ten sam room co ty, będą widzieć twoje wiadomości na czacie i na odwrót.\n\nWpisz wybrany room:", "Wybierz", "Cofnij");
	if(dialogid == D_ROOM)
		if(response)
			if(strval(inputtext) <= 0)
                SCM(playerid,C_RED,""WE" "R"Room musi być większy od 0!");
				return 1;
			if(strval(inputtext) > 99)
                SCM(playerid,C_RED,""WE" "R"Room musi być mniejszy od 99!");
				return 1;
            GetPlayerRoom(playerid) = strval(inputtext);
			new String[128];
			format(String,sizeof(String),"*(ROOM) Twój room został zmieniony na %d! Teraz wszyscy w tym samym roomie będą widzieć twoje wiadomości i na odwrót.",Player[playerid][Room]);
            SCM(playerid,C_YELLOW,String);
			format(String,sizeof(String),"*(ROOM) Gracz %s wszedł do pokoju!",Player[playerid][Name]);
            foreach(Player,x)
				if(GetPlayerRoom(x) == GetPlayerRoom(playerid))
					SCM(x, C_YELLOW, String);
		else
			cmd_room(playerid);
	if(dialogid == D_BRONIE_WG)
		if(response)
			switch(listitem)
			    case 0:
					GivePlayerWeapon(playerid, 22, 1000);
			    case 1:
                    GivePlayerWeapon(playerid, 23, 1000);
			    case 2:
                    GivePlayerWeapon(playerid, 24, 1000);
			    case 3:
                    GivePlayerWeapon(playerid, 29, 1500);
            PlaySoundForPlayer(playerid, 30800);
            SPD(playerid, D_BRONIE_WG2, DIALOG_STYLE_LIST, "{00BFFF}Bronie WG "W"- Broń ciężka", "› M4\n"GUI2"› AK-47\n"W"› Combat Shotgun\n"GUI2"› Shotgun\n"W"› Sniper-Rifle", "Wybierz", "");
		else
            switch(listitem)
			    case 0:
					GivePlayerWeapon(playerid, 22, 1000);
			    case 1:
                    GivePlayerWeapon(playerid, 23, 1000);
			    case 2:
                    GivePlayerWeapon(playerid, 24, 1000);
			    case 3:
                    GivePlayerWeapon(playerid, 29, 1500);
            PlaySoundForPlayer(playerid, 30800);
            SPD(playerid, D_BRONIE_WG2, DIALOG_STYLE_LIST, "{00BFFF}Bronie WG "W"- Broń ciężka", "› M4\n"GUI2"› AK-47\n"W"› Combat Shotgun\n"GUI2"› Shotgun\n"W"› Sniper-Rifle", "Wybierz", "");
    if(dialogid == D_BRONIE_WG2)
		if(response)
			switch(listitem)
			    case 0:
					GivePlayerWeapon(playerid, 31, 2000);
			    case 1:
                    GivePlayerWeapon(playerid, 30, 2000);
			    case 2:
                    GivePlayerWeapon(playerid, 27, 2000);
			    case 3:
                    GivePlayerWeapon(playerid, 25, 2000);
                case 4:
                    GivePlayerWeapon(playerid, 34, 1000);
            PlaySoundForPlayer(playerid, 30800);
		else
            switch(listitem)
			    case 0:
					GivePlayerWeapon(playerid, 31, 2000);
			    case 1:
                    GivePlayerWeapon(playerid, 30, 2000);
			    case 2:
                    GivePlayerWeapon(playerid, 27, 2000);
			    case 3:
                    GivePlayerWeapon(playerid, 25, 2000);
                case 4:
                    GivePlayerWeapon(playerid, 34, 1000);
            PlaySoundForPlayer(playerid, 30800);
	if(dialogid == D_KWOTY_PORTFEL)
		if(response)
			switch(listitem)
				case 0:
                    format(Player[playerid][SMS_Tresc],5,"SH1");
					Player[playerid][SMS_Numer] = 7143;
					Player[playerid][SMS_Koszt] = 1;
					format(Player[playerid][SMS_VAT],32,"1,23zł z VAT");
                case 1:
                    format(Player[playerid][SMS_Tresc],5,"SH2");
					Player[playerid][SMS_Numer] = 72550;
					Player[playerid][SMS_Koszt] = 2;
					format(Player[playerid][SMS_VAT],32,"2,46zł z VAT");
				case 2:
                    format(Player[playerid][SMS_Tresc],5,"SH3");
					Player[playerid][SMS_Numer] = 73550;
					Player[playerid][SMS_Koszt] = 3;
					format(Player[playerid][SMS_VAT],32,"3,69zł z VAT");
				case 3:
                    format(Player[playerid][SMS_Tresc],5,"SH4");
					Player[playerid][SMS_Numer] = 74550;
					Player[playerid][SMS_Koszt] = 4;
					format(Player[playerid][SMS_VAT],32,"4,92zł z VAT");
				case 4:
                    format(Player[playerid][SMS_Tresc],5,"SH5");
					Player[playerid][SMS_Numer] = 75550;
					Player[playerid][SMS_Koszt] = 5;
					format(Player[playerid][SMS_VAT],32,"6,15zł z VAT");
				case 5:
                    format(Player[playerid][SMS_Tresc],5,"SH6");
					Player[playerid][SMS_Numer] = 76550;
					Player[playerid][SMS_Koszt] = 6;
					format(Player[playerid][SMS_VAT],32,"7,38zł z VAT");
				case 6:
                    format(Player[playerid][SMS_Tresc],5,"SH9");
					Player[playerid][SMS_Numer] = 79550;
					Player[playerid][SMS_Koszt] = 9;
					format(Player[playerid][SMS_VAT],32,"11,07zł z VAT");
				case 7:
                    format(Player[playerid][SMS_Tresc],5,"SH19");
					Player[playerid][SMS_Numer] = 91909;
					Player[playerid][SMS_Koszt] = 19;
					format(Player[playerid][SMS_VAT],32,"23,37zł z VAT");
				case 8:
                    format(Player[playerid][SMS_Tresc],5,"SH25");
					Player[playerid][SMS_Numer] = 92505;
					Player[playerid][SMS_Koszt] = 25;
					format(Player[playerid][SMS_VAT],32,"30,75zł z VAT");
            new String[540];
			format(String,sizeof(String),"Aby zasilić swój portfel kwotą %dzł wyślij SMS o treści "W"%s.GOLD.%d "GUI"pod numer "W"%d"GUI"\n",Player[playerid][SMS_Koszt],Player[playerid][SMS_Tresc],Player[playerid][AID],Player[playerid][SMS_Numer]);
			format(String,sizeof(String),"%sKoszt wysłania pojedynczej wiadomości SMS to %dzł (%s)\n",String,Player[playerid][SMS_Koszt],Player[playerid][SMS_VAT]);
            format(String,sizeof(String),"%sPo wysłaniu SMS automatycznie twój portfel zostanie zasilony kwotą %d zł.\n",String,Player[playerid][SMS_Koszt]);
   			format(String,sizeof(String),"%sPłatność SMS zrealizowana przy współpracy z hostingiem serwerów gier ServHost.pl\n",String);
			format(String,sizeof(String),"%sReklamacje dotyczące usługi należy składać pod adresem e-mail bok@servhost.pl\n\n",String);
            format(String,sizeof(String),"%s"R"Uwaga! "W"Po wysłaniu SMS należy ponownie wejść na serwer w celu aktywacji kwoty.",String);
			SPD(playerid,D_KWOTY_INFO_PORTFEL,DIALOG_STYLE_MSGBOX,"{00BFFF}Doładowanie portfela "W"- SMS",String,"Zamknij","Cofnij");
		else
			cmd_portfel(playerid);
	if(dialogid == D_KWOTY_INFO_PORTFEL && !response)
		SPD(playerid,D_KWOTY_PORTFEL,DIALOG_STYLE_LIST,"{00BFFF}Kwota zasilenia portfela","› 1 zł (SMS: 1,23zł z VAT)\n"GUI2"› 2 zł (SMS: 2,46zł z VAT)\n"W"› 3 zł (SMS: 3,69zł z VAT)\n"GUI2"› 4 zł (SMS: 4,92zł z VAT)\n"W"› 5 zł (SMS: 6,15zł z VAT)\n"GUI2"› 6 zł (SMS: 7,38zł z VAT)\n"W"› 9 zł (SMS: 11,07zł z VAT)\n"GUI2"› 19 zł (SMS: 23,37zł z VAT)\n"W"› 25 zł (SMS: 30,75zł z VAT)","Wybierz","Cofnij");
	if(dialogid == D_CMDS_1 && response)
        new string[1200];
		strcat(string,"{44a428}/Air "W"- Wyłączasz/Włączasz podwójny skok.\n");
		strcat(string,"{44a428}/Ramp "W"- Wyłączasz/Włączasz rampy w pojazdach.\n");
		strcat(string,"{44a428}/Kask "W"- Wyłączasz/Włączasz kask w motorach.\n");
		strcat(string,"{44a428}/Premium "W"- Lista graczy z kontem premium OnLine.\n");
		strcat(string,"{44a428}/Portfel "W"- Menu twojego portfela.\n");
		strcat(string,"{44a428}/Drift "W"- Włącza/Wyłącza licznik driftu.\n");
		strcat(string,"{44a428}/PanelTD "W"- Panel TextDrawów serwera.\n");
		strcat(string,"{44a428}/Anims "W"- Animacje na serwerze.\n");
        strcat(string,"{44a428}/Exp "W"- Panel przelewu/informacji o exp.\n");
		strcat(string,"{44a428}/Astop "W"- Zatrzymujesz animację.\n");
		strcat(string,"{44a428}/Mods "W"- Lista moderatorów na serwerze.\n");
		strcat(string,"{44a428}/Nowosci "W"- Lista nowości na serwerze.\n");
        strcat(string,"{44a428}/VC [Kolor 1] [Kolor 2] "W"- Zmieniasz kolor pojazdu.\n");
        strcat(string,"{44a428}/Auto "W"- Modernizacja pojazdu.\n");
        strcat(string,"{44a428}/Fryzura [1-5] "W"- Zmieniasz sobie fryzurę.\n");
        strcat(string,"{44a428}/fReset "W"- Przywracasz normalną fryzurę.\n");
        strcat(string,"{44a428}/Czysc "W"- Czyścisz swój chat.\n");
        strcat(string,"{44a428}/Gang "W"- Panel gangów.\n");
        strcat(string,"{44a428}/FAQ "W"- Najczęściej zadawane pytania i odpowiedzi na nie.\n");
        strcat(string,"{44a428}/Przedmioty "W"- Panel przyczepianych przedmiotów do skina.\n");
        strcat(string,"{44a428}/eCMD "W"- Lista komend za exp.\n");
		SPD(playerid,D_CMDS_2,0,"{00BFFF}Komendy Gracza "W"- 2/2",string,"Zamknij","Cofnij");
	if(dialogid == D_CMDS_2 && !response)
		cmd_cmd(playerid);
	if(dialogid == D_EXP && response)
		switch(listitem)
			case 0:
				if(!Player[playerid][Registered])
                    SCM(playerid,C_RED,""WE" "R"Musisz się zarejestrować! /Register.");
					cmd_exp(playerid);
					return 1;
                if(Player[playerid][TimePlay] < 60)
                    SCM(playerid,C_RED,""WE" "R"Aby przelać komuś exp musisz przegrać conajmniej godzinę na serwerze!");
					cmd_exp(playerid);
					return 1;
                if(Player[playerid][PrzelalExp] > 0 && !Player[playerid][Mod] && !Player[playerid][Admin1])
                    SCM(playerid,C_RED,""WE" "R"Exp można przelewać co 5 minut!");
					cmd_exp(playerid);
					return 1;
				SPD(playerid,D_PRZELEW_EXP,DIALOG_STYLE_INPUT,"{00BFFF}Przelew Exp","Aby przelać exp na konto innego gracza\nPoniżej wpisz ID gracza:","Dalej","Cofnij");
			case 1:
                new String[530];
				format(String,sizeof(String),""W"Co to jest tzw. Exp?\n\n"GUI"Exp - skrót z angielskiego słowa \"Experience\" (Doświadczenie)\nExp można zdobywać poprzez zabijanie ludzi i wygrywanie różnych eventów na serwerze.\n\n");
				format(String,sizeof(String),"%s "W"Co to jest Level?\n\n"GUI"Level - Poziom w grze.\nPoziomy można zdobywać za zdobywanie pkt exp.\nIm większy poziom tym większe nagrody na spawnie i lepsze bronie.",String);
                format(String,sizeof(String),"%s "W"Pamiętaj! Im większy level (poziom) tym lepsze bronie i kamizelka!",String);
				SPD(playerid, D_INFO_EXP, DIALOG_STYLE_MSGBOX, "{00BFFF}Exp/Level "W"- Informacje",String,"Zamknij","Cofnij");
	if(dialogid == D_INFO_EXP && !response)
	    cmd_exp(playerid);
	if(dialogid == D_PRZELEW_EXP)
		if(response)
			if(strval(inputtext) < 0 || strval(inputtext) > MAX_PLAYERS+1)
                SCM(playerid,C_RED,""WE" "R"Podano niepoprawne ID gracza!");
				SPD(playerid,D_PRZELEW_EXP,DIALOG_STYLE_INPUT,"{00BFFF}Przelew Exp","Aby przelać exp na konto innego gracza\nPoniżej wpisz ID gracza:","Dalej","Cofnij");
				return 1;
			if(strval(inputtext) == playerid)
                SCM(playerid,C_RED,""WE" "R"Podałeś(aś) swoje ID!");
				SPD(playerid,D_PRZELEW_EXP,DIALOG_STYLE_INPUT,"{00BFFF}Przelew Exp","Aby przelać exp na konto innego gracza\nPoniżej wpisz ID gracza:","Dalej","Cofnij");
				return 1;
			if(!IsNumeric(inputtext))
				SCM(playerid,C_RED,""WE" "R"Niepoprawne ID Gracza!");
				SPD(playerid,D_PRZELEW_EXP,DIALOG_STYLE_INPUT,"{00BFFF}Przelew Exp","Aby przelać exp na konto innego gracza\nPoniżej wpisz ID gracza:","Dalej","Cofnij");
				return 1;
			if(!IsPlayerConnected(strval(inputtext)))
                SCM(playerid,C_RED,""WE" "R"Ten gracz nie jest podłączony!");
				SPD(playerid,D_PRZELEW_EXP,DIALOG_STYLE_INPUT,"{00BFFF}Przelew Exp","Aby przelać exp na konto innego gracza\nPoniżej wpisz ID gracza:","Dalej","Cofnij");
				return 1;
			Player[playerid][PrzelewExpId] = strval(inputtext);
			new String[128];
			format(String,sizeof(String),"Wpisz kwotę przelewu exp na konto gracza "W"%s (ID: %d)"GUI":",Player[strval(inputtext)][Name],strval(inputtext));
			SPD(playerid,D_PRZELEW_EXP2,DIALOG_STYLE_INPUT,"{00BFFF}Przelew Exp",String,"Przelej","Anuluj");
		else
			cmd_exp(playerid);
	if(dialogid == D_PRZELEW_EXP2 && response)
	    new String[256];
		if(strval(inputtext) <= 0 || strval(inputtext) > 300)
            SCM(playerid,C_RED,""WE" "R"Jednocześnie możesz przelać od 1 do 300 exp!");
			format(String,sizeof(String),"Wpisz kwotę przelewu exp na konto gracza "W"%s (ID: %d)"GUI":",Player[Player[playerid][PrzelewExpId]][Name],Player[playerid][PrzelewExpId]);
			SPD(playerid,D_PRZELEW_EXP2,DIALOG_STYLE_INPUT,"{00BFFF}Przelew Exp",String,"Przelej","Anuluj");
			return 1;
		if(!IsNumeric(inputtext))
            SCM(playerid,C_RED,""WE" "R"Niepoprawna ilość exp!");
			format(String,sizeof(String),"Wpisz kwotę przelewu exp na konto gracza "W"%s (ID: %d)"GUI":",Player[Player[playerid][PrzelewExpId]][Name],Player[playerid][PrzelewExpId]);
			SPD(playerid,D_PRZELEW_EXP2,DIALOG_STYLE_INPUT,"{00BFFF}Przelew Exp",String,"Przelej","Anuluj");
		if(Player[playerid][Exp] < strval(inputtext))
			SCM(playerid,C_RED,""WE" "R"Nie posiadasz tyle exp!");
			format(String,sizeof(String),"Wpisz kwotę przelewu exp na konto gracza "W"%s (ID: %d)"GUI":",Player[Player[playerid][PrzelewExpId]][Name],Player[playerid][PrzelewExpId]);
			SPD(playerid,D_PRZELEW_EXP2,DIALOG_STYLE_INPUT,"{00BFFF}Przelew Exp",String,"Przelej","Anuluj");
			return 1;
		Player[playerid][Exp] -= strval(inputtext);
		Player[Player[playerid][PrzelewExpId]][Exp] += strval(inputtext);
        Player[playerid][PrzelalExp] = 5;
		format(String,sizeof(String),""WI" "G"Przelałeś(aś) "G2"%d "G"pkt. exp graczowi "G2"%s (ID: %d)"G"!",strval(inputtext),Player[Player[playerid][PrzelewExpId]][Name],Player[playerid][PrzelewExpId]);
		SCM(playerid, C_GREEN,String);
		format(String,sizeof(String),""WI" "G"Gracz "G2"%s (ID: %d) "G"wysłał ci "G2"%d "G"pkt. exp!",Player[playerid][Name],playerid,strval(inputtext));
		SCM(Player[playerid][PrzelewExpId],C_GREEN,String);
		format(String,sizeof(String),"~w~Exp + ~b~~h~%d",strval(inputtext));
		GameTextForPlayer(Player[playerid][PrzelewExpId],String, 1000, 1);
        format(String,sizeof(String),"~w~Exp - ~b~~h~%d",strval(inputtext));
		GameTextForPlayer(playerid,String, 1000, 1);
        Player[playerid][Level] = GetPlayerLevel(playerid);
        Player[Player[playerid][PrzelewExpId]][Level] = GetPlayerLevel(Player[playerid][PrzelewExpId]);
		SavePlayer(playerid);
		SavePlayer(Player[playerid][PrzelewExpId]);
	if(dialogid == D_PRACA_WOJAK && response)
        SCM(playerid,C_WHITE,""I" "W"Zostałeś właśnie żołnierzem!");
		SetPlayerSkin(playerid,287);
		GivePlayerWeapon(playerid,30,1000);
    if(dialogid == D_WYSLIJ_RAPORT)
        new userid = Player[playerid][ClickedPlayer];
		if(response)
			format(inputtext,40,"%d %s",userid,inputtext);
			cmd_raport(playerid,inputtext);
		else
            SPD(playerid, D_PLAYER, DIALOG_STYLE_LIST, Player[userid][Name], "› Idź do gracza\n"GUI2"› Statystyki\n"W"› Wyślij kasę\n"GUI2"› Raportuj łamanie regulaminu\n"W"› Wystaw nagrodę za głowę", "Wybierz", "Anuluj");
    if(dialogid == D_WYSLIJ_HITMAN)
        new gracz = Player[playerid][ClickedPlayer];
		if(response)
            if(!IsNumeric(inputtext))
				SCM(playerid,C_RED,""WE" "R"Niepoprawna kwota!");
				SPD(playerid, D_WYSLIJ_HITMAN, DIALOG_STYLE_INPUT,"{00BFFF}Nagroda za głowę", "Wpisz kwotę, którą chcesz wysłać jako nagrodę:", "Wyślij", "Cofnij");
				return 1;
            if(strval(inputtext) > Player[playerid][Money])
				SCM(playerid, C_WHITE, ""E" "W"Nie masz tyle pieniędzy!");
				return 1;
			if(strval(inputtext) < 5000)
				SCM(playerid, C_WHITE, ""E" "W"Zbyt niska kwota! (Minimum 5000$)");
				return 1;
            if(!Player[playerid][HitmanBlock])
				Player[playerid][HitmanBlock] = true;
				SetTimerEx("HitmanUnlock", 10000, 0,"i",playerid);
				new pierwszyraz = false;
		        if(Player[gracz][bounty] <= 0)
					pierwszyraz = true;
				if(Player[gracz][bounty]+strval(inputtext) <= 2147483647)
					Player[gracz][bounty]+=strval(inputtext);
					GivePlayerMoney(playerid, 0-strval(inputtext));
					Player[playerid][Money] -= strval(inputtext);
	else{
					Player[gracz][bounty] = 2147483647;
					GivePlayerMoney(playerid, 0-strval(inputtext));
					Player[playerid][Name] -= strval(inputtext);
				new tmp[255];
		        if(pierwszyraz)
					format(tmp, sizeof(tmp), ""WI" {E36600}%s (%d) wyznacza nagrodę za głowę gracza %s (%d) w wysokości: %d$ (/Hitman)", Player[playerid][Name],playerid, Player[gracz][Name], gracz,strval(inputtext));
					SCMA(0xE36633FF, tmp);
				else
		            format(tmp, sizeof(tmp), ""WI" {E36600}%s (%d) zwiększa stawkę za głowę gracza %s (%d)! Łączna suma: %d$ (/Hitman)", Player[playerid][Name],playerid, Player[gracz][Name], gracz,Player[gracz][bounty]);
					SCMA(0xE36633FF, tmp);
				format(tmp, sizeof(tmp), ""WI" "R"Jesteś poszukiwany za %d$! Twoja śmierć oznacza wzbogacenie twego zabójcy.",strval(inputtext));
				SCM(gracz, C_RED, tmp);
		        GameTextForAll("~r~~h~] ~w~ZLECENIE ~r~~h~]",5000,3);
			else
                SCM(playerid, C_WHITE, ""E" "W"Możesz tego używać co 10 sekund!");
		else
            SPD(playerid, D_PLAYER, DIALOG_STYLE_LIST, Player[gracz][Name], "› Idź do gracza\n"GUI2"› Statystyki\n"W"› Wyślij kasę\n"GUI2"› Raportuj łamanie regulaminu\n"W"› Wystaw nagrodę za głowę", "Wybierz", "Anuluj");
	if(dialogid == D_PRZEDMIOTY && response)
		switch(listitem)
			case 0: SPD(playerid,D_PRZEDMIOTY1,DIALOG_STYLE_LIST, "{00BFFF}Czapki", "› Czapka1\n› Czapka2\n› Czapka3\n› Czapka4\n› Czapka5\n› Czapka6", "Wybierz", "Cofnij");
            case 1: SPD(playerid,D_PRZEDMIOTY2,DIALOG_STYLE_LIST, "{00BFFF}Kapelusze", "› Kapelusz1\n› Kapelusz2\n› Kapelusz3\n› Kapelusz4\n› Kapelusz5\n› Kapelusz6\n› Kapelusz7", "Wybierz", "Cofnij");
            case 2: SPD(playerid,D_PRZEDMIOTY3,DIALOG_STYLE_LIST, "{00BFFF}Hełmy", "› Hełm1\n› Hełm2\n› Hełm3\n› Hełm4\n› Hełm5\n› Hełm6\n› Hełm7\n› Hełm8\n› Hełm9\n› Hełm10\n› Hełm11", "Wybierz", "Cofnij");
            case 3: SPD(playerid,D_PRZEDMIOTY4,DIALOG_STYLE_LIST, "{00BFFF}Maski", "› Maska1\n› Maska2", "Wybierz", "Cofnij");
            case 4: SPD(playerid,D_PRZEDMIOTY5,DIALOG_STYLE_LIST, "{00BFFF}Inne", "› Tarcza\n› Kamizelka\n› Papuga\n› Teczka\n› Kanister\n› Cygaro\n› Kasa\n› Latarka\n› Okulary\n› Katana", "Wybierz", "Cofnij");
            case 5: SPD(playerid,D_PRZEDMIOTY6,DIALOG_STYLE_LIST, "{00BFFF}Usuń przedmioty", "› Tułów\n› Głowa\n› Ręce\n› Wszystkie", "Wybierz", "Cofnij");
    if(dialogid == D_PRZEDMIOTY1)
		if(response)
            SendClientMessage(playerid, 0x00FFFFAA, ""I" {00FFFF}Założyłeś czapkę.");
			if(listitem == 0)
                SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 19064, 2, 0.130, 0.025, 0.0, 0,90,90, 1.2,1.2,1.2);
			if(listitem == 1)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 18636, 2, 0.135, 0.055, 0.0, 0,90,90, 1.2,1.2,1.2);
			if(listitem == 2)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 19093, 2, 0.1, 0.0, 0.0, 0,0,0, 1.1,1.1,1.1);
			if(listitem == 3)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 19160, 2, 0.1, 0.0, 0.0, 0,0,0, 1.1,1.1,1.1);
			if(listitem == 4)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 19161, 2, 0.1, 0.0, 0.0, 0,0,0, 1.1,1.1,1.1);
			if(listitem == 5)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 19162, 2, 0.1, 0.0, 0.0, 0,0,0, 1.1,1.1,1.1);
		else
			cmd_przedmioty(playerid);
    if(dialogid == D_PRZEDMIOTY2)
		if(response)
            SendClientMessage(playerid, 0x00FFFFAA, ""I" {00FFFF}Założyłeś kapelusz.");
			if(listitem == 0)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 19095, 2, 0.155, 0.010, 0.0, 0,0,0, 1.165,1.165,1.165);
			if(listitem == 1)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 19096, 2, 0.155, 0.010, 0.0, 0,0,0, 1.165,1.165,1.165);
			if(listitem == 2)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 19097, 2, 0.155, 0.010, 0.0, 0,0,0, 1.165,1.165,1.165);
			if(listitem == 3)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 19098, 2, 0.155, 0.010, 0.0, 0,0,0, 1.165,1.165,1.165);
			if(listitem == 4)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 19099, 2, 0.155, 0.010, 0.0, 0,0,0, 1.165,1.165,1.165);
			if(listitem == 5)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 19100, 2, 0.155, 0.010, 0.0, 0,0,0, 1.165,1.165,1.165);
			if(listitem == 6)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 19136, 2, 0.115, 0.0, 0.0, 0,0,0, 1.165,1.165,1.165);
		else
			cmd_przedmioty(playerid);
    if(dialogid == D_PRZEDMIOTY3)
		if(response)
            SendClientMessage(playerid, 0x00FFFFAA, ""I" {00FFFF}Założyłeś hełm.");
			if(listitem == 0)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 19101, 2, 0.155, 0.010, 0.0, 0,0,0, 1.165,1.165,1.165);
			if(listitem == 1)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 19102, 2, 0.155, 0.010, 0.0, 0,0,0, 1.165,1.165,1.165);
			if(listitem == 2)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 19103, 2, 0.155, 0.010, 0.0, 0,0,0, 1.165,1.165,1.165);
			if(listitem == 3)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 19104, 2, 0.155, 0.010, 0.0, 0,0,0, 1.165,1.165,1.165);
			if(listitem == 4)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 19105, 2, 0.155, 0.010, 0.0, 0,0,0, 1.165,1.165,1.165);
			if(listitem == 5)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 19106, 2, 0.155, 0.010, 0.0, 0,0,0, 1.165,1.165,1.165);
			if(listitem == 6)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 19107, 2, 0.155, 0.010, 0.0, 0,0,0, 1.165,1.165,1.165);
			if(listitem == 7)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 19108, 2, 0.155, 0.010, 0.0, 0,0,0, 1.165,1.165,1.165);
			if(listitem == 8)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 19109, 2, 0.155, 0.010, 0.0, 0,0,0, 1.165,1.165,1.165);
			if(listitem == 9)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 19110, 2, 0.155, 0.010, 0.0, 0,0,0, 1.165,1.165,1.165);
			if(listitem == 10)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 19111, 2, 0.155, 0.010, 0.0, 0,0,0, 1.165,1.165,1.165);
		else
			cmd_przedmioty(playerid);
    if(dialogid == D_PRZEDMIOTY4)
		if(response)
            SendClientMessage(playerid, 0x00FFFFAA, ""I" {00FFFF}Założyłeś maskę.");
			if(listitem == 0)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 19163, 2, 0.080, 0.035, 0.0, 180,90,0, 1.225,1.225,1.225);
			if(listitem == 1)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_GLOWA, 19137, 2, 0.115, 0.020, 0.0, 0,0,0, 1.1,1.1,1.1);
	    else
			cmd_przedmioty(playerid);
    if(dialogid == D_PRZEDMIOTY5)
		if(response)
			if(listitem == 0)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_INNE, 18637, 1, 0.1, 0.3, -0.1, 90,180,90, 1.2,1.3,1.2);
				SendClientMessage(playerid, 0x00FFFFAA, ""I" {00FFFF}Założyłeś tarczę.");
			if(listitem == 1)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_INNE, 19142, 1, 0.075, 0.045, 0.0, 0,0,0, 1.1,1.1,1.1);
				SendClientMessage(playerid, 0x00FFFFAA, ""I" {00FFFF}Założyłeś kamizelkę.");
			if(listitem == 2)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_INNE, 19078, 1, 0.3, -0.040, 0.185, 0,0,0, 0.8,0.8,0.8);
				SendClientMessage(playerid, 0x00FFFFAA, ""I" {00FFFF}Dodałeś papugę.");
			if(listitem == 3)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_RECE, 1210, 6, 0.340,0.110,0.0, 0,270,0, 1.2,1.2,1.2);
				SendClientMessage(playerid, 0x00FFFFAA, ""I" {00FFFF}Dodałeś teczkę.");
			if(listitem == 4)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_RECE, 1650, 6, 0.130,0.020,0.050, 0,270,0, 1.2,1.2,1.2);
				SendClientMessage(playerid, 0x00FFFFAA, ""I" {00FFFF}Dodałeś kanister.");
			if(listitem == 5)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_INNE, 1485, 18, -0.05, -0.055, -0.015, 0,0,0, 1.2,1.2,1.2);
				SendClientMessage(playerid, 0x00FFFFAA, ""I" {00FFFF}Dodałeś cygaro.");
			if(listitem == 6)
		        SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_RECE, 1212, 6, 0.080,0.080,0.050, 90,0,90, 0.9,0.9,0.9);
				SendClientMessage(playerid, 0x00FFFFAA, ""I" {00FFFF}Dodałeś kasę.");
			if(listitem == 7)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_RECE, 18641, 6, 0.080,0.020,0.025, 180,0,0, 1.2,1.2,1.2);
				SendClientMessage(playerid, 0x00FFFFAA, ""I" {00FFFF}Dodałeś latarkę.");
			if(listitem == 8)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_INNE, 19138, 2, 0.1, 0.035, 0.0, 90,90,0, 1.1,1.1,1.1);
				SendClientMessage(playerid, 0x00FFFFAA, ""I" {00FFFF}Dodałeś okulary.");
			if(listitem == 9)
				SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_RECE, 339, 5, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
				SendClientMessage(playerid, 0x00FFFFAA, ""I" {00FFFF}Dodałeś katanę.");
			if(listitem == 10)
			    SetPlayerAttachedObject(playerid, SLOT_PRZEDMIOT_RECE, 18643, 6, 0.080,0.020,0.0, 90,0,90, 1.2,1.2,1.2);
				SendClientMessage(playerid, 0x00FFFFAA, ""I" {00FFFF}Dodałeś laser.");
		else
			cmd_przedmioty(playerid);
    if(dialogid == D_PRZEDMIOTY6)
		if(response)
			if(listitem == 0)
                RemovePlayerAttachedObject(playerid,SLOT_PRZEDMIOT_INNE);
				SendClientMessage(playerid, 0x00FFFFAA, ""I" {00FFFF}Usunięto inne przedmioty.");
			if(listitem == 1)
                RemovePlayerAttachedObject(playerid,SLOT_PRZEDMIOT_GLOWA);
				SendClientMessage(playerid, 0x00FFFFAA, ""I" {00FFFF}Usunięto przedmioty z głowy.");
			if(listitem == 2)
                RemovePlayerAttachedObject(playerid,SLOT_PRZEDMIOT_RECE);
				SendClientMessage(playerid, 0x00FFFFAA, ""I" {00FFFF}Usunięto przedmioty z rąk.");
			if(listitem == 3)
                RemovePlayerAttachedObject(playerid,SLOT_PRZEDMIOT_INNE);
                RemovePlayerAttachedObject(playerid,SLOT_PRZEDMIOT_GLOWA);
                RemovePlayerAttachedObject(playerid,SLOT_PRZEDMIOT_RECE);
				SendClientMessage(playerid, 0x00FFFFAA, ""I" {00FFFF}Usunięto wszystkie przedmioty.");
		else
			cmd_przedmioty(playerid);
    if(dialogid == D_MENU_GANG && response)
		switch(listitem)
			case 0:
				if(!Player[playerid][Registered])
					SendClientMessage(playerid, 0x00FFFFAA, ""E" {FFFFFF}Musisz być zarejestrowany! /Register [Hasło].");
					cmd_gang(playerid);
					return 1;
    			SPD(playerid,D_SHOW_GANGS,DIALOG_STYLE_LIST,"{00BFFF}Lista gangów",GetGangsForPlayer(playerid," \n"),"Dołącz","Cofnij");
			case 1:
                if(!Player[playerid][Registered])
					SendClientMessage(playerid, 0x00FFFFAA, ""E" {FFFFFF}Musisz być zarejestrowany! /Register [Hasło].");
					cmd_gang(playerid);
					return 1;
				if(IsPlayerInAnyGang(playerid))
					SCM(playerid,C_RED,""WE" "R"Jesteś już w jakimś gangu!");
					cmd_gang(playerid);
					return 1;
                if(Player[playerid][Exp] < 10000)
					SendClientMessage(playerid, 0x00FFFFAA, ""E" {FFFFFF}Nie stać cię na założenie gangu! (10.000 pkt exp).");
					cmd_gang(playerid);
					return 1;
                if(TotalGangs == MAX_GANGS)
					SendClientMessage(playerid, 0x00FFFFAA, ""E" {FFFFFF}Niestety, wykorzystano limit gangów. (20)");
					cmd_gang(playerid);
					return 1;
				SPD(playerid,D_CREATE_GANG1,DIALOG_STYLE_INPUT,"{00BFFF}Nowy gang - Nazwa","Podaj nazwę gangu:\n\n(Nazwa gangu musi mieć od 4 do 32 znaków)","Dalej","Cofnij");
	if(dialogid == D_CREATE_GANG1)
		if(response)
			if(strlen(inputtext) < 4 || strlen(inputtext) > 32)
				SCM(playerid,C_RED,""WE" "R"Nazwa gangu musi posiadać od 4 do 32 znaków.");
                SPD(playerid,D_CREATE_GANG1,DIALOG_STYLE_INPUT,"{00BFFF}Nowy gang - Nazwa","Podaj nazwę gangu:\n\n(Nazwa gangu musi mieć od 4 do 32 znaków)","Dalej","Koniec");
				return 1;
			format(Player[playerid][NewGangNazwa],32,inputtext);
			SCM(playerid, C_WHITE, ""I" "W"Nazwa gangu zapisana.");
			SPD(playerid,D_CREATE_GANG2,DIALOG_STYLE_INPUT,"{00BFFF}Nowy gang - Tag","Wpisz tag gangu bez nawiasów. Serwer automatycznie je doda.\n\nPrzykład: VLA","Dalej","Koniec");
		else
			cmd_gang(playerid);
	if(dialogid == D_CREATE_GANG2)
		if(response)
            if(strfind(inputtext,"[",true) != -1 || strfind(inputtext,"]",true) != -1 || strfind(inputtext,"(",true) != -1 || strfind(inputtext,")",true) != -1)
                SPD(playerid,D_CREATE_GANG2,DIALOG_STYLE_INPUT,"{00BFFF}Nowy gang - Tag","Wpisz tag gangu bez nawiasów. Serwer automatycznie je doda.\n\nPrzykład: VLA","Dalej","Koniec");
				SCM(playerid,C_RED,""WE" "R"Musisz wpisać tag gangu bez użycia nawiasów.");
				return 1;
			if(strlen(inputtext) < 2 || strlen(inputtext) > 4)
                SPD(playerid,D_CREATE_GANG2,DIALOG_STYLE_INPUT,"{00BFFF}Nowy gang - Tag","Wpisz tag gangu bez nawiasów. Serwer automatycznie je doda.\n\nPrzykład: VLA","Dalej","Koniec");
				SCM(playerid,C_RED,""WE" "R"Tag gangu musi mieć od 2 do 4 znaków.");
				return 1;
            SCM(playerid, C_WHITE, ""I" "W"Nazwa tagu gangu zapisana.");
			format(Player[playerid][NewGangTag],32,inputtext);
            for(new x=0;x<MAX_GANGS;x++)
				if(strfind(gInfo[x][gKolorChat],Player[playerid][ChatColor],false)==0)
                    SPD(playerid,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Nowy gang - Kolor zajęty","Niestety, twój kolor nicku służy jako kolor gangu.\n\nJakiś gang używa już tego koloru.\n\nZmień kolor nicku komendą /Kolor i spróbuj ponownie.","Zamknij","");
					return 1;
			new c = Player[playerid][Color],mozna = false;
            for(new x=0;x<sizeof(playerColors);x++)
				if(playerColors[x] == c)
					mozna = true;
			if(!mozna)
                SCM(playerid,C_WHITE,""I" "W"Ten kolor jest nie dozwolony! Dostępne kolory z listy /kolor.");
				return 1;
			new String[155];
			format(String,sizeof(String),"{%s}%s\n\n"GUI"Twój kolor nicku służy jako kolor gangu.\nJeżeli chcesz inny wpisz komendę /Kolor i spróbuj ponownie.",Player[playerid][ChatColor],Player[playerid][NewGangNazwa]);
			SPD(playerid,D_CREATE_GANG3,DIALOG_STYLE_MSGBOX,"{00BFFF}Nowy gang - Kolor",String,"Dalej","Koniec");
		else
            cmd_gang(playerid);
	if(dialogid == D_CREATE_GANG3)
		if(response)
            SCM(playerid, C_WHITE, ""I" "W"Kolor nowego gangu zapisany.");
			SPD(playerid,D_CREATE_GANG4,DIALOG_STYLE_INPUT,"{00BFFF}Nowy gang - Pojazd","Wpisz nazwę lub ID pojazdu gangowego.\n\n(Nazwy pojazdów są pod komendą /Cars)","Dalej","Koniec");
		else
			cmd_gang(playerid);
	if(dialogid == D_CREATE_GANG4)
		if(response)
            new pojazd;
			pojazd = GetVehicleModelIDFromName(inputtext);
			if(pojazd < 400 || pojazd > 611)
				SCM(playerid, C_RED, ""WE" "R"Taki pojazd nie został znaleziony.");
				cmd_gang(playerid);
				return 1;
            if(pojazd == 592 || pojazd == 577 || pojazd == 520 || pojazd == 432 || pojazd == 425 || pojazd == 447 || pojazd == 406 || pojazd == 537 || pojazd == 538 || pojazd == 569 || pojazd == 570 || pojazd == 584 || pojazd == 590 || pojazd == 591 || pojazd == 606  || pojazd == 607 || pojazd == 608 || pojazd == 610 || pojazd == 611 || pojazd == 464 || pojazd == 465 || pojazd == 501 || pojazd == 564 || pojazd == 594 && !IsPlayerAdmin(playerid))
	            SCM(playerid, C_RED, ""WE" "R"Ten pojazd jest nie dozwolony!");
				cmd_gang(playerid);
				return 1;
            SCM(playerid, C_WHITE, ""I" "W"Pojazd nowego gangu zapisany. Potwierdź stworzenie gangu.");
			Player[playerid][NewGangCar] = pojazd;
			new String[255];
			format(String,sizeof(String),"Twój gang prezentuje się następująco:\n\nNazwa: %s\nTag: [%s]\nSzef: %s\nVice-Szef: Brak\nKolor: {%s}%s\n"GUI"Pojazd: %s (ID: %d)\nSkin: N/A",
			Player[playerid][NewGangNazwa],Player[playerid][NewGangTag],Player[playerid][Name],Player[playerid][ChatColor],Player[playerid][ChatColor],CarList[Player[playerid][NewGangCar]-400],Player[playerid][NewGangCar]);
			SPD(playerid,D_CREATE_GANG5,DIALOG_STYLE_MSGBOX,"{00BFFF}Nowy gang - Zakończenie",String,"Stwórz","Koniec");
		else
			cmd_gang(playerid);
	if(dialogid == D_CREATE_GANG5)
		if(response)
            CreateGang(playerid,Player[playerid][NewGangNazwa],Player[playerid][NewGangTag],Player[playerid][ChatColor],Player[playerid][NewGangCar],0);
			Player[playerid][Exp] -= 10000;
			GameTextForPlayer(playerid,"~w~Exp - ~b~~h~10000",1000, 1);
			new String[128];
			format(String,sizeof(String),"UPDATE "PREFIX"Users SET Exp='%d' WHERE Name='%s'",Player[playerid][Exp],Player[playerid][Name]);
			mysql_query(String);
            SCM(playerid, C_WHITE, ""I" "W"Zapłaciłeś 10.000 pkt exp.");
            SCM(playerid, C_WHITE, ""I" "W"Twój nowy gang został utworzony! Panel zarządzania znajdziesz pod /Gang.");
		else
			cmd_gang(playerid);
	if(dialogid == D_SHOW_GANGS)
		if(response)
			if(!Player[playerid][Registered])
				SCM(playerid,C_WHITE,""E" "W"Musisz być zarejestrowany, aby dołączyć do gangu.");
			else
				new String[155],GangId = Player[playerid][GetGangs][listitem];
				format(String,sizeof(String),"Czy napewno chcesz prosić o członkostwo w gangu %s?\n\nSzef: %s\nVice-Szef: %s\nTag: %s\nLiczba członków: %d",gInfo[GangId][gName],gInfo[GangId][gSzef],gInfo[GangId][gVice],gInfo[GangId][gTag],GetGangPlayersCount(GangId));
				SPD(playerid,D_JOIN_GANG,DIALOG_STYLE_MSGBOX,"{00BFFF}Dołączanie do gangu",String,"Dołącz","Cofnij");
				Player[playerid][DoTegoGanguZapro] = GangId;
		else
			cmd_gang(playerid);
	if(dialogid == D_JOIN_GANG)
		if(response)
			if(Player[playerid][gZapro] == Player[playerid][DoTegoGanguZapro])
				SPD(playerid,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Wystąpił błąd","Aktualnie wysłałeś już jedną prośbę o członkostwo do tego gangu.\n\nOczekuj na rozpatrzenie prośby lub dołącz do innego gangu.","Zamknij","");
				return 1;
            if(Player[playerid][gZapro] > -1)
				new String[200];
				format(String,sizeof(String),"Wysłałeś wcześniej prośbę do gangu %s.\n\nCzy chcesz anulować prośbę o dołączenie do gangu %s, i wysłać ją do gangu %s?",gInfo[Player[playerid][gZapro]][gName],gInfo[Player[playerid][gZapro]][gName],gInfo[Player[playerid][DoTegoGanguZapro]][gName]);
				SPD(playerid,D_CONFLICT_ZAPRO_GANG,DIALOG_STYLE_MSGBOX,"{00BFFF}Potwierdzenie",String,"Tak","Nie");
				return 1;
			new String[155];
			if(!GangAccountExists(Player[playerid][Name]))
				format(String,sizeof(String),"INSERT INTO "PREFIX"Gangi_Users VALUES ('-1','%s','-1','%d')",Player[playerid][Name],Player[playerid][DoTegoGanguZapro]);
				mysql_query(String);
			else
                SetPlayerGangZapro(playerid,Player[playerid][DoTegoGanguZapro]);
			format(String,sizeof(String),"Wysłano prośbę o dołączenie do gangu %s.\n\nOczekuj na rozpatrzenie prośby.",gInfo[Player[playerid][DoTegoGanguZapro]][gName]);
			SPD(playerid,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Prośba wysłana",String,"Zamknij","");
		else
			cmd_gang(playerid);
	if(dialogid == D_CONFLICT_ZAPRO_GANG)
		if(response)
			SetPlayerGangZapro(playerid,Player[playerid][DoTegoGanguZapro]);
			new String[128];
			format(String,sizeof(String),"Wysłano prośbę o dołączenie do gangu %s.\n\nOczekuj na rozpatrzenie prośby.",gInfo[Player[playerid][DoTegoGanguZapro]][gName]);
			SPD(playerid,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Prośba wysłana",String,"Zamknij","");
		else
			cmd_gang(playerid);
	if(dialogid == D_CONTROL_GANG_SZEF && response)
		switch(listitem)
			case 0: //Zobacz prośby o dołączenie
                SPD(playerid,D_ZAPRO_DO_GANGU,DIALOG_STYLE_LIST,"{00BFFF}Prośby o dołączenie do gangu",GetZaproDoGangu(playerid," \n"),"Wybierz","Cofnij");
			case 1: //Lista członków gangu
                SPD(playerid,D_VIEV_GANG_MEMBERS,DIALOG_STYLE_LIST,"{00BFFF}Lista członków gangu",GetGangMembersForPlayer(playerid," \n"),"Zamknij","Cofnij");
			case 2: //Wyrzuć członka
                
				SPD(playerid,D_GANG_DEGRADE,DIALOG_STYLE_LIST,"{00BFFF}Wyrzuć członka",GetGangDegradeMembersForPlayer(playerid," \n"),"Wybierz","Cofnij");
			case 3: //Zmień Vice-Szefa gangu
				SPD(playerid,D_GANG_SET_VICE,DIALOG_STYLE_INPUT,"{00BFFF}Zmiana Vice-Szefa","Wpisz ID gracza, który ma zostać Vice-Szefem\n\n(Gracz musi być w twoim gangu)","Dalej","Cofnij");
			case 4: //Zmień tag gangu
                SPD(playerid,D_GANG_SET_TAG,DIALOG_STYLE_INPUT,"{00BFFF}Zmiana tagu gangu","Wpisz tag gangu bez nawiasów. Serwer automatycznie je doda.\n\nPrzykład: VLA","Zmień","Cofnij");
			case 5: //Zmień kolor gangu
				new String[155];
				format(String,sizeof(String),"{%s}%s\n\n"GUI"Czy chcesz zmienić kolor gangu na ten?\nKolor gangu zależy od twojego koloru nicku.",Player[playerid][ChatColor],gInfo[Player[playerid][InGang]][gName]);
				SPD(playerid,D_GANG_SET_COLOR,DIALOG_STYLE_MSGBOX,"{00BFFF}Zmiana koloru gangu",String,"Zmień","Cofnij");
			case 6: //Zmień pojazd gangu
                SPD(playerid,D_GANG_SET_CAR,DIALOG_STYLE_INPUT,"{00BFFF}Zmiana pojazdu gangowego","Wpisz nazwę lub id nowego pojazdu gangowego.\n\n(Nazwy pojazdów są pod komendą /Cars)","Zmień","Cofnij");
            case 7: //Zmień skin gangu
                SPD(playerid,D_GANG_SET_SKIN,DIALOG_STYLE_LIST,"{00BFFF}Zmiana skinu gangu","› Wpisz ID skina\n"GUI2"› Użyj twój aktualny skin","Wybierz","Cofnij");
			case 8: //Ustaw wejście do siedziby gangu
				Player[playerid][gAkceptEnabled] = true;
				SCM(playerid,C_WHITE,""I" "W"Idź do miejsca, gdzie ma się znajdować wejście do siedziby.");
                SCM(playerid,C_WHITE,""I" "W"Gdy już tam będziesz wpisz /gAkceptuj. Wejście może znajdować się tylko na twoim terenie.");
			case 9: //Ustaw wnętrze siedziby gangu
				Player[playerid][gAkceptInteriorEnabled] = true;
				SCM(playerid,C_WHITE,""I" "W"Idź do miejsca, gdzie ma się znajdować "Y"wnętrze "W"siedziby gangu.");
                SCM(playerid,C_WHITE,""I" "W"Gdy już tam będziesz wpisz /gAkceptujInterior.");
			case 10: //Usuń gang
                SPD(playerid,D_CONFIRM_DELETE_GANG,DIALOG_STYLE_MSGBOX,"Potwierdzenie","Czy napewno chcesz usunąć gang?\n\nJeżeli twój gang posiada vice-szefa, przejmie on stanowisko szefa i gang nie zostanie usunięty.\nJeżeli go nie posiada, to gang zostanie usunięty.","Tak","Nie");
			case 11: //Zmień swój skin na gangowy
				SetPlayerSkin(playerid,gInfo[Player[playerid][InGang]][gSkin]);
				SCM(playerid,C_WHITE,""I" "W"Zmieniłeś swój skin na gangowy.");
			case 12: //Zmień kolor nicku na barwy gangu
                format(Player[playerid][ChatColor],32,gInfo[Player[playerid][InGang]][gKolorChat]);
				Player[playerid][Color] = gInfo[Player[playerid][InGang]][gColor];
				SetPlayerColor(playerid,Player[playerid][Color]);
				SCM(playerid,C_WHITE,""I" "W"Zmieniłeś swój kolor na gangowy.");
			case 13: //Teleportuj przed siedzibę
			    if(gInfo[Player[playerid][InGang]][gEnterX] == 0.0)
                    SCM(playerid,C_WHITE,""I" "W"Twój gang nie posiada siedziby.");
					return 1;
				if(IsPlayerNearAnyone(playerid, 15.0))
					SPD(playerid, D_NONE, DIALOG_STYLE_MSGBOX, "{00BFFF}Teleport", "Niestety, nie możesz teleportować się do siedziby bezpośrednio, gdy twój gang toczy wojnę. Odsuń się od innych o 15 metrów.", "Zamknij", "");
				    return 1;
				SetPlayerPos(playerid,gInfo[Player[playerid][InGang]][gEnterX],gInfo[Player[playerid][InGang]][gEnterY],gInfo[Player[playerid][InGang]][gEnterZ]);
			case 14: //Zrespawnuj pojazd gangowy
                GivePlayerCar(playerid, gInfo[Player[playerid][InGang]][gCar]);
                SCM(playerid,C_WHITE,""I" "W"Pojazd gangowy zrespawnowany.");
			case 15: //Dodaj tag gangu do nicku
				SPD(playerid,D_GANG_ADD_TAG,DIALOG_STYLE_LIST,"{00BFFF}Dodawanie tagu do nicku","› Za nickiem\n› Przed nickiem","Wybierz","Cofnij");
			case 16: //Informacje o gangu
				new String[400],GangId = Player[playerid][InGang];
				format(String,sizeof(String),
				"› Nazwa: %s\n› Tag: %s\n› Pojazd: %s (ID: %d)\n› Skin: %s (ID: %d)\n› Liczba członków: %d\n› Szef: %s\n› Vice-Szef: %s",
				gInfo[GangId][gName],gInfo[GangId][gTag],CarList[gInfo[GangId][gCar]-400],gInfo[GangId][gCar],GetSkinName(gInfo[GangId][gSkin]),gInfo[GangId][gSkin],
				GetGangPlayersCount(GangId),gInfo[GangId][gSzef],gInfo[GangId][gVice]);
				SPD(playerid,D_GANG_STATS,DIALOG_STYLE_LIST,"Informacje o gangu",String,"Zamknij","Cofnij");
	if(dialogid == D_GANG_ADD_TAG)
		if(response)
            new String[32],LocalName[MAX_PLAYER_NAME];
            GetPlayerName(playerid,LocalName,MAX_PLAYER_NAME);
			switch(listitem)
				case 0:
					if(strfind(LocalName,gInfo[Player[playerid][InGang]][gTag],true)==0)
						SetPlayerName(playerid,Player[playerid][Name]);
						SCM(playerid,C_WHITE,""Y"*(G) "W"Tag usunięty z nicku.");
					else
						format(String,sizeof(String),"%s%s",Player[playerid][Name],gInfo[Player[playerid][InGang]][gTag]);
						if(strlen(String) <= MAX_PLAYER_NAME)
							SetPlayerName(playerid,String);
							SCM(playerid,C_WHITE,""Y"*(G) "W"Dodałeś tag do nicku za nickiem. Będzie on widoczny tylko nad nickiem.");
						else
							SCM(playerid,C_WHITE,""E" "W"Twój nick z tagiem będzie zbyt długi i nie można dodać tagu.");
				case 1:
                    if(strfind(LocalName,gInfo[Player[playerid][InGang]][gTag],true)==0)
						SetPlayerName(playerid,Player[playerid][Name]);
						SCM(playerid,C_WHITE,""Y"*(G) "W"Tag usunięty z nicku.");
					else
						format(String,sizeof(String),"%s%s",gInfo[Player[playerid][InGang]][gTag],Player[playerid][Name]);
						if(strlen(String) <= MAX_PLAYER_NAME)
							SetPlayerName(playerid,String);
							SCM(playerid,C_WHITE,""Y"*(G) "W"Dodałeś tag do nicku przed nickiem. Będzie on widoczny tylko nad nickiem.");
						else
							SCM(playerid,C_WHITE,""E" "W"Twój nick z tagiem będzie zbyt długi i nie można dodać tagu.");
		else
			cmd_gang(playerid);
	if(dialogid == D_CONFIRM_DELETE_GANG)
		if(response)
            DeleteGang(playerid,Player[playerid][InGang]);
			SCM(playerid,C_WHITE,""I" "W"Jeżeli twój gang posiadał vice-szefa, został on nowym szefem. Jeżeli nie, to gang został usunięty.");
		else
			cmd_gang(playerid);
	if(dialogid == D_CONTROL_GANG_VICE && response)
		switch(listitem)
			case 0: //Zobacz prośby o dołączenie
                SPD(playerid,D_ZAPRO_DO_GANGU,DIALOG_STYLE_LIST,"{00BFFF}Prośby o dołączenie do gangu",GetZaproDoGangu(playerid," \n"),"Wybierz","Cofnij");
			case 1: //Lista członków gangu
                SPD(playerid,D_VIEV_GANG_MEMBERS,DIALOG_STYLE_LIST,"{00BFFF}Lista członków gangu",GetGangMembersForPlayer(playerid," \n"),"Zamknij","Cofnij");
			case 2: //Wyrzuć członka
                SPD(playerid,D_GANG_DEGRADE,DIALOG_STYLE_LIST,"{00BFFF}Wyrzuć członka",GetGangDegradeMembersForPlayer(playerid," \n"),"Wybierz","Cofnij");
			case 3: //Zmień swój skin na gangowy
            	SetPlayerSkin(playerid,gInfo[Player[playerid][InGang]][gSkin]);
				SCM(playerid,C_WHITE,""I" "W"Zmieniłeś swój skin na gangowy.");
			case 4: //Zmień kolor nicku na barwy gangu
                format(Player[playerid][ChatColor],32,gInfo[Player[playerid][InGang]][gKolorChat]);
				Player[playerid][Color] = gInfo[Player[playerid][InGang]][gColor];
				SetPlayerColor(playerid,Player[playerid][Color]);
				SCM(playerid,C_WHITE,""I" "W"Zmieniłeś swój kolor na gangowy.");
			case 5: //Teleportuj przed siedzibę
			    if(gInfo[Player[playerid][InGang]][gEnterX] == 0.0)
                    SCM(playerid,C_WHITE,""I" "W"Twój gang nie posiada siedziby.");
					return 1;
			    if(IsPlayerNearAnyone(playerid, 15.0))
					SPD(playerid, D_NONE, DIALOG_STYLE_MSGBOX, "{00BFFF}Teleport", "Niestety, nie możesz teleportować się do siedziby bezpośrednio, gdy twój gang toczy wojnę. Odsuń się od innych o 15 metrów.", "Zamknij", "");
				    return 1;
				SetPlayerPos(playerid,gInfo[Player[playerid][InGang]][gEnterX],gInfo[Player[playerid][InGang]][gEnterY],gInfo[Player[playerid][InGang]][gEnterZ]);
			case 6: //Zrespawnuj pojazd gangowy
                GivePlayerCar(playerid, gInfo[Player[playerid][InGang]][gCar]);
                SCM(playerid,C_WHITE,""I" "W"Pojazd gangowy zrespawnowany.");
            case 7: //Dodaj tag  gangu do nicku
                new String[32],LocalName[MAX_PLAYER_NAME];
                GetPlayerName(playerid,LocalName,MAX_PLAYER_NAME);
				if(strfind(LocalName,gInfo[Player[playerid][InGang]][gTag],true)==0)
					SetPlayerName(playerid,Player[playerid][Name]);
					SCM(playerid,C_WHITE,""Y"*(G) "W"Tag usunięty z nicku.");
				else
					format(String,sizeof(String),"%s%s",gInfo[Player[playerid][InGang]][gTag],Player[playerid][Name]);
					if(strlen(String) <= 21)
						SetPlayerName(playerid,String);
						SCM(playerid,C_WHITE,""Y"*(G) "W"Dodałeś tag do nicku. Będzie on widoczny tylko nad nickiem.");
					else
						SCM(playerid,C_WHITE,""E" "W"Twój nick z tagiem będzie zbyt długi i nie można dodać tagu.");
			case 8: //Informacje o gangu
				new String[400],GangId = Player[playerid][InGang];
				format(String,sizeof(String),
				"› Nazwa: %s\n› Tag: %s\n› Pojazd: %s (ID: %d)\n› Skin: %s (ID: %d)\n› Liczba członków: %d\n› Szef: %s\n› Vice-Szef: %s",
				gInfo[GangId][gName],gInfo[GangId][gTag],CarList[gInfo[GangId][gCar]-400],gInfo[GangId][gCar],GetSkinName(gInfo[GangId][gSkin]),gInfo[GangId][gSkin],
				GetGangPlayersCount(GangId),gInfo[GangId][gSzef],gInfo[GangId][gVice]);
				SPD(playerid,D_GANG_STATS,DIALOG_STYLE_LIST,"Informacje o gangu",String,"Zamknij","Cofnij");
			case 9: //Odejdź z gangu
				LeavePlayerFromGang(Player[playerid][InGang],playerid);
	if(dialogid == D_CONTROL_GANG && response)
		switch(listitem)
			case 0: //Lista członków
                SPD(playerid,D_VIEV_GANG_MEMBERS,DIALOG_STYLE_LIST,"{00BFFF}Lista członków gangu",GetGangMembersForPlayer(playerid," \n"),"Zamknij","Cofnij");
			case 1: //Zmień swój skin na gangowy
                SetPlayerSkin(playerid,gInfo[Player[playerid][InGang]][gSkin]);
				SCM(playerid,C_WHITE,""I" "W"Zmieniłeś swój skin na gangowy.");
			case 2: //Zmień kolor nicku na barwy gangu
                format(Player[playerid][ChatColor],32,gInfo[Player[playerid][InGang]][gKolorChat]);
				Player[playerid][Color] = gInfo[Player[playerid][InGang]][gColor];
				SetPlayerColor(playerid,Player[playerid][Color]);
				SCM(playerid,C_WHITE,""I" "W"Zmieniłeś swój kolor na gangowy.");
			case 3: //Teleportuj przed siedzibę
                if(gInfo[Player[playerid][InGang]][gEnterX] == 0.0)
                    SCM(playerid,C_WHITE,""I" "W"Twój gang nie posiada siedziby.");
					return 1;
                if(IsPlayerNearAnyone(playerid, 15.0))
					SPD(playerid, D_NONE, DIALOG_STYLE_MSGBOX, "{00BFFF}Teleport", "Niestety, nie możesz teleportować się do siedziby bezpośrednio, gdy twój gang toczy wojnę. Odsuń się od innych o 15 metrów.", "Zamknij", "");
				    return 1;
                SetPlayerPos(playerid,gInfo[Player[playerid][InGang]][gEnterX],gInfo[Player[playerid][InGang]][gEnterY],gInfo[Player[playerid][InGang]][gEnterZ]);
			case 4: //Zrespawnuj pojazd gangowy
                GivePlayerCar(playerid, gInfo[Player[playerid][InGang]][gCar]);
                SCM(playerid,C_WHITE,""I" "W"Pojazd gangowy zrespawnowany.");
			case 5: //Dodaj tag gangu do nicku
                new String[32],LocalName[MAX_PLAYER_NAME];
                GetPlayerName(playerid,LocalName,MAX_PLAYER_NAME);
				if(strfind(LocalName,gInfo[Player[playerid][InGang]][gTag],true)==0)
					SetPlayerName(playerid,Player[playerid][Name]);
					SCM(playerid,C_WHITE,""Y"*(G) "W"Tag usunięty z nicku.");
				else
					format(String,sizeof(String),"%s%s",gInfo[Player[playerid][InGang]][gTag],Player[playerid][Name]);
					if(strlen(String) <= 21)
						SetPlayerName(playerid,String);
						SCM(playerid,C_WHITE,""Y"*(G) "W"Dodałeś tag do nicku. Będzie on widoczny tylko nad nickiem.");
					else
						SCM(playerid,C_WHITE,""E" "W"Twój nick z tagiem będzie zbyt długi i nie można dodać tagu.");
			case 6: //Informacje o gangu
                new String[400],GangId = Player[playerid][InGang];
				format(String,sizeof(String),
				"› Nazwa: %s\n› Tag: %s\n› Pojazd: %s (ID: %d)\n› Skin: %s (ID: %d)\n› Liczba członków: %d\n› Szef: %s\n› Vice-Szef: %s",
				gInfo[GangId][gName],gInfo[GangId][gTag],CarList[gInfo[GangId][gCar]-400],gInfo[GangId][gCar],GetSkinName(gInfo[GangId][gSkin]),gInfo[GangId][gSkin],
				GetGangPlayersCount(GangId),gInfo[GangId][gSzef],gInfo[GangId][gVice]);
				SPD(playerid,D_GANG_STATS,DIALOG_STYLE_LIST,"Informacje o gangu",String,"Zamknij","Cofnij");
			case 7: //Odejdź z gangu
                LeavePlayerFromGang(Player[playerid][InGang],playerid);
	if(dialogid == D_GANG_STATS && !response)
		cmd_gang(playerid);
	if(dialogid == D_GANG_SET_SKIN)
		if(response)
			switch(listitem)
				case 0:
                    SPD(playerid,D_GANG_SET_SKIN1,DIALOG_STYLE_INPUT,"{00BFFF}Zmiana skinu gangu","Wpisz ID skina, który ma być skinem gangowym:","Zmień","Cofnij");
				case 1:
					SetGangSkin(Player[playerid][InGang],GetPlayerSkin(playerid));
					SCM(playerid,C_WHITE,""I" "W"Skin gangu zmieniony!");
		else
			cmd_gang(playerid);
	if(dialogid == D_GANG_SET_SKIN1)
		if(response)
			if(!IsValidSkin(strval(inputtext)))
			    SCM(playerid,C_WHITE,""WE" "R"Niepoprawne id skina!");
				return 1;
			SetGangSkin(Player[playerid][InGang],strval(inputtext));
			SCM(playerid,C_WHITE,""I" "W"Skin gangu zmieniony!");
			//kod na zmiane skinu
		else
            SPD(playerid,D_GANG_SET_SKIN,DIALOG_STYLE_LIST,"{00BFFF}Zmiana skinu gangu","› Wpisz ID skina\n"GUI2"› Użyj twój aktualny skin","Wybierz","Cofnij");
	if(dialogid == D_GANG_SET_CAR)
		if(response)
            new pojazd;
			pojazd = GetVehicleModelIDFromName(inputtext);
			if(pojazd < 400 || pojazd > 611)
				SCM(playerid, C_RED, ""WE" "R"Taki pojazd nie został znaleziony.");
				cmd_gang(playerid);
				return 1;
            if(pojazd == 592 || pojazd == 577 || pojazd == 520 || pojazd == 432 || pojazd == 425 || pojazd == 447 || pojazd == 406 || pojazd == 537 || pojazd == 538 || pojazd == 569 || pojazd == 570 || pojazd == 584 || pojazd == 590 || pojazd == 591 || pojazd == 606  || pojazd == 607 || pojazd == 608 || pojazd == 610 || pojazd == 611 || pojazd == 464 || pojazd == 465 || pojazd == 501 || pojazd == 564 || pojazd == 594 && !IsPlayerAdmin(playerid))
	            SCM(playerid, C_RED, ""WE" "R"Ten pojazd jest nie dozwolony!");
				cmd_gang(playerid);
				return 1;
			SetGangCar(Player[playerid][InGang],pojazd);
			new String[128];
			format(String,sizeof(String), ""I" "W"Pojazd gangowy został zmieniony na: %s (ID: %d).",CarList[pojazd-400],pojazd);
			SCM(playerid,C_WHITE,String);
		else
			cmd_gang(playerid);
	if(dialogid == D_GANG_SET_COLOR)
		if(response)
            for(new x=0;x<MAX_GANGS;x++)
				if(strfind(gInfo[x][gKolorChat],Player[playerid][ChatColor],false)==0)
                    SCM(playerid,C_WHITE,""I" "W"Niestety, jakiś gang posiada już ten kolor. Użyj innego.");
					return 1;
			new c = Player[playerid][Color],mozna = false;
            for(new x=0;x<sizeof(playerColors);x++)
				if(playerColors[x] == c)
					mozna = true;
			if(!mozna)
                SCM(playerid,C_WHITE,""I" "W"Ten kolor jest nie dozwolony! Dostępne kolory z listy /kolor.");
				return 1;
   			SetGangColor(Player[playerid][InGang],Player[playerid][ChatColor]);
			SCM(playerid,C_WHITE,""I" "W"Kolor gangu zmieniony pomyślnie!");
		else
			cmd_gang(playerid);
	if(dialogid == D_GANG_SET_TAG)
		if(response)
            if(strfind(inputtext,"[",true) != -1 || strfind(inputtext,"]",true) != -1 || strfind(inputtext,"(",true) != -1 || strfind(inputtext,")",true) != -1)
                SPD(playerid,D_GANG_SET_TAG,DIALOG_STYLE_INPUT,"{00BFFF}Zmiana tagu gangu","Wpisz tag gangu bez nawiasów. Serwer automatycznie je doda.\n\nPrzykład: VLA","Zmień","Cofnij");
				SCM(playerid,C_RED,""WE" "R"Musisz wpisać tag gangu bez użycia nawiasów.");
				return 1;
			if(strlen(inputtext) < 2 || strlen(inputtext) > 4)
                SPD(playerid,D_GANG_SET_TAG,DIALOG_STYLE_INPUT,"{00BFFF}Zmiana tagu gangu","Wpisz tag gangu bez nawiasów. Serwer automatycznie je doda.\n\nPrzykład: VLA","Zmień","Cofnij");
				SCM(playerid,C_RED,""WE" "R"Tag gangu musi mieć od 2 do 4 znaków.");
				return 1;
			new String[128];
			format(String,sizeof(String),""I" "W"Tag gangu został zmieniony na: [%s]",inputtext);
			SCM(playerid,C_WHITE,String);
			SetGangTag(Player[playerid][InGang],inputtext);
		else
			cmd_gang(playerid);
	if(dialogid == D_GANG_SET_VICE)
		if(response)
			new NewVice = strval(inputtext);
			if(!IsPlayerConnected(NewVice))
				SCM(playerid,C_RED,""WE" "R"Ten gracz nie jest podłączony!");
				return 1;
            if(NewVice == playerid)
				SCM(playerid,C_RED,""WE" "R"Nie możesz podawać swojego id.");
				return 1;
            if(Player[NewVice][InGang] != Player[playerid][InGang])
				SCM(playerid,C_RED,""WE" "R"Ten gracz nie jest w twoim gangu!");
				return 1;
			new String[155];
			format(String,sizeof(String),"Czy chcesz aby gracz %s (%d) został Vice-Szefem gangu?",Player[NewVice][Name],NewVice);
			SPD(playerid,D_GANG_SET_VICE2,DIALOG_STYLE_MSGBOX,"{00BFFF}Potwierdzenie",String,"Tak","Nie");
            format(GlobalGangBuffer[playerid][0],MAX_PLAYER_NAME,Player[NewVice][Name]);
		else
			cmd_gang(playerid);
	if(dialogid == D_GANG_SET_VICE2)
		if(response)
			SetGangVice(Player[playerid][InGang],GlobalGangBuffer[playerid][0]);
			new String[155];
			format(String,sizeof(String),""I" "W"Nowym Vice-Szefem twojego gangu został gracz %s.",GlobalGangBuffer[playerid][0]);
			SCM(playerid,C_WHITE,String);
		else
			cmd_gang(playerid);
	if(dialogid == D_GANG_DEGRADE)
		if(response)
            if(strcmp(GlobalGangBuffer[playerid][listitem],Player[playerid][Name])==0)
				SCM(playerid,C_WHITE,""E" "W"Nie możesz wyrzucić siebie!");
				cmd_gang(playerid);
				return 1;
			new String[155];
			format(String,sizeof(String),"Czy chcesz wyrzucić z gangu gracza %s?",GlobalGangBuffer[playerid][listitem]);
			SPD(playerid,D_DEFINITE_D_G_MEMBER,DIALOG_STYLE_MSGBOX,"{00BFFF}Decyzja o wydaleniu",String,"Wyrzuć","Zostaw");
			format(GlobalGangBuffer[playerid][0],MAX_PLAYER_NAME,GlobalGangBuffer[playerid][listitem]);
		else
			cmd_gang(playerid);
	if(dialogid == D_DEFINITE_D_G_MEMBER)
		if(response)
            new String[128];
			format(String,sizeof(String),""I" "W"Wyrzucono z gangu gracza %s.",GlobalGangBuffer[playerid][0]);
            SCM(playerid,C_WHITE,String);
			RemovePlayerFromGang(Player[playerid][InGang],GlobalGangBuffer[playerid][0]);
		else
			cmd_gang(playerid);
	if(dialogid == D_VIEV_GANG_MEMBERS && !response)
		cmd_gang(playerid);
	if(dialogid == D_ZAPRO_DO_GANGU)
		if(response)
			new String[155];
			format(String,sizeof(String),"Czy chcesz przyjąć gracza %s do gangu?",GlobalGangBuffer[playerid][listitem]);
			SPD(playerid,D_INVITE_GANG,DIALOG_STYLE_MSGBOX,"{00BFFF}Decyzja o przyjęciu",String,"Przyjmij","Odrzuć");
			format(GlobalGangBuffer[playerid][0],MAX_PLAYER_NAME,GlobalGangBuffer[playerid][listitem]);
		else
			cmd_gang(playerid);
	if(dialogid == D_INVITE_GANG)
		if(response)
			cmd_gang(playerid);
			new String[128];
			format(String,sizeof(String),""I" "W"Przyjęto gracza %s do gangu.",GlobalGangBuffer[playerid][0]);
			SCM(playerid,C_WHITE,String);
			AddPlayerToGang(Player[playerid][InGang],GlobalGangBuffer[playerid][0]);
		else
			new String[155];
			format(String,sizeof(String),"UPDATE "PREFIX"Gangi_Users SET gZapro='-1' WHERE gMember='%s'",GlobalGangBuffer[playerid][0]);
			mysql_query(String);
			format(String,sizeof(String),""I" "W"Odrzucono prośbę o członkostwo gracza %s.",GlobalGangBuffer[playerid][0]);
			SCM(playerid,C_WHITE,String);
	if(dialogid == D_ENTER_SIEDZIBA)
        Player[playerid][SiedzibaAction] = 7;
        
        if(response)
			new GangId = Player[playerid][InGang];
			if(gInfo[GangId][gInX] == 0.0)
				return SCM(playerid,C_RED,""WE" "R"Twój gang nie posiada wnętrza siedziby.");
            GameTextForPlayer(playerid, "~w~Wpisz /exit~n~by opuscic siedzibe.", 2499, 3);
			SetPlayerPos(playerid,gInfo[GangId][gInX],gInfo[GangId][gInY],gInfo[GangId][gInZ]);
			SetPlayerInterior(playerid,gInfo[GangId][gInterior]);
			SetPlayerVirtualWorld(playerid,GangId+MAX_HOUSES);
	if(dialogid == D_SKLEP && response)
		switch(listitem)
			case 0: cmd_portfel(playerid);
			case 1: cmd_vip(playerid);
			case 2: SPD(playerid,D_NONE,DIALOG_STYLE_MSGBOX,"{00BFFF}Kupno moderatora","Aby zakupić konto premium (Moderator) na 1 miesiąc:\n\nWyślij SMS o treści SH19.5800 pod numer 91909\n\nCena: 23,37zł z VAT.\n\n{FF0000}Pamiętaj! Aby zakupić moderatora musisz mieć pozwolenie od właściciela serwera!","Zamknij","");
	return 1;
ShowCzynszDoZaplaty(userid,HouseId)
	new String[128];
 	format(String,sizeof(String),"Czy napewno chcesz opłacić dom?\nKwota opłaty: %d exp\nPrzedłużenie: 1 tydzień (7 dni)",hInfo[HouseId][hCzynsz]);
	SPD(userid, D_CONFIRM_CZYNSZ_HOUSE,DIALOG_STYLE_MSGBOX, "{00BFFF}Opłata czynszu", String, "Opłać","Cofnij");
PlayerEnterHouse(userid, HouseId)
	SetPlayerPos(userid, hInfo[HouseId][hInX],hInfo[HouseId][hInY],hInfo[HouseId][hInZ]);
	SetPlayerInterior(userid, hInfo[HouseId][hInterior]);
	SetPlayerVirtualWorld(userid, HouseId);
    SetPlayerFacingAngle(userid, hInfo[HouseId][hAngle]);
	if(HouseId == Player[userid][HouseOwn])
		RegeneratePlayer(userid);
	SCM(userid, C_GREEN, ""WI" "G"Jesteś w domu. :)");
	SCM(userid, C_GREEN, ""WI" "G"Aby opuścić dom wpisz /wyjdz");
	GameTextForPlayer(userid, "~w~Wpisz /wyjdz~n~by opuscic dom.", 2499, 3);
    Player[userid][InHouse] = true;
    Player[userid][House] = HouseId;
	Player[userid][ObokHouse] = false;
    Player[userid][NearHouse] = false;
forward PlayerLeaveHouse(userid,HouseId);
public PlayerLeaveHouse(userid,HouseId)
    if(Player[userid][InHouse])
        PlayerLegalTeleport(userid,0,hInfo[HouseId][hOutX],hInfo[HouseId][hOutY],hInfo[HouseId][hOutZ]);
		SetPlayerVirtualWorld(userid, 0);
        Player[userid][InHouse] = false;
        Player[userid][ObokHouse] = false;
        Player[userid][NearHouse] = false;
PlayerBuyHouse(userid, HouseId, HousePrice)
	if(!Player[userid][Logged]) return 1;
	if(Player[userid][HouseOwn] != -1)
        SCM(userid, C_RED, ""WI" "R"Możesz mieć tylko jeden dom.");
        Player[userid][ObokHouse] = false;
		Player[userid][NearHouse] = false;
		return 1;
	if(Player[userid][Exp] < HousePrice)
 		SCM(userid, C_RED, ""WI" "R"Nie posiadasz exp na kupno tego domku!");
		Player[userid][ObokHouse] = false;
		Player[userid][NearHouse] = false;
	else
		Player[userid][Exp] -= HousePrice;
		format(hInfo[HouseId][hOwner], MAX_PLAYER_NAME, Player[userid][Name]);
		hInfo[HouseId][hWaznosc] = 7;
        Player[userid][ObokHouse] = false;
        Player[userid][NearHouse] = false;
		Achievement(userid, "aDomownik");
		DestroyDynamicPickup(hInfo[HouseId][hPickup]);
	    DestroyDynamicMapIcon(hInfo[HouseId][hIcon]);
		new String[255];
		format(String,sizeof(String),""WI" "G"Zakupiłeś %s! Czynsz: %d exp co tydzień.",hInfo[HouseId][hName],hInfo[HouseId][hCzynsz]);
		SCM(userid, C_GREEN, String);
	 	SCM(userid, C_GREEN, ""WI" "G"Aby zarządzać domkiem wystarczy że tylko wciśniesz sprint przy domku.");
	 	SCM(userid, C_GREEN, ""WI" "G"Pamiętaj! Jeżeli nie będziesz regularnie opłacać czynszu to stracisz domek!");
	    format(String,sizeof(String),"~w~Exp - ~b~~h~%d",HousePrice);
		GameTextForPlayer(userid,String, 1000, 1);
		Player[userid][HouseOwn] = HouseId;
		Player[userid][CheckHouseSpawn] = 0;
        if(mysql_ping() == -1)
			mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
		format(String,sizeof(String),"UPDATE "PREFIX"Houses SET hOwner='%s',hWaznosc='7' WHERE hID='%d'",Player[userid][Name],HouseId);
		mysql_query(String);
        format(String,sizeof(String),"UPDATE "PREFIX"Users SET House='%d' WHERE Name='%s'",HouseId,Player[userid][Name]);
		mysql_query(String);
	    hInfo[HouseId][hPickup] = CreateDynamicPickup(1272, 1, hInfo[HouseId][hOutX], hInfo[HouseId][hOutY], hInfo[HouseId][hOutZ], 0, 0, -1, 40.0);
		hInfo[HouseId][hIcon] = CreateDynamicMapIcon(hInfo[HouseId][hOutX], hInfo[HouseId][hOutY], hInfo[HouseId][hOutZ], 32, -1, 0, 0, -1, 1000000.0);
		format(String,sizeof(String),"%s\nWłaściciel: %s",hInfo[HouseId][hName],Player[userid][Name]);
		UpdateDynamic3DTextLabelText(hInfo[HouseId][hLabel], 0xFFB400FF, String);
		SavePlayer(userid);
	return 1;
PlayerBuyBiznes(userid, BizId, BizPrice)
	if(Player[userid][Money] < BizPrice)
 		SCM(userid, C_RED, ""WI" "R"Nie posiadasz pieniędzy na kupno tego biznesu!");
	else
		if(!Player[userid][Registered])
            SCM(userid, C_RED, ""WE" "R"Musisz się zarejestrować!");
			return 1;
		if(Player[userid][BiznesTime] > 0)
			SCM(userid, C_RED, ""WE" "R"Musisz odczekać 5 minut zanim kupisz następny biznes!");
			return 1;
		GivePlayerMoney(userid, -BizPrice);
		format(bInfo[BizId][bOwner], MAX_PLAYER_NAME, Player[userid][Name]);
		Player[userid][Money] -= BizPrice;
		Player[userid][BiznesTime] = 5;
		new String[255];
		format(String,sizeof(String),""WI" Zakupiłeś %s! Od teraz regularnie będziesz dostawać do banku %d$.",bInfo[BizId][bName],bInfo[BizId][bCash]);
		SCM(userid, C_GREEN, String);
	 
        if(mysql_ping() == -1)
			mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
		format(String,sizeof(String),"UPDATE "PREFIX"Biznesy SET bOwner='%s' WHERE bID='%d'",Player[userid][Name],BizId);
		mysql_query(String);
		format(String,sizeof(String),"[BIZNES]\n{61C900}%s - %d$\nWłaściciel: %s",bInfo[BizId][bName],bInfo[BizId][bCash],Player[userid][Name]);
		UpdateDynamic3DTextLabelText(bInfo[BizId][bLabel], 0xFFFFFFFF, String);
	return 1;
PlayerSellBiznes(userid, BizId)
	GivePlayerMoney(userid, bInfo[BizId][bCash]/2);
    Player[userid][Money] += bInfo[BizId][bCash]/2;
	SCM(userid, C_GREEN, ""WI" "G"Sprzedałeś(aś) swój biznes!");
    if(mysql_ping() == -1)
		mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DBNM);
	bInfo[BizId][bOwner] = '0';
	new String[255];
	format(String,sizeof(String),"UPDATE "PREFIX"Biznesy SET bOwner='0' WHERE bID='%d'",BizId);
	mysql_query(String);
    format(String,sizeof(String),"[BIZNES]\n{61C900}%s - %d$\nNa sprzedaż",bInfo[BizId][bName],bInfo[BizId][bCash]);
	UpdateDynamic3DTextLabelText(bInfo[BizId][bLabel], 0xFFFFFFFF, String);
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
	if(Wiezien[playerid])
		SCM(playerid, C_WHITE, ""E" "W"W więzieniu nie możesz tego użyć!");
		return 1;
    if(IsPlayerOnEvent(playerid))
		SCM(playerid, C_ERROR, ""WE" "R"Niemożesz tego użyć na evencie!");
		return 1;
    if(playerid == RywalSolo[0] || playerid == RywalSolo[1])
		SCM(playerid, C_ERROR, ""WE" "R"Niemożesz tego użyć na solówce!");
		return 1;
    if(Player[playerid][OnOnede] || Player[playerid][OnMinigun] || Player[playerid][OnRPG] || Player[playerid][OnCombat] && GetPlayerVirtualWorld(playerid) == 10)
 		GameTextForPlayer(playerid,"~n~~n~~n~~n~~n~~n~~n~~w~/ARENAEXIT", 3000, 3);
 		PlaySoundForPlayer(playerid,1085);
		return 0;
    if(playerid != clickedplayerid)
		Player[playerid][ClickedPlayer] = clickedplayerid;
		SPD(playerid, D_PLAYER, DIALOG_STYLE_LIST, Player[clickedplayerid][Name], "› Idź do gracza\n"GUI2"› Statystyki\n"W"› Wyślij kasę\n"GUI2"› Raportuj łamanie regulaminu\n"W"› Wystaw nagrodę za głowę", "Wybierz", "Anuluj");
	return 1;
/*
    ##########  ##########  ###         ########
     ##########  ##########  ###         #########
      ###         ###    ###  ###         ###    ###
       ###         ###    ###  ###         ###    ###
        ###  #####  ###    ###  ###         ###    ###
         ###  #####  ###    ###  ###         ###    ###
          ###    ###  ###    ###  ###         ###    ###
           ###    ###  ###    ###  ###         ###    ###
            ##########  ##########  ##########  ##########
             ##########  ##########  ##########  #########
               ##########  ##########  ##########  ###                ###  ##########  ##########
                ##########  ##########  ##########   ###              ###   ##########  ##########
			     ###         ###         ###    ###    ###            ###    ###         ###    ###
	              ###         ###         ###    ###     ###          ###     ###         ###    ###
                   ##########  ##########  ##########      ###        ###      ##########  ##########
                    ##########  ##########  ##########       ###      ###       ##########  ##########
					        ###  ###         ### ###           ###    ###        ###         ### ###
					         ###  ###         ###  ###           ###  ###         ###         ###  ###
                       ##########  ##########  ###   ###           ######          ##########  ###   ###
                        ##########  ##########  ###    ###           ####           ##########  ###    ###
	THE END
*/
