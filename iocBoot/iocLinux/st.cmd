#!../../bin/linux-x86_64/ThorlabsDDS

< envPaths

epicsEnvSet("STREAM_PROTOCOL_PATH","../../db")

################################################################################
# Tell EPICS all about the record types, device-support modules, drivers,
# etc. in the software we just loaded
dbLoadDatabase("../../dbd/ThorlabsDDS.dbd")
ThorlabsDDS_registerRecordDeviceDriver(pdbbase)

### Confiugure Motor Controllers ###
drvAsynIPPortConfigure("TLBBD", "flute-econ-1s05:9001 TCP", 0, 0, 0)

#asynSetTraceFile("TLBBD", -1, "$(TOP)/async.log")

# print error       0x01
# print device IO   0x02
# print filtering   0x04
# print all above   0x07
# print driver IO   0x08
asynSetTraceMask("TLBBD",-1,0x01)

# print nothing     0x00
# print with ASCII  0x01
# print with excape 0x02
# print with hex    0x04
asynSetTraceIOMask("TLBBD",-1,0x04)

#asynSetTraceIOMask("TLBBD",-1,0x9)
#asynSetTraceMask("TLBBD",-1,0x4)
 
#asynSetTraceMask("TLBBD", 0, 31)
#asynSetTraceIOMask("TLBBD", 0, 7)

### save_restore setup
# We presume a suitable initHook routine was compiled into EOSMotorsApp.munch.
# See also create_monitor_set(), after iocInit() .
#< save_restore.cmd

### Load Records ###

# Parameters:
# DEV  - device PV prefix
# MOD  - module number {1|2|3}. Model BBD203 has 3 modules. Each module is a single channel module,  
#        so device calls always refer to 01 channel number.

dbLoadRecords("../../db/ThorlabsDDS.db", "PORT=TLBBD,DEV=F:TEST:TLSSD:01,MOD=1")
dbLoadRecords("../../db/ThorlabsDDS.db", "PORT=TLBBD,DEV=F:TEST:TLSSD:02,MOD=2")
dbLoadRecords("../../db/ThorlabsDDS.db", "PORT=TLBBD,DEV=F:INJ-1:TLSSD:01,MOD=3")

# Parameters:
# DEV  - device PV prefix
# SCAN - Scan field value: .1, .2, .5, 1, 2, 5, 10
# DEV1,DEV2,DEV3 - device prefixes in update rotation 

dbLoadRecords("../../db/ThorlabsDDSUpdate.db", "PORT=TLBBD,SCAN=.5,DEV=F:TEST:TLSSD:13,DEV1=F:TEST:TLSSD:01,DEV2=F:TEST:TLSSD:02,DEV3=F:INJ-1:TLSSD:01")



#dbLoadRecords("../../db/ThorlabsBBD203.db", "PORT=TLBBD,DEV1=F:TEST:TLSSD:01,SCAN1=10,MOD1=1,DEV2=F:TEST:TLSSD:02,SCAN2=10,MOD2=2")

#dbLoadTemplate "../../db/ThorlabsBBD203.substitutions"

# Dump the list of records to a file.
#dbl > "$(EPICS_AUTOPVLIST_IOC_FILE)"

iocInit

### Start up the autosave task and tell it what to do.
# The task is actually named "save_restore".
# Note that you can reload these sets after creating them: e.g., 
# reload_monitor_set("auto_settings.req",30,"P=SR:OrbitCheck:,R=")
#save_restoreDebug=20
#
# save motor positions every ten seconds
#create_monitor_set("laserMotorPositions.req", 10, "P=A:EO:Laser:,R=01:")
