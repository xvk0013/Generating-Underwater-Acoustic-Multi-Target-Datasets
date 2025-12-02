function y_out_norm = funNorm(y_out)
% 对信号做均值归一化处理
y_out = y_out - mean(y_out); % 0均值处理
y_out_norm = y_out / max(abs(y_out))/1.1; % 归一化处理，但是让最大值为1/1.1=0.9091