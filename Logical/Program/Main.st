
PROGRAM _INIT
	enableControl := TRUE;
	speedFactor := 1;
	
	CncMachine.Enable := TRUE;
	
	CncMachine.Override := 100;
	CncMachineParam.ProgramName := 'CncProg';
	
	mpDataRecorderFB.Enable := TRUE;
	mpDataRecorderFB.DeviceName := ADR('HD');
	mpDataRecorderFB.MpLink := ADR(gDataRecorder);
	mpDataRecorderFB.RecordMode := mpDATA_RECORD_MODE_VALUE;
	
	mpDataRegX.Enable := TRUE;
	mpDataRegX.MpLink := ADR(gDataRecorder);
	mpDataRegX.PVName := ADR('::Program:CncMachine.X');
	
	mpDataRegY.Enable := TRUE;
	mpDataRegY.MpLink := ADR(gDataRecorder);
	mpDataRegY.PVName := ADR('::Program:CncMachine.Y');
	
	mpDataRegZ.Enable := TRUE;
	mpDataRegZ.MpLink := ADR(gDataRecorder);
	mpDataRegZ.PVName := ADR('::Program:CncMachine.Z');
	 
END_PROGRAM

PROGRAM _CYCLIC
	CncMachine.MpLink := ADR(gCncXYZ);
	CncMachine.Parameters := ADR(CncMachineParam);
	CncMachine();
	
	mpDataRecorderFB();
	mpDataRegX();
	mpDataRegY();
	mpDataRegZ();
	
	IF CncMachine.PowerOn THEN
		ledPowerOn := 'Solid_Gray_Green';
		btnIsOnOff := 'Off';
	ELSE
		ledPowerOn := 'Solid_Gray_Gray';
		btnIsOnOff := 'On';
	END_IF
	
	IF CncMachine.IsHomed THEN
		ledIsHome := 'Solid_Gray_Green';
	ELSE
		ledIsHome := 'Solid_Gray_Gray';
	END_IF
	
	IF CncMachine.Error THEN
		ledIsError := 'Solid_Gray_Red';
	ELSE
		ledIsError := 'Solid_Gray_Green';
	END_IF
	
END_PROGRAM

PROGRAM _EXIT
	
	 
END_PROGRAM

