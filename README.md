# EPICS device support for Thorlabs BBD203 motor controller

This is EPICS device support IOC for a Thorlabs motor controller with support for three motor: BBD203 Brushless DC Servo Controller. 

It has been used on slit motor DDS300 Direct Drive Translation Stage.


## IOC


IOC uses StreamDevice for communication.

Communication protocol is binary based, with header and data parts, all defined with HEX and little endian.

Seems that addressing modules and channels is actually addressing directly memory on controller. Therefore:

* There is not end of line termination. Therefore StreamDevice waits readtimeout = 100; for communication to finish.

* All values are binary hex bytes.

* NOTE! Address for module is different weather message has only header or header and data part.

* Reading status from all three modules in a loop does not work and only first module is read, for some reason. So IOC reads one module at a time.

NOTE! If IOC issues questions faster that they are answered, then output buffer on processor gets overflowed and processor get stuck. See Reset procedure to get out of this.

Updates are rather slow, there is significant delay between any command and value update. 


## CSS GUI Panels

Panel module is located in CSS folder.



## Copyright / License

This EPICS device support is licensed under the terms of the [MIT license](LICENSE) by 
[Karlsruhe Institute of Technology's Institute of Beam Physics and Technology](https://www.ibpt.kit.edu/) 
and was developed by [igor@scictrl.com](http://scictrl.org).
