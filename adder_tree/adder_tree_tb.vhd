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

-- Testbench for the generic adder tree.

library ieee;
use ieee.std_logic_1164.all;

entity adder_tree_tb is
end adder_tree_tb;

architecture TB of adder_tree_tb is
    signal rst, clk : std_logic;
    signal input : std_logic_vector(19 downto 0);
    signal output : std_logic_vector(3 downto 0);
    constant clk_period : time := 20 ns; -- for a 50MHz clock
    signal valid, valid_out : std_logic;
begin
    
    -- Instantiate the Unit Under Test (UUT)
    UUT : entity work.adder_tree
        generic map (
            WIDTH => 4,
            TOPWIDTH => 5
        )
        port map (
            rst => rst,
            clk => clk,
            input => input,
            output => output,
            valid_in => valid,
            valid_out => valid_out
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
        --input <= "00111011";
        --input <= "000100100100";
        input <= "10010001001001001000";
        valid <= '1';
        rst <= '1';
        wait for clk_period;
        rst <= '0';
        wait for clk_period;
        valid <= '0';
        wait;
    end process;
    
end TB;
