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

-- Testbench for the 4-to-1 multiplexer.

library ieee;
use ieee.std_logic_1164.all;

entity mux_4x1_tb is
end mux_4x1_tb;

architecture TB of mux_4x1_tb is
    signal sel : std_logic_vector(1 downto 0);
    signal output, in0, in1, in2, in3 : std_logic_vector(0 downto 0);
begin
    
    -- Instantiate the unit under test (UUT)
    UUT : entity work.mux_4x1
        generic map (
            WIDTH => 1
        )
        port map (
            output => output,
            sel => sel,
            in0 => in0,
            in1 => in1,
            in2 => in2,
            in3 => in3
        );
    
    -- Stimulus process
    process
    begin
        
        in0(0) <= '0';
        in1(0) <= '0';
        in2(0) <= '0';
        in3(0) <= '0';
        sel <= "00";
        wait for 10 ns;
        
        in0(0) <= '0';
        in1(0) <= '0';
        in2(0) <= '0';
        in3(0) <= '0';
        sel <= "01";
        wait for 10 ns;
        
        in0(0) <= '0';
        in1(0) <= '0';
        in2(0) <= '0';
        in3(0) <= '0';
        sel <= "10";
        wait for 10 ns;
        
        in0(0) <= '0';
        in1(0) <= '0';
        in2(0) <= '0';
        in3(0) <= '0';
        sel <= "11";
        wait for 10 ns;
        
        in0(0) <= '1';
        in1(0) <= '0';
        in2(0) <= '0';
        in3(0) <= '0';
        sel <= "00";
        wait for 10 ns;
        
        in0(0) <= '0';
        in1(0) <= '1';
        in2(0) <= '0';
        in3(0) <= '0';
        sel <= "01";
        wait for 10 ns;
        
        in0(0) <= '0';
        in1(0) <= '0';
        in2(0) <= '1';
        in3(0) <= '0';
        sel <= "10";
        wait for 10 ns;
        
        in0(0) <= '0';
        in1(0) <= '0';
        in2(0) <= '0';
        in3(0) <= '1';
        sel <= "11";
        wait for 10 ns;
        
        wait;
    end process;
    
end TB;