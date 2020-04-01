# vhdTLM
Transaction Level Model (TLM) example for VHDL testing

This example is a simple testbench. The device under test is a model of a dual port RAM 8x8 bit

The methodology is based on a Jim Lewis (jim@SynthWorks.com) paper : 
"Accelerating Verification Throught Pre-Use of System-Level, Transaction-Based Restbench Components" DesignCon 2003

Transactional procedures CpuWrite() and CpuRead() enables to drive RAM address/data bus and RAM command signals using Bus Fonctional Model (BFM) components.

Transactional procedures , record structures, synchronization mechanisms are defined in a VHDL package (TEST/test_pkg.vhd)

A top level test environment (TEST/testtop.vhd) includes:
- DUT device under test (VHDL/dp8x8.vhd)
- Clock and reset processes
- BFM component to drive RAM port (TEST/bfmcpu.vhd)
- Test controller (TEST/testctrl.vhd)

The test controller architecture constains the testbench as a sequence of transactions.

The link between transactions and a BFM component is a bidirectionnal record type signal. 
As record type signal is bidirectionnal, the better is to use a resolved type (as std_logic) as record item.
The record type signals must be initialized at the beginning of the simulation on BFM and test controller side.


A Ready/Acknowledge mechanism is needed to synchronise the BFM and transactions. 
Ready warns the BFM of a pending transaction, Ack(nowledge) closes the current transaction.
This mechanism is implemented by two procedures:
- WaitForRequest() on BFM side
- RequestAction() on transaction side

Adding new test scenarios using this environment requests only the creation of new architectures for the test controller module.






