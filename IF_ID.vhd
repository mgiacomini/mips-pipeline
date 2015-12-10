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

ENTITY IF_ID IS
    PORT (clk         : in std_logic;
          pcplus4     : in std_logic_vector(31 downto 0);
          instruction : in std_logic_vector(31 downto 0);
          pc_out      : out std_logic_vector(31 downto 0);
          instr_out   : out std_logic_vector(31 downto 0));
    END IF_ID;

ARCHITECTURE ARC_IF_ID of IF_ID is
    BEGIN
        PROCESS(clk)
        BEGIN
            IF( clk'event and clk = '1') THEN
                instr_out <= instruction;
                pc_out <= pcplus4;
            END IF;
        END PROCESS;
    END;