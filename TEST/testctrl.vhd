library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.test_pkg.all;

entity testctrl is 
	port(
		clk : in std_logic;
		nrst : in std_logic;
		cpurec_a : inout cpurec_t := initcpurec;
		cpurec_b : inout cpurec_t := initcpurec
	);
end testctrl;

architecture test1 of testctrl is
--signal result : std_logic_vector(7 downto 0);
signal result : integer;
begin

	ptest1 : process
	begin
		wait until nrst = '1';
		
		--CpuWrite(cpurec_a, "000", x"aa" );  -- port a
		--CpuWrite(cpurec_b, "001", x"55" );  -- port b
		--CpuRead(cpurec_a, "001", result); -- port a
		--report integer'image(to_integer(unsigned(result)));
		--CpuRead(cpurec_b, "000", result); -- port b
		--report integer'image(to_integer(unsigned(result)));
		
		CpuWrite(cpurec_a, 0, 16#aa# );  -- port a
		CpuWrite(cpurec_b, 1, 16#55# );  -- port b
		CpuRead(cpurec_a, 1, result); -- port a
		report integer'image(result);
		CpuRead(cpurec_b, 0, result); -- port b
		report integer'image(result);
		wait;
	end process;

end test1;
	
