#include common_scripts\utility;
#include maps\mp\_utility;
init()
{
if ( !GetDvarInt( #"xblive_basictraining" ) )
{
if( !level.console )
{
bot_spawner_Once();
}
return;
}
level.autoassign = ::basic_training_auto_assign;
if ( IsDefined( game[ "bots_spawned" ] ) )
{
return;
}
if ( GetDvarInt( #"party_playerCount" ) >= GetDvarInt( #"bot_enemies" ) + GetDvarInt( #"bot_friends" ) )
{
return;
}
if ( level.teambased )
{
bot_num_friendly = GetDvarInt( #"bot_friends" ) - GetDvarInt( #"party_playerCount" );
bot_num_friendly = clamp( bot_num_friendly, 0, bot_num_friendly );
}
else
{
bot_num_friendly = 0;
}
human_enemies = GetDvarInt( #"party_playerCount" );
if ( level.teambased )
{
human_enemies = GetDvarInt( #"party_playerCount" ) - GetDvarInt( #"bot_friends" );
human_enemies = clamp( human_enemies, 0, human_enemies );
bot_num_enemy = GetDvarInt( #"bot_enemies" ) - human_enemies;
}
else
{
bot_num_enemy = GetDvarInt( #"bot_enemies" ) - human_enemies + 1;
}
if ( bot_num_enemy + bot_num_friendly <= 0 )
{
return;
}
bot_wait_for_host();
player = GetHostPlayer();
if ( GetDvar( #"bot_difficulty" ) == "" )
{
SetDvar( "bot_difficulty", "normal" );
}
bot_set_difficulty( GetDvar( #"bot_difficulty" ) );
team = player.pers[ "team" ];
game[ "bots_spawned" ] = 1;
spawned_bots = 0;
while ( spawned_bots < bot_num_enemy )
{
wait( 0.25 );
bot = AddTestClient();
if ( !IsDefined( bot ) )
{
continue;
}
spawned_bots++;
bot.pers[ "isBot" ] = true;
bot thread bot_spawn_think( getOtherTeam( team ) );
}
spawned_bots = 0;
while ( spawned_bots < bot_num_friendly )
{
wait( 0.25 );
bot = AddTestClient();
if ( !IsDefined( bot ) )
{
continue;
}
spawned_bots++;
bot.pers[ "isBot" ] = true;
bot thread bot_spawn_think( team );
}
}
basic_training_auto_assign()
{
host = GetHostPlayer();
if ( host == self )
{
self maps\mp\gametypes\_globallogic_ui::menuAutoAssign();
return;
}
if ( self is_bot() )
{
if ( !level.teambased )
{
self maps\mp\gametypes\_globallogic_ui::menuAutoAssign();
}
return;
}
bot_wait_for_host();
host = GetHostPlayer();
host_team = host.pers[ "team" ];
player_counts = self maps\mp\gametypes\_teams::CountPlayers();
friends = GetDvarInt( #"bot_friends" ) - player_counts[ host_team ];
if ( friends > 0 )
{
assignment = host_team;
}
else
{
assignment = getOtherTeam( host_team );
}
self.pers["team"] = assignment;
self.team = assignment;
self.pers["class"] = undefined;
self.class = undefined;
self.pers["weapon"] = undefined;
self.pers["savedmodel"] = undefined;
self maps\mp\gametypes\_globallogic_ui::updateObjectiveText();
if ( level.teamBased )
self.sessionteam = assignment;
else
{
self.sessionteam = "none";
self.ffateam = assignment;
}
if ( !isAlive( self ) )
self.statusicon = "hud_status_dead";
self notify("joined_team");
level notify( "joined_team" );
self notify("end_respawn");
if( isPregameGameStarted() )
{
pclass = self GetPregameClass();
if( IsDefined( pclass ) )
{
self closeMenu();
self closeInGameMenu();
self.selectedClass = true;
self [[level.class]](pclass);
return;
}
}
self maps\mp\gametypes\_globallogic_ui::beginClassChoice();
self setclientdvar( "g_scriptMainMenu", game[ "menu_class_" + self.pers["team"] ] );
}
bot_wait_for_host()
{
host = GetHostPlayer();
while ( !IsDefined( host ) )
{
wait( 0.05 );
host = GetHostPlayer();
}
while ( !IsDefined( host.pers[ "team" ] ) )
{
wait( 0.05 );
}
while ( host.pers[ "team" ] != "allies" && host.pers[ "team" ] != "axis" )
{
wait( 0.05 );
}
}
bot_spawn_think( team )
{
self endon( "disconnect" );
while( !IsDefined( self.pers["team"] ) )
{
wait .05;
}
if ( level.teambased )
{
self notify( "menuresponse", game["menu_team"], team );
wait 0.5;
}
self bot_set_rank();
while( 1 )
{
self notify( "menuresponse", "changeclass", "smg_mp" );
self waittill( "spawned_player" );
wait ( 0.10 );
}
}
bot_set_rank()
{
players = get_players();
ranks = [];
bot_ranks = [];
human_ranks = [];
if ( !IsDefined( self.bot ) )
{
self.bot = [];
}
for ( i = 0; i < players.size; i++ )
{
if ( players[i] == self )
continue;
if ( players[i] is_bot() && IsDefined( players[i].bot ) && IsDefined( players[i].bot[ "rank" ] ) )
{
bot_ranks[ bot_ranks.size ] = players[i].bot[ "rank" ];
}
else if ( !players[i] is_bot() && !players[i] isdemoclient() && IsDefined( players[i].pers[ "rank" ] ) )
{
human_ranks[ human_ranks.size ] = players[i].pers[ "rank" ];
}
}
if( !human_ranks.size )
human_ranks[ human_ranks.size ] = 10;
human_avg = array_average( human_ranks );
while ( bot_ranks.size + human_ranks.size < 5 )
{
rank = human_avg + RandomIntRange( -10, 10 );
human_ranks[ human_ranks.size ] = rank;
}
ranks = array_combine( human_ranks, bot_ranks );
avg = array_average( ranks );
s = array_std_deviation( ranks, avg );
rank = Int( random_normal_distribution( avg, s, 0, level.maxRank ) );
self setRank( rank );
self.bot[ "rank" ] = rank;
self.pers[ "rank" ] = rank;
self.pers[ "rankxp" ] = maps\mp\gametypes\_rank::getRankInfoMinXP( rank );
if ( self.kills == 1 )
{
self.kills = 0;
self.pers[ "bot_perk" ] = true;
}
else
{
self.pers[ "bot_perk" ] = false;
}
}
bot_set_difficulty( difficulty )
{
if ( difficulty == "fu" )
{
SetDvar( "sv_botMinDeathTime", "250" );
SetDvar( "sv_botMaxDeathTime", "500" );
SetDvar( "sv_botMinFireTime", "100" );
SetDvar( "sv_botMaxFireTime", "300" );
SetDvar( "sv_botYawSpeed", "14" );
SetDvar( "sv_botYawSpeedAds", "14" );
SetDvar( "sv_botPitchUp", "-5" );
SetDvar( "sv_botPitchDown", "10" );
SetDvar( "sv_botFov", "160" );
SetDvar( "sv_botMinAdsTime", "3000" );
SetDvar( "sv_botMaxAdsTime", "5000" );
SetDvar( "sv_botMinCrouchTime", "100" );
SetDvar( "sv_botMaxCrouchTime", "400" );
SetDvar( "sv_botTargetLeadBias",	"2" );
SetDvar( "sv_botMinReactionTime",	"30" );
SetDvar( "sv_botMaxReactionTime",	"100" );
SetDvar( "sv_botStrafeChance", "1" );
SetDvar( "sv_botMinStrafeTime", "3000" );
SetDvar( "sv_botMaxStrafeTime", "6000" );
SetDvar( "scr_help_dist", "512" );
}
else if ( difficulty == "hard" )
{
SetDvar( "sv_botMinDeathTime", "250" );
SetDvar( "sv_botMaxDeathTime", "500" );
SetDvar( "sv_botMinFireTime", "400" );
SetDvar( "sv_botMaxFireTime", "600" );
SetDvar( "sv_botYawSpeed", "8" );
SetDvar( "sv_botYawSpeedAds", "10" );
SetDvar( "sv_botPitchUp", "-5" );
SetDvar( "sv_botPitchDown", "10" );
SetDvar( "sv_botFov", "100" );
SetDvar( "sv_botMinAdsTime", "3000" );
SetDvar( "sv_botMaxAdsTime", "5000" );
SetDvar( "sv_botMinCrouchTime", "100" );
SetDvar( "sv_botMaxCrouchTime", "400" );
SetDvar( "sv_botTargetLeadBias",	"2" );
SetDvar( "sv_botMinReactionTime",	"400" );
SetDvar( "sv_botMaxReactionTime",	"700" );
SetDvar( "sv_botStrafeChance", "0.9" );
SetDvar( "sv_botMinStrafeTime", "3000" );
SetDvar( "sv_botMaxStrafeTime", "6000" );
SetDvar( "scr_help_dist", "384" );
}
else if ( difficulty == "easy" )
{
SetDvar( "sv_botMinDeathTime", "1000" );
SetDvar( "sv_botMaxDeathTime", "2000" );
SetDvar( "sv_botMinFireTime", "900" );
SetDvar( "sv_botMaxFireTime", "1000" );
SetDvar( "sv_botYawSpeed", "2" );
SetDvar( "sv_botYawSpeedAds", "2.5" );
SetDvar( "sv_botPitchUp", "-20" );
SetDvar( "sv_botPitchDown", "40" );
SetDvar( "sv_botFov", "50" );
SetDvar( "sv_botMinAdsTime", "3000" );
SetDvar( "sv_botMaxAdsTime", "5000" );
SetDvar( "sv_botMinCrouchTime", "4000" );
SetDvar( "sv_botMaxCrouchTime", "6000" );
SetDvar( "sv_botTargetLeadBias",	"8" );
SetDvar( "sv_botMinReactionTime",	"1200" );
SetDvar( "sv_botMaxReactionTime",	"1600" );
SetDvar( "sv_botStrafeChance", "0.1" );
SetDvar( "sv_botMinStrafeTime", "3000" );
SetDvar( "sv_botMaxStrafeTime", "6000" );
SetDvar( "scr_help_dist", "256" );
}
else
{
SetDvar( "sv_botMinDeathTime", "500" );
SetDvar( "sv_botMaxDeathTime", "1000" );
SetDvar( "sv_botMinFireTime", "600" );
SetDvar( "sv_botMaxFireTime", "800" );
SetDvar( "sv_botYawSpeed", "4" );
SetDvar( "sv_botYawSpeedAds", "5" );
SetDvar( "sv_botPitchUp", "-10" );
SetDvar( "sv_botPitchDown", "20" );
SetDvar( "sv_botFov", "70" );
SetDvar( "sv_botMinAdsTime", "3000" );
SetDvar( "sv_botMaxAdsTime", "5000" );
SetDvar( "sv_botMinCrouchTime", "2000" );
SetDvar( "sv_botMaxCrouchTime", "4000" );
SetDvar( "sv_botTargetLeadBias",	"4" );
SetDvar( "sv_botMinReactionTime",	"800" );
SetDvar( "sv_botMaxReactionTime",	"1200" );
SetDvar( "sv_botStrafeChance", "0.6" );
SetDvar( "sv_botMinStrafeTime", "3000" );
SetDvar( "sv_botMaxStrafeTime", "6000" );
SetDvar( "scr_help_dist", "256" );
}
}
bot_give_loadout()
{
if ( !IsDefined( self.bot ) )
{
self.bot = [];
}
if ( !IsDefined( self.bot[ "rank" ] ) )
{
self bot_set_rank();
}
self bot_get_cod_points();
playerRenderOptions = self calcPlayerOptions( randomint(5), randomint(5) );
self SetPlayerRenderOptions( int( playerRenderOptions ) );
weaponOptions = self calcWeaponOptions( randomint(5), 0, 0, 0, 0 );
if ( GetDvarInt( #"scr_botsHasPlayerWeapon" ) )
{
player = maps\mp\_utility::get_players()[0];
weapon = player GetCurrentWeapon();
reference = bot_weapon_reference_from_weapon( weapon );
self.bot[ "primary" ] = weapon;
self GiveWeapon( weapon );
self GiveStartAmmo( weapon );
primarygrenade = player getcurrentoffhand();
self.bot[ "primarygrenade" ] = primarygrenade;
self GiveWeapon( primarygrenade );
self GiveStartAmmo( primarygrenade );
self SwitchToOffhand( self.bot[ "primarygrenade" ] );
player_class = player.pers["class"];
if( isSubstr( player_class, "CLASS_CUSTOM" ) || isSubstr(player_class, "CLASS_PRESTIGE") )
{
specialgrenade = player.custom_class[player.class_num]["specialgrenades"];
}
else
{
specialgrenade = level.classGrenades[player_class]["secondary"]["type"];
}
self.bot[ "specialgrenade" ] = specialgrenade;
self GiveWeapon( specialgrenade );
self GiveStartAmmo( specialgrenade );
self SetOffhandSecondaryClass( self.bot[ "specialgrenade" ] );
}
else
{
reference = self bot_give_random_weapon( "primary", int( weaponOptions ) );
self bot_give_random_weapon( "secondary", 0 );
self bot_give_random_weapon( "primarygrenade", 0 );
self SwitchToOffhand( self.bot[ "primarygrenade" ] );
self bot_give_random_weapon( "specialgrenade", 0 );
self SetOffhandSecondaryClass( self.bot[ "specialgrenade" ] );
}
self bot_giveKillStreaks();
self.pers[ "primaryWeapon" ] = reference;
if ( GetDvarInt( #"sv_botsForceFragOnly" ) )
{
self TakeWeapon( self.bot[ "primary" ] );
if ( IsDefined(self.bot[ "secondary" ] ) )
{
self TakeWeapon( self.bot[ "secondary" ] );
}
self TakeWeapon( self.bot[ "specialgrenade" ] );
}
else if ( GetDvarInt( #"sv_botsForceSpecialOnly" ) )
{
self TakeWeapon( self.bot[ "primary" ] );
if ( IsDefined(self.bot[ "secondary" ] ) )
{
self TakeWeapon( self.bot[ "secondary" ] );
}
self TakeWeapon( self.bot[ "primarygrenade" ] );
}
else
{
self SetSpawnWeapon( self.bot[ "primary" ] );
}
self bot_give_random_armor();
if ( GetDvarInt( #"scr_game_perks" ) != 0 )
{
self ClearPerks();
self bot_give_random_perk( "specialty2" );
self bot_give_random_perk( "specialty3" );
}
self thread bot_revive_think();
self thread bot_crate_think();
self thread bot_turret_think();
self thread bot_killstreak_think();
self thread bot_dogs_think();
self thread bot_vehicle_think();
}
bot_giveKillstreaks()
{
if ( !isDefined( self.killstreak ) || !isDefined( self.killstreak[ 0 ] ) || !isDefined( self.killstreak[ 1 ] ) || !isDefined( self.killstreak[ 2 ] ) )
{
bot_setKillstreaks();
}
assert( isDefined( self.killstreak[ 0 ] ) && isDefined( self.killstreak[ 1 ] ) && isDefined( self.killstreak[ 2 ] ) );
}
bot_setKillstreaks()
{
self.killstreak = [];
allowed_killstreaks = [];
allowed_killstreaks[ 0 ] = "killstreak_spyplane";
allowed_killstreaks[ 1 ] = "killstreak_helicopter_comlink";
allowed_killstreaks[ 2 ] = "killstreak_napalm";
allowed_killstreaks[ 3 ] = "killstreak_counteruav";
if ( self.bot[ "rank" ] >= 9 )
{
allowed_killstreaks[ 4 ] = "killstreak_mortar";
allowed_killstreaks[ 5 ] = "killstreak_spyplane_direction";
allowed_killstreaks[ 6 ] = "killstreak_airstrike";
allowed_killstreaks[ 7 ] = "killstreak_dogs";
}
self.killstreak[ 0 ] = level.tbl_KillStreakData[ level.killStreakBaseValue ][ "reference" ];
self.killstreak[ 1 ] = level.tbl_KillStreakData[ level.killStreakBaseValue ][ "reference" ];
self.killstreak[ 2 ] = level.tbl_KillStreakData[ level.killStreakBaseValue ][ "reference" ];
if( getDvarInt( "custom_killstreak_mode" ) == 1 )
return;
if( getDvarInt( "custom_killstreak_mode" ) == 2 )
{
if( getDvarInt( "custom_killstreak_1_kills" ) )
{
self.killstreak[ 0 ] = level.tbl_KillStreakData[ getDvarInt( "custom_killstreak_1" ) ][ "reference" ];
}
if( getDvarInt( "custom_killstreak_2_kills" ) )
{
self.killstreak[ 1 ] = level.tbl_KillStreakData[ getDvarInt( "custom_killstreak_2" ) ][ "reference" ];
}
if( getDvarInt( "custom_killstreak_3_kills" ) )
{
self.killstreak[ 2 ] = level.tbl_KillStreakData[ getDvarInt( "custom_killstreak_3" ) ][ "reference" ];
}
}
else
{
for ( i = 0; i < 3; i++ )
{
index = RandomIntRange( 0, allowed_killstreaks.size );
self.killstreak[ i ] = allowed_killstreaks[ index ];
allowed_killstreaks = array_remove( allowed_killstreaks, self.killstreak[ i ] );
}
}
}
bot_give_random_weapon( slot, weaponOptions )
{
rank = self.bot[ "rank" ];
for ( ;; )
{
id = random( level.tbl_weaponIDs );
if ( id[ "slot" ] != slot )
continue;
if ( id[ "reference" ] == "weapon_null" )
continue;
if ( id[ "cost" ] == "-1" )
continue;
if ( id[ "classified" ] != 0 )
{
if ( !bot_weapon_classified_unlocked( id, rank ) )
{
continue;
}
}
if ( id[ "unlock_level" ] == "" )
{
if ( !bot_weapon_dual_wield_unlocked( id[ "reference" ], rank ) )
{
continue;
}
}
unlock = Int( id[ "unlock_level" ] );
if ( unlock > 3 && unlock > rank )
continue;
if ( id[ "unlock_level" ] != "" && id[ "attachment" ] != "" && RandomFloatRange( 0, 1 ) < ( rank / level.maxRank ) )
{
base_weapon = bot_give_random_attachment( id[ "reference" ], id[ "attachment" ] );
}
else
{
base_weapon = id[ "reference" ];
}
weapon = base_weapon + "_mp";
self.bot[ slot ] = weapon;
self GiveWeapon( weapon, 0, weaponOptions );
self GiveStartAmmo( weapon );
return base_weapon;
}
}
bot_weapon_dual_wield_unlocked( dw_weapon, rank )
{
if ( RandomInt( 100 ) > 20 )
{
return false;
}
base_weapon = StrTok( dw_weapon, "dw" );
if ( !IsDefined( base_weapon ) || base_weapon.size == 0 )
{
return false;
}
base_weapon = base_weapon[0];
if ( !IsDefined( base_weapon ) || base_weapon == "" )
{
return false;
}
unlock = 999;
for ( i = 0; i < level.tbl_weaponIDs.size; i++ )
{
id = level.tbl_weaponIDs[i];
if ( !IsDefined( id ) )
{
continue;
}
if ( base_weapon == id[ "reference" ] )
{
if ( id[ "classified" ] != 0 )
{
if ( !bot_weapon_classified_unlocked( id, rank ) )
{
return false;
}
}
unlock = Int( id[ "unlock_level" ] );
break;
}
}
return ( unlock <= rank );
}
bot_weapon_classified_unlocked( id, rank )
{
unlock = 999;
switch( id[ "group" ] )
{
case "weapon_pistol":
unlock = 17;
break;
case "weapon_smg":
unlock = 40;
break;
case "weapon_assault":
unlock = 43;
break;
case "weapon_lmg":
unlock = 20;
break;
case "weapon_sniper":
unlock = 26;
break;
case "weapon_cqb":
unlock = 23;
break;
}
return ( unlock <= rank );
}
bot_give_random_attachment( weapon, attachments )
{
attachments = StrTok( attachments, " " );
attachments = array_remove( attachments, "dw" );
if ( attachments.size <= 0 )
{
return ( weapon );
}
attachment = random( attachments );
if ( attachment == "" )
{
return ( weapon );
}
return ( weapon + "_" + attachment );
}
bot_give_random_armor()
{
if ( self bot_has_perk( "specialty_noname" ) )
{
self.cac_body_type = "hardened_mp";
playerRenderOptions = self calcPlayerOptions( 0, 0 );
self SetPlayerRenderOptions( int( playerRenderOptions ) );
self.bot[ "cod_points" ] = 500000;
}
else
{
keys = GetArrayKeys( level.cac_functions[ "set_body_model" ] );
self.cac_body_type = random( keys );
if ( game[ "cac_faction_allies" ] == "cub_rebels" && self.pers[ "team" ] == "allies" )
{
while ( self.cac_body_type == "hardened_mp" )
{
self.cac_body_type = random( keys );
}
}
}
self.cac_head_type = self maps\mp\gametypes\_armor::get_default_head();
self.cac_hat_type = "none";
self maps\mp\gametypes\_armor::set_player_model();
self bot_give_body_perk();
}
bot_give_random_perk( slot )
{
for ( ;; )
{
id = random( level.allowedPerks[0] );
id = level.tbl_PerkData[ id ];
if ( id[ "reference" ] == "specialty_null" )
continue;
if ( id[ "slot" ] != slot )
continue;
cost = Int( id[ "cost" ] );
if ( cost > self.bot[ "cod_points" ] )
continue;
self.bot[ "cod_points" ] = self.bot[ "cod_points" ] - cost;
self.bot[ slot ] = id[ "reference_full" ];
perks = StrTok( id[ "reference" ], "|" );
for ( i = 0; i < perks.size; i++ )
{
self SetPerk( perks[i] );
}
return;
}
}
bot_give_body_perk()
{
reference_full = "";
pro_cost = 3000;
switch( self.cac_body_type )
{
case "camo_mp":
reference_full = "perk_ghost";
break;
case "hardened_mp":
reference_full = "perk_hardline";
break;
case "ordnance_disposal_mp":
reference_full = "perk_flak_jacket";
break;
case "utility_mp":
reference_full = "perk_scavenger";
break;
case "standard_mp":
default:
reference_full = "perk_lightweight";
break;
}
if ( self.bot[ "cod_points" ] >= pro_cost )
{
self.bot[ "cod_points" ] = self.bot[ "cod_points" ] - pro_cost;
reference_full = reference_full + "_pro";
}
id = bot_perk_from_reference_full( reference_full );
if ( !IsDefined( id ) )
{
return;
}
self.bot[ "specialty1" ] = id[ "reference_full" ];
perks = StrTok( id[ "reference" ], "|" );
for ( i = 0; i < perks.size; i++ )
{
self SetPerk( perks[i] );
}
}
bot_perk_from_reference_full( reference_full )
{
keys = GetArrayKeys( level.tbl_PerkData );
for ( i = keys.size - 1; i >= 0; i-- )
{
key = keys[i];
if ( level.tbl_PerkData[ key ][ "reference_full" ] == reference_full )
{
return level.tbl_PerkData[ key ];
}
}
return undefined;
}
bot_weapon_reference_from_weapon( weapon )
{
toks = StrTok( weapon, "_" );
reference = toks[0];
for ( i = 1; i < toks.size - 1; i++ )
{
reference = reference + "_" + toks[i];
}
return reference;
}
bot_get_cod_points()
{
players = get_players();
total_points = [];
for ( i = 0; i < players.size; i++ )
{
if ( players[i] is_bot() )
{
continue;
}
total_points[ total_points.size ] = players[i].pers["currencyspent"] + players[i].pers["codpoints"];
}
if( !total_points.size )
total_points[ total_points.size ] = 10000;
point_average = array_average( total_points );
self.bot[ "cod_points" ] = Int( point_average * RandomFloatRange( 0.6, 0.8 ) );
}
bot_clone_loadout( player )
{
self.bot[ "primary" ] = player.bot[ "primary" ];
self GiveWeapon( self.bot[ "primary" ] );
self GiveStartAmmo( self.bot[ "primary" ] );
self SetSpawnWeapon( self.bot[ "primary" ] );
reference = bot_weapon_reference_from_weapon( self.bot[ "primary" ] );
self.pers[ "primaryWeapon" ] = reference;
self.bot[ "secondary" ] = player.bot[ "secondary" ];
self GiveWeapon( self.bot[ "secondary" ] );
self GiveStartAmmo( self.bot[ "secondary" ] );
self.bot[ "primarygrenade" ] = player.bot[ "primarygrenade" ];
self GiveWeapon( self.bot[ "primarygrenade" ] );
self GiveStartAmmo( self.bot[ "primarygrenade" ] );
self SwitchToOffhand( self.bot[ "primarygrenade" ] );
self.bot[ "specialgrenade" ] = player.bot[ "specialgrenade" ];
self GiveWeapon( self.bot[ "specialgrenade" ] );
self GiveStartAmmo( self.bot[ "specialgrenade" ] );
self SetOffhandSecondaryClass( self.bot[ "specialgrenade" ] );
self.cac_faction = player.cac_faction;
self.cac_body_type = player.cac_body_type;
self.cac_head_type = player.cac_head_type;
self.cac_hat_type = player.cac_hat_type;
self maps\mp\gametypes\_armor::set_player_model();
}
bot_damage_callback( eAttacker, iDamage, sMeansOfDeath, sWeapon, eInflictor, sHitLoc )
{
if ( !IsDefined( self ) || !IsAlive( self ) )
{
return;
}
if ( !self is_bot() )
{
return;
}
if ( sMeansOfDeath == "MOD_FALLING" || sMeansOfDeath == "MOD_SUICIDE" )
{
return;
}
if ( !IsDefined( eInflictor ) && !IsDefined( eAttacker ) )
{
return;
}
if ( !IsDefined( eInflictor ) )
{
eInflictor = eAttacker;
}
if ( eInflictor.classname == "script_vehicle" )
{
return;
}
if ( IsDefined( eInflictor.classname ) && eInflictor.classname == "auto_turret" )
{
eAttacker = eInflictor;
}
if ( IsDefined( eAttacker ) )
{
self bot_cry_for_help( eAttacker );
self SetAttacker( eAttacker );
}
}
bot_cry_for_help( attacker )
{
if ( !level.teamBased )
{
return;
}
if ( level.teamBased && IsDefined( attacker.team ) )
{
if ( attacker.team == self.team )
{
return;
}
}
if ( IsDefined( self.help_time ) && GetTime() - self.help_time < 1000 )
{
return;
}
self.help_time = GetTime();
players = get_players();
dist = GetDvarInt( #"scr_help_dist" );
for ( i = 0; i < players.size; i++ )
{
player = players[i];
if ( !player is_bot() )
{
continue;
}
if ( !IsAlive( player ) )
{
continue;
}
if ( player == self )
{
continue;
}
if ( player.team != self.team )
{
continue;
}
if ( DistanceSquared( self.origin, player.origin ) > dist * dist )
{
continue;
}
if ( RandomInt( 100 ) < 50 )
{
player thread bot_find_attacker( attacker );
if ( RandomInt( 100 ) > 70 )
{
break;
}
}
}
}
bot_find_attacker( attacker )
{
self endon( "death" );
self endon( "disconnect" );
if ( !IsDefined( attacker ) || !IsAlive( attacker ) )
{
return;
}
if ( attacker.classname == "auto_turret" )
{
self SetScriptEnemy( attacker );
self thread turret_path_monitor( attacker );
return;
}
dir = VectorNormalize( attacker.origin - self.origin );
dir = vector_scale( dir, 128 );
goal = self.origin + dir;
goal = ( goal[0], goal[1], self.origin[2] + 50 );
self SetScriptGoal( goal, 128 );
wait( 1 );
self ClearScriptGoal();
}
bot_revive_think()
{
self endon( "death" );
self endon( "disconnect" );
if ( self bot_has_perk( "specialty_noname" ) )
{
self SetPerk( "specialty_killstreak" );
self SetPerk( "specialty_fastreload" );
self SetPerk( "specialty_fastads" );
self SetPerk( "specialty_gpsjammer" );
}
if ( !level.teamBased )
{
return;
}
for ( ;; )
{
wait( randomintrange( 3, 5 ) );
players = get_players();
for ( i = 0; i < players.size; i++ )
{
player = players[i];
if ( player == self )
{
continue;
}
if ( !IsAlive( player ) )
{
continue;
}
if ( player.team != self.team )
{
continue;
}
if ( !IsDefined( player.revivetrigger ) )
{
player.bots = 0;
continue;
}
if ( !IsDefined( player.bots ) )
{
player.bots = 0;
}
if ( player.bots >= 1 )
{
continue;
}
if ( DistanceSquared( self.origin, player.origin ) < 2048 * 2048 )
{
self SetScriptGoal( player.origin, 32 );
player.bots++;
self waittill_any( "goal", "bad_path" );
if ( IsDefined( player ) && IsDefined( player.revivetrigger ) && self IsTouching( player.revivetrigger ) )
{
self PressUseButton( GetDvarInt( #"revive_time_taken" ) + 1 );
wait( GetDvarInt( #"revive_time_taken" ) + 1.5 );
}
self ClearScriptGoal();
break;
}
}
}
}
bot_crate_think()
{
self endon( "death" );
self endon( "disconnect" );
myteam = self.pers[ "team" ];
for ( ;; )
{
wait( randomintrange( 3, 5 ) );
crates = GetEntArray( "care_package", "script_noteworthy" );
if ( crates.size == 0 )
{
continue;
}
crate = random( crates );
if ( IsDefined( crate.droppingToGround ) )
{
continue;
}
if ( !IsDefined( crate.bots ) )
{
crate.bots = 0;
}
if ( crate.bots >= 1 )
{
continue;
}
if ( level.teambased && IsDefined( crate.owner ) )
{
if ( myteam == crate.owner.team )
{
if ( RandomInt( 100 ) > 30 )
{
continue;
}
}
}
if ( DistanceSquared( self.origin, crate.origin ) > 2048 * 2048 )
{
continue;
}
origin = ( crate.origin[0], crate.origin[1], crate.origin[2] + 12 );
self SetScriptGoal( origin, 64 );
crate.bots++;
self thread crate_path_monitor( crate );
crate thread crate_death_monitor( self );
path = self waittill_any_return( "goal", "bad_path" );
if ( path == "bad_path" )
{
if ( IsDefined( crate ) )
{
crate.bots--;
}
self ClearScriptGoal();
continue;
}
self PressUseButton( level.crateNonOwnerUseTime / 1000 + 1 );
wait( level.crateNonOwnerUseTime / 1000 + 1.5 );
self ClearScriptGoal();
}
}
crate_death_monitor( bot )
{
self endon( "death" );
bot waittill( "death" );
self.bots--;
}
crate_path_monitor( crate )
{
self endon( "death" );
self endon( "disconnect" );
self endon( "bad_path" );
self endon( "goal" );
crate waittill( "death" );
self notify( "bad_path" );
}
bot_turret_think()
{
self endon( "death" );
self endon( "disconnect" );
myteam = self.pers[ "team" ];
for ( ;; )
{
wait( 1 );
turrets = GetEntArray( "auto_turret", "classname" );
if ( turrets.size == 0 )
{
wait( randomintrange( 3, 5 ) );
continue;
}
turret = Random( turrets );
if ( turret.carried )
{
continue;
}
if ( turret.damageTaken >= turret.health )
{
continue;
}
if ( level.teambased && turret.team == myteam )
{
continue;
}
if ( !BulletTracePassed( self.origin, turret.origin, false, turret ) )
{
continue;
}
if ( !IsDefined( turret.bots ) )
{
turret.bots = 0;
}
if ( turret.bots >= 2 )
{
continue;
}
turret.bots++;
turret thread turret_death_monitor( self );
if ( self HasPerk( "specialty_disarmexplosive" ) )
{
self thread turret_path_monitor( turret );
self SetScriptGoal( turret.origin, 32 );
path = self waittill_any_return( "goal", "bad_path" );
if ( path == "goal" )
{
hackTime = GetDvarFloat( #"perk_disarmExplosiveTime" );
self PressUseButton( hackTime + 0.5 );
wait( hackTime + 0.5 );
self ClearScriptGoal();
continue;
}
}
self SetScriptEnemy( turret );
turret waittill_any( "turret_carried", "turret_deactivated", "death" );
self ClearScriptEnemy();
}
}
bot_killstreak_think()
{
self endon( "death" );
self endon( "disconnect" );
myteam = self.pers[ "team" ];
wait( 1 );
for ( ;; )
{
wait( RandomIntRange( 3, 5 ) );
weapon = self maps\mp\gametypes\_hardpoints::getTopKillstreak();
if ( !IsDefined( weapon ) || weapon == "none" )
{
continue;
}
killstreak = maps\mp\gametypes\_hardpoints::getKillStreakMenuName( weapon );
if ( !IsDefined( killstreak ) )
{
continue;
}
id = self maps\mp\gametypes\_hardpoints::getTopKillstreakUniqueId();
if ( killstreak == "killstreak_tow_turret" )
{
self maps\mp\gametypes\_hardpoints::removeUsedKillstreak( weapon, id );
continue;
}
if ( killstreak == "killstreak_auto_turret" )
{
self maps\mp\gametypes\_hardpoints::removeUsedKillstreak( weapon, id );
continue;
}
if ( !self maps\mp\_killstreakrules::isKillstreakAllowed( weapon, myteam ) )
{
wait( 5 );
continue;
}
switch( killstreak )
{
case "killstreak_helicopter_comlink":
case "killstreak_napalm":
case "killstreak_airstrike":
bot_killstreak_location( 1, weapon );
break;
case "killstreak_mortar":
bot_killstreak_location( 3, weapon );
break;
case "killstreak_supply_drop":
case "killstreak_rcbomb":
case "killstreak_auto_turret_drop":
case "killstreak_tow_turret_drop":
case "killstreak_helicopter_gunner":
case "killstreak_helicopter_player_firstperson":
self maps\mp\gametypes\_hardpoints::removeUsedKillstreak( weapon, id );
break;
case "killstreak_spyplane":
case "killstreak_counteruav":
case "killstreak_dogs":
case "killstreak_spyplane_direction":
default:
self SwitchToWeapon( weapon );
self waittill( "weapon_change" );
break;
}
wait( 0.05 );
if ( self GetCurrentWeapon() == weapon )
{
self SwitchToWeapon( self.lastNonKillstreakWeapon );
}
}
}
bot_killstreak_location( num, weapon )
{
self SwitchToWeapon( weapon );
self waittill( "weapon_change" );
self freeze_player_controls( true );
wait_time = 1;
while ( !IsDefined( self.selectingLocation ) || self.selectingLocation == false )
{
wait( 0.05 );
wait_time -= 0.05;
if ( wait_time <= 0 )
{
self freeze_player_controls( false );
self SwitchToWeapon( self.lastNonKillstreakWeapon );
return;
}
}
wait( 2 );
myteam = self.pers[ "team" ];
for ( i = 0; i < num; i++ )
{
wait( 0.05 );
player = Random( get_players() );
if ( player.sessionstate != "playing" )
{
i--;
continue;
}
if ( player == self )
{
i--;
continue;
}
if ( level.teambased )
{
if ( myteam == player.team )
{
i--;
continue;
}
}
x = RandomIntRange( -512, 512 );
y = RandomIntRange( -512, 512 );
origin = player.origin;
origin = origin + ( x, y, 0 );
yaw = RandomIntRange( 0, 360 );
wait( 0.25 );
self notify( "confirm_location", origin, yaw );
}
self freeze_player_controls( false );
}
bot_dogs_think()
{
self endon( "death" );
self endon( "disconnect" );
myteam = self.pers[ "team" ];
if ( level.no_dogs )
{
return;
}
for ( ;; )
{
wait( 1 );
if ( !IsDefined( level.dogs ) || level.dogs.size <= 0 )
{
level waittill( "called_in_the_dogs" );
}
for ( i = 0; i < level.dogs.size; i++ )
{
dog = level.dogs[i];
if ( !IsDefined( dog ) )
{
continue;
}
if ( !IsAlive( dog ) )
{
continue;
}
if ( level.teamBased )
{
if ( dog.aiteam == myteam )
{
continue;
}
}
if ( dog.script_owner == self )
{
continue;
}
if ( DistanceSquared( self.origin, dog.origin ) < ( 1024 * 1024 ) )
{
self SetScriptEnemy( dog );
break;
}
}
}
}
bot_vehicle_think()
{
self endon( "death" );
self endon( "disconnect" );
if ( GetDvar( #"bot_difficulty" ) == "easy" )
{
return;
}
myteam = self.pers[ "team" ];
for ( ;; )
{
wait( 1 );
airborne_enemies = GetEntArray( "script_vehicle", "classname" );
if ( !IsDefined( airborne_enemies ) || airborne_enemies.size <= 0 )
{
wait( RandomIntRange( 3, 5 ) );
continue;
}
for ( i = 0; i < airborne_enemies.size; i++ )
{
enemy = airborne_enemies[i];
if ( !IsDefined( enemy ) )
{
continue;
}
if ( !IsAlive( enemy ) )
{
continue;
}
if ( level.teamBased )
{
if ( enemy.team == myteam )
{
continue;
}
}
if ( enemy.owner == self )
{
continue;
}
if ( !IsDefined( enemy.targetname ) || enemy.targetname != "rcbomb" )
{
if ( !self bot_vehicle_weapon() )
{
continue;
}
}
if ( !BulletTracePassed( self.origin, enemy.origin, false, enemy ) )
{
continue;
}
self SetScriptEnemy( enemy );
wait( RandomIntRange( 7, 10 ) );
self ClearScriptEnemy();
break;
}
}
}
bot_vehicle_weapon()
{
weapons = [];
weapons[0] = "m72_law_mp";
weapons[1] = "strela_mp";
weapons[2] = "m202_flash_mp";
weapons[3] = "minigun_mp";
weapons[4] = "rpg_mp";
for ( i = 0; i < weapons.size; i++ )
{
if ( self HasWeapon( weapons[i] ) && self bot_vehicle_weapon_ammo( weapons[i] ) > 0 )
{
return true;
}
}
return false;
}
bot_vehicle_weapon_ammo( weapon )
{
return ( self GetWeaponAmmoClip( weapon ) + self GetWeaponAmmoStock( weapon ) );
}
turret_path_monitor( turret )
{
self endon( "death" );
self endon( "disconnect" );
self endon( "bad_path" );
turret waittill_any( "death", "hacked", "turret_deactivated" );
self ClearScriptGoal();
self ClearScriptEnemy();
}
turret_death_monitor( bot )
{
self endon( "death" );
bot waittill( "death" );
self.bots--;
}
bot_has_perk( perk )
{
return ( game[ "cac_faction_allies" ] == "cub_rebels" && self.team == "allies" && self.pers[ "bot_perk" ] );
}
bot_spawner_Once()
{
if ( !GetDvarInt( #"scr_bots_managed_spawn" ) )
{
SetDvar( "scr_bots_managed_spawn", 0 );
}
if ( !GetDvarInt( #"scr_bots_managed_all" ) )
{
SetDvar( "scr_bots_managed_all", 0 );
}
if ( !GetDvarInt( #"scr_bots_managed_axis" ) )
{
SetDvar( "scr_bots_managed_axis", 0 );
}
if ( !GetDvarInt( #"scr_bots_managed_allied" ) )
{
SetDvar( "scr_bots_managed_allied", 0 );
}
if ( GetDvar( #"scr_bot_difficulty" ) == "" )
{
SetDvar( "scr_bot_difficulty", "normal" );
}
bot_set_difficulty( GetDvar( #"scr_bot_difficulty" ) );
level thread bot_spawner_think();
}
bot_spawner_think()
{
level endon ( "game_ended" );
wait( 0.5 );
for( ;; )
{
wait 10.0;
if ( game["state"] == "postgame" )
return;
if( !GetDvarInt( #"scr_bots_managed_spawn" ) )
continue;
humans = 0;
players = level.players;
for ( i = 0; i < players.size; i++ )
{
player = players[i];
if( player is_bot() || player isdemoclient() )
continue;
humans++;
break;
}
countAllies = 0;
countAxis = 0;
if( IsDefined( level.botsCount["axis"] ) )
countAxis = level.botsCount["axis"];
if( IsDefined( level.botsCount["allies"] ) )
countAllies = level.botsCount["allies"];
num = GetDvarInt( #"scr_bots_managed_all" );
if ( num > 0 )
{
axis_num = Ceil( num / 2 );
allies_num = Floor( num / 2 );
}
else
{
axis_num = GetDvarInt( #"scr_bots_managed_axis" );
allies_num = GetDvarInt( #"scr_bots_managed_allies" );
}
if( !humans )
{
players = level.players;
for ( i = 0; i < players.size; i++ )
{
player = players[i];
if( !IsDefined( player.pers[ "isBot" ] ) )
continue;
kick( player getEntityNumber() );
wait(0.25);
}
}
differenceAxis = axis_num - countAxis;
differenceAllies = allies_num - countAllies;
if( differenceAxis == 0 && differenceAllies == 0 )
{
continue;
}
if( differenceAxis < 0 )
{
players = level.players;
for ( i = 0; i < players.size; i++ )
{
if( differenceAxis >= 0 )
break;
player = players[i];
if( !IsDefined( player.pers[ "isBot" ] ) )
continue;
if( "axis" == player.team )
{
kick( player getEntityNumber() );
differenceAxis = differenceAxis + 1;
wait(0.25);
}
}
}
else
{
for( ; differenceAxis > 0; differenceAxis = differenceAxis - 1 )
{
wait( 0.25 );
bot = AddTestClient();
if ( !IsDefined( bot ) )
{
continue;
}
bot.pers[ "isBot" ] = true;
bot thread bot_spawn_think( "axis" );
}
}
if( differenceAllies < 0 )
{
players = level.players;
for ( i = 0; i < players.size; i++ )
{
if( differenceAllies >= 0 )
break;
player = players[i];
if( !IsDefined( player.pers[ "isBot" ] ) )
continue;
if( "allies" == player.team )
{
kick( player getEntityNumber() );
differenceAllies = differenceAllies + 1;
wait(0.25);
}
}
}
else
{
for( ; differenceAllies > 0; differenceAllies = differenceAllies - 1 )
{
wait( 0.25 );
bot = AddTestClient();
if ( !IsDefined( bot ) )
{
continue;
}
bot.pers[ "isBot" ] = true;
bot thread bot_spawn_think( "allies" );
}
}
}
} 