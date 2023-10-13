----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.10.2023 15:09:11
-- Design Name: 
-- Module Name: FullAdder_8bits_tb - Behavioral
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
-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity FullAdder_8bits_tb is
end;

architecture bench of FullAdder_8bits_tb is
constant num_of_bits : integer := 8;  -- adjust the value of n as needed
  component FullAdder_8bits
      Port ( A : in STD_LOGIC_VECTOR (num_of_bits-1 downto 0);
             B : in STD_LOGIC_VECTOR (num_of_bits-1 downto 0);
             Cin : in STD_LOGIC;
             Sum : out STD_LOGIC_VECTOR (num_of_bits-1 downto 0);
             Cout : out STD_LOGIC);
  end component;
-- figure out why this exists
  signal A: STD_LOGIC_VECTOR (num_of_bits-1 downto 0);
  signal B: STD_LOGIC_VECTOR (num_of_bits-1 downto 0);
  signal Cin: STD_LOGIC;
  signal Sum: STD_LOGIC_VECTOR (num_of_bits-1 downto 0);
  signal Cout: STD_LOGIC;



begin
  uut: FullAdder_8bits port map ( A    => A,
                                  B    => B,
                                  Cin  => Cin,
                                  Sum  => Sum,
                                  Cout => Cout );

stimulus: process

  variable num_of_combination : integer := (2**num_of_bits)-1;
  
  -- 9 bit number for sum (8 bits) and curry out (1 one):
  variable expected_sum : std_logic_vector(num_of_bits downto 0);
 
  begin

    for A_value in 0 to num_of_combination loop -- 16 combination for 4 bit input
        for B_value in 0 to num_of_combination loop
            for C_value in 0 to 1 loop
                -- convert A/B_value to unsigned (num_of_bits) bit number. We don't use signed values. 
                -- Then convert to std logic vector and asign to bus A/B.
                A <= std_logic_vector(to_unsigned(A_value, num_of_bits));
                B <= std_logic_vector(to_unsigned(B_value, num_of_bits));
                -- Cin is just 1 bit:
                if C_value = 0 then
                    Cin <= '0';
                else
                    Cin <= '1';
                end if;
   
                -- wait for results:
                wait for 10 ns;
                
                -- we sum A_value, B_value and C_value then we compare with 'Sum':
                expected_sum := std_logic_vector(to_unsigned(A_value + B_value + C_value, num_of_bits+1));
                
                -- check result:
                assert expected_sum(num_of_bits-1 downto 0) = Sum and expected_sum(num_of_bits) = Cout
                    report "Mismatch: expected: " & integer'image(to_integer(unsigned(expected_sum(num_of_bits-1 downto 0))))  & ", instead: " & integer'image(to_integer(unsigned(Sum)))
                    severity error;
       
                    
            end loop;
         end loop;
         
     end loop;
     
     report "Simulation finished !!"
     severity note;
     wait;
     
  end process;


end;