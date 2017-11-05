-- Prof. Julio C. D. de Melo - DELT/EEUFMG
-- Sistemas, Processadores e Periféricos - Sem. 1/12
-- Projeto do processador uMIPS: Memória de Dados

-- Declaração de bibliotecas
LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY altera_mf;
USE altera_mf.all;

-- Entidade principal
ENTITY MEMD IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (9 DOWNTO 0);			-- barramento de endereços
		clock		: IN STD_LOGIC  := '1';						-- sinal de relógio
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);		-- barramento de entrada de dados
		wren		: IN STD_LOGIC ;							-- habilitação de escrita
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)			-- barramento de saída de dados
	);
END MEMD;

ARCHITECTURE SYN OF memd IS

	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (31 DOWNTO 0);

	COMPONENT altsyncram
	GENERIC (
		clock_enable_input_a		: STRING;
		clock_enable_output_a		: STRING;
		intended_device_family		: STRING;
		lpm_hint		: STRING;
		lpm_type		: STRING;
		numwords_a		: NATURAL;
		operation_mode		: STRING;
		outdata_aclr_a		: STRING;
		outdata_reg_a		: STRING;
		power_up_uninitialized		: STRING;
		widthad_a		: NATURAL;
		width_a		: NATURAL;
		width_byteena_a		: NATURAL
	);
	PORT (
			wren_a	: IN STD_LOGIC ;
			clock0	: IN STD_LOGIC ;
			address_a	: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
			q_a	: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
			data_a	: IN STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	END COMPONENT;

BEGIN
	q    <= sub_wire0(31 DOWNTO 0);

	altsyncram_component : altsyncram
	GENERIC MAP (
		clock_enable_input_a => "BYPASS",
		clock_enable_output_a => "BYPASS",
		intended_device_family => "Cyclone II",
		lpm_hint => "ENABLE_RUNTIME_MOD=NO",
		lpm_type => "altsyncram",
		numwords_a => 1024,
		operation_mode => "SINGLE_PORT",
		outdata_aclr_a => "NONE",
		outdata_reg_a => "UNREGISTERED",
		power_up_uninitialized => "TRUE",
		widthad_a => 10,
		width_a => 32,
		width_byteena_a => 1
	)
	PORT MAP (
		wren_a => wren,
		clock0 => clock,
		address_a => address,
		data_a => data,
		q_a => sub_wire0
	);

END SYN;

