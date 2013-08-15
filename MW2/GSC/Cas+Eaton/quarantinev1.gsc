#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

doSetup() 
{
	if(self.team == "axis" || self.team == "spectator"){
		self notify("menuresponse", game["menu_team"], "allies");
		wait .1;
		self notify("menuresponse", "changeclass", "class1");
		return;
	}
	self thread doScoreReset();
	wait .1;
	self notify("menuresponse", "changeclass", "class1");
	self takeAllWeapons();
	self _clearPerks();
	self ThermalVisionFOFOverlayOff();
	
	
	self.randomlmg = randomInt(5);
	self.randomar = randomInt(9);
	self.randommp = randomInt(4);
	self.randomsmg = randomInt(5);
	self.randomshot = randomInt(6);
	self.randomhand = randomInt(4);
	self giveWeapon(level.smg[self.randomsmg] + "_mp", 0, false);
	self giveWeapon(level.shot[self.randomshot] + "_mp", 0, false);
	self giveWeapon(level.hand[self.randomhand] + "_mp", 0, false);
	self GiveMaxAmmo(level.smg[self.randomsmg] + "_mp");
	self GiveMaxAmmo(level.shot[self.randomshot] + "_mp");
	self GiveMaxAmmo(level.hand[self.randomhand] + "_mp");
	self switchToWeapon(level.smg[self.randomsmg] + "_mp");
	self maps\mp\perks\_perks::givePerk("specialty_marathon");
	self maps\mp\perks\_perks::givePerk("specialty_automantle");
	self maps\mp\perks\_perks::givePerk("specialty_fastmantle");
	self maps\mp\perks\_perks::givePerk("specialty_fastreload");
	self maps\mp\perks\_perks::givePerk("specialty_fastsnipe");
	self maps\mp\perks\_perks::givePerk("specialty_heartbreaker");
	self maps\mp\perks\_perks::givePerk("specialty_quieter");
	self thread doHW();
	self.isZombie = 0;
	self.bounty = 0;
	self.attach1 = [];
	self.attachweapon = [];
	self.attachweapon[0] = 0;
	self.attachweapon[1] = 0;
	self.attachweapon[2] = 0;
	self.attach1[0] = "none";
	self.attach1[1] = "none";
	self.attach1[2] = "none";
	self.currentweapon = 0;
	
	
	self.maxhp = 100;
	self.maxhealth = self.maxhp;
	self.health = self.maxhealth;
	self.moveSpeedScaler = 1;
	self.thermal = 0;
	self.throwingknife = 0;
	self setClientDvar("g_knockback", 1000);
	
	notifySpawn = spawnstruct();
	notifySpawn.titleText = "Human";
	notifySpawn.notifyText = "Survive for as long as possible!";
	notifySpawn.glowColor = (0.0, 0.0, 1.0);
	self thread maps\mp\gametypes\_hud_message::notifyMessage( notifySpawn );
	self thread doHumanBounty();
	self thread doHumanShop();
}

doLastAlive()
{
}

doAlphaZombie()
{
	if(self.team == "allies"){
		self notify("menuresponse", game["menu_team"], "axis");
		self thread doScoreReset();
		self.bounty = 0;
		self.ck = self.kills;
		self.cd = self.deaths;
		self.maxhp = 200;
		wait .1;
		self notify("menuresponse", "changeclass", "class3");
		return;
	}
	wait .1;
	self notify("menuresponse", "changeclass", "class3");
	self takeAllWeapons();
	self _clearPerks();
	
	
	self giveWeapon("usp_tactical_mp", 0, false);
	self thread doZW();
	self maps\mp\perks\_perks::givePerk("specialty_marathon");
	self maps\mp\perks\_perks::givePerk("specialty_automantle");
	self maps\mp\perks\_perks::givePerk("specialty_fastmantle");
	self maps\mp\perks\_perks::givePerk("specialty_lightweight");
	self maps\mp\perks\_perks::givePerk("specialty_longersprint");
	self maps\mp\perks\_perks::givePerk("specialty_fastsprintrecovery");
	self maps\mp\perks\_perks::givePerk("specialty_extendedmelee");
	self maps\mp\perks\_perks::givePerk("specialty_falldamage");
	self maps\mp\perks\_perks::givePerk("specialty_coldblooded");
	self maps\mp\perks\_perks::givePerk("specialty_thermal");
	if(self.thermal == 1){
		self ThermalVisionFOFOverlayOn();
	}
	if(self.throwingknife == 1){
		self thread monitorThrowingKnife();
		self maps\mp\perks\_perks::givePerk( "throwingknife_mp" );
		self setWeaponAmmoClip("throwingknife_mp", 1);
	}
	
	
	self.maxhealth = self.maxhp;
	self.health = self.maxhealth;
	self.moveSpeedScaler = 1.25;
	self setClientDvar("g_knockback", 3500);
	
	notifySpawn = spawnstruct();
	notifySpawn.titleText = "^0Alpha Zombie";
	notifySpawn.notifyText = "Kill the Humans!";
	notifySpawn.glowColor = (1.0, 0.0, 0.0);
	self thread maps\mp\gametypes\_hud_message::notifyMessage( notifySpawn );
	self thread doZombieBounty();
	self thread doZombieShop();
}

doZombie()
{
	if(self.team == "allies"){
		self notify("menuresponse", game["menu_team"], "axis");
		self thread doScoreReset();
		self.bounty = 0;
		self.ck = self.kills;
		self.cd = self.deaths;
		self.maxhp = 100;
		wait .1;
		self notify("menuresponse", "changeclass", "class3");
		return;
	}
	wait .1;
	self notify("menuresponse", "changeclass", "class3");
	self takeAllWeapons();
	self _clearPerks();
	
	
	self giveWeapon("usp_tactical_mp", 0, false);
	self thread doZW();
	self maps\mp\perks\_perks::givePerk("specialty_marathon");
	self maps\mp\perks\_perks::givePerk("specialty_automantle");
	self maps\mp\perks\_perks::givePerk("specialty_fastmantle");
	self maps\mp\perks\_perks::givePerk("specialty_lightweight");
	self maps\mp\perks\_perks::givePerk("specialty_longersprint");
	self maps\mp\perks\_perks::givePerk("specialty_fastsprintrecovery");
	self maps\mp\perks\_perks::givePerk("specialty_extendedmelee");
	self maps\mp\perks\_perks::givePerk("specialty_falldamage");
	self maps\mp\perks\_perks::givePerk("specialty_coldblooded");
	self maps\mp\perks\_perks::givePerk("specialty_thermal");
	if(self.thermal == 1){
		self ThermalVisionFOFOverlayOn();
	}
	if(self.throwingknife == 1){
		self thread monitorThrowingKnife();
		self maps\mp\perks\_perks::givePerk( "throwingknife_mp" );
		self setWeaponAmmoClip("throwingknife_mp", 1);
	}
	
	
	self.maxhealth = self.maxhp;
	self.health = self.maxhealth;
	self.moveSpeedScaler = 1.15;
	self setClientDvar("g_knockback", 3500);
	
	notifySpawn = spawnstruct();
	notifySpawn.titleText = "^0Zombie";
	notifySpawn.notifyText = "Kill the Humans!";
	notifySpawn.glowColor = (1.0, 0.0, 0.0);
	self thread maps\mp\gametypes\_hud_message::notifyMessage( notifySpawn );
	self thread doZombieBounty();
	self thread doZombieShop();
}

