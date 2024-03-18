LIBRARY	ieee;
USE 	ieee.std_logic_1164.ALL;
USE	ieee.numeric_std.ALL;

ENTITY	baudrate_gen_tb	IS
END 	baudrate_gen_tb;

ARCHITECTURE Test OF baudrate_gen_tb IS
	
	CONSTANT C_CLK_PERIOD 		: 		TIME			:= 20 ns;	-- 50 MHz Clock.
  
	SIGNAL clk_tb     		: 		STD_LOGIC		:= '0';
	SIGNAL reset_tb			: 		STD_LOGIC		:= '0';
	SIGNAL tick_tb		    	: 		STD_LOGIC		:= '0';
	
	COMPONENT 	baudrate_gen	IS

		GENERIC
			(		
					M		:	integer		:= 434;
					N		:	integer		:= 9	
			);
		
		PORT
			(
					clk, reset	:	in 		std_logic;
					tick		: 	out 		std_logic
			);
			
	END COMPONENT;

BEGIN
	
	DUT	:	baudrate_gen	PORT MAP (clk_tb, reset_tb, tick_tb);
	
	clk_tb <= NOT clk_tb AFTER C_CLK_PERIOD / 2;
	reset_tb <= '0';
	
END Test;