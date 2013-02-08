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

-- Testbench for the shift register.

library ieee;
use ieee.std_logic_1164.all;

entity shift_reg_tb is
end shift_reg_tb;

architecture TB of shift_reg_tb is
    constant clk_period : time := 20 ns; -- for a 50MHz clock
    signal rst, clk, load, lsb : std_logic;
    signal output : std_logic_vector(3 downto 0);
begin
    
    -- Instantiate the unit under test (UUT)
    UUT : entity work.shift_reg
        generic map (
            WIDTH => 4
        )
        port map (
            rst => rst,
            clk => clk,
            load => load,
            lsb => lsb,
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
        lsb <= '0';
        load <= '1';
        wait for clk_period;
        rst <= '0';
        -- Perform the simulation
        wait for clk_period;
        lsb <= '1';
        wait for clk_period;
        load <= '0';
        wait for clk_period;
        load <= '1';
        lsb <= '0';
        wait for clk_period;
        lsb <= '0';
        wait for clk_period;
        load <= '0';
        wait;
    end process;
    
end TB;
