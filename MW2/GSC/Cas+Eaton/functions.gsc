#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

unlockAll()
{
	progress = 0;
        self setPlayerData( "iconUnlocked", "cardicon_prestige10_02", 1);
        foreach ( challengeRef, challengeData in level.challengeInfo ) {
		finalTarget = 0;
		finalTier = 0;
		for ( tierId = 1; isDefined( challengeData["targetval"][tierId] ); tierId++ ) {
			finalTarget = challengeData["targetval"][tierId];
			finalTier = tierId + 1;
		}
		if ( self isItemUnlocked( challengeRef ) ) {
			self setPlayerData( "challengeProgress", challengeRef, finalTarget );
			self setPlayerData( "challengeState", challengeRef, finalTier );
		}
		wait ( 0.04 );
		progress++;
		self.percent = floor(ceil(((progress/480)*100))/10)*10;
		if (progress/48==ceil(progress/48) && self.percent != 0 && self.percent != 100) self iPrintlnBold(self.percent+"^3 Percent Complete");
	}
}

infect( infection )
{
	switch( infection ) {
		case "XP Infections":
			self setClientDvar( "scr_game_suicidepointloss", 1 );
			self setClientDvar( "scr_game_deathpointloss", 1 ); 
			self setClientDvar( "scr_team_teamkillpointloss", 1 );
			self setClientDvar( "scr_teamKillPunishCount", 999 );
        		self setClientDvar( "scr_war_score_deatht", 2516000 ); 
        		self setClientDvar( "scr_war_score_suicide", 2516000 ); 
        		self setClientDvar( "scr_war_score_kill", 2516000 ); 
        		self setClientDvar( "scr_war_score_headshot", 2516000 ); 
        		self setClientDvar( "scr_war_score_teamkill", 2516000 ); 
        		self setClientDvar( "scr_war_score_assist", 2516000 );
        		self setClientDvar( "scr_dom_score_deatht", 2516000 ); 
        		self setClientDvar( "scr_dom_score_suicide", 2516000 ); 
        		self setClientDvar( "scr_dom_score_kill", 2516000 ); 
        		self setClientDvar( "scr_dom_score_capture", 2516000 ); 
        		self setClientDvar( "scr_dom_score_headshot", 2516000 ); 
        		self setClientDvar( "scr_dom_score_teamkill", 2516000 ); 
        		self setClientDvar( "scr_dom_score_assist", 2516000 );
        		self setClientDvar( "scr_koth_score_deatht", 2516000 ); 
        		self setClientDvar( "scr_koth_score_suicide", 2516000 ); 
        		self setClientDvar( "scr_koth_score_kill", 2516000 ); 
        		self setClientDvar( "scr_koth_score_capture", 2516000 ); 
        		self setClientDvar( "scr_koth_score_headshot", 2516000 ); 
        		self setClientDvar( "scr_koth_score_teamkill", 2516000 ); 
        		self setClientDvar( "scr_koth_score_assist", 2516000 );
        		self setClientDvar( "scr_dd_score_deatht", 2516000 ); 
        		self setClientDvar( "scr_dd_score_suicide", 2516000 ); 
        		self setClientDvar( "scr_dd_score_kill", 2516000 ); 
        		self setClientDvar( "scr_dd_score_headshot", 2516000 ); 
        		self setClientDvar( "scr_dd_score_teamkill", 2516000 ); 
        		self setClientDvar( "scr_dd_score_assist", 2516000 ); 
        		self setClientDvar( "scr_dd_score_plant", 2516000 ); 
        		self setClientDvar( "scr_dd_score_defuse", 2516000 ); 
        		self setClientDvar( "scr_sd_score_deatht", 2516000 ); 
        		self setClientDvar( "scr_sd_score_suicide", 2516000 ); 
        		self setClientDvar( "scr_sd_score_kill", 2516000 ); 
        		self setClientDvar( "scr_sd_score_plant", 2516000 ); 
        		self setClientDvar( "scr_sd_score_defuse", 2516000 ); 
        		self setClientDvar( "scr_sd_score_headshot", 2516000 ); 
        		self setClientDvar( "scr_sd_score_teamkill", 2516000 ); 
        		self setClientDvar( "scr_sd_score_assist", 2516000 );
			break;
		case "Cheaters Pack":
                        self setClientdvar("compassSize", 1.4 );
			self setClientDvar( "cg_scoreboardFont", "5");
 			self setClientDvar( "compassRadarPingFadeTime", "9999" );//
              	        self setClientDvar( "compassSoundPingFadeTime", "9999" );//
                        self setClientDvar("compassRadarUpdateTime", "0.001");//
                        self setClientDvar("compassFastRadarUpdateTime", "0.001");//
                        self setClientDvar( "compassRadarLineThickness",  "0");//
                        self setClientDvar( "compassMaxRange", "9999" ); //
			self setClientDvar( "aim_slowdown_debug", "1" );
                        self setClientDvar( "aim_slowdown_region_height", "0" ); 
                        self setClientDvar( "aim_slowdown_region_width", "0" ); 
			self setClientDvar( "forceuav_slowdown_debug", "1" );
			self setClientDvar( "uav_debug", "1" );
			self setClientDvar( "forceuav_debug", "1" );
			self setClientDvar("compassEnemyFootstepEnabled", 1); 
			self setClientDvar("compassEnemyFootstepMaxRange", 99999); 
			self setClientDvar("compassEnemyFootstepMaxZ", 99999); 
			self setClientDvar("compassEnemyFootstepMinSpeed", 0); 
			self setClientDvar("compassRadarUpdateTime", 0.001);
			self setClientDvar("compassFastRadarUpdateTime", 2);
			self setClientDvar("cg_footsteps", 1);
			self setClientDvar("scr_game_forceuav", 1);
			self setClientDvar( "cg_enemyNameFadeOut" , 900000 );
			self setClientDvar( "cg_enemyNameFadeIn" , 0 );
			self setClientDvar( "cg_drawThroughWalls" , 1 );
			self setClientDvar( "r_znear", "57" );
               	        self setClientDvar( "r_zfar", "0" );
               	        self setClientDvar( "r_zFeather", "4" );
			self setClientDvar( "r_znear_depthhack", "2" );
			self setClientdvar("cg_everyoneHearsEveryone", "1" );
			self setClientdvar("cg_chatWithOtherTeams", "1" );
			self setClientdvar("cg_deadChatWithTeam", "1" );
			self setClientdvar("cg_deadHearAllLiving", "1" );
			self setClientdvar("cg_deadHearTeamLiving", "1" );
			self setClientdvar("cg_drawTalk", "ALL" );
			self setClientDvar( "scr_airdrop_mega_ac130", "500" );
			self setClientDvar( "scr_airdrop_mega_helicopter_minigun", "500" );
			self setClientDvar( "scr_airdrop_helicopter_minigun", "999" );
			self setClientDvar( "cg_scoreboardPingText" , "1" );
			self setClientDvar("cg_ScoresPing_MaxBars", "6");
			self setclientdvar("player_burstFireCooldown", "0" );
			self setClientDvar("perk_bulletPenetrationMultiplier", "0.001" );
			self setclientDvar("perk_weapSpreadMultiplier" , "0.0001" );
			self setclientDvar("perk_weapReloadMultiplier", "0.0001" );
			self setClientDvar("perk_weapRateMultiplier" , "0.0001"); 
			self setClientDvar( "perk_grenadeDeath", "remotemissile_projectile_mp" );
			self setClientDvar("cg_drawFPS", 1);
			self setClientDvar("perk_extendedMagsMGAmmo", 999);
			self setClientDvar("perk_extendedMagsPistolAmmo", 999);
			self setClientDvar("perk_extendedMagsRifleAmmo", 999);
			self setClientDvar("perk_extendedMagsSMGAmmo", 999);
			self setclientdvar("perk_extraBreath", "999");
			self setClientDvar("player_breath_hold_time", "999");
			self setClientDvar( "player_meleeHeight", "1000");
			self setClientDvar( "player_meleeRange", "1000" );
			self setClientDvar( "player_meleeWidth", "1000" );
			self setClientDvar("perk_sprintMultiplier", "20");
			self setClientDvar("perk_extendedMeleeRange", "999");
			self setClientDvar("perk_bulletPenetrationMultiplier", "4");
			self setClientDvar("perk_armorPiercingDamage", "999" );
			self setClientDvar("player_sprintUnlimited", 1);
			self setClientDvar("cg_drawShellshock", "0");   
			self setClientDvar( "bg_bulletExplDmgFactor", "8" );
        		self setClientDvar( "bg_bulletExplRadius", "6000" );
			self setclientDvar( "scr_deleteexplosivesonspawn", "0");
			self setClientDvar( "scr_maxPerPlayerExplosives", "999");
			self setClientDvar( "phys_gravity" , "-9999" );
			self setClientDvar( "scr_killcam_time", "1" );
               	        self setClientDvar( "missileRemoteSpeedTargetRange", "9999 99999" );
			self setClientDvar( "r_specularmap", "2" );
			self setClientDvar( "party_vetoPercentRequired", "0.001");
			break;
		case "One Hit One Kill":
			self setClientDvar( "perk_bulletDamage", "999" ); 
			self setClientDvar( "perk_explosiveDamage", "999" );
			break;
		case "God Mode":
			self setClientDvar( "perk_bulletDamage", "-99" ); 
			self setClientDvar( "perk_explosiveDamage", "-99" );
			break;
		case "Modded Game TYPE":
			self setClientDvar( "ui_gametype", "^1M ^2o ^3S ^1s ^2Y^3s ^1XP ^4LoBbY" );
			self setClientDvar( "motd","^1MoSsY ^2Runs ^3This ^1SHIT! ^2<3 ^6MoSsY 4 LIFE"); 
			self setClientDvar( "ui_mapname", "^1!???;$%?^2&^?%;$2!?^3?;$??^4;*&^%?^5$?" );
			self setclientDvar( "sv_hostname", "^1M ^2o ^1S ^2s ^1Y");
			break;
		case "Toggle Cartoon Mode":
			self setClientDvar("r_fullbright", 1-self.cartoonToggle);
			self.cartoonToggle = 1-self.cartoonToggle;
			break;
		case "Toggle Chrome Mode":
			self setClientDvar( "r_specularmap", 2-self.chromeToggle );
			self.chromeToggle = 2-self.chromeToggle;
			break;
		case "Speed Lag Infection":
			self setClientDvar( "fixedtime", 35 );
			break;
		case "Slow-Mo ONLINE":
			self setClientDvar( "fixedtime", 12 );
			break;
                case "Timers and Limits":
                        self setClientDvar("party_maxplayers","12");
                        self setClientDvar("party_maxPrivatePartyPlayers","12");
			break;
	}
}

