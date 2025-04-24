clear;
figure;set(gcf,'Position',[100,100,500,350],'color','w');
tmp_D = readmatrix('HR01.csv', 'OutputType', 'string');
time_D=tmp_D(1,5:end);
def_D=str2double(tmp_D(2,5:end));

time_insar=datenum(time_D,'yyyy-mm-dd')-datenum(time_D(1),'yyyy-mm-dd')+1;
time_insar=transpose(time_insar);
time_inter=[1:12:time_insar(end)];
def_interp=interp1(time_insar,def_D,time_inter);

time_notrend=time_inter-1+datenum(time_D(1),'yyyy-mm-dd');

def_D_notrend=detrend(def_interp,1);
% def_D_notrend=def_interp;
% def_D_notrend=detrend(def_interp,1);

%%
figure;set(gcf,'Position',[100,100,500,350],'color','w');
wt(def_D_notrend);
time=[64 128 256 512];
y_cwt_true = log2(time / 12);
yticks(y_cwt_true);
cell_y_cwt = cellfun(@num2str, num2cell(time), 'UniformOutput', false);
str_yt_cwt = string(cell_y_cwt);
yticklabels(str_yt_cwt);
date_index=[1 xticks];
set(gca,'XTick',date_index);
xticklabels(datestr(time_notrend(date_index+1),'mm.yyyy'));
% ylabel('Period (days)','Color','black');
% xlabel('Time');
set(gca,'fontsize',10,'FontName','Times New Roman');
%%

% cwt(def_D_notrend);
% [cab,f]=cwt(def_D_notrend);
% 
% ylim([f(end),f(1)]);
% time=[64 128 256 512];
% fs=12./time;
% fs=fliplr(fs);
% time=fliplr(time);
% set(gca,'YTick',fs);
% cell_yt_time=cellfun(@num2str, num2cell(time), 'UniformOutput', false);
% str_yt_time=string(cell_yt_time);
% yticklabels(str_yt_time);
% 
% date_index=xticks;
% xticklabels(datestr(time_notrend(date_index+1),'mm.yyyy'));
% datestr(datenum(time_D,'yyyy-mm-dd'),'mm.yyyy');

% caxis([0 18]);
% year = {'2015-04-01' '2016-01-01' '2017-01-01' '2018-01-01' '2019-01-01' '2020-01-01' '2021-01-01' '2022-01-01' '2023-01-01' '2024-01-01' '2025-01-01'};
% idx_matrix = zeros(size(year));
% for i = 1:numel(year)
%     [~, idx_matrix(i)] = min(abs(datenum(time_D,'yyyy-mm-dd') - datenum(year(i),'yyyy-mm-dd')));
% end
% set(gca,'XTick',idx_matrix);
% %xticklabels({'2021' '2022' '2023' '2024'});
% xticklabels({'04.2015','01.2016','01.2017','01.2018','01.2019','01.2020','01.2021','01.2022','01.2023','01.2024','01.2025'});
% ylabel('Period (days)','Color','black');
% xlabel('Time');
% set(gca,'fontsize',12,'FontName','Times New Roman');

%% 
temp_D = readmatrix('Temp_final.csv', 'OutputType', 'string');
time_temp=temp_D(1,:);
temp=str2double(temp_D(2,:));

[~, idx] = ismember(time_notrend, datenum(time_temp,'yyyy-mm-dd'));  % idx 是日期相同的索引


figure;set(gcf,'Position',[100,100,500,350],'color','w');
xwt(temp(idx),def_D_notrend);
[Wxy,period,scale,coi,sig95]=xwt(temp(idx),def_D_notrend);
aWxy=angle(Wxy);
% figure;set(gcf,'Position',[100,100,500,350],'color','w');
% imagesc(aWxy);
% [xfs,fre]=xwt(temp(idx),def_D_notrend);

%%
time=[64 128 256 512];
y_xwt_true = log2(time / 12);
yticks(y_xwt_true);
cell_y_xwt = cellfun(@num2str, num2cell(time), 'UniformOutput', false);
str_yt_xwt = string(cell_y_xwt);
yticklabels(str_yt_xwt);
date_index=[1 xticks];
set(gca,'XTick',date_index);
xticklabels(datestr(time_notrend(date_index+1),'mm.yyyy'));
% ylabel('Period (days)','Color','black');
% xlabel('Time');
set(gca,'fontsize',10,'FontName','Times New Roman');
%%
figure;set(gcf,'Position',[100,100,500,350],'color','w');
wtc(temp(idx),def_D_notrend);
time=[64 128 256 512];
y_wtc_true = log2(time / 12);
yticks(y_wtc_true);
cell_y_wtc = cellfun(@num2str, num2cell(time), 'UniformOutput', false);
str_yt_wtc = string(cell_y_wtc);
yticklabels(str_yt_wtc);
date_index=[1 xticks];
set(gca,'XTick',date_index);
xticklabels(datestr(time_notrend(date_index+1),'mm.yyyy'));
% ylabel('Period (days)','Color','black');
% xlabel('Time');
set(gca,'fontsize',10,'FontName','Times New Roman');

% % year = {'2004-01-01' '2005-01-01' '2006-01-01' '2007-01-01' '2008-01-01' '2009-01-01' '2010-01-01' '2011-01-01' '2012-01-01' '2013-01-01' '2014-01-01' '2015-01-01' '2016-01-01' '2017-01-01' '2018-01-01' '2019-01-01' '2020-01-01' '2021-01-01' '2022-01-01' '2023-01-01' };
% 
% % year = { '2011-01-01' '2012-01-01' '2013-01-01' '2014-01-01' '2009-01-01' '2010-01-01' '2011-01-01' '2012-01-01' '2013-01-01' };
% idx_matrix = zeros(size(year));
% for i = 1:numel(year)
%     [~, idx_matrix(i)] = min(abs(time_shuizhun(:) - datenum(year(i),'yyyy-mm-dd')));
% end
% set(gca,'XTick',idx_matrix);
% % xticklabels({'2004' '2005' '2006' '2007' '2008' '2009' '2010' '2011' '2012' '2013' '2014' '2015' '2016' '2017' '2018' '2019' '2020' '2021' '2022' '2023'});
% xticklabels({ '2005' '2006' '2007' '2008' '2009' '2010' '2011' '2012' '2013'});