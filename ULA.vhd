-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--  Complete implementation of Patterson and Hennessy single cycle MIPS processor
--  Copyright (C) 2015  Darci Luiz Tomasi Junior
--
--  This program is free software: you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation, version 3.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
--  You should have received a copy of the GNU General Public License
--  along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
--  Engineer: 	Darci Luiz Tomasi Junior
--	 E-mail: 	dltj007@gmail.com
--  Date :    	18/06/2015 - 20:12
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;



ENTITY ULA IS
	PORT(
			IN_A : 				IN  	STD_LOGIC_VECTOR (31 downto 0);				--RS
			IN_B : 				IN  	STD_LOGIC_VECTOR (31 downto 0);				--RT
			IN_C : 				IN 	STD_LOGIC_VECTOR (2 downto 0);
         OUT_A :		 		OUT  	STD_LOGIC_VECTOR (31 downto 0);
			ZERO : 				OUT  	STD_LOGIC	
	);
	
END ULA;

ARCHITECTURE ARC_ULA OF ULA IS
	SIGNAL DATA_RS :				STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL DATA_RT :				STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL ULA_CTRL :				STD_LOGIC_VECTOR (2 downto 0);
	SIGNAL DATA_ALU_RESULT :	STD_LOGIC_VECTOR(31 DOWNTO 0);
	
BEGIN

	DATA_RS <= IN_A;
	DATA_RT <= IN_B;
	ULA_CTRL <= IN_C;
				  
	ZERO <= '1' WHEN (DATA_ALU_RESULT = X"00000000") else '0';
	
	--PARA A INSTRUO SLT, PEGA O SINAL DO RESULTADO DA SUBTRAO E ADICIONA AO FINAL DO VETOR
	OUT_A <= (X"0000000" & "000" & DATA_ALU_RESULT(31)) WHEN ULA_CTRL = "111" ELSE
						DATA_ALU_RESULT;
						
	PROCESS(ULA_CTRL, DATA_RS, DATA_RT)
	BEGIN
		CASE ULA_CTRL IS
			WHEN "000" => DATA_ALU_RESULT <= DATA_RS AND DATA_RT;			--AND
			WHEN "001" => DATA_ALU_RESULT <= DATA_RS OR DATA_RT;			--OR
			WHEN "010" => DATA_ALU_RESULT <= DATA_RS + DATA_RT;				--ADD
			WHEN "110" => DATA_ALU_RESULT <= DATA_RS - DATA_RT;				--SUB
			WHEN "111" => DATA_ALU_RESULT <= DATA_RS - DATA_RT;				--SLT			
			WHEN OTHERS => DATA_ALU_RESULT <= X"00000000";
		END CASE;
	END PROCESS;

END ARC_ULA;


