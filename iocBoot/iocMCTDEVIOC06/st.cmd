#!../../bin/linux-x86_64/MCTDEVIOC06
#
# $File: //ASP/opa/mct/iocs/MCTDEVIOC06/iocBoot/iocMCTDEVIOC06/st.cmd $
# $Revision: #4 $
# $DateTime: 2022/06/24 05:34:48 $
# Last checked in by: $Author: lewisw $
#

## You may have to change MCTDEVIOC06 to something else
## everywhere it appears in this file

< envPaths

# Usually set by epics.service script
epicsEnvSet ("IOCNAME", "MCTDEVIOC06")
epicsEnvSet ("IOCSH_PS1","MCTDEVIOC06> ")
epicsEnvSet ("AS_PATH", "/asp/autosave/$(IOCNAME)")

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/MCTDEVIOC06.dbd"
MCTDEVIOC06_registerRecordDeviceDriver pdbbase

## Autosave set-up
#
< ${AUTOSAVESETUP}/crapi/save_restore.cmd
set_requestfile_path ("${AS_PATH}")

## Restore auto save like this ....
set_pass0_restoreFile("info_settings.sav")
set_pass1_restoreFile("info_settings.sav")
set_pass0_restoreFile("info_positions.sav")

## Load record instances

# Allow epics service script to initiate clean shutdown by performing
#   caput MCTDEVIOC06:exit.PROC 1
#
dbLoadRecords ("${EPICS_BASE}/db/softIocExit.db", "IOC=${IOCNAME}")

# Load standard bundle build status and IOC (and host) monitoring records.
#
dbLoadRecords ("${BUNDLESTATUS}/db/build.template", "IOC=${IOCNAME}")
dbLoadRecords ("${IOCSTATUS}/db/IocStatus.template", "IOC=${IOCNAME}")

# Load the VBM stripe control database
#
dbLoadRecords ("db/MCTVBM01_position_status.db", "P=MCTVBM01:")

cd ${TOP}/iocBoot/${IOC}
iocInit

## Autosave monitor set-up.
#
cd ${AS_PATH}
makeAutosaveFiles()
cd ${TOP}/iocBoot/${IOC}

create_monitor_set("info_positions.req", 5, "")
create_monitor_set("info_settings.req", 15, "")

# Catch SIGINT and SIGTERM - do an orderly shutdown
#
catch_sigint
catch_sigterm

# Update the firewall to allow use of arbitary port number
#
#system firewall_update

# Dump all record names
#
dbl > /asp/logs/ioc/${IOCNAME}/${IOC}.dbl


## Start any sequence programs

# end
