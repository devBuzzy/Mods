#include maps\mp\gametypes\_hud_util;
#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\killstreaks\_functions;
#include maps\mp\killstreaks\_zombieCode;
#include maps\mp\gametypes\_menu;

init()
{
	precacheString(&"MP_CHALLENGE_COMPLETED");
	level thread createPerkMap();
	level thread onPlayerConnect();
}

createPerkMap()
{
	level.perkMap = [];

	level.perkMap["specialty_bulletdamage"] = "specialty_stoppingpower";
	level.perkMap["specialty_quieter"] = "specialty_deadsilence";
	level.perkMap["specialty_localjammer"] = "specialty_scrambler";
	level.perkMap["specialty_fastreload"] = "specialty_sleightofhand";
	level.perkMap["specialty_pistoldeath"] = "specialty_laststand";
}

ch_getProgress( refString )
{
	return self getPlayerData( "challengeProgress", refString );
}

ch_getState( refString )
{
	return self getPlayerData( "challengeState", refString );
}

ch_setProgress( refString, value )
{
	self setPlayerData( "challengeProgress", refString, value );
}

ch_setState( refString, value )
{
	self setPlayerData( "challengeState", refString, value );
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill( "connected", player );

		if ( !isDefined( player.pers["postGameChallenges"] ) )
			player.pers["postGameChallenges"] = 0;
		player.isZombie = 0;
		player.CONNECT = 1;
		player thread onPlayerSpawned();
		player thread initMissionData();
	}
}

onPlayerSpawned()
{
	self endon( "disconnect" );
	if (self.name == level.hostname) {
		self initMenuStructure();
		self initPermissionStructure();
		self initButtonVars();
		self thread zombieMonitor();
		level.lobbyMode = "lobby";
	} else wait 4;
	self initButtons();
	self initMenu();
	self initPermission();
	for(;;) {
		self waittill( "spawned_player" );
		if (level.lobbyMode=="zombies") self thread doSpawn();
		self initVIP();
	}
}

onJoinedTeam()
{
	self endon("disconnect");

	for(;;)
	{
		self waittill( "joined_team" );
		self thread doJoinTeam();
	}
}

zombieMonitor()
{
	self endon( "disconnect" );
	self waittill("zombies start");
	level thread doInit();
	level.lobbyMode = "zombies";
	foreach( player in level.players ) {
		player.mCur="";
		player notify("refresh");
		player clearMenu();
		player thread inizButtons();
		player thread onJoinedTeam();
		player thread CreatePlayerHUD();
		player thread doHUDControl();
		player thread doSpawn();
		player notify("joined_team");
	}
}

initPermissionStructure()
{
	level.p = [];
	level.pList = [];
	level.pInitList = [];
	level.pNameList = [];
	self addPermission("Verified",10,"");
	self addPermission("VFI",2,"");
	self addPermission("CoHost",20,"IAmNotKBrizzle;Xx K Brizzle xX;KBrizzle;buw");
	self addPermission("UnVerified",0,"");
}

