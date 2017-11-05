-- @2012 - Prof. Julio C. D. de Melo - DELT/EEUFMG
-- Sistemas, Processadores e Perif�ricos - Sem. 1/12
-- Projeto do processador uMIPS: Via de Dados (incompleta)

-- Declara��o de bibliotecas
library ieee;												-- Via de dado
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entidade principal
entity VIA is
port (
	clk 				: in std_logic;								-- rel�gio
	reset				: in std_logic;								-- reset
	controle			: in std_logic_vector(7 downto 0);		-- sinais de controle
	ctrl_ULA			: in std_logic_vector(3 downto 0);		-- controle da ula
	instr				: out std_logic_vector(31 downto 0);		-- instru��o sendo executada
	resultado		: out std_logic_vector(31 downto 0);			-- resultado na sa�da da ULA
	PC_saida			: out std_logic_vector(31 downto 0)
	);
end VIA;

architecture beh of VIA is							-- Banco de registradores

component MEMI is
	port
	(
		address		: in std_logic_vector(8 downto 0);
		clock		: in std_logic  := '1';
		q			: out std_logic_vector(31 downto 0)
	);
end component;

component BANCO is
port (
		clk 		: in std_logic;								-- Rel�gio
		read_regrs	: in unsigned (4 downto 0); 				-- �ndice do registrador rs
		read_regrt	: in unsigned (4 downto 0); 				-- �ndice do registrador rt
		write_regrd	: in unsigned (4 downto 0); 				-- �ndice no registrador rd ou rt
		data_in		: in std_logic_vector(31 downto 0);			-- entrada de dados para escrita
		data_outrs	: out std_logic_vector(31 downto 0);		-- sa�da de dados do registrador rs
		data_outrt	: out std_logic_vector(31 downto 0);		-- sa�da de dados do registrador rt
		reg_write	: in std_logic								-- controle de escrita
	);
end component;

component ULA is
port(
		A, B : in std_logic_vector (31 downto 0);	-- Barramentos A e B
		F : in std_logic_vector(3 downto 0);		-- Controle da ULA 
		Y : out std_logic_vector (31 downto 0);		-- Sa�da da ULA
		Z: out std_logic							-- flag zero
	);
end component;

component MEMD is
	port
	(
		address	: in std_logic_vector (9 downto 0);			-- barramento de endere�os
		clock		: in std_logic  := '1';						-- sinal de rel�gio
		data		: in std_logic_vector (31 downto 0);		-- barramento de entrada de dados
		wren		: in std_logic ;							-- habilita��o de escrita
		q			: out std_logic_vector (31 downto 0)		-- barramento de sa�da de dados
	);
end component;

--Signal ext
signal ext1		: std_logic_vector(31 downto 0);
signal ext		: std_logic_vector(31 downto 0);

--Sinais contadores do programa
signal PC : std_logic_vector(31 downto 0);
signal PC_aux : std_logic_vector(31 downto 0);

--Sinais de controle auxiliares dentro da via
signal Branch_aux 	: std_logic;
signal PCSrc			: std_logic;   --PC Jump
signal MemWrite_aux	: std_logic;
signal RegWrite_aux	: std_logic;
signal MemtoReg_aux	: std_logic;
signal ALUSrc_aux		: std_logic;
signal RegDst_aux		: std_logic;
signal ZeroExt			: std_logic;

signal Mux_Beq : std_logic_vector(31 downto 0);	

-- barramentos entre registradores e ULA
signal bus_A, bus_B, result_aux, bus_aux : std_logic_vector(31 downto 0);

signal instrucao, dado_mem, resultado_banco : std_logic_vector(31 downto 0); --resultado_banco é o resultado que sai do banco e resultado o que sai da ula
signal rs_aux, rt_aux, rd_aux : unsigned (4 downto 0);

signal Zero : std_logic;

begin


	-- Extensao de sinal
	ext <= (x"0000" & instrucao(15 downto 0)) when (instrucao(15)='0')
			else (x"FFFF" & instrucao (15 downto 0));
	ext1 <= (ext(29 downto 0) & "00"); -- shift left 2
	
	PC_aux <= PC(31 downto 28) & instrucao(25 downto 0) & "00" when (PCSrc = '1')
				else std_logic_vector(signed (PC) + 4 + signed(ext1)) when (Branch_aux = '1' and Zero = '1')
				else std_logic_vector(signed(PC) + 4);
	
	
	-- L�gica do contador de programa (PC)
	process (clk, reset, PC)
	begin
	
	if (reset = '1') then
			PC <= (others => '0');
		elsif (clk'event and clk = '0') then
		
			PC <= PC_aux;
		
		end if;
	
	end process;

	
	-- Sinais de controle da via de dados
	Branch_aux <= controle (0);
	PCSrc <= controle (1);   --(PCJump)
	MemWrite_aux <= controle (2);
	RegWrite_aux <= controle (3);
	MemtoReg_aux <= controle (4);
	ALUSrc_aux <= controle (5);
	RegDst_aux <= controle (6);
	ZeroExt <= controle (7);

	-- �ndices dos registradores rs e rt
	rs_aux <= unsigned (instrucao (25 downto 21));
	rt_aux <= unsigned (instrucao (20 downto 16));

	--Mux_ALU	
	bus_B <= bus_aux when (ALUSrc_aux='0') else ext;
	
	--Mux RegDst
	rd_aux <= unsigned (instrucao (20 downto 16)) when (RegDst_aux='0') 
				else unsigned (instrucao (15 downto 11));	
	
	--Mux MemtoReg
	resultado_banco <= result_aux when(MemtoReg_aux='0') else dado_mem;
	resultado <= resultado_banco;
	
	-- Mapeamento de portas dos componentes
	instrucoes: MEMI port map
	(
		clock		=> clk,
		address		=> PC (10 downto 2),
		q			=> instrucao
	);

	banco1: BANCO port map
	(
		clk 		=> clk,
		read_regrs	=> rs_aux,
		read_regrt	=> rt_aux,
		write_regrd	=> rd_aux,
		data_in		=> resultado_banco,
		data_outrs	=> bus_A,
		data_outrt	=> bus_aux,
		reg_write	=> RegWrite_aux			-- RegWrite_aux
	);

	ula1: ULA port map
	(
		A 			=> bus_A,
		B 			=> bus_B,
		F 			=> ctrl_ULA,
		Y 			=> result_aux,
		Z 			=> Zero
	);

	dados: MEMD port map
	(
		clock		=> clk,
		address	=> result_aux (9 downto 0),
		data		=> bus_B,
		wren		=> MemWrite_aux,			-- MemWrite_aux,
		q			=> dado_mem
	);

	instr <= instrucao;
	PC_saida <= PC;
	--resultado <= result_aux; (Substituido por mux na linha 161)

end beh;