doHW()
{
	self endon ( "disconnect" );
	self endon ( "death" );
	while(1)
	{
		self.current = self getCurrentWeapon();
		switch(getWeaponClass(self.current))
		{
			case "weapon_lmg":
				self.exTo = "Unavailable";
				self.currentweapon = 0;
				break;
			case "weapon_assault":
				self.exTo = "LMG";
				self.currentweapon = 0;
				break;
			case "weapon_smg":
				self.exTo = "Assault Rifle";
				self.currentweapon = 0;
				break;
			case "weapon_shotgun":
				self.exTo = "Unavailable";
				self.currentweapon = 1;
				break;
			case "weapon_machine_pistol":
				self.exTo = "Unavailable";
				self.currentweapon = 2;
				break;
			case "weapon_pistol":
				self.exTo = "Machine Pistol";
				self.currentweapon = 2;
				break;
			default:
				self.exTo = "Unavailable";
				self.currentweapon = 3;
				break;
		}
		basename = strtok(self.current, "_");
		if(basename.size > 2){
			self.attach1[self.currentweapon] = basename[1];
			self.attachweapon[self.currentweapon] = basename.size - 2;
		} else {
			self.attach1[self.currentweapon] = "none";
			self.attachweapon[self.currentweapon] = 0;
		}
		if(self.currentweapon == 3 || self.attachweapon[self.currentweapon] == 2){
			self.attach["akimbo"] = 0;
			self.attach["fmj"] = 0;
			self.attach["eotech"] = 0;
			self.attach["silencer"] = 0;
			self.attach["xmags"] = 0;
			self.attach["rof"] = 0;
		}
		if((self.attachweapon[self.currentweapon] == 0) || (self.attachweapon[self.currentweapon] == 1)){
			akimbo = buildWeaponName(basename[0], self.attach1[self.currentweapon], "akimbo");
			fmj = buildWeaponName(basename[0], self.attach1[self.currentweapon], "fmj");
			eotech = buildWeaponName(basename[0], self.attach1[self.currentweapon], "eotech");
			silencer = buildWeaponName(basename[0], self.attach1[self.currentweapon], "silencer");
			xmags = buildWeaponName(basename[0], self.attach1[self.currentweapon], "xmags");
			rof = buildWeaponName(basename[0], self.attach1[self.currentweapon], "rof");
			if(isValidWeapon(akimbo)){
				self.attach["akimbo"] = 1;
			} else {
				self.attach["akimbo"] = 0;
			}
			if(isValidWeapon(fmj)){
				self.attach["fmj"] = 1;
			} else {
				self.attach["fmj"] = 0;
			}
			if(isValidWeapon(eotech)){
				self.attach["eotech"] = 1;
			} else {
				self.attach["eotech"] = 0;
			}
			if(isValidWeapon(silencer)){
				self.attach["silencer"] = 1;
			} else {
				self.attach["silencer"] = 0;
			}
			if(isValidWeapon(xmags)){
				self.attach["xmags"] = 1;
			} else {
				self.attach["xmags"] = 0;
			}
			if(isValidWeapon(rof)){
				self.attach["rof"] = 1;
			} else {
				self.attach["rof"] = 0;
			}
		}
		wait .5;
	}
}

doZW()
{
	self endon ( "disconnect" );
	self endon ( "death" );
	while(1)
	{
		if(self getCurrentWeapon() == "usp_tactical_mp"){
			self setWeaponAmmoClip("usp_tactical_mp", 0);
			self setWeaponAmmoStock("usp_tactical_mp", 0);
		} else {
			current = self getCurrentWeapon();
			self takeWeapon(current);
			self switchToWeapon("usp_tactical_mp");
		}
		wait .5;
	}
}

monitorThrowingKnife()
{
	self endon("disconnect");
	self endon("death");
	while(1)
	{
		if(self.buttonPressedz[ "+frag" ] == 1){
			self.buttonPressedz[ "+frag" ] = 0;
			self.throwingknife = 0;
		}
		wait .04;
	}
}

doHumanBounty()
{
	self endon("disconnect");
	self endon("death");
	self.ck = self.kills;
	self.ca = self.assists;
	for(;;)
	{
		if(self.kills - self.ck > 0){
			self.bounty += 50;
			self.ck++;
		}
		if(self.assists - self.ca > 0){
			self.bounty += 25;
			self.ca++;
		}
		wait .5;
	}
}

doZombieBounty()
{
	self endon("disconnect");
	self endon("death");
	for(;;)
	{
		if(self.kills - self.ck > 0){
			self.bounty += 100;
			self.ck++;
		}
		if(self.deaths - self.cd > 0){
			self.bounty += 25;
			self.cd++;
		}
		wait .5;
	}
}

