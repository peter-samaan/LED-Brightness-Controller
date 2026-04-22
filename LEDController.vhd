-- LEDController.VHD
-- 2025.03.09
--
-- This SCOMP peripheral drives ten outputs high or low based on
-- a value from SCOMP.

-- 4 bits (7-10) select LED number
-- 7 bits (0-6) select PWM value
-- 2^7 = 128 levels

LIBRARY IEEE;
LIBRARY LPM;

USE LPM.LPM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY LEDController IS
PORT(
	CS      	: IN  STD_LOGIC;
	WRITE_EN	: IN  STD_LOGIC;
	RESETN  	: IN  STD_LOGIC;
	LEDs    	: OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
	IO_DATA 	: IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
 	CLOCK     	: IN  STD_LOGIC;
 	TEST_PINS  	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END LEDController;

ARCHITECTURE a OF LEDController IS
	SIGNAL LED0 : UNSIGNED(6 DOWNTO 0);
	SIGNAL LED1 : UNSIGNED(6 DOWNTO 0);
	SIGNAL LED2 : UNSIGNED(6 DOWNTO 0);
	SIGNAL LED3 : UNSIGNED(6 DOWNTO 0);
	SIGNAL LED4 : UNSIGNED(6 DOWNTO 0);
	SIGNAL LED5 : UNSIGNED(6 DOWNTO 0);
	SIGNAL LED6 : UNSIGNED(6 DOWNTO 0);
	SIGNAL LED7 : UNSIGNED(6 DOWNTO 0);
	SIGNAL LED8 : UNSIGNED(6 DOWNTO 0);
	SIGNAL LED9 : UNSIGNED(6 DOWNTO 0);
	SIGNAL cnt  : UNSIGNED(6 DOWNTO 0);
    
	type gamma_lut_type is array (0 to 127) of UNSIGNED (6 downto 0);

	constant gamma_lut : gamma_lut_type := (
	"0000000","0000000","0000000","0000000","0000000","0000000","0000000","0000000",
	"0000000","0000000","0000000","0000001","0000001","0000001","0000001","0000001",
	"0000001","0000010","0000010","0000010","0000010","0000010","0000011","0000011",
	"0000011","0000100","0000100","0000100","0000101","0000101","0000101","0000110",
	"0000110","0000111","0000111","0000111","0001000","0001000","0001001","0001001",
	"0001010","0001011","0001011","0001100","0001100","0001101","0001110","0001110",
	"0001111","0010000","0010000","0010001","0010010","0010011","0010011","0010100",
	"0010101","0010110","0010111","0011000","0011000","0011001","0011010","0011011",
	"0011100","0011101","0011110","0011111","0100000","0100001","0100010","0100011",
	"0100100","0100110","0100111","0101000","0101001","0101010","0101011","0101101",
	"0101110","0101111","0110001","0110010","0110011","0110100","0110110","0110111",
	"0111001","0111010","0111100","0111101","0111110","1000000","1000010","1000011",
	"1000101","1000110","1001000","1001001","1001011","1001101","1001110","1010000",
	"1010010","1010100","1010101","1010111","1011001","1011011","1011101","1011110",
	"1100000","1100010","1100100","1100110","1101000","1101010","1101100","1101110",
	"1110000","1110010","1110100","1110110","1111000","1111011","1111101", "1111111"
    	);
BEGIN
	PROCESS (RESETN, CS, CLOCK)
	BEGIN
    	IF (RESETN = '0') THEN
            	LED0 <= (gamma_lut(to_integer("0000000")));
            	LED1 <= (gamma_lut(to_integer("0000000")));
            	LED2 <= (gamma_lut(to_integer("0000000")));
            	LED3 <= (gamma_lut(to_integer("0000000")));
            	LED4 <= (gamma_lut(to_integer("0000000")));
            	LED5 <= (gamma_lut(to_integer("0000000")));
            	LED6 <= (gamma_lut(to_integer("0000000")));
            	LED7 <= (gamma_lut(to_integer("0000000")));
            	LED8 <= (gamma_lut(to_integer("0000000")));
            	LED9 <= (gamma_lut(to_integer("0000000")));
            	cnt <= "0000000";
    	ELSE
        	IF CS = '1' and WRITE_EN = '1' THEN
                    	case IO_DATA(10 DOWNTO 7) is
                        	when "0000" =>
                            	LED0 <= gamma_lut(to_integer(unsigned(IO_DATA(6 DOWNTO 0))));
                        	when "0001" =>
                            	LED1 <= gamma_lut(to_integer(unsigned(IO_DATA(6 DOWNTO 0))));
                        	when "0010" =>
                            	LED2 <= gamma_lut(to_integer(unsigned(IO_DATA(6 DOWNTO 0))));
                        	when "0011" =>
                            	LED3 <= gamma_lut(to_integer(unsigned(IO_DATA(6 DOWNTO 0))));
                        	when "0100" =>
                            	LED4 <= gamma_lut(to_integer(unsigned(IO_DATA(6 DOWNTO 0))));
                        	when "0101" =>
                            	LED5 <= gamma_lut(to_integer(unsigned(IO_DATA(6 DOWNTO 0))));
                        	when "0110" =>
                            	LED6 <= gamma_lut(to_integer(unsigned(IO_DATA(6 DOWNTO 0))));
                        	when "0111" =>
                            	LED7 <= gamma_lut(to_integer(unsigned(IO_DATA(6 DOWNTO 0))));
                        	when "1000" =>
                            	LED8 <= gamma_lut(to_integer(unsigned(IO_DATA(6 DOWNTO 0))));
                        	when "1001" =>
                            	LED9 <= gamma_lut(to_integer(unsigned(IO_DATA(6 DOWNTO 0))));
                                                   	 
                        	when others => --do nothing
                    	end case;
            	END IF;

            	IF (RISING_EDGE(CLOCK)) THEN
                        	IF (cnt = x"0") THEN
                            	IF (LED0 /= x"0") THEN
                                	LEDs(0) <= '1';
                            	ELSE
                                	LEDs(0) <= '0';
                            	END IF;
                           	 
                            	IF (LED1 /= x"0") THEN
                                	LEDs(1) <= '1';
                            	ELSE
                                	LEDs(1) <= '0';
                            	END IF;
                           	 
                            	IF (LED2 /= x"0") THEN
                                	LEDs(2) <= '1';
                            	ELSE
                                	LEDs(2) <= '0';
                            	END IF;
                           	 
                            	IF (LED3 /= x"0") THEN
                                	LEDs(3) <= '1';
                            	ELSE
                                	LEDs(3) <= '0';
                            	END IF;
                           	 
                            	IF (LED4 /= x"0") THEN
                                	LEDs(4) <= '1';
                            	ELSE
                                	LEDs(4) <= '0';
                            	END IF;
                           	 
                            	IF (LED5 /= x"0") THEN
                                	LEDs(5) <= '1';
                            	ELSE
                                	LEDs(5) <= '0';
                            	END IF;
                           	 
                            	IF (LED6 /= x"0") THEN
                                	LEDs(6) <= '1';
                            	ELSE
                                	LEDs(6) <= '0';
                            	END IF;
                           	 
                            	IF (LED7 /= x"0") THEN
                                	LEDs(7) <= '1';
                            	ELSE
                                	LEDs(7) <= '0';
                            	END IF;
                           	 
                            	IF (LED8 /= x"0") THEN
                                	LEDs(8) <= '1';
                            	ELSE
                                	LEDs(8) <= '0';
                            	END IF;
                           	 
                            	IF (LED9 /= x"0") THEN
                                	LEDs(9) <= '1';
                            	ELSE
                                	LEDs(9) <= '0';
                            	END IF;
                           	 
                        	ELSIF (cnt /= "1111111") THEN
                            	IF (LED0 = cnt) THEN
                                	LEDs(0) <= '0';
                            	END IF;
                            	IF (LED1 = cnt) THEN
                                	LEDs(1) <= '0';
                            	END IF;
                            	IF (LED2 = cnt) THEN
                                	LEDs(2) <= '0';
                            	END IF;
                            	IF (LED3 = cnt) THEN
                                	LEDs(3) <= '0';
                            	END IF;
                            	IF (LED4 = cnt) THEN
                                	LEDs(4) <= '0';
                            	END IF;
                            	IF (LED5 = cnt) THEN
                                	LEDs(5) <= '0';
                            	END IF;
                            	IF (LED6 = cnt) THEN
                                	LEDs(6) <= '0';
                            	END IF;
                            	IF (LED7 = cnt) THEN
                                	LEDs(7) <= '0';
                            	END IF;
                            	IF (LED8 = cnt) THEN
                                	LEDs(8) <= '0';
                            	END IF;
                            	IF (LED9 = cnt) THEN
                                	LEDs(9) <= '0';
                            	END IF;
                        	END IF;
                        	cnt <= cnt + "0000001";
        	END IF;
    	END IF;
	END PROCESS;
 	TEST_PINS(0) <= LED1(0);
 	TEST_PINS(1) <= LED1(1);
 	TEST_PINS(2) <= LED1(2);
 	TEST_PINS(3) <= LED1(3);
-- 	TEST_PINS(0) <= IO_DATA(8);
-- 	TEST_PINS(1) <= IO_DATA(7);
-- 	TEST_PINS(2) <= IO_DATA(1);
-- 	TEST_PINS(3) <= IO_DATA(0);

END a;
