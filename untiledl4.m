clear all;
clc;
% 定义指标范围
pulseRange = [60, 100];
bpRange = [90, 140];
ecgRange = [0, 1]; % 假设心电图复杂性范围为0到1
heartAmbiguityRange = [0, 10];

altRange = [7, 56];
astRange = [10, 40];
imagingRange = [0, 1]; % 假设影像学复杂性范围为0到1
liverAmbiguityRange = [0, 10];

tongueCoatingRange = [0, 1]; % 假设舌苔厚度范围为0到1
appetiteRange = [0, 1]; % 假设食欲范围为0到1
digestionRange = [0, 1]; % 假设消化功能范围为0到1
spleenAmbiguityRange = [0, 10];

fev1fvcRange = [70, 100];
breathRateRange = [12, 20];
spo2Range = [0.95, 1];
lungAmbiguityRange = [0, 10];

creatinineRange = [0.5, 1.2];
bunRange = [7, 20];
urineRange = [0, 1]; % 假设尿液复杂性范围为0到1
kidneyAmbiguityRange = [0, 10];

% 示例数据（十个患者）
data = [
72, 120, 0.6, 5, 25, 35, 0.7, 5, 0.5, 0.8, 0.6, 5, 85, 15, 0.97, 5, 1.1, 15, 0.6, 5;
65, 110, 0.4, 4, 30, 28, 0.8, 6, 0.3, 0.9, 0.7, 6, 80, 18, 0.98, 6, 1.0, 16, 0.5, 6;
70, 115, 0.5, 4.5, 28, 30, 0.75, 5.5, 0.4, 0.85, 0.65, 5.5, 82, 16, 0.975, 5.5, 1.05, 15.5, 0.55, 5.5;
68, 112, 0.45, 4.2, 29, 29, 0.78, 5.8, 0.35, 0.87, 0.68, 5.8, 81, 17, 0.98, 5.8, 1.02, 15.8, 0.52, 5.8;
66, 108, 0.42, 4.1, 27, 31, 0.77, 5.6, 0.32, 0.88, 0.66, 5.6, 79, 17.5, 0.985, 5.6, 1.03, 15.6, 0.53, 5.6;
71, 118, 0.55, 4.8, 26, 34, 0.72, 5.3, 0.48, 0.83, 0.62, 5.3, 83, 16.5, 0.96, 5.3, 1.07, 15.3, 0.58, 5.3;
69, 113, 0.48, 4.3, 32, 27, 0.79, 6.1, 0.37, 0.89, 0.69, 6.1, 78, 18, 0.99, 6.1, 1.0, 16.1, 0.54, 6.1;
64, 105, 0.35, 3.8, 33, 25, 0.82, 6.3, 0.28, 0.91, 0.71, 6.3, 77, 18.5, 1.0, 6.3, 0.98, 16.3, 0.51, 6.3;
74, 122, 0.65, 5.2, 24, 36, 0.69, 5.2, 0.53, 0.81, 0.61, 5.2, 86, 14.5, 0.95, 5.2, 1.09, 14.5, 0.61, 5.2;
63, 102, 0.32, 3.6, 34, 23, 0.85, 6.5, 0.25, 0.92, 0.72, 6.5, 76, 19, 1.01, 6.5, 0.97, 16.5, 0.5, 6.5
];

% 标准化处理
data_std = zeros(size(data));
data_std(:, 1) = standardize(data(:, 1), pulseRange(1), pulseRange(2));
data_std(:, 2) = standardize(data(:, 2), bpRange(1), bpRange(2));
data_std(:, 3) = standardize(data(:, 3), ecgRange(1), ecgRange(2));
data_std(:, 4) = standardize(data(:, 4), heartAmbiguityRange(1), heartAmbiguityRange(2));

data_std(:, 5) = standardize(data(:, 5), altRange(1), altRange(2));
data_std(:, 6) = standardize(data(:, 6), astRange(1), astRange(2));
data_std(:, 7) = standardize(data(:, 7), imagingRange(1), imagingRange(2));
data_std(:, 8) = standardize(data(:, 8), liverAmbiguityRange(1), liverAmbiguityRange(2));