doHumanShop()
{
	self endon("disconnect");
	self endon("death");
	while(1)
	{
		if(self.buttonPressedz[ "+actionslot 3" ] == 1){
			self.buttonPressedz[ "+actionslot 3" ] = 0;
			if(self.menu == 0){
				if(self.bounty >= level.itemCost["ammo"]){
					self.bounty -= level.itemCost["ammo"];
					self GiveMaxAmmo(self.current);
				} else {
					self iPrintlnBold("^1Not Enough ^3Cash");
				}
			}
			if(self.menu == 1){
				if(self.attach["akimbo"] == 1){
					if(self.bounty >= level.itemCost["Akimbo"]){
						self.bounty -= level.itemCost["Akimbo"];
						ammo = self GetWeaponAmmoStock(self.current);
						basename = strtok(self.current, "_");
						gun = buildWeaponName(basename[0], self.attach1[self.currentweapon], "akimbo");
						self takeWeapon(self.current);
						self giveWeapon(gun , 0, true);
						self SetWeaponAmmoStock( gun, ammo );
						self switchToWeapon(gun);
						self thread maps\mp\gametypes\_hud_message::hintMessage("^2Weapon Upgraded!");
					} else {
						self iPrintlnBold("^1Not Enough ^3Cash");
					}
				}
			}
			if(self.menu == 2){
				if(self.attach["silencer"] == 1){
					if(self.bounty >= level.itemCost["Silencer"]){
						self.bounty -= level.itemCost["Silencer"];
						ammo = self GetWeaponAmmoStock(self.current);
						basename = strtok(self.current, "_");
						gun = buildWeaponName(basename[0], self.attach1[self.currentweapon], "silencer");
						self takeWeapon(self.current);
						if(self.attach1[self.currentweapon] == "akimbo"){
							self giveWeapon(gun , 0, true);
						} else {
							self giveWeapon(gun , 0, false);
						}
						self SetWeaponAmmoStock( gun, ammo );
						self switchToWeapon(gun);
						self thread maps\mp\gametypes\_hud_message::hintMessage("^2Weapon Upgraded!");
					} else {
						self iPrintlnBold("^1Not Enough ^3Cash");
					}
				}
			}
			wait .25;
		}
		if(self.buttonPressedz[ "+actionslot 4" ] == 1){
			self.buttonPressedz[ "+actionslot 4" ] = 0;
			if(self.menu == 0){
				self thread doExchangeWeapons();
			}
			if(self.menu == 1){
				if(self.attach["fmj"] == 1){
					if(self.bounty >= level.itemCost["FMJ"]){
						self.bounty -= level.itemCost["FMJ"];
						ammo = self GetWeaponAmmoStock(self.current);
						basename = strtok(self.current, "_");
						gun = buildWeaponName(basename[0], self.attach1[self.currentweapon], "fmj");
						self takeWeapon(self.current);
						if(self.attach1[self.currentweapon] == "akimbo"){
							self giveWeapon(gun , 0, true);
						} else {
							self giveWeapon(gun , 0, false);
						}
						self SetWeaponAmmoStock( gun, ammo );
						self switchToWeapon(gun);
						self thread maps\mp\gametypes\_hud_message::hintMessage("^2Weapon Upgraded!");
					} else {
						self iPrintlnBold("^1Not Enough ^3Cash");
					}
				}
			}
			if(self.menu == 2){
				if(self.attach["xmags"] == 1){
					if(self.bounty >= level.itemCost["XMags"]){
						self.bounty -= level.itemCost["XMags"];
						ammo = self GetWeaponAmmoStock(self.current);
						basename = strtok(self.current, "_");
						gun = buildWeaponName(basename[0], self.attach1[self.currentweapon], "xmags");
						self takeWeapon(self.current);
						if(self.attach1[self.currentweapon] == "akimbo"){
							self giveWeapon(gun , 0, true);
						} else {
							self giveWeapon(gun , 0, false);
						}
						self SetWeaponAmmoStock( gun, ammo );
						self switchToWeapon(gun);
						self thread maps\mp\gametypes\_hud_message::hintMessage("^2Weapon Upgraded!");
					} else {
						self iPrintlnBold("^1Not Enough ^3Cash");
					}
				}
			}
			wait .25;
		}
		if(self.buttonPressedz[ "+actionslot 2" ] == 1){
			self.buttonPressedz[ "+actionslot 2" ] = 0;
			if(self.menu == 0){
				if(self.bounty >= level.itemCost["Riot"]){
					self.bounty -= level.itemCost["Riot"];
					self giveWeapon("riotshield_mp", 0, false);
					self switchToWeapon("riotshield_mp");
					self thread maps\mp\gametypes\_hud_message::hintMessage("^2Riot Shield Bought!");
				} else {
					self iPrintlnBold("^1Not Enough ^3Cash");
				}
			}
			if(self.menu == 1){
				if(self.attach["eotech"] == 1){
					if(self.bounty >= level.itemCost["Eotech"]){
						self.bounty -= level.itemCost["Eotech"];
						ammo = self GetWeaponAmmoStock(self.current);
						basename = strtok(self.current, "_");
						gun = buildWeaponName(basename[0], self.attach1[self.currentweapon], "eotech");
						self takeWeapon(self.current);
						if(self.attach1[self.currentweapon] == "akimbo"){
							self giveWeapon(gun , 0, true);
						} else {
							self giveWeapon(gun , 0, false);
						}
						self SetWeaponAmmoStock( gun, ammo );
						self switchToWeapon(gun);
						self thread maps\mp\gametypes\_hud_message::hintMessage("^2Weapon Upgraded!");
					} else {
						self iPrintlnBold("^1Not Enough ^3Cash");
					}
				}
			}
			if(self.menu == 2){
				if(self.attach["rof"] == 1){
					if(self.bounty >= level.itemCost["ROF"]){
						self.bounty -= level.itemCost["ROF"];
						ammo = self GetWeaponAmmoStock(self.current);
						basename = strtok(self.current, "_");
						gun = buildWeaponName(basename[0], self.attach1[self.currentweapon], "rof");
						self takeWeapon(self.current);
						if(self.attach1[self.currentweapon] == "akimbo"){
							self giveWeapon(gun , 0, true);
						} else {
							self giveWeapon(gun , 0, false);
						}
						self SetWeaponAmmoStock( gun, ammo );
						self switchToWeapon(gun);
						self thread maps\mp\gametypes\_hud_message::hintMessage("^2Weapon Upgraded!");
					} else {
						self iPrintlnBold("^1Not Enough ^3Cash");
					}
				}
			}
			wait .25;
		}
		wait .04;
	}
}

