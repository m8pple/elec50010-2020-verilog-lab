* The issue is that y overflows while y_expected doesn't.
* The compiler doesn't warn you.
* Make y_expected overflow as well by capping it to 255.