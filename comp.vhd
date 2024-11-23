library ieee;
use ieee.std_logic_1164.all;

entity comp is
port (
    seq_user: in std_logic_vector(9 downto 0);  
    seq_reg: in std_logic_vector(9 downto 0); 
    seq_mask: out std_logic_vector(9 downto 0) 
);
end entity comp;

architecture Behavioral of comp is
begin
    process(seq_user, seq_reg)
    begin
        seq_mask <= seq_user xor seq_reg; 
    end process;
end architecture Behavioral;
