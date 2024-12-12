-- Nama         : William Anthony
-- NIM          : 13223048
-- Tanggal      : 13 Desember 2024
-- Fungsi       : Melakukan penjumlahan dua angka width bertipe signed

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity W_Adder is

    generic(
        Size : integer := 15 -- Int banyak diinput -1+(2^4)
    );

    port(
        A : in signed(Size downto 0);
        B : in signed(Size downto 0);
        Sum : out signed((Size+1) downto 0)
    );
end entity W_Adder;

-- architecture of W_Adder
architecture rtl of W_Adder is
-- computational logic
begin
Sum <= to_signed(to_integer(A)+to_integer(B), (Size + 2));
end architecture rtl;

