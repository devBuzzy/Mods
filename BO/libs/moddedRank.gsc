giveModdedXP()
{
	self endon("disconnect");
	pixbeginevent("giveRankXP");
	value = getScoreInfoValue( "kill" );
	xpGain_type = "kill";
	if ( !isDefined( self.xpGains[xpGain_type] ) ) self.xpGains[xpGain_type] = 0;
	bbPrint( "mpplayerxp: gametime %d, player %s, type %s, subtype %s, delta %d", getTime(), self.name, xpGain_type, type, value );
	self.xpGains[xpGain_type] += value;
	xpIncrease = self incModdedXP( value );
	if (maps\mp\gametypes\_rank::updateRank()) self thread maps\mp\gametypes\_rank::updateRankAnnounceHUD();
	self thread maps\mp\gametypes\_rank::updateRankScoreHUD( value );
	self.pers["summary"]["score"] += value;
	self.pers["summary"]["xp"] += xpIncrease;
	pixendevent();
}

incModdedXP( amount )
{
	newXp = self.pers["rankxp"] + amount;
	if ( self.pers["rank"] == level.maxRank && newXp >= int(level.rankTable[level.maxRank][7])) newXp = level.rankTable[level.maxRank][7];
	self.pers["rankxp"] = newXp;
	return amount;
}