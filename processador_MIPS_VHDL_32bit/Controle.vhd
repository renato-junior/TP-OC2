-- @2012 - Prof. Julio C. D. de Melo - DELT/EEUFMG
-- Sistemas, Processadores e Perif�ricos
-- Projeto do processador uMIPS: Unidade de Controle

-- Declara��o de bibliotecas
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entidade principal						-- Unidade de Controle
entity Controle is
port (
	instrucao	: in std_logic_vector(31 downto 0);		-- instru��o a ser decodificada
	controle	: out std_logic_vector(7 downto 0);		-- sinais de controle da via de dados
	ctrl_ULA	: out std_logic_vector(3 downto 0)		-- sinais de fun��o da ULA
	);
end Controle;

architecture beh of Controle is

signal inst_aux : std_logic_vector (31 downto 0);		-- instru��o
signal opcode, funcao : std_logic_vector (5 downto 0);	-- opcode e fun��o da instru��o
signal ctrl_aux : std_logic_vector (7 downto 0);		-- controle
signal ULA_aux : std_logic_vector(3 downto 0);		-- fun��o da ULA

begin
	inst_aux <= instrucao;
	opcode <= inst_aux (31 downto 26);
	funcao <= inst_aux (5 downto 0);
	
	process (opcode, funcao)
    begin
		case opcode is
			when "000000" =>	-- opera��o do tipo R (registrador): opcode = 0x00 e a fun��o �
					--   especificada no campo �func� (bits 5 a 0 da instru��o)
					
				ctrl_aux <= "01001000";			-- opera��o com registrador
				
				case funcao is 				-- identifique a fun��o
					when "100111" =>			-- fun��o NOR: 0x27
						ULA_aux <= "1100";		-- opera��o NOR na ULA: 0xC

					when "100000" =>			-- fun��o ADD: 0x20
						ULA_aux <= "0010";		-- opera��o ADD na ULA: 0x2

					when "100100" =>			-- função AND: 0x24
						ULA_aux <= "0000";		--   operação AND na ULA: 0x0
						
					when "101010" =>			-- função SLT: 0x2a
						ULA_aux <= "0111";		--   operação SLT na ULA: 0111
						
					when "100101" =>			-- função OR: 0x25
						ULA_aux <= "0001";		--   operação OR na ULA: 0001
						
					when "100010" =>			-- função SUB: 0x22
						ULA_aux <= "0110";		-- operação SUB na ULA: 0110
						
					when "100001" =>			-- função ADDU: 0x21
						ULA_aux <= "0011";		-- operação ADDU na ULA: 0011
						
					when "100011" =>			-- função SUBU: 0x23
						ULA_aux <= "0100";		-- operação SUBU na ULA: 0100
					
					when "101011" =>			-- função SLTU: 0x2b
						ULA_aux <= "0101";		-- operação SLTU na ULA: 0101
						
					when "100110" =>			-- função XOR: 0x26
						ULA_aux <= "1110";		-- operação XOR na ULA: 1110
						
	
					when others => ULA_aux <= (others => '0');
				end case;
				
			when "101011" =>										-- função SW: 0X2b
				ctrl_aux <= "00010100";
				ULA_aux <= "0010";
				
			when "100011" => 										-- função LW: 0x23
				ctrl_aux <= "00011000";
				ULA_aux <= "0010";
					
			when "000100" => 										-- função BEQ: 0x4
				ctrl_aux <= "00000001";							-- 11000000
				ULA_aux <= "0110";
			
			when "001100" => 										-- função ANDI: 0xc
					ctrl_aux <= "00101000";
					ULA_aux <= "0000";
					
			when "001101" => 										-- função ORI: 0xd
					ctrl_aux <= "00101000";
					ULA_aux <= "0001";
					
			when "001110" => 										-- função XORI: 0xe
					ctrl_aux <= "00101000";
					ULA_aux <= "1110";
					
			when "001000" => 										-- função ADDI: 0x8
					ctrl_aux <= "00101000";
					ULA_aux <= "0010";
					
			when "001010" => 										-- função SLTI: 0xa
					ctrl_aux <= "00101000";
					ULA_aux <= "0111";
					
			when "000010" =>										-- função JUMP: 0x2
					ctrl_aux <= "00000010";
					ULA_aux <= "0000";


			when others =>		-- opcodes nao identificados: tratar como NOP
				ctrl_aux <= (others => '0');
				ULA_aux <= (others => '0');
		end case;

	END PROCESS;

	controle <= ctrl_aux;
	ctrl_ULA <= ULA_aux;

end beh;
