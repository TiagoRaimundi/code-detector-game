library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity decodRegM is
    port (
        Entrada: in std_logic_vector(3 downto 0);  
        HEX: out std_logic_vector(6 downto 0)  
    );
end decodRegM;

architecture struct of decodRegM is
    signal unid: std_logic_vector(3 downto 0);  
begin

  
    process (Entrada)
    begin
        case Entrada is
            when "0000" => HEX <= "1000000"; -- 0
            when "0001" => HEX <= "1111001"; -- 1
            when "0010" => HEX <= "0100100"; -- 2
            when "0011" => HEX <= "0110000"; -- 3
            when "0100" => HEX <= "0011001"; -- 4
            when "0101" => HEX <= "0010010"; -- 5
            when "0110" => HEX <= "0000010"; -- 6
            when "0111" => HEX <= "1111000"; -- 7
            when "1000" => HEX <= "0000000"; -- 8
            when "1001" => HEX <= "0010000"; -- 9
            when others => HEX <= "1111111"; -- Default (apagado)
        end case;
    end process;

end struct;