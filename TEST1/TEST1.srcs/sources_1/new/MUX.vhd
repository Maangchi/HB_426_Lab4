library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MUX is
    generic(N : integer);
    Port ( Sel : in std_logic;
           A : in unsigned(N downto 0);
           B : in unsigned(N downto 0);
           C : out unsigned(N downto 0));
end MUX;

architecture Behavioral of MUX is

begin


end Behavioral;
