library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity displayDriver is
    Port (
        rst        : in  STD_LOGIC;
        clk        : in  STD_LOGIC;
        d0         : in  STD_LOGIC_VECTOR (3 downto 0);
        d1         : in  STD_LOGIC_VECTOR (3 downto 0);
        d2         : in  STD_LOGIC_VECTOR (3 downto 0);
        d3         : in  STD_LOGIC_VECTOR (3 downto 0);
        seg        : out  STD_LOGIC_VECTOR (7 downto 0)    := "00000000";
        an         : out  STD_LOGIC_VECTOR (3 downto 0)    := "1000"
    );
end displayDriver;

architecture Behavioral of displayDriver is
    TYPE FONT_ARRAY IS ARRAY (0 to 15) OF std_logic_vector(6 downto 0);
    
    CONSTANT font            : FONT_ARRAY        := (
        "0000001", -- 0
        "1001111", -- 1
        "0010010", -- 2
        "0000110", -- 3
        "1101100", -- 4
        "0100100", -- 5
        "0100000", -- 6
        "0001111", -- 7
        "0000000", -- 8
        "0000100", -- 9
        "0001000", -- a
        "1100000", -- b
        "1110010", -- c
        "1000100", -- d
        "0110000", -- e
        "0111000"  -- f
    );


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
	 signal currentDigitNumber
                             : std_logic_vector(1 downto 0)  
                                                 := "00"; 
     signal currentDigit     : std_logic_vector(3 downto 0);
	 signal anClk            : std_logic         := '0';
     -- signal digits           : std_logic_vector(15 downto 0);
     -- signal output           : std_logic_vector(31 downto 0);
begin

    --digits <= d3 & d2 & d1 & d0;
    --seg <= font(
    --            to_integer(unsigned(
    --                digits( 
    --                   (((to_integer(unsigned(currentDigitNumber))+1)*4)-1)
    --                    downto
    --                    ((to_integer(unsigned(currentDigitNumber)))*4)
    --                )
    --            ))
    --        ) & '1';
    -- ------------------------------------------------------------------------
    --currentDigit <= d3 when currentDigitNumber = "11" else
    --                d2 when currentDigitNumber = "10" else
    --                d1 when currentDigitNumber = "01" else
    --                d0;
                    
    --seg <= font( to_integer(unsigned(currentDigit)) ) & '1';
           

    anClockGen: freqDivider 
    GENERIC MAP (divisor => 50000)
    PORT MAP (clk => clk, rst => rst, enable => '1', output => anClk);


    process(rst, anClk)
    
    begin
        if rst='1' then
            seg <= "11111111";
        elsif rising_edge(anClk) then
            case currentDigitNumber is
                when "11" => seg <= font(to_integer(unsigned(d3))) & '1';
                when "10" => seg <= font(to_integer(unsigned(d2))) & '1';
                when "01" => seg <= font(to_integer(unsigned(d1))) & '1';
                when "00" => seg <= font(to_integer(unsigned(d0))) & '1';
                when others => seg <= "11111111";
            end case;
        end if;
    end process;

	process(rst, anClk)
		
	begin
        if rst='1' then
            currentDigitNumber <= "00";
        elsif rising_edge(anClk) then
            currentDigitNumber <= std_logic_vector(to_unsigned(to_integer(unsigned(currentDigitNumber )) + 1, 2));
        end if;
	end process;
    
    
    process(rst, clk)
        
    begin
        if rst='1' then
            an <= "1000";
        elsif rising_edge(clk) then
            case currentDigitNumber is
                when "00" => an <= "1000";
                when "01" => an <= "0100";
                when "10" => an <= "0010";
                when others => an <= "0001";
            end case;
        end if;
    
    end process;

end Behavioral;

