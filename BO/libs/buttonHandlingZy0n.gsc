init()
{
  level.horTrigger = 45;
  level.vertTrigger = 14;
  level.buttons = [];
  level.buttons["func"]["X"] = :: useButtonPressed();
  level.buttons["func"]["Y"] = :: changeSeatButtonPressed();
  level.buttons["func"]["RS"] = :: meleeButtonPressed();
  level.buttons["func"]["RT"] = :: attackButtonPressed();
  level.buttons["func"]["RB"] = :: fragButtonPressed();
  level.buttons["func"]["LB"] = :: secondaryOffhandButtonPressed();
  level.buttons["func"]["Up"] = :: ActionSlotOneButtonPressed();
  level.buttons["func"]["Down"] = :: ActionSlotTwoButtonPressed();
  level.buttons["func"]["Left"] = :: ActionSlotThreeButtonPressed();
  level.buttons["func"]["Right"] = :: ActionSlotFourButtonPressed();
  level.buttons["name"] = strToArray("X;Y;RS;RT;RB;LB;Up;Down;Left;Right");
}

playerInitButtons()
{
  self.buttonPressed = [];
  self.joystickAmount = [];
  buttons = getArrayKeys(level.buttons["name"]);
  comboStrings = getArrayKeys(level.buttonCombos);
  self thread monitorJoystick();
  for(buttonNum=0;buttonNum<buttons.size;buttonNum++)
  {
      self.buttonPressed[button[buttonNum]] = false;
      self.buttonJustPressed[button[buttonNum]] = false;
  }
  for(comboNum=0;comboNum<comboStrings.size;comboNum++)
  {
    self.comboCompleted[comboStrings[comboNum]] = false;
  }
  for(;;)
  {
    for(buttonNum=0;buttonNum<buttons.size;buttonNum++)
    {
      if(self [[level.buttons["func"][button[buttonNum]]]] && !self.buttonJustPressed[button[buttonNum])
      {
        self.buttonPressed[button[buttonNum]] = true;
        self.buttonJustPressed[button[buttonNum]] = true;
        self notify("buttonPress", button[buttonNum]);
        tmpCombo += button[buttonNum]+",";
      }
    }
    for(buttonNum=0;buttonNum<buttons.size;buttonNum++)  
      if(self.buttonJustPressed[button[buttonNum]] && !self [[level.buttons["func"][button[buttonNum]]]])
        self.buttonJustPressed[button[buttonNum]] = false;

    if (self timedPro("btnCombo", 3, true)) tmpCombo = "";
    for(comboNum=0;comboNum<comboStrings.size;comboNum++)
    {
      check = getSubStr( tmpCombo, 0, tmpCombo.size-1 );
      if(isSubStr(check, comboStrings[comboNum]) && !self.comboCompleted[comboStrings[comboNum]])
      {
        if(level.buttonCombos[comboStrings[comboNum]].onetime) self.comboCompleted[comboStrings[comboNum]] = true;
        self thread [[level.buttonCombos[comboStrings[comboNum]].func]](level.buttonCombos[comboStrings[comboNum]].args);
        tmpCombo = "";
      }
    }
    wait .05;
  }
}

createCombo(combo, func, args, onetime)
{
  level.buttonCombos[combo] = spawnStruct();
  level.buttonCombos[combo].func = func;
  if(isDefined(args)) level.buttonCombos[combo].args = args;
  else level.buttonCombos[combo].args = "undefined";
  if(isDefined(onetime) && onetime) level.buttonCombos[combo].onetime = true;
  else level.buttonCombos[combo].onetime = false;
}

monitorJoystick()
{
  self.joystickAmount["Vert"] = 0;
  self.joystickAmount["Hor"] = 0;
  self.joystickLastPress = 0;
  for(;;) {
    angle = self getPlayerAngles();
    self.joystickAmount["Vert"] = angle[0];
    self.joystickAmount["Hor"] = angle[1];
    self setPlayerAngles( (0,0,0) );
    wait .05;
  }
}


isJoystickPressed( buttonID, waittime )
{
  if (getTime()-self.joystickLastPress > waitime*1000) {
    if ( (buttonID == "Up" || buttonID == "Down") && abs(self.joystickAmount["Vert"])>level.vertTrigger ) self.joystickLastPress = getTime();
    if ( (buttonID == "Left" || buttonID == "Right") && abs(self.joystickAmount["Hor"])>level.horTrigger ) self.joystickLastPress = getTime();
    if (buttonID == "Up") return (self.joystickAmount["Vert"]>level.vertTrigger);
    if (buttonID == "Down") return (self.joystickAmount["Vert"]<(-1)*level.vertTrigger);
    if (buttonID == "Left") return (self.joystickAmount["Hor"]>level.horTrigger);
    if (buttonID == "Right") return (self.joystickAmount["Hor"]<(-1)*level.horTrigger);
  }
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

isButtonHeld( buttonID )
{
  return self [[level.buttons["func"][buttonID]]];
}

strToArray( arrayString )
{
  array = [];
  tokens = strTok( arrayString, ";" );
  for(i=0; i<tokens.size; i++ ) array[array.size] = tokens[i];
  return array;
}

timedPro(pname, waitTime, reset)
{
  if (!isDefined( self.isProcess[pname]["active"]))
  {
    self.isProcess[pname]["start"] = getTime();
    self.isProcess[pname]["active"] = true;
    self.isProcess[pname]["wait"] = waitTime*1000;
    return false;
  } else if ((getTime() - self.isProcess[pname]["start"]) > self.isProcess[pname]["wait"])
    {
      if (reset) self.isProcess[pname]["active"] = undefined;
      return true;
    } else return false;
}