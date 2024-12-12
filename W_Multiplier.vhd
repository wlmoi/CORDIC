
-- Nama         : William Anthony
-- NIM          : 13223048
-- Tanggal      : 13 Desember 2024
-- Fungsi       : Melakukan perkalian dua angka width bertipe signed

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity W_Multiplier is

    generic(
        Size : integer := 15
    );

    port(
        A : in signed(Size downto 0);
        B : in signed(Size downto 0);
        Result : out signed((2*Size) downto 0)
    );
end entity W_Multiplier;

-- architecture of W_Multiplier
architecture Behavioral of W_Multiplier is
begin
Result <= to_signed(to_integer(A)*to_integer(B), (2*Size + 1));

end architecture Behavioral;

