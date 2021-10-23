----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2021 04:10:41 PM
-- Design Name: 
-- Module Name: Instruction_Memory - Behavioral
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

entity Instruction_Memory is
    Port ( Read_Address : in unsigned (15 downto 0);
           Rs : out unsigned (2 downto 0);
           Rt : out unsigned (2 downto 0);
           Rd : out unsigned (2 downto 0);
           Func : out unsigned (2 downto 0);
           Opcode : out unsigned (3 downto 0);
           Instruction_Jump_Shift : out unsigned(11 downto 0));
           
end Instruction_Memory;

architecture Behavioral of Instruction_Memory is
begin
    
    
end Behavioral;
