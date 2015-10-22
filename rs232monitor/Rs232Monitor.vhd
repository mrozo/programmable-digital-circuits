library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Rs232Monitor is
    Port (
        clk        : in  STD_LOGIC;
        rst        : in  STD_LOGIC;
        rx         : in  STD_LOGIC;
        ledAn      : out STD_LOGIC_VECTOR (3 downto 0);
        ledSeg     : out STD_LOGIC_VECTOR (7 downto 0)
    );
end Rs232Monitor;

architecture Behavioral of Rs232Monitor is
    
    COMPONENT Rs232Receiver
        PORT(
            clk              : IN  std_logic;
            rst              : IN  std_logic;
            rx               : IN  std_logic;
            data             : OUT std_logic_vector(7 downto 0);
            dataReady        : OUT std_logic
        );
    END COMPONENT;


    COMPONENT displayDriver
        PORT(
             rst             : IN  std_logic;
             clk             : IN  std_logic;
             d0              : IN  std_logic_vector(3 downto 0);
             d1              : IN  std_logic_vector(3 downto 0);
             d2              : IN  std_logic_vector(3 downto 0);
             d3              : IN  std_logic_vector(3 downto 0);
             seg             : OUT std_logic_vector(7 downto 0);
             an              : OUT std_logic_vector(3 downto 0)
            );
    END COMPONENT;
    
    signal data              : std_logic_vector;
    signal dataReady         : std_logic_vector;
    signal rxLineRst         : std_logic_vector;
    signal d0                : std_logic_vector(3 downto 0);
    signal d1                : std_logic_vector(3 downto 0);

begin

    rxLine: Rs232Receiver PORT MAP (
        clk        => clk,
        rst        => rxLineRst,
        rx         => rx,
        data       => data,
        dataReady  => dataReady
    );
    
   display: displayDriver PORT MAP (
        rst        => rst,
        clk        => clk,
        d0         => d0,
        d1         => d1,
        d2         => "0000",
        d3         => "0000",
        seg        => ledSeg,
        an         => ledAn
    );
    
    process(rst, clk)
    begin
        if rst='1' then
            rxLineRst <= '1';
            
        elsif rising_edge(clk) then
            rxLineRst <= '0';
            
            if dataReady = '1' then
                d0 <= data(3 downto 0);
                d1 <= data(7 downto 0);
                dataCopied <= '1';
                rxLineRst  <= '1';
                
            end if;
        end if;
    end process;

end Behavioral;

