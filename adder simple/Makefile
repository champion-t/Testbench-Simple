VLOG_PATH = /mnt/c/questasim64_10.7c/win64/vlog.exe
VSIM_PATH = /mnt/c/questasim64_10.7c/win64/vsim.exe

ll: compile sim view

compile:
	$(VLOG_PATH) -f filelist.f
sim_gui:
	$(VSIM_PATH) -voptargs="+acc" work.tb
sim_console:
	$(VSIM_PATH) -c -voptargs="+acc" work.tb
view:
	gtkwave dump.vcd