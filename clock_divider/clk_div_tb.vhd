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

-- Testbench for the parameterized clock divider

library ieee;
use ieee.std_logic_1164.all;

entity clk_div_tb is
end clk_div_tb;

architecture TB of clk_div_tb is
    signal clk_in, clk_out, rst : std_logic;
    constant clk_period : time := 20 ns; -- for a 50MHz clock
begin
    
    -- Instantiate the Unit Under Test (UUT)
    UUT : entity work.clk_div
        generic map (
            clk_in_freq => 50,
            clk_out_freq => 25
        )
        port map (
            rst => rst,
            clk_in => clk_in,
            clk_out => clk_out
        );
    
    -- Clock process
    process
    begin
        clk_in <= '0';
        wait for clk_period/2;
        clk_in <= '1';
        wait for clk_period/2;
    end process;
    
    -- Stimulus process
    process
    begin        
        -- Hold reset state
        rst <= '1';
        wait for clk_period;
        -- Release reset
        rst <= '0';
        -- Perform the simulation
        wait for clk_period*20;
        wait;
    end process;
    
end TB;