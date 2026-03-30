#===============================================================================
# Makefile for Nibble CPU Testbench
# Supports both basic ($urandom) and randomization (+define+RAND) versions
# Simulator: Mentor Questa/ModelSim (adjust VLOG/VSIM for other tools)
#===============================================================================

# Simulator commands
VLOG     = vlog 
VSIM     = vsim
WORK     = work

# Source files in compilation order

SRC_RTL = instr_decoder.v\
	alu.v \
  reg_file.v\
  top.v
 

SRC_MEM   = ram.v
SRC_TOP   = top_tb.v


SRC_ALL   = $(SRC_RTL) $(SRC_MEM) $(SRC_TOP)

# Compilation flags
BASIC_FLAGS = +acc


#------------------------------------------------------------------------------
# Targets
#------------------------------------------------------------------------------
.PHONY: all comp_basic comp_rand run run_rand clean help

all: comp_basic

# Basic version (no randomization)
comp_basic: 
	$(VLOG) $(BASIC_FLAGS) $(SRC_ALL)


# Run basic version (command line)
run: comp_basic
	$(VSIM)  top_tb -do "log -r /* ;do wave.do;run -all;"


# Clean generated files
clean:
	rm -rf $(WORK) transcript vsim.wlf
