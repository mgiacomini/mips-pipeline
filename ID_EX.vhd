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




ENTITY ID_EX IS
    PORT (clk           : in std_logic;
          RegWrite   : in std_logic;
          MemtoReg   : in std_logic;
          MemWrite   : in std_logic;
          Branch     : in std_logic_vector(31 downto 0);
          ALUOp : in std_logic_vector(2 downto 0);
          ALUSrc     : in std_logic;
          RegDst     : in std_logic;

          RD1           : in std_logic_vector(31 downto 0);
          RD2           : in std_logic_vector(31 downto 0);
          RtE           : in std_logic_vector(4 downto 0);
          RdE           : in std_logic_vector(4 downto 0);

          SignExt       : in std_logic_vector(31 downto 0);
          PCPlus4       : in std_logic_vector(31 downto 0);

          outRegWrite   : out std_logic;
          outMemtoReg   : out std_logic;
          outMemWrite   : out std_logic;
          outBranch     : out std_logic_vector(31 downto 0);
          outALUOp : out std_logic_vector(2 downto 0);
          outALUSrc     : out std_logic;
          outRegDst     : out std_logic;

          outRD1           : out std_logic_vector(31 downto 0);
          outRD2           : out std_logic_vector(31 downto 0);
          outRtE           : out std_logic_vector(4 downto 0);
          outRdE           : out std_logic_vector(4 downto 0);

          outSignExt       : out std_logic_vector(31 downto 0);
          outPCPlus4       : out std_logic_vector(31 downto 0));
    END;

Architecture ARC_ID_EX of ID_EX is
    BEGIN
        PROCESS(clk)
        BEGIN
            IF( clk'event and clk = '1') THEN
            outRegWrite <= RegWrite;
            outMemtoReg <= MemtoReg;
            outMemWrite <=MemWrite;
            outBranch <= Branch;
            outALUOp <=ALUOp;
            outALUSrc <=ALUSrc;
            outRegDst <=RegDst;

            outRD1 <=RD1;
            outRD2 <=RD2;
            outRtE <= RtE;
            outRdE <= RdE;

            outSignExt <= SignExt;
            outPCPlus4 <= PCPlus4;
        END IF;
        END PROCESS;
    END;
