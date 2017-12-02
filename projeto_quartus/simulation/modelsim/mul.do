onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Processador/ctrl/clk
add wave -noupdate /Processador/ctrl/inst
add wave -noupdate /Processador/ctrl/controle_a
add wave -noupdate /Processador/ctrl/regs_a
add wave -noupdate /Processador/ctrl/controle_b
add wave -noupdate /Processador/ctrl/regs_b
add wave -noupdate /Processador/ctrl/controle_c
add wave -noupdate /Processador/ctrl/regs_c
add wave -noupdate /Processador/banco/regA
add wave -noupdate /Processador/banco/regB
add wave -noupdate /Processador/banco/dado
add wave -noupdate /Processador/banco/regC
add wave -noupdate /Processador/banco/regsaidaA
add wave -noupdate /Processador/banco/regsaidaB
add wave -noupdate /Processador/alu/codop
add wave -noupdate /Processador/alu/operando1
add wave -noupdate /Processador/alu/operando2
add wave -noupdate /Processador/alu/mulH
add wave -noupdate /Processador/alu/mulL
add wave -noupdate /Processador/alu/resultado
add wave -noupdate /Processador/CLOCK_50
add wave -noupdate /Processador/reset
add wave -noupdate /Processador/banco/registradores
add wave -noupdate /Processador/CLOCK_50
add wave -noupdate /Processador/reset
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {23631 ps} 0} {{Cursor 2} {6975 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 251
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {94201 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue {-No Data-} -period 5ns -dutycycle 50 -starttime 0ns -endtime 100ns sim:/Processador/CLOCK_50 
wave create -driver freeze -pattern constant -value 0 -starttime 0ns -endtime 100ns sim:/Processador/reset 
wave edit change_value -start 0ps -end 3500ps -value 1 Edit:/Processador/reset 
wave edit change_value -start 0ps -end 4010ps -value 0 Edit:/Processador/reset 
wave edit change_value -start 0ps -end 3400ps -value 0 Edit:/Processador/CLOCK_50 
WaveCollapseAll -1
wave clipboard restore
