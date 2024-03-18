LIBRARY	ieee;
USE 	ieee.std_logic_1164.ALL;
USE	ieee.numeric_std.ALL;

ENTITY UART_TX_Equipo7 IS
	
	GENERIC
		(
			DATA_WIDTH				:		INTEGER	:=	8;
			COUNTER_WIDTH				:		INTEGER	:= 	3	-- log 2 (8) = 3.
		);

	PORT
		(
			clk, reset, s_tick, tx_start		:		IN		STD_LOGIC;
			d_in					:		IN		STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
			tx, tx_done_tick			:		OUT		STD_LOGIC
		);

END UART_TX_Equipo7;
	
ARCHITECTURE Behavioral OF UART_TX_Equipo7 IS

	SIGNAL d_in_tmp				:		STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0)	:=	(OTHERS => '0');
	
BEGIN

	PROCESS(clk, reset)
	
		TYPE UART_statetype IS (UART_IDLE, UART_START, UART_DATA, UART_STOP);
		VARIABLE UART_state		: 		UART_statetype	:= UART_IDLE;

		VARIABLE counter		:		INTEGER		:= 0;
		
	BEGIN
	
		IF (RISING_EDGE(clk)) THEN

			IF(reset = '1') THEN
			
				UART_state := UART_IDLE;
			
			ELSE
			
				CASE UART_STATE IS
				
					WHEN UART_IDLE =>
						
						tx <= '1';
						tx_done_tick <= '0';
						counter := 0;		
						d_in_tmp <= d_in;
						
					WHEN UART_START =>
					
						tx <= '0';
						tx_done_tick <= '0';
						
					WHEN UART_DATA =>
						
						tx <= d_in_tmp(0);
						tx_done_tick <= '0';
											
					WHEN UART_STOP =>
					
						tx <= '1';
						tx_done_tick <= '1';
						
					WHEN OTHERS =>
						
						tx <= '1';
						tx_done_tick <= '0';
						counter := 0;
						d_in_tmp <= d_in;
						
				END CASE;
				
				CASE UART_state IS
				
					WHEN UART_IDLE =>
						
						IF ((NOT tx_start) = '1') THEN
						
							UART_STATE := UART_START;
						
						ELSIF (tx_start = '1') THEN
						
							UART_STATE := UART_IDLE;
							
						END IF;
						
					WHEN UART_START =>
					
						IF ((NOT s_tick) = '1') THEN
							
							UART_STATE := UART_START;
							
						ELSIF (s_tick = '1') THEN
							
							UART_STATE := UART_DATA;
							
						END IF;
						
					WHEN UART_DATA =>
					
						IF ((NOT s_tick) = '1') THEN
						
							UART_STATE := UART_DATA;
							
						ELSIF (s_tick = '1' AND counter < DATA_WIDTH - 1) THEN
							
							UART_STATE := UART_DATA;
							counter := counter + 1;
							d_in_tmp <= '0' & d_in_tmp(DATA_WIDTH - 1 DOWNTO 1);
						
						ELSIF (s_tick = '1' AND counter = DATA_WIDTH - 1) THEN
						
							UART_STATE := UART_STOP;
							
						END IF;
						
					WHEN UART_STOP =>
					
						IF ((NOT s_tick) = '1') THEN
							
							UART_STATE := UART_STOP;
							
						ELSIF (s_tick = '1') THEN
						
							UART_STATE := UART_IDLE;
							
						END IF;
					
					WHEN OTHERS =>
					
						UART_STATE := UART_IDLE;
						
				END CASE;
						
			END IF;
			
		END IF;
		
	END PROCESS;
	
END Behavioral;