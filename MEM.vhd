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
--  Date :    	08/07/2015 - 20:07
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY MEM IS
	PORT(
		CLK :						IN STD_LOGIC;
		RESET :					IN STD_LOGIC;
		MemWrite :				IN STD_LOGIC;
		MemRead :				IN STD_LOGIC;
		IN_A :					IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
		IN_B :					IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		OUT_A :					OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END MEM;

ARCHITECTURE ARC_MEM OF MEM IS
	TYPE 		RAM_TYPE IS ARRAY(0 TO 255) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL	RAM: RAM_TYPE;
	SIGNAL 	ADRESS :  STD_LOGIC_VECTOR(31 DOWNTO 0);
	
BEGIN
	PROCESS(CLK)
		BEGIN
			IF RESET = '1' THEN
			
				RAM <= ((OTHERS => (OTHERS=>'0')));
				
			ELSIF CLK'EVENT AND CLK = '1' THEN
				IF MemWrite = '1' THEN
					
					--MIPS ARMAZEMA EM BYTES OU SEJA 4 EM 4
					--POR ISSO PEGA DE 31 A 2, POIS DEVIDO A POSIO DE ORDENAO DO ARRAY SER DE 1 EM 1...
					--...SE DESLOCA DOIS PARA DIREITA EX:
					--						SW $S0, 4($T0)					1010110100101000 0000000000000100
					--												[31-2]
					--															1010110100101000 00000000000001  = 1
					--						SW $S0, 8($T0) 				1010110100101000 0000000000001000
					--												[31-2]
					--															1010110100101000 00000000000010  = 2
					RAM(TO_INTEGER (UNSIGNED(ADRESS(31 DOWNTO 2)))) <= IN_B;
				END IF;
			END IF;
	END PROCESS;
	
	OUT_A	<=	RAM(TO_INTEGER(UNSIGNED(ADRESS(31 DOWNTO 2)))) WHEN MemRead ='1';
	
	--PARA UTILIZAR COM O MARS
	ADRESS <= STD_LOGIC_VECTOR(UNSIGNED(IN_A) - X"FFFF0000");

END ARC_MEM;