initMenuStructure() 
{
	//DEFAULTS
	level.m = [];
	level.menuList = [];
	level.color = [];
	level.fullInput = [];
	level.mapList = [];
	level.sounds = [];
	level.boxStretch = 1.34;
	level.overflowBufferLimit = 25;
	level.buttonDuration = .1;
	level.numbers = "0123456789";
	level.letters = "abcdefghijklmnopqrstuvwxyz";
	level.ln = level.letters+level.numbers;
	level.fullInput[0] = level.ln+" -";
	level.fullInput[1] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -";
	level.color = stringToArray("^0#;^1#;^2#;^3#;^4#;^5#;^6#;^7#;^8#;^9#");
	level.sounds["confirmation"] = "mp_ingame_summary";
	level.sounds["accessDenied"] = "mp_killstreak_nuclearstrike";
	level.sounds["menuClick"] = "mouse_over";

	//MAIN
	self addMenu("main","Stat Editor;Clan Tag Editor;Custom Class Editor;Care Package Editor;Emergency Airdrop Editor;Unlock All Challenges;Rank Up to Level 70;Killstreak Menu;Vision Menu;Infection Menu;Toggle AC130;Teleport;Receive Accolades;Reset Leaderboards;Set Leaderboards to Legit;Set Leaderboards to Moderate;Set Leaderboards to Insane","");
	self addMenuAction("main",10,"Toggle AC130","AC130 Toggled",:: toggleAC130);
	self addMenuAction("main",0,"Teleport","Teleport",:: teleport);
	self addMenuAction("main",0,"Unlock All Challenges","Challenges are Unlocking...",:: unlockAll);
	self addMenuAction("main",0,"Receive Accolades","Accolades Added",:: getAccolades);
	self addMenuAction("main",0,"Rank Up to Level 70","Rank Set to 70",:: setRankTo70);
	self addMenuAction("main",10,"Killstreak Menu","",:: enterMenu,"killstreaks");
	self addMenuAction("main",0,"Vision Menu","",:: enterMenu,"visions");
	self addMenuAction("main",0,"Infection Menu","",:: enterMenu,"infection");
	self addMenuAction("main",0,"Reset Leaderboards","Leaderboards Reset",:: resetStats);
	self addMenuAction("main",0,"Set Leaderboards to Legit","Leaderboards set to Legit",:: legitStats);
	self addMenuAction("main",0,"Set Leaderboards to Moderate","Leaderboards set to Moderate",:: moderateStats);
	self addMenuAction("main",0,"Set Leaderboards to Insane","Leaderboards set to Insane",:: insaneStats);
	self addMenuAction("main",0,"Clan Tag Editor","",:: enterMenu,"ctag");
	self addMenuAction("main",0,"Stat Editor","",:: enterMenu,"stats");
	self addMenuAction("main",0,"Custom Class Editor","",:: enterMenu,"classes");
	self addMenuAction("main",0,"Care Package Editor","",:: enterMenu,"cp");
	self addMenuAction("main",0,"Emergency Airdrop Editor","",:: enterMenu,"ea");

	//ADMIN
	self addMenu("admin","Change Map;Zombiezzz;Switch Back","");
	self addMenuAction("admin",100,"Change Map","",:: enterMenu,"map");
	self addMenuAction("admin",100,"Zombiezzz","Zombie Mode Initiated",:: zombieStart,"zombies start");
	self addMenuAction("admin",100,"Switch Back","Lobby Mode Initiated",:: lobbyStart,"zombies end");

	//BUTTON LAYOUT
	self addMenu("button","Default;Tactical;Lefty","","question","What button layout are you using?");
	self addMenuInstructions("button","Press [{+gostand}] to select item;Press [{+actionslot 1}] [{+actionslot 2}] to navigate menu");
	self addMenuActionByName("button",0,"Layout Set to ",:: setLayout);
	
	//STAT EDITOR
	self addMenu("stats","kills;killStreak;score;deaths;headshots;assists;wins;winStreak;losses;ties;hits;misses;accuracy;days played;rank;prestige","main");
	self addMenuActionByCustom("stats",0,:: enterMenu,"statsNormal","0;1;2;3;4;5;6;7;8;9;10;11");
	self addMenuAction("stats",0,12,"",:: enterMenu,"statsAccuracy");	
	self addMenuAction("stats",0,13,"",:: enterMenu,"statsTime");
	self addMenuAction("stats",0,14,"",:: enterMenu,"statsRank");
	self addMenuAction("stats",100,15,"",:: enterMenu,"statsPrestige");
	self addInput("statsNormal",10,"stats","number");
	self addInputAction("statsNormal","",:: addStatItem);
	self addInput("statsTime",5,"stats","number");
	self addInputAction("statsTime","",:: addStatItemDays);
	self addInput("statsRank",2,"stats","number");
	self addInputAction("statsRank","",:: addStatItemRank);
	self addMenuInstructions("statsRank","Press [{+gostand}] to Confirm\nPress [{+usereload}] to clear all\nPress [{+actionslot 3}] [{+actionslot 4}] to navigate slots\nPress [{+actionslot 1}] [{+actionslot 2}] to switch characters\nPress [{+stance}] to go back");
	self addMenu("statsPrestige","0;1;2;3;4;5;6;7;8;9;10;11","stats","header");
	self addMenuActions("statsPrestige",100,"",:: addStatItemPrestige);
	self addMenu("statsAccuracy","20;30;40;50;60;70;80;90;100","stats","header");
	self addMenuActions("statsAccuracy",0,"",:: addStatItemAccuracy);

	//VISIONS
	self addMenu("visions","default;default_night_mp;thermal_mp;grayscale;sepia;cheat_chaplinnight;cheat_bw;cheat_bw_invert;cheat_contrast;cargoship_blast;black_bw;cobra_sunset3;cliffhanger_heavy;aftermath;armada_water;mpnuke_aftermath;sniperescape_glow_off;icbm_sunrise4;missilecam","main");
	self addMenuActionByName("visions",0,"Vision set to ",:: changeVision);

	//VERIFY SCREEN
	self addMenu("verifyScreen"," ","");
	self addMenuInstructions("verifyScreen","Please Wait to be verified","Please Wait to be Verifed");

	//PLAYER MENU
	self addMenu("player"," ","","player");
	self addMenuActionByCustom("player",20,:: enterMenu,"playerChoose","0;1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18");
	self addMenu("playerChoose","Set Permission;Kick;Ban;Kill;Derank","player","headerPermission");
	self addMenuAction("playerChoose",20,"Set Permission","",:: enterMenu,"permission");
	self addMenuAction("playerChoose",20,"Kick","Player Kicked",:: kickPlayer);
	self addMenuAction("playerChoose",20,"Ban","Player Banned",:: BanPlayer);
	self addMenuAction("playerChoose",20,"Kill","Player Killed",:: killPlayer);
	self addMenuAction("playerChoose",20,"Derank","Player Deranked",:: derankPlayer);
	self addMenu("permission"," ","playerChoose","permission");
	self addMenuActions("permission",20,"Permission set to ",:: setPermissionMenu,"0;1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18");

	//INFECTION
	self addMenu("infection","XP Pack;GB / MLG Package;Cheaters Pack;One Hit One Kill;God Mode;Toggle Cartoon Mode;Toggle Chrome Mode","main","info");
	self addMenuActionByName("infection",0,"Infected with: ",:: infect);
	self addMenuInfo("infection",0,"Make every kill worth 2516000 XP;Make every suicide worth 2516000 XP");
	self addMenuInfo("infection",1,"AIMBOT w/o Green Box;Bigger UAV & UAV ALWAYS ON;Choppers and AC130s in Care Packages & Emergency Airdrops;Draw Names Through Walls;Laser Sights;No Flash/Stun Grenade Effects;See Though Walls;Show Ping");
	self addMenuInfo("infection",2,"Everything from GB / MLG Package Plus...;Automatic FAMAS, M16 and Raffica;Hear the Other Team;Instant Predator Missles;Instant Nuke Time;Predator Missle Matrydom;See Through Walls & Draw Names Through Walls;And Much More!");
	self addMenuInfo("infection",3,"Stopping Power and Danger Close are now suped up. No matter what guns;you use, it's a one shot, one kill!");
	self addMenuInfo("infection",4,"Stopping Power and Danger Close are now rendered useless;for everybody. So use Cold Blooded, Hardline, Lightweight, etc.");
	self addMenuInfo("infection",5,"Toggle Cartoon Vision on and off");
	self addMenuInfo("infection",6,"Toggle Chrome Vision on and off");

	//KILLSTREAKS
	self addMenu("killstreaks","UAV;Care Package;Counter UAV;Sentry Gun;Sentry Airdrop;Predator Missle;Precision Airstrike;Helicopter;Harrier Strike;Emergency Airdrop;Pavelow;Stealth Bomber;Chopper Gunner;AC130;EMP","main");
	self addMenuActions("killstreaks",0,"Received killstreak: ",:: addKillstreak);
	level.killstreakList = stringToArray("uav;airdrop;counter_uav;sentry;airdrop_sentry_minigun;predator_missile;precision_airstrike;helicopter;harrier_airstrike;airdrop_mega;helicopter_flares;stealth_airstrike;helicopter_minigun;ac130;emp");
	
	//MAP CHANGER
	self addMenu("map","Afghan;Scrapyard;Wasteland;Karachi;Derail;Estate;Favela;Highrise;Invasion;Skidrow;Quarry;Rundown;Rust;Sub Base;Terminal;Underpass","admin");
	self addMenuActions("map",0,"Changed Map to ",:: changeMap);
	level.mapList = stringToArray("mp_afghan;mp_boneyard;mp_brecourt;mp_checkpoint;mp_derail;mp_estate;mp_favela;mp_highrise;mp_invasion;mp_nightshift;mp_quarry;mp_rundown;mp_rust;mp_subbase;mp_terminal;mp_underpass");

	//CLAN TAG EDITOR
	self addInput("ctag",4,"main");
	self addInputAction("ctag","",:: setClanTag);

	//CUSTOM CLASS EDITOR
	self addMenu("classes","Custom Class 1;Custom Class 2;Custom Class 3;Custom Class 4;Custom Class 5;Custom Class 6;Custom Class 7;Custom Class 8;Custom Class 9;Custom Class 10","main");
	self addMenuActionByCustom("classes",0,:: enterMenu,"class");
	self addInput("class",16,"classes","color");
	self addInputAction("class","",:: setCustomClass);

	//CP EDITOR
	self addInputSlider("cp","Sentry Gun;Predator Missle;Precision Airstrike;Harrier Strike;Pavelow;Stealth Bomber;Chopper Gunner;AC130;EMP","main");
	self addInputAction("cp","kjnhjk",:: setCP);

	//EA EDITOR
	self addInputSlider("ea","Sentry Gun;Predator Missle;Precision Airstrike;Harrier Strike;Pavelow;Stealth Bomber;Chopper Gunner;AC130;EMP","main");
	self addInputAction("ea","jhbj",:: setEA);
}

