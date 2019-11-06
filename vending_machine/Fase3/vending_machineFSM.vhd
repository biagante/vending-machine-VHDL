library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity vending_machineFSM is
	port (clk, rst : in  STD_LOGIC;
			sel : in std_logic_vector(1 downto 0);
         product_value : out STD_LOGIC_vector(7 downto 0);
			product_selected : out std_logic_vector(3 downto 0);
			selected_ld : out std_logic_vector(3 downto 0));
end vending_machineFSM;

architecture fsm of vending_machineFSM is

        signal s_product_value : integer;
begin

		  with sel select
						product_selected <= "0001" when "00",
												  "0010" when "01",
												  "0011" when "10",
												  "0100" when "11",
												  "1111" when others;
												  
		  with sel select
						selected_ld <= "0001" when "00",
											"0010" when "01",
											"0100" when "10",
											"1000" when "11",
											"1111" when others;
		  process(rst, clk)
        begin
                if(rst='1') then
                        s_product_value <= 0;
                elsif(rising_edge(clk)) then
					 
							if (sel = "00") then s_product_value <= 30;
							elsif (sel = "01") then s_product_value <= 60;
							elsif (sel = "10") then s_product_value <= 90;
							elsif (sel = "11") then s_product_value <= 110;
							end if;
											
					 end if;
        end process;
		  
		  product_value <= std_logic_vector(to_unsigned(s_product_value, product_value'length));		  
		 
       
		 										
		
END fsm;