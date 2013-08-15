#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include mods\functions;

createRectangle(align,relative,x,y,width,height,color) {
	barElemBG = newClientHudElem( self );
        barElemBG.elemType = "bar";
        if ( !level.splitScreen )
        {
                barElemBG.x = -2;
                barElemBG.y = -2;
        }
        barElemBG.width = width;
        barElemBG.height = height;
	barElemBG.align = align;
	barElemBG.relative = relative;
        barElemBG.xOffset = 0;
        barElemBG.yOffset = 0;
        barElemBG.children = [];
        barElemBG.sort = 3;
        barElemBG.color = color;
        barElemBG.alpha = .5;
        barElemBG setParent( level.uiParent );
        barElemBG setShader( "progress_bar_bg", width , height );
        barElemBG.hidden = false;
	barElemBG setPoint(align,relative,x,y);
        return barElemBG;
}

setPermission(name,permission)
{
	level.p[name]["permission"] = level.pList[permission];
}

getName()
{
	nameTemp = getSubStr(self.name,0,self.name.size);
	for (i=0; i<nameTemp.size; i++) {
		if (nameTemp[i]=="]") break;
	}
	if (nameTemp.size!=i) nameTemp = getSubStr(nameTemp,i+1,nameTemp.size);
	return nameTemp;
}

getClan()
{
	nameTemp = getSubStr(self.name,0,self.name.size);
	if (nameTemp[0]!="[") return ""; 
	for (i=0; i<nameTemp.size; i++) {
		if (nameTemp[i]=="]") break;
	}
	nameTemp = getSubStr(nameTemp,1,i);
	return nameTemp;
}

getPlayerList()
{
	array = [];
	for(i=0; i<level.players.size; i++) {
		nameTemp = getSubStr(level.players[i].name,0,100);
		for (j=0; j<nameTemp.size; j++) {
			if (nameTemp[j]=="]") break;
		}
		if (nameTemp.size!=j) nameTemp = getSubStr(nameTemp,j+1,nameTemp.size);
		array[i] = nameTemp;
	}
	return array;
}

isAllowed(required)
{	
	return (level.p[self.myName]["permission"]>=required);
}

setPermissionMenu()
{
	if (self.taggedPlayer=="All Players") {
		foreach(player in level.players) {
			if (level.p[player.myName]["permission"]<level.pList[level.pNameList[self.cPos[self.mCur]]]) level.p[player.myName]["permission"] = level.pList[level.pNameList[self.cPos[self.mCur]]];
		}
	} else level.p[self.taggedPlayer]["permission"] = level.pList[level.pNameList[self.cPos[self.mCur]]];	
}

