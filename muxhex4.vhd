
library ieee;
use ieee.std_logic_1164.all;

entity muxhex4 is
    port(
        entrada0, entrada1: in std_logic_vector(6 downto 0);
        seletor: in std_logic;
        saida: out std_logic_vector(6 downto 0)
    );
end muxhex4;

architecture behavior of muxhex4 is
begin
    process(seletor, entrada0, entrada1)
    begin
        if seletor = '0' then
            saida <= entrada0;
        elsif seletor = '1' then
            saida <= entrada1;
        end if;
    end process;
end behavior;
