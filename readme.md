Instruction Architectures and Compilers Lab : Autumn
====================================================

You already have some experience with digital design for FPGAs
through DECA lab, where the main focus was on block design with
bits of Verilog. Those of you who chose the CPU project
in 1st year will have more experience, but there should be no
problems for those who did other projects.

The main differences in this course are related to:

- Complexity: developing a full MIPS is inherently a more complex task than doing a small custom ISA.
- Specifications: you must adhere to a reasonably complex and precise ISA spec, rather than making your
  own choices according to convenience.
- Language: we are using pure Verilog with no block diagrams or vendor primitives.
- Testing: you need not only develop the CPU, but also deliver a test framework.

These labs are intended to get you up to speed on Verilog, with a heavy emphasis
on testing. The approach taken is more to show you lots of examples of Verilog,
rather than to ask you to write Verilog from scratch, and to learn by example
and investigation.

There is no assessment of what you _do_ in these labs, the only thing that matters
is what you _learn_. The oral questions will refer back to things discussed in
the labs, but there is no requirement to produce any "solutions". There are many
suggested activities which are worth trying, either individually or by sharing
them out in the group. It is highly recommended that you talk to each other
occasionally while doing the lab, and share experience.

There are a number of suggested "thinking" points. You should genuinely try to
think about them, and potentially discuss them as a group. There is not necessarily
one answer, or it may be subjective, but they are worth thinking about.

Structure
=========

The lab is organised into six sections:

- [0-tools](0-tools) This describes how to get hold of the Verilog simulator we'll use,
    and some basic simulation tasks.

- [1-verilog-syntax](1-verilog-syntax) This is a short intro to the parts of SystemVerilog
    needed to build the CPU. This section is mainly reading.

- [2-verilog-errors](2-verilog-errors) Provides 7 very simple examples of different types
    of error, so that you can see what happens, fix them, and think about how to stop
    them happening in your code.

- [3-functional-units](3-functional-units) Provides slightly more complex working examples
    of functional units, described using a number of styles and architectures. These are
    mainly for you to run, read, and understand.

- [4-verilog-MU0](4-verilog-MU0) An example of a working synthesisable MU0 in Verilog, including
    test-benches and testing infrastructure. The purpose here is to give an example of
    a complete system, and to show all the other stuff that is needed beyond just the
    Verilog for the CPU.

- [5-assessment](5-assessment) Describes how the oral assessment will work.

Approach
========

In total there are ~9000 words in the instructions, which is about 30 minutes
for most readers. So it is suggested that you individually read the whole thing
through once first, then come back and do the more technical aspects.

A suggested path is to do earlier sections individually, then come together
as a group for the later sections, but it is up to you.

- Performed Individually : if you get stuck on a part, then just leave it and then talk about it in your group

    - 0-tools : 30-60 minutes (depending on internet connection)
    - 1-verilog-syntax : 30 minutes of reading
    - 2-verilog-errors : 30-60 minutes (depending on how well you understood it). This is mainly just to fix the errors. The thinking can be done more in the group.

- Performed as a group or pairs : it's worth reading the later sections first, but you'll likely get more value from discussion

    - 3-functional units : 30 minutes of checking everyone understands, then 30-60 minutes of breaking and fixing
    - 4-verilog-MU0 : worth discussing as a group once to try to work out how it works, then again closer to the oral

Remember that each individual doesn't have to do everything or know everything. You are
trying develop knowledge and learn skills so that you can deliver a MIPS CPU as a group.

Overall about 2-3 hours of individual and 3-4 hours of group work should be about right, including
time spent during the mid-term week as a group preparing for the oral. So if you were to organise
it as:

-   26th-30th : Individual reading and work (2-3 hours)
-   2nd-6th : Group discussions and learning (2-3 hours)
-   9th-11th : Group revision and oral preparation (1-2 hours)
  
Obviously these are just estimates - some people will be faster, some slower (either due to ability, or decisions about how to manage time.

If you have specific questions, you can [book a group consultation slot](https://imperiallondon-my.sharepoint.com/:x:/g/personal/dt10_ic_ac_uk/EULre3tu5M1IiPbNoGgnLUEBbG9japRccFPp2akkeKAC4A?e=8ZxgFA), or ask in the module teams page.

On errors
=========

I (dt10) freely admit that I had never really used Verilog before June 2020 (though I have written
many thousands of lines of VHDL), and learnt the language purely to develop this coursework. Based
on my research, reading, and experiments, the information and approaches presented here seem to present
the best balance between writing nice code and writing correct code. Some "best practises" are inherently
subjective, so there will often be differences between what I suggest and what others suggest (and
even between what I suggest and actually do in the example code). However, if there is anything
which is factually wrong, then let me know - I'm perfectly happy with being corrected.