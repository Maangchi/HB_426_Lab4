library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Shift_Bubble is
    generic(N : integer;
            R : integer);
    Port ( A : in unsigned (R downto 0);
           B : in unsigned (3 downto 0);
           C : out unsigned (N downto 0));
end Shift_Bubble;

architecture Behavioral of Shift_Bubble is

begin
    
    
    
end Behavioral;
