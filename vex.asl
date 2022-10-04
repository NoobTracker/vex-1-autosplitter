//Autosplitter and IGT for the hacked .exe of Vex, (currently limited to) Any%

state("vexspeed")
{
	//This variable is a magic number. It should be 0x13371337.
	//It's a variable of the main script. 
	int magicNumber : 0x007E8A60, 0x158, 0x94, 0x1C, 0x4F8, 0x240, 0x18, 0xEB4, 0xE8;
	
	//This variable is incremented whenever the player presses the start button.
	//It's a variable of the main script. 
	int start : 0x007E8A60, 0x158, 0x94, 0x1C, 0x4F8, 0x240, 0x18, 0xEB4, 0xEC;
	
	//This variable is incremented whenever you beat a level.
	//It's a variable of the main script. 
	int split : 0x007E8A60, 0x158, 0x94, 0x1C, 0x4F8, 0x240, 0x18, 0xEB4, 0xF0;
	
	//This variable counts frames, starting when start is inc'd. 
	//Stops when the last portal is reached.
	//It's a variable of the main script. 
	int time : 0x007E8A60, 0x158, 0x94, 0x1C, 0x4F8, 0x240, 0x18, 0xEB4, 0xF4;
	
	//This variable is incremented whenever you reset the data.
	//It's a variable of the main script. 
	int reset : 0x007E8A60, 0x158, 0x94, 0x1C, 0x4F8, 0x240, 0x18, 0xEB4, 0xF8;
}



startup
{
	//This seems to allow us to play around with the timer functions,
	//we need this to reset when you exit the game.
	vars.TimerModel = new TimerModel { CurrentState = timer };
}


update
{
	int magicNumber = 0x13371337;
	return magicNumber == current.magicNumber;
}


start
{
	return current.start > old.start;
}

split
{
	return current.split > old.split;
}



//I was told that this is needed to make LiveSplit use the "IGT"
isLoading{return true;}

gameTime
{
	double frames = current.time;
	double fps = 30;
	double millis = (frames * 1000) / fps;
	return TimeSpan.FromMilliseconds(millis);
}



reset{
	return current.reset > old.reset;
}

exit
{
	//If the reset setting is enabled and the run isn't finished ...
	if(settings.ResetEnabled && !(timer.CurrentPhase == TimerPhase.Ended)){
		vars.TimerModel.Reset();
	}
}