library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Load_Immediates_Result is
    generic(N : integer);
    Port ( A : in unsigned(N downto 0);
           B : in unsigned(N downto 0);
           C : in unsigned(N downto 0);
           D : in unsigned(N downto 0);
           E : out unsigned(N downto 0));
end Load_Immediates_Result;

architecture Behavioral of Load_Immediates_Result is

begin


end Behavioral;
