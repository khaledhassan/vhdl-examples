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

-- Testbench for synchronous register of a given width with a load signal.

library ieee;
use ieee.std_logic_1164.all;

entity reg_tb is
end reg_tb;

architecture TB of reg_tb is
    signal rst, clk, load : std_logic;
    signal input, output : std_logic_vector(0 downto 0);
    constant clk_period : time := 20 ns; -- for a 50MHz clock
begin
    
    -- Instantiate the Unit Under Test (UUT)
    UUT : entity work.reg
        generic map (
            WIDTH => 1
        )
        port map (
            rst => rst,
            clk => clk,
            load => load,
            input => input,
            output => output
        );
    
    -- Clock process
    process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
    -- Stimulus process
    process
    begin        
        -- Hold reset state
        rst <= '1';
        load <= '0';
        input(0) <= '0';
        wait for clk_period;
        -- Release reset
        rst <= '0';
        -- Perform the simulation
        input(0) <= '1';
        wait for clk_period;
        input(0) <= '0';
        load <= '1';
        wait for clk_period;
        input(0) <= '1';
        wait for clk_period;
        input(0) <= '0';
        wait;
    end process;
    
end TB;
