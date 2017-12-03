onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /Processador/controle_a
add wave -noupdate -radix hexadecimal /Processador/controle_b
add wave -noupdate -radix hexadecimal /Processador/controle_c
add wave -noupdate -radix hexadecimal /Processador/regs_a
add wave -noupdate -radix hexadecimal /Processador/regs_b
add wave -noupdate -radix hexadecimal /Processador/regs_c
add wave -noupdate -radix unsigned /Processador/resultadoALU
add wave -noupdate -radix unsigned /Processador/resultadoMuxAluA
add wave -noupdate -radix unsigned /Processador/resultadoMuxAluB
add wave -noupdate -radix unsigned /Processador/saidaA
add wave -noupdate -radix unsigned /Processador/saidaB
add wave -noupdate -childformat {{{/Processador/banco/registradores[15]} -radix unsigned} {{/Processador/banco/registradores[14]} -radix unsigned} {{/Processador/banco/registradores[13]} -radix unsigned} {{/Processador/banco/registradores[12]} -radix unsigned} {{/Processador/banco/registradores[11]} -radix unsigned} {{/Processador/banco/registradores[10]} -radix unsigned} {{/Processador/banco/registradores[9]} -radix unsigned} {{/Processador/banco/registradores[8]} -radix unsigned} {{/Processador/banco/registradores[7]} -radix unsigned} {{/Processador/banco/registradores[6]} -radix unsigned} {{/Processador/banco/registradores[5]} -radix unsigned} {{/Processador/banco/registradores[4]} -radix unsigned} {{/Processador/banco/registradores[3]} -radix unsigned} {{/Processador/banco/registradores[2]} -radix unsigned} {{/Processador/banco/registradores[1]} -radix unsigned} {{/Processador/banco/registradores[0]} -radix unsigned}} -expand -subitemconfig {{/Processador/banco/registradores[15]} {-height 15 -radix unsigned} {/Processador/banco/registradores[14]} {-height 15 -radix unsigned} {/Processador/banco/registradores[13]} {-height 15 -radix unsigned} {/Processador/banco/registradores[12]} {-height 15 -radix unsigned} {/Processador/banco/registradores[11]} {-height 15 -radix unsigned} {/Processador/banco/registradores[10]} {-height 15 -radix unsigned} {/Processador/banco/registradores[9]} {-height 15 -radix unsigned} {/Processador/banco/registradores[8]} {-height 15 -radix unsigned} {/Processador/banco/registradores[7]} {-height 15 -radix unsigned} {/Processador/banco/registradores[6]} {-height 15 -radix unsigned} {/Processador/banco/registradores[5]} {-height 15 -radix unsigned} {/Processador/banco/registradores[4]} {-height 15 -radix unsigned} {/Processador/banco/registradores[3]} {-height 15 -radix unsigned} {/Processador/banco/registradores[2]} {-height 15 -radix unsigned} {/Processador/banco/registradores[1]} {-height 15 -radix unsigned} {/Processador/banco/registradores[0]} {-height 15 -radix unsigned}} /Processador/banco/registradores
add wave -noupdate /Processador/CLOCK_50
add wave -noupdate -radix unsigned /Processador/PC
add wave -noupdate -radix hexadecimal /Processador/memi_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {632 ps} 0} {{Cursor 2} {60687 ps} 0}
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
WaveRestoreZoom {0 ps} {105 ns}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue {Not Logged} -period 5ns -dutycycle 50 -starttime 0ns -endtime 100ns sim:/Processador/CLOCK_50 
wave create -driver freeze -pattern clock -initialvalue {Not Logged} -period 5ns -dutycycle 50 -starttime 0ns -endtime 100ns sim:/Processador/CLOCK_50 
wave create -driver freeze -pattern constant -value 0 -starttime 0ns -endtime 100ns sim:/Processador/reset 
wave create -driver freeze -pattern clock -initialvalue {Not Logged} -period 5ns -dutycycle 50 -starttime 0ns -endtime 100ns sim:/Processador/CLOCK_50 
WaveCollapseAll -1
wave clipboard restore
