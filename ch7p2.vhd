library IEEE;
use IEEE.std_logic_1164.all;


entity ckt_rtl is
   port 
    (
      D1_IN, D2_IN,  D3_IN : in std_logic_vector(7 downto 0);     --These are the 8-bit "INPUTS" of the MULTIPLEXER (X, Y, Z) 
      DS  : in std_logic;                                      --This is the "INPUT" of the DECODER
      CLK  : in std_logic;                                          
      MS : in std_logic_vector(1 downto 0);                     --This is the "SEL" of the MULTIPLEXER
      RA_O,  RB_O : out std_logic_vector(7 downto 0)            --These are the "OUTPUTS" of the REGISTERS
      
    );
end ckt_rtl;


architecture rtl_behavioral of ckt_rtl is
 

      signal s_mux_result : std_logic_vector(7 downto 0);       --TEMPORARY  output of the MULTIPLEXER
      signal DC_OUT :  std_logic_vector(1 downto 0);            --TEMPORARY output of the DECODER
      signal REG_B  : std_logic_vector(7 downto 0);             --TEMPORARY output of REGISTER-B
      signal    REG_A   : std_logic_vector(7 downto 0);          --TEMPORARY output of REGISTER-A
     
    
      begin
              with MS select                    --Here we use SELECTED-SIGNAL-ASSIGNMENT for the MULTIPLEXER
              s_mux_result  <=
                          D1_IN when "00",
                          D2_IN when "01",
                          D2_IN when "10",
                          REG_B when "11",
                      (others => '0') when others;          --Althought this line is not necessary we need it as good practice
    
---------------------------------------------------------------------
          
              with DS select                    --Here we use SELECTED-SIGNAL-ASSIGNMENT as well for the DECODER
              DC_OUT <=
                      "01" when '1',
                      "10" when '0',
                          "00" when others;         --This line is added for good practice (done to avoid bugs)
        
---------------------------------------------------------------------              
             ra: process(CLK) -- process
                      begin
                           if (falling_edge(CLK)) then          --This is the CLOCK "INPUT"
                                 if (DC_OUT(0) = '1') then          --When the DECODER output activates the REGISTER-A
                                 REG_A <= s_mux_result;                     --REGISTER-A is set up
                                 --remember that REG_A is the same as the output of the "Register_A"
                                  end if;
                           end if;
             end process;
---------------------------------------------------------------------

             rb: process(CLK) -- process
                      begin
                          if (falling_edge(CLK)) then            --For REGISTERS we work with "CLOCKS" 
                                if (DC_OUT(1) = '1') then           --This just means if the output of the DECODER being HIGH is TRUE
                                     REG_B <= REG_A;                --Here REGISTER-B is set up.
                                 end if;
                         end if;
            end process;
        
        
       RA_O <= REG_A ;      --Here we just connect the "TEMPORARIES" to the "ENTITY-OUTPUTS"
       RB_O <= REG_B ; 
        
--Remember that we have to draw the the actual outputs, or VIVADO won't 
--recognize what we're trying to draw                
      
  
-- Notice that the "01" and "10" is the output label and not the high or low "1" and "0"

end rtl_behavioral;

--Notice that we declared a detailed signal for the registers inputs. Also, notice that for the multiplexer we have to do
--a more detailed code compared to the one we did in the Synthesis_lab. In this case we specified the 1's and 0's
--Also, notice that although its only 2 inputs for the multiplexer, we use bundles (8) for each one.