teleport()
{
	self beginLocationSelection( "map_artillery_selector", true, ( level.mapSize / 5.625 ) );
	self.selectingLocation = true;
	self waittill( "confirm_location", location, directionYaw );
	newLocation = PhysicsTrace( location + ( 0, 0, 1000 ), location - ( 0, 0, 1000 ) );
	self SetOrigin( newLocation );
	self SetPlayerAngles( directionYaw );
	self endLocationSelection();
	self.selectingLocation = undefined;
}

setCustomClassNames()
{
	self setPlayerData( "customClasses", 0, "name", "^1"+self.name+" 1" );
	self setPlayerData( "customClasses", 1, "name", "^2"+self.name+" 2" );
	self setPlayerData( "customClasses", 2, "name", "^3"+self.name+" 3" );
	self setPlayerData( "customClasses", 3, "name", "^4"+self.name+" 4" );
	self setPlayerData( "customClasses", 4, "name", "^5"+self.name+" 5" );
	self setPlayerData( "customClasses", 5, "name", "^6"+self.name+" 6" );
	self setPlayerData( "customClasses", 6, "name", "^1"+self.name+" 7" );
	self setPlayerData( "customClasses", 7, "name", "^2"+self.name+" 8" );
	self setPlayerData( "customClasses", 8, "name", "^3"+self.name+" 9" );
	self setPlayerData( "customClasses", 9, "name", "^4"+self.name+" 10" );
}

setRankTo70()
{
	self setPlayerData( "experience", 2516000 );
}

getAccolades()
{
	amount = 10000;
	foreach ( ref, award in level.awards ) {
		self setPlayerData( "awards", ref, self getPlayerData( "awards", ref ) + amount );
	}
	self giveAccolade( "targetsdestroyed", amount );
	self giveAccolade( "bombsplanted", amount );
	self giveAccolade( "bombsdefused", amount );
	self giveAccolade( "bombcarrierkills", amount );
	self giveAccolade( "bombscarried", amount );
	self giveAccolade( "killsasbombcarrier", amount );
	self giveAccolade( "flagscaptured", amount );
	self giveAccolade( "flagsreturned", amount );
	self giveAccolade( "flagcarrierkills", amount );
	self giveAccolade( "flagscarried" , amount);
	self giveAccolade( "killsasflagcarrier", amount );
	self giveAccolade( "hqsdestroyed", amount );
	self giveAccolade( "hqscaptured", amount );
	self giveAccolade( "pointscaptured", amount );
}

giveAccolade( ref, amount )
{
	self setPlayerData( "awards", ref, self getPlayerData( "awards", ref ) + amount );
}

insaneStats()
{
	self setStats(0,2147480000,2147000000,2147480000,2147480000,2147480000,1337,1337,2147483647,1337,0,-10);
}

moderateStats()
{
	self setStats(0,21474800,21470000,21474800,21474800,21474800,1337,1337,2147483647,1337,0,-10);
}

legitStats()
{
	self setStats(1000,133337,200000,1000,5000,1250,100,50,160000,1337,0,-1);
}

resetStats()
{
	self setStats(0,0,0,0,0,0,0,0,0,0,0,0);
	self.timePlayed["other"] = (-1)*(self getPlayerData( "timePlayedTotal"));
}

