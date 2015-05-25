--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:59:32 03/12/2015
-- Design Name:   
-- Module Name:   /home/javier/proyectos/master/master-lrp/practica3/controller_bench.vhd
-- Project Name:  practica3
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
    Port ( in_signal : in STD_LOGIC_VECTOR (11 downto 0);
           ref_signal : in STD_LOGIC_VECTOR (11 downto 0);
           out_signal : out STD_LOGIC_VECTOR (20 downto 0);
			  clk : in std_logic;
			  ce : in std_logic;
			  rst : in std_logic);
    END COMPONENT;
    

   --Inputs
   signal in_signal : std_logic_vector(11 downto 0) := (others => '0');
   signal ref_signal : std_logic_vector(11 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal ce : std_logic := '0';

 	--Outputs
   signal out_signal : std_logic_vector(20 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: controller PORT MAP (
          in_signal => in_signal,
          ref_signal => ref_signal,
          out_signal => out_signal,
          clk => clk,
          rst => rst,
			 ce => ce
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
      -- hold reset state for 100 ns.
      rst <= '1';
      wait for 100 ns;
      wait for clk_period*10;
      rst <= '0';
 
      ref_signal <= (others => '0');
      
      wait for 200 us;

      ref_signal <= (11 => '0', others => '1');
		
      wait for 600 us;
      ref_signal <= (11 => '0', others => '1');
      --ref_signal <= (11 => '1', others => '0');

      wait;
   end process;

END;
