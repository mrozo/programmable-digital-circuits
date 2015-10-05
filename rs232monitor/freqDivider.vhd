library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real."ceil";
use IEEE.math_real."log2";

entity freqDivider is
	Generic (
		divisor      : integer                     := 10
	);
	Port (
		clk          : in  STD_LOGIC;
		rst          : in  STD_LOGIC;
		enable       : in  STD_LOGIC;
		output       : out  STD_LOGIC
	);
end freqDivider;


architecture Behavioral of freqDivider is
	COMPONENT counter
	Generic (
		width        : integer                     
	);
	PORT(
		rst          : IN  std_logic;
		clk          : IN  std_logic;
		clear        : IN  std_logic;
		state        : OUT std_logic_vector(
									(ceil(log2(real(divisor)))) downto 0
								)
	);
	END COMPONENT;
	
	signal counterClk         : STD_LOGIC;

begin
	
	
	
	c1: counter 
		GENERIC MAP (
			width => ceil(log2(real(divisor)))
		)
		PORT MAP (
          rst => rst,
          clk => counterClk,
          clear => '0',
          state => state
        );
	counterClk <= clk AND enable;
	
	output <= '0' when rst='1' else
	          '0' when state<divisor-(divisor/2) else
				 '1';

end Behavioral;

