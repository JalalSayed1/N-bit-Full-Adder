----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.10.2023 11:23:26
-- Design Name: 
-- Module Name: FullAdder_4bits_tb - Behavioral
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

entity FullAdder_4bits_tb is
end;

architecture bench of FullAdder_4bits_tb is

  component FullAdder_4bits
      Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
             B : in STD_LOGIC_VECTOR (3 downto 0);
             Cin : in STD_LOGIC;
             Sum : out STD_LOGIC_VECTOR (3 downto 0);
             Cout : out STD_LOGIC);
  end component;

  signal A: STD_LOGIC_VECTOR (3 downto 0);
  signal B: STD_LOGIC_VECTOR (3 downto 0);
  signal Cin: STD_LOGIC;
  signal Sum: STD_LOGIC_VECTOR (3 downto 0);
  signal Cout: STD_LOGIC;

begin

  uut: FullAdder_4bits port map ( A    => A,
                                  B    => B,
                                  Cin  => Cin,
                                  Sum  => Sum,
                                  Cout => Cout );

stimulus: process
  begin
    A <= "0000";
    B <= "0000";
    Cin <= '0';
    wait for 10 ns; 
    
    for A_value in 0 to 15 loop -- 16 combination for 4 bit input
        for B_value in 0 to 15 loop
            for C_value in 0 to 1 loop
                -- convert A/B_value to unsigned 4 bit number. We don't use signed values. 
                -- Then convert to std logic vector and asign to bus A/B.
                A <= std_logic_vector(to_unsigned(A_value, 4));
                B <= std_logic_vector(to_unsigned(B_value, 4));
                -- Cin is just 1 bit:
                if C_value = 0 then
                    Cin <= '0';
                else
                    Cin <= '1';
                end if;
   
                -- wait for results:
                wait for 100 ns;
            
            end loop;
         end loop;
     end loop;
            
   report "Simulation Finished";
   wait;
  end process;


end;