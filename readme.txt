
This package contains five MATLAB-related files in total.

Among them, `test.m` is the main file and provides a prototype implementation of the algorithm. Reviewers may use this file to understand the basic iterative procedure of the proposed method. It should be noted that the example used in `test.m` is a simplified version of Model 2. Therefore, the main purpose of this file is to illustrate the core idea and implementation framework of the algorithm, rather than to directly reproduce all the results reported in the paper.

`hafl.m` and `restore.m` are auxiliary functions called by `test.m`, and they are used to support the corresponding computations in the main program.

`model1.slx` is the Simulink file for Model 1. It contains the relevant data, control law, and disturbance settings for Model 1. The `Scope` block shows the output responses under both uncontrolled and controlled cases. The control input is obtained by multiplying the multi-segment delayed outputs by the control law.

`model2.slx` is the Simulink file for Model 2, which likewise contains the relevant information for Model 2, including the model data, control law, and other required settings. The detailed information on the model matrices, control law, observation period, and the number of delayed outputs has already been provided in the manuscript.

It should be emphasized that the control laws for `model1` and `model2` cannot be obtained directly by simply modifying the matrix information contained in `test.m`. The code in `test.m` is only a preliminary implementation of the algorithm and still differs from the complete procedure required to compute the results for Models 1 and 2 in the paper. Nevertheless, this file is sufficient to demonstrate the core content of the algorithm, while `model1.slx` and `model2.slx` are adequate for verifying the correctness and validity of the reported results.

