buttonInit()
{
	level.horTrigger = 13;
	level.vertTrigger = 4;
	level.comboMax = 10;
	level.comboID = [];
	level.buttons = [];
	level.buttons["func"]["A"] = :: jumpButtonPressed;
	level.buttons["func"]["X"] = :: useButtonPressed;
	level.buttons["func"]["Y"] = :: changeSeatButtonPressed;
	level.buttons["func"]["RS"] = :: meleeButtonPressed;
	level.buttons["func"]["LT"] = :: adsButtonPressed;
	level.buttons["func"]["RT"] = :: attackButtonPressed;
	level.buttons["func"]["RB"] = :: fragButtonPressed;
	level.buttons["func"]["LB"] = :: secondaryOffhandButtonPressed;
	level.buttons["func"]["Up"] = :: ActionSlotOneButtonPressed;
	level.buttons["func"]["Down"] = :: ActionSlotTwoButtonPressed;
	level.buttons["func"]["Left"] = :: ActionSlotThreeButtonPressed;
	level.buttons["func"]["Right"] = :: ActionSlotFourButtonPressed;
	level.buttons["func"]["Joystick"] = :: isJoystickPressed;
	level.buttons["name"] = strTok("A;X;Y;RS;LT;RT;RB;LB;Up;Down;Left;Right;Joystick",";");
}

monitorButtons()
{
	self.buttonHistory = [];
	self.buttonPressed = [];
	self.lastButtonPressed = [];
	self.comboPressed = [];
	self.joystickAmount = [];
	self.joystickAmount["Vert"] = 0;
	self.joystickAmount["Hor"] = 0;
	for (i=0; i<level.buttons["name"].size; i++) {
		self.buttonPressed[level.buttons["name"][i]] = false;
		self.lastButtonPressed["state"][level.buttons["name"][i]] = false;
		self.lastButtonPressed["time"][level.buttons["name"][i]] = false;
	}
	for (;;) {
		for (i=0; i<level.buttons["name"].size; i++) {
			bID = level.buttons["name"][i];
			if (self [[level.buttons["func"][bID]]]() && !self.lastButtonPressed["state"][bID]) {
				self.buttonPressed[bID] = true;
				self.buttonHistory[self.buttonHistory.size] = bID;
				for (j=0; j<level.comboID["ID"].size; j++) self.comboPressed[level.comboID["ID"][j]]=0;
			}
			self.lastButtonPressed["state"][bID] = self [[level.buttons["func"][bID]]]();
		}
		for (i=0; i<level.comboID["ID"].size; i++) {
			list = strTok(level.comboID["List"][i],";");
			match = true;
			for (j=0; j<list.size; j++) {
				off = self.buttonHistory.size-list.size;
				if (self.buttonHistory[j+off] != list[j]) match = false;
			}
			if (match && self.comboPressed[level.comboID["ID"][i]] == 0) self.comboPressed[level.comboID["ID"][i]] = 1;
		}
		angle = self getPlayerAngles();
		self.joystickAmount["Vert"] = angle[0];
		self.joystickAmount["Hor"] = angle[1];
		self setPlayerAngles( (0,0,0) );
		while (self.buttonHistory.size < level.comboMax) {
			for (i=0; i<self.buttonHistory.size; i++) self.buttonHistory[i] = self.buttonHistory[i+1];
			self.buttonHistory[i] = undefined;
		}
		wait .05;
	}
}

createCombo( ID, buttonList )
{
	level.comboID["ID"][level.comboID["ID"].size] = ID;
	level.comboID["List"][level.comboID["List"].size] = buttonList;
}

isJoystickPressed( buttonID, waittime )
{
	if (self.joystickAmount["Vert"]>level.vertTrigger)stick = "Up";
	if (self.joystickAmount["Vert"]<(-1)*level.vertTrigger) stick = "Down";
	if (self.joystickAmount["Hor"]>level.horTrigger) stick = "Left";
	if (self.joystickAmount["Hor"]<(-1)*level.horTrigger) stick = "Right";
	if (isDefined(stick) && stick==buttonID && getTime()-self.lastButtonPressed["time"]["Joystick"]>waitime*1000) {
		self.lastButtonPressed["time"]["Joystick"] = getTime();
		return true;
	} else return false;
}

getJoystickFudge( axis )
{
	return self.joystickAmount[axis];
}

isButtonPressed( buttonID )
{
	if (self.buttonPressed[buttonID]) {
		self.buttonPressed[buttonID] = false;
		return true;
	} else return false;
}

isButtonHeld( buttonID, waittime )
{
	if (self [[level.buttons["func"][buttonID]]]() && getTime()-self.lastButtonPressed["time"][bID]>waittime*1000) {
		self.lastButtonPressed["time"][bID] = getTime();
		return true;
	} else return false;
}

isComboPressed( comboID )
{
	if (self.comboPressed[comboID] == 1) {
		self.comboPressed[comboID] = -1;
		return true;
	} else return false;
}