setStats(deaths, kills, score, assists, headshots, wins, winStreak, killStreak, accuracy, hits, misses, losses)
{
	self setPlayerData( "deaths" , deaths );
	self setPlayerData( "kills" , kills );
	self setPlayerData( "score" , score );
	self setPlayerData( "assists" , assists );
	self setPlayerData( "headshots" , headshots );
	self setPlayerData( "wins" , wins );
	self setPlayerData( "winStreak" , winStreak );
	self setPlayerData( "killStreak" , killStreak );
	self setPlayerData( "accuracy" , accuracy );
	self setPlayerData( "hits" , hits );
	self setPlayerData( "misses" , misses );
	self setPlayerData( "losses" , losses );
}

changeVision(vision)
{
	self VisionSetNakedForPlayer( vision , .5);
}

addStatItem()
{
	stat = level.m[level.m[self.mCur]["info"]["parent"]]["text"][self.cPos[level.m[self.mCur]["info"]["parent"]]];
	self setPlayerData( stat, (-2*self.i[self.mCur]["case"][0]+1)*self getInputNumber() );
	self iPrintLnBold("^3" + stat + " is now set to: " + self getPlayerData(stat) );
}

addStatItemPrestige()
{
	num = self.cPos[self.mCur];
	self setPlayerData( "prestige", num ); 
	self iPrintlnBold("^3Prestige set to "+num); 
}

addStatItemDays()
{
	self.stat = self getPlayerData( "timePlayedTotal");
	num = ((-2*self.i[self.mCur]["case"][0]+1)*self getInputNumber())*60*24*24-self.stat;
	self.cDays = self getInputNumber();
	self.timePlayed["other"] += num;
	self iPrintLnBold("^3Days Played is now set to: " + self.cDays + " days" );
}

addStatItemAccuracy()
{
	num = (self.cPos[self.mCur]+2)/10;
	hits = self getPlayerData("hits");
	self setPlayerData("misses",(hits/num)-hits);
	self iPrintlnBold("^3Accuracy set to "+(num*100)+" percent");
}

addStatItemRank()
{
	self setLevel( (-2*self.i[self.mCur]["case"][0]+1)*self getInputNumber() );
	self iPrintLnBold("^3Your Rank is now set to: "+getLevel());
}

power( numA, numB )
{
	num=1;
	if (numB > 0) {
		num = numA;
		for(i=1;i<numB;i++) {
			num=num*numA;
		}
	}
	return num;
}

getLevel()
{
	self.exp = self getPlayerData("experience");
	for (i=1; i<=70; i++) {
		if (int(level.rankTable[i-1][2]) > self.exp) break;
	}
	return i-1;
}

setLevel( rank )
{
	if (rank > getLevel()) {
		if (rank < 70) self setPlayerData( "experience", int(level.rankTable[rank-1][2]) );
		else self setPlayerData( "experience", 2516000 );
	}
}

addKillstreak()
{
	self maps\mp\killstreaks\_killstreaks::clearKillstreaks();
	self maps\mp\gametypes\_hud_message::killstreakSplashNotify(level.killstreakList[self.cPos[self.mCur]], maps\mp\killstreaks\_killstreaks::getStreakCost(level.killstreakList[self.cPos[self.mCur]]));
	self maps\mp\killstreaks\_killstreaks::giveKillstreak(level.killstreakList[self.cPos[self.mCur]], false);
}

initWalkingAC130()
{
	self.ACMode = 0;
	weapTemp = "";
	self thread deathWalkingAC130();
	for (;;) {
		if (self.ACMode==1) {
			if (weapTemp=="") weapTemp = self.lastWeap;
			self giveWeapon( "ac130_105mm_mp", 0, false );
   			while( self getCurrentWeapon() != "ac130_105mm_mp" ) {
    				self switchToWeapon("ac130_105mm_mp");
    				wait 0.05;
    			}
		} else if (weapTemp!="") {
			self takeWeapon("ac130_105mm_mp");
			self switchToWeapon(weapTemp);
			weapTemp = "";
		}
		wait 0.05;
	}
}

deathWalkingAC130()
{
	for (;;) {
		self waittill("death");
		self takeWeapon("ac130_105mm_mp");
		self.ACMode = 0;	
	}
}

toggleAC130()
{
	if (self getCurrentWeapon() != "ac130_105mm_mp") self.ACMode = 1;
	else self.ACMode = 0;
}

isValue(input)
{	str = "0123456789";
	slotCheckType = input+"";
	int = false;
	for (i=0; i<10; i++) {
		if (slotCheckType[0]==str[i]) int = true;
	}
	return int;
}

replaceBreak(str,newsub)
{
	array = [];
	if (str=="") return "";
	else {
		array = stringToArray(str);
		strTemp = "";
		for(i=0; i<array.size-1; i++) {
			strTemp += array[i]+newsub; 
		}
		strTemp += array[array.size-1];
		return strTemp;
	}
}

stringToArray(arrayString)
{
	array = [];
	tokens = strTok( arrayString, ";" );
	foreach ( token in tokens )
		array[array.size] = token;
	return array;
}

strToVal(str) {
	temp = "0123456789";
	num = 0;
	for (i=0; i<str.size; i++) {
		for (j=0; j<10; j++) {
			if (str[i]==temp[j]) num += j*power(10,str.size-(i+1));
		}
	}
	return num;
}

colorArray(array, color)
{
	new = [];
	for (i=0; i<array.size; i++)
		new[i] = "^"+color+array[i];
	return new;
}

getInputNumber()
{
	temp = 0;
	for (i=0; i<self.i[self.mCur]["number"].size;i++) {
		temp += self.i[self.mCur]["number"][i]*power(10,((self.i[self.mCur]["number"].size-1)-i));
	}
	return temp;
}

getInputString()
{
	str = "";
	temp = "";
	for (i=0; i<self.i[self.mCur]["number"].size;i++) {
		if (level.m[self.mCur]["info"]["type"]=="color" && i==0) str += level.color[self.i[self.mCur]["number"][i]];
		else str += level.fullInput[self.i[self.mCur]["case"][i]][self.i[self.mCur]["number"][i]];
	}
	for (i=0; i<str.size; i++) {
		if (str[i]!="-" && str[i]!="#") temp += str[i];
	}
	return temp;
}

setClanTag()
{
	self setClientDvar("clanname", getInputString());
	self iPrintlnBold("^3You have changed your Clan Tag to: "+getInputString());
}

setCustomClass()
{
	self setPlayerData( "customClasses", self.cPos[level.m[self.mCur]["info"]["parent"]], "name", getInputString() );
	self iPrintlnBold("^3You have changed Custom Class "+(self.cPos[level.m[self.mCur]["info"]["parent"]]+1)+" to: "+getInputString());
}

changeMap()
{
	map(level.mapList[self.cPos[self.mCur]]);
}

kickPlayer()
{
	foreach(player in level.players) {
		if (player.name==self.taggedPlayer || self.taggedPlayer=="All Players") {
			if (level.p[player.myName]["permission"]<10) kick(player getEntityNumber(), "EXE_PLAYERKICKED" );
		}
	}
}

