The file **_ILSVRC2012.m_** contains the training and corresponding testing code for the neural network. The file **_Layer_graph.mat_** contains the network to be trained in this task. Before running **_ILSVRC2012.m_**, we need to replace the train function in the file **_Trainer.m_** with the train function in the file **_train.m_**. The file **_Trainer.m_** is usually located in the toolbox folder that comes with Matlab (the specific location is as follows: toolbox\nnet\cnn\+nnet\+internal\+cnn\Trainer.m).

Before training, please download the ILSVRC2012 data set from the website address https://image-net.org/ first (Training images & Validation images). Then, please organize the Training set and Validation set separately into two folders, **_Train_** and **_validation_**, and place these two folders directly into the current folder (**_ILSVRC2012_**). The structure of folders **_Train_** and **_validation_** is as follows.

|-- Train  
\. |-- n01440764  
    |   |-- picture1  
    |   |-- picture2  
    |   |-- picture3  
    |   |-- ......  
    |-- n01443537  
    |-- n01444850  
    |-- ......  
    
|-- Validation  
    |-- n01440764  
    |   |-- picture1  
    |   |-- picture2  
    |   |-- picture3  
    |   |-- ......  
    |-- n01443537  
    |-- n01444850  
    |-- ......  

The file **_net_pretrain.m_** contains a neural network trained using the LEM algorithm (our method) for your reference and testing. This file is also stored on the cloud drive above.
