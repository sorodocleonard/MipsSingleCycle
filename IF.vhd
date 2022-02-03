library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity InstF is
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
end InstF;

architecture Behavioral of InstF is

signal d, q, mux_out:std_logic_vector(15 downto 0);


type mem_rom is array (0 to 15) of std_logic_vector (15 downto 0);
signal ROM : mem_rom:= ( 
0=> B"000_000_000_001_0_000", -- add $1,$0,$0  i=0
1=> B"001_000_010_0001000",   -- addi $2,$0,8  numar iteratii=8
2=> B"000_000_000_011_0_000", -- add $3,$0,$0  locatia de memorie
3=> B"000_000_000_100_0_000", -- add $4,$0,$0  suma=0
4=> B"100_001_010_0000111", -- beq $1,$2,7   compara i cu numar de iteratii
5=> B"010_011_101_0000000",   -- lw $5,0($3)   aduce elementul din memorie
6=> B"001_101_101_1111110",   -- addi $5,$5,-2 
7=> B"011_011_101_0000000",   -- sw $5,0($3)   salveaza elementul modificat 
8=> B"000_100_101_100_0_000", -- add $4,$4,$5  aduna elementul la suma
9=> B"001_011_011_0000001",   -- addi $3,$3,1  urmatoarea locatie de memorie
10=> B"001_001_001_0000001",   -- addi $1,$1,1 incrementeaza i
11=> B"111_0000000000100",   -- j 4          jump la beq   
12=> B"011_000_100_0001001",   -- sw $4,9($0)  salveaza suma in memorie

others => x"9999"
);  

begin

PCplus1<=q+1;
Instruction<=ROM(conv_integer (q(3 downto 0)));


with PCSrc Select
mux_out<=BranchAddress when '1',
    q+1 when others;
    
    

with Jump Select
d<=JumpAddress when '1',
    mux_out when others;
    

process (clk)
begin
if rising_edge(clk) then
    if rst='1' then
        q<="0000000000000000";
    elsif en='1' then
        q<= d;
    end if;
end if;
end process;
    
   
end Behavioral;