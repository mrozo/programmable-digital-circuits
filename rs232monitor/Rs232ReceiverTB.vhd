LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY Rs232ReceiverTB IS
END Rs232ReceiverTB;

ARCHITECTURE behavior OF Rs232ReceiverTB IS 

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT Rs232Receiver
        PORT(
            clk : IN  std_logic;
            rst : IN  std_logic;
            rx : IN  std_logic;
            data : OUT  std_logic_vector(7 downto 0);
            dataReady : OUT  std_logic
        );
    END COMPONENT;


    --Inputs
    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal rx : std_logic := '1';

    --Outputs
    signal data : std_logic_vector(7 downto 0);
    signal dataReady : std_logic;

    -- Clock period definitions
    constant clk_period : time := 20 ns;
    constant uart_bit_time : time := 104 us;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: Rs232Receiver PORT MAP (
        clk => clk,
        rst => rst,
        rx => rx,
        data => data,
        dataReady => dataReady
    );

    -- Clock process definitions
    clk <= not clk after clk_period/2;
    
    --rst <= '0' after clk_period*5 when dataReady /= '1' else '1';

    -- Stimulus process
    stim_proc: process
    
    begin
    
        wait for 100 * clk_period;

        rx <= '1';
        rst <= '0';

        wait for 200 * clk_period;

        -- byte 0x00
        rx <= '0'; --start bit
        wait for uart_bit_time;
        -- data start

        rx <= '0'; -- bit 0
        wait for uart_bit_time;
        rx <= '0'; -- bit 1
        wait for uart_bit_time;
        rx <= '0'; -- bit 2
        wait for uart_bit_time;
        rx <= '0'; -- bit 3
        wait for uart_bit_time;   
        rx <= '0'; -- bit 4
        wait for uart_bit_time;
        rx <= '0'; -- bit 5
        wait for uart_bit_time;
        rx <= '0'; -- bit 6
        wait for uart_bit_time;
        rx <= '0'; -- bit 7
        wait for uart_bit_time;

        -- data stop
        rx <= '0'; --stop bit
        wait for uart_bit_time;
        rx <= '1';
        wait for 20 us;

        rst <= '1';
        wait for clk_period * 2;
        rst <= '0';
        wait for clk_period * 2;

        -- byte 0xff
        rx <= '0'; --start bit
        wait for uart_bit_time;
        -- data start

        rx <= '1'; -- bit 0
        wait for uart_bit_time;
        rx <= '1'; -- bit 1
        wait for uart_bit_time;
        rx <= '1'; -- bit 2
        wait for uart_bit_time;
        rx <= '1'; -- bit 3
        wait for uart_bit_time;   
        rx <= '1'; -- bit 4
        wait for uart_bit_time;
        rx <= '1'; -- bit 5
        wait for uart_bit_time;
        rx <= '1'; -- bit 6
        wait for uart_bit_time;
        rx <= '1'; -- bit 7
        wait for uart_bit_time;

        -- data stop
        rx <= '0'; --stop bit
        wait for uart_bit_time;
        rx <= '1';
        wait for 20 us;

        rst <= '1';
        wait for clk_period * 2;
        rst <= '0';
        wait for clk_period * 2;

        -- byte 0x55
        rx <= '0'; --start bit
        wait for uart_bit_time;
        -- data start

        rx <= '1'; -- bit 0
        wait for uart_bit_time;
        rx <= '0'; -- bit 1
        wait for uart_bit_time;
        rx <= '1'; -- bit 2
        wait for uart_bit_time;
        rx <= '0'; -- bit 3
        wait for uart_bit_time;   
        rx <= '1'; -- bit 4
        wait for uart_bit_time;
        rx <= '0'; -- bit 5
        wait for uart_bit_time;
        rx <= '1'; -- bit 6
        wait for uart_bit_time;
        rx <= '0'; -- bit 7
        wait for uart_bit_time;

        -- data stop
        rx <= '0'; --stop bit
        wait for uart_bit_time;
        rx <= '1';
        wait for 20 us;
        
        rst <= '1';
        wait for clk_period * 2;
        rst <= '0';
        wait for clk_period * 2;

        
        wait;
    end process;

END;
