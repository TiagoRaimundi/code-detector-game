library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity soma is
    port(
        seq: in std_logic_vector(9 downto 0); -- Vetor de entrada
        soma_out: out std_logic_vector(3 downto 0) -- Soma dos bits '1'
    );
end entity;

architecture Behavioral of soma is
signal soma1 , soma2 , soma3 , soma4 ,soma5 , soma6 ,soma7 ,soma8 , soma9 , soma10 : std_logic_vector(3 downto 0);
signal tot : unsigned(3 downto 0);
begin
    soma1 <= "000" & seq(0);
    soma2 <= "000" & seq(1);
    soma3 <= "000" & seq(2);
    soma4 <= "000" & seq(3);
    soma5 <= "000" & seq(4);
    soma6 <= "000" & seq(5);
    soma7 <= "000" & seq(6);
    soma8 <= "000" & seq(7);
    soma9 <= "000" & seq(8);
    soma10 <= "000" & seq(9);
    tot <= unsigned(soma1) +  unsigned(soma2) +  unsigned(soma3) +  unsigned(soma4) +  unsigned(soma5) +  unsigned(soma6) +  unsigned(soma7) +  unsigned(soma8) +  unsigned(soma9) +  unsigned(soma10); 

    soma_out <= std_logic_vector(tot);
end architecture Behavioral;
