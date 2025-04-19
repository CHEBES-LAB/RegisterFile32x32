--------------------------------------------------------------------------------
-- Company: Chebe's Lab
-- Engineer: Edgar Nyandoro
-- Create Date: 2025/04/20 00:14:00
-- Design Name: Register32x32
---------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Register32x32 is
    Port ( CLK : in STD_LOGIC;
           EN : in STD_LOGIC;
           WR_EN : in STD_LOGIC;
           D_IN : in STD_LOGIC_VECTOR (31 downto 0);
           D_OUT_1 : out STD_LOGIC_VECTOR (31 downto 0);
           D_OUT_2 : out STD_LOGIC_VECTOR (31 downto 0);
           ADDR : in STD_LOGIC_VECTOR (4 downto 0);
           RD_SEL_1 : in STD_LOGIC_VECTOR (4 downto 0);
           RD_SEL_2 : in STD_LOGIC_VECTOR (4 downto 0));
end Register32x32;

architecture Behavioral of Register32x32 is
    type reg_array is array (0 to 31) of STD_LOGIC_VECTOR (31 downto 0);
    signal registers : reg_array;
    signal STARTUP : boolean := true;

begin
    process(CLK, EN, WR_EN)
    begin
        -- if STARTUP=true then
        --     registers <= (  0 => X"0000010f",
        --                     1 => X"00110100",
        --                     2 => X"00000110",
        --                     3 => X"00011000",
        --                     others => (others => '0'));
        --     D_OUT_1 <= (others => 'X');
        --     D_OUT_2 <= (others => 'X');
        --     STARTUP <= false;
        -- end if; 
        if rising_edge(CLK) then
            if EN = '1' then
                if WR_EN = '1' then
                    registers(to_integer(unsigned(ADDR))) <= D_IN;
                end if;

                D_OUT_1 <= registers(to_integer(unsigned(RD_SEL_1)));
                D_OUT_2 <= registers(to_integer(unsigned(RD_SEL_2)));

            end if;
        end if;
    end process;
end Behavioral;