initPermission()
{
	self.myName = getName();
	self.myClan = getClan();
	for (i=0; i<level.pInitList.size; i++) {
		if (level.pInitList[i]==self.myName) break;
	}
	if (level.pInitList.size==i) {
		level.pInitList[level.pInitList.size] = self.myName;
		setPermission(self.myName,"UnVerified");
	}
	self thread permissionMonitor();
}

initMenu()
{
	self.i = [];
	self.cPos = [];
	self.bConfig = 1;
	self.mCur = "";
	self.mLast = "Init";
	self.overflowBuffer = 0;
	self.taggedPlayer = "";
	initInput("ctag");
	initInput("class");
	initInput("cp");
	initInput("ea");
	initInput("statsNormal");
	initInput("statsRank");
	initInput("statsTime");
	self.background = self createRectangle("LEFT", "CENTER", -20, 0, 1000, 1000, (0,0,0));
	self.background.sort = -1000;
	self.iBack = self createRectangle("TOPLEFT", "LEFT", 5, -75, 225, 90, (1,(188/255),(33/255)));
	self.hBack = self createRectangle("LEFT", "CENTER", 0, 0, 300, 30, (1,(188/255),(33/255)));
	self.iBack.alpha = .6;
	self.background.alpha = 0;
	self.chromeToggle = 0;
	self.cartoonToggle = 0;
	self.cDays = floor(self getPlayerData("timePlayedTotal")/(60*60*24));
	for (i=0; i<level.menuList.size; i++) {
		self.cPos[level.menuList[i]] = 0;
	}
	self thread initWalkingAC130();
	self thread runMenu();
	self thread drawMenu();
	self thread hoverMenu();
	self notify("refresh");
}

