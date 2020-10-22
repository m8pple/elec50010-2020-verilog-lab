#include "mu0.hpp"

#include <vector>
#include <cctype>
#include <iostream>

int main()
{
    vector<uint16_t> memory=mu0_read_binary(cin);

    // Simulate it
    int ACC=mu0_simulate(&memory[0]);

    // Convert non-zero ACC to failure code
    return ACC!=0;
}
