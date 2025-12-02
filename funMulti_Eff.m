function y = funMulti_Eff(x, fs, Amp, tau)
% 海洋环境多径效应建模函数 | Ocean Multipath Effect Modeling
% 输入参数:
%   x   : 输入时域信号 (N×1 vector)
%   fs  : 采样频率 (Hz)
%   Amp : 多径幅度向量 (M×1 vector)
%   tau : 多径时延向量 (M×1 vector, 单位：秒)
% 输出参数:
%   y   : 带多径效应的输出信号 (N×1 vector)
% 算法原理:
%   1. 对输入信号做FFT得到频域表示
%   2. 计算各多径分量的相位延迟（相位=2πfτ）
%   3. 频域叠加多径分量
%   4. IFFT恢复时域信号

Fx = fft(x).';
[~, indmx ] = max(abs(Amp));
tau = tau - tau(indmx);  % 相对时延调整 | Relative delay adjustment
tau = tau.'; 
fk = (0: length(x)-1)/ length(x) * fs;

% 频域相位延迟计算 | Frequency domain phase delay calculation
Fy = Amp * (exp(-1j * 2 * pi * tau * fk) .* (ones(length(Amp), 1) * Fx));

y =  ifft(Fy, 'symmetric');

end