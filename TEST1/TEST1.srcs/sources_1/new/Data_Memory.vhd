----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity Data_Memory is
    generic(N : integer);
    Port ( MemWrite : in std_logic;
           MemRead : in std_logic;
           ALU_Result : in unsigned (N downto 0);
           Read_Data : out unsigned (N downto 0);
           Write_Data : in unsigned (N downto 0));
end Data_Memory;

architecture Behavioral of Data_Memory is

begin


end Behavioral;
