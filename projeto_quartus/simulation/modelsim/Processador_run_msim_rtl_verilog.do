transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/renato/Dev/TP-OC2/projeto_quartus {/home/renato/Dev/TP-OC2/projeto_quartus/Processador.v}

