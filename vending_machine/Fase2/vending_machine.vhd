library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity vending_machine is
	port(LEDR : out std_logic_vector(14 downto 0);
	     LEDG : out std_logic_vector(7 downto 0);
		  KEY : in std_logic_vector(2 downto 0);
		  SW   : in std_logic_vector(2 downto 0);
		  HEX6 : out std_logic_vector(6 downto 0);
		  HEX4: out std_logic_vector(6 downto 0);
		  HEX5: out std_logic_vector(6 downto 0);
		  CLOCK_50: in std_logic);
end vending_machine;

architecture Shell of vending_machine is
	signal s_clk : std_logic; 
	signal s_product : std_logic_vector(7 downto 0);
   signal sel_number : std_logic_vector(3 downto 0);
	signal s_rst : std_logic; --reset global
   signal s_temp: std_logic_vector(7 downto 0);
	signal s_deb0, s_deb1, s_deb2 : std_logic;
	signal s_prelease: std_logic;
	signal s_troco: std_logic_vector(7 downto 0);
	signal dp_d, dp_u : std_logic_vector(3 downto 0);
	signal intern : std_logic;

begin
	s_rst <= SW(0);
	s_clk <= CLOCK_50;
	LEDR(0) <= s_rst;
	
	deb0: entity work.debouncer(Behavioral)
			port map(refClk => s_clk,
						dirtyIn => KEY(0),
						pulsedOut => s_deb0);

	deb1: entity work.debouncer(Behavioral)
			port map(refClk => s_clk,
						dirtyIn => KEY(1),
						pulsedOut => s_deb1);

	deb2: entity work.debouncer(Behavioral)
			port map(refClk => s_clk,
						dirtyIn => KEY(2),
						pulsedOut => s_deb2);
						
	moedas: entity work.moedas(fsm)
			  port map(rst => s_rst or intern,
						  clk => s_clk,
						  u_in => s_deb2,
						  c_in => s_deb1,
						  v_in => s_deb0,
						  temp => s_temp);
							 
	fsm: entity work.vending_machineFSM(fsm)
		  port map(rst => s_rst  or intern,
					  clk => s_clk,
					  sel => SW(2 downto 1),
					  product_value => s_product,
					  product_selected => sel_number,
					  selected_ld =>LEDR(4 downto 1));
	
	p_release : entity work.funcionalidade(Behavioral)
					port map(rst => s_rst or intern,
								input0 => s_temp,
								input1 => s_product,
								cmpOut => s_prelease,
								troco => s_troco);
	
	led2s : entity work.temporizador(RTL)
			  port map(clk => s_clk,
						  reset => s_rst,
						  product_out => s_prelease,
						  out_p => LEDG(0),
						  unidade => intern);
								
	display_troc: entity work.Bin2BCD(behav)
					  port map(i => s_troco,
								  d => dp_d,
								  u => dp_u);
								  
	display_tu : entity work.Bin7SegDecoder(Behavioral)
				 port map(binInput => dp_u,
							 decOut_n => HEX4);
							 
	display_td : entity work.Bin7SegDecoder(Behavioral)
				 port map(binInput => dp_d,
							 decOut_n => HEX5);
							 
					  
	display_p : entity work.Bin7SegDecoder(Behavioral)
				 port map(binInput => sel_number,
							 decOut_n => HEX6);

						
end Shell;
	