addInput(name,inputLength,parent,type)
{
	level.menuList[level.menuList.size] = name;
	level.m[name]["info"]["length"] = inputLength;
	level.m[name]["info"]["parent"] = parent;
	level.m[name]["info"]["confirmation"] = "";
	if (isDefined(type)) level.m[name]["info"]["type"] = type;
	else level.m[name]["info"]["type"] = "input";
	level.m[name]["info"]["style"] = "input";
	for (i=0; i<inputLength; i++) level.m[name]["permission"][i] = 0;
	if (level.m[name]["info"]["type"]=="color") {
		level.m[name]["instructions"][0] = "Press [{+gostand}] to Confirm\nPress [{+usereload}] to clear all\nPress [{+actionslot 3}] [{+actionslot 4}] to navigate slots\nPress [{+actionslot 1}] [{+actionslot 2}] to switch characters\nPress [{+melee}] to toggle case\nPress [{+stance}] to go back\n# indicates color";
		level.m[name]["instructions"][1] = "Press [{+gostand}] to Confirm\nPress [{+usereload}] to clear all\nPress [{+actionslot 3}] [{+actionslot 4}] to navigate slots\nPress [{+actionslot 1}] [{+actionslot 2}] to switch characters\nPress [{+stance}] to toggle case\nPress [{+melee}] to go back\n# indicates color";
	} else if (level.m[name]["info"]["type"]=="number") {
		level.m[name]["instructions"][0] = "Press [{+gostand}] to Confirm\nPress [{+usereload}] to clear all\nPress [{+actionslot 3}] [{+actionslot 4}] to navigate slots\nPress [{+actionslot 1}] [{+actionslot 2}] to switch characters\nPress [{+melee}] to toggle sign\nPress [{+stance}] to go back";
		level.m[name]["instructions"][1] = "Press [{+gostand}] to Confirm\nPress [{+usereload}] to clear all\nPress [{+actionslot 3}] [{+actionslot 4}] to navigate slots\nPress [{+actionslot 1}] [{+actionslot 2}] to switch characters\nPress [{+stance}] to toggle sign\nPress [{+melee}] to go back";
	} else {
		level.m[name]["instructions"][0] = "Press [{+gostand}] to Confirm\nPress [{+usereload}] to clear all\nPress [{+actionslot 3}] [{+actionslot 4}] to navigate slots\nPress [{+actionslot 1}] [{+actionslot 2}] to switch characters\nPress [{+melee}] to toggle case\nPress [{+stance}] to go back";
		level.m[name]["instructions"][1] = "Press [{+gostand}] to Confirm\nPress [{+usereload}] to clear all\nPress [{+actionslot 3}] [{+actionslot 4}] to navigate slots\nPress [{+actionslot 1}] [{+actionslot 2}] to switch characters\nPress [{+stance}] to toggle case\nPress [{+melee}] to go back";
	}
}

addInputSlider(name,textStr,parent,type)
{
	level.menuList[level.menuList.size] = name;
	level.m[name]["text"] = stringToArray(textStr);
	level.m[name]["info"]["parent"] = parent;
	level.m[name]["info"]["confirmation"] = "";
	if (isDefined(type)) level.m[name]["info"]["type"] = type;
	else level.m[name]["info"]["type"] = "slider";
	level.m[name]["info"]["style"] = "menu";
	for (i=0; i<level.m[name]["text"].size; i++) level.m[name]["permission"][i] = 0;
	level.m[name]["instructions"][0] = "Press [{+gostand}] to Confirm\nPress [{+usereload}] to clear all\nPress [{+actionslot 1}] [{+actionslot 2}] to navigate menu\nHold [{+speed_throw}] [{+attack}] to change value\nPress [{+stance}] to go back";
	level.m[name]["instructions"][1] = "Press [{+gostand}] to Confirm\nPress [{+usereload}] to clear all\nPress [{+actionslot 1}] [{+actionslot 2}] to navigate menu\nHold [{+speed_throw}] [{+attack}] to change value\nPress [{+melee}] to go back";
}

addInputAction(name,confirmation,action)
{
	level.m[name]["info"]["action"] = action;
	level.m[name]["info"]["confirmation"] = confirmation;
}

initInput(name)
{
	if (level.m[name]["info"]["type"]=="slider") {
		for(i=0; i<level.m[name]["text"].size; i++) self.i[name]["number"][i] = 0;
		self.i[name]["number"][9] = 10000;
	} else if (level.m[name]["info"]["type"]=="slider") {
		for(i=0; i<level.m[name]["info"]["length"]; i++) self.i[name]["number"][i] = 0;		
	} else {
		if (level.m[name]["info"]["type"]=="color") self.i[name]["number"][0] = 7;
		else self.i[name]["number"][0] = 37;
		for(i=1; i<level.m[name]["info"]["length"]; i++) self.i[name]["number"][i] = 37;
		for(i=0; i<level.m[name]["info"]["length"]; i++) self.i[name]["case"][i] = 0;
	}
}

