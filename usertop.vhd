-- Faz a conexão entre o controle e o datapath.

library IEEE;
use IEEE.Std_Logic_1164.all;

entity usertop is
port (
    CLK_500Hz: in std_logic; -- para uso no emulador
    CLK_1Hz: in std_logic; -- para uso no emulador
    KEY: in std_logic_vector(3 downto 0); -- Botões
    SW: in std_logic_vector(17 downto 0); -- Switches
    LEDR: out std_logic_vector(17 downto 0); -- LEDs de saída
    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7: out std_logic_vector(6 downto 0) -- Displays
);
end entity;

architecture arc of usertop is

component datapath is
port (
    SW: in std_logic_vector(9 downto 0);
    CLK_500Hz, CLK_1Hz: in std_logic;
    R1, R2, E1, E2, E3, E4, E5: in std_logic;
    sw_erro, end_game, end_time, end_round: out std_logic;
    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5: out std_logic_vector(6 downto 0);
    LEDR: out std_logic_vector(9 downto 0)
);
end component;

component controle is
port (
    BTN1, BTN0, clock_500: in std_logic;
    sw_erro, end_game, end_time, end_round: in std_logic;
    R1, R2, E1, E2, E3, E4, E5: out std_logic
);
end component;

component ButtonSync is
port (
    KEY0, KEY1, CLK: in std_logic;
    BTN0, BTN1: out std_logic
);
end component;

-- Sinais internos
signal R1, R2, E1, E2, E3, E4, E5: std_logic; -- Sinais de controle
signal sw_erro, end_game, end_time, end_round: std_logic; -- Sinais de status
signal btn0, btn1: std_logic; -- Botões sincronizados

begin

-- Instância do datapath
PM_datapath: datapath port map(
    SW => SW(9 downto 0),
    CLK_500Hz => CLK_500Hz, -- CLOCK_50 na placa e CLK_500Hz no emulador
    CLK_1Hz => CLK_1Hz, -- Clock para uso no emulador
    R1 => R1,
    R2 => R2,
    E1 => E1,
    E2 => E2,
    E3 => E3,
    E4 => E4,
    E5 => E5,
    sw_erro => sw_erro,
    end_game => end_game,
    end_time => end_time,
    end_round => end_round,
    HEX0 => HEX0,
    HEX1 => HEX1,
    HEX2 => HEX2,
    HEX3 => HEX3,
    HEX4 => HEX4,
    HEX5 => HEX5,
    LEDR => LEDR(9 downto 0)
);

-- Instância do controle
PM_controle: controle port map(
    BTN1 => btn1,
    BTN0 => btn0,
    clock_500 => CLK_500Hz, -- CLOCK_50 na placa e CLK_500Hz no emulador
    sw_erro => sw_erro,
    end_game => end_game,
    end_time => end_time,
    end_round => end_round,
    R1 => R1,
    R2 => R2,
    E1 => E1,
    E2 => E2,
    E3 => E3,
    E4 => E4,
    E5 => E5
);

-- Instância do ButtonSync
PM_ButtonSync: ButtonSync port map(
												KEY0 => KEY(0), 
												KEY1 => KEY(1), 
												CLK => CLK_500Hz, -- CLOCK_50 na placa e CLK_500Hz no emulador
												BTN0 => btn0,
												BTN1 => btn1
);
end architecture;
