# Simulator for 1-Dimensional cellular automata

## Configuration:

*input*: Array of binary values to set on the initial row

*inputRepeat*: If true repeats the input on the entire initial row

*cornerValueLeft/-Right*: Value of the cell outside of simulation bounds

*backgroundC/foregroundC*: Color of dead/live cells (as RGB value)

*save*: If true saves the image as png

*ruleNr*: Used as a binary number to define the rule

Example for Rule105:

| 111 | 110 | 101 | 100 | 011 | 010 | 001 | 000 |
| --- | --- | --- | --- | --- | --- | --- | --- |
|  0  |  1  |  1  |  0  |  1  |  0  |  0  |  1  |

The binary value of this rule is 01101001, which is 105 in decimal

![Rule105 with a single central dot in the initial row](/Rule105.png)