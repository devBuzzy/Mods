processModdedChallenge( baseName, progressInc, weaponNum, challengeType )
{
	numLevels = getChallengeLevels( baseName );
	if ( numLevels < 0 ) return;
	if ( isDefined( weaponNum ) && isDefined( challengeType ) ) {
		missionStatus = self getdstat( "WeaponStats", weaponNum, "challengeState", challengeType );
		if ( !missionStatus ) {
			missionStatus = 1;
			self setDStat( "WeaponStats", weaponNum, "challengeState", challengeType, missionStatus );
		}
	} else {
		if ( numLevels > 1 ) missionStatus = self getChallengeStatus( (baseName + "1") );
		else missionStatus = self getChallengeStatus( baseName );
	}
	if ( !isDefined( progressInc ) ) progressInc = 1;
	if ( !missionStatus || missionStatus == 255 ) return;
	assertex( missionStatus <= numLevels, "Mini challenge levels higher than max: " + missionStatus + " vs. " + numLevels );
	if ( numLevels > 1 ) refString = baseName + missionStatus;
	else refString = baseName;
	if ( isDefined( weaponNum ) && isDefined( challengeType ) ) progress = self getdstat( "WeaponStats", weaponNum, "challengeprogress", challengeType );
	else progress = self getdstat( "ChallengeStats", refString, "challengeprogress" );
	progress += progressInc;
	if ( isDefined( weaponNum ) && isDefined( challengeType ) ) self setdstat( "WeaponStats", weaponNum, "challengeprogress", challengeType, progress );
	else self setdstat( "ChallengeStats", refString, "challengeprogress", progress );
	if ( progress >= level.challengeInfo[refString]["maxval"] ) {
		if ( !isDefined( weaponNum ) ) weaponNum = 0;
		self thread milestoneNotify( level.challengeInfo[refString]["tier"], level.challengeInfo[refString]["index"], weaponNum, level.challengeInfo[refString]["tier"] );
		if ( missionStatus == numLevels ) {
			missionStatus = 255;
			self maps\mp\gametypes\_globallogic_score::incPersStat( "challenges", 1 );
		} else missionStatus += 1;
		if ( numLevels > 1 ) self.challengeData[baseName + "1"] = missionStatus;
		else self.challengeData[baseName] = missionStatus;
		if ( isDefined( weaponNum ) && isDefined( challengeType ) ) {
			self setdstat( "WeaponStats", weaponNum, "challengeprogress", challengeType, level.challengeInfo[refString]["maxval"] );
			self setdstat( "WeaponStats", weaponNum, "challengestate", challengeType, missionStatus );
		} else {
			self setdstat( "ChallengeStats", refString, "challengeprogress", level.challengeInfo[refString]["maxval"] );
			self setdstat( "ChallengeStats", refString, "challengestate", missionStatus );
		}
			self maps\mp\gametypes\_rank::giveRankXP( "challenge", level.challengeInfo[refString]["reward"] );
			self maps\mp\gametypes\_rank::incCodPoints( level.challengeInfo[refString]["cpreward"] );
	}
}