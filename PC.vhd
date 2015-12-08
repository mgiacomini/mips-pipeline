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
--  Date :    	01/07/2015 - 19:53 
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY PC IS
	PORT(
		CLK :							IN		STD_LOGIC;
		RESET :						IN		STD_LOGIC;
		IN_A :						IN 	STD_LOGIC_VECTOR(31 DOWNTO 0);
		OUT_A :						OUT	STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END PC;

ARCHITECTURE ARC_PC OF PC IS
	
BEGIN
	PROCESS(CLK, RESET)
	BEGIN
		IF RESET = '1' THEN
			OUT_A <= X"00400000";								--Para utilizar com o MARS
		ELSIF	CLK'EVENT AND CLK = '1' THEN
			OUT_A <= IN_A;
		END IF;
	END PROCESS;
END ARC_PC;

