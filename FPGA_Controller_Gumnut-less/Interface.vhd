LIBRARY IEEE;
LIBRARY IEEE;
USE	IEEE.STD_LOGIC_1164.ALL;
USE	IEEE.NUMERIC_STD.ALL;

ENTITY interface IS

	PORT	(	
				CLOCK_50	: IN		STD_LOGIC;
				KEY		: IN		STD_LOGIC_VECTOR(1 DOWNTO 0);
				SW		: IN		STD_LOGIC_VECTOR(9 DOWNTO 0);
				GPIO_24		: IN		STD_LOGIC;	--RX
				GPIO_25		: OUT 		STD_LOGIC;	--TX
				LEDR		: BUFFER 	STD_LOGIC_VECTOR(9 DOWNTO 0);
				SEGMENTS	: OUT		STD_LOGIC_VECTOR(13 DOWNTO 0);
				
				-- Accelerometer
				
				GSENSOR_INT	: IN		STD_LOGIC_VECTOR(1 DOWNTO 0);
				GSENSOR_SDI	: INOUT		STD_LOGIC;
				GSENSOR_SDO	: INOUT		STD_LOGIC;
				GSENSOR_CS_N	: OUT		STD_LOGIC;
				GSENSOR_SCLK	: OUT		STD_LOGIC
		);
		
END ENTITY interface;

ARCHITECTURE Structural OF interface IS
	
	COMPONENT uart IS

		GENERIC (
				 clk_freq  	:  integer    := 50_000_000;  -- Frequency of system clock IN Hertz
				 baud_rate 	:  integer    := 115_200;     -- Data lINk baud rate IN bits/second
				 os_rate   	:  integer    := 16;          -- OversamplINg rate to fINd center of receive bits (IN samples per baud period)
				 d_width   	:  integer    := 8;           -- Data bus width
				 parity    	:  integer    := 0;           -- 0 for no parity, 1 for parity
				 parity_eo 	:  STD_LOGIC  := '0'          -- '0' for even, '1' for odd parity
			);
			
		PORT	(
				 clk     	:  IN   STD_LOGIC;                             	-- System clock
				 reset_n  	:  IN   STD_LOGIC;                             	-- Ascynchronous reset
				 tx_ena   	:  IN   STD_LOGIC;                             	-- INitiate transmission
				 tx_data  	:  IN   STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);  	-- Data to transmit
				 rx       	:  IN   STD_LOGIC;                             	-- Receive pIN
				 rx_busy  	:  OUT  STD_LOGIC;                             	-- Data reception IN progress, LEDR(9)
				 rx_error 	:  OUT  STD_LOGIC;                             	-- Start, parity, or stop bit error detected
				 rx_data  	:  OUT  STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);  	-- Data received
				 tx_busy  	:  OUT  STD_LOGIC;                            	-- Transmission IN progress, LEDR(8)
				 tx       	:  OUT  STD_LOGIC								-- Transmit pIN
			); 
				
	END COMPONENT uart;

	COMPONENT Decoder_BCDTo7Seg IS

		PORT	(	
				bcd		:	IN	STD_LOGIC_VECTOR(3 DOWNTO 0);
				Segments	:	OUT	STD_LOGIC_VECTOR(13 DOWNTO 0)
			);
				
	END COMPONENT Decoder_BCDTo7Seg;
	
	COMPONENT debounce IS
	
		PORT	(
				Clock		:	IN	STD_LOGIC;
				button		:	IN	STD_LOGIC;
				debounced	:	BUFFER	STD_LOGIC
		);
				
	END COMPONENT debounce;
	
	COMPONENT accelerometer IS
	
		PORT	(			
				CLOCK_50	: IN	STD_LOGIC;
				KEY		: IN	STD_LOGIC_VECTOR(1 DOWNTO 0);
				GSENSOR_INT	: IN	STD_LOGIC_VECTOR(1 DOWNTO 0);
				GSENSOR_SDI	: INOUT	STD_LOGIC;
				GSENSOR_SDO	: INOUT	STD_LOGIC;
				GSENSOR_CS_N	: OUT	STD_LOGIC;
				GSENSOR_SCLK	: OUT	STD_LOGIC;
				LEDR		: OUT	STD_LOGIC_VECTOR(9 DOWNTO 0)
			);
		
	END COMPONENT accelerometer;
	
	-- UART
	
	SIGNAL reset_n_de10		:	STD_LOGIC := '1';
	SIGNAL tx_ena_de10		: 	STD_LOGIC := '1';
	SIGNAL tx_data_de10		: 	STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL rx_busy_de10		: 	STD_LOGIC;
	SIGNAL rx_error_de10		:	STD_LOGIC;
	SIGNAL rx_data_de10		:	STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL tx_busy_de10		:	STD_LOGIC;
	
	-- Buttons 
	
	SIGNAL key0_db		: 	STD_LOGIC;
	SIGNAL key1_db		: 	STD_LOGIC;
	
	-- Accelerometer

	SIGNAL acc_data_de10		:	STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL acc_data_de10_integer	:	INTEGER;
	
	SIGNAL right_s, left_s		: STD_LOGIC;
	
