* There were no compiler warnings.
* Always_comb changes how the compiler views it initially (It runs at t=0) however after this is added the code is compiled exactly the same.
* Or is a keyword in verilog & either would not compile or would cause issues when we try to create an or gate.
* The clearest option in my opinion is either ```if(a + b > 0)``` or  ```if(a == 1 || b == 1)``` as it is a single if/else statement.
* There is also the option which doesn't require "else" statements, which I believe to be the least error prone, however it includes multiple assignments which can take up more time.
```
  r = 0;
  if(a==1) r = 1;
  if(b==1) r = 1;

```
* The issue is that the or gate doesn't have any method to set r to 0 if ```a || b``` is false.