onbreak {quit -f}
onerror {quit -f}

vsim  -lib xil_defaultlib BUFF1B_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {BUFF1B.udo}

run 1000ns

quit -force
