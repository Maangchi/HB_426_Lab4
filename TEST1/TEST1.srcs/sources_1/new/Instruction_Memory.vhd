library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Instruction_Memory is
    Port (
           Read_Address : in unsigned (15 downto 0);
           Rs : out unsigned (2 downto 0);
           Rt : out unsigned (2 downto 0);
           Rd : out unsigned (2 downto 0);
           Func : out unsigned (2 downto 0);
           immediate : out unsigned(5 downto 0);
           Opcode : out unsigned (3 downto 0);
           Instruction_Jump_Shift : out unsigned(11 downto 0));
           
end Instruction_Memory;

architecture Behavioral of Instruction_Memory is
begin
    
    
end Behavioral;
