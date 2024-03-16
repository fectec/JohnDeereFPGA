LIBRARY	ieee;
USE 		ieee.std_logic_1164.ALL;
USE	 	ieee.numeric_std.ALL;

ENTITY	UART_TX_Interface 	IS
	
	GENERIC
		(
			DATA_WIDTH			:		INTEGER	:=	8
		);
		
	PORT
		(
			clk, tx_start, reset_baudrate_gen, reset_UART_TX_Equipo7		:		IN		STD_LOGIC;
			d_in									:		IN		STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
			tx, tx_done_tick							: 		OUT		STD_LOGIC
		);
		
END	UART_TX_Interface;

ARCHITECTURE Behavioral OF	UART_TX_Interface	IS

	COMPONENT	baudrate_gen	IS

		GENERIC
			(		
					M			:		integer	:= 434;		
					N			:		integer	:= 9		
			);
		
		PORT
			(
					clk, reset		:		in 		std_logic;
					tick			: 		out 		std_logic
			);
			
	END COMPONENT;

	COMPONENT UART_TX_Equipo7 IS
		
		GENERIC
			(
				DATA_WIDTH			:		INTEGER	:=	8;
				COUNTER_WIDTH			:		INTEGER	:= 3	-- log 2 (8) = 3
			);

		PORT
			(
				clk, reset, s_tick, tx_start	:		IN		STD_LOGIC;
				d_in				:		IN		STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
				tx, tx_done_tick		:		OUT		STD_LOGIC
				
			);

	END COMPONENT;
	
	SIGNAL	baudrate_gen_tick				:		STD_LOGIC;
	
BEGIN
		
	BRG	:		baudrate_gen
	
					PORT MAP
					(
						clk => clk,
						reset => reset_baudrate_gen,
						tick => baudrate_gen_tick
					);
					
	UT		:		UART_TX_Equipo7
	
					PORT MAP
					(
						clk => clk,
						reset => reset_UART_TX_Equipo7,
						s_tick => baudrate_gen_tick,
						tx_start => tx_start,
						d_in => d_in,
						tx => tx,
						tx_done_tick => tx_done_tick
					);

END Behavioral;