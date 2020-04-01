library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package test_pkg is
	type operation_t is (OP_WRITE, OP_READ);
	
	type cpurec_t is record
		ack : std_logic;
		ready : std_logic;
		operation : operation_t;
		data : std_logic_vector(7 downto 0);
		address : std_logic_vector(2 downto 0);
	end record;
	
	constant initcpurec : cpurec_t;
	
	procedure RequestAction(
		signal ready : out std_logic;
		signal ack	  : in std_logic
	);
	
	--procedure CpuWrite(
		--signal cpurec : inout cpurec_t;
		--address : in std_logic_vector(2 downto 0);
		--data   : in std_logic_vector(7 downto 0)
	--);
	
	--procedure CpuRead(
		--signal cpurec : inout cpurec_t;
		--address : in std_logic_vector(2 downto 0);
		--signal data   : out std_logic_vector(7 downto 0)		
	--);
	
	procedure CpuWrite(
		signal cpurec : inout cpurec_t;
		address : in integer;
		data   : in integer
	);
	
	procedure CpuRead(
		signal cpurec : inout cpurec_t;
		address : in integer;
		signal data   : out integer		
	);
	
	procedure WaitForRequest(
		signal clk : in std_logic;
		signal ready : in std_logic;
		signal ack	: out std_logic
	);
	
end test_pkg;

package body test_pkg is

	procedure RequestAction(
		signal ready : out std_logic;
		signal ack	  : in std_logic
	) is 
	begin
		ready <= '1';
		if (ack /= '0') then
			wait until ack='0';
		end if;
		ready <= '0';
		wait until ack='1';
	end procedure;
	
	--procedure CpuWrite(
		--signal cpurec : inout cpurec_t;
		--address : in std_logic_vector(2 downto 0);
		--data   : in std_logic_vector(7 downto 0)
	--) is
	--begin
		--cpurec.operation <= OP_WRITE;
		--cpurec.address <= address;
		--cpurec.data <= data;
		--RequestAction(cpurec.ready,cpurec.ack);
		--cpurec.data <= (others=>'Z');
	--end procedure;
	
	procedure CpuWrite(
		signal cpurec : inout cpurec_t;
		address : in integer;
		data   : in integer
	) is
	begin
		cpurec.operation <= OP_WRITE;
		cpurec.address <= std_logic_vector(to_unsigned(address,3));
		cpurec.data <= std_logic_vector(to_unsigned(data,8));
		RequestAction(cpurec.ready,cpurec.ack);
		cpurec.data <= (others=>'Z');
	end procedure;	
	
	--procedure CpuRead(
		--signal cpurec : inout cpurec_t;
		--address : in std_logic_vector(2 downto 0);
		--signal data   : out std_logic_vector(7 downto 0)		
	--) is
	--begin
		--cpurec.operation <= OP_READ;
		--cpurec.address <= address;
		--cpurec.data <= (others=>'Z');
		--RequestAction(cpurec.ready,cpurec.ack);
		--data <= cpurec.data;
		--wait for 0 ns; -- delta time for data value assignement
	--end procedure;	
	
	procedure CpuRead(
		signal cpurec : inout cpurec_t;
		address : in integer;
		signal data   : out integer		
	) is
	begin
		cpurec.operation <= OP_READ;
		cpurec.address <= std_logic_vector(to_unsigned(address,3));
		cpurec.data <= (others=>'Z');
		RequestAction(cpurec.ready,cpurec.ack);
		data <= to_integer(unsigned(cpurec.data));
		wait for 0 ns; -- delta time for data value assignement
	end procedure;
	
	procedure WaitForRequest(
		signal clk : in std_logic;
		signal ready : in std_logic;
		signal ack	: out std_logic
	) is
	begin
		ack <= '1';
		wait for 0 ns;
		wait for 0 ns;
		if (ready /= '1') then
			wait until ready = '1';
			wait until clk = '1';
		end if;
		ack <= '0';
	end procedure;
	
	constant initcpurec : cpurec_t := (
		ack => 'Z',
		ready => '0',
		operation => OP_READ,
		data => (others=>'Z'),
		address => (others=>'Z')
	);
		
end test_pkg;

