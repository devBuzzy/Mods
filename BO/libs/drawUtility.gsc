//-----------------------------------------------
//------------- DRAW FUNCTIONALITY --------------
//-----------------------------------------------

//Rectangle
rectCreateAndSet( elementRel, screenRel, x, y, width, height, color, alpha ) {
	barElemBG = newClientHudElem( self );
	barElemBG.elemType = "bar";
	if ( !level.splitScreen ) {
		barElemBG.x = -2;
		barElemBG.y = -2;
	}
	barElemBG.xOffset = 0;
	barElemBG.yOffset = 0;
	barElemBG.children = [];
	barElemBG.sort = 3;
	barElemBG setParent( level.uiParent );
	barElemBG.hidden = false;
	barElemBG setPoint( elementRel, screenRel, x, y );
	barElemBG rectSize( width, height );
	barElemBG rectColor( color, alpha );
	barElemBG.pulsing = false;
	barElemBG.pulseTime = 0;
	return barElemBG;
}

rectCreate() {
	barElemBG = newClientHudElem( self );
	barElemBG.elemType = "bar";
	if ( !level.splitScreen ) {
		barElemBG.x = -2;
		barElemBG.y = -2;
	}
	barElemBG.xOffset = 0;
	barElemBG.yOffset = 0;
	barElemBG.children = [];
	barElemBG.sort = 0;
	barElemBG setParent( level.uiParent );
	barElemBG.hidden = false;
	barElemBG.pulsing = false;
	barElemBG.pulseTime = 0;
	return barElemBG;
}

rectSize( width, height )
{
	self setShader( "progress_bar_bg", width , height );
}

rectColor( color, alpha )
{
	self.color = color;
	self.alpha = alpha;
}

rectPulse( period, endAlpha )
{
	if (!isDefined(endAlpha)) endAlpha = 0;
	self.pulsing = (period > 0);
	while (self.pulsing) {
		self.pulseTime += 1;
		self.alpha = sin((2*3.14159265*pulseTime)/(20*period));
		wait .05;
	}
}

rectFade( endAlpha )
{
	alpha = self.alpha;
	
}

//Text
textCreateAndSet( font, size, elementRel, sreenRel, x, y, string )
{
	text = self createFontString( "default", 1);
	text setPoint( elementRel, sreenRel, x, y );
	text setText( string );
	return text;
}

//Progress Bar
progressBarCreate()
{
	bar = spawnstruct();
	bar.front = self rectCreate();
	bar.front.sort = 10;
	bar.back = self rectCreate();
	bar.front.sort = -10;
	return bar;
}

progressBarColor( colorBack, colorFront, alpha )
{
	self.back.color = colorBack;
	self.back.alpha = alpha;
	self.front.color = colorFront;
	self.front.alpha = alpha;
}

progressBarSize( width, height )
{
	self.back setShader( "progress_bar_bg", width , height );
	self.back.width = width;
	self.back.height = height;
	self.front setShader( "progress_bar_bg", width , height );
	self.front.width = width;
	self.front.height = height;
}

progressBarUpdate( percentage )
{
	self.front setShader( "progress_bar_bg", self.front.width*percentage, self.front.height );
}