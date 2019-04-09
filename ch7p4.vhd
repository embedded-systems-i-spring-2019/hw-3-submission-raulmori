library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ckt_rtl is 
    Port (    
          CLK, S0, S1, LDA, LDB, RD : in std_logic;
          X, Y : in std_logic_vector (7 downto 0);
          RB, RA : out std_logic_vector (7 downto 0) 
         );
end ckt_rtl;


architecture rtl_behavioral of ckt_rtl is       -- Architecture #2
        signal MUX_OUT1, MUX_OUT2 : std_logic_vector (7 downto 0); --remember the 7 to 0 means "8-bits"
        signal RBtemp, RAtemp: std_logic_vector (7 downto 0);   --These are our temporary signals (interchangeable signals)

        begin
             with S1 select             --1st Mux
                 MUX_OUT1  <= X when '1',
                                 Y when '0',
                                 (others => '0') when others;


             with S0 select         --2nd Mux
                 MUX_OUT2  <= 
                          RBtemp when '1',
                          Y when '0',
                                 (others => '0') when others;


        REGA: process (CLK) --Remember a flipflop is just memory it doesn't process information
            begin
                if (falling_edge(CLK)) then --The "1" represents rising edge
                     if ((RD and LDA) = '1') then
                         RAtemp <= MUX_OUT2;
                    end if;
                end if;
        end process;


        REGB: process (CLK)
            begin
                if (falling_edge(CLK)) --The "1" represents rising edge
                    then if (((not RD) and LDB) = '1') then
                          RBtemp <= MUX_OUT1;
                    end if;
                end if;
        end process;


        RA <= Ratemp;  --Remember that the Final outputs have to be declared at the end
        RB <= Rbtemp;


end rtl_behavioral;
