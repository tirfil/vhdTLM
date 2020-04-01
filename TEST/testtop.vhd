library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.test_pkg.all;

entity testtop is
end testtop;

architecture testenv of testtop is
component  testctrl
	port(
		clk : in std_logic;
		nrst : in std_logic;
		cpurec_a : inout cpurec_t;
		cpurec_b : inout cpurec_t
	);
end component;

component bfmcpu
	port (
		cpurec : inout cpurec_t;
		clk : in std_logic;
		address : out std_logic_vector(2 downto 0);
		wren : out std_logic;
		dout : out std_logic_vector(7 downto 0);
		din  : in std_logic_vector(7 downto 0)
	);
end component;


component  dp8x8
	port (
		address_a		: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		address_b		: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		clock_a			: IN STD_LOGIC  := '1';
		clock_b			: IN STD_LOGIC  := '1';
		data_a			: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data_b			: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		enable_a		: IN STD_LOGIC  := '1';
		enable_b		: IN STD_LOGIC  := '1';
		wren_a			: IN STD_LOGIC  := '0';
		wren_b			: IN STD_LOGIC  := '0';
		q_a				: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		q_b				: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
end component;
signal clk, nrst : std_logic;
signal cpurec_a, cpurec_b : cpurec_t;
signal one : std_logic;

signal address_a, address_b : std_logic_vector(2 downto 0);
signal data_a, data_b : std_logic_vector(7 downto 0);
signal q_a, q_b : std_logic_vector(7 downto 0);
signal wren_a, wren_b : std_logic;

signal running	: std_logic := '1';

begin

 one <= '1';

 i_testctrl : testctrl
	port map (
		clk => clk,
		nrst => nrst,
		cpurec_a => cpurec_a,
		cpurec_b => cpurec_b
	);
	
 i_bfmcpu_a : bfmcpu
	port map (
		cpurec => cpurec_a,
		clk => clk,
		address => address_a,
		wren => wren_a,
		dout => data_a,
		din => q_a
	);

 i_bfmcpu_b : bfmcpu
	port map (
		cpurec => cpurec_b,
		clk => clk,
		address => address_b,
		wren => wren_b,
		dout => data_b,
		din => q_b
	);
	
 i_dut : dp8x8
	port map (
		address_a => address_a,
		address_b => address_b,
		clock_a => clk,
		clock_b	=> clk,	
		data_a	=> data_a,	
		data_b	=> data_b,	
		enable_a => one,
		enable_b => one,
		wren_a	=> wren_a,	
		wren_b	=> wren_b,	
		q_a	=> q_a,
		q_b	=> q_b
	);	

	i_clock: process
	begin
		while (running = '1') loop
			clk <= '1';
			wait for 10 ns;
			clk <= '0';
			wait for 10 ns;
		end loop;
		wait;
	end process i_clock;
	
	i_reset: process
	begin
		nrst <= '0';
		wait for 101 ns;
		nrst <= '1';
		wait for 300 ns;
		running <= '0';
		wait;
	end process i_reset;
		
end testenv;
	
