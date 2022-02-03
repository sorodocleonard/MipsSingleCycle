library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;



entity EX is
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
    
end EX;

architecture Behavioral of EX is

signal final : std_logic_vector(15 downto 0);
signal T2 : std_logic_vector(15 downto 0);
signal checkZero : std_logic;
signal ALUCtrl : std_logic_vector(2 downto 0);


begin

T2 <= RD2 when ALUSrc = '0'
        else Ext_Imm;
checkZero <= '1' when final= X"0000"
        else '0';
Zero<= checkZero;
Dif<= not checkZero;
ALURes<= final;
BranchAdr<= Ext_Imm + PCplus1;

process(ALUOp,func)
begin

case ALUOp is
    when "00" => ALUCtrl <= func; -- "func"
    when "01" => ALUCtrl <= "001"; -- "-"
    when "10" => ALUCtrl <= "000"; -- "+"
    when "11" => ALUCtrl <= "101"; -- "or"
    end case;
 end process;
 
 process(ALUCtrl,RD1,T2,sa)
 begin
 
 case ALUCtrl is
    when "000" => final <= RD1 + T2; -- ADD
    when "001" => final <= RD1 - T2; -- SUB
    when "010" => if (sa='1') then final<= T2(14 downto 0) & '0'; -- SLL
                        else final<=T2; 
                  end if;
    when "011" => if (sa='1') then final<= '0' & T2(15 downto 1); -- SRL
                        else final<=T2; 
                  end if;
    when "100" => final <= RD1 and T2; -- AND
    when "101" => final <= RD1 or T2; -- OR
    when "110" => final <= RD1 xor T2; -- XOR
    when "111" => if ( signed(RD1) < signed(T2) ) then final<=X"0001"; -- SLT
                        else final<=x"0000"; 
                  end if;
  end case;
 end process;

end Behavioral;
