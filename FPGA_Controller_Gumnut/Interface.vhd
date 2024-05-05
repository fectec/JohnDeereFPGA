LIBRARY IEEE;
USE	IEEE.STD_LOGIC_1164.ALL;
USE	IEEE.NUMERIC_STD.ALL;

ENTITY interface IS

	PORT	(	
				CLOCK_50		: IN		STD_LOGIC;
				KEY			: IN		STD_LOGIC_VECTOR(1 DOWNTO 0);
				SW			: IN		STD_LOGIC_VECTOR(9 DOWNTO 0);
				GPIO_24			: IN		STD_LOGIC;	--RX
				GPIO_25			: OUT 		STD_LOGIC;	--TX
				LEDR			: BUFFER 	STD_LOGIC_VECTOR(9 DOWNTO 0);
				SEGMENTS		: OUT		STD_LOGIC_VECTOR(13 DOWNTO 0);
				
				-- Accelerometer
				
				GSENSOR_INT		: IN		STD_LOGIC_VECTOR(1 DOWNTO 0);
				GSENSOR_SDI		: INOUT		STD_LOGIC;
				GSENSOR_SDO		: INOUT		STD_LOGIC;
				GSENSOR_CS_N	        : OUT		STD_LOGIC;
				GSENSOR_SCLK	        : OUT		STD_LOGIC
		);
		
END ENTITY interface;


ARCHITECTURE Structural OF interface IS

	COMPONENT gumnut_with_mem IS
	
		GENERIC ( 
					IMem_file_name	: STRING := "gasm_text.dat";
					DMem_file_name	: STRING := "gasm_data.dat";
					debug 		: BOOLEAN := false 
				);
			
		PORT	( 
					clk_i		: IN 	STD_LOGIC;
					rst_i 		: IN 	STD_LOGIC;
					
					-- I/O PORT bus
					
					PORT_cyc_o 	: OUT	STD_LOGIC;
					PORT_stb_o 	: OUT	STD_LOGIC;
					PORT_we_o 	: OUT	STD_LOGIC;
					PORT_ack_i 	: IN	STD_LOGIC;
					PORT_adr_o 	: OUT	UNSIGNED(7 DOWNTO 0);
					PORT_dat_o 	: OUT	STD_LOGIC_VECTOR(7 DOWNTO 0);
					PORT_dat_i 	: IN	STD_LOGIC_VECTOR(7 DOWNTO 0);
					
					-- Interrupts
					
					Int_req : IN STD_LOGIC;
					Int_ack : OUT STD_LOGIC
				);
	
	END COMPONENT gumnut_with_mem;
	
	COMPONENT uart IS

		GENERIC (
				 clk_freq  	:  integer    := 50_000_000;  -- Frequency of system clock in Hertz
				 baud_rate 	:  integer    := 115_200;     -- Data link baud rate in bits/second
				 os_rate   	:  integer    := 16;          -- Oversampling rate to find center of receive bits (in samples per baud period)
				 d_width   	:  integer    := 8;           -- Data bus width
				 parity    	:  integer    := 0;           -- 0 for no parity, 1 for parity
				 parity_eo 	:  STD_LOGIC  := '0'          -- '0' for even, '1' for odd parity
			);
			
		PORT	(
				 clk     	:  IN   STD_LOGIC;                             	-- System clock
				 reset_n  	:  IN   STD_LOGIC;                             	-- Ascynchronous reset
				 tx_ena   	:  IN   STD_LOGIC;                             	-- Iitiate transmission
				 tx_data  	:  IN   STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);  	-- Data to transmit
				 rx       	:  IN   STD_LOGIC;                             	-- Receive pin
				 rx_busy  	:  OUT  STD_LOGIC;                             	-- Data reception in progress, LEDR(9)
				 rx_error 	:  OUT  STD_LOGIC;                             	-- Start, parity, or stop bit error detected
				 rx_data  	:  OUT  STD_LOGIC_VECTOR(d_width-1 DOWNTO 0);  	-- Data received
				 tx_busy  	:  OUT  STD_LOGIC;                            	-- Transmission in progress, LEDR(8)
				 tx       	:  OUT  STD_LOGIC				-- Transmit pin
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
					CLOCK_50		: IN	STD_LOGIC;
					KEY			: IN	STD_LOGIC_VECTOR(1 DOWNTO 0);
					GSENSOR_INT		: IN	STD_LOGIC_VECTOR(1 DOWNTO 0);
					GSENSOR_SDI		: INOUT	STD_LOGIC;
					GSENSOR_SDO		: INOUT	STD_LOGIC;
					GSENSOR_CS_N	        : OUT	STD_LOGIC;
					GSENSOR_SCLK	        : OUT	STD_LOGIC;
					LEDR			: OUT	STD_LOGIC_VECTOR(9 DOWNTO 0)
				);
		
	END COMPONENT accelerometer;

	-- Gumnut
	
	SIGNAL rst_i						:	STD_LOGIC;
	SIGNAL port_cyc_o, port_stb_o, port_we_o, port_ack_i	:	STD_LOGIC;
	SIGNAL port_adr_o					:	UNSIGNED(7 DOWNTO 0);
	SIGNAL port_dat_o, port_dat_i				:	STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL int_req, int_ack					:	STD_LOGIC;

	-- UART
	
	SIGNAL reset_n_de10			:	STD_LOGIC := '1';
	SIGNAL tx_ena_de10			: 	STD_LOGIC := '1';
	SIGNAL tx_data_de10			: 	STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL rx_busy_de10			: 	STD_LOGIC;
	SIGNAL rx_error_de10		        :	STD_LOGIC;
	SIGNAL rx_data_de10			:	STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL tx_busy_de10			:	STD_LOGIC;

	-- Decoder

	SIGNAL bcd_i				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL rx_done                          :       STD_LOGIC       := '0';    
        
	-- RX data
	
	SIGNAL RX_inp				:	STD_LOGIC_VECTOR(7 DOWNTO 0);
		
	-- Switches
	
	SIGNAL switches_inp			:	STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	-- Buttons
	
	SIGNAL key0_db, key1_db		        :	STD_LOGIC;
	SIGNAL key0_inp, key1_inp	        :	STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	-- Accelerometer

	SIGNAL acc_inp				:	STD_LOGIC_VECTOR(7 DOWNTO 0);
	
