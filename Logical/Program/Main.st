
PROGRAM _INIT
	(* Insert code here *)
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
	(* Insert code here *)
	CncMachine.MpLink := ADR(gCncXYZ);
	CncMachine.Parameters := ADR(CncMachineParam);
	CncMachine();
	
	mpDataRecorderFB();
	mpDataRegX();
	mpDataRegY();
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

