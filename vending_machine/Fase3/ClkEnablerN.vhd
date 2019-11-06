library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity ClkEnablerN is
   generic(factor : positive := 50000000);
   port(clkIn  : in  std_logic;
        clkOut : out std_logic);
end ClkEnablerN;

architecture Behavioral of ClkEnablerN is

   subtype Tgenerator is natural range 0 to (factor - 1);
   signal s_generator : Tgenerator;

begin
   assert(factor >= 2);

   generator_proc : process(clkIn)
   begin
      if (rising_edge(clkIn)) then
         if (s_generator >= factor - 1) then
            s_generator <= 0;
         else
            s_generator <= s_generator + 1;
         end if;
      end if;
   end process;

   out_proc : process(clkIn)
   begin
      if (rising_edge(clkIn)) then
         if (s_generator >= (factor / 2 - 1)) then
            clkOut <= '1';
         else
            clkOut <= '0';
         end if;
      end if;
   end process;
end Behavioral;
