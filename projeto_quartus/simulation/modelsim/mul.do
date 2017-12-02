onerror {resume}
quietly WaveActivateNextPane {} 0
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
add wave -noupdate -expand /Processador/banco/registradores
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {23631 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {10510 ps} {104711 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue {-No Data-} -period 5ns -dutycycle 50 -starttime 0ns -endtime 100ns sim:/Processador/CLOCK_50 
wave create -driver freeze -pattern constant -value 0 -starttime 0ns -endtime 100ns sim:/Processador/reset 
wave edit change_value -start 0ps -end 3500ps -value 1 Edit:/Processador/reset 
WaveCollapseAll -1
wave clipboard restore
