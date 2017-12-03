onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Processador/CLOCK_50
add wave -noupdate /Processador/memi_out
add wave -noupdate /Processador/PC
add wave -noupdate /Processador/extPC
add wave -noupdate /Processador/dado
add wave -noupdate /Processador/zero
add wave -noupdate /Processador/aux
add wave -noupdate /Processador/reset
add wave -noupdate /Processador/resH
add wave -noupdate /Processador/resL
add wave -noupdate /Processador/codeop
add wave -noupdate /Processador/endRegC
add wave -noupdate /Processador/endRegA
add wave -noupdate /Processador/endRegB
add wave -noupdate /Processador/controle_a
add wave -noupdate /Processador/regs_a
add wave -noupdate /Processador/controle_b
add wave -noupdate /Processador/regs_b
add wave -noupdate /Processador/controle_c
add wave -noupdate /Processador/regs_c
add wave -noupdate /Processador/resultadoALU
add wave -noupdate /Processador/saidaA
add wave -noupdate /Processador/saidaB
add wave -noupdate /Processador/resultadoMuxAluA
add wave -noupdate /Processador/resultadoMuxAluB
add wave -noupdate /Processador/data
add wave -noupdate /Processador/extEndRegB
add wave -noupdate /Processador/j_imm
add wave -noupdate /Processador/resultadoMux
add wave -noupdate /Processador/banco/registradores
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 341
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {96134 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue {Not Logged} -period 5ns -dutycycle 50 -starttime 0ns -endtime 100ns sim:/Processador/CLOCK_50 
WaveCollapseAll -1
wave clipboard restore
