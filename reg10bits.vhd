library ieee;
use ieee.std_logic_1164.all;

entity reg10bits is
    port (
        CLK, RST, enable: in std_logic;                 
        D: in std_logic_vector(9 downto 0);             
        Q: out std_logic_vector(9 downto 0)        
    );
end entity reg10bits;

architecture Behavioral of reg10bits is
    signal data: std_logic_vector(9 downto 0) := "0000000000"; 
begin
    process(CLK, RST)
    begin
        if RST = '1' then
            data <= "0000000000"; 
        elsif CLK = '1' and CLK'event then
            if enable = '1' then
                data <= D; 
            end if;
        end if;
    end process;

    Q <= data; 
end architecture Behavioral;
