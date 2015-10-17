library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.math_real.ALL;
USE ieee.numeric_std.ALL;

entity freqDivider is
    Generic (
        divisor              : integer           := 10
    );
    Port (
        clk                  : in  STD_LOGIC;
        rst                  : in  STD_LOGIC;
        enable               : in  STD_LOGIC;
        output               : out  STD_LOGIC    := '0'
    );
end freqDivider;


architecture Behavioral of freqDivider is

    function SizeInBits(val : positive) return natural is
    begin
        return integer(ceil(log2(real(val))));
    end function;

    COMPONENT counter
    Generic (
        width                : integer           := (SizeInBits(divisor))                    
    );
    PORT(
        rst                  : IN  std_logic;
        clk                  : IN  std_logic;
        clear                : IN  std_logic;
        state                : OUT std_logic_vector((SizeInBits(divisor)-1) downto 0)
    );
    END COMPONENT;

    signal counterClk        : STD_LOGIC         := '0';
	signal counterRst        : STD_LOGIC         := '0';
    signal state             : std_logic_vector((SizeInBits(divisor)-1) downto 0);
 begin

    c1: counter 
    GENERIC MAP (
        width => (SizeInBits(divisor))
    )
    PORT MAP (
        rst => counterRst,
        clk => counterClk,
        clear => '0',
        state => state
    );
	 
	 counterRst <= '1' when rst='1' else
                  '1' when (to_integer(unsigned(state)) = (divisor-1)) else
                  '0';
	 
    counterClk <= clk AND enable;

    output <= '1' when (rst='1') else
              '1' when (to_integer(unsigned(state)) = 0) else
              '1' when (to_integer(unsigned(state))<(divisor/2)) else	 
              '0';

end Behavioral;

