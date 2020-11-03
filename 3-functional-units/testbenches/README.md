# Testbenches

## Dependencies:
To run the testbenches you must have mix installed. It can be installed using:  
```sudo apt install elixir```  

## Running
To run the testbenches, run:
```mix test```

## Files
The testbench is [here](/test/testbenches_test.exs)  
The Elixir version of the parallel multiplier is [here](/lib/mul.ex)  

## Editing
To create a new testbench, add one to test/testbenches_test.exs as follows: 
```ex
test "Test name" do
  # code you want to run
  # you can add assertions in the form:
  assert(1 == 1)
  # or with an error message
  assert(1==1, "1 != 1 now")
  # you can also just throw an error with
  flunk("The program shouldn't've got here")
end
```
