library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity Comparador is
	port(reset : in std_logic;
		  input0 : in std_logic_vector(7 downto 0);
		  input1 : in std_logic_vector(7 downto 0);
		  cmpOut : out std_logic);
end Comparador;

architecture Behavioral of Comparador is
begin

	process(reset)
	begin
	
		if (reset = '1') then
			cmpOut <= '0';
			
		elsif (input0 >= input1) then
			cmpOut <= '1';
			
		else
			cmpOut <= '0';
		
		end if;
	end process;
	
end Behavioral;