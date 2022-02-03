library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MPG is
 port( en : out STD_LOGIC;
       input : in STD_LOGIC;
       clk : in STD_LOGIC);
end MPG;

architecture Behavioral of MPG is

signal count_int: STD_LOGIC_VECTOR(15 downto 0) := x"0000";
signal Q1 : STD_LOGIC;
signal Q2 : STD_LOGIC;
signal Q3 : STD_LOGIC;

begin
en <= Q2 and (not Q3);

process(clk)
begin
    if clk'event and clk='1' then
        if count_int(15 downto 0) = "1111111111111111" then
            Q1 <= input;
        end if;
    end if;
end process;

process(clk)
begin
    if clk'event and clk='1' then
        count_int <= count_int + 1;
    end if;
end process;

process(clk)
begin
    if clk'event and clk='1' then
        Q2 <= Q1;
        Q3 <= Q2;
    end if;
end process;

end Behavioral;