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
--  Date :    	05/08/2015 - 22:02
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY CONCAT IS
	PORT(
		IN_A :					IN 			STD_LOGIC_VECTOR(31 DOWNTO 0);
		IN_B :					IN				STD_LOGIC_VECTOR(31 DOWNTO 0);
		OUT_A :					OUT 			STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END CONCAT;

ARCHITECTURE ARC_CONCAT OF CONCAT IS

	SIGNAL MONTA_OUT_S :				STD_LOGIC_VECTOR(31 DOWNTO 0); 

BEGIN	
	OUT_A <= IN_B(31 DOWNTO 28) & IN_A(27 DOWNTO 0);
	
END ARC_CONCAT;

