%% 海洋声信道数据生成主流程 - 多声源叠加
% 输入参数:
%   oriDataPath - 原始音频数据路径 | Raw audio data path
%   ocnDataPath - 生成数据存储路径 | Generated data storage path
%   numCombinations - 要生成的组合音频文件数量 | Number of combined audio files to generate
%
% 主要功能:
%   1. 加载BELLHOP仿真结果（两个不同的环境）
%   2. 应用声场传播模型到两个不同位置的音频数据
%   3. 将两个处理后的音频叠加为一个文件
%   4. 重复此过程指定次数，生成多个不同的组合文件
%
%%
% 文件结构
% -0
% --0_0_x.wav
% -1
% --1_0_x.wav

%% 准备条件
oriDataPath = "D:\data_gen\shipsear_5s_16k";                % 原始数据文件夹路径
ocnDataPath = "D:\data_gen\shipsear_5s_16k_combine\2_3\2km";    % 扩充数据文件夹路径
numComb = 50;   % 要生成的组合音频文件数量

folderA = fullfile(oriDataPath, '2');   % 获取A和B文件夹的路径,与ocnDataPath对应即可
folderB = fullfile(oriDataPath, '3');

if ~exist(ocnDataPath, 'dir')
    mkdir(ocnDataPath)
end

envConfig1 = 'Pos1Azi1freq100Hz';   % 定义两个不同的环境配置   
envConfig2 = 'Pos1Azi1freq100Hz_1';    

bellhop(envConfig1)     % 加载两个环境的BELLHOP仿真结果
[Arr1, Pos1] = read_arrivals_asc([envConfig1 '.arr']);      % Arr1/Pos1: 第一个环境的延迟、幅度、距离和深度信息
bellhop(envConfig2)  
[Arr2, Pos2] = read_arrivals_asc([envConfig2 '.arr']);      % Arr2/Pos2: 第二个环境的延迟、幅度、距离和深度信息

if ~exist(folderA, 'dir') || ~exist(folderB, 'dir')
    error('A or B folder does not exist in the original data path');
end

% 获取A和B文件夹中的所有wav文件
wavFilesA = dir(fullfile(folderA, '**', '*.wav'));
wavFilesB = dir(fullfile(folderB, '**', '*.wav'));

if isempty(wavFilesA) || isempty(wavFilesB)
    error('No wav files found in A or B folder');
end

fprintf('Found %d files in A folder and %d files in B folder\n', length(wavFilesA), length(wavFilesB));

% 创建记录所有组合信息的文件
allInfoFilePath = fullfile(ocnDataPath, 'all_combinations_info.txt');
fidAll = fopen(allInfoFilePath, 'wt');
fprintf(fidAll, 'All Combined Audio Information:\n');
fprintf(fidAll, 'Total combinations generated: %d\n', numComb);
fprintf(fidAll, '===================================\n');
fprintf(fidAll, 'Combination \tOutput file \tSource A file \tSource A Env \tSource A Dist(km) \tSource A Depth(m) \tSource B file \tSource B Env \tSource B Dist(km) \tSource B Depth(m)\n');
fprintf(fidAll, '-----------------------------------\n');

%% 批量生成多个组合音频文件
for combIdx = 1:numComb
    fprintf('Processing combination %d/%d...\n', combIdx, numComb);
     
    selectedFileA = wavFilesA(randi(length(wavFilesA)));    % 随机选择一个音频文件
    selectedFileB = wavFilesB(randi(length(wavFilesB)));

    fprintf('  Selected file from A: %s\n', selectedFileA.name);
    fprintf('  Selected file from B: %s\n', selectedFileB.name);

    % 读取选中的音频文件
    [y1, fs1] = audioread(fullfile(selectedFileA.folder, selectedFileA.name));
    [y2, fs2] = audioread(fullfile(selectedFileB.folder, selectedFileB.name));

    if fs1 ~= fs2  % 确保采样率相同
        error('The two selected audio files have different sampling rates');
    end
    fs = fs1;

    % 对输入音频进行归一化处理，使两个原始音频信号的幅度范围保持一致 
    y1 = funNorm(y1);
    y2 = funNorm(y2);

    % 随机分配位置索引
    k1 = randi(length(Pos1.r.r));   % A音频的距离索引 (第一个环境)
    n1 = randi(length(Pos1.r.z));   % 深度索引
    k2 = randi(length(Pos2.r.r));   % B音频的距离索引 (第二个环境) 
    n2 = randi(length(Pos2.r.z));   % 深度索引

    % 提取音频的传播参数
    Arr_A1 = double(Arr1(k1, 1, n1).A);     % 振幅归一化
    Arr_TAU1 = double(Arr1(k1, 1, n1).delay - min(Arr1(k1, 1, n1).delay));  % 相对延迟
    Arr_A2 = double(Arr2(k2, 1, n2).A);     
    Arr_TAU2 = double(Arr2(k2, 1, n2).delay - min(Arr2(k2, 1, n2).delay)); 

    y_out1 = funMulti_Eff(y1, fs, Arr_A1, Arr_TAU1);  %  应用海洋声传播模型
    y_out2 = funMulti_Eff(y2, fs, Arr_A2, Arr_TAU2);  % B音频在指定环境下的传播结果  

    y_combined = y_out1 + y_out2;   % 叠加两个音频信号
    y_combined = funNorm(y_combined);   % 归一化组合后的信号

    outputFileName = sprintf('combined_%03d.wav', combIdx);     % 生成输出文件名（包含组合编号）
    outputFilePath = fullfile(ocnDataPath, outputFileName);
    
    audiowrite(outputFilePath, y_combined, fs);     % 保存叠加后的音频文件

    % 记录到总信息文件
    fprintf(fidAll, '%d\t %s\t %s\t %s\t %.2f\t %.2f\t %s\t %s\t %.2f\t %.2f\n', ...
        combIdx, outputFileName, selectedFileA.name, envConfig1, Pos1.r.r(k1)/1e3, Pos1.s.z(n1), ...
        selectedFileB.name, envConfig2, Pos2.r.r(k2)/1e3, Pos2.s.z(n2));
    
    fprintf('  Combination %d completed. Output file: %s\n', combIdx, outputFileName);
end

fclose(fidAll);
fprintf('Processing completed!\n');
fprintf('Generated %d combined audio files in: %s\n', numComb, ocnDataPath);
fprintf('All combinations info saved to: %s\n', allInfoFilePath);
%% 保存配置信息
data.Rrmax1 = Pos1.r.r(end)/1e3;
data.Szmax1 = Pos1.s.z(end)/1e3;
data.Rrmax2 = Pos2.r.r(end)/1e3; 
data.Szmax2 = Pos2.s.z(end)/1e3;
data.NumCombinations = numComb;

datajson = jsonencode(data);
fid = fopen(fullfile(ocnDataPath, 'config.json'), 'wt');
fprintf(fid, '%s', datajson);
fclose(fid);
