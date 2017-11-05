-- @2012 - Prof. Julio C. D. de Melo - DELT/EEUFMG
-- Sistemas, Processadores e Perif ricos

-- Marina Antonia Carvalho Salmen
-- Vinicius Vecchia
-- Thais Rodrigues


-- Declara  o de bibliotecas
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Processador com entradas e saidas do kit
entity PROCESSADOR_FINAL is
port (
	KEY : in std_logic_vector (3 downto 0);			-- key(3): reset, key(2): clock e key(1): clock_ram
	LEDR	: out std_logic_vector (17 downto 0)		-- resultado da saida do kit (17 bits menos significativos da saida do processador)
	);
end PROCESSADOR_FINAL;

architecture beh of PROCESSADOR_FINAL is							

component PROCESSADOR is
port (
	clk 				: in std_logic;								-- rel�gio
	reset				: in std_logic;								-- reset
	instrucao		: out std_logic_vector(31 downto 0);		-- instru��o sendo executada
	resultado		: out std_logic_vector(31 downto 0);		-- resultado na sa�da da ULA
 	PC_saida			: out std_logic_vector(31 downto 0)
	);
end component;

signal resultado_aux : std_logic_vector (31 downto 0);
signal clk_aux, reset_aux : std_logic;

	begin

	LEDR <= resultado_aux(17 downto 0);
	clk_aux  <= not KEY(2);
	reset_aux <= not KEY(3);

P1: PROCESSADOR port map

	(
	clk => clk_aux,
	reset => reset_aux,
	resultado => resultado_aux
	);
	
	
end beh;