#ifndef mu0_hpp
#define mu0_hpp

#include <cstdint>
#include <string>
#include <vector>
#include <fstream>

using namespace std;


/////////////////////////////////////////////
// Simulation

// Read a binary from the given stream
// This always returns the full 4096 values, even if there are fewer in the input binary
vector<uint16_t> mu0_read_binary(istream &src);

// Simulates the execution of a program on a MU0 processors.
// Input: Receives a pointer to the initial state of memory
// Output: Leaves being final state of memory, and returns value of ACC
int16_t mu0_simulate(uint16_t *memory);

/////////////////////////////////////////////
// Assembly

// Return true if the string is a valid label declaration
bool mu0_is_label_decl(const string &s);

// Return true if the string s represents data ( a decimal integer constant)
bool mu0_is_data(const string &s);

// Takes a 3-letter opname and turns it into the numeric opcode
uint16_t mu0_opname_to_opcode(const string &s);

// TODO: overload for mu0_is_instruction which takes a string
// Return true if the integer v is a valid encoded instruction
bool mu0_is_instruction(const string &value);

// Returns true if the given opname has a memory operand
bool mu0_instruction_has_operand(const string &value);

////////////////////////////////////////////
// Disassembly

// Takes a numeric opcode and turns it into the 3-letter opname
string mu0_opcode_to_opname(uint16_t opcode);

// Returns the disassembly for the given 16-bit value
string mu0_disassemble_instruction(uint16_t instruction);

// Return true if the integer v is a valid encoded instruction
bool mu0_is_instruction(uint16_t value);

// Returns true if the given opcode has a memory operand
bool mu0_instruction_has_operand(uint16_t opcode);

#endif