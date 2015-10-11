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

    function log2_float(val : positive) return natural is
    begin
        return integer(ceil(log2(real(val))));
    end function;

    COMPONENT counter
    Generic (
        width                : integer                     
    );
    PORT(
        rst                  : IN  std_logic;
        clk                  : IN  std_logic;
        clear                : IN  std_logic;
        state                : OUT std_logic_vector(
                                        log2_float(divisor) downto 0
                                    )
            );
    END COMPONENT;

    signal counterClk        : STD_LOGIC         := '0';
 --   signal output            : STD_LOGIC         := '0';
    signal state             : std_logic_vector(
                                    log2_float(divisor) downto 0
                                );
 begin

    c1: counter 
    GENERIC MAP (
        width => divisor
    )
    PORT MAP (
        rst => rst,
        clk => counterClk,
        clear => '0',
        state => state
    );
    counterClk <= clk AND enable;

    output <=   '1';

end Behavioral;

