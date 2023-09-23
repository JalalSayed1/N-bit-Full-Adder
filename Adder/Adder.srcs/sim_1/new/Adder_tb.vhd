-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Adder_tb is
end;

architecture bench of Adder_tb is

  component Adder
      Port ( A : in STD_LOGIC;
             B : in STD_LOGIC;
             Cin : in STD_LOGIC;
             S : out STD_LOGIC;
             Cout : out STD_LOGIC);
  end component;

  signal A: STD_LOGIC;
  signal B: STD_LOGIC;
  signal Cin: STD_LOGIC;
  signal S: STD_LOGIC;
  signal Cout: STD_LOGIC;

begin

  uut: Adder port map ( A    => A,
                        B    => B,
                        Cin  => Cin,
                        S    => S,
                        Cout => Cout );

  stimulus: process
  begin
  
    -- Put initialisation code here
    a <= '0';
    b <= '0';
    cin <= '0';
    wait for 10 ns;
    a <= '0';
    b <= '0';
    cin <= '1';
    wait for 10 ns;
    a <= '0';
    b <= '1';
    cin <= '0';
    wait for 10 ns;
    a <= '0';
    b <= '1';
    cin <= '1';
    wait for 10 ns;
    a <= '1';
    b <= '1';
    cin <= '1';
    wait for 10 ns;
    a <= '1';
    b <= '0';
    cin <= '0';
    wait for 10 ns;
    a <= '1';
    b <= '1';
    cin <= '0';
    wait for 10 ns;
    a <= '1';
    b <= '0';
    cin <= '1';

    -- Put test bench stimulus code here

    wait;
  end process;


end;