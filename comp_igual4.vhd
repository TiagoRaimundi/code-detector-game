library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- Para operações com números inteiros

entity comp_igual4 is
    port (
        soma   : in std_logic_vector(3 downto 0); -- Vetor de entrada com a soma dos bits '1'
        status : out std_logic                   -- Sinal de status: '1' se soma = 4, caso contrário '0'
    );
end entity;

architecture Behavioral of comp_igual4 is
begin
    process (soma)
    begin
        if unsigned(soma) = 4 then
            status <= '1'; -- Ativa o status se soma é igual a 4
        else
            status <= '0'; -- Caso contrário, desativa
        end if;
    end process;
end Behavioral;
