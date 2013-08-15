unlockChallenges()
{
	for (tierNum=1;tierNum<=level.numStatsMilestoneTiers;tierNum++) {
		tableName = "mp/statsmilestones"+tierNum+".csv";
		for(idx=0;idx<level.maxStatChallenges; idx++) {
			row = tableLookupRowNum(tableName, 0, idx);
			if ( row > -1 ) {
				statType = tableLookupColumnForRow(tableName, row, 3);
				statName = tableLookupColumnForRow(tableName, row, 4);
				if (isDefined(level.statsMilestoneInfo[statType][statName])) self maps\mp\gametypes\_persistence::statAdd(statName, int(tableLookupColumnForRow(tableName, row, 2)), false);
			}
			wait .05;
		}
		wait .05;
	}
}