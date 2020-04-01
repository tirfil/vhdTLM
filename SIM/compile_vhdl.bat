set FLAG=-v -PALL_LIB --syn-binding --ieee=synopsys --std=93c -fexplicit
rem set FLAG=-v -PALL_LIB --syn-binding --std=08 -fexplicit
ghdl -a --work=WORK --workdir=ALL_LIB %FLAG% ../VHDL/dp8x8.vhd
ghdl -a --work=WORK --workdir=ALL_LIB %FLAG% ../TEST/test_pkg.vhd
ghdl -a --work=WORK --workdir=ALL_LIB %FLAG% ../TEST/bfmcpu.vhd
ghdl -a --work=WORK --workdir=ALL_LIB %FLAG% ../TEST/testctrl.vhd
ghdl -a --work=WORK --workdir=ALL_LIB %FLAG% ../TEST/testtop.vhd
