library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Control is
    Port ( Opcode : in unsigned (3 downto 0);
           Func : in unsigned (2 downto 0);
           RegDst : out STD_LOGIC;
           Branch : out STD_LOGIC;
           MemRead : out STD_LOGIC;
           MemtoReg : out STD_LOGIC;
           ALUOp : out Unsigned(2 downto 0);
           MemWrite : out STD_LOGIC;
           ALUSrc : out STD_LOGIC;
           RegWrite : out STD_LOGIC;
           LoadImmediatesMux : out STD_LOGIC;
           Jump : out STD_LOGIC);
end Control;

architecture Behavioral of Control is

begin


end Behavioral;
