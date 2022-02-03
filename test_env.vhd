library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;


entity test_env is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0);
           sim : out std_logic_vector(15 downto 0));
end test_env;

architecture Behavioral of test_env is

component MPG is
 port( en : out STD_LOGIC;
       input : in STD_LOGIC;
       clk : in STD_LOGIC);
end component;

component SSD is
    Port ( digits : in STD_LOGIC_VECTOR (15 downto 0);
           clk: in std_logic;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0) := "1111111");
end component;

component InstF is
--  Port ( );
      Port (  clk : in std_logic;
      BranchAddress :in std_logic_vector (15 downto 0);
      JumpAddress : in std_logic_vector (15 downto 0);
      Jump : in std_logic;
      PCSrc :in std_logic;  
      PCplus1: out std_logic_vector(15 downto 0);
      Instruction: out std_logic_vector (15 downto 0);
      EN : in std_logic;
      RST: in std_logic);
end component;

component ID is
--  Port ( );
 Port(
        RegWrite: in std_logic;
        Instr: in std_logic_vector(15 downto 0);
        RegDst: in std_logic;
        clk: in std_logic;
        en:in std_logic;
        ExtOp: in std_logic;
        WD:in std_logic_vector(15 downto 0);
        RD1: out std_logic_vector(15 downto 0);
        RD2: out std_logic_vector (15 downto 0);
        Ext_imm: out std_logic_vector (15 downto 0);
        func: out std_logic_vector(2 downto 0);
        sa : out std_logic
    );
end component;

component EX is
    Port ( 
            PCplus1 : in std_logic_vector(15 downto 0);
            RD1 : in std_logic_vector(15 downto 0);
            RD2 : in std_logic_vector(15 downto 0);
            Ext_Imm : in std_logic_vector(15 downto 0);
            func: in std_logic_vector(2 downto 0);
            sa: in std_logic;
            ALUSrc: in std_logic;
            ALUOp: in std_logic_vector(1 downto 0);
            BranchAdr: out std_logic_vector(15 downto 0);
            ALURes: out std_logic_vector(15 downto 0);
            Zero: out std_logic;
            Dif: out std_logic
             );
    
end component;

component UC is
  Port (
        Instr : in std_logic_vector(15 downto 0);
        RegDst: out std_logic;
        ExtOp: out std_logic;
        ALUSrc: out std_logic;
        Branch: out std_logic;
        Bne: out std_logic;
        Jump: out std_logic;
        ALUOp: out std_logic_vector(1 downto 0);
        MemWrite: out std_logic;
        MemtoReg: out std_logic;
        RegWrite: out std_logic
         );
end component;

component MEM is
--  Port ( );
    Port(
    MemWrite: in std_logic;
    ALUResIn: in std_logic_vector(15 downto 0);
    RD2: in std_logic_vector (15 downto 0);
    clk: in std_logic;
    en: in std_logic;
    MemData: out std_logic_vector(15 downto 0);
    ALUResOut: out std_logic_vector (15 downto 0));
end component;

signal Instruction, PCplus1, RD1, RD2, Ext_Imm, WD, JumpAdress, BranchAdress, ALURes, ALUResOut, MemData: std_logic_vector(15 downto 0);
signal en, rst, Jump, MemtoReg, MemWrite, Branch, ALUSrc, Bne, RegWrite, RegDst, sa, ExtOp, PcSrc, Zero, Dif : std_logic;
signal ALUOp : std_logic_vector(1 downto 0);
signal func : std_logic_vector(2 downto 0);
signal afiseaza : std_logic_vector(15 downto 0);

begin


MPG1 : MPG port map(en,btn(0),clk);

MPG2 : MPG port map(rst,btn(1),clk);

InstFX: InstF port map(clk,BranchAdress,JumpAdress,Jump,PcSrc,Pcplus1,Instruction,en,rst);

IDX: ID port map(RegWrite,Instruction,RegDst,clk,en,ExtOp,WD,RD1,RD2,Ext_Imm,func,sa);

EXX: EX port map(Pcplus1,RD1,RD2,Ext_Imm,func,sa,ALUSrc,ALUOp,BranchAdress,ALURes,Zero,Dif);

UCX: UC port map(Instruction,RegDst,ExtOp,ALUSrc,Branch,Bne,Jump,ALUOp,MemWrite,MemtoReg,RegWrite);

MEMX: MEM port map(MemWrite,ALURes,RD2,clk,en,MemData,ALUResOut);

WD <= ALUResOut when MemtoReg='0'
    else MemData;
PCSrc <= (Branch and Zero) or (Bne and Dif);
JumpAdress <= Pcplus1(15 downto 13) & Instruction(12 downto 0);

--with sw(7 downto 5) Select
--    afiseaza <= Instruction when "000",
  --              PCplus1 when "001",
    --            RD1 when "010",
      --          RD2 when "011",
        --        Ext_Imm when "100",
          --      ALURes when "101",
            --    MemData when "110",
              --  WD when "111";
  afiseaza<= Instruction;             
  sim <= afiseaza;            
end Behavioral;
