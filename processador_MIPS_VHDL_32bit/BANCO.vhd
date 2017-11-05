-- @2012 - Prof. Julio C. D. de Melo - DELT/EEUFMG
-- Sistemas, Processadores e Perif�ricos
-- Projeto do processador uMIPS: Banco de Registradores

-- Declara��o de bibliotecas
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entidade principal
entity BANCO is
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
end BANCO;

architecture beh of BANCO is

subtype	regType   is std_logic_vector(31 downto 0) ;		-- registrador de 32 bits
type 	regsType  is array (31 downto 0) of regType ;		-- vetor/banco de registradores com 32 elementos
signal registradores : regsType;

begin
	escrever_rd:											-- processo de escrita no regitrador
	process (clk, reg_write, write_regrd) 
	begin
		if (reg_write = '1') then
			if (clk'event and clk = '1') then
				registradores(to_integer(write_regrd)) <= data_in;		-- escrever dado em Banco(rd)
			end if;
		end if;
	end process;

	data_outrs <= X"00000000" when (read_regrs = "00000")			-- ler conte�do de Banco(rs)
		else registradores (to_integer(read_regrs));
	data_outrt <= X"00000000" when (read_regrt = "00000")			-- ler conte�do de Banco(rt)
		else registradores (to_integer(read_regrt));

end beh;
