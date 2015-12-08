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
--  Date :    	08/07/2015 - 19:11
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY MX_5 IS
	PORT(
		MemtoReg :				IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		IN_A :					IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		IN_B :					IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		IN_C :					IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		OUT_A :					OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END MX_5;
ARCHITECTURE ARC_MX_5 OF MX_5 IS

BEGIN
	OUT_A <= IN_B  WHEN MemtoReg = "00";
	OUT_A <= IN_A  WHEN MemtoReg = "01";
	OUT_A <= IN_C  WHEN MemtoReg = "10";

END ARC_MX_5;

