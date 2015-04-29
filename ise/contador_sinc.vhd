----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:42:27 09/23/2008 
-- Design Name: 
-- Module Name:    contador_asin - codigo 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library 	IEEE;
use 		IEEE.STD_LOGIC_1164.ALL;
use 		IEEE.STD_LOGIC_ARITH.ALL;
use 		IEEE.STD_LOGIC_UNSIGNED.ALL;


entity contador_sinc is
    Port ( clock       : in  STD_LOGIC;
			  direccion   : in  STD_LOGIC;
			  cuenta_fin  : out STD_LOGIC;
			  cuenta      : out STD_LOGIC_VECTOR (3 downto 0));
end contador_sinc;

architecture codigo of contador_sinc is

	signal cuenta_int   : std_logic_vector(3 downto 0) := "0000";
	signal clock_out    : std_logic;


begin

	process (clock) 
	begin
		if rising_edge(clock) then
			if direccion='1' then   
				cuenta_int <= cuenta_int + 1;
			else
				cuenta_int <= cuenta_int - 1;
			end if;
		end if;
	end process;

	cuenta		<= cuenta_int;
	cuenta_fin 	<= clock;
	
end codigo;
