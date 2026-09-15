##################################################################################################
#This file created by Huy Nguyen
#Updated date: 6/30/2019
#Example run string: make TESTNAME={name_of_testcase} {optional}
#                    make TESTNAME=counter_test all
##################################################################################################
#Define variables
TESTNAME	?= reg_init
TB_NAME		?= test_bench
RADIX		?= decimal
REGRESS_LIST	?= pat.list

#==============================
all: build run

all_wave: build run wave

all_cov: build_cov run_cov

build:
	mkdir -p log
	cp -rf ../testcases/$(TESTNAME).v run_test.v
	vlib work
	vmap work work
	vlog  -f compile.f | tee compile.log
build_cov:
	mkdir -p log
	cp -rf ../testcases/$(TESTNAME).v run_test.v
	vlib work
	vmap work work
	vlog +cover=bcesft -f compile.f
run:
	vsim -debugDB -l $(TESTNAME).log -voptargs=+access -assertdebug -c $(TB_NAME) -do "log -r /*;run -all;"
	cp $(TESTNAME).log ./log
	mv $(TESTNAME).log sim.log
run_cov:
	vsim -debugDB -coverage -l $(TESTNAME).log -c $(TB_NAME) -voptargs="+access+cover=bcesft" -assertdebug -do "coverage save -onexit $(TESTNAME).ucdb; log -r /*;run -all"
	cp $(TESTNAME).log ./log
	mv $(TESTNAME).log sim.log
wave:
	vsim -i -view vsim.wlf -do "add wave vsim:/$(TB_NAME)/*; radix -$(RADIX)" &
gen_cov:
	mkdir -p coverage
	vcover merge IP.ucdb *.ucdb
	vcover report IP.ucdb -output coverage/summary_report.txt
	vcover report -zeros -details -code bcesft -annotate -All -codeAll IP.ucdb -output coverage/detail_report.txt
	#vcover report -zeros -details -code bcesft -All -codeAll IP.ucdb -output coverage/detail_report.txt
view_cov:
	vsim -gui -viewcov IP.ucdb &
gen_html:
	mkdir -p coverage
	vcover merge IP.ucdb *.ucdb
	vcover report -zeros -details -code bcesft -annotate -testhitdataAll -html IP.ucdb
clean:
	rm -rf work
	rm -rf vsim.dbg
	rm -rf *.ini
	rm -rf *.log
	rm -rf *.wlf
	rm -rf transcript
	rm -rf *.ucdb
	rm -rf run_test.v
apb:
	make all TESTNAME=apb_multiple_access
	make all TESTNAME=apb_protocol_chk
	make all TESTNAME=apb_pslverr_chk
	make all TESTNAME=apb_unaligned
cnt:
	make all TESTNAME=cnt_counting_chk
	make all TESTNAME=cnt_ctrl_chk
	make all TESTNAME=cnt_halt_chk
reg:
	make all TESTNAME=reg_1hot_chk
	make all TESTNAME=reg_byte_access
	make all TESTNAME=reg_init_chk
	make all TESTNAME=reg_reserved_chk
	make all TESTNAME=reg_rw_chk
interrupt:
	make all TESTNAME=interrupt_chk
help:
	@echo ""
	@echo "****************************************"
	@echo "** make clean    : clean all compiled data"
	@echo "** make build    : build the design"
	@echo "** make build_cov: build the design in coverage mode"
	@echo "** make run      : run simulation"
	@echo "** make run_cov  : run simulation in coverage mode"
	@echo "** make all      : build and run simulation"
	@echo "** make all_cov  : build and run simulation in coverage mode"
	@echo "** make wave     : open waveform"
	@echo "** make gen_cov  : merge, generate coverage data base and text coverage report"
	@echo "** make gen_cov  : merge, gemerate coverage data base and html coverage report"
	@echo "****************************************"
	@echo ""
