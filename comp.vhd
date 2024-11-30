library ieee;
use ieee.std_logic_1164.all;

entity comp is
port (
    seq_user: in std_logic_vector(9 downto 0);  -- Sequência do usuário
    seq_reg: in std_logic_vector(9 downto 0);  -- Sequência da ROM
    seq_acertos: out std_logic_vector(9 downto 0) -- Vetor de acertos
);
end entity comp;

architecture Behavioral of comp is
begin
    process(seq_user, seq_reg)
    begin
        -- Verifica onde os bits de ambos os vetores são '1'
        seq_acertos <= seq_user and seq_reg;
    end process;
end architecture Behavioral;
