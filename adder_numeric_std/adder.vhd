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

-- Implements an adder of variable width with carry signals.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
    generic (
        WIDTH : positive := 8
    );
    port (
        a     : in std_logic_vector(WIDTH-1 downto 0);
        b     : in std_logic_vector(WIDTH-1 downto 0);
        c_in  : in std_logic;
        sum   : out std_logic_vector(WIDTH-1 downto 0);
        c_out : out std_logic
    );
end;

architecture BHV of adder is
    signal full_sum : std_logic_vector(WIDTH downto 0);
    signal c_in_vec : std_logic_vector(0 downto 0);
begin
    c_in_vec(0) <= c_in;
    full_sum <= std_logic_vector( resize(unsigned(a), WIDTH+1) + resize(unsigned(b), WIDTH+1) + resize(unsigned(c_in_vec), WIDTH+1) );
    sum <= full_sum(WIDTH-1 downto 0);
    c_out <= full_sum(WIDTH);
end BHV;
