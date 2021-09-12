# CPRE 381 (Fall 2020)
In this course I created a simple computer processor. The early labs help to prepare us for when we would be implementing both a single-cycle and a pipelined processor. Pretty much all the labs required us to use VHDL to represent logical operations. A lot of the labs have the test bench outputs included to verify functionality.

###### Lab 1
We didn't really make anything in this lab. Just used files created by our instructor to get oriented to ModelSim.

###### Lab 2
Create a unit to take the one's complement of a number. Also create a two to one MUX. Create a functional full adder. Lastly, create a Fully functioning adder/subtractor arithmetic logic unit (ALU).

###### Lab 3
Begin working with stored (register) values. Create a decoder and a MUX for the Microprocessor without Interlocked Pipelined Stages (MIPS) application. Finally, implement MIPS application that is capable of adding/subtracting values in addition to storing them.

###### Lab 4
Use the previously created MIPS app, but now store the calculated values in memory (RAM). Also create a signed number extender so components can communicate if they are not working with the same width bus.

###### Project A
In Project A we were tasked with creating a 32-bit arithmetic logic unit (ALU). In addidion to the ALU, a barrel shifter needed to be created for multiplication / division. As this would be a lot of work for one person, I primarily worked with the 32-bit ALU's functionality.

###### Project B
In Project B we moved on to making a single-cycle processor. My main task in my group was to ensure the instruction decoder was working properly. Pretty much every compoenent we created needed to be used in this processor, so there was a large number of files included in the final design. To verify, we used a test script provided by our professor.

###### Project C
In our final project we were to turn our single-cycle processor into a pipelined processor. This involved adding some equality checks and adding the actual pipeline stages where needed. We mainly got the design of the pipeline processor down as this semsester was heavily affected by COVID-19.
