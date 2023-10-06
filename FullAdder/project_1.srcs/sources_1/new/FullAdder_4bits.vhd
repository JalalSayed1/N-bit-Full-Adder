----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.10.2023 09:36:34
-- Design Name: 
-- Module Name: FullAdder_4bits - Behavioral
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

entity FullAdder_4bits is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (3 downto 0);
           Cout : out STD_LOGIC);
end FullAdder_4bits;

architecture Behavioral of FullAdder_4bits is
    signal S0, S1 : STD_LOGIC_VECTOR (1 downto 0);
    signal C0, C1 : STD_LOGIC;    
    
    COMPONENT FullAdder_2bits
        Port ( A : in STD_LOGIC_VECTOR (1 downto 0);
               B : in STD_LOGIC_VECTOR (1 downto 0);
               Cin : in STD_LOGIC;
               Sum : out STD_LOGIC_VECTOR (1 downto 0);
               Cout : out STD_LOGIC);
    end COMPONENT;
begin

    FA_LSB: FullAdder_2bits
        port map (
            A => A(1 downto 0),
            B => B(1 downto 0),
            Cin => Cin,
            Sum => S0,
            Cout => C0
        );

    -- Connect the second full adder for the MSB
       
    FA_MSB: FullAdder_2bits 
        port map (
            A => A(3 downto 2),
            B => B(3 downto 2),
            Cin => C0,   -- Carry from the LSB full adder
            Sum => S1,
            Cout => C1
        );

    -- Connect the outputs
    Sum(1 downto 0) <= S0;
    Sum(3 downto 2) <= S1;
    Cout <= C1;  -- Carry from the MSB full adder

end Behavioral;