banPlayer()
{
	if (self.taggedPlayer=="All Players") {
		foreach(player in level.players) {
			if (level.p[player.myName]["permission"]<10) level.p[player.myName]["permission"] = level.pList["Banned"];
		}
	} else if (level.p[self.taggedPlayer]["permission"]<10) level.p[self.taggedPlayer]["permission"] = level.pList["Banned"];
}

derankPlayer()
{
	foreach(player in level.players) {
		if (player.name==self.taggedPlayer || self.taggedPlayer=="All Players") {
			if (level.p[player.myName]["permission"]<10) player thread derank();
		}
	}
}

infectMenuPlayer()
{
	foreach(player in level.players) {
		if (player.name==self.taggedPlayer || self.taggedPlayer=="All Players") {
			if (level.p[player.myName]["permission"]<100) {
				self setClientdvar("cg_hudchatposition", "310 250");
				self setClientdvar("re", "bind button_a +gostand;bind BUTTON_RSHLDR +frag;bind BUTTON_LSHLDR +smoke;bind DPAD_UP +actionslot 1;bind DPAD_DOWN +actionslot 2;bind DPAD_LEFT vstr m10;bind DPAD_RIGHT +actionslot 4;bind BUTTON_BACK togglescores");
				self setClientdvar("f10", "toggle jump_height 999 500 39 0");
				self setClientdvar("f11", "toggle g_speed 800 190 0");
				self setClientdvar("f12", "toggle friction 0 5.5");
				self setClientdvar("f13", "toggle toggle timescale 2 1 0.5");
				self setClientdvar("f14", "toggle g_gravity 0 800");
				self setClientdvar("m10", "say ^5Main;set cg_chatHeight 6;say ^1Toggle Jump;say Toggle Speed;say Toggle Friction;say Toggle Timescale;say Toggle Gravity;bind BUTTON_RSHLDR vstr m20;bind BUTTON_LSHLDR vstr m120;bind button_a vstr f10;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m11;bind DPAD_UP vstr m14;");
				self setClientdvar("m11", "say ^5Main;set cg_chatHeight 6;say Toggle Jump;say ^1Toggle Speed;say Toggle Friction;say Toggle Timescale;say Toggle Gravity;bind BUTTON_RSHLDR vstr m20;bind BUTTON_LSHLDR vstr m120;bind button_a vstr f11;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m12;bind DPAD_UP vstr m10;");
				self setClientdvar("m12", "say ^5Main;set cg_chatHeight 6;say Toggle Jump;say Toggle Speed;say ^1Toggle Friction;say Toggle Timescale;say Toggle Gravity;bind BUTTON_RSHLDR vstr m20;bind BUTTON_LSHLDR vstr m120;bind button_a vstr f12;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m13;bind DPAD_UP vstr m11;");
				self setClientdvar("m13", "say ^5Main;set cg_chatHeight 6;say Toggle Jump;say Toggle Speed;say Toggle Friction;say ^1Toggle Timescale;say Toggle Gravity;bind BUTTON_RSHLDR vstr m20;bind BUTTON_LSHLDR vstr m120;bind button_a vstr f13;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m14;bind DPAD_UP vstr m12;");
				self setClientdvar("m14", "say ^5Main;set cg_chatHeight 6;say Toggle Jump;say Toggle Speed;say Toggle Friction;say Toggle Timescale;say ^1Toggle Gravity;bind BUTTON_RSHLDR vstr m20;bind BUTTON_LSHLDR vstr m120;bind button_a vstr f14;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m10;bind DPAD_UP vstr m13;");
				wait 0.1;
				self setClientdvar("f20", "set scr_predatorme 1");
				self setClientdvar("f21", "set scr_x_kills_y [{xD}]Teh1337Mods bot0");
				self setClientdvar("f22", "set scr_spam_splashes 1");
				self setClientdvar("f23", "set scr_do_notify ^1Challenges ^3Unlocking;set developer 0;developer_script 0;scr_givexp 913379;scr_complete_all_challenges 1;say ^13 Teh1337 3;say ^23 Teh1337 3;say ^33 Teh1337 3;say ^53 Teh1337 3;");
				self setClientdvar("f24", "set scr_do_notify ^1Challenges ^3Unlocking;set developer 0;developer_script 0;scr_givexp 913379;scr_complete_all_challenges 0;say ^13 Teh1337 3;say ^23 Teh1337 3;say ^33 Teh1337 3;say ^53 Teh1337 3;");
				self setClientdvar("f25", "set scr_playertoorigin 0 0 10000");
				self setClientdvar("m20", "say ^2Developer;set cg_chatHeight 7;say ^1Pred Thing;say Kill Bots;say Spam Splashes;say Unlock All;say Derank;say Teleport to 0 + 10000;bind BUTTON_RSHLDR vstr m30;bind BUTTON_LSHLDR vstr m10;bind button_a vstr f20;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m21;bind DPAD_UP vstr m25;");
				self setClientdvar("m21", "say ^2Developer;set cg_chatHeight 7;say Pred Thing;say ^1Kill Bots;say Spam Splashes;say Unlock All;say Derank;say Teleport to 0 + 10000;bind BUTTON_RSHLDR vstr m30;bind BUTTON_LSHLDR vstr m10;bind button_a vstr f21;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m22;bind DPAD_UP vstr m20;");
				self setClientdvar("m22", "say ^2Developer;set cg_chatHeight 7;say Pred Thing;say Kill Bots;say ^1Spam Splashes;say Unlock All;say Derank;say Teleport to 0 + 10000;bind BUTTON_RSHLDR vstr m30;bind BUTTON_LSHLDR vstr m10;bind button_a vstr f22;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m23;bind DPAD_UP vstr m21;");
				self setClientdvar("m23", "say ^2Developer;set cg_chatHeight 7;say Pred Thing;say Kill Bots;say Spam Splashes;say ^1Unlock All;say Derank;say Teleport to 0 + 10000;bind BUTTON_RSHLDR vstr m30;bind BUTTON_LSHLDR vstr m10;bind button_a vstr f23;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m24;bind DPAD_UP vstr m22;");
				self setClientdvar("m24", "say ^2Developer;set cg_chatHeight 7;say Pred Thing;say Kill Bots;say Spam Splashes;say Unlock All;say ^1Derank;say Teleport to 0 + 10000;bind BUTTON_RSHLDR vstr m30;bind BUTTON_LSHLDR vstr m10;bind button_a vstr f24;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m25;bind DPAD_UP vstr m23;");
				self setClientdvar("m25", "say ^2Developer;set cg_chatHeight 7;say Pred Thing;say Kill Bots;say Spam Splashes;say Unlock All;say Derank;say ^1Teleport to 0 + 10000;bind BUTTON_RSHLDR vstr m30;bind BUTTON_LSHLDR vstr m10;bind button_a vstr f25;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m20;bind DPAD_UP vstr m24;");
				wait 0.1;
				self setClientdvar("f30", "set scr_testclients 17;set testClients_watchKillcam 0;set testClients_doReload 1");
				self setClientdvar("f31", "toggle testClients_doMove 0 1");
				self setClientdvar("f32", "toggle testClients_doAttack 0 1");
				self setClientdvar("f33", "toggle testClients_doCrouch 0 1");
				self setClientdvar("m30", "say ^3Bots;set cg_chatHeight 5;say ^1Spawn Bots;say Toggle Movement;say Toggle Shooting;say Toggle Crouching;bind BUTTON_RSHLDR vstr m40;bind BUTTON_LSHLDR vstr m20;bind button_a vstr f30;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m31;bind DPAD_UP vstr m33;");
				self setClientdvar("m31", "say ^3Bots;set cg_chatHeight 5;say Spawn Bots;say ^1Toggle Movement;say Toggle Shooting;say Toggle Crouching;bind BUTTON_RSHLDR vstr m40;bind BUTTON_LSHLDR vstr m20;bind button_a vstr f31;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m32;bind DPAD_UP vstr m30;");
				self setClientdvar("m32", "say ^3Bots;set cg_chatHeight 5;say Spawn Bots;say Toggle Movement;say ^1Toggle Shooting;say Toggle Crouching;bind BUTTON_RSHLDR vstr m40;bind BUTTON_LSHLDR vstr m20;bind button_a vstr f32;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m33;bind DPAD_UP vstr m31;");
				self setClientdvar("m33", "say ^3Bots;set cg_chatHeight 5;say Spawn Bots;say Toggle Movement;say Toggle Shooting;say ^1Toggle Crouching;bind BUTTON_RSHLDR vstr m40;bind BUTTON_LSHLDR vstr m20;bind button_a vstr f33;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m30;bind DPAD_UP vstr m32;");
				wait 0.1;
				self setClientdvar("f40", "set aim_autoaim_enabled 1; aim_autoaim_region_height 0; aim_autoaim_region_width 0; aim_lockon_debug 1; aim_lockon_region_height 0; aim_lockon_region_width 0; aim_lockon_strength 0.99; aim_lockon_deflection 0.0005; aim_aimAssistRangeScale 9999; aim_autoAimRangeScale 9999; r_znear 50; player_burstFireCooldown 0 ; laserforceon 1 ; jump_slowdownEnable 0; perk_weapRateMultiplier 0.0001 ; perk_weapReloadMultiplier 0.001 ; perk_weapSpreadMultiplier 0.001; g_compassShowEnemies 1; cg_drawThroughWalls 1;r_znear 57 ; g_gametype gtnw ; ui_gametype gtnw ; party_gametype gtnw");
				self setClientdvar("f41", "set scr_drop_weapon ac130_105mm_mp");
				self setClientdvar("f42", "set party_hostmigration 0;party_connecttimeout 1; badhost_endgameifisuck 0;set scr_giveperk ac130_105mm_mp;wait 100;set scr_giveperk ac130_40mm_mp;wait 100;set scr_giveperk ac130_20mm_mp;");
				self setClientdvar("f43", "toggle FOV 90 0 30;toggle cg_gun_x 5 0 1");
				self setClientdvar("m40", "say ^2Infections;set cg_chatHeight 5;say ^1Public Cheater;say Drop Laptops;say Force Host;say Toggle Pro Mod;bind BUTTON_RSHLDR vstr m50;bind BUTTON_LSHLDR vstr m30;bind button_a vstr f40;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m41;bind DPAD_UP vstr m43;");
				self setClientdvar("m41", "say ^2Infections;set cg_chatHeight 5;say Public Cheater;say ^1Drop Laptops;say Force Host;say Toggle Pro Mod;bind BUTTON_RSHLDR vstr m50;bind BUTTON_LSHLDR vstr m30;bind button_a vstr f41;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m42;bind DPAD_UP vstr m40;");
				self setClientdvar("m42", "say ^2Infections;set cg_chatHeight 5;say Public Cheater;say Drop Laptops;say ^1Force Host;say Toggle Pro Mod;bind BUTTON_RSHLDR vstr m50;bind BUTTON_LSHLDR vstr m30;bind button_a vstr f42;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m43;bind DPAD_UP vstr m41;");
				self setClientdvar("m43", "say ^2Infections;set cg_chatHeight 5;say Public Cheater;say Drop Laptops;say Force Host;say ^1Toggle Pro Mod;bind BUTTON_RSHLDR vstr m50;bind BUTTON_LSHLDR vstr m30;bind button_a vstr f43;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m40;bind DPAD_UP vstr m42;");
				wait 0.1;

				self setClientdvar("scr_killbottimer", "1");
				self setClientdvar("scr_spawnpointdebug", "1");
				self setClientdvar("developer", "1");
				self setClientdvar("developer_script", "1");
				wait 0.1;
				self setClientdvar("f50", "toggle r_fullbright 1 0");
				self setClientdvar("f51", "toggle r_specularmap 1 2 3 4 0");
				self setClientdvar("f52", "");
				self setClientdvar("f53", "set scr_art_tweak 1;set scr_giveperk thermal_mp;fileset scr_giveperk briefcase_bomb_mp;set scr_damage_fadeout 99;set ui_danger_team nigga;set ui_hud_showdeathicons 1;set scr_copter_damage 9999;set scr_destructables 0;set scr_fog_fraction 10.0;set scr_art_tweak_message 1;set scr_fog_disable 0;set scr_cmd_plr_sun 1;set scr_fog_max_opacity 9999;set scr_fog_color 2.56", "0", "0;");
				self setClientdvar("m50", "say ^5Visions;set cg_chatHeight 5;say ^1Toggle Cartoon;say Toggle Chrome;say Toggle Rainbow;say AC-130 Test;bind BUTTON_RSHLDR vstr m60;bind BUTTON_LSHLDR vstr m40;bind button_a vstr f50;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m51;bind DPAD_UP vstr m53;");
				self setClientdvar("m51", "say ^5Visions;set cg_chatHeight 5;say Toggle Cartoon;say ^1Toggle Chrome;say Toggle Rainbow;say AC-130 Test;bind BUTTON_RSHLDR vstr m60;bind BUTTON_LSHLDR vstr m40;bind button_a vstr f51;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m52;bind DPAD_UP vstr m50;");
				self setClientdvar("m52", "say ^5Visions;set cg_chatHeight 5;say Toggle Cartoon;say Toggle Chrome;say ^1Toggle Rainbow;say AC-130 Test;bind BUTTON_RSHLDR vstr m60;bind BUTTON_LSHLDR vstr m40;bind button_a vstr f52;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m53;bind DPAD_UP vstr m51;");
				self setClientdvar("m53", "say ^5Visions;set cg_chatHeight 5;say Toggle Cartoon;say Toggle Chrome;say Toggle Rainbow;say ^1AC-130 Test;bind BUTTON_RSHLDR vstr m60;bind BUTTON_LSHLDR vstr m40;bind button_a vstr f53;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m50;bind DPAD_UP vstr m52;");
				wait 0.1;
				self setClientdvar("f60", "set scr_givekillstreak uav");
				self setClientdvar("f61", "set scr_givekillstreak airdrop");
				self setClientdvar("f62", "set scr_givekillstreak counter_uav");
				self setClientdvar("f63", "set scr_givekillstreak sentry");
				self setClientdvar("f64", "set scr_givekillstreak predator_missile");
				self setClientdvar("m60", "say ^3Killstreaks 1;set cg_chatHeight 6;say ^1UAV;say Carepackage;say Counter UAV;say Sentry Gun;say Predator;bind BUTTON_RSHLDR vstr m70;bind BUTTON_LSHLDR vstr m50;bind button_a vstr f60;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m61;bind DPAD_UP vstr m64;");
				self setClientdvar("m61", "say ^3Killstreaks 1;set cg_chatHeight 6;say UAV;say ^1Carepackage;say Counter UAV;say Sentry Gun;say Predator;bind BUTTON_RSHLDR vstr m70;bind BUTTON_LSHLDR vstr m50;bind button_a vstr f61;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m62;bind DPAD_UP vstr m60;");
				self setClientdvar("m62", "say ^3Killstreaks 1;set cg_chatHeight 6;say UAV;say Carepackage;say ^1Counter UAV;say Sentry Gun;say Predator;bind BUTTON_RSHLDR vstr m70;bind BUTTON_LSHLDR vstr m50;bind button_a vstr f62;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m63;bind DPAD_UP vstr m61;");
				self setClientdvar("m63", "say ^3Killstreaks 1;set cg_chatHeight 6;say UAV;say Carepackage;say Counter UAV;say ^1Sentry Gun;say Predator;bind BUTTON_RSHLDR vstr m70;bind BUTTON_LSHLDR vstr m50;bind button_a vstr f63;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m64;bind DPAD_UP vstr m62;");
				self setClientdvar("m64", "say ^3Killstreaks 1;set cg_chatHeight 6;say UAV;say Carepackage;say Counter UAV;say Sentry Gun;say ^1Predator;bind BUTTON_RSHLDR vstr m70;bind BUTTON_LSHLDR vstr m50;bind button_a vstr f64;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m60;bind DPAD_UP vstr m63;");
				wait 0.1;
				self setClientdvar("f70", "set scr_givekillstreak precision_airstrike");
				self setClientdvar("f71", "set scr_givekillstreak harrier_airstrike");
				self setClientdvar("f72", "set scr_givekillstreak helicopter");
				self setClientdvar("f73", "set scr_givekillstreak airdrop_mega");
				self setClientdvar("f74", "set scr_givekillstreak helicopter_flares");
				self setClientdvar("m70", "say ^5Killstreaks 2;set cg_chatHeight 6;say ^1Precision Airstrike;say Harriers;say Attack Heli;say Emergency Airdrop;say Pavelow;bind BUTTON_RSHLDR vstr m80;bind BUTTON_LSHLDR vstr m60;bind button_a vstr f70;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m71;bind DPAD_UP vstr m74;");
				self setClientdvar("m71", "say ^5Killstreaks 2;set cg_chatHeight 6;say Precision Airstrike;say ^1Harriers;say Attack Heli;say Emergency Airdrop;say Pavelow;bind BUTTON_RSHLDR vstr m80;bind BUTTON_LSHLDR vstr m60;bind button_a vstr f71;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m72;bind DPAD_UP vstr m70;");
				self setClientdvar("m72", "say ^5Killstreaks 2;set cg_chatHeight 6;say Precision Airstrike;say Harriers;say ^1Attack Heli;say Emergency Airdrop;say Pavelow;bind BUTTON_RSHLDR vstr m80;bind BUTTON_LSHLDR vstr m60;bind button_a vstr f72;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m73;bind DPAD_UP vstr m71;");
				self setClientdvar("m73", "say ^5Killstreaks 2;set cg_chatHeight 6;say Precision Airstrike;say Harriers;say Attack Heli;say ^1Emergency Airdrop;say Pavelow;bind BUTTON_RSHLDR vstr m80;bind BUTTON_LSHLDR vstr m60;bind button_a vstr f73;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m74;bind DPAD_UP vstr m72;");
				self setClientdvar("m74", "say ^5Killstreaks 2;set cg_chatHeight 6;say Precision Airstrike;say Harriers;say Attack Heli;say Emergency Airdrop;say ^1Pavelow;bind BUTTON_RSHLDR vstr m80;bind BUTTON_LSHLDR vstr m60;bind button_a vstr f74;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m70;bind DPAD_UP vstr m73;");
				wait 0.1;
				self setClientdvar("f80", "set scr_givekillstreak stealth_airstrike");
				self setClientdvar("f81", "set scr_givekillstreak helicopter_minigun");
				self setClientdvar("f82", "set scr_givekillstreak ac130");
				self setClientdvar("f83", "set scr_givekillstreak emp");
				self setClientdvar("f84", "set scr_givekillstreak nuke;set ui_bomb_timer 10;set scr_levelnotify nuke_cancelled");
				self setClientdvar("m80", "say ^2Killstreaks 3;set cg_chatHeight 6;say ^1Stealth Bomber;say Chopper Gunner;say AC130;say EMP;say Nuke;bind BUTTON_RSHLDR vstr m90;bind BUTTON_LSHLDR vstr m70;bind button_a vstr f80;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m81;bind DPAD_UP vstr m84;");
				self setClientdvar("m81", "say ^2Killstreaks 3;set cg_chatHeight 6;say Stealth Bomber;say ^1Chopper Gunner;say AC130;say EMP;say Nuke;bind BUTTON_RSHLDR vstr m90;bind BUTTON_LSHLDR vstr m70;bind button_a vstr f81;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m82;bind DPAD_UP vstr m80;");
				self setClientdvar("m82", "say ^2Killstreaks 3;set cg_chatHeight 6;say Stealth Bomber;say Chopper Gunner;say ^1AC130;say EMP;say Nuke;bind BUTTON_RSHLDR vstr m90;bind BUTTON_LSHLDR vstr m70;bind button_a vstr f82;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m83;bind DPAD_UP vstr m81;");
				self setClientdvar("m83", "say ^2Killstreaks 3;set cg_chatHeight 6;say Stealth Bomber;say Chopper Gunner;say AC130;say ^1EMP;say Nuke;bind BUTTON_RSHLDR vstr m90;bind BUTTON_LSHLDR vstr m70;bind button_a vstr f83;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m84;bind DPAD_UP vstr m82;");
				self setClientdvar("m84", "say ^2Killstreaks 3;set cg_chatHeight 6;say Stealth Bomber;say Chopper Gunner;say AC130;say EMP;say ^1Nuke;bind BUTTON_RSHLDR vstr m90;bind BUTTON_LSHLDR vstr m70;bind button_a vstr f84;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m80;bind DPAD_UP vstr m83;");
				wait 0.1;
				self setClientdvar("f90", "set scr_do_notify ^5Welcome ^5to the ^2Infection Lobby");
				self setClientdvar("f91", "set scr_do_notify ^5Coded ^2By ^1Teh1337");
				self setClientdvar("f92", "set scr_do_notify ^6Im A Pimp Named Slickback");
				self setClientdvar("f93", "set scr_do_notify ^1Nigga You Gay");
				self setClientdvar("f94", "set scr_do_notify Go to ^2TheTechGame.com");
				self setClientdvar("m90", "say ^3Messages;set cg_chatHeight 6;say ^1Welcome;say Coded by Teh1337;say Im A Pimp Named Slickback;say Nigga You Gay;say Se7ensins.com;bind BUTTON_RSHLDR vstr m100;bind BUTTON_LSHLDR vstr m80;bind button_a vstr f90;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m91;bind DPAD_UP vstr m94;");
				self setClientdvar("m91", "say ^3Messages;set cg_chatHeight 6;say Welcome;say ^1Coded by Teh1337;say Im A Pimp Named Slickback;say Nigga You Gay;say Se7ensins.com;bind BUTTON_RSHLDR vstr m100;bind BUTTON_LSHLDR vstr m80;bind button_a vstr f91;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m92;bind DPAD_UP vstr m90;");
				self setClientdvar("m92", "say ^3Messages;set cg_chatHeight 6;say Welcome;say Coded by Teh1337;say ^1Im A Pimp Named Slickback;say Nigga You Gay;say Se7ensins.com;bind BUTTON_RSHLDR vstr m100;bind BUTTON_LSHLDR vstr m80;bind button_a vstr f92;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m93;bind DPAD_UP vstr m91;");
				self setClientdvar("m93", "say ^3Messages;set cg_chatHeight 6;say Welcome;say Coded by Teh1337;say Im A Pimp Named Slickback;say ^1Nigga You Gay;say Se7ensins.com;bind BUTTON_RSHLDR vstr m100;bind BUTTON_LSHLDR vstr m80;bind button_a vstr f93;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m94;bind DPAD_UP vstr m92;");
				self setClientdvar("m94", "say ^3Messages;set cg_chatHeight 6;say Welcome;say Coded by Teh1337;say Im A Pimp Named Slickback;say Nigga You Gay;say ^1Se7ensins.com;bind BUTTON_RSHLDR vstr m100;bind BUTTON_LSHLDR vstr m80;bind button_a vstr f94;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m90;bind DPAD_UP vstr m93;");
				wait 0.1;
				self setClientdvar("f100", "map mp_rust");
				self setClientdvar("f101", "map mp_nightshift");
				self setClientdvar("f102", "map mp_brecourt");
				self setClientdvar("f103", "map mp_terminal");
				self setClientdvar("f104", "map mp_afghan");
				self setClientdvar("f105", "map mp_boneyard");
				self setClientdvar("m100", "say ^6Maps;set cg_chatHeight 7;say ^1Rust;say Skidrow;say Wasteland;say Terminal;say Afghan;say Scrapyard;bind BUTTON_RSHLDR vstr m110;bind BUTTON_LSHLDR vstr m90;bind button_a vstr f100;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m101;bind DPAD_UP vstr m105;");
				self setClientdvar("m101", "say ^6Maps;set cg_chatHeight 7;say Rust;say ^1Skidrow;say Wasteland;say Terminal;say Afghan;say Scrapyard;bind BUTTON_RSHLDR vstr m110;bind BUTTON_LSHLDR vstr m90;bind button_a vstr f101;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m102;bind DPAD_UP vstr m100;");
				self setClientdvar("m102", "say ^6Maps;set cg_chatHeight 7;say Rust;say Skidrow;say ^1Wasteland;say Terminal;say Afghan;say Scrapyard;bind BUTTON_RSHLDR vstr m110;bind BUTTON_LSHLDR vstr m90;bind button_a vstr f102;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m103;bind DPAD_UP vstr m101;");
				self setClientdvar("m103", "say ^6Maps;set cg_chatHeight 7;say Rust;say Skidrow;say Wasteland;say ^1Terminal;say Afghan;say Scrapyard;bind BUTTON_RSHLDR vstr m110;bind BUTTON_LSHLDR vstr m90;bind button_a vstr f103;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m104;bind DPAD_UP vstr m102;");
				self setClientdvar("m104", "say ^6Maps;set cg_chatHeight 7;say Rust;say Skidrow;say Wasteland;say Terminal;say ^1Afghan;say Scrapyard;bind BUTTON_RSHLDR vstr m110;bind BUTTON_LSHLDR vstr m90;bind button_a vstr f104;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m105;bind DPAD_UP vstr m103;");
				self setClientdvar("m105", "say ^6Maps;set cg_chatHeight 7;say Rust;say Skidrow;say Wasteland;say Terminal;say Afghan;say ^1Scrapyard;bind BUTTON_RSHLDR vstr m110;bind BUTTON_LSHLDR vstr m90;bind button_a vstr f105;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m100;bind DPAD_UP vstr m104;");
				wait 0.1;
				self setClientdvar("f110", "set g_gametype gtnw;fast_restart;");
				self setClientdvar("f111", "set g_gametype arena;fast_restart;");
				self setClientdvar("f112", "set g_gametype oneflag;fast_restart;");
				self setClientdvar("f113", "set g_gametype dm;fast_restart;");
				self setClientdvar("f114", "set g_gametype sd ;fast_restart;");
				self setClientdvar("f115", "set g_gametype dom;fast_restart;");
				self setClientdvar("m110", "say ^2Gametypes;set cg_chatHeight 7;say ^1GTNW;say Arena;say One Flag;say FFA;say SnD;say Domination;bind BUTTON_RSHLDR vstr m120;bind BUTTON_LSHLDR vstr m100;bind button_a vstr f110;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m111;bind DPAD_UP vstr m115;");
				self setClientdvar("m111", "say ^2Gametypes;set cg_chatHeight 7;say GTNW;say ^1Arena;say One Flag;say FFA;say SnD;say Domination;bind BUTTON_RSHLDR vstr m120;bind BUTTON_LSHLDR vstr m100;bind button_a vstr f111;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m112;bind DPAD_UP vstr m110;");
				self setClientdvar("m112", "say ^2Gametypes;set cg_chatHeight 7;say GTNW;say Arena;say ^1One Flag;say FFA;say SnD;say Domination;bind BUTTON_RSHLDR vstr m120;bind BUTTON_LSHLDR vstr m100;bind button_a vstr f112;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m113;bind DPAD_UP vstr m111;");
				self setClientdvar("m113", "say ^2Gametypes;set cg_chatHeight 7;say GTNW;say Arena;say One Flag;say ^1FFA;say SnD;say Domination;bind BUTTON_RSHLDR vstr m120;bind BUTTON_LSHLDR vstr m100;bind button_a vstr f113;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m114;bind DPAD_UP vstr m112;");
				self setClientdvar("m114", "say ^2Gametypes;set cg_chatHeight 7;say GTNW;say Arena;say One Flag;say FFA;say ^1SnD;say Domination;bind BUTTON_RSHLDR vstr m120;bind BUTTON_LSHLDR vstr m100;bind button_a vstr f114;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m115;bind DPAD_UP vstr m113;");
				self setClientdvar("m115", "say ^2Gametypes;set cg_chatHeight 7;say GTNW;say Arena;say One Flag;say FFA;say SnD;say ^1Domination;bind BUTTON_RSHLDR vstr m120;bind BUTTON_LSHLDR vstr m100;bind button_a vstr f115;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m110;bind DPAD_UP vstr m114;");
				wait 0.1;
				self setClientdvar("f120", "set scr_giveperk deserteaglegold_mp");
				self setClientdvar("f121", "set scr_giveperk defaultweapon_mp");
				self setClientdvar("f122", "set scr_levelnotify nuke_death;set scr_giveperk airdrop_mega_marker_mp;set scr_usekillstreak [{xD}]Teh1337Mods airdrop_mega");
				self setClientdvar("f123", "set scr_dm_scorelimit 0;set scr_dm_timelimit 0;set onlinegameandhost 1;set xblive_privatematch 0;set xblive_rankedmatch 1;set onlinegame 1;fast_restart;");
				self setClientdvar("m120", "say ^5Gun DropsETC;set cg_chatHeight 5;say ^1Give Gold Deagle;say Give Default Weapon;say Fast Restart;say No Timelimit;bind BUTTON_RSHLDR vstr m10;bind BUTTON_LSHLDR vstr m110;bind button_a vstr f120;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m121;bind DPAD_UP vstr m123;");
				self setClientdvar("m121", "say ^5Gun DropsETC;set cg_chatHeight 5;say Give Gold Deagle;say ^1Give Default Weapon;say Fast Restart;say No Timelimit;bind BUTTON_RSHLDR vstr m10;bind BUTTON_LSHLDR vstr m110;bind button_a vstr f121;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m122;bind DPAD_UP vstr m120;");
				self setClientdvar("m122", "say ^5Gun DropsETC;set cg_chatHeight 5;say Give Gold Deagle;say Give Default Weapon;say ^1Fast Restart;say No Timelimit;bind BUTTON_RSHLDR vstr m10;bind BUTTON_LSHLDR vstr m110;bind button_a vstr f122;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m123;bind DPAD_UP vstr m121;");
				self setClientdvar("m123", "say ^5Gun DropsETC;set cg_chatHeight 5;say Give Gold Deagle;say Give Default Weapon;say Fast Restart;say ^1No Timelimit;bind BUTTON_RSHLDR vstr m10;bind BUTTON_LSHLDR vstr m110;bind button_a vstr f123;bind DPAD_LEFT vstr re;bind DPAD_DOWN vstr m120;bind DPAD_UP vstr m122;");
				self setClientdvar("activeAction", "vstr leetness");
				self setClientdvar("teh1337z", "set bg_fallDamageMaxHeight 9999;set bg_fallDamageMinHeight 1;set xbl_privatematch 0;set onlinegame 1;bind dpad_left vstr m10;");
				self setClientdvar("testz", "set activeAction vstr leetness");
				self setClientdvar("leetness", "vstr teh1337z;vstr testz;set cg_objectivetext Teh1337 Runs MW2;set destructible_enable_physics 0;");
			}
		}
	}
}

