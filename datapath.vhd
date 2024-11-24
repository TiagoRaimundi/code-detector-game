-- Datapath, fazendo a conexao entre cada componente


library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity datapath is
port (
-- Entradas de dados
SW: in std_logic_vector(9 downto 0);
CLOCK_50, CLK_1Hz: in std_logic;
-- Sinais de controle
R1, R2, E1, E2, E3, E4, E5: in std_logic;
-- Sinais de status
sw_erro, end_game, end_time, end_round: out std_logic;
-- Saidas de dados
HEX0, HEX1, HEX2, HEX3, HEX4, HEX5: out std_logic_vector(6 downto 0);
LEDR: out std_logic_vector(9 downto 0)
);
end datapath;


architecture arc of datapath is
--============================================================--
--                      COMPONENTS                            --
--============================================================--
-------------------DIVISOR DE FREQUENCIA------------------------


component Div_Freq is
    port (      clk: in std_logic;
                reset: in std_logic;
                CLK_1Hz: out std_logic
            );
end component;


------------------------CONTADORES------------------------------


component counter_time is
port(R, E, clock: in std_logic;
        end_time: out std_logic;
        tempo: out std_logic_vector(3 downto 0);
        load: in std_logic_vector(3 downto 0)
        );
end component;


component counter_round is
port(R, E, clock: in std_logic;
        end_round: out std_logic;
        conta_round : out std_logic_vector(3 downto 0)
        );
end component;


-------------------ELEMENTOS DE MEMORIA-------------------------


component reg4bits is
port(
    CLK, RST, enable: in std_logic;
    D: in std_logic_vector(3 downto 0);
    Q: out std_logic_vector(3 downto 0)
    );
end component;


component reg8bits is
port (
    CLK, RST, enable: in std_logic;
    D: in std_logic_vector(7 downto 0);
    Q: out std_logic_vector(7 downto 0)
);
end component;


component reg10bits is
port(
    CLK, RST, enable: in std_logic;
    D: in std_logic_vector(9 downto 0);
    Q: out std_logic_vector(9 downto 0)
    );
end component;


component ROM is
port(
    address : in std_logic_vector(3 downto 0);
    data : out std_logic_vector(9 downto 0)
    );
end component;


---------------------MULTIPLEXADORES----------------------------
component mux4 is
port(
    seletor: in std_logic;
    entrada0, entrada1: in std_logic_vector(3 downto 0);
    saida: out std_logic_vector(3 downto 0)
    );
end component;


component mux2pra1_8bits is
port (sel: in std_logic;
        x, y: in std_logic_vector(7 downto 0);
        saida: out std_logic_vector(7 downto 0)
);
end component;


component mux7 is
    port(
        seletor: in std_logic;
        entrada0, entrada1: in std_logic_vector(6 downto 0);
        saida: out std_logic_vector(6 downto 0)
        );
    end component;


component muxLevelCode is
    port(
        seletor: in std_logic;
        entrada0, entrada1: in std_logic_vector(6 downto 0);
        saida: out std_logic_vector(6 downto 0)
        );
    end component;


component muxhex5 is
    port(
        seletor: in std_logic;
        entrada0, entrada1: in std_logic_vector(6 downto 0);
        saida: out std_logic_vector(6 downto 0)
        );
    end component;




component muxhex4 is
    port(
        seletor: in std_logic;
        
           entrada0, entrada1: in std_logic_vector(6 downto 0);
        saida: out std_logic_vector(6 downto 0)
        );
    end component;


component muxhex3 is
    port(
        seletor: in std_logic;
        entrada0, entrada1: in std_logic_vector(6 downto 0);
        saida: out std_logic_vector(6 downto 0)
        );
    end component;


component muxhex2 is
    port(
        seletor: in std_logic;
        entrada0, entrada1: in std_logic_vector(6 downto 0);
        saida: out std_logic_vector(6 downto 0)
        );
    end component;


component mux10 is
    port(
        seletor: in std_logic;
        entrada0, entrada1: in std_logic_vector(9 downto 0);
        saida: out std_logic_vector(9 downto 0)
        );
    end component;


----------------------DECODIFICADOR-----------------------------


component decodLevel is
port(
    Entrada: in std_logic_vector(3 downto 0);
    HEX: out std_logic_vector(6 downto 0)
    );
end component;


component decodRound is
port(
    Entrada: in std_logic_vector(3 downto 0);
    HEX: out std_logic_vector(6 downto 0)
    );
end component;


component decodRegL is
port(
    Entrada: in std_logic_vector(3 downto 0);
    HEX: out std_logic_vector(6 downto 0)
    );
end component;


component decodRegM is
port(
    Entrada: in std_logic_vector(3 downto 0);
    HEX: out std_logic_vector(6 downto 0)
    );
end component;


component decodTime is
port(
    Entrada: in std_logic_vector(3 downto 0);
    HEX: out std_logic_vector(6 downto 0)
    );
end component;


-------------------COMPARADORES E SOMA--------------------------


component comp is
    port (
        seq_user: in std_logic_vector(9 downto 0);
        seq_reg: in std_logic_vector(9 downto 0);
        seq_mask: out std_logic_vector(9 downto 0)
        );
    end component;


    component comp_igual4 is
        port(
            soma: in std_logic_vector(3 downto 0);
            status: out std_logic
            );
        end component;

component soma is
    port(
        seq: in std_logic_vector(9 downto 0);
        soma_out: out std_logic_vector(3 downto 0)
        );
    end component;

   
