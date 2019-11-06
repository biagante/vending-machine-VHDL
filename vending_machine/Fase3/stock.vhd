library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity stock is
	port(clk : in std_logic;
		  reset : in std_logic;
		  id : in std_logic_vector(1 downto 0);
		  unidade: in std_logic;
		  p1, p2, p3, p4 : out std_logic_vector(3 downto 0));
end stock;

architecture behav of stock is

	signal p1_s : integer := 6;
	signal p2_s : integer := 4;
	signal p3_s : integer := 5;
	signal p4_s : integer := 7;
	
begin

	process(clk, reset)
	begin 
		if (rising_edge(clk)) then
			if(reset = '1') then
					p1_s <= 6;
					p2_s <= 4;
					p3_s <= 5;
					p4_s <= 7;
		
			elsif (unidade ='1') then
				if(id = "00") then
					p1_s <= (p1_s - 1) ;	
				elsif (id = "01") then
					p2_s <= (p2_s - 1);
				elsif (id = "10") then
					p3_s <= (p3_s - 1);	
				elsif (id = "11") then
					p4_s <= (p4_s - 1);	
				end if;	
			end if;
		end if;		 
	end process;
	
	p1 <= std_logic_vector(to_unsigned(p1_s, 4));
	p2 <= std_logic_vector(to_unsigned(p2_s, 4));
	p3 <= std_logic_vector(to_unsigned(p3_s, 4));
	p4 <= std_logic_vector(to_unsigned(p4_s, 4));
	
	

end behav;