----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:37:23 04/29/2015 
-- Design Name: 
-- Module Name:    master - Behavioral 
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity master is
    Port ( clk : in  STD_LOGIC;
           ce : in  STD_LOGIC;
           modulo : in  STD_LOGIC_VECTOR (2 downto 0);
           dir : in  STD_LOGIC;
           cuenta_fin : out  STD_LOGIC;
           cuenta : out  STD_LOGIC_VECTOR (3 downto 0));
end master;

architecture Behavioral of master is

	COMPONENT contador_sinc
	PORT(
		clock : IN std_logic;
		direccion : IN std_logic;          
		cuenta_fin : OUT std_logic;
		cuenta : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	COMPONENT divisor
	PORT(
		clk: IN std_logic;
		modulo : IN std_logic_vector(2 downto 0);          
		ce : IN std_logic;
		clock_out : OUT std_logic
		);
	END COMPONENT;
	signal int_clk : std_logic;
begin

	Inst_contador_sinc: contador_sinc PORT MAP(
		clock => int_clk,
		direccion => dir,
		cuenta_fin => cuenta_fin,
		cuenta => cuenta
	);

	Inst_divisor: divisor PORT MAP(
		clk => clk,
		modulo => modulo,
		ce => ce,
		clock_out => int_clk
	);



end Behavioral;