--============================================================--
--                      SIGNALS                               --
--============================================================--


signal selMux23, selMux45, end_game_interno, end_round_interno, clk_1, enableRegFinal: std_logic; --1 bit
signal Round, Level_time, Level_code, SaidaCountT,Tempo, SomaDigitada, SomaSelDig , timermux_dec : std_logic_vector(3 downto 0); -- 4 bits
signal t, r, n , mux_muxh3 , dec_muxh4 , decLevel_mux , muxLevel_muxh2, decRound_muxh2: std_logic_vector(6 downto 0); -- 7 bits
signal SomaSelDig_estendido,SeqLevel, RegFinal, valorfin_vector, MuxSelDig: std_logic_vector(7 downto 0); -- 8 bits
signal N_unsigned: unsigned(3 downto 0);
signal SeqDigitada, ComparaSelDig, SelecionadaROM, EntradaLEDS: std_logic_vector(9 downto 0); -- 10 bits
signal reg1_output: std_logic_vector(7 downto 0);
signal reg2_output: std_logic_vector(9 downto 0);
signal rom_data : std_logic_vector(9 downto 0); -- SaÃ­da da ROM (10 bits)
signal soma_out : std_logic_vector(3 downto 0);

signal seletor_mux_hex5: std_logic;
signal seletor_mux_hex3e2: std_logic;


begin

    seletor_mux_hex5 <= E1 or E2;
    seletor_mux_hex3e2 <= R1 xor R2;


--DIV: Div_Freq
--port map (CLOCK_50, R2, clk_1); -- Para teste no emulador, comentar essa linha e usar o CLK_1Hz


------------------------CONTADORES------------------------------


DUT_timer : Counter_time
port map (  
      R => R1 ,
      E => E2 ,
      clock => clk_1 ,
      end_time => end_time ,
      tempo => Tempo ,
      load => Level_time
      );
DUT_round : Counter_round
port map (
      R => R2 ,
      E => E3 ,
      clock => CLOCK_50 ,
      end_round => end_round ,
      conta_round => Round
);


--Registradores


Reg1 : reg8bits
port map (
    CLK => CLOCK_50,        
    RST => R2,              
    enable => E1,          
    D => SW(7 downto 0),    
    Q => reg1_output        
);


Level_time <= reg1_output(7 downto 4); -- Bits mais significativos (MSB)
Level_code <= reg1_output(3 downto 0); -- Bits menos significativos (LSB)


Reg2 : reg10bits
port map (
    CLK => CLOCK_50,        
    RST => R2,              
    enable => E1,          
    D => SW(9 downto 0),    
    Q => reg2_output
);


-------------------ELEMENTOS DE MEMORIA-------------------------


-- a fazer pel@ alun@


-- InstÃ¢ncia da ROM
ROM_inst : ROM
port map (
   address => Level_code, -- Conecta os 4 bits do Level_code ao endereÃ§o da ROM
    data  => rom_data    -- Saida da ROM conectada ao sinal rom_data
);

---------------------MULTIPLEXADORES----------------------------
-- a fazer pel@ alun@

DUT_mux4 : mux4
 port map(
    entrada0 => Level_time,
    entrada1 => Tempo,
    seletor => E2,
    saida => timermux_dec
);


DUT_mux7 : mux7
 port map(
    entrada0 => "1111111",
    entrada1 => n,
    seletor => E1,
    saida => mux_muxh3
);


DUT_muxLevel : muxLevelCode
 port map(
    entrada0 => "1111111",
    entrada1 => decLevel_mux,
    seletor => E1,
    saida => muxLevel_muxh2
);


DUT_hex5 : muxhex5
port map(
    entrada0 => "1111111",
    entrada1 => t,
    seletor  => seletor_mux_hex3e2,
    saida    => HEX5
);

DUT_hex3 : muxhex5
port map(
    entrada0 => "1111111",
    entrada1 => t,
    seletor  => seletor_mux_hex3e2,
    saida    => HEX3
);


DUT_hex2 : muxhex2
 port map(
    entrada0 => muxLevel_muxh2,
    entrada1 => decRound_muxh2,
    seletor => seletor_mux_hex3e2,
    saida => HEX2
);


DUT_mux10 : mux10
 port map(
    entrada0 => "0000000000",
    entrada1 => rom_data,
    seletor => E5,
    saida => LEDR(9 downto 0)
);

-------------------COMPARADORES E SOMA--------------------------
comp_igual10 : comp
port map (
    seq_user => reg2_output, -- Sequência do registrador de 10 bits (digitada pelo usuário)
    seq_reg  => rom_data,    -- Sequência da ROM
    seq_mask => SeqDigitada  
);

soma_inst: soma
port map (
    seq => reg2_output,   -- Entrada de 10 bits, conectada ao registrador de 10 bits
    soma_out => SomaDigitada -- Saída de 4 bits, conectada ao sinal SomaDigitada
);

compigual4: comp_igual4
port map (
    soma => soma_out, 
    status => sw_erro       
);
-- a fazer pel@ alun@
----------------DECODIFICADORES----------------------------
DUT_decodLevel : decodLevel
 port map(
    Entrada => Level_code,
    HEX => decLevel_mux
);
       
DUT_decodRound : decodRound
 port map(
    Entrada => Round,
    HEX => decRound_muxh2
);
       

DUT_decodTime : decodTime
 port map(
    Entrada => timermux_dec,
    HEX => dec_muxh4
);
       
---------------------ATRIBUICOES DIRETAS---------------------


-- a fazer pel@ alun@


end arc;