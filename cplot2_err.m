% % 实测数据的作�?
% % function [] = myplot4(ns, nolayer, pset, total_depth, delta_pset)
% clear
% % close all
% dbstop if error
% pset = 1:17;
% % delta_pset = 1;            % 测点之间的距�? （m�?
% ns = length(pset);                  % 测点的个�?
% nolayer = 7;                  % 划分的层�?
% total_depth = 40;           % �?大深�? m

%%



%%

a1 = []; 
for i = 1:ns %:ns
%     if i == 16 || i == 17
%         iterEnd = 52;
%     end
%     j = pset(i);
    j=i;
    fileid = fopen( fullfile(filefolder1, sprintf('errns%d.dat', j))   );
    res = textscan(fileid,'%f64');
    fclose(fileid);
    res2 = res{1,1}; res2 = res2';
    atmp = res2(1:end);
    err_it = atmp(1,1:end) ;
    iter = 1:length(err_it);
    figure('Position',[15	14.333333333333	1254	564]) % get(gcf,'Position')
    semilogy(iter, err_it, '-o','LineWidth',1.3)
    grid on; hold on; 
    xlabel('���ݵ�������');   ylabel('���ݽ�����')
    ylim([1e-10 1e0])

    iterEnd = length(err_it);
    legend(['���',num2str(i)])
    set(gca,'FontSize',14,'FontWeight','bold')
    if ~exist(fullfile(filefolder,'\�������\'),'dir')
        mkdir(fullfile(filefolder,'\�������\'))
    end
    for j = 1:1:iterEnd
        text(j, err_it(j), num2str(j), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', 'FontSize', 12);
    end
    saveas(gcf, fullfile(filefolder,'\�������\', sprintf('%d.tif', i)) )

close all

%     a1 = [a1 ; atmp];
end



% 
% for i = 1:ns
%     figure
%     iter = 1:iterEnd;
%     err_it = a1(i,1:iterEnd) ;
%     semilogy(iter, err_it, '-o','LineWidth',1.3)
%     grid on
%     hold on
%     xlabel('���ݵ�������')
%     ylabel('���ݽ�����')
% 
% legend(['���',num2str(i)])
% set(gca,'FontSize',14,'FontWeight','bold')
% saveas(gcf, fullfile(filefolder,'���ݳ���ͼ\�������\', sprintf('%d.tif', i)) )
% 
% close all
% end