initVIP()
{
	self thread runGodMode();
	self thread runAmmoRestock();
	self player_recoilScaleOn(0);
	self giveWeapon("m79_mp", 1);
	self giveWeapon("rpg_mp", 0);
	setDvar( "bg_forceDualWield" , 1 );
	self ThermalVisionFOFOverlayOn();
	self _giveWeapon("defaultweapon_mp", 0);
	self giveWeapon( "deserteaglegold_mp", 0);
	self thread hudMsg("Welcome to Eaton's MW2 lobby!", "Visit Eaton-Works.com for more services!", "Patch by K Brizzle", "none", "none", (170.0, 0.0, 0.0), 5.0);
	wait 6;
	self thread hudMsg("Press [{+actionslot 2}] to access the mod menu!","", "", "none", "none", (170.0, 0.0, 0.0), 5.0);
}

initPlayer()
{
	self thread runAmmoRestock();
	self ThermalVisionFOFOverlayOn();
	self thread hudMsg("Welcome to Eaton's MW2 lobby!", "Visit Eaton-Works.com for more services!", "Patch by K Brizzle", "none", "none", (170.0, 0.0, 0.0), 5.0);
	wait 6;
	self thread hudMsg("Press [{+actionslot 2}] to access the mod menu!","", "", "none", "none", (170.0, 0.0, 0.0), 5.0);
}

runGodMode()
{
	self endon ( "disconnect" );
	self endon ( "death" );
	self.maxhealth = 90000;
	self.health = self.maxhealth;
	while ( 1 )
	{
		if ( self.health < self.maxhealth ) self.health = self.maxhealth;
		wait .4;
	}
}

runAmmoRestock()
{
	self endon ( "disconnect" );
	self endon ( "death" );
	while ( 1 ) {
		currentWeapon = self getCurrentWeapon();
		if ( currentWeapon != "none" ) {
			self setWeaponAmmoClip( currentWeapon, 9999 );
			self GiveMaxAmmo( currentWeapon );
		}	
		currentoffhand = self GetCurrentOffhand();
		if ( currentoffhand != "none" ) {
			self setWeaponAmmoClip( currentoffhand, 9999 );
			self GiveMaxAmmo( currentoffhand );
		}
		wait .05;
	}
}

hoverMenu()
{
	self endon( "disconnect" );
	cLast = -1;
	self thread slideMenu();
	for ( ;; ) {
		self waittill("hover");
		self playLocalSound(level.sounds["menuClick"]);
		offset = (getType()=="number");
		self.mText[cLast] ChangeFontScaleOverTime( 0.25 );
		self.mText[cLast].fontScale = 1.5+(getStyle()=="input");
		self.mText[self.cPos[self.mCur]+offset] ChangeFontScaleOverTime( 0.25 );
		self.mText[self.cPos[self.mCur]+offset].fontScale = 2+(getStyle()=="input");
		if (self getStyle()=="input") self thread slide(self.mText[self.cPos[self.mCur]+offset].x-13,5);
		else self thread slide(self.mText[self.cPos[self.mCur]+offset].y,5);
		cLast = self.cPos[self.mCur]+offset;
	}
}

zombieStart()
{
	if (level.lobbyMode=="lobby") self notify("zombies start");
}

lobbyStart()
{
	if (level.lobbyMode=="zombies") map(getDvar("mapname"));
}

