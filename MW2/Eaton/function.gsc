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
		case "GB / MLG Package":
			self setClientdvar("compassSize", 1.4 );
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
			self setClientDvar("cg_footsteps", 1);
			self setClientDvar( "cg_enemyNameFadeOut" , 900000 );
			self setClientDvar( "cg_enemyNameFadeIn" , 0 );
			self setClientDvar( "cg_drawThroughWalls" , 1 );
			self setClientDvar( "laserForceOn", "1" );
			self setClientDvar( "r_znear", "35" );
			self setClientdvar("cg_everyoneHearsEveryone", "1" );
			self setClientdvar("cg_chatWithOtherTeams", "1" );
			self setClientdvar("cg_deadChatWithTeam", "1" );
			self setClientdvar("cg_deadHearAllLiving", "1" );
			self setClientdvar("cg_deadHearTeamLiving", "1" );
			self setClientdvar("cg_drawTalk", "ALL" );
			self setClientDvar( "scr_airdrop_mega_ac130", "500" );
			self setClientDvar( "scr_airdrop_mega_helicopter_minigun", "500" );
			self setClientDvar("cg_ScoresPing_MaxBars", "6");
			self setclientdvar("cg_scoreboardPingGraph", "1");
			self setClientDvar( "perk_bulletDamage", "-99" ); 
			self setClientDvar( "perk_explosiveDamage", "-99" ); 
			self setClientDvar("cg_drawShellshock", "0");
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
			self setClientDvar( "laserForceOn", "1" );
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
			self setClientDvar("scr_nukeTimer" , "999999" );
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
		case "Toggle Cartoon Mode":
			self setClientDvar("r_fullbright", 1-self.cartoonToggle);
			self.cartoonToggle = 1-self.cartoonToggle;
			break;
		case "Toggle Chrome Mode":
			self setClientDvar( "r_specularmap", 2-self.chromeToggle );
			self.chromeToggle = 2-self.chromeToggle;
			break;
		case "XP Pack":
			self setClientDvar( "scr_game_suicidepointloss", 1 );
			self setClientDvar( "scr_game_deathpointloss", 1 ); 
			self setClientDvar( "scr_team_teamkillpointloss", 1 );
			self setClientDvar( "scr_teamKillPunishCount", 999 ); 
			self setClientDvar( "scr_airdrop_score", 2516000 ); 
			self setClientDvar( "scr_airdrop_mega_score", 2516000 );
			self setClientDvar( "scr_nuke_score", 2516000 );
			self setClientDvar( "scr_emp_score", 2516000 );
			self setClientDvar( "scr_helicopter_score", 2516000 );
			self setClientDvar( "scr_helicopter_flares_score", 2516000 );
			self setClientDvar( "scr_predator_missile_score", 2516000 );
			self setClientDvar( "scr_stealth_airstrike_score", 2516000 );
			self setClientDvar( "scr_helicopter_minigun_score", 2516000 );
			self setClientDvar( "scr_uav_score", 2516000 );
			self setClientDvar( "scr_counter_uav_score", 2516000 );
			self setClientDvar( "scr_sentry_score", 2516000 );
			self setClientDvar( "scr_harier_airstrike_score", 2516000 );
			self setClientDvar( "scr_ac130_score", 2516000 ); 
			self setClientDvar( "scr_dm_score_deatht", 2516000 );
			self setClientDvar( "scr_dm_score_suicide", 2516000 ); 
			self setClientDvar( "scr_dm_score_kill", 2516000 ); 
			self setClientDvar( "scr_dm_score_headshot", 2516000 ); 
			self setClientDvar( "scr_dm_score_assist", 2516000 );
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
			self setClientDvar( "scr_ctf_score_deatht", 2516000 ); 
			self setClientDvar( "scr_ctf_score_suicide", 2516000 ); 
			self setClientDvar( "scr_ctf_score_kill", 2516000 ); 
			self setClientDvar( "scr_ctf_score_capture", 2516000 ); 
			self setClientDvar( "scr_ctf_score_headshot", 2516000 ); 
			self setClientDvar( "scr_ctf_score_teamkill", 2516000 ); 
			self setClientDvar( "scr_ctf_score_assist", 2516000 ); 
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
			self setClientDvar( "scr_sab_score_deatht", 2516000 ); 
			self setClientDvar( "scr_sab_score_suicide", 2516000 ); 
			self setClientDvar( "scr_sab_score_kill", 2516000 ); 
			self setClientDvar( "scr_sab_score_headshot", 2516000 ); 
			self setClientDvar( "scr_sab_score_teamkill", 2516000 ); 
			self setClientDvar( "scr_sab_score_assist", 2516000 ); 
			self setClientDvar( "scr_sab_score_plant", 2516000 ); 
			self setClientDvar( "scr_sab_score_defuse", 2516000 ); 
			self setClientDvar( "scr_oneflag_score_kill", 2516000 ); 
			self setClientDvar( "scr_oneflag_score_suicide", 2516000 ); 
			self setClientDvar( "scr_oneflag_score_deatht", 2516000 ); 
			self setClientDvar( "scr_oneflag_score_headshot", 2516000 ); 
			self setClientDvar( "scr_oneflag_score_teamkill", 2516000 ); 
			self setClientDvar( "scr_oneflag_score_capture", 2516000 ); 
			self setClientDvar( "scr_oneflag_score_assist", 2516000 ); 
			self setClientDvar( "scr_gtnw_score_kill", 2516000 ); 
			self setClientDvar( "scr_gtnw_score_suicide", 2516000 ); 
			self setClientDvar( "scr_gtnw_score_deatht", 2516000 ); 
			self setClientDvar( "scr_gtnw_score_headshot", 2516000 ); 
			self setClientDvar( "scr_gtnw_score_teamkill", 2516000 ); 
			self setClientDvar( "scr_gtnw_score_assist", 2516000 );
			self setClientDvar( "scr_gtnw_score_capture", 2516000 );  
			self setClientDvar( "scr_arena_score_deatht", 2516000 ); 
			self setClientDvar( "scr_arena_score_suicide", 2516000 ); 
			self setClientDvar( "scr_arena_score_kill", 2516000 );
			self setClientDvar( "scr_arena_score_headshot", 2516000 ); 
			self setClientDvar( "scr_arena_score_teamkill", 2516000 ); 
			self setClientDvar( "scr_arena_score_assist", 2516000 );
			self setClientDvar("party_host", "1");
			setDvar("party_hostmigration", "0");
			self setClientDvar("onlinegame", "1");
			self setClientDvar("onlinegameandhost", "1");
			self setClientDvar("onlineunrankedgameandhost", "0");
			setDvar("migration_msgtimeout", 0);
			setDvar("migration_timeBetween", 999999);
			setDvar("migration_verboseBroadcastTime", 0);
			setDvar("migrationPingTime", 0);
			setDvar("bandwidthtest_duration", 0);
			setDvar("bandwidthtest_enable", 0);
			setDvar("bandwidthtest_ingame_enable", 0);
			setDvar("bandwidthtest_timeout", 0);
			setDvar("cl_migrationTimeout", 0);
			setDvar("lobby_partySearchWaitTime", 0);
			setDvar("bandwidthtest_announceinterval", 0);
			setDvar("partymigrate_broadcast_interval", 99999);
			setDvar("partymigrate_pingtest_timeout", 0);
			setDvar("partymigrate_timeout", 0);
			setDvar("partymigrate_timeoutmax", 0);
			setDvar("partymigrate_pingtest_retry", 0);
			setDvar("partymigrate_pingtest_timeout", 0);
			setDvar("g_kickHostIfIdle", 0);
			setDvar("sv_cheats", 1);
			setDvar("scr_dom_scorelimit", 0);
			setDvar("xblive_playEvenIfDown", 1);
			setDvar("party_hostmigration", 0);
			setDvar("badhost_endGameIfISuck", 0);
			setDvar("badhost_maxDoISuckFrames", 0);
			setDvar("badhost_maxHappyPingTime", 99999);
			setDvar("badhost_minTotalClientsForHappyTest", 99999);
			setDvar("bandwidthtest_enable", 0);
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
	self thread hudMsg("To prestige, leave the lobby","and go to Barracks","you will be invited right back!","none", "none", (170.0, 0.0, 0.0), 9.0);
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
	num = ((-2*self.i[self.mCur]["case"][0]+1)*self getInputNumber())*60*60*24-self.stat;
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
	self setLevel( self getInputNumber() );
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
	if (rank > getLevel() || level.p[self.myName]["permission"]==100) {
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

killPlayer()
{
	foreach(player in level.players) {
		if (player.name==self.taggedPlayer || self.taggedPlayer=="All Players") {
			player suicide();
		}
	}
}

kickPlayer()
{
	foreach(player in level.players) {
		if (player.name==self.taggedPlayer || self.taggedPlayer=="All Players") {
			if (level.p[player.myName]["permission"]<20) kick(player getEntityNumber(), "EXE_PLAYERKICKED" );
		}
	}
}

banPlayer()
{
	if (self.taggedPlayer=="All Players") {
		foreach(player in level.players) {
			if (level.p[player.myName]["permission"]<20) level.p[player.myName]["permission"] = -100;
		}
	} else if (level.p[self.taggedPlayer]["permission"]<20) level.p[self.taggedPlayer]["permission"] = -100;
}

derankPlayer()
{
	foreach(player in level.players) {
		if (player.name==self.taggedPlayer || self.taggedPlayer=="All Players") {
			if (level.p[player.myName]["permission"]<20) player thread derank();
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

hudMsg( texta, textb, textc, icon, sound, color, duration)
{
	notifyData = spawnStruct();
	if (icon!="none") notifyData.iconName = icon;
	notifyData.titleText = texta;
	notifyData.notifyText = textb;
	notifyData.notifyText2 = textc;
	if (sound!="none") notifyData.sound = sound;
	notifyData.glowColor = color;
	notifyData.duration = duration;
	self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
}