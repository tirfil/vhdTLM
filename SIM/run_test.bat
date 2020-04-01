set FLAG=-v -PALL_LIB --syn-binding --ieee=synopsys --std=93c -fexplicit

ghdl -e --work=WORK --workdir=ALL_LIB %FLAG% testtop
ghdl -r --work=WORK --workdir=ALL_LIB %FLAG% testtop --wave=testtop.ghw

