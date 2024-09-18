LIBRARY 	ieee;
USE 		ieee.std_logic_1164.ALL;
USE 		ieee.std_logic_unsigned.ALL;

ENTITY clock_divider IS

	GENERIC (

		CLOCK_FREQUENCY		:	POSITIVE	:= 50000000;
		FRAMES_PER_SECOND	:	POSITIVE	:=	60
		
	);

	PORT (

		clk, rst		:	IN  	STD_LOGIC;
		clk_out			: 	OUT 	STD_LOGIC 
		
	);
	
END clock_divider;

ARCHITECTURE behavior OF clock_divider IS

	SIGNAL count 			: 	POSITIVE;
	SIGNAL tmp   			: 	STD_LOGIC 	:= '0';
	
	SIGNAL TOP_COUNT		:	POSITIVE;
	
BEGIN

	TOP_COUNT <= CLOCK_FREQUENCY / FRAMES_PER_SECOND;

	PROCESS( clk, rst )
	BEGIN
	
		IF rst = '0' THEN 
		
			count <= 1; 
			tmp   <= '0';
			
		ELSIF RISING_EDGE( clk ) THEN
		
			count <= count + 1;
			
			 -- (50MHz / 60Hz) = ~833,333.33 (rounded down to 833,333 for integer division)
			
			IF( count = TOP_COUNT ) THEN
			
				tmp   <= NOT tmp;
				count <= 1;
				
			END IF;
			
		END IF;
		
		clk_out <= tmp;
		
	END PROCESS;
	
END behavior;
