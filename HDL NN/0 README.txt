==============================================================================================================
== On-Chip Spike Detection and Classification using Neural Networks and Approximate Computing				==
==																											==
== Efstratios Zacharelos,			Ciro Scognamillo, 			Ettore Napoli, 		Diego Gragnaniello		==
== efstratios.zacharelos@unina.it,	ciro.scognamillo@unina.it,	enapoli@unisa.it,	digragnaniello@unisa.it ==
==============================================================================================================


================== Introduction  =================

This file contains a brief explanation of the HDL-verilog code that describes the hardware implementation of the spike detection and classification Neural Network.
This code can describe any simple dense neural nework by modifying the parameters and input files accordingly.
For a better understanding of the code, reading the paper is advised!


== Information on the Bit-width of the signals ==

Choosing a short bit-width for the fractional part of the signals increases the quantization error, as the floating-point parameters are heavily truncated. 
On the other hand, opting for longer signals results in heavy hardware requirements.
According to the desired bit-width of the parameters and the inputs, three versions of the network are developed.
1) Bit-width = 12, (4 bits before the radix point, 8 bits after the radix point) [pre-selected]
2) Bit-width = 10, (4 bits before the radix point, 6 bits after the radix point)
3) Bit-width =  8, (3 bits before the radix point, 5 bits after the radix point)


============ Changing the Bit-width ============

To change the bit-width of your ANN to X bits (X being 8, 10, or 12), you need to do three steps:
1) Copy the contents of the corresponding parameters file ("parametersXbits.txt") to the "parameters.txt" file.
2) Copy the contents of the corresponding input file ("3comma5_inputSample_originalNN_groundTruth.txt", "4comma6_inputSample_originalNN_groundTruth.txt", or "4comma8_inputSample_originalNN_groundTruth.txt") to the "input.txt" file.
3) Choose the correct truncation option for the multiplier ("multiplier.v") (lines 20-22).
4) In case the 8-bits signals version is selected, enable saturation (see next section).


============== Signal Saturation  ==============

If the 8-bits version is selected, overflowing signals may appear leading to very bad results.
To avoid that, either choose a different architecture with more bits, or enable saturated signals to partially tackle the problem.
Saturation is enabled by modifying the "Neuron.v" file:
1) Uncomment line 25
2) Uncomment line 82
3) Comment line 91
4) Uncomment line 92


================== Input File ==================

Input files contain triplets of consecutive data that correspond to the binary input, the output of the original network in binary trained by TensorFlow, and the ground truth.
Input files contain 2,840,448 consecutive input samples. 
Each 32 samples constitute an input window to be processed.
There are 88,764 windows.
For faster simulations you may consider less inputs and smaller bit-widths.


================= Output Test  =================

Use the matlab file ("accuracies.m") to obtain the accuracy of your simulated network by processing the generated "output.txt" file.
Note: 
The first three generated outputs correspond to rubbish stored in the pipeline.
The fourth output corresponds to the first window, the fifth output to the second window, and so on...


============ Approximate Multiplier ============

The user may modify the multiplier file ("multiplier.v") to test an alternative approximate multiplier.