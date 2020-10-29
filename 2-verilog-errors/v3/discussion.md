* The compiler ran without warnings or errors.
* One way to detect errors in testbenches is to give the testbench known good input and see if it throws and error and where.
* ff.v should've used always_ff to enable warnings in the compiler if the always condition isn't on an edge.
* ff.v used single-letter variable names which can lead to confusion as to what each variable means, especially when you have a lot of variables.
* If you get in the habit of using single-letter variable names you may well end up overwriting a variable by accident.
* ff_tb.v should've done assert else rather than a simple assert so that the tester knows what caused the program to fail.
* ff_tb.v never edited clock_enable, which meant that the FF was always write-enabled. To fully test the FF we should've attempted to write to it with clock_enable set to 0.