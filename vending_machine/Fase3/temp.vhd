library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
 
entity temporizador is

	 Port 	( 
					clk	         : in  std_logic;
					reset          : in std_logic;
					product_out	   : in  std_logic;
					out_p			   : out	std_logic:='0';
					unidade				: out std_logic
				);
end temporizador;
 
architecture RTL of temporizador is

	signal max_time		: integer	:=	2;

 begin
    process(clk)
    begin
			if (reset='1') then
			max_time		<=	0;
			out_p		<= '0';
			else
				if (rising_edge(clk)) then -- Intervalo de tempo com base em 50MHz
					if(product_out = '1') then
						if (max_time<50000000) then
							out_p <= '1';
							max_time <= max_time + 1;
							unidade <= '0';
						else
							out_p <= '0';
							end if;
					else
						out_p <=	'0';
						
					end if;
					
					if(max_time=50000000 and product_out='1') then
						unidade <= '1';
						max_time<= 0;
					else
						unidade <= '0';
					end if;
					
				end if;
			end if;
    end process; 
	 
	 
	 
 end RTL;

