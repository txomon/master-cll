----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:39:14 03/12/2015 
-- Design Name: 
-- Module Name:    controller - Behavioral 
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
library ieee_proposed;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee_proposed.fixed_float_types.all;
use ieee_proposed.fixed_pkg.all;
use ieee_proposed.float_pkg.all;

entity controller is
    Port ( in_signal : in STD_LOGIC_VECTOR (11 downto 0);
           ref_signal : in STD_LOGIC_VECTOR (11 downto 0);
           out_signal : out STD_LOGIC_VECTOR (17 downto 0);
			  clk : in std_logic;
			  ce : in std_logic;
			  rst : in std_logic);
end controller;

architecture Behavioral of controller is

subtype a1t is sfixed(1 downto -6);
subtype a2t is sfixed(0 downto -8);
subtype au12t is sfixed(10 downto -6);
subtype au1t is sfixed(18 downto -6);
subtype au2t is sfixed(7 downto -6);
subtype b0t is sfixed(6 downto -7);
subtype b1t is sfixed(8 downto -8);
subtype b2t is sfixed(6 downto -8);
subtype be012t is sfixed(9 downto -10);
subtype be01t is sfixed(9 downto -5);
subtype be0t is sfixed(8 downto -5);
subtype be1t is sfixed(10 downto -5);
subtype be2t is sfixed(8 downto -4);
subtype ekt is sfixed(1 downto -10);
subtype ukt is sfixed(8 downto -9);
subtype ykt is sfixed(2 downto -9);

signal a1 : a1t;
signal a2 : a2t;
signal au12 : au12t;
signal au1 : au1t;
signal au2 : au2t;
signal b0 : b0t;
signal b1 : b1t;
signal b2 : b2t;
signal be012 : be012t;
signal be01 : be01t;
signal be0 : be0t;
signal be1 : be1t;
signal be2 : be2t;
signal ek, ek1, ek2 : ekt;
signal uk, uk1, uk2 : ukt;
signal yk, ref : ykt;

begin

a1 <= to_sfixed(-1.689189189189189,a1);
a2 <= to_sfixed(0.689189189189189,a2);
b0 <= to_sfixed( 89.463507459459464,b0);
b1 <= to_sfixed(-177.3636067027027,b1);
b2 <= to_sfixed(87.902615567567537,b2);

yk <= sfixed(in_signal);
ref <= sfixed(ref_signal);
ek <= resize(ref - yk, ek, fixed_saturate, fixed_truncate);
be0 <= resize(b0 * ek, be0, fixed_saturate, fixed_truncate);
be1 <= resize(b1 * ek1, be1, fixed_saturate, fixed_truncate);
be2 <= resize(b2 * ek2, be2, fixed_saturate, fixed_truncate);
au1 <= resize(a1 * uk1, au1, fixed_saturate, fixed_truncate);
au2 <= resize(a2 * uk2, au2, fixed_saturate, fixed_truncate);

be01 <= resize(be0 + be1, be01, fixed_saturate, fixed_truncate);
be012 <= resize(be01 + be2, be012, fixed_saturate, fixed_truncate);
au12 <= resize(au1 + au2, au12, fixed_saturate, fixed_truncate);
uk <= resize(be012 - au12, uk, fixed_saturate, fixed_truncate);

out_signal <= std_logic_vector(uk);

process(clk)
begin
   if rising_edge(clk) then
      if rst = '1' then
         ek1 <= (others => '0');
         ek2 <= (others => '0');
         uk1 <= (others => '0');
         uk2 <= (others => '0');
      else
         ek1 <= ek;
         ek2 <= ek1;
         uk1 <= uk;
         uk2 <= uk1;
      end if;
   end if;
end process;

end Behavioral;

