library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.test_pkg.all;

entity bfmcpu is
	port (
		cpurec : inout cpurec_t := initcpurec;
		
		clk : in std_logic;
		address : out std_logic_vector(2 downto 0);
		wren : out std_logic;
		dout : out std_logic_vector(7 downto 0);
		din  : in std_logic_vector(7 downto 0)
	);
end bfmcpu;

architecture bfm of bfmcpu is

begin
	model : process
	begin
		wren <= '0';
		dout <= (others=>'1');
		address <= (others=>'1');
		WaitForRequest(clk, cpurec.ready, cpurec.ack);
		address <= cpurec.address;
		if ( cpurec.operation = OP_WRITE ) then
			dout <= cpurec.data;
			wren <= '1';
			wait until clk = '1'; -- set address & data
		else
			wren <= '0';
			wait until clk = '1'; -- set address
			wait until clk = '1'; -- sample data
			cpurec.data <= din;
		end if;
	end process;
	
end bfm;
		
