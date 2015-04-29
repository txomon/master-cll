library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity divisor is
    Port ( clock_in 	: in  STD_LOGIC;
			  modulo 	: in  STD_LOGIC_VECTOR(2 downto 0);
           clock_out : out STD_LOGIC);
end divisor;


architecture codigo of divisor is

	signal  count		 : STD_LOGIC_VECTOR (23 downto 0) := "000000000000000000000000";
	signal  clock_int	 : STD_LOGIC;
	
begin
	
	process (clock_in) 
	begin
		if clock_in='1' and clock_in'event then
			count <= count + 1;
		end if;
	end process;

	process (modulo,count)
	begin
      	case modulo(2 downto 0) is
		      when "000" => 
			      clock_int <= count(23); --7
		      when "001" => 
			      clock_int <= count(22); --6
		      when "010" => 
			      clock_int <= count(21); --5
		      when "011" => 
			      clock_int <= count(20); --4
		      when "100" => 
			      clock_int <= count(3);
		      when "101" => 
			      clock_int <= count(2);
		      when "110" => 
			      clock_int <= count(1);
		      when others => 
			      clock_int <= count(0);
	      end case;
	end process;
	
	clock_out <= clock_int;

end codigo;

