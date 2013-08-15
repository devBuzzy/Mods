#include maps\mp\_utility;
#include common_scripts\utility;
main()
{
maps\mp\mp_array_fx::main();
maps\mp\_load::main();
if ( GetDvarInt( #"xblive_wagermatch" ) == 1 )
{
maps\mp\_compass::setupMiniMap("compass_map_mp_array_wager");
}
else
{
maps\mp\_compass::setupMiniMap("compass_map_mp_array");
}
maps\mp\mp_array_amb::main();
maps\mp\gametypes\_teamset_winterspecops::level_init();
setdvar("compassmaxrange","2100");
game["strings"]["war_callsign_a"] = &"MPUI_CALLSIGN_MAPNAME_A";
game["strings"]["war_callsign_b"] = &"MPUI_CALLSIGN_MAPNAME_B";
game["strings"]["war_callsign_c"] = &"MPUI_CALLSIGN_MAPNAME_C";
game["strings"]["war_callsign_d"] = &"MPUI_CALLSIGN_MAPNAME_D";
game["strings"]["war_callsign_e"] = &"MPUI_CALLSIGN_MAPNAME_E";
game["strings_menu"]["war_callsign_a"] = "@MPUI_CALLSIGN_MAPNAME_A";
game["strings_menu"]["war_callsign_b"] = "@MPUI_CALLSIGN_MAPNAME_B";
game["strings_menu"]["war_callsign_c"] = "@MPUI_CALLSIGN_MAPNAME_C";
game["strings_menu"]["war_callsign_d"] = "@MPUI_CALLSIGN_MAPNAME_D";
game["strings_menu"]["war_callsign_e"] = "@MPUI_CALLSIGN_MAPNAME_E";
maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
radar_move_init();
}
radar_move_init()
{
level endon ("game_ended");
dish_top = GetEnt( "dish_top", "targetname" );
dish_base = GetEnt( "dish_base", "targetname" );
dish_inside = GetEnt( "dish_inside", "targetname" );
dish_gears = GetEntArray( "dish_gear", "targetname");
total_time_for_rotation_outside = 240;
total_time_for_rotation_inside = 60;
dish_top LinkTo(dish_base);
dish_base thread rotate_dish_top(total_time_for_rotation_outside);
dish_inside thread rotate_dish_top(total_time_for_rotation_inside);
if(dish_gears.size > 0)
{
array_thread(dish_gears, ::rotate_dish_gears, total_time_for_rotation_inside);
}
}
rotate_dish_top( time )
{
self endon ("game_ended");
while(1)
{
self RotateYaw( 360, time );
self waittill( "rotatedone" );
}
}
rotate_dish_gears( time )
{
self endon ("game_ended");
gear_ratio = 5.0 / 60.0;
inverse_gear_ratio = 1.0 / gear_ratio;
while(1)
{
self RotateYaw( 360 * inverse_gear_ratio, time );
self waittill( "rotatedone" );
}
} 