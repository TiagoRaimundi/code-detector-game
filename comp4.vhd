library ieee;
use ieee.std_logic_1164.all;

entity comp_igual4 is
    port (
        soma: in std_logic_vector(3 downto 0); -- Entrada de 4 bits
        status: out std_logic                -- Saída do status (erro)
    );
end entity comp_igual4;

architecture Behavioral of comp_igual4 is
begin
    process(soma)
    begin
        if soma = "0100" then              
            status <= '1';                 
        else
            status <= '0';                 
        end if;
    end process;
end architecture Behavioral;
