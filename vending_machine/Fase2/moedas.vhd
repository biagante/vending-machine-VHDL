library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity moedas is
	port (clk, rst : in  STD_LOGIC;
         u_in, c_in, v_in : in  std_logic;
			temp : out std_logic_vector(7 downto 0));
end moedas;

architecture fsm of moedas is

	type state is (E0, E20, E50, E100);
	signal present_state, next_state : STATE := E0;
	signal valor: integer := 0;
	
begin
		
	process(clk,present_state, rst, u_in, c_in, v_in)
	begin
	if(rising_edge(clk)) then
	
	present_state <= next_state;
	
		if(rst ='1') then 
					next_state <= E0; 
			valor <= 0;
		else
	
				case present_state is			
					
					when E0 =>
						if (u_in = '1' ) then next_state <= E100;
						elsif (c_in = '1') then next_state <= E50;
						elsif (v_in = '1') then next_state <= E20;
						else next_state <= E0;
						end if;
						
						valor <= valor ;
						
					when E20 =>
						valor <= valor + 20;
						next_state <= E0;
	
					
					when E50 =>
						valor <= valor + 50;
						 next_state <= E0;
						
						
					when E100 =>
						valor <= valor + 100;
						 next_state <= E0;
						
						
					when others => 
					next_state <= E0;
					valor <= valor;
					
				end case;
			end if;
		end if;
	end process;

	temp <= std_logic_vector(to_unsigned(valor,8));
				
end fsm;
	
		