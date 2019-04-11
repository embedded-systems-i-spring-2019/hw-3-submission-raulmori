-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;


entity ckt_rtl is
   port 
    (
      D1_IN,D2_IN, D3_IN : in std_logic_vector(7 downto 0);
      CLK, DS  : in std_logic;
      MS : in std_logic_vector(1 downto 0);
      RA_O,  RB_O : out std_logic_vector(7 downto 0)
      
    );
end ckt_rtl;
--Notice the only signals not declared here the inputs of the two registers (the output of the multiplexer)

-- architecture
architecture rtl_behavioral of ckt_rtl is
 
  -- intermediate signal declaration ---------------
  signal s_mux_result : std_logic_vector(7 downto 0);
  signal SZ_OUT :  std_logic_vector(1 downto 0);
  signal REG_B  : std_logic_vector(7 downto 0);
     signal    REG_A   : std_logic_vector(7 downto 0);
     
     --For this process to work we had to use temporary signals for interchangeable
     --inputs and outputs. Notice that the outputs on the ports are not temporary
      begin
      
          with MS select
          s_mux_result  <=
                      D1_IN when "00",
                      D2_IN when "01",
                      D2_IN when "10",
                      REG_B when "11",
                  (others => '0') when others;
  --(others => '0') is just an addon     
  
  
      with DS select
      SZ_OUT <=
          "01" when '1',
              "10" when '0',
            "00" when others;

      
         ra: process(CLK) -- process
          begin
              if (falling_edge(CLK)) then 
	      	    if (SZ_OUT(0) = '1') then
                REG_A <= s_mux_result;
                --remember that REG_A is the same as the output of the "Register_A"
              end if;
          end if;
        end process;
        
         rb: process(CLK) -- process
          begin
              if (falling_edge(CLK)) then 
	      	if (SZ_OUT(1) = '1') then
               	 REG_B <= REG_A;
              end if;
          end if;
        end process;
        
        
       RA_O <= REG_A ; 
        RB_O <= REG_B ; 
        
--Remember that we have to draw the the actual outputs, or VIVADO won't 
--recognize what we're trying to draw                
      
  
-- Notice that the "01" and "10" is the output label and not the high or low "1" and "0"

end rtl_behavioral;

--Notice that we declared a detailed signal for the registers inputs. Also, notice that for the multiplexer we have to do
--a more detailed code compared to the one we did in the Synthesis_lab. In this case we specified the 1's and 0's
--Also, notice that although its only 2 inputs for the multiplexer, we use bundles (8) for each one.
