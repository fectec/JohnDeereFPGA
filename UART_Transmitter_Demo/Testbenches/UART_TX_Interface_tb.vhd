LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY 	UART_TX_Interface_tb 	IS
END 	UART_TX_Interface_tb;
 
ARCHITECTURE Test OF UART_TX_Interface_tb IS
	
	CONSTANT C_CLK_PERIOD 			: TIME			:= 20 ns;	-- 50 MHz Clock.
  
	SIGNAL clk_tb     			: STD_LOGIC		:= '0';
	SIGNAL tx_start_tb     			: STD_LOGIC		:= '0';
	SIGNAL reset_baudrate_gen_tb		: STD_LOGIC		:= '0';
	SIGNAL reset_UART_TX_tb			: STD_LOGIC		:= '0';
	SIGNAL d_in_tb   			: STD_LOGIC_VECTOR(7 DOWNTO 0)	:= (OTHERS => '0');
	SIGNAL tx_tb 				: STD_LOGIC		:= '0';
	SIGNAL tx_done_tick_tb			: STD_LOGIC		:= '0';
	
	COMPONENT  UART_TX_Interface IS
		
		GENERIC
			(
				DATA_WIDTH	:		INTEGER	:=	8
			);
			
		PORT
			(
				clk, tx_start, reset_baudrate_gen, reset_UART_TX	:		IN		STD_LOGIC;
				d_in							:		IN		STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
				tx, tx_done_tick					: 		OUT		STD_LOGIC
			);
			
	END COMPONENT;
   
	BEGIN
		
		-- UART Transmitter Instantiation
		
		DUT	:	UART_TX_Interface PORT MAP (clk_tb, tx_start_tb, reset_baudrate_gen_tb, reset_UART_TX_tb, d_in_tb, tx_tb, tx_done_tick_tb);
	 
		clk_tb <= NOT clk_tb AFTER C_CLK_PERIOD / 2;
		tx_start_tb <= '0';
		reset_baudrate_gen_tb <= '0';
		reset_UART_TX_tb <= '0';
		d_in_tb <= "11010101";
		
END Test;
