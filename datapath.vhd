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
	port (	    clk: in std_logic;
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

component mux2pra1_4bits is
port(
    sel: in std_logic;
	x, y: in std_logic_vector(3 downto 0);
	saida: out std_logic_vector(3 downto 0)
    );
end component;

component mux2pra1_7bits is
port (sel: in std_logic;
		x, y: in std_logic_vector(6 downto 0);
		saida: out std_logic_vector(6 downto 0)
);
end component;

component mux2pra1_8bits is
port(
    sel: in std_logic;
	x, y: in std_logic_vector(7 downto 0);
	saida: out std_logic_vector(7 downto 0)
    );
end component;

component mux2pra1_10bits is
port(
    sel: in std_logic;
	x, y: in std_logic_vector(9 downto 0);
	saida: out std_logic_vector(9 downto 0)
    );
end component;

----------------------DECODIFICADOR-----------------------------

component decod7seg is
port(
    X: in std_logic_vector(3 downto 0);
    Y: out std_logic_vector(6 downto 0)
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
signal Round, Level_time, Level_code, SaidaCountT,Tempo, SomaDigitada, SomaSelDig, CounterTMux: std_logic_vector(3 downto 0); -- 4 bits
signal decMuxCode, decMuxRound, muxMux2, muxMux3, decMux4, t, r, n: std_logic_vector(6 downto 0); -- 7 bits
signal SomaSelDig_estendido,SeqLevel, RegFinal, valorfin_vector, MuxSelDig: std_logic_vector(7 downto 0); -- 8 bits
signal N_unsigned: unsigned(3 downto 0);
signal SeqDigitada, ComparaSelDig, SelecionadaROM, EntradaLEDS: std_logic_vector(9 downto 0); -- 10 bits
signal reg1_output: std_logic_vector(7 downto 0);
signal reg2_output: std_logic_vector(9 downto 0);

begin


--DIV: Div_Freq 
--port map (CLOCK_50, R2, clk_1); -- Para teste no emulador, comentar essa linha e usar o CLK_1Hz

------------------------CONTADORES------------------------------

timer : Counter_time 
port map (  
      R => R1 ,
	  E => E2 ,
	  clock => clk_1 ,
	  end_time => end_time , 
	  tempo => Tempo ,
	  load => Level_time
	  );


Dut : Counter_round
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

---------------------MULTIPLEXADORES----------------------------

-- a fazer pel@ alun@

-------------------COMPARADORES E SOMA--------------------------

-- a fazer pel@ alun@
        
---------------------DECODIFICADORES----------------------------

-- a fazer pel@ alun@
        
---------------------ATRIBUICOES DIRETAS---------------------

-- a fazer pel@ alun@

end arc;