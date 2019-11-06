library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity selector is
	port(clock : out std_logic;
		  clk : in std_logic;
		  p1, p2, p3, p4 : in std_logic_vector(3 downto 0));
end selector;

architecture behav of selector is

	signal CLOCK_50 : std_logic;

begin

	clock <= clk when (p1 = "0000" or p2 = "0000" or p3 = "0000" or p4 = "0000")
				else CLOCK_50;


end behav;