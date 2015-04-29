--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:39:27 04/22/2015
-- Design Name:   
-- Module Name:   C:/javier/part3/tb1.vhd
-- Project Name:  part3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: contador_sinc
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
 
ENTITY tb1 IS
END tb1;
 
ARCHITECTURE behavior OF tb1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT contador_sinc
    PORT(
         clock : IN  std_logic;
         direccion : IN  std_logic;
         modulo : IN  std_logic_vector(2 downto 0);
         cuenta_fin : OUT  std_logic;
         cuenta : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal direccion : std_logic := '0';
   signal modulo : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal cuenta_fin : std_logic;
   signal cuenta : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: contador_sinc PORT MAP (
          clock => clock,
          direccion => direccion,
          modulo => modulo,
          cuenta_fin => cuenta_fin,
          cuenta => cuenta
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		modulo <= "000";
		
      wait for clock_period*100000;
		modulo <= "001";
		
      wait for clock_period*100000;
		modulo <= "010";
		
      wait for clock_period*100000;
		modulo <= "011";
		
      wait for clock_period*100000;
		modulo <= "100";
		
      wait for clock_period*100000;
		modulo <= "101";
		
      wait for clock_period*100000;
		modulo <= "110";
		
      wait for clock_period*100000;
		modulo <= "111";

      wait;
   end process;

END;
