library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Mux_Two_Outputs is
    generic(N : integer);
    Port ( Sel : in std_logic;
           A : in unsigned (N downto 0);
           C : out unsigned (N downto 0);
           D : out unsigned (N downto 0));
end Mux_Two_Outputs;

architecture Behavioral of Mux_Two_Outputs is

begin


end Behavioral;
