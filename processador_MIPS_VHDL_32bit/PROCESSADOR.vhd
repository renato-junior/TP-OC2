-- @2012 - Prof. Julio C. D. de Melo - DELT/EEUFMG
-- Sistemas, Processadores e Perif�ricos - Sem. 1/12
-- Projeto do processador uMIPS

--Marina Antonia Carvalho Salmen
--Thais Rodrigues Guanaes Neiva
--Vinicius Azevedo de Souza e Vecchia

-- Declara��o de bibliotecas
library ieee;												-- Via de dado
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entidade principal
entity PROCESSADOR is
port (
	clk 				: in std_logic;								-- rel�gio
	reset				: in std_logic;								-- reset
	instrucao		: out std_logic_vector(31 downto 0);		-- instru��o sendo executada
	resultado		: out std_logic_vector(31 downto 0);		-- resultado na sa�da da ULA
 	PC_saida			: out std_logic_vector(31 downto 0)
	);
end PROCESSADOR;

architecture beh of PROCESSADOR is							-- Banco de registradores

component Controle is
port (
	instrucao	: in std_logic_vector(31 downto 0);		-- instru��o a ser decodificada
	controle	: out std_logic_vector(7 downto 0);		-- sinais de controle da via de dados
	ctrl_ULA	: out std_logic_vector(3 downto 0)		-- sinais de fun��o da ULA
	);
end component;


component via is
port (
	clk 		: in std_logic;								-- rel�gio
	reset		: in std_logic;								-- reset
	controle	: in std_logic_vector(7 downto 0);		-- sinais de controle
	ctrl_ULA	: in std_logic_vector(3 downto 0);		-- controle da ula
	instr		: out std_logic_vector(31 downto 0);		-- instru��o sendo executada
	resultado	: out std_logic_vector(31 downto 0);			-- resultado na sa�da da ULA
	PC_saida		: out std_logic_vector(31 downto 0)
	);
end component;

-- Sinais auxiliares
signal controle_aux 	: std_logic_vector(7 downto 0);
signal func_aux		: std_logic_vector(3 downto 0); --funcao F auxiliar (controle ULA)
signal instr_aux			: std_logic_vector(31 downto 0);		--funcao instrucao aux
signal resultado_aux	: std_logic_vector(31 downto 0);
signal PC_saida_aux: 	std_logic_vector(31 downto 0);


begin

	-- Mapeamento de portas dos componentes
viad: via port map
	(	
		clk => clk,
		reset => reset,
		controle	=> controle_aux,
		ctrl_ULA	=> func_aux,
		instr => instr_aux,
		resultado => resultado_aux,
		PC_saida => PC_saida_aux
	);
	
ctrl: Controle port map
	(
		instrucao => instr_aux,
		controle => controle_aux,
		ctrl_ULA => func_aux
	);

		instrucao <= instr_aux;
		resultado <= resultado_aux;
		PC_saida <= PC_saida_aux;

end beh;