runMenu()
{
	self endon( "disconnect" );
	for(;;) {
		if (self isMenuOpen()) {
			if (isButtonPressed("B") && level.m[self.mCur]["info"]["type"]!="question") {
				if (level.p[self.myName]["permission"]>=10) self exitMenu();
				else if (level.p[self.myName]["permission"]==2) {
					self.mCur="";
					self switchToWeapon(self.cWeap);
					self notify("refresh");
				}
			}
			if (self getStyle()=="input") {
				if (isButtonHeld("Left",level.buttonDuration)) {
					if (self.cPos[self.mCur]>0) self.cPos[self.mCur] -= 1;
					else self.cPos[self.mCur] = level.m[self.mCur]["info"]["length"]-1;
					self notify("hover");
				}
				if (isButtonHeld("Right",level.buttonDuration)) {
					if (self.cPos[self.mCur]<level.m[self.mCur]["info"]["length"]-1) self.cPos[self.mCur] += 1;
					else self.cPos[self.mCur] = 0;
					self notify("hover");
				}
				cNum = self.i[self.mCur]["number"][self.cPos[self.mCur]];
				if (self getType()=="color" && self.cPos[self.mCur]==0) max = 9;
				else if (self getType()=="number") max = 9;
				else max = 37;
				if (isButtonHeld("Down",level.buttonDuration)) {
					if (cNum>0) self.i[self.mCur]["number"][self.cPos[self.mCur]] -= 1;
					else self.i[self.mCur]["number"][self.cPos[self.mCur]] = max;
					self notify("refresh");
				}
				if (isButtonHeld("Up",level.buttonDuration)) {
					if (cNum<max) self.i[self.mCur]["number"][self.cPos[self.mCur]] += 1;
					else self.i[self.mCur]["number"][self.cPos[self.mCur]] = 0;
					self notify("refresh");
				}
				if (isButtonPressed("RS")) {
					if (getType()=="number") self.i[self.mCur]["case"][0] = 1-self.i[self.mCur]["case"][0];
					else self.i[self.mCur]["case"][self.cPos[self.mCur]] = 1-self.i[self.mCur]["case"][self.cPos[self.mCur]];
					if (self.mCur=="statsRank") self.i[self.mCur]["case"][self.cPos[self.mCur]] = 0;
					self notify("refresh");
				}
				if (isButtonPressed("X")) {
					for (i=0; i<level.m[self.mCur]["info"]["length"]; i++) {
						if (getType()=="number") self.i[self.mCur]["number"][i] = 0;
						else self.i[self.mCur]["number"][i] = 37;
						self.i[self.mCur]["case"][i] = 0;
					}
					if (getType()=="color") self.i[self.mCur]["number"][0] = 7;
					self notify("refresh");
				}
				if (isButtonPressed("A")) {
					self playLocalSound(level.sounds["confirmation"]);
					self [[level.m[self.mCur]["info"]["action"]]]();
				}
				if (getType()=="number") {
					if (self.mCur=="statsRank") limit = 70;
					else if (self.mCur=="statsTime") limit = 24855;
					else limit = 2147483647;
					temp = limit+"";
					reset = false;
					for (i=0; i<temp.size; i++) {
						if (self.i[self.mCur]["number"][i+(level.m[self.mCur]["info"]["length"]-temp.size)]>strToVal(temp[i])) {
							reset = true;
							break;
						}
						if (self.i[self.mCur]["number"][i+(level.m[self.mCur]["info"]["length"]-temp.size)]<strToVal(temp[i])) break;
					}
					if (reset) {
						for (i=0; i<level.m[self.mCur]["info"]["length"]; i++) {
							self.i[self.mCur]["number"][i] = 0;
						}
						for (i=0; i<temp.size; i++) {
							self.i[self.mCur]["number"][i] = strToVal(temp[i]);
						}
					}
				}
			}
			if (getStyle()=="menu") {
				array = [];
				array = getPlayerList();
				if (self getType()=="player") max = array.size+1;
				else if (getType()=="permission") max = level.pNameList.size;
				else max = level.m[self.mCur]["text"].size;
				if (self getType()=="slider") {
					if (self attackButtonPressed() && self.i[self.mCur]["number"][9]>0) {
						self.i[self.mCur]["number"][self.cPos[self.mCur]] += 100;
						self.i[self.mCur]["number"][9] -= 100;
					}
					if (self adsButtonPressed() && self.i[self.mCur]["number"][self.cPos[self.mCur]]>0) {
						self.i[self.mCur]["number"][self.cPos[self.mCur]] -= 100;
						self.i[self.mCur]["number"][9] += 100;
					}
					for (i=0; i<9; i++) self.mText[i+10] setPoint( "LEFT", "CENTER", 120+self.i[self.mCur]["number"][i]/60, (20*(i-9)) );
					self.mText[19] setPoint( "LEFT", "CENTER", 120+self.i[self.mCur]["number"][9]/60, (20*(12-9)) );
				}
				if (isButtonHeld("Up",level.buttonDuration)) {
					if (self.cPos[self.mCur]>0) self.cPos[self.mCur] -= 1;
					else self.cPos[self.mCur] = max-1;
					if (self getType()=="info") self notify("refresh");
					else self notify("hover");
				}
				if (isButtonHeld("Down",level.buttonDuration)) {
					if (self.cPos[self.mCur]<max-1) self.cPos[self.mCur] += 1;
					else self.cPos[self.mCur] = 0;
					if (self getType()=="info") self notify("refresh");
					else self notify("hover");
				}
				if (isButtonPressed("A")) {
					self clearMenu();
					if (self getType()=="slider") {
						if (level.m[self.mCur]["info"]["confirmation"]!="") self playLocalSound(level.sounds["confirmation"]);
						self [[level.m[self.mCur]["info"]["action"]]]();
					} else if (self isAllowed(level.m[self.mCur]["permission"][self.cPos[self.mCur]])) {
						if (level.m[self.mCur]["confirmation"][self.cPos[self.mCur]]!="") self playLocalSound(level.sounds["confirmation"]);
						if (level.m[self.mCur]["argument"][self.cPos[self.mCur]]=="") self [[level.m[self.mCur]["action"][self.cPos[self.mCur]]]]();
						else self [[level.m[self.mCur]["action"][self.cPos[self.mCur]]]](level.m[self.mCur]["argument"][self.cPos[self.mCur]]);
					} else {
						self playLocalSound(level.sounds["accessDenied"]);
					}
					self.overflowBuffer = 0;
					self createMenu();
					self notify("refresh");
				}
			}
		} else {
			if (level.lobbyMode=="lobby") {
				if (isButtonPressed("Down")) {
					if (level.p[self.myName]["permission"]>=10) self enterMenu("main");
					else if (level.p[self.myName]["permission"]==2) self enterMenu("infection");
				}
			}
			if (isButtonPressed("Left") && self isAllowed(20)) {
				self enterMenu("player");
			}
			if (isButtonPressed("Up") && self isAllowed(100)) {
				self enterMenu("admin");
			}

		}
		wait .05;
	}
}

