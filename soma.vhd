library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity soma4 is
    port (
        bits_in: in std_logic_vector(9 downto 0); -- Entrada de 10 bits
        count_out: out std_logic_vector(3 downto 0) -- Saída com a contagem (4 bits)
    );
end entity;

architecture Behavioral of soma4 is
    signal count: unsigned(3 downto 0) := (others => '0'); -- Contador interno
begin
    process(bits_in)
    begin
        count <= (others => '0'); -- Zera o contador
        for i in bits_in' range loop
            if bits_in(i) = '1' then
                count <= count + 1; -- Incrementa para cada bit "1"
            end if;
        end loop;
        count_out <= std_logic_vector(count); -- Atribui o valor final ao sinal de saída
    end process;
end architecture;
