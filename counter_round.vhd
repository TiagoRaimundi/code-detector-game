library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Counter_round is
port( R: in std_logic;
	  E: in std_logic;
	  clock: in std_logic;
	  end_round: out std_logic;
	  conta_round: out std_logic_vector(3 downto 0)

    );
end Counter_round;

architecture circuito of Counter_round is
signal valor: std_logic_vector(3 downto 0);
begin
    P1: process(clock, R)
    begin
        if R='1' then
            valor <= "0000"; -- De 0
            end_round <= '0';
        elsif clock'event and clock= '1' then
			if E='1' then
                if valor = "1010" then -- Até 10
                    end_round <= '1';
                else valor <= valor + 1;
                end if;
            end if;
        end if;
    end process;
    conta_round <= valor;
end circuito;
