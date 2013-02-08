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

-- Adder tree (generic)

-- Recursively generate a tree of adders in order to add a large amount of numbers
-- together. The height of the tree is 1+ceil(log2(TOPWIDTH)).
-- Imagine it looking like an "inverted triangle" to get an idea of the nodes
-- that this code generates.

library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.log2;
use ieee.math_real.ceil;

entity adder_tree is
    generic (
        WIDTH     : positive := 8;
        TOPWIDTH  : positive := 4
    );
    port (
        rst       : in  std_logic;
        clk       : in  std_logic;
        input     : in  std_logic_vector(TOPWIDTH*WIDTH-1 downto 0);
        output    : out std_logic_vector(WIDTH-1 downto 0);
        valid_in  : in  std_logic;
        valid_out : out std_logic
    );
end adder_tree;

architecture STR of adder_tree is
    signal valid : std_logic;
begin
    
    -- Delay the valid bit by one cycle for each level in the pipeline
    U_VALID : entity work.reg
        port map (
            rst     => rst,
            clk     => clk,
            d(0)    => valid_in,
            q(0)    => valid
        );
    
    -- Base case
    BASE_CASE : if TOPWIDTH = 2 generate
        signal register_input : std_logic_vector(WIDTH-1 downto 0);
    begin
        -- Valid bit
        valid_out <= valid;
        -- Adder
        U_ADDER : entity work.adder
            generic map (
                WIDTH => WIDTH
            )
            port map (
                input1 => input(TOPWIDTH*WIDTH-1 downto WIDTH),
                input2 => input(WIDTH-1 downto 0),
                c_in   => '0',
                output => register_input,
                c_out  => open
            );
        -- Vector of Registers
        U_FFV : entity work.reg
            generic map (
                WIDTH => WIDTH
            )
            port map (
                rst => rst,
                clk => clk,
                d => register_input,
                q => output
            );
    end generate BASE_CASE;
    
    -- Recursive case for even inputs
    RECURSIVE_CASE_EVEN : if (TOPWIDTH > 2 and (TOPWIDTH mod 2) = 0) generate
        signal register_input, register_output : std_logic_vector((TOPWIDTH/2)*WIDTH-1 downto 0);
    begin
        -- Slice off a line of values from the top of the tree and sum them up
        U_ADDERS : for i in TOPWIDTH/2-1 downto 0 generate
            U_ADDER : entity work.adder
                generic map (
                    WIDTH => WIDTH
                )
                port map (
                    input1 => input(((i*2)*WIDTH)+(WIDTH-1) downto (i*2)*WIDTH),
                    input2 => input(((i*2+1)*WIDTH)+(WIDTH-1) downto (i*2+1)*WIDTH),
                    c_in   => '0',
                    output => register_input((i*WIDTH)+(WIDTH-1) downto i*WIDTH),
                    c_out  => open
                );
             U_FFV : entity work.reg
                generic map (
                    WIDTH => WIDTH
                )
                port map (
                    rst     => rst,
                    clk     => clk,
                    d   => register_input((i*WIDTH)+(WIDTH-1) downto i*WIDTH),
                    q   => register_output((i*WIDTH)+(WIDTH-1) downto i*WIDTH)
                );
        end generate U_ADDERS;
        -- The remaining triangle becomes its own adder tree
        U_SUBTREE : entity work.adder_tree
            generic map (
                WIDTH    => WIDTH,
                TOPWIDTH => TOPWIDTH/2
            )
            port map (
                rst     => rst,
                clk     => clk,
                input   => register_output,
                output  => output,
                valid_in  => valid,
                valid_out => valid_out
            );
    end generate RECURSIVE_CASE_EVEN;
    
    -- Recursive case for odd inputs
    RECURSIVE_CASE_ODD : if (TOPWIDTH > 2 and (TOPWIDTH mod 2) = 1) generate
        constant TREEHEIGHT : integer := integer(ceil(log2(real(TOPWIDTH))));
        signal base_case : std_logic_vector(WIDTH*2-1 downto 0);
        signal delay_chain : std_logic_vector((TREEHEIGHT+1)*WIDTH-1 downto 0);
        signal valid2 : std_logic;
    begin
        -- Take the odd value out and push it down to the bottom of the tree
        -- The number of delays is equal to the height of the tree (minus 1)
        -- The height of the tree is 1+ceil(log2(N)) where N is the number
        -- of registers wide the top row is.
        U_FFV_DELAYCHAIN : for i in TREEHEIGHT downto 1 generate
            U_FFV : entity work.reg
                generic map (
                    WIDTH => WIDTH
                )
                port map (
                    rst     => rst,
                    clk     => clk,
                    d   => delay_chain((i+1)*WIDTH-1 downto ((i+1)*WIDTH-1)-(WIDTH-1)),
                    q   => delay_chain(i*WIDTH-1 downto (i*WIDTH-1)-(WIDTH-1))
                );
        end generate U_FFV_DELAYCHAIN;
        -- Provide a source for the first register in the delay chain
        delay_chain((TREEHEIGHT+1)*WIDTH-1 downto ((TREEHEIGHT+1)*WIDTH-1)-(WIDTH-1)) <= input(WIDTH-1 downto 0);
        -- Rename the output of the last register in the delay chain
        base_case(WIDTH-1 downto 0) <= delay_chain(WIDTH-1 downto 0);
        -- The rest of the values are an even case
        U_SUBTREE : entity work.adder_tree
            generic map (
                WIDTH => WIDTH,
                TOPWIDTH => TOPWIDTH-1
            )
            port map (
                rst     => rst,
                clk     => clk,
                input   => input(TOPWIDTH*WIDTH-1 downto WIDTH),
                output  => base_case(WIDTH*2-1 downto WIDTH),
                valid_in  => valid,
                valid_out => valid2
            );
         -- Extra base case to add in the odd value
         U_EXTRABASE : entity work.adder_tree
            generic map (
                WIDTH => WIDTH,
                TOPWIDTH => 2
            )
            port map (
                rst     => rst,
                clk     => clk,
                input   => base_case,
                output  => output,
                valid_in  => valid2,
                valid_out => valid_out
            );
    end generate RECURSIVE_CASE_ODD;
    
end STR;
