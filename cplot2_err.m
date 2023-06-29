% % 瀹炴祴鏁版嵁鐨勪綔鍥?
% % function [] = myplot4(ns, nolayer, pset, total_depth, delta_pset)
% clear
% % close all
% dbstop if error
% pset = 1:17;
% % delta_pset = 1;            % 娴嬬偣涔嬮棿鐨勮窛绂? 锛坢锛?
% ns = length(pset);                  % 娴嬬偣鐨勪釜鏁?
% nolayer = 7;                  % 鍒掑垎鐨勫眰鏁?
% total_depth = 40;           % 鏈?澶ф繁搴? m

%%



%%

a1 = []; 
for i = 1:ns %:ns
%     if i == 16 || i == 17
%         iterEnd = 52;
%     end
%     j = pset(i);
    j=i;
    fileid = fopen( fullfile(filefolder, sprintf('errns%d.dat', j))   );
    res = textscan(fileid,'%f64');
    fclose(fileid);
    res2 = res{1,1}; res2 = res2';
    atmp = res2(1:end);
    err_it = atmp(1,1:end) ;
    iter = 1:length(err_it);
    figure('Position',[695	394.333333333333	1354	864]) % get(gcf,'Position')
    semilogy(iter, err_it, '-o','LineWidth',1.3)
    grid on
    hold on
    xlabel('反演迭代次数')
    ylabel('反演结果误差')

    iterEnd = length(err_it);
legend(['测点',num2str(i)])
set(gca,'FontSize',14,'FontWeight','bold')
mkdir(fullfile(filefolder,'\反演成像图\迭代误差\'))
for j = 1:1:iterEnd
    text(j, err_it(j), num2str(j), ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom', 'FontSize', 12);
end
saveas(gcf, fullfile(filefolder,'反演成像图\迭代误差\', sprintf('%d.tif', i)) )

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
%     xlabel('反演迭代次数')
%     ylabel('反演结果误差')
% 
% legend(['测点',num2str(i)])
% set(gca,'FontSize',14,'FontWeight','bold')
% saveas(gcf, fullfile(filefolder,'反演成像图\迭代误差\', sprintf('%d.tif', i)) )
% 
% close all
% end