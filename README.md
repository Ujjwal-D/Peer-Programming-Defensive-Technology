# Peer-Programming-Defensive-Technology
This repo handles codes and their results testing defensive technology.

To run defend.ps1 follow the steps below:
1. Run the program file ' defend.ps1 '
2. In command line type the syntax: .\defend.ps1 function_name [Example: .\defend.ps1 testwdac]
3. Here is list of function_name to choose:
   a. testwdac : tests if specified program (keyfinder.txt) runs or not.
   b. setupwdac : sets up the xml policy file to binary file.
   c. enablewdac : enables the WDAC policy file which defends installation of specified program.
   d. resetwdac : resets the WDAC policy state to disabled and restarts computer.

Download keyfinder application in the local computer.
The local repository to find the specific policy xml file: C:\Windows\schemas\CodeIntegrity\ExamplePolicies
Move the respective xml file to Desktop directory in local machine. Rename it as ' MyWDACPolicy.xml ' to resonate with script.
