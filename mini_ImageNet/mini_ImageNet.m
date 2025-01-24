load('Layer_graph.mat')

load('train_set.mat')

load('val_set.mat')

options = trainingOptions('sgdm','InitialLearnRate',0.01,'MaxEpochs',100, ...
    'Shuffle','every-epoch','ValidationFrequency',1875,'ExecutionEnvironment','auto', ...
    'Verbose',false,'Plots','training-progress','MiniBatchSize',128,'ValidationData',...
    {val_data , val_label },'LearnRateDropPeriod',40,'LearnRateDropFactor',0.1,...
    'LearnRateSchedule','piecewise','Momentum',0.9,'ResetInputNormalization',true,'L2Regularization',1e-4,...
    'OutputNetwork','last-iteration');


net = trainNetwork(train_data,train_label,lgraph,options);

% Testing the robustness of neural network weights
% i.e. the prediction accuracy after adding noise

% load('net_pretrain.mat') % Load the trained net

N = 300;

testPred = classify(net,val_data);

CNNAccuracy = sum(YPred_noiseNtimes == val_label)/numel(val_label);

fprintf('Baseline Accuracy =  %f:\n\n',CNNAccuracy);

Max_Bias = 1.0;

for delta = 0.2:0.2:1.0

    accuracy_noise_modifyNtimes = zeros(1,N);

    Layer_Num = [2 6 9 13 16 20 22 25 29 32 36 39 41 45 48 52 55 57 61 64 69];

    for i = 1:N
        modify_net = net.saveobj; 


        for num = 1:length(Layer_Num)
            RAND = randn(size(net.Layers(Layer_Num(num),1).Weights));
            RAND(RAND>Max_Bias) = Max_Bias;
            RAND(RAND<-Max_Bias) = -Max_Bias;        
            modify_net.Layers(Layer_Num(num),1).Weights = net.Layers(Layer_Num(num),1).Weights+...
                delta.*RAND.*net.Layers(Layer_Num(num),1).Weights;
        end                 

        modify_net = net.loadobj(modify_net);

        YPred_noiseNtimes = classify(modify_net,val_data);
        accuracy_noise_modifyNtimes(i) = sum(YPred_noiseNtimes == val_label)/numel(val_label);
    end
    fprintf('delta =  %f:\n',delta);
    accuracy_noiseNtimes_final = sum(accuracy_noise_modifyNtimes) / N;
    fprintf('Mean Value: %f\n',accuracy_noiseNtimes_final);
    fprintf('Min Value: %f\n',min(accuracy_noise_modifyNtimes));
    fprintf('Max Value: %f\n',max(accuracy_noise_modifyNtimes));
    fprintf('Variance: %f\n\n',sqrt(var(100*accuracy_noise_modifyNtimes)));
end