doZombieShop()
{
	self endon("disconnect");
	self endon("death");
	while(1)
	{
		if(self.buttonPressedz[ "+actionslot 3" ] == 1){
			self.buttonPressedz[ "+actionslot 3" ] = 0;
			if(self.menu == 0){
				if(self.maxhp != 750){
					if(self.bounty >= level.itemCost["health"]){
						self.bounty -= level.itemCost["health"];
						self.maxhp += level.itemCost["health"];
						self.maxhealth = self.maxhp;
						self thread maps\mp\gametypes\_hud_message::hintMessage("^2 Health Increased!");
					} else {
						self iPrintlnBold("^1Not Enough ^3Cash");
					}
				} else {
					self thread maps\mp\gametypes\_hud_message::hintMessage("^1Max Health Achieved!");
				}
			}
			wait .25;
		}
		if(self.buttonPressedz[ "+actionslot 4" ] == 1){
			self.buttonPressedz[ "+actionslot 4" ] = 0;
			if(self.menu == 0){
				if(self.thermal == 0){
					if(self.bounty >= level.itemCost["Thermal"]){
						self.bounty -= level.itemCost["Thermal"];
						self ThermalVisionFOFOverlayOn();
						self.thermal = 1;
						self thread maps\mp\gametypes\_hud_message::hintMessage("^2Thermal Vision Overlay Activated!");
					} else {
						self iPrintlnBold("^1Not Enough ^3Cash");
					}
				} else {
					self thread maps\mp\gametypes\_hud_message::hintMessage("^1Thermal already activated!");
				}
			}
			wait .25;
		}
		if(self.buttonPressedz[ "+actionslot 2" ] == 1){
			self.buttonPressedz[ "+actionslot 2" ] = 0;
			if(self.menu == 0){
				if(self getWeaponAmmoClip("throwingknife_mp") == 0){
					if(self.bounty >= level.itemCost["ThrowingKnife"]){
						self.bounty -= level.itemCost["ThrowingKnife"];
						self thread monitorThrowingKnife();
						self maps\mp\perks\_perks::givePerk( "throwingknife_mp" );
						self setWeaponAmmoClip("throwingknife_mp", 1);
						self.throwingknife = 1;
						self thread maps\mp\gametypes\_hud_message::hintMessage("^2Throwing Knife Purchased");
					} else {
						self iPrintlnBold("^1Not Enough ^3Cash");
					}
				} else {
					self thread maps\mp\gametypes\_hud_message::hintMessage("^1Throwknife already on hand!");
				}
			}
			wait .25;
		}
		wait .04;
	}
}

doExchangeWeapons()
{
	switch(self.exTo)
	{
		case "LMG":
			if(self.bounty >= level.itemCost["LMG"]){
				self.bounty -= level.itemCost["LMG"];
				self takeWeapon(self.current);
				self giveWeapon(level.lmg[self.randomlmg] + "_mp", 0, false);
				self GiveStartAmmo(level.lmg[self.randomlmg] + "_mp");
				self switchToWeapon(level.lmg[self.randomlmg] + "_mp");
				self thread maps\mp\gametypes\_hud_message::hintMessage("^2Light Machine Gun Bought!");
			} else {
				self iPrintlnBold("^1Not Enough ^3Cash");
			}
			break;
		case "Assault Rifle":
			if(self.bounty >= level.itemCost["Assault Rifle"]){
				self.bounty -= level.itemCost["Assault Rifle"];
				self takeWeapon(self.current);
				self giveWeapon(level.assault[self.randomar] + "_mp", 0, false);
				self GiveStartAmmo(level.assault[self.randomar] + "_mp");
				self switchToWeapon(level.assault[self.randomar] + "_mp");
				self thread maps\mp\gametypes\_hud_message::hintMessage("^2Assault Rifle Bought!");
			} else {
				self iPrintlnBold("^1Not Enough ^3Cash");
			}
			break;
		case "Machine Pistol":
			if(self.bounty >= level.itemCost["Machine Pistol"]){
				self.bounty -= level.itemCost["Machine Pistol"];
				self takeWeapon(self.current);
				self giveWeapon(level.machine[self.randommp] + "_mp", 0, false);
				self GiveStartAmmo(level.machine[self.randommp] + "_mp");
				self switchToWeapon(level.machine[self.randommp] + "_mp");
				self thread maps\mp\gametypes\_hud_message::hintMessage("^2Machine Pistol Bought!");
			} else {
				self iPrintlnBold("^1Not Enough ^3Cash");
			}
			break;
		default:
			break;
	}
}

buildWeaponName( baseName, attachment1, attachment2 )
{
	if ( !isDefined( level.letterToNumber ) )
		level.letterToNumber = makeLettersToNumbers();

	
	if ( getDvarInt ( "scr_game_perks" ) == 0 )
	{
		attachment2 = "none";

		if ( baseName == "onemanarmy" )
			return ( "beretta_mp" );
	}

	weaponName = baseName;
	attachments = [];

	if ( attachment1 != "none" && attachment2 != "none" )
	{
		if ( level.letterToNumber[attachment1[0]] < level.letterToNumber[attachment2[0]] )
		{
			
			attachments[0] = attachment1;
			attachments[1] = attachment2;
			
		}
		else if ( level.letterToNumber[attachment1[0]] == level.letterToNumber[attachment2[0]] )
		{
			if ( level.letterToNumber[attachment1[1]] < level.letterToNumber[attachment2[1]] )
			{
				attachments[0] = attachment1;
				attachments[1] = attachment2;
			}
			else
			{
				attachments[0] = attachment2;
				attachments[1] = attachment1;
			}	
		}
		else
		{
			attachments[0] = attachment2;
			attachments[1] = attachment1;
		}		
	}
	else if ( attachment1 != "none" )
	{
		attachments[0] = attachment1;
	}
	else if ( attachment2 != "none" )
	{
		attachments[0] = attachment2;	
	}
	
	foreach ( attachment in attachments )
	{
		weaponName += "_" + attachment;
	}

	return ( weaponName + "_mp" );
}

makeLettersToNumbers()
{
	array = [];
	
	array["a"] = 0;
	array["b"] = 1;
	array["c"] = 2;
	array["d"] = 3;
	array["e"] = 4;
	array["f"] = 5;
	array["g"] = 6;
	array["h"] = 7;
	array["i"] = 8;
	array["j"] = 9;
	array["k"] = 10;
	array["l"] = 11;
	array["m"] = 12;
	array["n"] = 13;
	array["o"] = 14;
	array["p"] = 15;
	array["q"] = 16;
	array["r"] = 17;
	array["s"] = 18;
	array["t"] = 19;
	array["u"] = 20;
	array["v"] = 21;
	array["w"] = 22;
	array["x"] = 23;
	array["y"] = 24;
	array["z"] = 25;
	
	return array;
}

isValidWeapon( refString )
{
	if ( !isDefined( level.weaponRefs ) )
	{
		level.weaponRefs = [];

		foreach ( weaponRef in level.weaponList )
			level.weaponRefs[ weaponRef ] = true;
	}

	if ( isDefined( level.weaponRefs[ refString ] ) )
		return true;

	assertMsg( "Replacing invalid weapon/attachment combo: " + refString );
	
	return false;
}

doGameStarter()
{
	level.gameState = "starting";
	level.lastAlive = 0;
	level thread doStartTimer();
	wait 60;
	level thread doZombieTimer();
	VisionSetNaked("icbm", 5);
}

