* The waveform changes q as soon as d changes if the clock is high.
* Q is set to update whenever the clock is high rather than just on the rising edge.
* No as it doesn't know we're making a FF and we may want D to update whenever the clock is on.
* As the complier now knows we're making a FF, we get the warning ```ff.v:6 Warning: Synthesis requires the sensitivity list of an always_ff process to only be edge sensitive. clk is missing a pos/negedge.```