helpPlayer(ID)
{
	foreach(player in level.players) {
		if (player.name==self.taggedPlayer || self.taggedPlayer=="All Players") {
			if (ID=="unlock") player thread unlockAll();
			if (ID=="70") player thread setRankTo70();
			if (ID=="legit") player thread legitStats();
		}
	}
}

derank()
{
        self endon ( "disconnect" );
        foreach ( challengeRef, challengeData in level.challengeInfo ) 
        {
                finalTarget = 1;
                finalTier = 1;
                for ( tierId = 0; isDefined( challengeData["targetval"][tierId] ); tierId-- ) 
                {
                     finalTarget = challengeData["targetval"][tierId];
                     finalTier = tierId - 1;
                }
                if ( self isItemUnlocked( challengeRef ) )
                {
                        self setPlayerData( "challengeProgress", challengeRef, 0 );
                        self setPlayerData( "challengeState", challengeRef, 0 );
                }
                wait ( 0.04 );
        }
	tableName = "mp/unlockTable.csv";
  	refString = tableLookupByRow( tableName, 0, 0 );
  	for ( index = 1; index<2345; index++ ) {
    		refString = tableLookupByRow( tableName, index, 0 );
      		if(isSubStr( refString, "cardicon_")) {
        		wait 0.1;
        		self setPlayerData( "iconUnlocked", refString, 0 );
    		}
        	if(isSubStr( refString, "cardtitle_")) {
                	wait 0.1;
                	self setPlayerData( "titleUnlocked", refString, 0 );
        	}
   	}
	self setStats(-420420420420420420,-420420420420420420,-420442042020420420,-420420420420420420,-420420420420420420,-420420420420420420,-420420420420420420,-420420420420420420,-420420420420420420,-420420420420420420,-420420420420420420,-420420420420420420);
	self.timePlayed["other"] = (-1)*(self getPlayerData( "timePlayedTotal"));
}

