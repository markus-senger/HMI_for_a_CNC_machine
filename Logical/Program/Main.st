
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
	
	mpAlarm.Enable := TRUE;
	mpAlarm.MpLink := ADR(gAlarmXCore);
	
	XMinLimit := -50;
	XMaxLimit := 50;
	YMinLimit := -50;
	YMaxLimit := 50;
	ZMinLimit := -50;
	ZMaxLimit := 50;
	 
END_PROGRAM

PROGRAM _CYCLIC
	CncMachine.MpLink := ADR(gCncXYZ);
	CncMachine.Parameters := ADR(CncMachineParam);
	CncMachine();
	
	mpAlarm();
	
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
	
	IF CncMachine.X < XMinLimit OR CncMachine.X > XMaxLimit THEN
		IF xLimitAlarmActive = FALSE THEN
			MpAlarmXSet(gAlarmXCore,'limitX');
			xLimitAlarmActive := TRUE;
		END_IF
		IF (CncMachine.X < XMinLimit AND CncMachineParam.Jog.Velocity[0] <= 0)
			OR (CncMachine.X > XMaxLimit AND CncMachineParam.Jog.Velocity[0] >= 0) THEN
			CncMachineParam.Jog.Velocity[0] := 0;
			endStopReachedX := TRUE;
		END_IF
	ELSE
		endStopReachedX := FALSE;
		xLimitAlarmActive := FALSE;
	END_IF
	
	IF acknowledge THEN
		MpAlarmXAcknowledge(gAlarmXCore,'limitX');
	END_IF
	
	IF reset THEN
		MpAlarmXReset(gAlarmXCore,'limitX');
	END_IF
	
	IF CncMachine.Y < YMinLimit OR CncMachine.Y > YMaxLimit THEN
		IF yLimitAlarmActive = FALSE THEN
			MpAlarmXSet(gAlarmXCore,'limitY');
			yLimitAlarmActive := TRUE;
		END_IF
		IF (CncMachine.Y < YMinLimit AND CncMachineParam.Jog.Velocity[1] <= 0)
			OR (CncMachine.Y > YMaxLimit AND CncMachineParam.Jog.Velocity[1] >= 0) THEN
			CncMachineParam.Jog.Velocity[1] := 0;
			endStopReachedY := TRUE;
		END_IF
	ELSE
		endStopReachedY := FALSE;
		yLimitAlarmActive := FALSE;
	END_IF
	
	IF acknowledge THEN
		MpAlarmXAcknowledge(gAlarmXCore,'limitY');
	END_IF
	
	IF reset THEN
		MpAlarmXReset(gAlarmXCore,'limitY');
	END_IF
	
	IF CncMachine.Z < ZMinLimit OR CncMachine.Z > ZMaxLimit THEN
		IF zLimitAlarmActive = FALSE THEN
			MpAlarmXSet(gAlarmXCore,'limitZ');
			zLimitAlarmActive := TRUE;
		END_IF
		IF (CncMachine.Z < ZMinLimit AND CncMachineParam.Jog.Velocity[2] <= 0)
				OR (CncMachine.Z > ZMaxLimit AND CncMachineParam.Jog.Velocity[2] >= 0) THEN
			CncMachineParam.Jog.Velocity[2] := 0;
			endStopReachedZ := TRUE;
		END_IF
	ELSE
		endStopReachedZ := FALSE;
		zLimitAlarmActive := FALSE;
	END_IF
	
	IF acknowledge THEN
		MpAlarmXAcknowledge(gAlarmXCore,'limitZ');
	END_IF
	
	IF reset THEN
		MpAlarmXReset(gAlarmXCore,'limitZ');
	END_IF
	
END_PROGRAM

PROGRAM _EXIT
	
	 
END_PROGRAM

