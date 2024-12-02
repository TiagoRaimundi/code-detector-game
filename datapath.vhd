library ieee;
use ieee.std_logic_1164.all;

entity controle is
port (
    BTN1: in std_logic; -- Bot�o Enter
    BTN0: in std_logic; -- Bot�o Reset
    CLOCK_50: in std_logic; -- Clock de 500 Hz
    sw_erro: in std_logic;
    end_game: in std_logic; 
    end_time: in std_logic;
    end_round: in std_logic;
    R1, R2, E1, E2, E3, E4, E5: out std_logic 
);
end entity;

architecture arc of controle is
    type State is (Init, Setup, Play, Count_Round, Check, Waits, Result);
    signal EstadoAtual, ProximoEstado: State := Init; -- Estado atual e próximo
begin


REG: process(CLOCK_50, BTN0)
begin
            if BTN0= '0' then	
				EstadoAtual <= Init;
			elsif CLOCK_50'event and CLOCK_50= '1' then
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
                ProximoEstado <= Play; 
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
            if end_time = '1' then
                ProximoEstado <= Result;
            elsif BTN1 = '0' then
                ProximoEstado <= Count_Round; 
            else
                ProximoEstado <= Play; 
            end if;

        when Count_Round =>
            R1 <= '0';
            R2 <= '0';
            E1 <= '0';
            E2 <= '0';
            E3 <= '1';
            E4 <= '0';
            E5 <= '0';
            ProximoEstado <= Check;

        when Check =>
            R1 <= '0';
            R2 <= '0';
            E1 <= '0';
            E2 <= '0';
            E3 <= '0';
            E4 <= '1';
            E5 <= '0';
            
            if sw_erro = '1' then
            
            ProximoEstado <= Result;
            
            elsif end_round = '1' then
                ProximoEstado <= Result;
            elsif end_game = '1' then
                ProximoEstado <= Result; 
            else
                ProximoEstado <= Waits; 
            end if;

        when Waits =>
            R1 <= '1'; 
            R2 <= '0';
            E1 <= '0';
            E2 <= '0'; 
            E3 <= '0';
            E4 <= '0';
            E5 <= '0';
            if BTN1 = '0' then
                ProximoEstado <= Play; 
            else
                ProximoEstado <= Waits; 
            end if;

        when Result =>
            R1 <= '0';
            R2 <= '0';
            E1 <= '0';
            E2 <= '0';
            E3 <= '0';
            E4 <= '0';
            E5 <= '1';
            
            if BTN1 = '0' then
                ProximoEstado <= Init; 
            else
                ProximoEstado <= Result; 
            end if;

        when others =>
            ProximoEstado <= Init;
    end case;
end process;

end architecture;
