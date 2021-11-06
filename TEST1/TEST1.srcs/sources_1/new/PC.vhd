library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC is
    Generic(N: integer);
    Port ( clk : in std_logic;
           A : in unsigned (N downto 0);
           C : out unsigned (N downto 0));
end PC;

architecture Behavioral of PC is
begin


end Behavioral;
