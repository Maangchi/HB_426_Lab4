library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU is
    generic (N : integer;
             R : integer);
    port(   
    --Inputs
    ALUCtr : in unsigned(R downto 0);
    BusA : in unsigned(N downto 0);
    BusB : in unsigned(N downto 0);
    --Outputs
    zero : out std_logic;
    result: out unsigned(N downto 0));
    
end entity;

architecture behavior of ALU is

--***********************************************************************

procedure add(signal  A : in unsigned(N downto 0);
                      signal B : in unsigned(N downto 0);
                      signal Z : out std_logic;
                      signal Res : out unsigned(N downto 0)) is
                      
variable carry : unsigned(N downto 0);
variable result: unsigned(N downto 0);
begin
    result(0) := A(0) XOR B(0);
    carry(0) := A(0) and B(0);
    for i in 1 to N loop
        result(i) := A(i) XOR B(i) XOR carry(i-1);
        carry(i) := (a(i) AND carry(i-1)) OR (b(i) AND carry(i-1)) OR (a(i) AND b(i));
    end loop;
    
    res <= result;
    if((result) = 0) THEN
        Z <= '1';
    else
        Z <= '0';
    END IF;
end procedure;

--***********************************************************************

procedure sub(signal  A : in unsigned(N downto 0);
                      signal B : in unsigned(N downto 0);
                      signal Z : out std_logic;
                      signal Res : out unsigned(N downto 0)) is
variable result: unsigned(N downto 0);
variable Bnot : unsigned(N downto 0);
begin
  Res <= A-B;
  Z <= '0';
end procedure;

--***********************************************************************

procedure bitwise_and(signal A : in unsigned(N downto 0);
                      signal B : in unsigned(N downto 0);
                      signal Z : out std_logic;
                      signal Res : out unsigned(N downto 0)) is
variable result: unsigned(N downto 0);
begin

    result := A AND B;
    res <= result;
    if(to_integer(result) = 0) THEN
          Z <= '1';
      else
          Z <= '0';
      END IF;
end procedure;

--***********************************************************************

procedure bitwise_or(signal  A : in unsigned(N downto 0);
                      signal B : in unsigned(N downto 0);
                      signal Z : out std_logic;
                      signal Res : out unsigned(N downto 0)) is
variable result: unsigned(N downto 0);
begin

    result := A OR B;
    res <= result;
    if(to_integer(result) = 0) THEN
          Z <= '1';
      else
          Z <= '0';
      END IF;
end procedure;

--***********************************************************************

procedure logical_left_shift(signal  A : in unsigned(N downto 0);
                      signal Z : out std_logic;
                      signal Res : out unsigned(N downto 0)) is
variable result: unsigned(N downto 0);                      
begin
    result(N downto 1) := A(14 downto 0);
    result(0) := '0';
    
    res <= result;
    if(to_integer(result) = 0) THEN
          Z <= '1';
      else
          Z <= '0';
      END IF;
    
end procedure;

--***********************************************************************

procedure logical_right_shift(signal  A : in unsigned(N downto 0);
                      signal Z : out std_logic;
                      signal Res : out unsigned(N downto 0)) is
variable result: unsigned(N downto 0);                    
begin
    
    result(14 downto 0) := A(N downto 1);
    result(N) := '0';
    
    res <= result;
    if(to_integer(result) = 0) THEN
          Z <= '1';
      else
          Z <= '0';
      END IF;

end procedure;

--***********************************************************************

procedure Bitwise_Not(signal  A : in unsigned(N downto 0);
                      signal Z : out std_logic;
                      signal Res : out unsigned(N downto 0)) is
variable result: unsigned(N downto 0);                      
begin

result := not(A);
Res <= result;

end procedure;

--***********************************************************************

procedure Arith_right_shift(signal  A : in unsigned(N downto 0);
                      signal Z : out std_logic;
                      signal Res : out unsigned(N downto 0)) is
variable result: unsigned(N downto 0);
begin

    if A(N) = '1' then
        result(N) := '1';
        result(14 downto 0) := A(15 downto 1);
        result(14) := '0';
    else
        result(N) := '0';
        result(13 downto 0) := A(14 downto 1);
        result(14) := '0';
    end if;
    
    res <= result;
    if(to_integer(result) = 0) THEN
          Z <= '1';
      else
          Z <= '0';
      END IF;
    
end procedure;

--***********************************************************************


begin
    
    process(ALUCtr,BusA,BusB) is
    begin
        case ALUCtr is
            when "000" =>
                 add(BusA, BusB, zero,result);
                --addition
            when "001" =>
                 sub(BusA, BusB, zero, result);
                --subtraction
            when "010" =>
                 bitwise_and(BusA, BusB, zero,result);
                --Bitwise And
            when "011" =>
                bitwise_or(BusA, BusB, zero,result);
                --Bitwise Or
            when "100" =>
                logical_left_shift(BusA, zero, result);
                --Logical Left Shift
            when "101" =>
                logical_right_shift(BusA, zero, result);
                --Logical Right Shift
            when "110" =>
                Bitwise_Not(BusA, zero, result);
                --Bitwise NOT
            when "111" =>
                Arith_right_shift(BusA, zero, result);
                --Artihmetic right shift
            when others => report "other!";
        end case;
        
    end process;
    
end architecture;