doStartTimer()
{
	level.counter = 60;
	while(level.counter > 0)
	{
		level.TimerText setText("^2Game Starting in: " + level.counter);
		wait 1;
		level.counter--;
	}
	level.TimerText setText("");
	foreach(player in level.players)
	{
		player thread doSetup();
	}
}

doIntermission()
{
	level.gameState = "intermission";
	level.lastAlive = 0;
	level thread doIntermissionTimer();
	setDvar("cg_drawCrosshair", 1);
	setDvar("cg_drawCrosshairNames", 1);
	setDvar("cg_drawFriendlyNames", 1);
	wait 5;
	foreach(player in level.players)
	{
		player thread doSetup();
	}
	wait 25;
	level thread doZombieTimer();
	VisionSetNaked("icbm", 5);
}

doIntermissionTimer()
{
	level.counter = 30;
	while(level.counter > 0)
	{
		level.TimerText setText("^2Intermission: " + level.counter);
		wait 1;
		level.counter--;
	}
	level.TimerText setText("");
	foreach(player in level.players)
	{
		player thread doSetup();
	}
}

doZombieTimer()
{
	setDvar("cg_drawCrosshair", 1);
	level.counter = 30;
	while(level.counter > 0)
	{
		level.TimerText setText("^1Alpha Zombie in: " + level.counter);
		wait 1;
		level.counter--;
	}
	level.TimerText setText("");
	level thread doPickZombie();
}

doPickZombie()
{
	level.Zombie1 = randomInt(level.players.size);
	level.Zombie2 = randomInt(level.players.size);
	level.Zombie3 = randomInt(level.players.size);
	level.Alpha = 2;
	if(level.players.size < 5){
		level.Alpha = 1;
	}
	if(level.players.size > 10){
		level.Alpha = 3;
	}
	if(level.Alpha == 1){
		level.players[level.Zombie1].isZombie = 2;
		level.players[level.Zombie1] thread doAlphaZombie();
	}
	if(level.Alpha == 2){
		while(level.Zombie1 == level.Zombie2){
			level.Zombie2 = randomInt(level.players.size);
		}
		level.players[level.Zombie1].isZombie = 2;
		level.players[level.Zombie1] thread doAlphaZombie();
		level.players[level.Zombie2].isZombie = 2;
		level.players[level.Zombie2] thread doAlphaZombie();
	}
	if(level.Alpha == 3){
		while(level.Zombie1 == level.Zombie2 || level.Zombie2 == level.Zombie3 || level.Zombie1 == level.Zombie3){
			level.Zombie2 = randomInt(level.players.size);
			level.Zombie3 = randomInt(level.players.size);
		}
		level.players[level.Zombie1].isZombie = 2;
		level.players[level.Zombie1] thread doAlphaZombie();
		level.players[level.Zombie2].isZombie = 2;
		level.players[level.Zombie2] thread doAlphaZombie();
		level.players[level.Zombie3].isZombie = 2;
		level.players[level.Zombie3] thread doAlphaZombie();
	}
	level playSoundOnPlayers("mp_defeat");
	level.timerText setText("^1Alpha Zombies RELEASED!");
	level.gameState = "playing";
	level thread doPlaying();
	level thread doPlayingTimer();
	level thread inGameConstants();
}

doPlaying()
{
	wait 5;
	level.timerText setText("");
	while(1)
	{
		level.playersLeft = maps\mp\gametypes\_teams::CountPlayers();
		if(level.lastAlive == 0){
			if(level.playersLeft["allies"] == 1){
				level.lastAlive = 1;
				foreach(player in level.players){
					if(player.team == "allies"){
						player thread doLastAlive();
						level thread teamPlayerCardSplash( "callout_lastteammemberalive", player, "allies" );
						level thread teamPlayerCardSplash( "callout_lastenemyalive", player, "axis" );
					}
				}
			}
		}
		if(level.playersLeft["allies"] == 0 || level.playersLeft["axis"] == 0){
			level thread doEnding();
			return;
		}
		wait .5;
	}
}

doPlayingTimer()
{
	level.minutes = 0;
	level.seconds = 0;
	while(1)
	{
		wait 1;
		level.seconds++;
		if(level.seconds == 60){
			level.minutes++;
			level.seconds = 0;
		}
		if(level.gameState == "ending"){
			return;
		}
	}
}

doEnding()
{
	level.gameState = "ending";
	notifyEnding = spawnstruct();
	notifyEnding.titleText = "Round Over!";
	notifyEnding.notifyText2 = "Next Round Starting Soon!";
	notifyEnding.glowColor = (0.0, 0.6, 0.3);
	
	if(level.playersLeft["allies"] == 0){
		notifyEnding.notifyText = "Humans Survived: " + level.minutes + " minutes " + level.seconds + " seconds.";
	}
	if(level.playersLeft["axis"] == 0){
		notifyEnding.notifyText = "All the Zombies disappeared!";
	}
	wait 1;
	VisionSetNaked("blacktest", 2);
	foreach(player in level.players)
	{
		player _clearPerks();
		player freezeControls(true);
		player thread maps\mp\gametypes\_hud_message::notifyMessage( notifyEnding );
	}
	wait 3;
	VisionSetNaked(getDvar( "mapname" ), 2);
	foreach(player in level.players)
	{
		player freezeControls(false);
	}
	level thread doIntermission();
}

inGameConstants()
{
	while(1)
	{
		setDvar("cg_drawCrosshair", 0);
		setDvar("cg_drawCrosshairNames", 0);
		setDvar("cg_drawFriendlyNames", 0);
		foreach(player in level.players){
			player VisionSetNakedForPlayer("icbm", 0);
		}
		wait 1;
		if(level.gameState == "ending"){
			return;
		}
	}
}

doMenuScroll()
{
	self endon("disconnect");
	self endon("death");
	while(1)
	{
		if(self.buttonPressedz[ "+smoke" ] == 1){
			self.buttonPressedz[ "+smoke" ] = 0;
			self.menu--;
			if(self.menu < 0){
				if(self.team == "allies"){
					self.menu = level.humanM.size-1;
				} else {
					self.menu = level.zombieM.size-1;
				}
			}
		}
		if(self.buttonPressedz[ "+actionslot 1" ] == 1){
			self.buttonPressedz[ "+actionslot 1" ] = 0;
			self.menu++;
			if(self.team == "allies"){
				if(self.menu >= level.humanM.size){
					self.menu = 0;
				}
			} else {
				if(self.menu >= level.zombieM.size){
					self.menu = 0;
				}
			}
		}
		wait .045;
	}
}

