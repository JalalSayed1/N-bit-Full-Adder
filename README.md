# N-bit Full Adder

## Introduction

This is a N-bit full adder made in VHDL.

---

## 1-bit full adder

Firstly, make a 1-bit full adder to be used to scale up to N-bit full adder.

![1-bit](img\1-bit-full-adder.png)

Reference: [Full Adder Circuit and its Construction](https://circuitdigest.com/tutorial/full-adder-circuit-theory-truth-table-construction)

### Notes

```vhdl
entity adder_1bit is
port(A, B, Cin : in std_logic;
     Sum, Cout : out std_logic);
end entity adder_1bit;
```

1. `Entity`: In VHDL, an entity is a declaration of inputs and outputs for a digital system. It's like defining a function's inputs and outputs in other programming languages.
2. `std_logic`: A data type used in VHDL to represent binary values, including '0', '1', and some meta-values such as 'U' (undefined).
3. `in` and `out`: These define the direction of signals. "in" represents input signals, and "out" represents output signals.

### Testbench
Tested manually as the structure is simple. More advanced testbenches is implemented as number of bits increases.
```vhdl
stimulus: process 
  begin 
     -- Combination 1 
    A <= "0"; B <= "0"; Cin <= '0'; 
    wait for 10 ns; 
...
end process;
```

## 2 bits full adder

Using two 1-bit adders to make a 2 bits adder.

### Notes

```vhdl
entity adder_2bit is
port(A, B : in std_logic_vector(1 downto 0);
     Sum : out std_logic_vector(1 downto 0);
     Cout : out std_logic);
end entity adder_2bit;
```

1. `std_logic_vector`: This is an array of `std_logic`, just like a list in Python.
2. `(1 downto 0)`: This defines the range of the vector, starting from bit 1 down to bit 0, essentially representing a 2-bit binary number.

```vhdl
architecture ...
COMPONENT FullAdder_1bit 
        Port ( A : in STD_LOGIC; 
               B : in STD_LOGIC; 
               Cin : in STD_LOGIC; 
               S : out STD_LOGIC; 
               Cout : out STD_LOGIC); 
    end COMPONENT;
begin

    FA: FullAdder_1bit  
    port map ( 
        A => A(0), 
        B => B(0), 
        Cin => Cin, 
        S => S0, 
        Cout => C0 
    ); 
...
end Behavioral; 
```

1. `COMPONENT`: In VHDL, a component declaration is a way to declare a reusable entity. It can be used in multiple places in the same design or in multiple designs. It declares the interface of the component. The interface of a component is the set of its input and output ports. The component declaration is followed by a component instantiation. It instantiates the component and connects its ports to signals in the design.
2. `port map`: This is a way to connect the ports of a component to signals in the design. It's used in component instantiation.
3. `=>`: association operator, used in Port Maps to associate signals with ports of the component/entity.


### Testbench
Tested manually as the structure is simple. More advanced testbenches is implemented as number of bits increases.

```vhdl
stimulus: process
begin
    -- Combination 1  
   A <= "00"; B <= "00"; Cin <= '0';
   wait for 10 ns;
...
end process;
```

![2-bit](img/2-bit%20results.png)

## 4 bits full adder

Using two 2-bits adders to make a 4 bits adder.

### Notes

```vhdl
architecture Behavioral of FullAdder_4bits is 
   signal S0, S1 : STD_LOGIC_VECTOR (1 downto 0); 
   signal C0, C1 : STD_LOGIC; 
    COMPONENT FullAdder_2bits
       ...
    end COMPONENT;
begin
...
end Behavioral;
```

1. `signal`: This is a way to declare a signal in VHDL. A signal is a variable that can be used to transfer data between processes or between a process and an entity. It's like a variable in other programming languages.

### Testbench

```vhdl
stimulus: process
for A_value in 0 to 15 loop -- 16 combination for 4 bit input 
        for B_value in 0 to 15 loop 
            for C_value in 0 to 1 loop 

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
```

1. `loop`: This is a way to loop through a range of values. As number of combinations increases, it's more efficient and easier to use loops to test all combinations.
2. `to_unsigned`: This is a way to convert an integer to a `std_logic_vector`. It's used to convert the loop variable to a `std_logic_vector` to be used as input to .
3. `report`: This is a way to print a message to the console. It's used to indicate the end of simulation. In the future, it will be used to report errors.

![4-bit](img/4-bit%20results.png)

## 8 bits full adder

Using two 4-bits adders to make a 8 bits adder.

### Testbench

```vhdl
architecture bench of FullAdder_8bits_tb is 
   constant num_of_bits : integer := 8; 
   ...
begin
stimulus: process
   variable num_of_combination : integer := (2**num_of_bits)-1; 
   variable expected_sum : std_logic_vector(num_of_bits downto 0);
begin
   for A_value in 0 to num_of_combination loop
      ...
       A <= std_logic_vector(to_unsigned(A_value, num_of_bits));
       ...
       expected_sum := std_logic_vector(to_unsigned(A_value + B_value + C_value, num_of_bits+1));
       assert expected_sum(num_of_bits-1 downto 0) = Sum and expected_sum(num_of_bits) = Cout 
            report "Mismatch: expected: " & integer'image(to_integer(unsigned(expected_sum(num_of_bits-1 downto 0))))  & ", instead: " & integer'image(to_integer(unsigned(Sum))) 
           severity error; 
      ...
end process;
end;
```

1. `constant`: This is a way to declare a constant in VHDL. A constant is a variable that can't be changed on runtime.
2. `variable`: This is a way to declare a variable in VHDL.
3. `assert`: This is a way to assert a condition. If the condition is false, it will report an error.
4. `severity`: This is a way to define the severity of an error. It can be `note`, `warning`, `error`, or `failure`.

When expected_sum is incorrect, in tcl console, it will show:

![8-bit](img/8-bit%20resutls.png)

## 16 bits full adder

For this, we wanted to use generic and generate to make the code more scalable. Therefore, we are using 4x 4-bits adders to make a 16 bits adder.

<!-- ### Notes

```vhdl

```

1. .

### Testbench

```vhdl

```

1. .

![16-bit](img/16-bit%20results.png)

## N bits full adder

To make a very scalable full adder and to make the code as dynamic as possible, we are using generic and generate to make a N bits adder out of 1-bit adders.

### Notes

```vhdl

```

1. .

### Testbench

```vhdl

```

1. .

![N-bit](img/N-bit%20results.png)

## Conclusion

1. . -->
