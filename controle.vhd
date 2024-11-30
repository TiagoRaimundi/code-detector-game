library ieee;
use ieee.std_logic_1164.all;

entity controle is 
	port (
		BTN1: in std_logic;
		BTN0: in std_logic;
		clock_500: in std_logic;
		end_game: in std_logic;
		end_round: in std_logic;
		R1, R2, E1, E2, E3, E4, E5: out std_logic

	);
	end entity;


architecture arc of controle is 
	type State is (Init, Setup, Play, Count_Round, Check, Result);
	signal EstadoAtual, ProximoEstado: State := Init;
	begin


REG: process(clock_500, BTN0)
begin 
	if BTN0 = '0' then
		EstadoAtual <= Init;
	elsif clock_500'event and CLOCK_500 = '1' then
		EstadoAtual <= ProximoEstado;
	end if;
end process;

CMB: process(EstadoAtual, BTN1, sw_erro, end_game, end_time, end_round)
begin
	R1 <= '0'; R2 <= '0';
	E1 <= '0'; E2 <= '0'; E3 <= '0'; E4 <= '0'; E5 <= '0';

	case EstadoAtual is
		when Init =>
			R1 <= '1';
			R2 <= '1';
			E1 <= '0';
			E2 <= '0';
			E3 <= '0';
            E4 <= '0';
            E5 <= '0';

			if BTN1 = '0' then 
				ProximoEstado <= Setup;
			else 
				ProximoEstado <= Init;
			end if;
			
		when Setup =>
			R1 <= '0';
			R2 <= '0';
			E1 <= '1';
			E2 <= '0';
            E3 <= '0';
            E4 <= '0';
            E5 <= '0';

			if BTN1 = '0' then
				ProximoEstado <= Waits;
			else
				ProximoEstado <= Setup;
			end if;



			when Play =>
			R1 <= '0';
            R2 <= '0';
            E1 <= '0';
            E2 <= '1';
            E3 <= '0';
            E4 <= '0';
            E5 <= '0';
			if end_time
