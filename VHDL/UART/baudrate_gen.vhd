LIBRARY	ieee;
USE 		ieee.std_logic_1164.ALL;
USE	 	ieee.numeric_std.ALL;

ENTITY	baudrate_gen	IS

	GENERIC
			(
				-- M = clk_freq / baudrate, without oversampling
				
				M				:		integer	:= 434;		-- M = 50 MHz /  115200
				N				:		integer	:= 9		-- Size of M
			);
	
	PORT
		(
				clk, reset	:		in 		std_logic;
				tick			: 		out 		std_logic
		);
		
END baudrate_gen;

ARCHITECTURE	Behavioral	OF		baudrate_gen	IS

	SIGNAL	clk16_reg, clk16_next:	UNSIGNED(N - 1 DOWNTO 0) := (OTHERS => '0');

BEGIN

	PROCESS(clk, reset)
	BEGIN
	
		IF (reset = '1') THEN
			clk16_reg <= (OTHERS => '0');
			
		ELSIF (RISING_EDGE(clk)) THEN
			clk16_reg <= clk16_next;
			
		END IF;
		
	END PROCESS;

	-- Next state logic
	
	clk16_next	<=	(OTHERS => '0')	WHEN clk16_reg = (M - 1)	ELSE clk16_reg + 1;
	
	-- Output logic
	
	tick			<= '1'					WHEN clk16_reg = 0 			ELSE '0';

END Behavioral;