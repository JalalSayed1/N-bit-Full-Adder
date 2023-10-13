----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.10.2023 16:17:44
-- Design Name: 
-- Module Name: FullAdder_16bits - Behavioral
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

entity FullAdder_16bits is
    generic (
    num_of_bit: natural := 16 --this can be changed to make different adders using 4 bit adder.
    );
    Port ( A : in STD_LOGIC_VECTOR (num_of_bit-1 downto 0);
           B : in STD_LOGIC_VECTOR (num_of_bit-1 downto 0);
           Cin : in STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (num_of_bit-1 downto 0);
           Cout : out STD_LOGIC);
end FullAdder_16bits;

architecture Behavioral of FullAdder_16bits is

    signal internalSum: STD_LOGIC_VECTOR (num_of_bit-1 downto 0);
    signal internalCout: STD_LOGIC_VECTOR (num_of_bit/4-1 downto 0);  -- We are assuming we are scaling up using the FullAdder_4bits. Hence divided by 4.
    COMPONENT FullAdder_4bits
        Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
               B : in STD_LOGIC_VECTOR (3 downto 0);
               Cin : in STD_LOGIC;
               Sum : out STD_LOGIC_VECTOR (3 downto 0);
               Cout : out STD_LOGIC);
    end COMPONENT;
begin
    gen: for i in 0 to (num_of_bit/4)-1 generate
        signal temoCout: std_logic;
    begin
        FA: FullAdder_4bits
        port map (
            A => A(i*4+3 downto i*4),
            B => B(i*4+3 downto i*4),
            ---- error here below 
            Cin => Cin when (i = 0) else internalCout(i-1), -- First module takes external Cin, others take previous module's Cout
            Sum => internalSum(i*4+3 downto i*4),
            Cout => tempCout
            );
        internalCout(i) <= tempCout;
    end generate gen;

    Sum <= internalSum;
    Cout <= internalCout(num_of_bit/4-1); -- Carry from the MSB module

end Behavioral;    