BEGIN
	
		acc_data_de10 <= LEDR;
		acc_data_de10_integer <= TO_INTEGER(UNSIGNED(acc_data_de10));
	
		uart_0		: uart 			PORT MAP( CLOCK_50, reset_n_de10, tx_ena_de10, tx_data_de10, GPIO_24, rx_busy_de10, rx_error_de10, rx_data_de10, tx_busy_de10, GPIO_25 );
		button_0	: debounce		PORT MAP( CLOCK_50, KEY(0), key0_db );
		button_1	: debounce  		PORT MAP( CLOCK_50, KEY(1), key1_db );
		decoder_0	: Decoder_BCDTo7Seg 	PORT MAP( rx_data_de10(3 DOWNTO 0), segments );
		acc_0		: accelerometer 	PORT MAP( CLOCK_50, "11", GSENSOR_INT, GSENSOR_SDI, GSENSOR_SDO, GSENSOR_CS_N, GSENSOR_SCLK, LEDR );
		
		-- Process to determine tractor's direction based on accelerometer data
		
		acc_to_d	: PROCESS ( CLOCK_50 )
						
		BEGIN	
		
			IF ( RISING_EDGE(CLOCK_50) ) THEN
			
				IF (acc_data_de10_integer >= 1 AND acc_data_de10_integer <= 12) THEN
				
					right_s <= '1';
					left_s  <= '0';
							
				ELSIF (acc_data_de10_integer >= 64 AND acc_data_de10_integer <= 768) THEN
				
					left_s <= '1';
					right_s <= '0';
				
				ELSIF (acc_data_de10_integer >= 16 AND acc_data_de10_integer <= 48) THEN
				
					left_s <= '0';
					right_s <= '0';
					
				ELSE
					
					left_s <= '0';
					right_s <= '0';
										
				END IF;
	
			END IF;
		
		END PROCESS acc_to_d;
					
		--Process to transmit data according to the interface inputs
		
		data_fsm	: PROCESS( CLOCK_50 )
		
			TYPE FSM_STATE IS (IDLE, FIRST_GEAR, SECOND_GEAR, THIRD_GEAR, FOURTH_GEAR, FIFTH_GEAR, REVERSE_GEAR, THROTTLE, BRAKE, RIGHT_DIRECTION, LEFT_DIRECTION);
			VARIABLE STATE	:	FSM_STATE	:=	IDLE;
		
		BEGIN
		
			IF ( RISING_EDGE(CLOCK_50) ) THEN
				
				CASE STATE IS
					
					WHEN IDLE =>

						IF (SW(0) = '1') THEN
						
							STATE := FIRST_GEAR;
				
						ELSIF (SW(1) = '1') THEN
						
							STATE := SECOND_GEAR;
						
						ELSIF (SW(2) = '1') THEN
						
							STATE := THIRD_GEAR;
						
						ELSIF (SW(3) = '1') THEN
						
							STATE := FOURTH_GEAR;
						
						ELSIF (SW(4) = '1') THEN
						
							STATE := FIFTH_GEAR;
							
						ELSIF (SW(5) = '1') THEN
						
							STATE := REVERSE_GEAR;
							
						ELSIF (key0_db = '1') THEN
												
							STATE := THROTTLE;
						
						ELSIF (key1_db = '1') THEN
												
							STATE := BRAKE;	
							
						ELSIF (right_s = '1') THEN
												
							STATE := RIGHT_DIRECTION;	
							
						ELSIF (left_s = '1') THEN
												
							STATE := LEFT_DIRECTION;	
						
						ELSE	
						
							STATE := IDLE;
							
						END IF;
					
					WHEN FIRST_GEAR =>
					
						IF (SW(0) = '0') THEN
						
							STATE := IDLE;

						END IF;
					
					WHEN SECOND_GEAR =>
						
						IF (SW(1) = '0') THEN
						
							STATE := IDLE;

						END IF;
					
					WHEN THIRD_GEAR =>
					
						IF (SW(2) = '0') THEN
						
							STATE := IDLE;

						END IF;
							
					WHEN FOURTH_GEAR =>
					
						IF (SW(3) = '0') THEN
						
							STATE := IDLE;

						END IF;
					
					WHEN FIFTH_GEAR =>
					
						IF (SW(4) = '0') THEN
						
							STATE := IDLE;

						END IF;
							
					WHEN REVERSE_GEAR =>
					
						IF (SW(5) = '0') THEN
						
							STATE := IDLE;

						END IF;
					
					WHEN THROTTLE =>
					
						IF (key0_db = '0') THEN
					
							STATE := IDLE;

						END IF;
						
					WHEN BRAKE =>			
					
						IF (key1_db = '0') THEN
						
							STATE := IDLE;

						END IF;
						
					WHEN RIGHT_DIRECTION =>			
					
						IF (right_s = '0') THEN
						
							STATE := IDLE;

						END IF;
						
					WHEN LEFT_DIRECTION =>			
					
						IF (left_s = '0') THEN
						
							STATE := IDLE;

						END IF;
						
					WHEN OTHERS =>
					
						STATE := IDLE;
					
				END CASE;
				
				CASE STATE IS
				
					WHEN IDLE =>
					
						tx_ena_de10 <= '1';

					WHEN OTHERS =>
					 
						tx_ena_de10 <= '0';
						
				END CASE;
			
				CASE STATE IS
					
					WHEN IDLE =>
						
						tx_data_de10 <= (OTHERS => '0');
						
					WHEN FIRST_GEAR =>
						
						tx_data_de10 <= "00000001";
						
					WHEN SECOND_GEAR =>

						tx_data_de10 <= "00000010";
						
					WHEN THIRD_GEAR =>

						tx_data_de10 <= "00000011";
						
					WHEN FOURTH_GEAR =>

						tx_data_de10 <= "00000100";
						
					WHEN FIFTH_GEAR =>

						tx_data_de10 <= "00000101";
					
					WHEN REVERSE_GEAR =>

						tx_data_de10 <= "00000110";
						
					WHEN THROTTLE =>			

						tx_data_de10 <= "00000111";

					WHEN BRAKE =>

						tx_data_de10 <= "00001000";
						
					WHEN RIGHT_DIRECTION =>

						tx_data_de10 <= "00001001";
						
					WHEN LEFT_DIRECTION =>

						tx_data_de10 <= "00001010";
						
					WHEN OTHERS =>
					
						tx_data_de10 <= (OTHERS => '0');
						
				END CASE;
				
			END IF;
			
	END PROCESS data_fsm;
							
END Structural;