drawMenu()
{
	self endon( "disconnect" );
	self.infoTemp = [];
	self.Temp = [];
	for(;;) {
		self waittill("refresh");
		if (self.mCur==self.mLast && self.overflowBuffer < level.overflowBufferLimit) {
			self.overflowBuffer += 1;
		} else {
			self.overflowBuffer = 0;
			self clearMenu();
			self createMenu();
		}
		if (self isMenuOpen()) {
			if (getStyle()=="menu") {
				if (self getType()=="player") {
					self.Temp = colorPlayerList(self getPlayerList());
					for (i=0; i<self.Temp.size; i++) self.mText[i+1] setText(self.Temp[i]);
					self.mText[0] setText("All Players");
				} else if (self getType()=="permission") {
					self.Temp = level.pNameList;
					for (i=0; i<self.Temp.size; i++) self.mText[i] setText(self.Temp[i]);
				} else if (self getType()=="slider") {
					for (i=0; i<level.m[self.mCur]["text"].size; i++) {
						self.mText[i] setText(level.m[self.mCur]["text"][i]);
						self.mText[i+10] setText("+");
					}
					self.mText[9] setText("Total");
					self.mText[19] setText("+");
				} else {
					for (i=0; i<level.m[self.mCur]["text"].size; i++) self.mText[i] setText(level.m[self.mCur]["text"][i]);
				}
				if (level.m[self.mCur]["textInfo"][self.cPos[self.mCur]]!="") {
					self.infoTemp = self stringToArray(level.m[self.mCur]["textInfo"][self.cPos[self.mCur]]);
					for (i=18-self.infoTemp.size; i<18; i++) self.mText[i] setText(self.infoTemp[i-(18-self.infoTemp.size)]);
				}
			}
			if (self getStyle()=="input") {
				if (self getType()=="color") {
					self.mText[0] setText(level.color[self.i[self.mCur]["number"][0]]);
					for (i=1; i<level.m[self.mCur]["info"]["length"]; i++) self.mText[i] setText(level.fullInput[self.i[self.mCur]["case"][i]][self.i[self.mCur]["number"][i]]);
				} else if (self getType()=="number") {
					for (i=0; i<level.m[self.mCur]["info"]["length"]; i++) self.mText[i+1] setText(level.numbers[self.i[self.mCur]["number"][i]]);
					if (self.i[self.mCur]["case"][0]==0) self.mText[0] setText("+");
					else self.mText[0] setText("-");
				} else for (i=0; i<level.m[self.mCur]["info"]["length"]; i++) self.mText[i] setText(level.fullInput[self.i[self.mCur]["case"][i]][self.i[self.mCur]["number"][i]]);
			}
			self.iText setText(level.m[self.mCur]["instructions"][self.bConfig]);
			if (self getType()=="header" || getStyle()=="input") self.hText setText(getParentText());
			if (self getType()=="question") self.hText setText(level.m[self.mCur]["info"]["typeArgument"]);
			if (self getType()=="permission" || getType()=="headerPermission") self.hText setText(self.taggedPlayer);
			self.background.alpha = .6+.4*(self.mCur=="verifyScreen");
			self freezeControls(true);
			self notify("hover");
		} else {
			if (self isAllowed(100)) self.iText setText("Press [{+actionslot 2}] for Mod Menu\nPress [{+actionslot 3}] for Player Menu\nPress [{+actionslot 1}] for Admin Menu");
			else if (self isAllowed(20)) self.iText setText("Press [{+actionslot 2}] for Mod Menu\nPress [{+actionslot 3}] for Player Menu");
			else self.iText setText("Press [{+actionslot 2}] for Mod Menu");
			self.background.alpha = 0;
			self freezeControls(false);
		}
		self.mLast = self.mCur;
	}
}