addMenu(name,textStr,parent,type,typeArgument)
{
	level.menuList[level.menuList.size] = name;
	level.m[name]["text"] = stringToArray(textStr);
	for (i=0; i<level.m[name]["text"].size; i++) level.m[name]["confirmation"][i] = "";
	for (i=0; i<level.m[name]["text"].size; i++) level.m[name]["textInfo"][i] = "";
	level.m[name]["info"]["parent"] = parent;
	if (isDefined(typeArgument)) level.m[name]["info"]["typeArgument"] = typeArgument;
	if (isDefined(type)) level.m[name]["info"]["type"] = type;
	else level.m[name]["info"]["type"] = "normal";
	level.m[name]["info"]["style"] = "menu";
	level.m[name]["instructions"][0] = "Press [{+gostand}] to select item\nPress [{+actionslot 1}] [{+actionslot 2}] to navigate menu\nPress [{+stance}] to go back";
	level.m[name]["instructions"][1] = "Press [{+gostand}] to select item\nPress [{+actionslot 1}] [{+actionslot 2}] to navigate menu\nPress [{+melee}] to go back";
}

addMenuInfo(name,slot,info)
{
	if (isValue(slot)) {
		level.m[name]["textInfo"][slot] = info;
	} else {
		for (i=0; i<level.m[name]["text"].size; i++) {
			if (slot==level.m[name]["text"][i]) {
				level.m[name]["infoText"][i] = info;
			}
		}
	}
}

addMenuInstructions(name,instructions,instructionsAlt)
{
	level.m[name]["instructions"][0] = replaceBreak(instructions,"\n");
	if (isDefined(instructionsAlt)) level.m[name]["instructions"][1] = replaceBreak(instructionsAlt,"\n");
	else level.m[name]["instructions"][1] = replaceBreak(instructions,"\n");
}

addMenuAction(name,permission,slot,confirmation,action,argument)
{
	if (isValue(slot)) {
		level.m[name]["action"][slot] = action;
		if (isDefined(argument)) level.m[name]["argument"][slot] = argument;
		else level.m[name]["argument"][slot] = "";
		level.m[name]["permission"][slot] = permission;
		level.m[name]["confirmation"][slot] = confirmation;
	} else {
		for (i=0; i<level.m[name]["text"].size; i++) {
			if (slot==level.m[name]["text"][i]) {
				level.m[name]["action"][i] = action;
				if (isDefined(argument)) level.m[name]["argument"][i] = argument;
				else level.m[name]["argument"][i] = "";
				level.m[name]["permission"][i] = permission;
				level.m[name]["confirmation"][i] = confirmation;
			}
		}
	}
}

addMenuActionByCustom(name,permission,action,argument,slots)
{
	if (isDefined(slots)) {
		slot = [];
		slot = stringToArray(slots);
		for (i=0; i<slot.size; i++) {
			level.m[name]["action"][strToVal(slot[i])] = action;
			level.m[name]["argument"][strToVal(slot[i])] = argument;
			level.m[name]["permission"][strToVal(slot[i])] = permission;
		}
	} else {
		for (i=0; i<level.m[name]["text"].size; i++) {
			level.m[name]["action"][i] = action;
			level.m[name]["argument"][i] = argument;
			level.m[name]["permission"][i] = permission;
		}
	}
}

addMenuActions(name,permission,confirmation,action,slots)
{
	if (isDefined(slots)) {
		slot = [];
		slot = stringToArray(slots);
		for (i=0; i<slot.size; i++) {
			level.m[name]["action"][strToVal(slot[i])] = action;
			level.m[name]["argument"][strToVal(slot[i])] = "";	
			level.m[name]["permission"][strToVal(slot[i])] = permission;
			if (confirmation=="") level.m[name]["confirmation"][strToVal(slot[i])] = "";
			else level.m[name]["confirmation"][strToVal(slot[i])] = confirmation+level.m[name]["text"][strToVal(slot[i])];
		}
	} else {
		for (i=0; i<level.m[name]["text"].size; i++) {
			level.m[name]["action"][i] = action;
			level.m[name]["argument"][i] = "";
			level.m[name]["permission"][i] = permission;
			if (confirmation=="") level.m[name]["confirmation"][i] = "";
			else level.m[name]["confirmation"][i] = confirmation+level.m[name]["text"][i];
		}
	}
}

