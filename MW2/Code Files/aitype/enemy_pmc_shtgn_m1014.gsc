// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
/*QUAKED actor_enemy_pmc_SHTGN_m1014 (1.0 0.25 0.0) (-16 -16 0) (16 16 72) SPAWNER FORCESPAWN UNDELETABLE PERFECTENEMYINFO DONTSHAREENEMYINFO
defaultmdl="body_airborne_shotgun"
"count" -- max AI to ever spawn from this spawner
SPAWNER -- makes this a spawner instead of a guy
FORCESPAWN -- will try to delete an AI if spawning fails from too many AI
UNDELETABLE -- this AI (or AI spawned from here) cannot be deleted to make room for FORCESPAWN guys
PERFECTENEMYINFO -- this AI when spawned will get a snapshot of perfect info about all enemies
DONTSHAREENEMYINFO -- do not get shared info about enemies at spawn time from teammates
*/
main()
{
	self.animTree = "";
	self.additionalAssets = "";
	self.team = "axis";
	self.type = "human";
	self.subclass = "regular";
	self.accuracy = 0.2;
	self.health = 150;
	self.secondaryweapon = "beretta";
	self.sidearm = "beretta";
	self.grenadeWeapon = "fraggrenade";
	self.grenadeAmmo = 0;

	if ( isAI( self ) )
	{
		self setEngagementMinDist( 0.000000, 0.000000 );
		self setEngagementMaxDist( 280.000000, 400.000000 );
	}

	self.weapon = "m1014";

	switch( codescripts\character::get_random_character(3) )
	{
	case 0:
		character\character_airborne_shotgun::main();
		break;
	case 1:
		character\character_airborne_shotgun_b::main();
		break;
	case 2:
		character\character_airborne_shotgun_c::main();
		break;
	}
}

spawner()
{
	self setspawnerteam("axis");
}

precache()
{
	character\character_airborne_shotgun::precache();
	character\character_airborne_shotgun_b::precache();
	character\character_airborne_shotgun_c::precache();

	precacheItem("m1014");
	precacheItem("beretta");
	precacheItem("beretta");
	precacheItem("fraggrenade");
}
