
library IEEE;                 -- library declaration
use IEEE.std_logic_1164.all;



entity ckt_rtl is       --This is the entity
       port 
        (
              D1_IN,D2_IN : in std_logic_vector(7 downto 0);
              CLK,SEL : in std_logic;
              LDA : in std_logic;
              REG_A : out std_logic_vector(7 downto 0)
        );
end ckt_rtl;
--Notice the only signals not declared here the inputs of the two registers (the output of the multiplexer)

architecture rtl_behavioral of ckt_rtl is
 
      signal s_mux_result : std_logic_vector(7 downto 0);     -- intermediate signal declaration ---------------
      
      begin     
             ra: process(CLK)        -- Here we create a mux process and use a clock to make it work in loop
                  begin
                      if (rising_edge(CLK)) then 
                            if (LDA = '1') then
                            REG_A <= s_mux_result;
                            end if;
                  end if;
                 end process;
            
            
             with SEL select                         --this is where the multiplexer building starts
                     s_mux_result  <= D1_IN when '1',
                                  D2_IN when '0',
                                  (others => '0') when others;
end rtl_behavioral;

--Notice that we declared a detailed signal for the registers inputs. Also, notice that for the multiplexer we have to do
--a more detailed code compared to the one we did in the Synthesis_lab. In this case we specified the 1's and 0's
--Also, notice that although its only 2 inputs for the multiplexer, we use bundles (8) for each one.
