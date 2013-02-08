VHDL example code
=================

This project contains chunks of example VHDL source code, distributed as educational material under the MIT License and written by Brian Nezvadovitz.

What's in the box?
------------------

#### Simple Examples

 * <code>adders_1bit</code> - 1-bit half-adder and 1-bit full-adder examples demonstate the use of combinatorial logic

 * <code>multiplexer</code> - 2:1 and 4:1 multiplexer examples demonstrate the use of generics in purely combinatorial code

 * <code>adder_numeric_std</code> - Basic use of the numeric_std library is shown with a full adder of generic width

 * <code>decoder</code> - A binary to one-hot decoder with enable signal demonstrates the use of the combinatorial process block

 * <code>register</code> - Demonstration of the clocked process and the basic memory storage element

#### Intermediate Examples

 * <code>shift_reg</code> - Shift register example demonstrates the simple use of generics and the single-process model

 * <code>clock_divider</code> - Logic-only parameterized clock divider that uses a cycle counter in its implementation

 * <code>pulse_emitter</code> - Emits single-cycle pulses at regular intervals when enabled; demonstrates use of 2-process model

#### Complex Examples

 * <code>adder_tree</code> - Adder tree example demonstrates how to write recursive, pipelined VHDL