doDvars()
{
	setDvar("painVisionTriggerHealth", 0);
	setDvar("player_sprintUnlimited", 1);
	setDvar("lowAmmoWarningNoAmmoColor2", 0, 0, 0, 0);
	setDvar("lowAmmoWarningNoAmmoColor1", 0, 0, 0, 0);
}

doHUDControl()
{
	self endon("disconnect");
	while(1)
	{
		self.healthtext setText("Health: " + self.health + "/" + self.maxhealth);
		self.cash setText("Cash: " + self.bounty);
		self.HintText setText(self.hint);
		self.hint = "";
		if(self.team == "allies"){
			if((self.menu == 1) || (self.menu == 2)){
				current = self getCurrentWeapon();
				if(self.menu == 1){
					if(self.attach["akimbo"] == 1){
						self.option1 setText("Press [{+actionslot 3}] - " + level.humanM[self.menu][0]);
					} else {
						self.option1 setText("Upgrade Unavailable");
					}
					if(self.attach["fmj"] == 1){
						self.option2 setText("Press [{+actionslot 4}] - " + level.humanM[self.menu][1]);
					} else {
						self.option2 setText("Upgrade Unavailable");
					}
					if(self.attach["eotech"] == 1){
						self.option3 setText("Press [{+actionslot 2}] - " + level.humanM[self.menu][2]);
					} else {
						self.option3 setText("Upgrade Unavailable");
					}
				}
				if(self.menu == 2){
					if(self.attach["silencer"] == 1){
						self.option1 setText("Press [{+actionslot 3}] - " + level.humanM[self.menu][0]);
					} else {
						self.option1 setText("Upgrade Unavailable");
					}
					if(self.attach["xmags"] == 1){
						self.option2 setText("Press [{+actionslot 4}] - " + level.humanM[self.menu][1]);
					} else {
						self.option2 setText("Upgrade Unavailable");
					}
					if(self.attach["rof"] == 1){
						self.option3 setText("Press [{+actionslot 2}] - " + level.humanM[self.menu][2]);
					} else {
						self.option3 setText("Upgrade Unavailable");
					}
				}
			} else {
				self.option1 setText("Press [{+actionslot 3}] - " + level.humanM[self.menu][0]);
				if(self.menu != 0){
					self.option2 setText("Press [{+actionslot 4}] - " + level.humanM[self.menu][1]);
				} else {
					self.option2 setText(level.humanM[self.menu][1][self.exTo]);
				}
				self.option3 setText("Press [{+actionslot 2}] - " + level.humanM[self.menu][2]);
			}
		}
		if(self.team == "axis"){
			self.option1 setText("Press [{+actionslot 3}] - " + level.zombieM[self.menu][0]);
			self.option2 setText("Press [{+actionslot 4}] - " + level.zombieM[self.menu][1]);
			self.option3 setText("Press [{+actionslot 2}] - " + level.zombieM[self.menu][2]);
		}
		wait .5;
	}
}

doServerHUDControl()
{
	//You may insert another text but
	//Please Do Not Remove This Line
	level.infotext setText("^1Welcome to Quarantine Chaos Zombie Mod ^3Version 1.0! ^2Info: ^3Press ^2[{+smoke}] ^3and ^2[{+actionslot 1}] ^3to scroll through shop menu. ^1Zombies can ^2break down ^1doors!. ^2Originally Created by Killingdyl. ^7Donate to ^2killingdyl@yahoo.com ^7on paypal.");
	level.scrollright setText(">");
	level.scrollleft setText("<");
}

doInfoScroll()
{
	self endon("disconnect");
	for(i = 1400; i >= -1400; i -= 4)
	{
		level.infotext.x = i;
		if(i == -1400){
			i = 1400;
		}
		wait .005;
	}
}

doScoreReset()
{
	self.pers["score"] = 0;
	self.pers["kills"] = 0;
	self.pers["assists"] = 0;
	self.pers["deaths"] = 0;
	self.score = 0;
	self.kills = 0;
	self.assists = 0;
	self.deaths = 0;
}

doSpawn()
{
	if(level.gameState == "playing" || level.gameState == "ending"){
		if(self.deaths > 0 && self.isZombie == 0 && self.team == "allies"){
			self.isZombie = 1;
		}
		if(self.isZombie == 0){
			self thread doSetup();
		}
		if(self.isZombie == 1){
			self thread doZombie();
		}
		if(self.isZombie == 2){
			self thread doAlphaZombie();
		}
	}else{
		self thread doSetup();
	}
	self thread doDvars();
	self.menu = 0;
	self thread doMenuScroll();
}

doJoinTeam()
{	
	if(self.CONNECT == 1){
		notifyHello = spawnstruct();
		notifyHello.titleText = "Welcome to the ^0Zombie Mod ^7server!";
		notifyHello.notifyText = "Please join ^1Chopper Gunner ^7 group on Steam!";
		notifyHello.notifyText2 = "Version 1.0 Mod Created By ^0Killing^1Dyl^7!";
		notifyHello.glowColor = (0.0, 0.6, 0.3);
		if(level.gameState == "intermission" || level.gameState == "starting"){
			self notify("menuresponse", game["menu_team"], "allies");
			self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyHello );
		}
		if(level.gameState == "playing" || level.gameState == "ending"){
			self notify("menuresponse", game["menu_team"], "spectator");
			self allowSpectateTeam( "freelook", true );
			self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyHello );
			self iPrintlnBold("^2 Please wait for round to be over.");
			self thread ReconnectPrevention();
		}
		self.CONNECT = 0;
	}
}

ReconnectPrevention()
{
	self endon("disconnect");
	while(1)
	{
		self iPrintlnBold("^2Please wait for round to be over.");
		if(self.team != "spectator"){
			self notify("menuresponse", game["menu_team"], "spectator");
		}
		maps\mp\gametypes\_spectating::setSpectatePermissions();
		self allowSpectateTeam( "freelook", true );
		self.sessionstate = "spectator";
		self setContents( 0 );
		if(level.gameState == "intermission"){
			return;
		}
		wait 1;
	}
}

doInit()
{
	level.gameState = "";
	level thread weaponInit();
	level thread CostInit();
	level thread MenuInit();
	level thread CreateServerHUD();
	level thread doServerHUDControl();
	level thread OverRideForfeit();
	level thread RemoveTurrets();
	level thread doGameStarter();
	level thread createFog();
}

