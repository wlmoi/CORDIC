-- Nama         : William Anthony
-- NIM          : 13223048
-- Tanggal      : 13 Desember 2024
-- Fungsi       : Melakukan Right Shifting untuk mempersiapkan hasil desimal

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity W_RShift is

    generic(
        Size : integer := 15
    );

    port(
        A : in std_logic_vector(Size downto 0);
        Shift : in integer;
        Result : out std_logic_vector(Size downto 0)
    );
end entity W_RShift;

-- architecture of W_RShift
architecture rtl of W_RShift is
    begin
    Result <= std_logic_vector(shift_right(signed(A), Shift));
end architecture rtl;