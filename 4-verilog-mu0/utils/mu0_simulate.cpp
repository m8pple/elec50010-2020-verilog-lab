#include "mu0.hpp"

#include <cassert>
#include <iostream>

int16_t mu0_simulate(uint16_t *memory)
{
    uint16_t PC=0;
    int16_t ACC=0;

    while(1){
        assert(PC < 4096);

        uint16_t instr=memory[PC];
        assert(mu0_is_instruction(instr));

        uint16_t opcode=instr>>12;
        uint16_t S=instr&0xFFF;

        if(opcode==0){ // LDA
            ACC = (int16_t)memory[S];
            PC=PC+1;

        }else if(opcode==1){ // STO
            memory[S] = (uint16_t)ACC;
            PC=PC+1;

        }else if(opcode==2){ // ADD
            ACC = ACC + (int16_t)memory[S];
            PC=PC+1;

        }else if(opcode==3){ // SUB
            ACC = ACC - (int16_t)memory[S];
            PC=PC+1;

        }else if(opcode==4){ // JMP
            PC=S;

        }else if(opcode==5){ // JGE
            if(ACC>=0){
                PC=S;
            }else{
                PC=PC+1;
            }

        }else if(opcode==6){ // JNE
            if(ACC!=0){
                PC=S;
            }else{
                PC=PC+1;
            }

        }else if(opcode==7){ // STP
            return ACC;

        }else if(opcode==8){
            std::cout<<(int)(ACC)<<"\n";
            PC=PC+1;

        }else{
            assert(0);
        }
    }
}