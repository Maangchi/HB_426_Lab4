library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Registers is
    generic(N : integer;
            R : integer);
    port(   
    --Inputs
    clk : std_logic;
    RegWr: in std_logic;
    Rd   : in unsigned(R downto 0);
    Rs   : in unsigned(R downto 0);
    Rt   : in unsigned(R downto 0);
    busW : in unsigned(N downto 0);
    --Outputs
    BusA: out unsigned(N downto 0);
    BusB: out unsigned(N downto 0));
end entity;

architecture behavior of Registers is
    type Reg is array (0 to 3) of unsigned(0 to N);
    signal Registers: Reg := (others =>(others => '0'));

begin
    Write_Read : process (clk)
    begin
        IF(rising_edge(clk)) THEN
            BusA <= Registers(to_integer(Rs));
            BusB <= Registers(to_integer(Rt));   
        END if; 
        IF(falling_edge(clk)) THEN
            IF(RegWr = '1') THEN
                Registers(to_integer(Rd)) <= busW;
            END if;
        END if;
    end process Write_Read;
end behavior;
