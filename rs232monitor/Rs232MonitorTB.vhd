LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Rs232MonitorTB IS
END Rs232MonitorTB;

ARCHITECTURE behavior OF Rs232MonitorTB IS 

    COMPONENT Rs232Monitor
    PORT(
        clk        : IN  std_logic;
        rst        : IN  std_logic;
        rx         : IN  std_logic;
        ledAn      : OUT  std_logic_vector(3 downto 0);
        ledSeg     : OUT  std_logic_vector(7 downto 0)
    );
    END COMPONENT;


    --Inputs
    signal clk     : std_logic         := '0';
    signal rst     : std_logic         := '0';
    signal rx      : std_logic         := '0';

    --Outputs
    signal ledAn   : std_logic_vector(3 downto 0);
    signal ledSeg  : std_logic_vector(7 downto 0);

    -- Clock period definitions
    constant clk_period      : time    := 20 ns;
    constant uart_bit_time   : time    := 104 us;

BEGIN
    
    clk <= not clk after clk_period/2;

    -- Instantiate the Unit Under Test (UUT)
    uut: Rs232Monitor PORT MAP (
        clk => clk,
        rst => rst,
        rx => rx,
        ledAn => ledAn,
        ledSeg => ledSeg
    );



    -- Stimulus process
    stim_proc: process
    
    begin
        rst <= '1';
        rx  <= '1';
        wait for 200 * clk_period;
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
        
        
        wait;
    end process;

END;
