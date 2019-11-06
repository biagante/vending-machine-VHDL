library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity Comparador is
	port(input0 : in std_logic_vector(7 downto 0);
		  input1 : in std_logic_vector(7 downto 0);
		  cmpOut : out std_logic);
end Comparador;

architecture Behavioral of Comparador is
begin
	cmpOut <= '1' when (input0 >= input1) else
				 '0';
end Behavioral;