LIBRARY	ieee;
USE		ieee.std_logic_1164.ALL;
USE		ieee.numeric_std.ALL;

ENTITY Interface IS

	PORT (
	
			clk_i				: IN		STD_LOGIC;	-- 50MHz
			Hsync_i, Vsync_i		: BUFFER 	STD_LOGIC;
			R_i, G_i, B_i			: OUT 		STD_LOGIC_VECTOR(3 DOWNTO 0);
			
			up_s_i, down_s_i		: IN		STD_LOGIC;
			restart_i			: IN		STD_LOGIC;
			
			-- Accelerometer
			
			accelerometer_x_value_i		: BUFFER	STD_LOGIC_VECTOR(9 DOWNTO 0);
						
			KEY_i				: IN		STD_LOGIC_VECTOR(1 DOWNTO 0);
			GSENSOR_INT_i			: IN		STD_LOGIC_VECTOR(1 DOWNTO 0);
			GSENSOR_SDI_i			: INOUT		STD_LOGIC;
			GSENSOR_SDO_i			: INOUT		STD_LOGIC;
			GSENSOR_CS_N_i			: OUT		STD_LOGIC;
			GSENSOR_SCLK_i			: OUT		STD_LOGIC				
	);
	
END Interface;

ARCHITECTURE Interface_Arch OF Interface IS

	COMPONENT VGA IS
	
		GENERIC (
		
			Ha			: 	POSITIVE 	:= 96;		--Hpulse
			Hb			: 	POSITIVE 	:= 144; 	--Hpulse+HBP
			Hc			: 	POSITIVE 	:= 784; 	--Hpulse+HBP+Hactive
			Hd			: 	POSITIVE 	:= 800; 	--Hpulse+HBP+Hactive+HFP
			Va			: 	POSITIVE 	:= 2; 		--Vpulse
			Vb			: 	POSITIVE 	:= 35; 		--Vpulse+VBP
			Vc			: 	POSITIVE 	:= 515; 	--Vpulse+VBP+Vactive
			Vd			: 	POSITIVE	:= 525; 	--Vpulse+VBP+Vactive+VFP
			
			FRAMES_PER_SECOND	:	POSITIVE	:= 60;
			
			SCREEN_WIDTH		:	POSITIVE	:= 640;
			SCREEN_HEIGHT		:	POSITIVE	:= 480;
			
			SPRITE_SIZE		:	POSITIVE 	:= 75;
			COLOR_LAYERS		:	POSITIVE	:= 5;
		
			SPRITES			:	POSITIVE	:= 3;
			DISPLACEMENT		:	POSITIVE	:= 8;
			
			CORNERS			:	POSITIVE	:= 4
		
		);
		
		PORT (
		
			clk			: 	IN		STD_LOGIC;	-- 50MHz
			Hsync, Vsync		: 	BUFFER 		STD_LOGIC;
			R, G, B			: 	OUT 		STD_LOGIC_VECTOR(3 DOWNTO 0);
			
			up_s, down_s		:	IN		STD_LOGIC;
			restart			: 	IN		STD_LOGIC;
						
			accelerometer_x_value	: 	IN		STD_LOGIC_VECTOR(9 DOWNTO 0)
		);
		
	END COMPONENT VGA;
	
	COMPONENT accelerometer IS
		
		PORT (	
		
			CLOCK_50		: IN			STD_LOGIC;
			
			KEY			: IN			STD_LOGIC_VECTOR(1 DOWNTO 0);
			GSENSOR_INT		: IN			STD_LOGIC_VECTOR(1 DOWNTO 0);
			GSENSOR_SDI		: INOUT			STD_LOGIC;
			GSENSOR_SDO		: INOUT			STD_LOGIC;
			GSENSOR_CS_N		: OUT			STD_LOGIC;
			GSENSOR_SCLK		: OUT			STD_LOGIC;
			
			LEDR			: BUFFER		STD_LOGIC_VECTOR(9 DOWNTO 0)
		);
			
	END COMPONENT accelerometer;
	
	SIGNAL accelerometer_x_value_i_tmp	: 	STD_LOGIC_VECTOR(9 DOWNTO 0);
	
BEGIN	

	accelerometer_x_value_i_tmp <= accelerometer_x_value_i;
	
	VGA_C		:	VGA PORT MAP (clk_i, Hsync_i, Vsync_i, R_i, G_i, B_i, up_s_i, down_s_i, restart_i, accelerometer_x_value_i_tmp);
	ACC_C		:	accelerometer PORT MAP (clk_i, KEY_i, GSENSOR_INT_i, GSENSOR_SDI_i, GSENSOR_SDO_i, GSENSOR_CS_N_i, GSENSOR_SCLK_i, accelerometer_x_value_i);
			
END ARCHITECTURE Interface_Arch;