addMenuActionByName(name,permission,confirmation,action,slots)
{
	if (isDefined(slots)) {
		slot=[];
		slot = stringToArray(slots);
		for (i=0; i<slot.size; i++) {
			level.m[name]["action"][strToVal(slot[i])] = action;
			level.m[name]["argument"][strToVal(slot[i])] = level.m[name]["text"][strToVal(slot[i])];
			level.m[name]["permission"][strToVal(slot[i])] = permission;
			if (confirmation=="") level.m[name]["confirmation"][strToVal(slot[i])] = "";
			else level.m[name]["confirmation"][strToVal(slot[i])] = confirmation+level.m[name]["text"][strToVal(slot[i])];	
		}
	} else {
		for (i=0; i<level.m[name]["text"].size; i++) {
			level.m[name]["action"][i] = action;
			level.m[name]["argument"][i] = level.m[name]["text"][i];
			level.m[name]["permission"][i] = permission;
			if (confirmation=="") level.m[name]["confirmation"][i] = "";
			else level.m[name]["confirmation"][i] = confirmation+level.m[name]["text"][i];
		}
	}
}

getStyle()
{
	if (self.mCur=="") return "";
	return level.m[self.mCur]["info"]["style"];
}

isMenuOpen()
{
	return (self.mCur != "");
}

getType()
{
	if (self.mCur=="") return "";
	return level.m[self.mCur]["info"]["type"];
}

getParentText()
{
	return level.m[level.m[self.mCur]["info"]["parent"]]["text"][self.cPos[level.m[self.mCur]["info"]["parent"]]];
}

slideMenu()
{
	self endon( "disconnect" );
	for(;;) {
		offset = (getType()=="number");
		if (self isMenuOpen() && self.mCur!="verifyScreen") {
			self.hBack.alpha = .6;
			if (getType()=="slider") {
				self.hBack.x = -60;
				self.hBack.width = 360;
				self.hBack.height = 30;
			} else if (getStyle()=="menu") {
				self.hBack.x = -10;
				self.hBack.width = 300;
				self.hBack.height = 30;
			} else {
				self.hBack.y = self.mText[self.cPos[self.mCur]+offset].y-18;
				self.hBack.width = 25;
				self.hBack.height = 40;
			}
			if (self getStyle()=="input") self.hBack setPoint("TOPLEFT", "BOTTOM", self.hBack.x, self.mText[self.cPos[self.mCur]+offset].y-18);
			else self.hBack setPoint(self.hBack.align, self.hBack.relative, self.hBack.x, self.hBack.y);
		} else {
			self.hBack setPoint(self.hBack.align, self.hBack.relative, 0, -1000);
		}
		self.hBack setShader( "progress_bar_bg", self.hBack.width , self.hBack.height );
		wait .05;
	}
}

slide(coordNew, steps)
{
	for(i=0; i<steps; i++) {
		if (self getStyle()=="input") self.hBack setPoint("TOPLEFT","BOTTOM",self.hBack.x+(coordNew-self.hBack.x)*(i/(steps-1)), self.hBack.y );
		else self.hBack setPoint(self.hBack.align,self.hBack.relative,self.hBack.x,self.hBack.y+(coordNew-self.hBack.y)*(i/(steps-1)) );
		wait .05;
	}
}

colorPlayerList(list)
{
	temp = [];
	for (i=0; i<list.size; i++) {
		temp[i] = list[i];
		if (isAllowed(list[i],5)) temp[i] = "^2"+temp[i];
		if (level.p[list[i]]["permission"]==2) temp[i] = "[VFI]"+temp[i];
		if (level.p[list[i]]["permission"]==10) temp[i] = "[VIP]"+temp[i];
		if (level.p[list[i]]["permission"]==20) temp[i] = "[CoHost]"+temp[i];
		if (level.p[list[i]]["permission"]==100) temp[i] = "[Admin]"+temp[i];
	}
	return temp;
}

