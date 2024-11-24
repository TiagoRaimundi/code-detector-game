library ieee;
use ieee.std_logic_1164.all;

entity comp4 is
    port (
        soma: in std_logic_vector(3 downto 0); -- Entrada de 4 bits
        status: out std_logic                -- Saída do status (erro)
    );
end entity comp4;

architecture Behavioral of comp4 is
begin
    process(soma)
    begin
        if soma = "0100" then               -- Compara se o valor de soma é igual a 4
            status <= '0';                  -- Status desativado (sem erro)
        else
            status <= '1';                  -- Status ativado (erro)
        end if;
    end process;
end architecture Behavioral;
