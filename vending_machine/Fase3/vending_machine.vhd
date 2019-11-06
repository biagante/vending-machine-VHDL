library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity vending_machine is
	port(LEDR : out std_logic_vector(17 downto 0);
	     LEDG : out std_logic_vector(5 downto 0);
		  KEY : in std_logic_vector(2 downto 0);
		  SW   : in std_logic_vector(4 downto 0);
		  HEX6 : out std_logic_vector(6 downto 0);
		  HEX4: out std_logic_vector(6 downto 0);
		  HEX5: out std_logic_vector(6 downto 0);
		  HEX3: out std_logic_vector(6 downto 0);
		  HEX2: out std_logic_vector(6 downto 0);
		  HEX1: out std_logic_vector(6 downto 0); 
		  HEX0: out std_logic_vector(6 downto 0);
		  CLOCK_50: in std_logic);
end vending_machine;

architecture Shell of vending_machine is
	signal s_clk : std_logic; 
	signal s_product : std_logic_vector(7 downto 0);
   signal sel_number : std_logic_vector(3 downto 0);
	signal s_rst : std_logic; --reset global
   signal s_temp: std_logic_vector(7 downto 0);
	signal s_prelease : std_logic;
	signal s_deb0, s_deb1, s_deb2 : std_logic;
	signal s_troco: std_logic_vector(7 downto 0);
	signal dp_d, dp_u : std_logic_vector(3 downto 0);	
	signal p1_s, p2_s, p3_s, p4_s : std_logic_vector(3 downto 0);
	signal p1_d, p2_d, p3_d, p4_d : std_logic_vector(3 downto 0);
	signal s_sel: std_logic_vector(1 downto 0);
	signal intern : std_logic;
	signal clk_1hz : std_logic;

begin
	s_rst <= SW(0);
	s_clk <= CLOCK_50;
	s_sel <= SW(2 downto 1);
	
	clk_enb : entity work.ClkEnablerN(Behavioral)
				 port map (clkIn => s_clk,
							  clkOut => clk_1hz);
	
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
		  port map(rst => s_rst or intern,
					  clk => s_clk,
					  sel => s_sel,
					  product_value => s_product,
					  product_selected => sel_number,
					  selected_ld =>LEDR(4 downto 1));
	
	p_release : entity work.funcionalidade(Behavioral)
					port map(rst => s_rst or intern,
								input0 => s_temp,
								input1 => s_product,
								cmpOut => s_prelease,
								troco => s_troco);
								
	stock: entity work.stock(behav)
			 port map(clk => s_clk,
						 reset => s_rst,
						 unidade => intern,
						 id => s_sel,
						 p1 => p1_s,
						 p2 => p2_s,
						 p3 => p3_s,
						 p4 => p4_s);
						 
						 
	display_p1 : entity work.Bin7SegDecoder(Behavioral)
				 port map(binInput => p1_s,
							 decOut_n => HEX3,
							 enable => '1');
							 
	display_p2 : entity work.Bin7SegDecoder(Behavioral)
				 port map(binInput => p2_s,
							 decOut_n => HEX2,
							 enable => '1');	
							 
   display_p3 : entity work.Bin7SegDecoder(Behavioral)
				 port map(binInput => p3_s,
							 decOut_n => HEX1,
							 enable => '1');
							 
   display_p4 : entity work.Bin7SegDecoder(Behavioral)
				 port map(binInput => p4_s,
							 decOut_n => HEX0,
							 enable => '1');
							 
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
				 port map(enable => '1',
							 binInput => dp_u,
							 decOut_n => HEX4);
							 
	display_td : entity work.Bin7SegDecoder(Behavioral)
				 port map(binInput => dp_d,
							 decOut_n => HEX5,
							 enable => '1');
							 
					  
	display_p : entity work.Bin7SegDecoder(Behavioral)
				 port map(binInput => sel_number,
							 decOut_n => HEX6,
							 enable => '1');
						 
end Shell;
	