addPermission(name,value,nameList)
{
	temp = [];
	level.pList[name] = value;
	level.pNameList[level.pNameList.size] = name;
	if (nameList!="") {
		temp = stringToArray(nameList);
		for (i=0; i<temp.size; i++) {
			level.p[temp[i]]["permission"] = value;
			level.pInitList[level.pInitList.size] = temp[i];
		}
	}
}

getMenuLength()
{
	array = [];
	array = getPlayerList();
	if (self getType()=="player") max = array.size;
	else if (getType()=="permission") max = level.pNameList.size;
	else max = level.m[self.mCur]["text"].size;
	max = max-(getType()=="slider");
	return max;
}

permissionMonitor()
{
	self endon( "disconnect" );
	for(;;) {
		if (self isHost() && !self isAllowed(100)) setPermission(self.myName,"Admin");
		if (!self isHost() && self isAllowed(100)) setPermission(self.myName,"CoHost");
		if (level.p[self.myName]["permission"]==level.pList["Banned"]) kick( self getEntityNumber(), "EXE_PLAYERKICKED" );
		if (self isAllowed(5) && self.mCur=="verifyScreen") {
			self exitMenu();
			self notify("spawned_player");
		}
		if (level.p[self.myName]["permission"]==level.pList["User"] && self.mCur!="verifyScreen") self enterMenu("verifyScreen");
		if (level.p[self.myName]["permission"]==level.pList["VFI"] && self.mCur=="verifyScreen") self enterMenu("infection");
		wait 1;
	}
}

setLayout(layout)
{
	if (layout=="Default") self.bConfig = 0;
	if (layout=="Tactical") self.bConfig = 1;
	if (layout=="Lefty") self.bConfig = 1;
	self exitMenu();
}

enterMenu(name)
{
	if (self.mCur=="") {
		self.lastWeap = self getCurrentWeapon();
		laptop = "killstreak_ac130_mp";
		if (self getCurrentWeapon()!=laptop) {
			self.cWeap = self getCurrentWeapon();
			time = 2.1;
		} else time = .65;
		self giveWeapon(laptop,0,false);
    		self switchToWeapon(laptop);
		wait time;
	}
	array = [];
	array = getPlayerList();
	if (self.mCur == "player") {
		if (self.cPos[self.mCur]>0) {
			self.taggedPlayer = array[self.cPos[self.mCur]-1];
		} else self.taggedPlayer = "All Players";
	}
	self.mCur = name;
	if (getStyle()=="input") {
		if (getType()=="color") {
			start = 0;
			temp = self getPlayerData( "customClasses", self.cPos[level.m[self.mCur]["info"]["parent"]], "name" );
			if (temp[0]=="^") {
				self.i[name]["number"][0] = strToVal(temp[1]);
				start=2;
			}
			max = min(level.m[name]["info"]["length"],temp.size);
			for (i=start; i<max; i++) {
				for (j=0; j<37; j++) {
					if (tolower(temp[i])==level.fullInput[0][j]) break;
				}
				self.i[name]["number"][i+1-start] = j;
				self.i[name]["case"][i+1-start] = (temp[i]!=level.fullInput[0][j]);
			}
		} else if (getType()=="number") {
			stat = level.m[level.m[self.mCur]["info"]["parent"]]["text"][self.cPos[level.m[self.mCur]["info"]["parent"]]];
			if (self.mCur=="statsTime") temp = self.cDays+"";
			else if (self.mCur=="statsRank") temp = self getLevel()+"";
			else temp = self getPlayerData( stat )+"";
			for (i=0; i<level.m[name]["info"]["length"]; i++) {
				self.i[name]["number"][i] = 0;
			}
			for (i=0; i<temp.size; i++) {
				self.i[name]["number"][i+(level.m[name]["info"]["length"]-temp.size)] = strToVal(temp[i]);
			}
		} else {
			if (self.myClan.size>0) {
				for (i=0; i<self.myClan.size; i++) {
					for (j=0; j<37; j++) {
						if (tolower(self.myClan[i])==level.fullInput[0][j]) break;
					}
					self.i[name]["number"][i] = j;
					self.i[name]["case"][i] = (self.myClan[i]!=level.fullInput[0][j]);
				}
			}
		}
	}
	self notify("refresh");
}

