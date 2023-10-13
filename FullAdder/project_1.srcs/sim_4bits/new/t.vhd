library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder_8bits is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Cin : in STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (7 downto 0);
           Cout : out STD_LOGIC);
end FullAdder_8bits;

--This architecture 
architecture Behavioral of FullAdder_8bits is
signal S0, S1 : STD_LOGIC_VECTOR (3 downto 0);
    signal C0, C1 : STD_LOGIC;    
    
    COMPONENT FullAdder_4bits
        Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
               B : in STD_LOGIC_VECTOR (3 downto 0);
               Cin : in STD_LOGIC;
               Sum : out STD_LOGIC_VECTOR (3 downto 0);
               Cout : out STD_LOGIC);
    end COMPONENT;
begin

    FA_LSB: FullAdder_4bits
        port map (
            A => A(3 downto 0),
            B => B(3 downto 0),
            Cin => Cin,
            Sum => S0,
            Cout => C0
        );

    -- Connect the second full adder for the MSB
       
    FA_MSB: FullAdder_4bits 
        port map (
            A => A(7 downto 4),
            B => B(7 downto 4),
            Cin => C0,   -- Carry from the LSB full adder
            Sum => S1,
            Cout => C1
        );

    -- Connect the outputs
    Sum(3 downto 0) <= S0;
    Sum(7 downto 4) <= S1;
    Cout <= C1;  -- Carry from the MSB full adder

end Behavioral;

