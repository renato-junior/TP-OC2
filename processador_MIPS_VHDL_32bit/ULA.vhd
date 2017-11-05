-- @2012 - Prof. Julio C. D. de Melo - DELT/EEUFMG
-- Sistemas, Processadores e Perif�ricos - Sem. 1/12
-- Projeto do processador uMIPS: Unidade L�gico-Aritm�tica
-- MARINA ANTONIA CARVALHO SALMEN
-- VINICIUS VECCHIA

-- Declara��o de bibliotecas
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entidade principal
entity ULA is
port(
	A, B : in std_logic_vector (31 downto 0);	-- Barramentos A e B
	F : in std_logic_vector(3 downto 0);		-- Controle da ULA 
	Y : out std_logic_vector (31 downto 0);		-- Sa�da da ULA
	Z: out std_logic							-- flag zero
	);
end ULA;

architecture beh of ULA is 
	SIGNAL saida : std_logic_vector (31 downto 0);
	SIGNAL AX, BX : std_logic_vector (31 downto 0);
	SIGNAL FN : std_logic_vector (3 downto 0);
	SIGNAL saida_aux : std_logic_vector(63 downto 0);

begin
	FN <= F;
	AX <= A;
	BX <= B;

	process (AX, BX, FN)
    begin
		case FN is
			when "0000"=>																	--AND
			   	saida <= AX AND BX;
					
			when "0001" =>									
					saida <= AX OR BX;											-- OR

			when "0010" =>
			   	saida <= std_logic_vector (signed (AX) + signed (BX));	--ADD
					
			when "0011" =>
			   	saida <= std_logic_vector (unsigned (AX) + unsigned (BX));	--ADDU
					
			when "0100" =>
					saida <= std_logic_vector (unsigned (AX) - unsigned (BX)); 		-- SUBU
					
			when "0101" =>
			   	if (unsigned (AX) < unsigned (BX)) then				-- SLTU
					saida <= x"00000001";
				else
					saida <= x"00000000";
			   	end if;
			
			when "0110" =>
					saida <= std_logic_vector (signed (AX) - signed (BX));		--SUB

			when "0111" =>
			   	if (signed (AX) < signed (BX)) then							-- SLT
					saida <= x"00000001";
				else
					saida <= x"00000000";
			   	end if;
					
			when "1000" =>
					saida <= BX(15 downto 0) & x"0000"; 						-- LUI
					
			when "1100" =>														--NOR
					saida <= AX NOR BX;
					
			when "1110" =>														--XOR
					saida <= AX XOR BX;
			
					
			when others => saida <= (others => '0');
		end case;

	END PROCESS;

	Y <= saida;
	Z <= '1' when (saida = x"00000000") else '0';

END beh; 

