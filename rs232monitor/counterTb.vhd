LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

ENTITY counterTb IS
	Generic (
		counter1Width          : integer           :=2;
		counter2Width          : integer           :=5;
		counter3Width          : integer           :=8;
		counter4Width          : integer           :=16
	);
END counterTb;
 
ARCHITECTURE behavior OF counterTb IS 
 
    COMPONENT counter
	 Generic (
		width        : integer
	 );
    PORT(
		rst          : IN  std_logic;
		clk          : IN  std_logic;
		clear        : IN  std_logic;
		state        : OUT std_logic_vector((width-1) downto 0)
        );
    END COMPONENT;


   --Inputs
   signal rst      : std_logic         := '0';
   signal clk      : std_logic         := '0';
   signal clear1   : std_logic         := '0';
   signal clear2   : std_logic         := '0';
   signal clear3   : std_logic         := '0';
   signal clear4   : std_logic         := '0';

 	--Outputs
   signal state1   : std_logic_vector((counter1Width-1) downto 0);
   signal state2   : std_logic_vector((counter2Width-1) downto 0);
   signal state3   : std_logic_vector((counter3Width-1) downto 0);
   signal state4   : std_logic_vector((counter4Width-1) downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	clk <= not clk after clk_period;
 
   c1: counter 
		GENERIC MAP (
			width => counter1Width
		)
		PORT MAP (
          rst => rst,
          clk => clk,
          clear => clear1,
          state => state1
        );
 
   c2: counter 
		GENERIC MAP (
			width => counter2Width
		)
		PORT MAP (
          rst => rst,
          clk => clk,
          clear => clear2,
          state => state2
        );
 
   c3: counter 
		GENERIC MAP (
			width => counter3Width
		)
		PORT MAP (
          rst => rst,
          clk => clk,
          clear => clear3,
          state => state3
        );
 
	clear4 <= '1' when unsigned(state4)=101 else '0';
   c4: counter 
		GENERIC MAP (
			width => counter4Width
		)
		PORT MAP (
          rst => rst,
          clk => clk,
          clear => clear4,
          state => state4
        );



   stim_proc: process
   begin		
      wait for 100 ns;	

      wait for clk_period*10;

      wait;
   end process;

END;
