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

-- Implements a shift register of a given size.

library ieee;
use ieee.std_logic_1164.all;

entity shift_reg is
    generic (
        WIDTH   : positive := 8
    );
    port (
        rst     : in  std_logic;
        clk     : in  std_logic;
        load    : in  std_logic;
        lsb     : in  std_logic;
        output  : out std_logic_vector(WIDTH-1 downto 0)
    );
end shift_reg;

architecture BHV of shift_reg is
    signal reg : std_logic_vector(WIDTH-1 downto 0);
begin
    
    process(clk, rst, load, lsb)
    begin
        if(rst = '1') then
            -- Reset to default value
            reg <= (others => '0');
        elsif(rising_edge(clk)) then
            if(load = '1') then
                reg <= reg(WIDTH-2 downto 0) & lsb; -- shift in the new LSB
            else
                reg <= reg;
            end if;
        end if;       
    end process;
    
    -- Break out the register's value
    output <= reg;
    
end BHV;
