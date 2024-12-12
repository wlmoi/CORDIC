-- Nama         : William Anthony
-- NIM          : 13223048
-- Tanggal      : 14 Desember 2024
-- Fungsi       : Melakukan perhitungan arctan menggunakan algoritma Cordic

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Cordic is
    port(
        X : in signed(15 downto 0);
        Y : in signed(15 downto 0);
        clk, rst, enable_cordic : in std_logic;
        RPolar : out signed(15 downto 0);
        Theta  : out signed(19 downto 0)
    );
end entity Cordic;

-- architecture of Cordic
architecture Behavioral of Cordic is
    signal Xs, Ys, Zs : signed(15 downto 0);
    signal Xn, Yn, Zn : signed(15 downto 0);
    signal Theta_s : signed(19 downto 0);
    signal RPolar_s : signed(15 downto 0);
    signal cordic_enable : std_logic;
    signal cordic_rst : std_logic;
    signal cordic_clk : std_logic;
    signal cordic_shift : integer;
    signal cordic_result : std_logic_vector(15 downto 0);
    signal cordic_temp : std_logic_vector(15 downto 0);

    --State
    type State is (Idle,Start,Calculate,Shifting,Ending);
    signal state : State := Idle;

    --Constant
    component W_LShift is
        generic(
            Size : integer := 15
        );
        port(
            A : in std_logic_vector(Size downto 0);
            Shift : in integer;
            Result : out std_logic_vector(Size downto 0)
        );
    end component W_LShift;

    component W_RShift is
        generic(
            Size : integer := 15
        );
        port(
            A : in std_logic_vector(Size downto 0);
            Shift : in integer;
            Result : out std_logic_vector(Size downto 0)
        );
    end component W_RShift;

    component W_Multiplier is
        generic(
            Size : integer := 15
        );
        port(
            A : in signed(Size downto 0);
            B : in signed(Size downto 0);
            Result : out signed((2*Size) downto 0)
        );
    end component W_Multiplier;

    component W_Subtractor is
        generic(
            Size : integer := 15
        );
        port(
            A : in signed(Size downto 0);
            B : in signed(Size downto 0);
            Difference : out signed((Size+1) downto 0)
        );
    end component W_Subtractor;

    

    begin
    process(clk, rst)
    begin
        if rst = '1' then
            state <= Idle;
        elsif rising_edge(clk) then
            case state is
                when Idle =>
                    if enable_cordic = '1' then
                        state <= Start;
                    else
                        state <= Idle;
                    end if;

                when Start =>
                    Xs <= X;
                    Ys <= Y;
                    Zs <= to_signed(0,16);
                    Theta_s <= to_signed(0,20);
                    cordic_enable <= '1';
                    cordic_rst <= '0';
                    cordic_clk <= '0';
                    cordic_shift <= 0;
                    state <= Calculate;

                when Calculate =>
                    Xn <= Xs;
                    Yn <= Ys;
                    Zn <= Zs;
                    if Yn > 0 then
                        Zn <= Zn + Theta_s;
                        Xn <= Xn + shift_right(Yn, cordic_shift);
                        Yn <= Yn - shift_right(Xn, cordic_shift);
                        Theta_s <= Theta_s - shift_right(to_signed(1,20), cordic_shift);
                    else
                        Zn <= Zn - Theta_s;
                        Xn <= Xn - shift_right(Yn, cordic_shift);
                        Yn <= Yn + shift_right(Xn, cordic_shift);
                        Theta_s <= Theta_s + shift_right(to_signed(1,20), cordic_shift);
                    end if;
                    cordic_enable <= '1';
                    cordic_rst <= '0';
                    cordic_clk <= '1';
                    cordic_shift <= cordic_shift + 1;
                    if cordic_shift = 15 then
                        state <= Shifting;
                    else
                        state <= Calculate;
                    end if;
                when Shifting =>
                    cordic_enable <= '0';
                    cordic_rst <= '1';
                    cordic_clk <= '0';
                    cordic_shift <= 0;
                    state <= Ending;
                when Ending =>
                    RPolar <= RPolar_s;
                    Theta <= Theta_s;
                    state <= Idle;
                
            end case;
        end if;
    end process;
end architecture Behavioral;