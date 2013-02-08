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

-- Multiplexer 4:1
-- Implements a 4-to-1 multiplexer of a given width.

library ieee;
use ieee.std_logic_1164.all;

entity mux_4x1 is
    generic (
        WIDTH : positive := 1
    );
    port (
        output : out std_logic_vector(WIDTH-1 downto 0);
        sel    : in  std_logic_vector(1 downto 0);
        in0    : in  std_logic_vector(WIDTH-1 downto 0);
        in1    : in  std_logic_vector(WIDTH-1 downto 0);
        in2    : in  std_logic_vector(WIDTH-1 downto 0);
        in3    : in  std_logic_vector(WIDTH-1 downto 0)
    );
end mux_4x1;

architecture BHV of mux_4x1 is
    
begin
    
    output <=
        in0 when sel = "00" else
        in1 when sel = "01" else
        in2 when sel = "10" else
        in3 when sel = "11" else
        (others => '0');
    
end BHV;
