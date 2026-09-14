##############################################################################
# Compile + simulate : Cadence Xcelium (xrun)
# Waveform viewer    : SimVision
# Coverage           : QuestaSim (vlog / vsim / vcover)
#
# Based on the original QuestaSim makefile by Huy Nguyen (6/30/2019)
# Example run string: make TESTNAME={name_of_testcase} {optional}
#                     make TESTNAME=counter_test all
##############################################################################

#=============================================================================
# Variables
#=============================================================================
TESTNAME	?= reg_init_chk
TB_NAME		?= test_bench
RADIX		?= decimal
REGRESS_LIST	?= pat.list
FILELIST	?= compile.f

#---- Xcelium ---------------------------------------------------------------
XRUN		 = xrun
XRUN_ARCH	?= -64bit
XRUN_LANG	?= -sv
XRUN_ACCESS	?= -access +rwc
XRUN_TS		?= -timescale 1ns/1ps
XRUN_OPTS	?= $(XRUN_ARCH) $(XRUN_LANG) $(XRUN_ACCESS) $(XRUN_TS)

XRUN_LIB	 = xcelium.d
WAVE_DB		?= waves.shm
WAVE_TCL	 = xrun_wave.tcl

#---- QuestaSim (coverage flow only) ----------------------------------------
VLOG		 = vlog
VSIM		 = vsim
VCOVER		 = vcover
COV_OPT		?= bcesft

#=============================================================================
.PHONY: all all_wave all_cov prep build run run_wave wave gui \
	build_cov run_cov gen_cov gen_html clean help $(WAVE_TCL)

all: build run

all_wave: build run_wave wave

all_cov: build_cov run_cov

# Common preparation
prep:
	mkdir -p log
	cp -rf ../testcases/$(TESTNAME).v run_test.v

build: prep
	$(XRUN) -elaborate $(XRUN_OPTS) -f $(FILELIST) -top $(TB_NAME) -l compile.log
	cp compile.log ./log

run:
	$(XRUN) -R -l $(TESTNAME).log
	cp $(TESTNAME).log ./log
	mv $(TESTNAME).log sim.log

run_wave: $(WAVE_TCL)
	$(XRUN) -R -l $(TESTNAME).log -input $(WAVE_TCL)
	cp $(TESTNAME).log ./log
	mv $(TESTNAME).log sim.log

$(WAVE_TCL):
	@echo 'database -open -shm -into $(WAVE_DB) waves -default'		 > $(WAVE_TCL)
	@echo 'probe -create -database waves $(TB_NAME) -depth all -all'	>> $(WAVE_TCL)
	@echo 'run'								>> $(WAVE_TCL)
	@echo 'exit'								>> $(WAVE_TCL)

wave:
	simvision $(WAVE_DB) &

# Interactive debug: elaborate snapshot loaded directly into SimVision
gui:
	$(XRUN) -R -gui &

build_cov: prep
	vlib work
	vmap work work
	$(VLOG) +cover=$(COV_OPT) -f $(FILELIST) | tee compile_cov.log

run_cov:
	$(VSIM) -coverage -l $(TESTNAME).log -c $(TB_NAME) -voptargs="+access+cover=$(COV_OPT)" \
		-assertdebug -do "coverage save -onexit $(TESTNAME).ucdb; log -r /*;run -all"
	cp $(TESTNAME).log ./log
	mv $(TESTNAME).log sim_cov.log

gen_cov:
	mkdir -p coverage
	$(VCOVER) merge IP.ucdb *.ucdb
	$(VCOVER) report IP.ucdb -output coverage/summary_report.txt
	$(VCOVER) report -zeros -details -code $(COV_OPT) -annotate -All -codeAll IP.ucdb -output coverage/detail_report.txt

gen_html:
	mkdir -p coverage
	$(VCOVER) merge IP.ucdb *.ucdb
	$(VCOVER) report -zeros -details -code $(COV_OPT) -annotate -testhitdataAll -html IP.ucdb

clean:
	# Xcelium / SimVision
	rm -rf $(XRUN_LIB)
	rm -rf $(WAVE_DB)
	rm -rf $(WAVE_TCL)
	rm -rf .simvision
	rm -rf xrun.history xrun.log
	rm -rf *.key *.diag *.err
	rm -rf waves.shm.dir
	# QuestaSim
	rm -rf work
	rm -rf vsim.dbg
	rm -rf *.ini
	rm -rf *.wlf
	rm -rf transcript
	rm -rf *.ucdb
	rm -rf covhtmlreport
	# common
	rm -rf *.log
	rm -rf run_test.v

help:
	@echo ""
	@echo "****************************************"
	@echo "*** make build     : compile + elaborate with Xcelium"
	@echo "*** make run       : run simulation with Xcelium (no waveform)"
	@echo "*** make run_wave  : run simulation and dump SHM waveform"
	@echo "*** make wave      : open $(WAVE_DB) in SimVision"
	@echo "*** make gui       : load the snapshot into SimVision interactively"
	@echo "*** make all       : build and run"
	@echo "*** make all_wave  : build, run with dump, open SimVision"
	@echo "*** make build_cov : compile in coverage mode with QuestaSim"
	@echo "*** make run_cov   : run simulation in coverage mode with QuestaSim"
	@echo "*** make all_cov   : build and run in coverage mode (QuestaSim)"
	@echo "*** make gen_cov   : merge, generate coverage data base and text report"
	@echo "*** make gen_html  : merge, generate coverage data base and html report"
	@echo "*** make clean     : clean all compiled data"
	@echo "****************************************"
	@echo ""
