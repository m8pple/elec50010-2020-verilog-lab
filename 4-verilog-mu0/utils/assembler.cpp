#include "mu0.hpp"

#include <utility>
#include <map>
#include <iostream>
#include <cassert>
#include <iomanip> 

string to_hex4(uint16_t x)
{
    char tmp[16]={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
    string res;
    res.push_back(tmp[(x>>12)&0xF]);
    res.push_back(tmp[(x>>8)&0xF]);
    res.push_back(tmp[(x>>4)&0xF]);
    res.push_back(tmp[(x>>0)&0xF]);
    return res;
}

int main()
{
    const vector<string> opnames = {
        "LDA", "STO", "ADD", "SUB", "JMP", "JGE", "JNE", "STP", "OUT"
    };

    vector< pair<string,string> > data_and_instr;
    map<string,int> labels;

    //////////////////////////////////////////
    // Read all the instructions/data and record labels

    string head;
    while(cin >> head){
        if(mu0_is_label_decl(head)){
            head.pop_back(); // remove colon
            assert(labels.find(head)==labels.end());
            labels[head]=data_and_instr.size();
        
        }else if(mu0_is_instruction(head)){
            string address;

            if(mu0_instruction_has_operand(head)){
                cin >> address;
                assert(!cin.fail());
            }

            data_and_instr.push_back({head,address});
        }else if(mu0_is_data(head)){
            data_and_instr.push_back({head,""});
        }else{
            cerr<<"Couldn't parse '"<<head<<"'\n";
            exit(1);
        }
    }

    //////////////////////////////////////////////////
    // Emit all the binary and embed labels

    cout << hex;    // Print everything in hex
    cout << setw(4); // Always print 4 digits
    cout << setfill('0'); // Pad with 0 digit

    for(int i=0; i<data_and_instr.size(); i++){
        if(mu0_is_instruction( data_and_instr[i].first )){
            string opname=data_and_instr[i].first;
            
            uint16_t opcode=0;
            while(opnames[opcode]!=opname){
                opcode++;
                assert(opcode < opnames.size());
            }

            uint16_t address=0;
            string address_name=data_and_instr[i].second;
            if(!address_name.empty()){
                assert(mu0_instruction_has_operand(opname));

                if(mu0_is_data(address_name)){
                    // Absolute address
                    address=stoul(address_name);
                    assert(address < 4096);

                }else{
                    // Labelled address
                    assert(labels.find(address_name)!=labels.end());
                    address=labels[address_name];
                }

            }else{
                assert(!mu0_instruction_has_operand(opname));
            }

            cout << to_hex4( (opcode<<12) + address ) << endl;
        }else{
            int16_t val=stoi(data_and_instr[i].first);
            
            cout << to_hex4( (uint16_t)val ) << endl;
        }
    }
}

