LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY freqDividerTb IS

END freqDividerTb;

ARCHITECTURE behavior OF freqDividerTb IS 

    COMPONENT freqDivider
    Generic (
        divisor              : integer
    );
    PORT(
        clk                  : IN  std_logic;
        rst                  : IN  std_logic;
        enable               : IN  std_logic;
        output               : OUT  std_logic
    );
    END COMPONENT;


    --Inputs
    signal clk               : std_logic         := '0';
    signal rst               : std_logic         := '0';
    signal enable            : std_logic         := '1';

    --Outputs
    signal clkDividedBy2     : std_logic;
    signal clkDividedBy3     : std_logic;
    signal clkDividedBy4     : std_logic;
    signal clkDividedBy5     : std_logic;
    signal clkDividedBy6     : std_logic;
    signal clkDividedBy7     : std_logic;

    -- Clock period definitions
    constant clk_period      : time              := 10 ns;

BEGIN

    clk <= not clk after clk_period;

    divBy2: freqDivider 
    GENERIC MAP (divisor => 2)
    PORT MAP (clk => clk, rst => rst, enable => enable, output => clkDividedBy2);

    divBy3: freqDivider 
    GENERIC MAP (divisor => 3)
    PORT MAP (clk => clk, rst => rst, enable => enable, output => clkDividedBy3);
   
    divBy4: freqDivider 
    GENERIC MAP (divisor => 4)
    PORT MAP (clk => clk, rst => rst, enable => enable, output => clkDividedBy4);
    
    divBy5: freqDivider 
    GENERIC MAP (divisor => 5)
    PORT MAP (clk => clk, rst => rst, enable => enable, output => clkDividedBy5);
    
    divBy6: freqDivider 
    GENERIC MAP (divisor => 6)
    PORT MAP (clk => clk, rst => rst, enable => enable, output => clkDividedBy6);
    
    divBy7: freqDivider 
    GENERIC MAP (divisor => 7)
    PORT MAP (clk => clk, rst => rst, enable => enable, output => clkDividedBy7);

END;
