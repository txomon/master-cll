--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:42:37 05/25/2015
-- Design Name:   
-- Module Name:   C:/javier/master-cll/koldo/controller/controller_bench.vhd
-- Project Name:  controller
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: controller
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY controller_bench IS
END controller_bench;
 
ARCHITECTURE behavior OF controller_bench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT controller
    PORT(
         clk : IN  std_logic;
         ce : IN  std_logic;
         rst : IN  std_logic;
         y : IN  std_logic_vector(11 downto 0);
         setpoint : IN  std_logic_vector(11 downto 0);
         u : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal ce : std_logic := '0';
   signal rst : std_logic := '0';
   signal y : std_logic_vector(11 downto 0) := (others => '0');
   signal setpoint : std_logic_vector(11 downto 0) := (others => '0');

 	--Outputs
   signal u : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: controller PORT MAP (
          clk => clk,
          ce => ce,
          rst => rst,
          y => y,
          setpoint => setpoint,
          u => u
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
      rst <= '1';
      wait for 100 ns;
      wait for clk_period*10;
      rst <= '0';
 
      setpoint <= (others => '0');
      
      wait for 200 us;

      setpoint <= (11 => '0', others => '1');
		
      wait for 600 us;
      setpoint <= (11 => '1', others => '0');

      wait;
   end process;

END;
