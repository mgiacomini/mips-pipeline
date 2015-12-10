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
--  Engineer:  Darci Luiz Tomasi Junior
--    E-mail:  dltj007@gmail.com
--  Date :     29/06/2015 - 20:31
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;



ENTITY MEM_WB IS
    PORT (clk           : in std_logic;
          RegWrite   : in std_logic;
          MemtoReg   : in std_logic;
          ReadDataW     : in std_logic_vector(31 downto 0);
          AluOutW       : in std_logic_vector(31 downto 0);
          WriteRegW     : in std_logic_vector(4 downto 0);

          outRegWrite : out std_logic;
          outMemtoReg : out std_logic;
          outReadDataW   : out std_logic_vector(31 downto 0);
          outAluOutW     : out std_logic_vector(31 downto 0);
          outWriteRegW   : out std_logic_vector(4 downto 0));
    END;

Architecture ARC_MEM_WB of MEM_WB is
    BEGIN
        PROCESS(clk)
        BEGIN
            IF( clk'event and clk = '1') THEN
            outRegWrite <= RegWrite;
            outMemtoReg <= MemtoReg;
            outAluOutW <= AluOutW;
            outReadDataW <= ReadDataW;
            outWriteRegW <= WriteRegW;
        END IF;
        END PROCESS;
    END;


