

--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--


entity MEM is
--  Port ( );
    Port(
    MemWrite: in std_logic;
    ALUResIn: in std_logic_vector(15 downto 0);
    RD2: in std_logic_vector (15 downto 0);
    clk: in std_logic;
    en: in std_logic;
    MemData: out std_logic_vector(15 downto 0);
    ALUResOut: out std_logic_vector (15 downto 0));
end MEM;

architecture Behavioral of MEM is

type memorie is array (0 to 32) of std_logic_vector (15 downto 0);
signal MEM: memorie:=(x"0000", x"0001",x"0002",x"0003",x"0004",x"0005",x"0006",x"0007",x"0008",x"0009", others => x"0000");

begin
    
    ALUResOut<=ALUResIn;
    MemData<= MEM(conv_integer(ALUResIn(4 downto 0)));
    process (clk)
    begin
        if rising_edge(clk) then
            if en='1' and MemWrite='1' then 
                MEM(conv_integer(ALUResIn(4 downto 0))) <= RD2;
            end if;
        end if;
     end process;
          

end Behavioral;