# -*- coding: utf-8 -*-
# UNICOS
# (c) Copyright CERN 2013 all rights reserved
# $LastChangedRevision$
from java.util import Vector
from java.util import ArrayList

#Additional required modules
from research.ch.cern.unicos.templateshandling import IUnicosTemplate  # REQUIRED
from research.ch.cern.unicos.plugins.interfaces import APlugin  # REQUIRED
from research.ch.cern.unicos.plugins.interfaces import IPlugin  # REQUIRED
from java.lang import System
from time import strftime

import S7Logic_DefaultAlarms_Template
reload(S7Logic_DefaultAlarms_Template)


def GLLogic(thePlugin, theUnicosProject, master, name, LparamVector):

    Lparam1, Lparam2, Lparam3, Lparam4, Lparam5, Lparam6, Lparam7, Lparam8, Lparam9, Lparam10 = S7Logic_DefaultAlarms_Template.getLparametersSplit(LparamVector)
    
    function = Lparam1

# Step 1. Create the FUNCTION called DeviceName_GL.
    theSectionText = ('''
DATA_BLOCK DB30

//
// Block contaning info for power cut
//
    STRUCT
        CS0d_C0_GP5020_old   : BOOL;     
        CS0d_P1_ST4a54_INC   : ARRAY[1..5] OF REAL;
        CS0d_P2_ST4c54_INC   : ARRAY[1..5] OF REAL;
    END_STRUCT
BEGIN
END_DATA_BLOCK    
    
    
FUNCTION $name$_GL : VOID
TITLE = '$name$_GL'
//
// Global Logic of $name$
//
(*
 Lparam1:	$Lparam1$
 Lparam2:	$Lparam2$
 Lparam3:	$Lparam3$
 Lparam4:	$Lparam4$
 Lparam5:	$Lparam5$
 Lparam6:	$Lparam6$
 Lparam7:	$Lparam7$
 Lparam8:	$Lparam8$
 Lparam9:	$Lparam9$
 Lparam10:	$Lparam10$
*)
//
AUTHOR: 'ICE/PLC'
NAME: 'Logic_GL'
FAMILY: 'GL'
''')

    # Third static variables
    theSectionText = theSectionText +'''
VAR_TEMP
    old_status : DWORD;
    sat_temp : REAL;
    _Tsat_CO2_A : REAL;
    _Tsat_CO2_B : REAL;
    _Tsat_CO2_C : REAL;
    _Tsat_R449a_A : REAL;
    _Tsat_R449a_B : REAL;
    _Tsat_R449a_C : REAL;
    mode_RTM_LC : INT;
    mode_RTM_WT : INT;
    _DTCS_GP5020_TLEN : INT;
    count_r : INT; //add statement to check if its necessary
    time_DT : DATE_AND_TIME;
    time_point : DINT;
    timeofday : TOD;'''
    
    theSectionText = theSectionText +'''
END_VAR
BEGIN
_Tsat_CO2_A := 10.77;
_Tsat_CO2_B := -1956;
_Tsat_CO2_C := 271.04;
_Tsat_R449a_A := 4.26;
_Tsat_R449a_B := 857.96;
_Tsat_R449a_C := 31.85;
'''


#--------------------------------------------------------PLC Logic Functions (Lparam1)-------------------------------------------------------------------
# Subtraction
# CO2Saturation
# Max
# AHOT
# AND
# R404Saturation
# MotorWorkingTime
# FreeCalc
# CompressorStartCnt
# Limitation function
# LiveCounter
# DC_CB_Reset
#
#
#
#



    thePlugin.writeSiemensLogic('''
// ----------------------------------------------------- USER code <begin>------------------------------------------------------------
''')

