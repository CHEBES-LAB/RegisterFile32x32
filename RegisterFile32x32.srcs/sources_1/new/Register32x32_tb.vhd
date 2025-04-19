----------------------------------------------------------------------------------
-- Company: Chebe's Lab
-- Engineer: Edgar Nyandoro
-- Create Date: 20.04.2025 00:32:23
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity Register32x32_tb is
end Register32x32_tb;

architecture Behavioral of Register32x32_tb is
    signal CLK : std_logic := '0';
    signal EN : std_logic := '0';
    signal WR_EN : std_logic := '0';
    signal D_IN : std_logic_vector(31 downto 0) := (others => '0');
    signal D_OUT_1 : std_logic_vector(31 downto 0);
    signal D_OUT_2 : std_logic_vector(31 downto 0);
    signal ADDR : std_logic_vector(4 downto 0) := (others => '0');
    signal RD_SEL_1 : std_logic_vector(4 downto 0);
    signal RD_SEL_2 : std_logic_vector(4 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    UTT: entity work.Register32x32
        port map (
            CLK => CLK,
            EN => EN,
            WR_EN => WR_EN,
            D_IN => D_IN,
            D_OUT_1 => D_OUT_1,
            D_OUT_2 => D_OUT_2,
            ADDR => ADDR,
            RD_SEL_1 => RD_SEL_1,
            RD_SEL_2 => RD_SEL_2
        );

    -- Clock generation
    CLK_process : process
    begin
        CLK <= '0';
        wait for 100 ns;
        CLK <= '1';
        wait for 100 ns;
    end process CLK_process;
    
    -- Test process
    test_process : process
    begin
        -- Test 1: Write to register 4
        EN <= '1';
        WR_EN <= '1';
        ADDR <= "00100"; -- Register 4
        D_IN <= X"00000001";
        wait for 200 ns;

        -- Test 2: Read from register 4
        WR_EN <= '0';
        RD_SEL_1 <= "00100"; -- Register 4
        wait for 200 ns;

        -- Test 3: Write to register 26
        WR_EN <= '1';
        ADDR <= "11010"; -- Register 26
        D_IN <= X"0ff0f002";
        wait for 200 ns;

        -- Test 4: Read from register 26
        WR_EN <= '0';
        RD_SEL_2 <= "11010"; -- Register 26
        wait for 200 ns;
    
        -- Test 5: Write to register 0
        WR_EN <= '1';
        ADDR <= "00000"; -- Register 0
        D_IN <= X"00000000";
        wait for 200 ns;
        
        -- Test 6: Read from register 0
        WR_EN <= '0';
        RD_SEL_1 <= "00000"; -- Register 0
        wait for 200 ns;
    
    end process test_process;
end Behavioral;
