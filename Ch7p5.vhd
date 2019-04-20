 LIBRARY ieee; 
USE ieee.std_logic_1164.all;  

entity Circuit is  
     port( 
            A,B,C : in std_logic_vector(7 downto 0);              --These represent the multiple-bit "INPUTS"
            SL1, SL2, CLK : in std_logic;                        --These represent 1-bit "INPUTS"   
            RBX,RAX :out std_logic_vector(7 downto 0)           --These represent the multiple-bit "OUTPUTS"
);  
end Circuit;

architecture behavioural of Circuit is

        signal mux_out : std_logic_vector(7 downto 0);          --
        signal DC_OUT :  std_logic_vector(1 downto 0);            --TEMPORARY output of the DECODER
        
        begin  
             with SL2 select                        --Notice here that we use SELECTED-SIGNAL-ASSIGNMENT to make the MULTIPLEXER
             mux_out <= C when '0',
                         B when '1',    
                         "00000000" when others;
---------------------------------------------------------------------
                    
             with SL1 select                    --Here we use SELECTED-SIGNAL-ASSIGNMENT as well for the DECODER
               DC_OUT <=
                       "01" when '1',
                       "10" when '0',
                           "00" when others;         --This line is added for good practice (done to avoid bugs)
---------- -----------------------------------------------------------
              
            reg1: process(CLK)                      --This is PROCESS for "REGISTER-A"
              begin
                  if(rising_edge(CLK)) then
                      if (DC_OUT(0) = '1') then
                          RAX <= A;    
                      end if;
                  end if;
              end process;
 ---------------------------------------------------------------------
      
            reg2: process(CLK)                      --This is PROCESS for "REGISTER-B"
              begin
                  if(rising_edge(CLK)) then
                      if(DC_OUT(1) = '1') then
                          RBX <= mux_out;
                      end if;
                  end if;
              end process;
end behavioural;  
