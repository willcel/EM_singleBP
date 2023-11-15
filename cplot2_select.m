% % 瀹炴祴鏁版嵁鐨勪綔鍥?
% % function [] = myplot4(ns, nolayer, pset, total_depth, delta_pset)
% clear
% close all
dbstop if error
% pset = 1:ns;
delta_pset = 1;            % 娴嬬偣涔嬮棿鐨勮窛绂? 锛坢锛?
ns = length(pset);                  % 娴嬬偣鐨勪釜鏁?
% total_depth = 25;           % 鏈?澶ф繁搴? m
no_para = 2 * nolayer -1;
%%


ind_array(1:ns) = 25;
% ind1 = [1:12 13 14 15 16 17 18 19 20 21];
% arr1 = [39*ones(1,12) 44 43 44 47 44 49 45 44 45 42 50 43 44];
% ind_array(ind1) = arr1;

%%
% filefolder = '.\仿真结果\0811v1\rawdata';

    a1 = []; 
    for i = 1:ns %:ns
        ind = ind_array(i);
%         j = pset(i);
        j = i;
        fileid = fopen( fullfile(filefolder1, sprintf('res2dns%d.dat', j))   );
        res = textscan(fileid,'%f64');
        fclose(fileid)
        res2 = res{1,1}; res2 = res2';
        atmp = res2(1+(ind-1)*(no_para):ind*(no_para));
        a1 = [a1 ; atmp];
    end

    % 测点7有误，
%     a1(7,:) = a1(6,:); 
    
    %%
    a =a1;
    a = ones(ns, no_para);
    j = 1;
    for i = 1:ns%pset
        a(i,:) = a1(j,:);
        for k = 1:no_para
            if(a(i,k) > 1e5)
                a(i,k) = 1e5;
            elseif(a(i,k) < 1e-5)
                a(i,k) = 1e-5;
            end
        end
        j = j + 1;
    end
    % a
    


    %% 图像美观修正
    layerHeight = a(:, nolayer+1:end);
    a_observe = zeros(ns, nolayer-1);
    a_observe(:, 1) = layerHeight(:, 1);
    for layer = 2:4
        a_observe(:, layer) = layerHeight(:,layer)+a_observe(:,layer-1);
    end
    a_observe = a_observe';
%     
%     layerHeight(1:ns,1) = layerHeight(1:ns,1); 
    a(:, (nolayer+1):end) = layerHeight;

    % a(:,3) = 0.47;
    % a(1:4,4) = mean(a(1:4,4));
    % a(5:7,4) = mean(a(5:7,4))-0.024;
    
    %% 不同层之间划分，方便观察
%     depthSeparate = a(:,6:9);
%     for j = 2:4
%         depthSeparate(:,j) = depthSeparate(:,j-1) + depthSeparate(:,j);
%     end
%     save('F:\BaiduNetdiskDownload\0514报告图库\04071仿真结果\a040710522v1.mat' ,'a')

    selectAns = a;
    save('.\selectAns.mat', "selectAns")


    scale_factor = 100;
    mat = zeros(ns,total_depth*scale_factor);
    
    
    for x = 1:ns 
        
        depth = zeros(1,nolayer-1);
        for k=1:nolayer-1
            for t = 1:k
                depth(k) = depth(k)+a(max(1,round(x)),t+1*nolayer);
            end
        end
        
        
        for y = 1:total_depth*scale_factor
            y1 = y/scale_factor;
            
            flag=0;
            for i=1:nolayer-1
                if(y1<=depth(i))
                    mat(x,y)=a(max(1,round(x)),i);
                    
                    
                    flag=1;
                    break
                end
                
                if(flag==0)
                    mat(x,y)=a(max(1,round(x)), nolayer);
                    
                end
                
            end
        end
        
    end
    
    
    dy = 1/scale_factor;
    y = 0:dy:total_depth-dy;
    %%
    mat(mat==1)=NaN;
%      writetxt(mat','.\0629测线2.txt')
   %{
        % N=10 倍分辨率提升
        N=3;
       pset_new = (1:pset(end)*N)/N;
       mat_new = zeros(ns*N,total_depth*scale_factor);
       for jj = 1:ns
           for kk = 1:N
            mat_new( N*(jj-1) + kk, :) = mat(jj,:);
           end
       end
       mat = mat_new;
       pset = pset_new;
   %}
    % ---- 为了pcolor画出最后一个测点 ---------
    xdraw_range = [pset, pset(end)+1]; mat = [mat;zeros(1,total_depth*scale_factor)];
    % ---------------------------------------

%     figure('Position',[200 200 900 600])
    figure('Position',[100 100 1200 600]) 
    h=pcolor(delta_pset*(xdraw_range - min(xdraw_range)),y,log10(mat'));
    % h.EdgeColor = 'none';
    shading flat%
%     shading interp
%     xlim([0 ns-1])
    colormap jet
    xlabel('Measurement Line / m','FontSize',15,'FontWeight','bold')
    ylabel('Depth / m','FontSize',15,'FontWeight','bold')
    h=colorbar;
    set(get(h,'title'),'string','log10(\rho)');
    % title('predicted model')
    set(gca,'FontSize',18,'FontWeight','bold')
    caxis([-4,2])
    set(gca,'ydir','reverse')
    title('反演成像')
    saveas(gcf, fullfile(filefolder,'\', ['选择v1.tif']  ) )
    for i = 1:ns
        % 追求标号的准确性
        if(i<ns) interval = xdraw_range(i+1)-xdraw_range(i); end

        text(xdraw_range(i)-1 + 0.5*interval, 1, num2str(i), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', 'FontSize', 12);
    end
    
%     for i = 1:ns
%         hold on
%         for k = 1:4
%             plot(0.5*[i-1 i], [depthSeparate(i,k) depthSeparate(i,k)], 'r', 'LineWidth', 1)
%         end
%         hold off
%     end

    

%     close all
