#!/bin/bash
ghdl -a --ieee=synopsys -fexplicit *.vhd
ghdl -e --ieee=synopsys -fexplicit TB_MAIN_PROCESSOR
ghdl -r --ieee=synopsys -fexplicit tb_main_processor --vcd=EXECUTA.vcd