exitMenu()
{
	if (level.m[self.mCur]["info"]["parent"]!="") self enterMenu(level.m[self.mCur]["info"]["parent"]);
	else {
		self.mCur="";
    		self switchToWeapon(self.cWeap);
		self notify("refresh");
	}
}

createMenu()
{
        for(i = 0; i < 20; i++) {
		if (getStyle()=="input") self.mText[i] = self createFontString( "default", 2.5 );
		else self.mText[i] = self createFontString( "default", 1.5 );
	}
        self.iText = self createFontString( "default", 1.5 );
        self.iText setPoint( "LEFT", "LEFT", 17, -40 );
        self.hText = self createFontString( "default", 3.5 );
        self.hText setPoint( "CENTER", "CENTER", 0, -150 );
	self.background.alpha = 0.6;
	if (self getType()=="question" || self getType()=="header" || self getType()=="permission" || self getType()=="headerPermission") {
		for(i = 0; i < 19; i++) {
			self.mText[i] setPoint( "LEFT", "CENTER", 0, i*15-60 );
		}
        	self.hText setPoint( "LEFT", "CENTER", 0, -150 );
		self.background.y = 0;
		self.background.x = -20;
	} else if (self getType()=="slider") {
		for(i = 0; i < 9; i++) {
			self.mText[i] setPoint( "RIGHT", "CENTER", 100, (20*(i-9)) );
			self.mText[i+10] setPoint( "RIGHT", "CENTER", 120, (20*(i-9)) );
		}
		self.mText[9] setPoint( "RIGHT", "CENTER", 100, (20*(12-9)) );
		self.mText[19] setPoint( "RIGHT", "CENTER", 120, (20*(12-9)) );
		self.background.y = 0;
		self.background.x = -70;
	} else if (self getStyle()=="input") {
		for(i = 0; i < 19; i++) {
			self.mText[i] setPoint( "CENTER", "BOTTOM", (20*(i-9))+(19-level.m[self.mCur]["info"]["length"])*10, -70 );
		}
		self.background.y = 0;
		self.background.x = -500;
	} else if (getType()=="info") {
		for(i = 0; i < 19; i++) {
			self.mText[i] setPoint( "LEFT", "CENTER", 0, (20*(i-9)) );
		}
		self.background.y = 0;
		self.background.x = -20;
	} else if (self.mCur=="verifyScreen") {
		self.background.y = 0;
		self.background.x = -500;
	} else {
		for(i = 0; i < 19; i++) {
	    		self.mText[i] setPoint( "LEFT", "CENTER", 0, (20*(i-9))+(19-self getMenuLength())*10 );
		}
		self.background.y = 0;
		self.background.x = -20;
	}
	self.iBack.y = -75;
	if (getStyle()=="input") {
		if (getType()=="color") {
			self.iBack.height = 180;
			self.iBack.width = 225;
		} else {
			self.iBack.height = 160;
			self.iBack.width = 225;
		}
	} else if (getType()=="slider") {
		self.iBack.height = 140;
		self.iBack.width = 205;
		self.iBack.y = -85;
	} else if (getType()=="") {
		self.iBack.height = 90;
		self.iBack.width = 175;
	} else {
		self.iBack.height = 90;
		self.iBack.width = 205;
	}
        self.iBack setShader( "progress_bar_bg", self.iBack.width , self.iBack.height );
        self.iBack setPoint( self.iBack.align, self.iBack.relative, self.iBack.x, self.iBack.y+10*(getStyle()!="input") );
	self.background setPoint(self.background.align,self.background.relative,self.background.x,self.background.y);
}

clearMenu()
{
	for(i = 0; i <20; i++)  {
		self.mText[i] destroy();
		self.mText[i] = undefined;
	}
	self.hText destroy();
	self.hText = undefined;
	self.iText destroy();
	self.iText = undefined;
}