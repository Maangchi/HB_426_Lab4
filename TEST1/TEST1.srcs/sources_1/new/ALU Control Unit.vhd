----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2021 01:21:06 PM
-- Design Name: 
-- Module Name: ALU Control Unit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_Control_Unit is
    generic(R:integer);
    Port ( A : in unsigned (R downto 0);
           B : in unsigned (R downto 0);
           C : out unsigned (R downto 0));
end ALU_Control_Unit;

architecture Behavioral of ALU_Control_Unit is

begin


end Behavioral;
