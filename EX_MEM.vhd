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





ENTITY EX_MEM IS
    PORT (clk           : in std_logic;
          RegWrite   : in std_logic;
          MemtoReg   : in std_logic;
          MemWrite   : in std_logic;
          MemRead    : in std_logic;
          Branch     : in std_logic;
          Jump :        IN STD_LOGIC;
          ZeroM         : in std_logic;
          
          AluOutM       : in std_logic_vector(31 downto 0); --SAIDA DA ULA
          WriteDataM    : in std_logic_vector(31 downto 0); -- VEM DA SAIDA 2 DE REG
          WriteRegM     : in std_logic_vector(4 downto 0); -- REG DESTINO VEM DO MX_1
          PcBranchM     : in std_logic_vector(31 downto 0); --ENDERECO DE DESVIO CONDICIONAL
          
          outRegWrite   : out std_logic;
          outMemtoReg   : out std_logic;
          outMemWrite   : out std_logic;
          outMemRead   : out std_logic;
          outBranch     : out std_logic;
          outZeroM         : out std_logic;
          
          outAluOutM       : out std_logic_vector(31 downto 0);
          outWriteDataM    : out std_logic_vector(31 downto 0);
          outWriteRegM     : out std_logic_vector(4 downto 0);
          outPcBranchM     : out std_logic_vector(31 downto 0));
    END;

Architecture ARC_EX_MEM of EX_MEM is
    BEGIN
        PROCESS(clk)
        BEGIN
            IF( clk'event and clk = '1') THEN
            outRegWrite <= RegWrite;
            outMemtoReg <= MemtoReg;
            outMemWrite <=MemWrite;
            outMemRead <=MemRead;
            outBranch <= Branch;
            outZeroM <= ZeroM;
            outAluOutM <= AluOutM;
            outWriteDataM <= WriteDataM;
            outWriteRegM <= WriteRegM;
            outPcBranchM <= PcBranchM;
        END IF;
        END PROCESS;
    END;


