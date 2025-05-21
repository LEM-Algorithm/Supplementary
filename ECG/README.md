The file ECG contains the training and corresponding testing code for the neural network. Before running ECG, we need to replace the train function in the file Trainer with the train function in the file train. The file Trainer is usually located in the toolbox folder that comes with Matlab (the specific location is as follows: toolbox\nnet\cnn\+nnet\+internal\+cnn\Trainer.m).
The file ECG_Data contains the training set and the test set.
The file net_pretrain contains a neural network trained using the LEM algorithm (our method) for your reference and testing.
