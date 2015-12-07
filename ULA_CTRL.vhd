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
--  Date :    	24/06/2015 - 20:23
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ULA_CTRL IS
    PORT ( 
				ALUOp : 			IN  STD_LOGIC_VECTOR (1 DOWNTO 0);
				IN_A : 			IN  STD_LOGIC_VECTOR (5 DOWNTO 0);
				OUT_A : 			OUT  STD_LOGIC_VECTOR (2 DOWNTO 0)
			);
END ULA_CTRL;

ARCHITECTURE ARC_ULA_CTRL of ULA_CTRL IS	

BEGIN
	
	--Conforme Apndix D do livro texto
	OUT_A(2) <= ALUOp(0) OR (ALUOp(1) AND IN_A(1));
	OUT_A(1) <= (NOT ALUOp(1)) OR (NOT IN_A(2));
	OUT_A(0) <= (ALUOp(1) AND IN_A(0)) OR (ALUOp(1) AND IN_A(3));

END ARC_ULA_CTRL;

