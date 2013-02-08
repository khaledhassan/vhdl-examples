-- Pulse emitter: Emits pulses at regular intervals when enabled
-- 
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.log2;
use ieee.math_real.ceil;

entity pulse_emitter is
    generic (
        MAX : integer
    );
    port (
        clk : in std_logic;
        rst : in std_logic;
        en  : in std_logic;
        output : out std_logic
    );
end pulse_emitter;

architecture BHV of pulse_emitter is
    constant WIDTH : integer := integer(ceil(log2(real(MAX))));
    signal count, next_count : unsigned(WIDTH-1 downto 0);
    signal reached_max : std_logic;
begin
    
    -- Break out the output signal
    output <= reached_max;
    
    -- Comparator for maximum value
    process(count)
    begin
        if(count = MAX) then
            reached_max <= '1';
        else
            reached_max <= '0';
        end if;
    end process;
    
    -- Adder for the next count value
    next_count <= count + 1;
    
    -- Clocked process to increment the count register
    process(rst, clk, count, next_count)
    begin
        if(rst = '1') then
            count <= (others => '0');
        elsif(rising_edge(clk)) then
            if(en = '1') then
                if(reached_max = '1') then
                    count <= (others => '0');
                else
                    count <= next_count;
                end if;
            else
                count <= count;
            end if;
        end if;
    end process;
    
end BHV;