BEGIN

	-- Gumnut
	
	rst_i <= '0';
	port_ack_i	<= '1';	
	
	gumnut	:	COMPONENT	gumnut_with_mem 
			PORT MAP	(
                                                CLOCK_50,
                                                rst_i,
                                                port_cyc_o,
                                                port_stb_o,
                                                port_we_o,
                                                port_ack_i,
                                                port_adr_o( 7 DOWNTO 0 ),
                                                port_dat_o( 7 DOWNTO 0 ),
                                                port_dat_i( 7 DOWNTO 0 ),
                                                int_req,
                                                int_ack
					);
					
	-- UART

	uart_0	: 	COMPONENT	uart	
			PORT MAP	( 
                                                CLOCK_50, 
                                                reset_n_de10, 
                                                tx_ena_de10, 
                                                tx_data_de10, 
                                                GPIO_24, 
                                                rx_busy_de10, 
                                                rx_error_de10, 
                                                rx_data_de10, 
                                                tx_busy_de10, 
                                                GPIO_25 
					);

	-- Decoder
	
	decoder_0	: Decoder_BCDTo7Seg	PORT MAP ( bcd_i, SEGMENTS );
	
	-- Buttons
	
	button_0	: debounce		PORT MAP( CLOCK_50, KEY(0), key0_db );
	button_1	: debounce  		PORT MAP( CLOCK_50, KEY(1), key1_db );
	
	-- Accelerometer
	
	acc_0		: accelerometer 	PORT MAP ( CLOCK_50, "11", GSENSOR_INT, GSENSOR_SDI, GSENSOR_SDO, GSENSOR_CS_N, GSENSOR_SCLK, LEDR );

	-- Gumnut & interfaces interaction
	
	-- Output => TX Data -> Data memory address	:		000
	
	PROCESS ( CLOCK_50, rst_i )
		BEGIN
			IF rst_i = '1' THEN
				
				tx_data_de10 <= ( OTHERS => '0' );

			ELSIF RISING_EDGE( CLOCK_50 ) THEN
			
				IF	port_adr_o = "00000000"	-- Address port
				AND 	port_cyc_o = '1'	-- Control signals for I/O
				AND	port_stb_o = '1'	
				AND	port_we_o  = '1'	-- Write
				THEN
				
					tx_data_de10 <= port_dat_o;
					
				END IF;
			END IF;
	END PROCESS;
	
	-- Output => TX Start -> Data memory address	:	        001
	
	PROCESS ( CLOCK_50, rst_i )
		BEGIN
			IF rst_i = '1' THEN
			
				tx_ena_de10 <= '1';
				
			ELSIF RISING_EDGE( CLOCK_50 ) THEN
			
				IF	port_adr_o = "00000001"	-- Address port
				AND 	port_cyc_o = '1'	-- Control signals for I/O
				AND	port_stb_o = '1'	
				AND	port_we_o  = '1'	-- Write
				THEN
				
					tx_ena_de10 <= port_dat_o(0);
					
				END IF;
			END IF;
	END PROCESS;
	
	-- Output => Displays -> Data memory address	:	        010		
			
	PROCESS ( CLOCK_50, rst_i )
		BEGIN
		
			IF rst_i = '1' THEN
			
				bcd_i <= ( OTHERS => '0' );
				
			ELSIF RISING_EDGE( CLOCK_50 ) THEN
			
				IF	port_adr_o = "00000010"	-- Address port
				AND     port_cyc_o = '1'	-- Control signals for I/O
				AND	port_stb_o = '1'	
				AND	port_we_o  = '1'	-- Write
				THEN
				
					bcd_i <= port_dat_o(3 DOWNTO 0);
					
				END IF;
			END IF;
	END PROCESS;	
	
	-- Input => RX Data -> Data memory address      :               011
	
	PROCESS ( CLOCK_50, rst_i )
		BEGIN
			IF rst_i = '1' THEN
			
				RX_inp <= ( OTHERS => '0' );
				
			ELSIF RISING_EDGE( CLOCK_50 ) THEN
			
				IF	port_adr_o = "00000011"
				AND     port_cyc_o = '1'	-- Control signals for I/O
				AND	port_stb_o = '1'	
				AND	port_we_o  = '0'	
				THEN
                                        
                                        RX_inp <= rx_data_de10;
					
				END IF;
			END IF;
	END PROCESS;
	
	-- Input => SWITCHES -> Data memory address     :	        100

	PROCESS ( CLOCK_50, rst_i )
		BEGIN
			IF rst_i = '1' THEN
			
				switches_inp <= ( OTHERS => '0' );
				
			ELSIF RISING_EDGE( CLOCK_50 ) THEN
			
				IF	port_adr_o = "00000100"
				AND     port_cyc_o = '1'	-- Control signals for I/O
				AND	port_stb_o = '1'	
				AND	port_we_o  = '0'	
				THEN
		
					switches_inp <= "00" & SW(5 DOWNTO 0);
					
				END IF;
			END IF;
	END PROCESS;	
	
	-- Input => KEY 0 -> Data memory address        :	        101	
	
	PROCESS ( CLOCK_50, rst_i )
		BEGIN
			IF rst_i = '1' THEN
			
				key0_inp <= ( OTHERS => '0' );
				
			ELSIF RISING_EDGE( CLOCK_50 ) THEN
			
				IF	port_adr_o = "00000101"
				AND     port_cyc_o = '1'	-- Control signals for I/O
				AND	port_stb_o = '1'	
				AND	port_we_o  = '0'	
				THEN
		
					key0_inp <= "0000000" & key0_db;
					
				END IF;
			END IF;
	END PROCESS;

	-- Input => KEY 1 -> Data memory address        :               110	
	
	PROCESS ( CLOCK_50, rst_i )
		BEGIN
			IF rst_i = '1' THEN
			
				key1_inp <= ( OTHERS => '0' );
				
			ELSIF RISING_EDGE( CLOCK_50 ) THEN
			
				IF	port_adr_o = "00000110"
				AND     port_cyc_o = '1'	-- Control signals for I/O
				AND	port_stb_o = '1'	
				AND	port_we_o  = '0'	
				THEN
		
					key1_inp <= "0000000" & key1_db;
					
				END IF;
			END IF;
	END PROCESS;
	
	-- Input => Accelerometer -> Data memory address        :       111	
	
	PROCESS ( CLOCK_50, rst_i )
		BEGIN
			IF rst_i = '1' THEN
			
				acc_inp <= ( OTHERS => '0' );
				
			ELSIF RISING_EDGE( CLOCK_50 ) THEN
			
				IF	port_adr_o = "00000111"
				AND     port_cyc_o = '1'	-- Control signals for I/O
				AND	port_stb_o = '1'	
				AND	port_we_o  = '0'	
				THEN
		
					acc_inp <= LEDR(8 DOWNTO 1);
					
				END IF;
			END IF;
	END PROCESS;
	
	-- Select signal that goes into Gumnut
	
	WITH port_adr_o SELECT	
		
		port_dat_i <=	RX_inp	        WHEN "00000011",
				switches_inp 	WHEN "00000100",
				key0_inp 	WHEN "00000101",
				key1_inp 	WHEN "00000110",
				acc_inp		WHEN "00000111",
				UNAFFECTED WHEN OTHERS;
                                
END Structural;