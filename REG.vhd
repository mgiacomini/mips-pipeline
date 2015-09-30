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
--  Date :    	29/06/2015 - 20:31
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY REG IS
	PORT(
		CLK :					IN STD_LOGIC;
		RESET :				IN	STD_LOGIC;
		RegWrite :			IN STD_LOGIC;
		IN_A :				IN	STD_LOGIC_VECTOR(4 DOWNTO 0);
		IN_B :				IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		IN_C :				IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		IN_D :				IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		OUT_A	:				OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		OUT_B :				OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END REG;

ARCHITECTURE ARC_REG OF REG IS
	
	TYPE 		STD_REG IS ARRAY(0 TO 31) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL	REG_1: STD_REG;
	SIGNAL	REG_2: STD_REG;
	
BEGIN	
	--REALIZA A LEITURA NO ENDEREO SELECIONADO
	OUT_A		<=		REG_1(TO_INTEGER(UNSIGNED(IN_A)));
	OUT_B		<=		REG_2(TO_INTEGER(UNSIGNED(IN_B)));
	
	--PROCESSO DE LEITURA
	PROCESS(CLK, RESET)
		BEGIN
			IF RESET = '1' THEN
				REG_1(0) <= (OTHERS => '0');
				REG_2(0) <= (OTHERS => '0');
				
				--t0
				REG_1(8) <= (0 => '1', OTHERS => '0');					--NO TEMOS A FUNO ADDI, ENTO
				REG_2(8) <= (0 => '1', OTHERS => '0');					--TEM QUE SER NA FORA BRUTA
				
				--t1
				REG_1(9) <= (0 => '1', 1 => '1', OTHERS => '0');
				REG_2(9) <= (0 => '1', 1 => '1', OTHERS => '0');
				
				--s1
				REG_1(17) <= X"FFFF0000";
				REG_2(17) <= X"FFFF0000";
			
			ELSIF CLK'EVENT AND CLK = '0' AND RegWrite = '1' THEN
				REG_1(TO_INTEGER(UNSIGNED(IN_C))) <= IN_D;
				REG_2(TO_INTEGER(UNSIGNED(IN_C))) <= IN_D;
			
			END IF;
	END PROCESS;

END ARC_REG;


