* My understanding is that the system failed on 2^16 - 1 as the size of count was only 4 bits when the correct answer was 16 which needs 5 bits.
* A simple incorrect assumption (such that only 4 bits would be required when a single case requires 5) can lead to the same errors being present in both the testbench and the simulation.
* The writer would be more likely to just copy their output variables rather than declaring an int type or something that cannot be declared in the simulation but is a better fit for testing.
* Use higher level types to better catch overflow errors etc.
* Far fewer lines of repeated code are required as the size of the tested bus grows exponentially rather than linearly with a single block. This leads to easier debugging and lower chance of errors.
* Change the testbench sizes to 64 bits then add a hamming32 and hamming64 module to count the bits of a 64 bit module.