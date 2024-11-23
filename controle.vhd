--Bloco de controle, tem a descrição de funcionamento da máquina de estados. Garante que tudo funciona como deve, saídas e transições de um estado para outro.

library ieee;
use ieee.std_logic_1164.all;

entity controle is
port
(
	BTN1, BTN0, clock_50: in std_logic;
	sw_erro, end_game, end_time, end_round: in std_logic;
	R1, R2, E1, E2, E3, E4, E5: out std_logic
);
end entity;

architecture arc of controle is
	type State is (Start, Setup, Play, Count_Round, Check, Waits, Result); --Aqui temos os estados
	signal EA, PE: State := Start; 						-- PE: proximo estado, EA: estado atual 

begin
-- FSM usando dois process a ser feito pel@ alun@
process (EA, BTN1, sw_erro, end_game, end_time, end_round)

begin
		R1 <='0'; R2 <= '0';
		E1 <= '0'; R2 <= '0'; E3 <= '0'; E4 <='0'; E5<= '0';

		case EA is
			when Start =>
				R1 <= '1'; R2 <='1';
				if BTN1 = '1' then
					PE<=Setup;
				else
					PE <=Start;
				end if;

				when Setup =>
					E1 <= '1';
					if BTN1 = '1' then
						PE <= Play;
					else
						PE <= Setup;
					end if;
				
					when Play =>
						E2 <= '1';
						if end_time = '1' then
							PE <= Result;
						elsif BTN1 = '1' then
							PE <= Count_Round;
						else
							PE <= Play;
						end if;

					when Count_Round =>
						E3 <= '1';
						PE <= Check;

					when Check =>
						if sw_erro = '1' then
							PE <= Result;
						elsif end_game = '1' or end_round = '1' then
							PE <= Result;
						elsif end_game = '1' or end_round = '1' then
							PE <= Result;
						else
							PE <= Waits;
						end if;
						
						when Waits =>
							E4 <= '1';
							if BTN1 = '1' then
								PE <= Play;
							else
								PE <= Waits;
							end if;
						when Result =>
							E5 <= '1';
							if BTN1 = '1' then
								PE <= Start;
							else
								PE <= Result;
							end if;
						when others => 
							PE <= Start;
end case;
end process;
end architecture;