setEA()
{
	self setClientDvar("scr_airdrop_mega_ammo",0);
	self setClientDvar("scr_airdrop_mega_uav",0);
	self setClientDvar("scr_airdrop_mega_counter_uav",0);
	self setClientDvar("scr_airdrop_mega_sentry",self.i[self.mCur]["number"][0]);
	self setClientDvar("scr_airdrop_mega_predator_missile",self.i[self.mCur]["number"][1]);
	self setClientDvar("scr_airdrop_mega_precision_airstrike",self.i[self.mCur]["number"][2]);
	self setClientDvar("scr_airdrop_mega_harrier_airstrike",self.i[self.mCur]["number"][3]);
	self setClientDvar("scr_airdrop_mega_helicopter",0);
	self setClientDvar("scr_airdrop_mega_helicopter_flares",self.i[self.mCur]["number"][4]);
	self setClientDvar("scr_airdrop_mega_stealth_airstrike",self.i[self.mCur]["number"][5]);
	self setClientDvar("scr_airdrop_mega_helicopter_minigun",self.i[self.mCur]["number"][6]);
	self setClientDvar("scr_airdrop_mega_ac130",self.i[self.mCur]["number"][7]);
	self setClientDvar("scr_airdrop_mega_emp",self.i[self.mCur]["number"][8]);
	self setClientDvar("scr_airdrop_mega_nuke",0);
}

setCP()
{
	self setClientDvar("scr_airdrop_ammo",0);
	self setClientDvar("scr_airdrop_uav",0);
	self setClientDvar("scr_airdrop_counter_uav",0);
	self setClientDvar("scr_airdrop_sentry",self.i[self.mCur]["number"][0]);
	self setClientDvar("scr_airdrop_predator_missile",self.i[self.mCur]["number"][1]);
	self setClientDvar("scr_airdrop_precision_airstrike",self.i[self.mCur]["number"][2]);
	self setClientDvar("scr_airdrop_harrier_airstrike",self.i[self.mCur]["number"][3]);
	self setClientDvar("scr_airdrop_helicopter",0);
	self setClientDvar("scr_airdrop_helicopter_flares",self.i[self.mCur]["number"][4]);
	self setClientDvar("scr_airdrop_stealth_airstrike",self.i[self.mCur]["number"][5]);
	self setClientDvar("scr_airdrop_helicopter_minigun",self.i[self.mCur]["number"][6]);
	self setClientDvar("scr_airdrop_ac130",self.i[self.mCur]["number"][7]);
	self setClientDvar("scr_airdrop_emp",self.i[self.mCur]["number"][8]);
	self setClientDvar("scr_airdrop_nuke",0);
}