data_std(:, 9) = standardize(data(:, 9), tongueCoatingRange(1), tongueCoatingRange(2));
data_std(:, 10) = standardize(data(:, 10), appetiteRange(1), appetiteRange(2));
data_std(:, 11) = standardize(data(:, 11), digestionRange(1), digestionRange(2));
data_std(:, 12) = standardize(data(:, 12), spleenAmbiguityRange(1), spleenAmbiguityRange(2));

data_std(:, 13) = standardize(data(:, 13), fev1fvcRange(1), fev1fvcRange(2));
data_std(:, 14) = standardize(data(:, 14), breathRateRange(1), breathRateRange(2));
data_std(:, 15) = standardize(data(:, 15), spo2Range(1), spo2Range(2));
data_std(:, 16) = standardize(data(:, 16), lungAmbiguityRange(1), lungAmbiguityRange(2));

data_std(:, 17) = standardize(data(:, 17), creatinineRange(1), creatinineRange(2));
data_std(:, 18) = standardize(data(:, 18), bunRange(1), bunRange(2));
data_std(:, 19) = standardize(data(:, 19), urineRange(1), urineRange(2));
data_std(:, 20) = standardize(data(:, 20), kidneyAmbiguityRange(1), kidneyAmbiguityRange(2));

% 层次分析法权重（假设通过专家判断得出）
W_AHP_heart = [0.25, 0.25, 0.25, 0.25];
W_AHP_liver = [0.25, 0.25, 0.25, 0.25];
W_AHP_spleen = [0.25, 0.25, 0.25, 0.25];
W_AHP_lung = [0.25, 0.25, 0.25, 0.25];
W_AHP_kidney = [0.25, 0.25, 0.25, 0.25];

% 计算熵权法权重
W_EWM_heart = calculateEntropyWeight(data_std(:, 1:4));
fprintf(' 心脏: %.2f, %s, %s, %s\n', W_EWM_heart(:,1),W_EWM_heart(:,2),W_EWM_heart(:,3),W_EWM_heart(:,4));
W_EWM_liver = calculateEntropyWeight(data_std(:, 5:8));
fprintf(' 心脏: %.2f, %s, %s, %s\n', W_EWM_heart(:,1),W_EWM_heart(:,2),W_EWM_heart(:,3),W_EWM_heart(:,4));
W_EWM_spleen = calculateEntropyWeight(data_std(:, 9:12));
W_EWM_lung = calculateEntropyWeight(data_std(:, 13:16));
W_EWM_kidney = calculateEntropyWeight(data_std(:, 17:20));

% 计算综合权重（假设alpha = 0.5）
alpha = 0.5;
W_final_heart = calculateFinalWeight(W_AHP_heart, W_EWM_heart, alpha);
W_final_liver = calculateFinalWeight(W_AHP_liver, W_EWM_liver, alpha);
W_final_spleen = calculateFinalWeight(W_AHP_spleen, W_EWM_spleen, alpha);
W_final_lung = calculateFinalWeight(W_AHP_lung, W_EWM_lung, alpha);
W_final_kidney = calculateFinalWeight(W_AHP_kidney, W_EWM_kidney, alpha);

