library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Mux_LoadImmediates is
    generic (N: integer);
    Port ( whichLoad : in unsigned (1 downto 0);
           C : out unsigned (N downto 0);
           D : out unsigned (N downto 0);
           E : out unsigned (N downto 0);
           F : out unsigned (N downto 0));
end Mux_LoadImmediates;

architecture Behavioral of Mux_LoadImmediates is

begin


end Behavioral;
