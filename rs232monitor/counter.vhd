library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity counter is
	 Generic (
		width        : integer                     := 8
	 );
    Port ( 
		rst          : in  STD_LOGIC;
      clk          : in  STD_LOGIC;
		clear        : in  STD_LOGIC;
      state        : out STD_LOGIC_VECTOR ((width-1) downto 0)       
                                                 := (others => '0')
		);
end counter;

architecture Behavioral of counter is
		signal internalState : STD_LOGIC_VECTOR ((width-1) downto 0)
		                                           := (others => '0');
begin

	process(rst, clear, clk)
	
	begin
		if(rst='1') then
			state <= (others => '0');
			internalState <= (others => '0');
		elsif(rising_edge(clk)) then
			if(clear='1') then
				state <= (others => '0');
				internalState <= (others => '0');
			else
				state <= internalState;
				internalState <= std_logic_vector(unsigned(internalState) + 1);
			end if;
		end if;
		
	end process;

end Behavioral;

