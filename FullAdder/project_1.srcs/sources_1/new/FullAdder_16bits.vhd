----------------------------------------------------------------------------------
-- Company: QCG
-- Engineer: Jalal & Tamim      
-- 
-- Create Date: 21.10.2023 19:07:02
-- Design Name: Making n-bit adder using generic and generate
-- Module Name: n_bit_adder - Behavioral
-- Project Name: FPGA Programming  
-- Target Devices: tbc
-- Tool Versions: 
-- Description: Creating a 16-bit adder scaled up from 1-bit adder. Scales upo until number of bits =< 31. 
-- 
-- Dependencies: tbc
-- 
-- Revision: 2
-- Revision 0.01 - File Created
-- Additional Comments:
-- get in touch in touch if you can help with number of bits => 32
----------------------------------------------------------------------------------


library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity FullAdder_16bits is
    generic (
        num_of_bit: integer := 16 
    );
    Port (
        A    : in  STD_LOGIC_VECTOR (num_of_bit-1 downto 0);
        B    : in  STD_LOGIC_VECTOR (num_of_bit-1 downto 0);
        Cin  : in  STD_LOGIC;
        Sum  : out STD_LOGIC_VECTOR (num_of_bit-1 downto 0);
        Cout : out STD_LOGIC
    );
end FullAdder_16bits;

-- 16-bit adder made using from 1-bit adder utilising the generate method in VHDL. 
architecture Behavioral of FullAdder_16bits is

    signal internalSum   : STD_LOGIC_VECTOR (num_of_bit-1 downto 0) := (others => '0');
   
    signal internalCarry : STD_LOGIC_VECTOR (num_of_bit downto 0) := (others => '0');

-- n-bit adder made from a 1 bit adder.
    COMPONENT FullAdder_1bit
        Port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            Cin  : in  STD_LOGIC;
            Sum  : out STD_LOGIC;
            Cout : out STD_LOGIC
        );
    end COMPONENT;

begin
    -- Initialize the first internal carry with the external Cin
    internalCarry(0) <= Cin;  

    -- Generate statement creates multiple 1-bit adder instances based on num_of_bit
    gen: for i in 0 to num_of_bit-1 generate
    begin
    
        -- Each 1-bit adder instance is mapped to segments of the input A and B vectors
        -- The internal carry signal is used to pass the carry-out from one 1-bit adder to the next
        FA: FullAdder_1bit
        port map (
            A    => A(i),             -- Selecting 1-bit segment of A
            B    => B(i),             -- Selecting 1-bit segment of B
            Cin  => internalCarry(i),                -- Using the carry-out from the previous adder
            Sum  => internalSum(i),   -- Storing the sum of the 1-bit segment
            Cout => internalCarry(i+1)               -- Storing the carry-out for the next 1-bit adder
        );

    end generate gen;

    -- The complete 16-bit (or num_of_bit) sum is assigned from the combined sum of all 1-bit adder
    Sum  <= internalSum;
    -- The carry-out from the 16-bit adder is taken from the last 1-bit adder
    Cout <= internalCarry(num_of_bit);

end Behavioral;
