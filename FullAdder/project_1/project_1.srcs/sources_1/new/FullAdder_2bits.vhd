----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.09.2023 12:28:43
-- Design Name: 
-- Module Name: FullAdder_2bits - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FullAdder_2bits is
    Port ( A : in STD_LOGIC_VECTOR (1 downto 0);
           B : in STD_LOGIC_VECTOR (1 downto 0);
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (1 downto 0));
end FullAdder_2bits;

architecture Behavioral of FullAdder_2bits is

-- Internal signals for 1-bit sum and carry outputs
    signal S0, S1 : STD_LOGIC;
    signal C0, C1 : STD_LOGIC;

    -- Use the 1-bit full adder to make 2-bits adder:
    COMPONENT FullAdder_1bit
        Port ( A : in STD_LOGIC;
               B : in STD_LOGIC;
               Cin : in STD_LOGIC;
               S : out STD_LOGIC;
               Cout : out STD_LOGIC);
    end COMPONENT;

begin

-- Connect the first full adder for the LSB
    FA_LSB: FullAdder_1bit 
    port map (
        A => A(0),
        B => B(0),
        Cin => Cin,
        S => S0,
        Cout => C0
    );

    -- Connect the second full adder for the MSB
    FA_MSB: FullAdder_1bit 
    port map (
        A => A(1),
        B => B(1),
        Cin => C0,   -- Carry from the LSB full adder
        S => S1,
        Cout => C1
    );

    -- Connect the outputs
    Sum(0) <= S0;
    Sum(1) <= S1;
    Cout <= C1;  -- Carry from the MSB full adder


end Behavioral;
