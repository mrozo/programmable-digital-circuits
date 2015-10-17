LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY displayDriverTB IS
END displayDriverTB;
 
ARCHITECTURE behavior OF displayDriverTB IS 
 
 
    COMPONENT displayDriver
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         d0 : IN  std_logic_vector(3 downto 0);
         d1 : IN  std_logic_vector(3 downto 0);
         d2 : IN  std_logic_vector(3 downto 0);
         d3 : IN  std_logic_vector(3 downto 0);
         seg : OUT  std_logic_vector(7 downto 0);
         an : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';
   signal d0 : std_logic_vector(3 downto 0) := (others => '0');
   signal d1 : std_logic_vector(3 downto 0) := (others => '0');
   signal d2 : std_logic_vector(3 downto 0) := (others => '0');
   signal d3 : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal seg : std_logic_vector(7 downto 0);
   signal an : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20ns;
 
BEGIN
	clk <= not clk after (clk_period/2);
 
	-- Instantiate the Unit Under Test (UUT)
   uut: displayDriver PORT MAP (
          rst => rst,
          clk => clk,
          d0 => d0,
          d1 => d1,
          d2 => d2,
          d3 => d3,
          seg => seg,
          an => an
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100ms.
      wait for 100ms;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
