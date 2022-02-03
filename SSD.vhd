library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;



entity SSD is
    Port ( digits : in STD_LOGIC_VECTOR (15 downto 0);
           clk: in std_logic;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0) := "1111111");
end SSD;

architecture Behavioral of SSD is

signal clock: std_logic;
signal anode: std_logic_vector(1 downto 0) := "00";
signal display: std_logic_vector(3 downto 0) :=  "0000";
signal n: std_logic_vector(15 downto 0) := (others => '0');

begin

process(clk)
begin
    if rising_edge(clk) then
        n <= n + 1;
        anode <= n(15 downto 14);
    end if;
end process;

process(anode)
begin
    case(anode) is
        when "00" => an <= "1110"; display <= digits(3 downto 0);
        when "01" => an <= "1101"; display <= digits(7 downto 4);
        when "10" => an <= "1011"; display <= digits(11 downto 8);
        when "11" => an <= "0111"; display <= digits(15 downto 12);
        when others => an <= "1111"; display <= "0000";
    end case;
end process; 

process(display)
begin
      case display is
            when "0000" => cat <= "1000000"; --0  Activ pe 0
            when "0001" => cat <= "1111001"; --1
            when "0010" => cat <= "0100100"; --2
            when "0011" => cat <= "0110000"; --3
            when "0100" => cat <= "0011001"; --4
            when "0101" => cat <= "0010010"; --5
            when "0110" => cat <= "0000010"; --6
            when "0111" => cat <= "1111000"; --7
            when "1000" => cat <= "0000000"; --8
            when "1001" => cat <= "0010000"; --9
            when "1010" => cat <= "0001000"; --A
            when "1011" => cat <= "0000011"; --B
            when "1100" => cat <= "1000110"; --C
            when "1101" => cat <= "0100001"; --D
            when "1110" => cat <= "0000110"; --E
            when "1111" => cat <= "0001110"; --F
            when others => cat <= "0100000";
      end case;
end process;
          

end Behavioral;