% 计算每个患者的综合健康状态指数、阴阳状态，并进行分层分级
for i = 1:size(data, 1)
% 心脏
Heart_Index = calculateOrganIndex(data_std(i, 1:4), W_final_heart);
Heart_Status = judgeYinYang(Heart_Index);
[Heart_Layer, Heart_Grade] = stratifyAndGrade(Heart_Index, data_std(i, 1), data_std(i, 2), data_std(i, 3), data_std(i, 4));
% 肝脏
Liver_Index = calculateOrganIndex(data_std(i, 5:8), W_final_liver);
Liver_Status = judgeYinYang(Liver_Index);
[Liver_Layer, Liver_Grade] = stratifyAndGrade(Liver_Index, data_std(i, 5), data_std(i, 6), data_std(i, 7), data_std(i, 8));
% 脾脏
Spleen_Index = calculateOrganIndex(data_std(i, 9:12), W_final_spleen);
Spleen_Status = judgeYinYang(Spleen_Index);
[Spleen_Layer, Spleen_Grade] = stratifyAndGrade(Spleen_Index, data_std(i, 9), data_std(i, 10), data_std(i, 11), data_std(i, 12));
% 肺脏
Lung_Index = calculateOrganIndex(data_std(i, 13:16), W_final_lung);
Lung_Status = judgeYinYang(Lung_Index);
[Lung_Layer, Lung_Grade] = stratifyAndGrade(Lung_Index, data_std(i, 13), data_std(i, 14), data_std(i, 15), data_std(i, 16));
% 肾脏
Kidney_Index = calculateOrganIndex(data_std(i, 17:20), W_final_kidney);
Kidney_Status = judgeYinYang(Kidney_Index);
[Kidney_Layer, Kidney_Grade] = stratifyAndGrade(Kidney_Index, data_std(i, 17), data_std(i, 18), data_std(i, 19), data_std(i, 20));
% 输出结果
fprintf('患者 %d:\n', i);
fprintf(' 心脏: 指数 = %.2f, 状态 = %s, 分层 = %s, 分级 = %s\n', Heart_Index, Heart_Status, Heart_Layer, Heart_Grade);
fprintf(' 肝脏: 指数 = %.2f, 状态 = %s, 分层 = %s, 分级 = %s\n', Liver_Index, Liver_Status, Liver_Layer, Liver_Grade);
fprintf(' 脾脏: 指数 = %.2f, 状态 = %s, 分层 = %s, 分级 = %s\n', Spleen_Index, Spleen_Status, Spleen_Layer, Spleen_Grade);
fprintf(' 肺脏: 指数 = %.2f, 状态 = %s, 分层 = %s, 分级 = %s\n', Lung_Index, Lung_Status, Lung_Layer, Lung_Grade);
fprintf(' 肾脏: 指数 = %.2f, 状态 = %s, 分层 = %s, 分级 = %s\n', Kidney_Index, Kidney_Status, Kidney_Layer, Kidney_Grade);
end
% 标准化函数
function normValue = standardize(value, minValue, maxValue)
normValue = (value - minValue) / (maxValue - minValue);
normValue = max(0, min(1, normValue)); % 确保标准化值在0到1之间
end

% 计算熵权
function W_EWM = calculateEntropyWeight(data)
[n, m] = size(data);
P = data ./ sum(data); % 计算比重
E = -sum(P .* log(P + eps)) / log(n); % 计算熵值
W = 1 - E; % 计算熵权
W_EWM = W / sum(W); % 归一化处理
end

% 计算综合权重
function W_final = calculateFinalWeight(W_AHP, W_EWM, alpha)
W_final = alpha * W_AHP + (1 - alpha) * W_EWM;
end

% 计算脏器综合健康状态指数
function organIndex = calculateOrganIndex(data_std, weights)
organIndex = sum(data_std .* weights);
end

% 判断阴阳状态
function status = judgeYinYang(index)
if index > 0.75
status = '阳盛';
elseif index < 0.25
status = '阴虚';
else
status = '阴阳平衡';
end
end

% 分层分级函数
function [layer, grade] = stratifyAndGrade(index, V, U, C, A)
if index > 0.75
layer = '健康层';
grade = '健康';
elseif index < 0.25
layer = '疾病层';
if V > 0.5
grade = '易变性高';
elseif U > 0.5
grade = '不确定性高';
elseif C > 0.5
grade = '复杂性高';
else
grade = '模糊性高';
end
else
layer = '亚健康层';
if V > 0.5
grade = '一级亚健康';
elseif U > 0.5
grade = '二级亚健康';
else
grade = '三级亚健康';
end
end
end


