LIBRARY ieee;
USE	ieee.STD_LOGIC_1164.all;

ENTITY accelerometer IS
	
		PORT (	
		
				CLOCK_50		: IN		STD_LOGIC;
				
				KEY			: IN		STD_LOGIC_VECTOR(1 DOWNTO 0);
				GSENSOR_INT		: IN		STD_LOGIC_VECTOR(1 DOWNTO 0);
				GSENSOR_SDI		: INOUT		STD_LOGIC;
				GSENSOR_SDO		: INOUT		STD_LOGIC;
				GSENSOR_CS_N		: OUT		STD_LOGIC;
				GSENSOR_SCLK		: OUT		STD_LOGIC;
				
				LEDR			: BUFFER	STD_LOGIC_VECTOR(9 DOWNTO 0)
			
		);
		
END ENTITY accelerometer;

ARCHITECTURE Structural OF accelerometer IS

COMPONENT reset_delay IS

	PORT ( 	
	
			iRSTN				: IN 		STD_LOGIC;
			iCLK				: IN 		STD_LOGIC;
			oRST				: OUT		STD_LOGIC
	);
	
END COMPONENT;

COMPONENT spi_pll IS

	PORT ( 	
	
			areset				: IN	 	STD_LOGIC;
			inclk0				: IN 		STD_LOGIC;
			c0				: OUT		STD_LOGIC;
			c1				: OUT 		STD_LOGIC	
	);
	
END COMPONENT;

COMPONENT spi_ee_config IS

	PORT ( 
	
			iRSTN				: IN 		STD_LOGIC;
			iSPI_CLK			: IN 		STD_LOGIC;
			iSPI_CLK_OUT			: IN		STD_LOGIC;
			iG_INT2				: IN 		STD_LOGIC;
			oDATA_L				: OUT 		STD_LOGIC_VECTOR(7 DOWNTO 0);
			oDATA_H				: OUT 		STD_LOGIC_VECTOR(7 DOWNTO 0);
			SPI_SDIO			: INOUT 	STD_LOGIC;
			oSPI_CSN			: OUT 		STD_LOGIC;
			oSPI_CLK			: OUT 		STD_LOGIC
	);
	
END COMPONENT;
 
COMPONENT led_driver IS

	PORT ( 	
	
			iRSTN				: IN 			STD_LOGIC;
			iCLK				: IN 			STD_LOGIC;
			iDIG				: IN 			STD_LOGIC_VECTOR(9 DOWNTO 0);
			iG_INT2				: IN 			STD_LOGIC;
			oLED				: OUT 			STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END COMPONENT;

SIGNAL dly_rst		: 	STD_LOGIC;
SIGNAL spi_clk		: 	STD_LOGIC;
SIGNAL spi_clk_out	: 	STD_LOGIC;
SIGNAL data_x		:	STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN
	
	-- Reset
	
	reset		: reset_delay 	PORT MAP( KEY(0), CLOCK_50, dly_rst );

	-- PLL
	
	pll		: spi_pll 	PORT MAP( dly_rst, CLOCK_50, spi_clk, spi_clk_out );

	-- Initial Setting and Data Read Back
	
	spi_config	: spi_ee_config	PORT MAP( not dly_rst, spi_clk, spi_clk_out, GSENSOR_INT(0), data_x(7 DOWNTO 0), 
							data_x(15 DOWNTO 8), GSENSOR_SDI, GSENSOR_CS_N, GSENSOR_SCLK );

	-- LED
	
	led		: led_driver 	PORT MAP( not dly_rst, CLOCK_50, data_x(9 DOWNTO 0), GSENSOR_INT(0), LEDR );

END Structural;
