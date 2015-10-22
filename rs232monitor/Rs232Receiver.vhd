library IEEE;
  use IEEE.STD_LOGIC_1164.ALL;
  use IEEE.NUMERIC_STD.ALL;
  
entity Rs232Receiver is
Port ( 
        clk : in  STD_LOGIC;
        rst : in  STD_LOGIC;
        rx : in  STD_LOGIC;
        data : out  STD_LOGIC_VECTOR (7 downto 0);
        dataReady : out  STD_LOGIC
    );
end Rs232Receiver;

architecture Behavioral of Rs232Receiver is
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

    signal state : std_logic_vector(7 downto 0);
    signal rxData: std_logic_vector(9 downto 0);
    signal uartClk : std_logic;
    signal clkGenRst: std_logic;
    signal zeroes: std_logic_vector(2 downto 0);
    
begin

    clkGenRst <= '1' when rst='1' else
                 '1' when state = "01010001" else --state=81
                 '0';
                  
    uartClkGen: freqDivider 
    GENERIC MAP (divisor => 651) -- 50MHz / 9600MHz / 8
    PORT MAP (clk => clk, rst => clkGenRst, enable => '1', output => uartClk);
    
    
    process(rst, uartClk) begin
        if rst='1' then
            zeroes <= "000";
            state  <= "00000000";
            rxData <= "0000000000";
            data   <= "00000000";
            dataReady <= '0';
        elsif rising_edge(uartClk) then
            if rx = '0' then
                zeroes <= std_logic_vector(1 + unsigned(zeroes));
            end if;
            
            if state(2 downto 0) = "111" then -- the last sample for the bit
               
                if (to_integer(unsigned(zeroes)) > 3) then
                    rxData(to_integer(unsigned(state(6 downto 3)))) <= '0';
                else
                    rxData(to_integer(unsigned(state(6 downto 3)))) <= '1';
                end if;
                
                zeroes <= "000";
                
                if state(6 downto 3) = "1001" then -- the last sample of the last bit
                    data <= rxData(8 downto 1);
                    dataReady <= '1';
                end if;
                
            end if;
            
            state <= std_logic_vector(unsigned(state) +1);
            
        end if;
    end process;

end Behavioral;