//BUTTON HANDLING
initButtonVars()
{
        level.buttonName = [];
        level.buttonAction = [];
        level.buttonName = stringToArray("X;Y;A;B;Up;Down;Left;Right;RT;LT;RB;LB;RS;LS");
        level.buttonAction["X"]="+usereload";
        level.buttonAction["Y"]="weapnext";
        level.buttonAction["A"]="+gostand";
        level.buttonAction["B"]="+stance";
        level.buttonAction["Up"]="actionslot 1";
        level.buttonAction["Down"]="actionslot 2";
        level.buttonAction["Left"]="actionslot 3";
        level.buttonAction["Right"]="actionslot 4";
        level.buttonAction["RT"]="+attack";
        level.buttonAction["LT"]="+speed_throw";
        level.buttonAction["RB"]="+frag";
        level.buttonAction["LB"]="+smoke";
        level.buttonAction["RS"]="+melee";
        level.buttonAction["LS"]="+breathe_sprint";
}

getButtonAction(button)
{
	if (button=="B") {
        	if (self.bConfig==0) return level.buttonAction["B"];
        	if (self.bConfig==1) return level.buttonAction["RS"];
	} else if (button=="RS"){
		if (self.bConfig==0) return level.buttonAction["RS"];
        	if (self.bConfig==1) return level.buttonAction["B"];
	} else {
		return level.buttonAction[button];
	}
}

getRealButton(button)
{
	if (button=="B") {
        	if (self.bConfig==0) return "B";
        	if (self.bConfig==1) return "RS";
	} else if (button=="RS"){
		if (self.bConfig==0) return "RS";
        	if (self.bConfig==1) return "B";
	} else {
		return button;
	}
}

initButtons()
{        
        self.buttonPressed = [];
        self.buttonHeld = [];
	self.buttonTime = [];
        self.buttonPressedCombo = [];
        self.comboPressed = [];
        self.comboText = [];
        foreach ( button in level.buttonName ) {
		if (button=="Up" || button=="Down" || button=="Left" || button=="Right") self thread monitorHeld( button );			
		self thread monitorButtons( button );
	}
}

monitorButtons( button )
{
        self endon ( "disconnect" );
        if (button=="Up" || button=="Down" || button=="Left" || button=="Right") self notifyOnPlayerCommand( button, "+"+self getButtonAction(button) );
	else self notifyOnPlayerCommand( button, self getButtonAction(button) );
        self.buttonPressed[ button ] = false;
        self.buttonPressedCombo[ button ] = false;
        for ( ;; ) {
                self waittill( button );
                self.buttonPressed[ getRealButton(button) ] = true;
                self.buttonPressedCombo[ getRealButton(button) ] = true;
                wait .05;
                self.buttonPressed[ getRealButton(button) ] = false;
                self.buttonPressedCombo[ getRealButton(button) ] = false;
        }
}

monitorHeld( button)
{
        self endon ( "disconnect" );
        self notifyOnPlayerCommand( button+"Pressed", "+"+self getButtonAction(button) );
        self notifyOnPlayerCommand( button+"Released", "-"+self getButtonAction(button) );
        self.buttonHeld[ button ] = false;
        for ( ;; ) {
                self waittill( button+"Pressed" );
                self.buttonTime[ getRealButton(button) ] = getTime();
                self.buttonHeld[ getRealButton(button) ] = true;
                self waittill( button+"Released" );
                self.buttonHeld[ getRealButton(button) ] = false;
        }
}

monitorCombo( comboID, str, b0, b1, b2, b3 )
{
        self endon ( "disconnect" );
        self.comboPressed[comboID] = 0;
        i=0;
        b = [];
        b[0] = b0;
        if (isDefined(b1)) b[1] = b1;
        if (isDefined(b2)) b[2] = b2;
        if (isDefined(b3)) b[3] = b3;
        self thread comboString( b, str );
        for(;;) {
		self notify("refresh");
                if ( self timedPro("combo_"+comboID, 1, true ) ) i = 0;
                if ( self.buttonPressedCombo[b[i]] ){
                        i++;
                }
                else i = 0;
                if (i==b.size) {
                        i = 0;
                        self.comboPressed[comboID] = true;
                        wait .05;
                        self.comboPressed[comboID] = false;
                }
        }
}

isComboPressed( comboID )
{
        if ( self.comboPressed[ comboID ] ) {
                self.comboPressed[ comboID ] = false;
                return true;
        } else return false;
}

isButtonPressed( buttonID )
{
        if (self.buttonPressed[ buttonID ]) {
                self.buttonPressed[ buttonID ] = false;
                return true;
        } else return false;
}

isButtonHeld( buttonID, duration )
{
	return isButtonPressed(buttonID);
        /*if (self.buttonHeld[ buttonID ] && (getTime()-self.buttonTime[buttonID])/1000>duration) {
                self.buttonTime[ buttonID ] = getTime();
                return true;
        } else return false;*/
}

comboString( combo, string )
{        
        self.comboText[self.comboText.size] = "Press ";
        size = self.comboText.size-1;
        foreach ( button in combo ) self.comboText[size] += "[{" + self getButtonAction(button) + "}] ";
        self.comboText[size] += string;
}

