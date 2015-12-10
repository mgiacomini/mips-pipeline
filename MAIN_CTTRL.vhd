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
--  Date :    	01/07/2015 - 22:08 
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY MAIN_PROCESSOR IS
	PORT(
		CLK :										IN 				STD_LOGIC;
		RESET :									IN 				STD_LOGIC
	);
END MAIN_PROCESSOR;

ARCHITECTURE ARC_MAIN_PROCESSOR OF MAIN_PROCESSOR IS

	COMPONENT ADD_PC IS
		PORT(
			IN_A :			IN 		STD_LOGIC_VECTOR(31 DOWNTO 0);
			OUT_A :			OUT		STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT ADD IS
		PORT(
			IN_A :			IN 		STD_LOGIC_VECTOR(31 DOWNTO 0);
			IN_B :			IN			STD_LOGIC_VECTOR(31 DOWNTO 0);
			OUT_A :			OUT 		STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT AND_1 IS
		PORT(
			Branch :		 	IN  		STD_LOGIC;
			IN_A :			IN			STD_LOGIC;
			OUT_A  :			OUT		STD_LOGIC
		);
	END COMPONENT;	

	COMPONENT CONCAT IS
		PORT(
			IN_A :			IN 		STD_LOGIC_VECTOR(31 DOWNTO 0);
			IN_B :			IN			STD_LOGIC_VECTOR(31 DOWNTO 0);
			OUT_A :			OUT 		STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT CTRL IS
		PORT(
			OPCode : 		IN			STD_LOGIC_VECTOR(5 DOWNTO 0);
			RegDst :			OUT		STD_LOGIC;
			Jump :			OUT		STD_LOGIC;
			Branch :			OUT		STD_LOGIC;
			MemRead :		OUT		STD_LOGIC;
			MemtoReg :		OUT		STD_LOGIC;
			ALUOp :			OUT		STD_LOGIC_VECTOR(1 DOWNTO 0);
			MemWrite :		OUT		STD_LOGIC;
			ALUSrc :			OUT		STD_LOGIC;
			RegWrite :		OUT		STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT EXTEND_SIGNAL IS
		PORT(
			IN_A :			IN			STD_LOGIC_VECTOR (15 DOWNTO 0);
			OUT_A : 			OUT  		STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT INST IS
		PORT(
			IN_A :			IN 		STD_LOGIC_VECTOR(31 DOWNTO 0);
			OUT_A :			OUT		STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT MEM IS
		PORT(
			CLK :				IN 		STD_LOGIC;
			RESET :			IN 		STD_LOGIC;
			MemWrite :		IN 		STD_LOGIC;
			MemRead :		IN 		STD_LOGIC;
			IN_A :			IN 		STD_LOGIC_VECTOR(31 DOWNTO 0); 
			IN_B :			IN 		STD_LOGIC_VECTOR(31 DOWNTO 0);
			OUT_A :			OUT 		STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT MX_1 IS
		PORT(
			RegDst :			IN			STD_LOGIC;	
			IN_A :			IN 		STD_LOGIC_VECTOR(4 DOWNTO 0);
			IN_B :			IN			STD_LOGIC_VECTOR(4 DOWNTO 0);
			OUT_A :			OUT 		STD_LOGIC_VECTOR(4 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT MX_2 IS
		PORT(
			AluSrc :			IN			STD_LOGIC;
			IN_A :			IN 		STD_LOGIC_VECTOR(31 DOWNTO 0);
			IN_B : 			IN  		STD_LOGIC_VECTOR(31 DOWNTO 0);
			OUT_A :			OUT		STD_LOGIC_VECTOR(31 DOWNTO 0)			
		);
	END COMPONENT;
	
	COMPONENT MX_3 IS
		PORT(
			IN_A :			IN 		STD_LOGIC_VECTOR(31 DOWNTO 0);
			IN_B :			IN 		STD_LOGIC_VECTOR(31 DOWNTO 0);
			IN_C :			IN 		STD_LOGIC;
			OUT_A :			OUT 		STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT MX_4 IS
		PORT(
			Jump :			IN 		STD_LOGIC;
			IN_A :			IN 		STD_LOGIC_VECTOR(31 DOWNTO 0);
			IN_B :			IN 		STD_LOGIC_VECTOR(31 DOWNTO 0);
			OUT_A :			OUT 		STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT MX_5 IS
		PORT(
			MemtoReg :		IN 		STD_LOGIC;
			IN_A :			IN 		STD_LOGIC_VECTOR(31 DOWNTO 0);
			IN_B :			IN 		STD_LOGIC_VECTOR(31 DOWNTO 0);
			OUT_A :			OUT 		STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT PC IS
		PORT(
			CLK :				IN			STD_LOGIC;
			RESET :			IN			STD_LOGIC;
			IN_A :			IN 		STD_LOGIC_VECTOR(31 DOWNTO 0);
			OUT_A :			OUT		STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT REG IS
		PORT(
			CLK :				IN 		STD_LOGIC;
			RESET :			IN			STD_LOGIC;
			RegWrite :		IN 		STD_LOGIC;
			IN_A :			IN			STD_LOGIC_VECTOR(4 DOWNTO 0);
			IN_B :			IN 		STD_LOGIC_VECTOR(4 DOWNTO 0);
			IN_C :			IN 		STD_LOGIC_VECTOR(4 DOWNTO 0);
			IN_D :			IN 		STD_LOGIC_VECTOR(31 DOWNTO 0);
			OUT_A	:			OUT 		STD_LOGIC_VECTOR(31 DOWNTO 0);
			OUT_B :			OUT 		STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT SL_1 IS
		PORT(
			IN_A :		 	IN  		STD_LOGIC_VECTOR (31 DOWNTO 0);
			OUT_A  :			OUT		STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT SL_2 IS
		PORT(
			IN_A : 			IN  		STD_LOGIC_VECTOR (31 DOWNTO 0);
			OUT_A	  :		OUT		STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT ULA_CTRL IS
		PORT ( 
			ALUOp : 			IN  		STD_LOGIC_VECTOR (1 DOWNTO 0);
			IN_A : 			IN  		STD_LOGIC_VECTOR (5 DOWNTO 0);
			OUT_A : 			OUT  		STD_LOGIC_VECTOR (2 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT ULA IS
		PORT(
			IN_A : 				IN  	STD_LOGIC_VECTOR (31 downto 0);				--RS
			IN_B : 				IN  	STD_LOGIC_VECTOR (31 downto 0);				--RT
			IN_C : 				IN 	STD_LOGIC_VECTOR (2 downto 0);
         	OUT_A :		 		OUT  	STD_LOGIC_VECTOR (31 downto 0);
			ZERO : 				OUT  	STD_LOGIC	
		);
	END COMPONENT;

	COMPONENT IF_ID IS
		PORT (
			  clk         : in std_logic;
			  pcplus4     : in std_logic_vector(31 downto 0);
			  instruction : in std_logic_vector(31 downto 0);
			  pc_out      : out std_logic_vector(31 downto 0);
          	  instr_out   : out std_logic_vector(31 downto 0)
          	 );
    END COMPONENT;

    COMPONENT ID_EX IS
		PORT (
			  clk    :      IN      STD_LOGIC;
          RegDst :      IN     STD_LOGIC;
          Jump :        IN     STD_LOGIC;
          Branch :      IN     STD_LOGIC;
          MemRead :     IN     STD_LOGIC;
          MemtoReg :    IN     STD_LOGIC;
          ALUOp :       IN     STD_LOGIC_VECTOR(1 DOWNTO 0);
          MemWrite :    IN     STD_LOGIC;
          ALUSrc :      IN     STD_LOGIC;
          RegWrite :    IN     STD_LOGIC;

          JumpAddr           : in std_logic_vector(31 downto 0);
          RD1           : in std_logic_vector(31 downto 0);
          RD2           : in std_logic_vector(31 downto 0);
          RtE           : in std_logic_vector(4 downto 0);
          RdE           : in std_logic_vector(4 downto 0);
          SignExt       : in std_logic_vector(31 downto 0);
          PCPlus4       : in std_logic_vector(31 downto 0);

          outRegDst     : out std_logic;
          outJump       : out std_logic;
          outBranch     : out std_logic;
          outMemRead   : out std_logic;
          outMemtoReg   : out std_logic;
          outALUOp      : out STD_LOGIC_VECTOR(1 DOWNTO 0);
          outMemWrite   : out std_logic;
          outALUSrc     : out std_logic;
          outRegWrite   : out std_logic;         

          outRD1           : out std_logic_vector(31 downto 0);
          outRD2           : out std_logic_vector(31 downto 0);
          outRtE           : out std_logic_vector(4 downto 0);
          outRdE           : out std_logic_vector(4 downto 0);
          outSignExt       : out std_logic_vector(31 downto 0);
          outPCPlus4       : out std_logic_vector(31 downto 0);
          JumpAddrOut           : out std_logic_vector(31 downto 0)
	        );
    END COMPONENT;

    COMPONENT EX_MEM IS
		PORT (clk           : in std_logic;
	          RegWrite   : in std_logic;
	          MemtoReg   : in std_logic;
	          MemWrite   : in std_logic;
	          Branch     : in std_logic_vector(31 downto 0);
	          Jump :        IN     STD_LOGIC;

	          ZeroM         : in std_logic;
	          
	          AluOutM       : in std_logic_vector(31 downto 0); --SAIDA DA ULA
	          WriteDataM    : in std_logic_vector(31 downto 0); -- VEM DA SAIDA 2 DE REG
	          WriteRegM     : in std_logic_vector(4 downto 0); -- REG DESTINO VEM DO MX_1
	          PcBranchM     : in std_logic_vector(31 downto 0); --ENDERECO DE DESVIO CONDICIONAL
	          
	          outRegWrite   : out std_logic;
	          outMemtoReg   : out std_logic;
	          outMemWrite   : out std_logic;
	          outBranch     : out std_logic_vector(31 downto 0);
	          outZeroM         : out std_logic;
	          outAluOutM       : out std_logic_vector(31 downto 0);
	          outWriteDataM    : out std_logic_vector(31 downto 0);
	          outWriteRegM     : out std_logic_vector(4 downto 0);
	          outPcBranchM     : out std_logic_vector(31 downto 0)
	        );
    END COMPONENT;

    COMPONENT MEM_WB IS
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
	          outWriteRegW   : out std_logic_vector(4 downto 0)
	        );
    END COMPONENT;
	
	--ADD_PC
	SIGNAL S_ADD_PC_OUT_A : 		STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	--ADD
	SIGNAL S_ADD_OUT_A :			 	STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	--AND_1
	SIGNAL S_AND_1_OUT_A  :			STD_LOGIC;
	
	--CONCAT
	SIGNAL S_CONCAT_OUT_A :			STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	--CTRL
	SIGNAL S_CTRL_RegDst :			STD_LOGIC;	
	SIGNAL S_CTRL_Jump :				STD_LOGIC;	
	SIGNAL S_CTRL_Branch :			STD_LOGIC;
	SIGNAL S_CTRL_MemRead :			STD_LOGIC;
	SIGNAL S_CTRL_MemtoReg :		STD_LOGIC;
	SIGNAL S_CTRL_ALUOp :			STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL S_CTRL_MemWrite :		STD_LOGIC;
	SIGNAL S_CTRL_ALUSrc :			STD_LOGIC;
	SIGNAL S_CTRL_RegWrite :		STD_LOGIC;
	
	--INST
	SIGNAL S_INST_OUT_A :			STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	--EXTEND_SIGNAL
	SIGNAL S_EXTEND_SIGNAL_OUT_A :STD_LOGIC_VECTOR (31 DOWNTO 0);
	
	--MEM
	SIGNAL S_MEM_OUT_A :				STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	--MX_1
	SIGNAL S_MX_1_OUT_A :			STD_LOGIC_VECTOR(4 DOWNTO 0);
	
	--MX_2
	SIGNAL S_MX_2_OUT_A :			STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	--MX_3
	SIGNAL S_MX_3_OUT_A :			STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	--MX_4
	SIGNAL S_MX_4_OUT_A :			STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	--MX_5
	SIGNAL S_MX_5_OUT_A :			STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	--PC
	SIGNAL S_PC_OUT_A :				STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	--REG
	SIGNAL S_REG_OUT_A :		 		STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL S_REG_OUT_B :				STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	--SL_1
	SIGNAL S_SL_1_OUT_A	  :		STD_LOGIC_VECTOR (31 DOWNTO 0);
	
	--SL_2
	SIGNAL S_SL_2_OUT_A	  :		STD_LOGIC_VECTOR (31 DOWNTO 0);
	
	--ULA_CTRL
	SIGNAL S_ULA_CTRL_OUT_A : 		STD_LOGIC_VECTOR (2 DOWNTO 0);
	
	--ULA
	SIGNAL S_ULA_OUT_A :				STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL S_ULA_ZERO :  			STD_LOGIC;



	------------------------  PIPE  ----------------------------
	--IF_ID
	SIGNAL  S_PCPlus4_IFID_OUT :				STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL  S_INSTRUCTION_OUT :				STD_LOGIC_VECTOR (31 DOWNTO 0);

	--ID_EX
	SIGNAL  S_RegDst_IDEX_OUT :				STD_LOGIC;
	SIGNAL  S_Jump_IDEX_OUT :				STD_LOGIC;
	SIGNAL  S_Branch_IDEX_OUT :				STD_LOGIC;
	SIGNAL  S_MemRead_IDEX_OUT :				STD_LOGIC;
	SIGNAL  S_MemtoReg_IDEX_OUT :				STD_LOGIC;
	SIGNAL  S_ALUOp_IDEX_OUT :				STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL  S_MemWrite_IDEX_OUT :				STD_LOGIC;
	SIGNAL  S_ALUSrc_IDEX_OUT :				STD_LOGIC;
	SIGNAL  S_RegWrite_IDEX_OUT :				STD_LOGIC;

	SIGNAL  S_CONCAT_IDEX_OUT:				STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL  S_RD1_OUT :				STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL  S_RD2_OUT :				STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL  S_RtE_OUT :				STD_LOGIC_VECTOR (4 DOWNTO 0);
	SIGNAL  S_RdE_OUT :				STD_LOGIC_VECTOR (4 DOWNTO 0);
	SIGNAL  S_SignExt_OUT :				STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL  S_PCPlus4_IDEX_OUT :				STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL  S_JUMP_ADDR_IDEX_OUT : STD_LOGIC_VECTOR (31 DOWNTO 0);



	--EX_MEM
	SIGNAL  S_RegWrite_EXMEM_OUT :				STD_LOGIC;
	SIGNAL  S_MemtoReg_EXMEM_OUT :				STD_LOGIC;
	SIGNAL  S_MemWrite_EXMEM_OUT :				STD_LOGIC;
	SIGNAL  S_MemRead_EXMEM_OUT :				STD_LOGIC;
	SIGNAL  S_Branch_EXMEM_OUT :				STD_LOGIC;
	SIGNAL  S_ULA_EXMEM_ZERO :				STD_LOGIC;

	SIGNAL  S_ULA_EXMEM_OUT :				STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL  S_REG_EXMEM_OUT :				STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL  S_DSTREG_OUT :				STD_LOGIC_VECTOR (4 DOWNTO 0);
	SIGNAL  S_BRANCH_ADDRESS_OUT :				STD_LOGIC_VECTOR (31 DOWNTO 0);



	--MEM_WB
	SIGNAL  S_RegWrite_MEMWB_OUT :				STD_LOGIC;
	SIGNAL  S_MemtoReg_MEMWB_OUT :				STD_LOGIC;
	SIGNAL  S_ReadDataW_OUT :				STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL  S_AluOutW_OUT :				STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL  S_WriteRegW_OUT :				STD_LOGIC_VECTOR (4 DOWNTO 0);


	
	--DEMAIS SINAIS
	SIGNAL S_GERAL_OPCode :			STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL S_GERAL_RS : 				STD_LOGIC_VECTOR(4 DOWNTO 0);	
	SIGNAL S_GERAL_RT : 				STD_LOGIC_VECTOR(4 DOWNTO 0);	
	SIGNAL S_GERAL_RD : 				STD_LOGIC_VECTOR(4 DOWNTO 0);	
	SIGNAL S_GERAL_I_TYPE :			STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL S_GERAL_FUNCT :			STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL S_GERAL_JUMP :			STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL S_GERAL_PC_4 :			STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
	S_GERAL_OPCode 	<= S_INST_OUT_A(31 DOWNTO 26);
	S_GERAL_RS 			<= S_INST_OUT_A(25 DOWNTO 21);
	S_GERAL_RT			<= S_INST_OUT_A(20 DOWNTO 16);
	S_GERAL_RD 			<= S_INST_OUT_A(15 DOWNTO 11);
	S_GERAL_I_TYPE 	<= S_INST_OUT_A(15 DOWNTO 0);
	S_GERAL_FUNCT		<= S_INST_OUT_A(5 DOWNTO 0);
	S_GERAL_JUMP		<= S_INST_OUT_A(31 DOWNTO 0);
	S_GERAL_PC_4		<= S_ADD_PC_OUT_A(31 DOWNTO 0);

	C_PC :					PC PORT MAP(CLK, RESET, S_MX_4_OUT_A, S_PC_OUT_A);
	C_ADD_PC :				ADD_PC PORT MAP(S_PC_OUT_A, S_ADD_PC_OUT_A);
	C_INST :					INST PORT MAP(S_PC_OUT_A, S_INST_OUT_A);
	C_SL_1 :					SL_1 PORT MAP(S_INSTRUCTION_OUT(31 DOWNTO 0), S_SL_1_OUT_A);


	C_CTRL :					CTRL PORT MAP(S_INSTRUCTION_OUT(31 DOWNTO 26), S_CTRL_RegDst, S_CTRL_Jump, S_CTRL_Branch, S_CTRL_MemRead, S_CTRL_MemtoReg, S_CTRL_ALUOp, S_CTRL_MemWrite, S_CTRL_ALUSrc, S_CTRL_RegWrite);


	C_CONCAT :				CONCAT PORT MAP(S_SL_1_OUT_A, S_PCPlus4_IFID_OUT, S_CONCAT_OUT_A);
	C_MX_1 :					MX_1 PORT MAP(S_CTRL_RegDst, S_RtE_OUT, S_RdE_OUT, S_MX_1_OUT_A);
	C_SL_2 :					SL_2 PORT MAP(S_SignExt_OUT, S_SL_2_OUT_A);
	C_REG :					REG PORT MAP(CLK, RESET, S_RegWrite_MEMWB_OUT, S_INSTRUCTION_OUT(25 DOWNTO 21), S_INSTRUCTION_OUT(20 DOWNTO 16), S_WriteRegW_OUT, S_MX_5_OUT_A, S_REG_OUT_A, S_REG_OUT_B);
	C_EXTEND_SIGNAL :		EXTEND_SIGNAL PORT MAP(S_INSTRUCTION_OUT(15 DOWNTO 0), S_EXTEND_SIGNAL_OUT_A);
	C_ADD :					ADD PORT MAP(S_PCPlus4_IDEX_OUT, S_SL_2_OUT_A, S_ADD_OUT_A);

	C_ULA :					ULA PORT MAP(S_RD1_OUT, S_MX_2_OUT_A, S_ULA_CTRL_OUT_A, S_ULA_OUT_A, S_ULA_ZERO);
	C_MX_2 :					MX_2 PORT MAP(S_ALUSrc_IDEX_OUT, S_RD2_OUT, S_SignExt_OUT, S_MX_2_OUT_A);
	C_ULA_CTRL :			ULA_CTRL PORT MAP(S_ALUOp_IDEX_OUT, S_SignExt_OUT(5 DOWNTO 0), S_ULA_CTRL_OUT_A);

	C_MX_3 :					MX_3 PORT MAP(S_ADD_PC_OUT_A, S_ADD_OUT_A, S_AND_1_OUT_A, S_MX_3_OUT_A);
	C_AND_1 :				AND_1 PORT MAP(S_Branch_EXMEM_OUT, S_ULA_EXMEM_ZERO, S_AND_1_OUT_A);

	C_MEM :					MEM PORT MAP(CLK, RESET, S_MemWrite_EXMEM_OUT, S_MemRead_EXMEM_OUT, S_ULA_EXMEM_OUT, S_REG_EXMEM_OUT, S_MEM_OUT_A);

	C_MX_4 :					MX_4 PORT MAP(S_CTRL_Jump, S_CONCAT_OUT_A, S_MX_3_OUT_A, S_MX_4_OUT_A);

	C_MX_5 :					MX_5 PORT MAP(S_MemtoReg_MEMWB_OUT, S_ReadDataW_OUT, S_AluOutW_OUT, S_MX_5_OUT_A);

	--PIPE
	C_IF_ID :					IF_ID PORT MAP(CLK, S_ADD_PC_OUT_A, S_INST_OUT_A, S_PCPlus4_IFID_OUT, S_INSTRUCTION_OUT);

	C_ID_EX :					ID_EX PORT MAP(CLK,
												S_CTRL_RegDst,
												S_CTRL_Jump,
												S_CTRL_Branch,
												S_CTRL_MemRead,
												S_CTRL_MemtoReg,
												S_CTRL_ALUOp,
												S_CTRL_MemWrite,
												S_CTRL_ALUSrc,
												S_CTRL_RegWrite, 
												 
												S_CONCAT_OUT_A,
												S_REG_OUT_A,
												S_REG_OUT_B,
												S_GERAL_RS,
												S_GERAL_RT,
												S_EXTEND_SIGNAL_OUT_A,
												S_PCPlus4_IFID_OUT,


												S_RegDst_IDEX_OUT,
												S_Jump_IDEX_OUT,
												S_Branch_IDEX_OUT,
												S_MemRead_IDEX_OUT,
												S_MemtoReg_IDEX_OUT,
												S_ALUOp_IDEX_OUT,
												S_MemWrite_IDEX_OUT,
												S_ALUSrc_IDEX_OUT,
												S_RegWrite_IDEX_OUT,

												S_RD1_OUT,
												S_RD2_OUT,
												S_RtE_OUT,
												S_RdE_OUT,
												S_SignExt_OUT,
												S_PCPlus4_IDEX_OUT,
												S_JUMP_ADDR_IDEX_OUT);

	C_EX_MEM :					IF_ID PORT MAP(CLK,
												S_RegWrite_IDEX_OUT,
												S_MemtoReg_IDEX_OUT,
												S_MemWrite_IDEX_OUT,
												S_MemRead_IDEX_OUT,
												S_Branch_IDEX_OUT,
												S_ULA_ZERO,
												S_Jump_IDEX_OUT,

												S_ULA_OUT_A,
												S_REG_OUT_B,
												S_MX_1_OUT_A,
												S_ADD_OUT_A,

												S_RegWrite_EXMEM_OUT,
												S_MemtoReg_EXMEM_OUT,
												S_MemWrite_EXMEM_OUT,
												S_MemRead_EXMEM_OUT,
												S_Branch_EXMEM_OUT,
												S_ULA_EXMEM_ZERO,

												S_ULA_EXMEM_OUT,
												S_REG_EXMEM_OUT,
												S_DSTREG_OUT,
												S_BRANCH_ADDRESS_OUT);


	C_MEM_WB :					MEM_WB PORT MAP(CLK, 
												  S_RegWrite_EXMEM_OUT, 
												  S_MemtoReg_EXMEM_OUT, 
												  S_MEM_OUT_A,
										          S_ULA_EXMEM_OUT,
										          S_DSTREG_OUT,

										          S_RegWrite_MEMWB_OUT,
										          S_MemtoReg_MEMWB_OUT,
										          S_ReadDataW_OUT,
										          S_AluOutW_OUT,
										          S_WriteRegW_OUT);

END ARC_MAIN_PROCESSOR;

