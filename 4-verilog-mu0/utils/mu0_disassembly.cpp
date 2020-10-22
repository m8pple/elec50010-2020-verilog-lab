#include "mu0.hpp"

#include <sstream>
#include <cassert>
#include <iostream>

bool mu0_is_instruction(uint16_t v)
{
    return (v>>12) < 10;
}

string mu0_disassemble_instruction(uint16_t instr)
{
    uint16_t opcode=instr>>12;

    if(opcode>9){
        return to_string((int16_t)instr);
    }
    
    // Could also do it digit by digit
    stringstream tmp;
    tmp<<hex;
    tmp<<(instr&0xFFFF);
    string S=tmp.str();
    S=" "+S; // To avoid repetition

    if(opcode==0){
        return "LDA"+S;
    }else if(opcode==1){
        return "STO"+S;
    }else if(opcode==2){
        return "ADD"+S;
    }else if(opcode==3){
        return "SUB"+S;
    }else if(opcode==4){
        return "JMP"+S;
    }else if(opcode==5){
        return "JGE"+S;
    }else if(opcode==6){
        return "JNE"+S;
    }else if(opcode==7){
        return "STP";
    }else if(opcode==8){
        return "OUT";
    }else{
        assert(0);
    }
}

string mu0_opcode_to_opname(uint16_t opcode)
{
    const vector<string> opnames={
        "LDA", "STA", "ADD", "SUB", "JMP", "JGE", "JNE", "STP", "OUT"
    };
    return opnames.at(opcode);
}

// Returns true if the given opcode has a memory operand
bool mu0_instruction_has_operand(uint16_t opcode)
{
    assert(opcode < 10);
    return opcode < 7;
}

vector<uint16_t> mu0_read_binary(std::istream &src)
{
    vector<uint16_t> memory;

    int num=1;
    string line;
    while( getline(src, line) ){
        assert(num <= 4096);

        // Trim initial space
        while(line.size()>0 && isspace(line.front())){
            line = line.substr(1); // Remove first characters
        }

        // Trim trailing space
        while(line.size()>0 && isspace(line.back())){
            line.pop_back();
        }

        if(line.size()!=4){
            cerr<<"Line "<<num<<" : expected exactly four chars, got '"<<line<<'"'<<endl;
            exit(1);
        }
        for(int i=0; i<line.size(); i++){
            if(!isxdigit(line[i])){
                cerr<<"Line "<<num<<" : expected only hexadecimal digits, got '"<<line[i]<<'"'<<endl;
                exit(1);
            }
        }

        unsigned x=stoul(line, nullptr, 16);
        assert(x<65536);
        memory.push_back(x);

        num++;
    }
    memory.resize(4096, 0);

    return memory;
}