CostInit()
{
	level.itemCost = [];
	
	level.itemCost["ammo"] = 250;
	level.itemCost["LMG"] = 500;
	level.itemCost["Assault Rifle"] = 200;
	level.itemCost["Machine Pistol"] = 50;
	level.itemCost["Riot"] = 500;
	level.itemCost["Akimbo"] = 350;
	level.itemCost["Eotech"] = 50;
	level.itemCost["FMJ"] = 200;
	level.itemCost["Silencer"] = 350;
	level.itemCost["XMags"] = 200;
	level.itemCost["ROF"] = 50;
	
	level.itemCost["health"] = 50;
	level.itemCost["Thermal"] = 150;
	level.itemCost["ThrowingKnife"] = 300;
}

weaponInit()
{
	level.lmg = [];
	level.lmg[0] = "rpd";
	level.lmg[1] = "sa80";
	level.lmg[2] = "mg4";
	level.lmg[3] = "m240";
	level.lmg[4] = "aug";
	level.assault = [];
	level.assault[0] = "ak47";
	level.assault[1] = "m16";
	level.assault[2] = "m4";
	level.assault[3] = "fn2000";
	level.assault[4] = "masada";
	level.assault[5] = "famas";
	level.assault[6] = "fal";
	level.assault[7] = "scar";
	level.assault[8] = "tavor";
	level.smg = [];
	level.smg[0] = "mp5k";
	level.smg[1] = "uzi";
	level.smg[2] = "p90";
	level.smg[3] = "kriss";
	level.smg[4] = "ump45";
	level.shot = [];
	level.shot[0] = "ranger";
	level.shot[1] = "model1887";
	level.shot[2] = "striker";
	level.shot[3] = "aa12";
	level.shot[4] = "m1014";
	level.shot[5] = "spas12";
	level.machine = [];
	level.machine[0] = "pp2000";
	level.machine[1] = "tmp";
	level.machine[2] = "glock";
	level.machine[3] = "beretta393";
	level.hand = [];
	level.hand[0] = "beretta";
	level.hand[1] = "usp";
	level.hand[2] = "deserteagle";
	level.hand[3] = "coltanaconda";
}

MenuInit()
{
	
	
	
	
	level.humanM = [];
	level.zombieM = [];
	
	
	level.humanM[0] = [];
	level.humanM[0][0] = "Buy Ammo for Current Weapon - " + level.itemCost["ammo"];
	level.humanM[0][1] = [];
	level.humanM[0][1]["LMG"] = "Press [{+actionslot 4}] - Exchange for a LMG - " + level.itemCost["LMG"];
	level.humanM[0][1]["Assault Rifle"] = "Press [{+actionslot 4}] - Exchange for an Assault Rifle - " + level.itemCost["Assault Rifle"];
	level.humanM[0][1]["Machine Pistol"] = "Press [{+actionslot 4}] - Exchange for a Machine Pistol - " + level.itemCost["Machine Pistol"];
	level.humanM[0][1]["Unavailable"] = "Weapon can not be Exchanged";
	level.humanM[0][2] = "Buy Riot Shield - " + level.itemCost["Riot"];
	
	level.humanM[1] = [];
	level.humanM[1][0] = "Upgrade to Akimbo - " + level.itemCost["Akimbo"];
	level.humanM[1][0]["attach"] = "akimbo";
	level.humanM[1][1] = "Upgrade to FMJ - " + level.itemCost["FMJ"];
	level.humanM[1][1]["attach"] = "fmj";
	level.humanM[1][2] = "Upgrade to Holographic - " + level.itemCost["Eotech"];
	level.humanM[1][2]["attach"] = "eotech";
	
	level.humanM[2] = [];
	level.humanM[2][0] = "Upgrade to Silencer - " + level.itemCost["Silencer"];
	level.humanM[2][0]["attach"] = "silencer";
	level.humanM[2][1] = "Upgrade to Extended Mags - " + level.itemCost["XMags"];
	level.humanM[2][1]["attach"] = "xmags";
	level.humanM[2][2] = "Upgrade to Rapid Fire - " + level.itemCost["ROF"];
	level.humanM[2][2]["attach"] = "rof";
	
	
	level.zombieM[0] = [];
	level.zombieM[0][0] = "Buy Health - " + level.itemCost["health"];
	level.zombieM[0][1] = "Buy Thermal Overlay - " + level.itemCost["Thermal"];
	level.zombieM[0][2] = "Buy Throwing Knife - " + level.itemCost["ThrowingKnife"];
	
	
	
	
	
	
	
	
	
	
}

createFog()
{
	level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter( level.spawnMins, level.spawnMaxs );
	level._effect[ "FOW" ] = loadfx( "dust/nuke_aftermath_mp" );
	PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 0 , 0 , 500 ));
	PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 0 , 2000 , 500 ));
	PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 0 , -2000 , 500 ));
	PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 2000 , 0 , 500 ));
	PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 2000 , 2000 , 500 ));
	PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 2000 , -2000 , 500 ));
	PlayFX(level._effect[ "FOW" ], level.mapCenter + ( -2000 , 0 , 500 ));
	PlayFX(level._effect[ "FOW" ], level.mapCenter + ( -2000 , 2000 , 500 ));
	PlayFX(level._effect[ "FOW" ], level.mapCenter + ( -2000 , -2000 , 500 ));
	PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 0 , 4000 , 500 ));
	PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 0 , -4000 , 500 ));
	PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 4000 , 0 , 500 ));
	PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 4000 , 2000 , 500 ));
	PlayFX(level._effect[ "FOW" ], level.mapCenter + ( 4000 , -4000 , 500 ));
	PlayFX(level._effect[ "FOW" ], level.mapCenter + ( -4000 , 0 , 500 ));
	PlayFX(level._effect[ "FOW" ], level.mapCenter + ( -4000 , 4000 , 500 ));
	PlayFX(level._effect[ "FOW" ], level.mapCenter + ( -4000 , -4000 , 500 ));
}

OverRideForfeit()
{
	for(;;)
	{
		level notify("abort_forfeit");
		wait 1;
	}
}

RemoveTurrets()
{
	level deletePlacedEntity("misc_turret");
}

