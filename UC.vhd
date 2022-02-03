library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity UC is
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
end UC;

architecture Behavioral of UC is

begin
process(Instr)
begin
    case Instr(15 downto 13) is
        when "000" => RegDst<= '1'; ExtOp<='0'; ALUSrc<='0'; Branch<='0'; Bne<='0'; Jump<='0'; MemWrite<='0'; MemtoReg<='0'; RegWrite<='1'; ALUOp<="00";
        when "001" => RegDst<= '0'; ExtOp<='1'; ALUSrc<='1'; Branch<='0'; Bne<='0'; Jump<='0'; MemWrite<='0'; MemtoReg<='0'; RegWrite<='1'; ALUOp<="10";
        when "010" => RegDst<= '0'; ExtOp<='1'; ALUSrc<='1'; Branch<='0'; Bne<='0'; Jump<='0'; MemWrite<='0'; MemtoReg<='1'; RegWrite<='1'; ALUOp<="10";
        when "011" => RegDst<= '0'; ExtOp<='1'; ALUSrc<='1'; Branch<='0'; Bne<='0'; Jump<='0'; MemWrite<='1'; MemtoReg<='0'; RegWrite<='0'; ALUOp<="10";
        when "100" => RegDst<= '0'; ExtOp<='1'; ALUSrc<='0'; Branch<='1'; Bne<='0'; Jump<='0'; MemWrite<='0'; MemtoReg<='0'; RegWrite<='0'; ALUOp<="01";
        when "101" => RegDst<= '0'; ExtOp<='1'; ALUSrc<='1'; Branch<='0'; Bne<='0'; Jump<='0'; MemWrite<='0'; MemtoReg<='0'; RegWrite<='1'; ALUOp<="01";
        when "110" => RegDst<= '0'; ExtOp<='1'; ALUSrc<='0'; Branch<='0'; Bne<='1'; Jump<='0'; MemWrite<='0'; MemtoReg<='0'; RegWrite<='0'; ALUOp<="01";
        when "111" => RegDst<= '0'; ExtOp<='0'; ALUSrc<='0'; Branch<='0'; Bne<='0'; Jump<='1'; MemWrite<='0'; MemtoReg<='0'; RegWrite<='0'; ALUOp<="00";
    end case;
end process;

end Behavioral;