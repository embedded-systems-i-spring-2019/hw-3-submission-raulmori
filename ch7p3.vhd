library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity #2

entity ex2 is 
    Port 
   (
    
    CLK, S0, S1, LDA, LDB  : in std_logic;
          X, Y : in std_logic_vector (7 downto 0);
          OUTPUT : out std_logic_vector (7 downto 0)
          
         );
end ex2;

-- Architecture #2

architecture my_ex2 of ex2 is
    signal MUX_OUT1, MUX_OUT2 : std_logic_vector (7 downto 0); --remember the 7 to 0 means "8-bits"
    signal RBtemp, RAtemp: std_logic_vector (7 downto 0);
--These are our temporary signals (interchangeable signals)

begin

--1st Mux
     with S1 select
         MUX_OUT1  <= X when '1',
                 RBtemp when '0',
                 (others => '0') when others;
               
--2nd Mux
            
     with S0 select
         MUX_OUT2  <= 
                  RAtemp when '1',
                  Y when '0',
                         (others => '0') when others;


regA: process (CLK)
begin
    if (CLK'event and CLK = '1')  --The "1" represents rising edge
        then if (LDA = '1') then
            RAtemp <= MUX_OUT1;
        end if;
    end if;
end process;


 regB: process (CLK)
begin
    if (CLK'event and CLK = '1') --The "1" represents rising edge
        then if (LDB = '1') then
            RBtemp <= MUX_OUT2;
        end if;
    end if;
end process;


OUTPUT <= Rbtemp;


end my_ex2;
