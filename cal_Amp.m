clear;
InSAR_input = readmatrix('HR04.csv', 'OutputType', 'string');
time_D=InSAR_input(1,5:end);
def_D=str2double(InSAR_input(2,5:end));

time_insar=datenum(time_D,'yyyy-mm-dd')-datenum(time_D(1),'yyyy-mm-dd')+1;
time_insar=transpose(time_insar);
time_inter=[1:12:time_insar(end)];
def_interp=interp1(time_insar,def_D,time_inter);
time_notrend=time_inter-1+datenum(time_D(1),'yyyy-mm-dd');

%%去线性趋势
def_D_notrend=detrend(def_interp,1);

%转为十进制年
decyear = datenum2decyear(time_notrend(:));

y=def_D_notrend';
t=decyear;
% 简化后的傅里叶级数函数（仅含常数项、线性趋势和年周期项）
fourierFunc = @(b, t) b(1) + b(2)*t + b(3)*cos(2*pi*t) + b(4)*sin(2*pi*t);

% 初始参数猜测（4个参数）
initialGuess = [mean(y), 0, 0, 0];

% 执行拟合
options = optimset('Display','off');
[beta, resnorm] = lsqcurvefit(fourierFunc, initialGuess, t, y, [], [], options);

% 提取参数
A0 = beta(1);  % 常数项
A1 = beta(2);  % 线性趋势
A2 = beta(3);  % 年周期余弦振幅
B2 = beta(4);  % 年周期正弦振幅

% 计算年周期振幅和相位
annual_amp = sqrt(A2^2 + B2^2);
annual_phase = atan2(B2, A2);








function decyear = datenum2decyear(dn)
    % 将datenum值转换为十进制年
    % 输入：dn - datenum值（标量或向量）
    % 输出：decyear - 十进制年
    % 获取日期向量 [年,月,日,时,分,秒]
    dateVec = datevec(dn);
    
    % 提取年份
    years = dateVec(:,1);
    
    % 计算每年1月1日的datenum
    jan1 = datenum([years, ones(size(years)), ones(size(years))]);
    
    % 计算下一年1月1日的datenum
    next_jan1 = datenum([years+1, ones(size(years)), ones(size(years))]);
    
    % 计算每年的总天数
    days_in_year = next_jan1 - jan1;
    
    % 计算当前日期在一年中的位置（从0开始）
    day_of_year = dn - jan1;
    
    % 计算十进制年
    decyear = years + day_of_year ./ days_in_year;
end