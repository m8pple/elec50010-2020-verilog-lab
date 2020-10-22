#include "mu0.hpp"

#include <cassert>
#include <iostream>

int main()
{
    vector<uint16_t> binary = mu0_read_binary(std::cin);
    assert(binary.size()==4096);

    // Trim it down
    while(binary.size()>1 && binary.back()==0){
        binary.pop_back();
    }

    // Find the last address which is used as a label
    int last_label=0;
    for(int i=0; i<binary.size(); i++){
        if(mu0_is_instruction(binary[i])){
            unsigned opcode=binary[i]>>12;
            unsigned address=binary[i]&0xFFF;

            if(mu0_instruction_has_operand(opcode)){
                last_label=i;
            }
        }
    }
    // Resize back up with zeros if needs-be
    if(last_label >= binary.size()){
        binary.resize(last_label+1, 0);
    }

    for(int i=0; i<binary.size(); i++){
        cout <<"L"<<i<<": ";
        if(mu0_is_instruction(binary[i])){
            unsigned opcode=binary[i]>>12;
            unsigned address=binary[i]&0xFFF;

            cout << mu0_opcode_to_opname(opcode);
            if(mu0_instruction_has_operand(opcode)){
                cout << " L" << address;
            }
            cout << endl;
        }else{
            cout<< (int16_t)binary[i] << endl;
        }
    }
}
