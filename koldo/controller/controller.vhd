----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:06:03 06/02/2014 
-- Design Name: 
-- Module Name:    controlador_classic - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controller is
    Port ( clk : in  STD_LOGIC;
		     regist : in STD_LOGIC; 
           rst : in  STD_LOGIC;
           setpoint : in  STD_LOGIC_VECTOR (11 downto 0);
           y : in  STD_LOGIC_VECTOR (11 downto 0);
           u : out  STD_LOGIC_VECTOR (15 downto 0));
end controller;

architecture paraleloa of controller is

signal a1, a2 : signed(9 downto 0);
signal b0, b1, b2 : signed(16 downto 0);
signal setpointf : signed(11 downto 0);
signal setpointf_r : signed(12 downto 0);
signal ykf : signed(11 downto 0);
signal ykf_r : signed(12 downto 0);
signal ek : signed(12 downto 0);
signal ek1reg, ek2reg : signed(12 downto 0) := (others => '0');
signal uk1reg, uk2reg : signed(15 downto 0) := (others => '0');
signal be0, be1, be2, au1, au2 : signed(17 downto 0);
signal be2_r : signed(18 downto 0);
signal be01 : signed(18 downto 0);
signal be012, uf_long : signed(19 downto 0);
signal au12 : signed (17 downto 0);
signal au12_r : signed (19 downto 0);
signal uf : signed (15 downto 0);
signal ufreg : signed (15 downto 0) := (others => '0');

begin
--Valor de los parametros del controlador
a1 <= "1001010101";
a2 <= "0010101011";
b0 <= "00101100001010110";
b1 <= "10101000100000000";
b2 <= "00101011010101010";

--Registramos las entradas y la salida
process (clk, rst)
begin
   if rst = '1' then
		setpointf <= (others => '0');
		ykf <= (others => '0');
		ufreg <= (others => '0');
		ek1reg <= (others => '0');
		ek2reg <= (others => '0');
		uk1reg <= (others => '0');
		uk2reg <= (others => '0');
	elsif (rising_edge(clk)) then
		setpointf <= signed(setpoint);
		ykf <= signed(y);
		if regist ='1' then           --registraremos solo en los instantes de muestreo
			ek1reg <= ek;
			ek2reg <= ek1reg;
			uk1reg <= uf;
			uk2reg <= uk1reg;
		elsif regist = '0' then
			ufreg <= uf;
		end if;
	end if;
end process;

--Lógica aritmética
--======================================================================
--Cálculo del error
--(Resize mete tantos bits de signo como sea necesario a la izquierda para extender el vector)
--Primero alineamos la coma
ykf_r <= resize(ykf, ykf_r'length); --Puede ser negativo y hau que meter unos en lugar de ceros
setpointf_r <= resize(setpointf, setpointf_r'length);
ek <= setpointf_r - ykf_r;
--ek <= resize((setpointf&'0') - ykf_r, ek'length);
--ek <= (setpointf&'0') - ykf_r;

--Multiplicaciones (truncamos a 18 bits)
be0 <= resize(shift_right(b0*ek,9), be0'length);
be1 <= resize(shift_right(b1*ek1reg,9), be1'length);
be2 <= resize(shift_right(b2*ek2reg,9), be2'length);
au1 <= resize(shift_right(a1*uk1reg,7), au1'length);
au2 <= resize(shift_right(a2*uk2reg,7), au2'length);
--El multiplicador trunca por la derecha (se queda com los bits de la izda)
--Al contrario que resize, que se queda con el bit de signo pero trunca por la izquierda
--be0 <= shift_left(b0*ek,3);
--be1 <= shift_left(b1*ek1reg,3);
--be2 <= shift_left(b2*ek2reg,3);
--au1 <= shift_left(a1*uk1reg,1);
--au2 <= shift_left(a2*uk2reg,1);

--Sumar/restar. Los bits de guarda se añaden automáticamente
be01 <= resize(be0+be1, be01'length);
be2_r <= resize(be2,be2_r'length);
be012 <= resize(be01+be2_r, be012'length);
au12 <= resize(au1+au2,au12'length);

--Señal de control
au12_r <= resize(au12, au12_r'length);
--truncar 3 por izquierda y uno por derecha
uf_long <= be012-au12_r;
uf <= uf_long(16 downto 1);
--Casting salida
u <= std_logic_vector(ufreg);
end paraleloa;

