init()
{
level.bookmark["kill"] = 0;
level.bookmark["event"] = 1;
}
bookmark( type, time, ent1, ent2 )
{
assertex( isdefined( level.bookmark[type] ), "Unable to find a bookmark type for type - " + type );
client1 = 255;
client2 = 255;
if ( isDefined( ent1 ) )
client1 = ent1 getEntityNumber();
if ( isDefined( ent2 ) )
client2 = ent2 getEntityNumber();
addDemoBookmark( level.bookmark[type], time, client1, client2 );
} 