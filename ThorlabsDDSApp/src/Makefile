TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = ThorlabsDDS

# EOSMotors.dbd will be created and installed
DBD += ThorlabsDDS.dbd

# EOSMotors.dbd will be made up from these files:
ThorlabsDDS_DBD += base.dbd
ThorlabsDDS_DBD += asyn.dbd
ThorlabsDDS_DBD += drvAsynIPPort.dbd
ThorlabsDDS_DBD += calc.dbd
ThorlabsDDS_DBD += stream.dbd

# Add all the support libraries needed by this IOC
ThorlabsDDS_LIBS += asyn
ThorlabsDDS_LIBS += calc
ThorlabsDDS_LIBS += stream

# EOSMotors_registerRecordDeviceDriver.cpp derives from EOSMotors.dbd
ThorlabsDDS_SRCS += ThorlabsDDS_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
ThorlabsDDS_SRCS_DEFAULT += ThorlabsDDSMain.c
ThorlabsDDS_SRCS_vxWorks += -nil-

# Finally link to the EPICS Base libraries
ThorlabsDDS_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE
