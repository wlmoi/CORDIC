-- Nama         : William Anthony
-- NIM          : 13223048
-- Tanggal      : 13 Desember 2024
-- Fungsi       : Melakukan pengurangan dua angka width bertipe signed

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity W_Subtractor is

    generic(
        Size : integer := 15
    );

    port(
        A : in signed(Size downto 0);
        B : in signed(Size downto 0);
        Difference : out signed((Size+1) downto 0)
    );
end entity W_Subtractor;

-- architecture of W_Subtractor
architecture rtl of W_Subtractor is
-- computational logic
begin
Difference <= to_signed(to_integer(A) - to_integer(B), (Size+2));

end architecture rtl;
