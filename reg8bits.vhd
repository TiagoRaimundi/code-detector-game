library ieee;
use ieee.std_logic_1164.all;

entity reg8bits is
    port (
        CLK, RST, enable: in std_logic;                 
        D: in std_logic_vector(7 downto 0);             
        Q: out std_logic_vector(7 downto 0)        
    );
end entity reg8bits;

architecture Behavioral of reg8bits is
    signal data: std_logic_vector(7 downto 0) := "00000000"; 
begin
    process(CLK, RST)
    begin
        if RST = '1' then
            data <= "00000000"; 
        elsif CLK = '1' and CLK'event then
            if enable = '1' then
                data <= D; 
            end if;
        end if;
    end process;

    Q <= data; 
end architecture Behavioral;