#--------------------------------------------------------AIR---------------------------------------------------------------------------

    #Return all AIR obejects
    AIRType = theUnicosProject.findMatchingInstances("AnalogInputReal","'#DeviceDocumentation:Description#'!='SPARE'" )
    
    for AIR in AIRType:
        #Get AIR object name
        AIRName = AIR.getAttributeData("DeviceIdentification:Name")
        AIRDescription= AIR.getAttributeData("DeviceDocumentation:Description")
        AIRMinRange = AIR.getAttributeData("FEDeviceParameters:Range Min")
        
        #Get AIR parameters
        Param1 = AIR.getAttributeData ("LogicDeviceDefinitions:CustomLogicParameters:Parameter1")
        Param2 = AIR.getAttributeData ("LogicDeviceDefinitions:CustomLogicParameters:Parameter2")
        Param3 = AIR.getAttributeData ("LogicDeviceDefinitions:CustomLogicParameters:Parameter3")
        Param4 = AIR.getAttributeData ("LogicDeviceDefinitions:CustomLogicParameters:Parameter4")
        Param5 = AIR.getAttributeData ("LogicDeviceDefinitions:CustomLogicParameters:Parameter5")
        Param6 = AIR.getAttributeData ("LogicDeviceDefinitions:CustomLogicParameters:Parameter6")
        Param7 = AIR.getAttributeData ("LogicDeviceDefinitions:CustomLogicParameters:Parameter7")
        Param8 = AIR.getAttributeData ("LogicDeviceDefinitions:CustomLogicParameters:Parameter8")
        Param9 = AIR.getAttributeData ("LogicDeviceDefinitions:CustomLogicParameters:Parameter9")
        Param10 = AIR.getAttributeData ("LogicDeviceDefinitions:CustomLogicParameters:Parameter10")
        
        #Readable variable names
        function = Param1
        
        #Extract name
        AIRName_split = AIRName.split("_")
        AIRDB = "DB_AIR_ALL.AIR_SET."+AIRName
        AIRHFPos = "DB_AIR_ALL.AIR_SET."+AIRName + ".HFPos"
        AIRIOError = "DB_AIR_ALL.AIR_SET." + AIRName + ".IOError"
        AIRIOSimu = "DB_AIR_ALL.AIR_SET." + AIRName + ".IOSimu"
        Param2_List = Param2.split(",")	# transforms the string of characters with declared used variables separated by coma into a list of these variables
        
        
        
        #Subtraction
        #function: Subtraction
        #Param2: Variable1, Variable2
        if (function == "Subtraction") and (len(Param2_List)==2):
            float_S1 = None
            float_S2 = None
            S1 = Param2_List[0].strip()		# Variable 1
            S2 = Param2_List[1].strip()		# Variable 2
            prefix = ""
            prefixS1 = "DB_AI_ALL.AI_SET."
            prefixS2 = "DB_AI_ALL.AI_SET."
            if isAIR(S1):
                prefixS1="DB_AIR_ALL.AIR_SET."
            if isAIR(S2):
                prefixS2="DB_AIR_ALL.AIR_SET."
            try:
                float_S1 = float(S1)
            except: pass
            try:
                float_S2 = float(S2)
            except: pass
            S1_OK = ObjectInSpecs(S1) or isinstance(float_S1,float)
            S2_OK = ObjectInSpecs(S2) or isinstance(float_S2,float)

            if (len(Param2_List)==2) and S1_OK and S2_OK: # generate only if there is consistent values
                Input_IOError = []
                Input_IOSimu = []
                Input_FoMoSt = []
                for x in Param2_List:
                    x=x.strip()
                    if isAIR(x):
                        prefix="DB_AIR_ALL.AIR_SET."
                    else:
                        prefix="DB_AI_ALL.AI_SET."
                    if IOErrorSimuEligible(x):
                        Input_IOError.append(prefix+x+".IOErrorW")
                        Input_IOSimu.append(prefix+x+".IOSimuW")
                        Input_FoMoSt.append(prefix+x+".FoMoSt")
                    else: 
                        Input_IOError.append("0")
                        Input_IOSimu.append("0")
                        Input_FoMoSt.append("0")
                S_IOError = AIRIOError + " := " + " OR \n".join(Input_IOError) + ";"
                S_IOSimu = " OR \n".join(Input_IOSimu)
                S_FoMoSt = " OR \n".join(Input_FoMoSt)
                if not isinstance(float_S1,float) and not isinstance(float_S2,float):
                    S_HFPos = AIRHFPos + " := "+prefixS1 + S1 + ".PosSt - "+ prefixS2 + S2 + ".PosSt;"
                elif isinstance(float_S1,float) and not isinstance(float_S2,float):
                    S_HFPos = AIRHFPos + " := " + S1 + " - " + prefixS2 + S2 + ".PosSt;"
                elif not isinstance(float_S1,float) and isinstance(float_S2,float):
                    S_HFPos = AIRHFPos + " := "+prefixS1 + S1 + ".PosSt - " + S2 + ";"
                
                textContent_Subtraction = textContent_Subtraction + ('''(*Subtraction calculation: $AIRName$ - $AIRDescription$*)\n$S_HFPos$ \n$S_IOError$\n$AIRIOSimu$ := $S_IOSimu$ OR $S_FoMoSt$;\n\n''')
            else:
                thePlugin.writeWarningInUABLog("Param2 variables can not be found in the specs or is not a float for $AIRName$! The calculation for $Param1$ function has not been generated. S1: "+str(S1_OK)+" S2: "+str(S2_OK))
        # Detection of wrong quantity of variables for the Subtraction function
        elif (Param1 == "Subtraction") and (Param2 <> "") and (len(Param2_List) > 2):
            thePlugin.writeWarningInUABLog("More than 2 variables used in Subtraction calculation for $AIRName$! The calculation for $Param1$ function has not been generated.")
        elif (Param1 == "Subtraction") and (Param2 <> "") and (len(Param2_List) < 2):
            thePlugin.writeWarningInUABLog("Missing variables in Subtraction calculation for $AIRName$! The calculation for $Param1$ function has not been generated.")
        # Detection of empty Param2: no variable
        elif (Param1 == "Subtraction") and (Param2 == ""):
            thePlugin.writeWarningInUABLog("No variable in Param2 for $AIRName$! The calculation for $Param1$ function has not been generated.")
    
    
        #CO2 saturation temperature function
        #Param1: SaturationCO2
        #Calculate CO2 saturation temperature
        #Param1: SaturationCO2
        #Param2: Pressure sensor for the calculation
        if (Param1 == "SaturationCO2") and (Param2 <> "") and IOErrorSimuEligible(Param2):
            S_HFPos = '''IF DB_AI_ALL.AI_SET.$Param2$.PosSt >= 73.77 THEN
    sat_temp := _Tsat_CO2_B/((LN(IN:=73.77))-_Tsat_CO2_A)-_Tsat_CO2_C;
    DB_AIR_ALL.AIR_SET.$AIRName$.HFPos := sat_temp - 7.8013e-08*(sat_temp*sat_temp*sat_temp*sat_temp) + 1.0773e-05*(sat_temp*sat_temp*sat_temp) + 0.00023077*(sat_temp**2) - 0.007166*sat_temp - 0.089753;
ELSIF DB_AI_ALL.AI_SET.$Param2$.PosSt <= 5.18 THEN
    sat_temp := _Tsat_CO2_B/((LN(IN:=5.18))-_Tsat_CO2_A)-_Tsat_CO2_C;
    DB_AIR_ALL.AIR_SET.$AIRName$.HFPos := sat_temp - 7.8013e-08*(sat_temp*sat_temp*sat_temp*sat_temp) + 1.0773e-05*(sat_temp*sat_temp*sat_temp) + 0.00023077*(sat_temp**2) - 0.007166*sat_temp - 0.089753;
ELSE
    sat_temp := _Tsat_CO2_B/((LN(IN:=DB_AI_ALL.AI_SET.$Param2$.PosSt))-_Tsat_CO2_A)-_Tsat_CO2_C;
    DB_AIR_ALL.AIR_SET.$AIRName$.HFPos := sat_temp - 7.8013e-08*(sat_temp*sat_temp*sat_temp*sat_temp) + 1.0773e-05*(sat_temp*sat_temp*sat_temp) + 0.00023077*(sat_temp**2) - 0.007166*sat_temp - 0.089753;
END_IF;
'''
            S_IOError = AIRIOError + " := DB_AI_ALL.AI_SET." + Param2 + ".IOErrorW;"
            S_IOSimu = "DB_AI_ALL.AI_SET."+Param2 + ".IOSimuW"
            S_FoMoSt = "DB_AI_ALL.AI_SET."+Param2 + ".FoMoSt;"
            textContent_ST_CO2 = textContent_ST_CO2 + ('''(*CO2 Saturation Temperature calculation: $AIRName$ - $AIRDescription$*)\n$S_HFPos$\n$S_IOError$\n$AIRIOSimu$ := $S_IOSimu$ OR $S_FoMoSt$\n\n''')
        elif (Param1 == "SaturationCO2") and (Param2 <> "") and not IOErrorSimuEligible(Param2):
            thePlugin.writeWarningInUABLog("The Param2 can not be used for $AIRName$! The calculation for $Param1$ function has not been generated.")
        # Detection of empty Param2: no variable
        elif (Param1 == "SaturationCO2") and (Param2 == ""):
            thePlugin.writeWarningInUABLog("No variable in Param2 for $AIRName$! The calculation for $Param1$ function has not been generated.")

        # R449a saturation temperature function
        # Param1: SaturationR449a
        # Calculate R449a saturation temperature
        # Param1: SaturationR449a
        # Param2: Pressure sensor for the calculation
        if (Param1 == "SaturationR449a") and (Param2 <> "") and IOErrorSimuEligible(Param2):
           S_HFPos =   '''DB_AIR_ALL.AIR_SET.$AIRName$.HFPos := _Tsat_R449a_B/(_Tsat_R449a_A-(LN(IN:=DB_AI_ALL.AI_SET.$Param2$.PosSt)))-(273.15-_Tsat_R449a_C);'''
           S_IOError = AIRIOError + " := DB_AI_ALL.AI_SET." + Param2 + ".IOErrorW;"
           S_IOSimu = "DB_AI_ALL.AI_SET."+Param2 + ".IOSimuW "
           S_FoMoSt = "DB_AI_ALL.AI_SET."+Param2 + ".FoMoSt;"
           textContent_ST_R449a = textContent_ST_R449a + ('''(*R449a Saturation Temperature calculation: $AIRName$ - $AIRDescription$*)\n$S_HFPos$\n$S_IOError$\nDB_AIR_ALL.AIR_SET.$AIRName$.IOSimu := $S_IOSimu$ OR $S_FoMoSt$\n\n''')
        if (Param1 == "SaturationR449a") and (Param2 <> "") and not IOErrorSimuEligible(Param2):
            thePlugin.writeWarningInUABLog("The Param2 can not be used for $AIRName$! The calculation for $Param1$ function has not been generated.")
        # Detection of empty Param2: no variable
        if (Param1 == "SaturationR449a") and (Param2 == ""):
            thePlugin.writeWarningInUABLog("No variable in Param2 for $AIRName$! The calculation for $Param1$ function has not been generated.")

        #MAX function
        #Param1: MAX
        #Param2 all values for the calculation separated by a ","
        # calculate any MAX function
        if (Param1 == "MAX") and (Param2 <> ""):
            Sensors_value = []
            Sensors_IOError = []
            Sensors_IOSimu = []
            Sensors_FoMoSt = []
            prefix = ""
            n=1
            for x in Param2.split(','):
                x = x.strip()
                prefix = "DB_AI_ALL.AI_SET."
                if isAIR(x):
                    prefix = "DB_AIR_ALL.AIR_SET."
                if IOErrorSimuEligible(x):
                    x = prefix+x
                    Sensors_value.append("IN$n$:="+x+".PosSt")
                    Sensors_IOError.append(x+".IOErrorW")
                    Sensors_IOSimu.append(x+".IOSimuW")
                    Sensors_FoMoSt.append(x+".FoMoSt")
                else:
                    Sensor_value_Temp = x.split(".")
                    if len(Sensor_value_Temp)==1:
                        if Sensor_value_Temp[0].isdigit():
                            Sensors_value.append(x+".0")
                        else:
                            thePlugin.writeWarningInUABLog("The Parameter: -$x$- is not present in the specs file and has been treated like a PLC internal value for the calculation of $AIRName$!")
                    if len(Sensor_value_Temp)==2:
                        if Sensor_value_Temp[0].isdigit():
                            if Sensor_value_Temp[1].isdigit():
                                Sensors_value.append(x)
                        else:
                            if IOErrorSimuEligible(Sensor_value_Temp[0]) and Sensor_value_Temp[0] <> "":
                                Sensors_value.append(prefix+x)
                                Sensors_IOError.append(Sensor_value_Temp[0]+".IOErrorW")
                                Sensors_IOSimu.append(Sensor_value_Temp[0]+".IOSimuW")
                                Sensors_FoMoSt.append(Sensor_value_Temp[0]+".FoMoSt")
                            else:
                                thePlugin.writeWarningInUABLog("The Parameter: -$x$- is not present in the specs file and has been treated like a PLC internal value for the calculation of $AIRName$!")
                n=n+1
            MAX_input = "MAX"+"(" + ",\n".join(Sensors_value) + ")"
            MAX_IOError = " OR \n".join(Sensors_IOError)
            MAX_IOSimu = " OR \n".join(Sensors_IOSimu)
            MAX_FoMoSt = " OR \n".join(Sensors_FoMoSt)
            S_HFPos = AIRHFPos + " := " + MAX_input + ";"
            S_IOError = AIRIOError + " := " + MAX_IOError + ";"
            S_IOSimu = AIRIOSimu + " := " + MAX_IOSimu + " OR \n" + MAX_FoMoSt + ";"
            textContent_max = textContent_max + ('''(*MAX calculation: $AIRName$ - $AIRDescription$*)\n$S_HFPos$\n$S_IOError$\n$S_IOSimu$\n\n''')

        # Detection of empty Param2: no variable
        elif (Param1 == "MAX") and (Param2 == ""):
            thePlugin.writeWarningInUABLog("No variable in Param2 for $AIRName$! The calculation for $Param1$ function has not been generated.")
            
