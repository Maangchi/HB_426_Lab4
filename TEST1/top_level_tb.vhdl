library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top_level_tb is
end entity;

architecture behavior of top_level_tb is
    signal clk_sig : std_logic := '0';
        
begin    
    DUT : entity work.top_level(simple)
          port map(clk => clk_sig);
clock : process
    begin
        for i in 0 to 2 * (NUM_VALS) loop
          clk_sig <= NOT clk_sig;
        wait for TIME_DELAY/2;
        end loop;
      wait;  
    end process clock;
  
end architecture;