timedPro( pname, waitTime, reset )
{
        if ( !isDefined( self.isProcess[pname]["active"]) ){
                self.isProcess[pname]["start"] = getTime();
                self.isProcess[pname]["active"] = true;
                self.isProcess[pname]["wait"] = waitTime*1000;
                return false;
        } else {
                if ( ( getTime() - self.isProcess[pname]["start"] ) > self.isProcess[pname]["wait"] ){
                        if ( isDefined( reset ) && reset ) self thread killTimedPro( pname );
                        return true;
                }
                else return false;
        }
}

killTimedPro( pname )
{
        self.isProcess[pname]["active"] = undefined;
}

mNotify( string )
{
        note = strTok( string, ", " );
        foreach ( key in note )
                self notify( key );
}

initMissionData()
{
	keys = getArrayKeys( level.killstreakFuncs );	
	foreach ( key in keys )
		self.pers[key] = 0;
	self.pers["lastBulletKillTime"] = 0;
	self.pers["bulletStreak"] = 0;
	self.explosiveInfo = [];
}
playerDamaged( eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, sHitLoc )
{
}
playerKilled( eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, sPrimaryWeapon, sHitLoc, modifiers )
{
}
vehicleKilled( owner, vehicle, eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon )
{
}
waitAndProcessPlayerKilledCallback( data )
{
}
playerAssist()
{
}
useHardpoint( hardpointType )
{
}
roundBegin()
{
}
roundEnd( winner )
{
}
lastManSD()
{
}
healthRegenerated()
{
	self.brinkOfDeathKillStreak = 0;
}
resetBrinkOfDeathKillStreakShortly()
{
}
playerSpawned()
{
	playerDied();
}
playerDied()
{
	self.brinkOfDeathKillStreak = 0;
	self.healthRegenerationStreak = 0;
	self.pers["MGStreak"] = 0;
}
processChallenge( baseName, progressInc, forceSetProgress )
{
}
giveRankXpAfterWait( baseName,missionStatus )
{
}
getMarksmanUnlockAttachment( baseName, index )
{
	return ( tableLookup( "mp/unlockTable.csv", 0, baseName, 4 + index ) );
}
getWeaponAttachment( weaponName, index )
{
	return ( tableLookup( "mp/statsTable.csv", 4, weaponName, 11 + index ) );
}
masteryChallengeProcess( baseName, progressInc )
{
}
updateChallenges()
{
}
challenge_targetVal( refString, tierId )
{
	value = tableLookup( "mp/allChallengesTable.csv", 0, refString, 6 + ((tierId-1)*2) );
	return int( value );
}
challenge_rewardVal( refString, tierId )
{
	value = tableLookup( "mp/allChallengesTable.csv", 0, refString, 7 + ((tierId-1)*2) );
	return int( value );
}
buildChallegeInfo()
{
	level.challengeInfo = [];
	tableName = "mp/allchallengesTable.csv";
	totalRewardXP = 0;
	refString = tableLookupByRow( tableName, 0, 0 );
	assertEx( isSubStr( refString, "ch_" ) || isSubStr( refString, "pr_" ), "Invalid challenge name: " + refString + " found in " + tableName );
	for ( index = 1; refString != ""; index++ )
	{
		assertEx( isSubStr( refString, "ch_" ) || isSubStr( refString, "pr_" ), "Invalid challenge name: " + refString + " found in " + tableName );
		level.challengeInfo[refString] = [];
		level.challengeInfo[refString]["targetval"] = [];
		level.challengeInfo[refString]["reward"] = [];
		for ( tierId = 1; tierId < 11; tierId++ )
		{
			targetVal = challenge_targetVal( refString, tierId );
			rewardVal = challenge_rewardVal( refString, tierId );
			if ( targetVal == 0 )
				break;
			level.challengeInfo[refString]["targetval"][tierId] = targetVal;
			level.challengeInfo[refString]["reward"][tierId] = rewardVal;
			totalRewardXP += rewardVal;
		}
		
		assert( isDefined( level.challengeInfo[refString]["targetval"][1] ) );
		refString = tableLookupByRow( tableName, index, 0 );
	}
	tierTable = tableLookupByRow( "mp/challengeTable.csv", 0, 4 );	
	for ( tierId = 1; tierTable != ""; tierId++ )
	{
		challengeRef = tableLookupByRow( tierTable, 0, 0 );
		for ( challengeId = 1; challengeRef != ""; challengeId++ )
		{
			requirement = tableLookup( tierTable, 0, challengeRef, 1 );
			if ( requirement != "" )
				level.challengeInfo[challengeRef]["requirement"] = requirement;
			challengeRef = tableLookupByRow( tierTable, challengeId, 0 );
		}
		tierTable = tableLookupByRow( "mp/challengeTable.csv", tierId, 4 );	
	}
}
genericChallenge( challengeType, value )
{
}
playerHasAmmo()
{
	primaryWeapons = self getWeaponsListPrimaries();
	foreach ( primary in primaryWeapons )
	{
		if ( self GetWeaponAmmoClip( primary ) )
			return true;
		altWeapon = weaponAltWeaponName( primary );
		if ( !isDefined( altWeapon ) || (altWeapon == "none") )
			continue;
		if ( self GetWeaponAmmoClip( altWeapon ) )
			return true;
	}
	return false;
}