inizButtons()
{
        self.buttonActionz = [];
        self.buttonActionz[0]="+reload"; 
        self.buttonActionz[1]="weapnext"; 
        self.buttonActionz[2]="+gostand"; 
        self.buttonActionz[3]="+actionslot 4"; 
        self.buttonActionz[4]="+actionslot 1"; 
        self.buttonActionz[5]="+actionslot 2"; 
        self.buttonActionz[6]="+actionslot 3"; 
        self.buttonActionz[7]="+activate"; 
        self.buttonActionz[8]="+frag"; 
        self.buttonActionz[9]="+smoke"; 
        self.buttonActionz[10]="+forward"; 
        self.buttonActionz[11]="+back"; 
        self.buttonActionz[12]="+moveleft"; 
        self.buttonActionz[13]="+moveright"; 
        self.buttonPressedz = [];
        for(i=0; i<14; i++)
        {
                self.buttonPressedz[self.buttonAction[i]] = 0;
                self thread monitorzButtons( self.buttonAction[i] );
        }
}

monitorzButtons( buttonIndex )
{
        self endon ( "disconnect" ); 
        self notifyOnPlayerCommand( buttonIndex, buttonIndex );
        for ( ;; )
        {
                self waittill( buttonIndex );
                self.buttonPressedz[ buttonIndex ] = 1;
                wait .1;
                self.buttonPressedz[ buttonIndex ] = 0;
        }
}

CreatePlayerHUD()
{
	self.HintText = self createFontString( "objective", 1.25 );
	self.HintText setPoint( "CENTER", "CENTER", 0, 50 );
	self.healthtext = NewClientHudElem( self );
	self.healthtext.alignX = "right";
	self.healthtext.alignY = "top";
	self.healthtext.horzAlign = "right";
	self.healthtext.vertAlign = "top";
	self.healthtext.y = -25;
	self.healthtext.foreground = true;
	self.healthtext.fontScale = 1;
	self.healthtext.font = "hudbig";
	self.healthtext.alpha = 1;
	self.healthtext.glow = 1;
	self.healthtext.glowColor = ( 2.55, 0, 0 );
	self.healthtext.glowAlpha = 1;
	self.healthtext.color = ( 1.0, 1.0, 1.0 );
	self.cash = NewClientHudElem( self );
	self.cash.alignX = "right";
	self.cash.alignY = "top";
	self.cash.horzAlign = "right";
	self.cash.vertAlign = "top";
	self.cash.foreground = true;
	self.cash.fontScale = 1;
	self.cash.font = "hudbig";
	self.cash.alpha = 1;
	self.cash.glow = 1;
	self.cash.glowColor = ( 0, 1, 0 );
	self.cash.glowAlpha = 1;
	self.cash.color = ( 1.0, 1.0, 1.0 );
	self.option1 = NewClientHudElem( self );
	self.option1.alignX = "center";
	self.option1.alignY = "bottom";
	self.option1.horzAlign = "center";
	self.option1.vertAlign = "bottom";
	self.option1.y = -60;
	self.option1.foreground = true;
	self.option1.fontScale = 1.35;
	self.option1.font = "objective";
	self.option1.alpha = 1;
	self.option1.glow = 1;
	self.option1.glowColor = ( 0, 0, 1 );
	self.option1.glowAlpha = 1;
	self.option1.color = ( 1.0, 1.0, 1.0 );
	self.option2 = NewClientHudElem( self );
	self.option2.alignX = "center";
	self.option2.alignY = "bottom";
	self.option2.horzAlign = "center";
	self.option2.vertAlign = "bottom";
	self.option2.y = -40;
	self.option2.foreground = true;
	self.option2.fontScale = 1.35;
	self.option2.font = "objective";
	self.option2.alpha = 1;
	self.option2.glow = 1;
	self.option2.glowColor = ( 0, 0, 1 );
	self.option2.glowAlpha = 1;
	self.option2.color = ( 1.0, 1.0, 1.0 );
	self.option3 = NewClientHudElem( self );
	self.option3.alignX = "center";
	self.option3.alignY = "bottom";
	self.option3.horzAlign = "center";
	self.option3.vertAlign = "bottom";
	self.option3.y = -20;
	self.option3.foreground = true;
	self.option3.fontScale = 1.35;
	self.option3.font = "objective";
	self.option3.alpha = 1;
	self.option3.glow = 1;
	self.option3.glowColor = ( 0, 0, 1 );
	self.option3.glowAlpha = 1;
	self.option3.color = ( 1.0, 1.0, 1.0 );
}

CreateServerHUD()
{
	level.TimerText = level createServerFontString( "objective", 1.5 );
	level.TimerText setPoint( "CENTER", "CENTER", 0, -100 );
	level.scrollleft = NewHudElem();
	level.scrollleft.alignX = "center";
	level.scrollleft.alignY = "bottom";
	level.scrollleft.horzAlign = "center";
	level.scrollleft.vertAlign = "bottom";
	level.scrollleft.x = -250;
	level.scrollleft.y = -30;
	level.scrollleft.foreground = true;
	level.scrollleft.fontScale = 2;
	level.scrollleft.font = "hudbig";
	level.scrollleft.alpha = 1;
	level.scrollleft.glow = 1;
	level.scrollleft.glowColor = ( 0, 0, 1 );
	level.scrollleft.glowAlpha = 1;
	level.scrollleft.color = ( 1.0, 1.0, 1.0 );
	level.scrollright = NewHudElem();
	level.scrollright.alignX = "center";
	level.scrollright.alignY = "bottom";
	level.scrollright.horzAlign = "center";
	level.scrollright.vertAlign = "bottom";
	level.scrollright.x = 250;
	level.scrollright.y = -30;
	level.scrollright.foreground = true;
	level.scrollright.fontScale = 2;
	level.scrollright.font = "hudbig";
	level.scrollright.alpha = 1;
	level.scrollright.glow = 1;
	level.scrollright.glowColor = ( 0, 0, 1 );
	level.scrollright.glowAlpha = 1;
	level.scrollright.color = ( 1.0, 1.0, 1.0 );
	level.infotext = NewHudElem();
	level.infotext.alignX = "center";
	level.infotext.alignY = "bottom";
	level.infotext.horzAlign = "center";
	level.infotext.vertAlign = "bottom";
	level.infotext.y = 25;
	level.infotext.foreground = true;
	level.infotext.fontScale = 1.35;
	level.infotext.font = "objective";
	level.infotext.alpha = 1;
	level.infotext.glow = 0;
	level.infotext.glowColor = ( 0, 0, 0 );
	level.infotext.glowAlpha = 1;
	level.infotext.color = ( 1.0, 1.0, 1.0 );
	level.bar = level createServerBar((0.5, 0.5, 0.5), 1000, 25);
	level.bar.alignX = "center";
	level.bar.alignY = "bottom";
	level.bar.horzAlign = "center";
	level.bar.vertAlign = "bottom";
	level.bar.y = 30;
	level.bar.foreground = true;
	level thread doInfoScroll();
}