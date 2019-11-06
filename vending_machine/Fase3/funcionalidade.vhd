library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity funcionalidade is
	port(rst  : in std_logic;
		  input0 : in std_logic_vector(7 downto 0);
		  input1 : in std_logic_vector(7 downto 0);
		  cmpOut : out std_logic;
		  troco : out std_logic_vector(7 downto 0));
end funcionalidade;

architecture Behavioral of funcionalidade is

begin
	
	process(rst)
	begin
	
		if (rst = '1') then
			cmpOut <= '0';
			
		elsif (input0 >= input1) then
			cmpOut <= '1';
			
		else 
			cmpOut <= '0';
		end if;
	end process;
	
	
	troco <= std_logic_vector(unsigned(input0(7 downto 0)) - unsigned(input1(7 downto 0))) when (input0 > input1) else
				"00000000";

				 
end Behavioral;