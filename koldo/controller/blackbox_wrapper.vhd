----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:27:43 05/25/2015 
-- Design Name: 
-- Module Name:    blackbox_wrapper - Behavioral 
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

entity blackbox_wrapper is
	PORT(
		clk : IN std_logic;
		ce : IN std_logic;
		rst : IN std_logic;
		setpoint : IN std_logic_vector(11 downto 0);
		y : IN std_logic_vector(11 downto 0);          
		u : OUT std_logic_vector(15 downto 0)
	);
end blackbox_wrapper;


architecture Behavioral of blackbox_wrapper is

	COMPONENT controller
	PORT(
		clk : IN std_logic;
		regist : IN std_logic;
		rst : IN std_logic;
		setpoint : IN std_logic_vector(11 downto 0);
		y : IN std_logic_vector(11 downto 0);          
		u : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	

	COMPONENT dcm
	PORT(
		CLKIN_IN : IN std_logic;
		RST_IN : IN std_logic;          
		CLKDV_OUT : OUT std_logic;
		CLK0_OUT : OUT std_logic
		);
	END COMPONENT;
	
	signal dcm_clk : std_logic;
	signal down_ce : std_logic;
	signal counter : natural;
begin

	Inst_controller: controller PORT MAP(
		clk => dcm_clk,
		regist => down_ce,
		rst => rst,
		setpoint => setpoint,
		y => y,
		u => u
	);

	Inst_dcm: dcm PORT MAP(
		CLKIN_IN => clk,
		RST_IN => rst,
		CLK0_OUT => open,
		CLKDV_OUT => dcm_clk
	);

	process (dcm_clk)
	begin
		if rising_edge(dcm_clk) then
			if rst = '1' then
				counter <= 0;
				down_ce <= '0';
			else
				if counter = 6250 then
					counter <= 0;
					down_ce <= '1';
				else
					counter <= counter + 1;
					down_ce <= '0';
				end if;
			end if;
		end if;
	end process;

end Behavioral;

