# $File: //ASP/opa/mct/iocs/MCTDEVIOC06/MCTDEVIOC06App/src/Makefile $
# $Revision: #1 $
# $DateTime: 2022/06/24 04:29:50 $
# Last checked in by: $Author: lewisw $
#
TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = MCTDEVIOC06
# MCTDEVIOC06.dbd will be created and installed
DBD += MCTDEVIOC06.dbd

# MCTDEVIOC06.dbd will be made up from these files:
MCTDEVIOC06_DBD += base.dbd
MCTDEVIOC06_DBD += system.dbd

ifdef BASE_7_0
# We are using EPICS 7.0 or later - pull in PV Access dbd files and libraries.
#
MCTDEVIOC06_DBD += PVAServerRegister.dbd
MCTDEVIOC06_DBD += qsrv.dbd

MCTDEVIOC06_LIBS += nt
MCTDEVIOC06_LIBS += pvAccess
MCTDEVIOC06_LIBS += pvAccessCA
MCTDEVIOC06_LIBS += pvAccessIOC
MCTDEVIOC06_LIBS += pvData
MCTDEVIOC06_LIBS += pvDatabase
MCTDEVIOC06_LIBS += qsrv
endif

# Autosave related dbd/libraries.
#
MCTDEVIOC06_DBD += asSupport.dbd
MCTDEVIOC06_LIBS += autosave

# IOC Status related dbd/libraries.
#
MCTDEVIOC06_DBD += IocStat.dbd
MCTDEVIOC06_LIBS += IocStat

# Signal handling related dbd/libraries (Linux only)
#
MCTDEVIOC06_DBD += signal_catch.dbd
MCTDEVIOC06_LIBS += signal_catch

# Include dbd files and libraries from all support applications
# needed by this IOC:
#

# MCTDEVIOC06_registerRecordDeviceDriver.cpp derives from MCTDEVIOC06.dbd
MCTDEVIOC06_SRCS += MCTDEVIOC06_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
MCTDEVIOC06_SRCS_DEFAULT += MCTDEVIOC06Main.cpp
MCTDEVIOC06_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#MCTDEVIOC06_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
MCTDEVIOC06_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

# end
