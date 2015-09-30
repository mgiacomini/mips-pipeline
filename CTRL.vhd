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
--  Date :    	25/06/2015 - 19:35
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY CTRL IS
	PORT(
		OPCode : 			IN			STD_LOGIC_VECTOR(5 DOWNTO 0);
		RegDst :				OUT		STD_LOGIC;
		Jump :				OUT		STD_LOGIC;
		Branch :				OUT		STD_LOGIC;
		MemRead :			OUT		STD_LOGIC;
		MemtoReg :			OUT		STD_LOGIC;
		ALUOp :				OUT		STD_LOGIC_VECTOR(1 DOWNTO 0);
		MemWrite :			OUT		STD_LOGIC;
		ALUSrc :				OUT		STD_LOGIC;
		RegWrite :			OUT		STD_LOGIC
	);
END CTRL;

ARCHITECTURE ARC_CTRL OF CTRL IS
	
BEGIN
	PROCESS(OPCode)
	BEGIN
		CASE OPCode IS
			--TYPE R
			WHEN "000000" =>  RegDst <=		'1';
									Jump <=			'0';
									ALUSrc <=		'0';
									MemtoReg <=		'0';
									RegWrite <=		'1';
									MemRead <=		'0';
									MemWrite <=		'0';
									Branch <=		'0';
									ALUOp(1) <=		'1';
									ALUOp(0) <=		'0';	
			--TYPE LW						
			WHEN "100011" =>  RegDst <= 		'0';
									Jump <=			'0';
									ALUSrc <=		'1';
									MemtoReg <=		'1';
									RegWrite <=		'1';
									MemRead <=		'1';
									MemWrite <=		'0';
									Branch <=		'0';
									ALUOp(1) <=		'0';
									ALUOp(0) <=		'0';
			--TYPE SW					
			WHEN "101011" =>  RegDst <=		'0'; --X
									Jump <=			'0';
									ALUSrc <=		'1';
									MemtoReg <=		'0'; --X
									RegWrite <=		'0';
									MemRead <=		'0';
									MemWrite <=		'1';
									Branch <=		'0';
									ALUOp(1) <=		'0';
									ALUOp(0) <=		'0';
			--TYPE JUMP
			WHEN "000010" =>  RegDst <=		'0'; --X
									Jump <=			'1';
									ALUSrc <=		'0';
									MemtoReg <=		'0'; --X
									RegWrite <=		'0';
									MemRead <=		'0';
									MemWrite <=		'0';
									Branch <=		'0';
									ALUOp(1) <=		'1';
									ALUOp(0) <=		'0';
			--TYPE BEQ
			WHEN OTHERS => 	RegDst <=		'0'; --X
									Jump <=			'0';
									ALUSrc <=		'0';
									MemtoReg <=		'0'; --X
									RegWrite <=		'0';
									MemRead <=		'0';
									MemWrite <=		'0';
									Branch <=		'1';
									ALUOp(1) <=		'0';
									ALUOp(0) <=		'1';	
									
		END CASE;
	END PROCESS;

END ARC_CTRL;

