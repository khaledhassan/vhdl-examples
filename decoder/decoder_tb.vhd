-- Copyright (c) 2012 Brian Nezvadovitz <http://nezzen.net>
-- This software is distributed under the terms of the MIT License shown below.
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to
-- deal in the Software without restriction, including without limitation the
-- rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
-- sell copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
-- FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
-- IN THE SOFTWARE.

-- Testbench for binary to one-hot decoder.

library ieee;
use ieee.std_logic_1164.all;

entity decoder_tb is
end decoder_tb;

architecture TB of decoder_tb is
    constant SELBITS : positive := 2;
    signal en  : std_logic;
    signal sel : std_logic_vector(SELBITS-1 downto 0);
    signal hot : std_logic_vector(2**SELBITS-1 downto 0);
begin
    
    -- Instantiate the unit under test (UUT)
    UUT : entity work.decoder
        generic map (
            SELBITS => 2
        )
        port map (
            sel => sel,
            en => en,
            hot => hot
        );
    
    -- Stimulus process
    process
    begin
        
        en <= '1';
        sel <= "00";
        wait for 10 ns;
        sel <= "01";
        wait for 10 ns;
        sel <= "10";
        wait for 10 ns;
        sel <= "11";
        wait for 10 ns;
        en <= '0';
        wait for 10 ns;
        sel <= "00";
        wait for 10 ns;
        
        wait;
    end process;
    
end TB;
