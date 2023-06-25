% % 瀹炴祴鏁版嵁鐨勪綔鍥?
% % function [] = myplot4(ns, nolayer, pset, total_depth, delta_pset)
clear
close all
dbstop if error
pset = 1:17;
% delta_pset = 1;            % 娴嬬偣涔嬮棿鐨勮窛绂? 锛坢锛?
ns = length(pset);                  % 娴嬬偣鐨勪釜鏁?
nolayer = 5;                  % 鍒掑垎鐨勫眰鏁?
total_depth = 25;           % 鏈?澶ф繁搴? m
no_para = 2 * nolayer -1;
%%


ind_array(1:4) = [60 39 60 39];
ind_array(8:17) = [33 60*ones(1,9)];
ind_array(5:7) = [37 28 29];
%%
filefolder = '.\0614v2';

    a1 = []; 
    for i = 1:ns %:ns
        ind = ind_array(i);
        j = pset(i);
        fileid = fopen( fullfile(filefolder, sprintf('res2dns%d.dat', j))   );
        res = textscan(fileid,'%f64');
        fclose(fileid)
        res2 = res{1,1}; res2 = res2';
        atmp = res2(1+(ind-1)*(no_para):ind*(no_para));
        a1 = [a1 ; atmp];
    end

%     % 测点16，17有误，
%     a1(16,:) = a1(15,:); a1(16,4) = a1(16,3);
%     a1(17,:) = a1(16,:);
    
    %%
    a =a1;
    a = ones(ns, no_para);
    j = 1;
    for i = pset
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
    


    %%
%     a([3 4],4) = a([3 4],3); 
%     a([3 4],8) = a([3 4],8)-1;
%     a([3 4],9) = 1;
%     
%     a([5 10],[3 4 5]) = a([5 10],[2 3 4]);
%     a([5 10],[4 5]+5) = a([5 10],[3 4]+5);
%     a([5 10],3+5) = 1;
%     a([5 10],2+5) = a([5 10],2+5)-1;
% 
%     a(11,[4 3]) = a(11,[3 2]);
%     a(11,[8 9]) = a(11,[7 8]);
%     a(11,[7]) = 1;

    %% 不同层之间划分，方便观察
%     depthSeparate = a(:,6:9);
%     for j = 2:4
%         depthSeparate(:,j) = depthSeparate(:,j-1) + depthSeparate(:,j);
%     end
%     save('F:\BaiduNetdiskDownload\0514报告图库\04071仿真结果\a040710522v1.mat' ,'a')


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
    p2 = 1:ns;

    % ---- 为了pcolor画出最后一个测点 ---------
    p2 = [p2, ns+1];
    mat = [mat;zeros(1,total_depth*scale_factor)];
%     mat(18,:) = mat(17,:); % interp补一位
    % ---------------------------------------

%     figure('Position',[200 200 900 600])
    figure('Position',[521	213.666666666667	784	625.333333333333]) 
    h=pcolor(0.5*(p2-min(p2)), y, log10(mat'));
    % h.EdgeColor = 'none';
    shading flat%
%     shading interp
%     xlim([0 8])
    colormap jet
    xlabel('Measurement Line / m','FontSize',15,'FontWeight','bold')
    ylabel('Depth / m','FontSize',15,'FontWeight','bold')
    h=colorbar;
    set(get(h,'title'),'string','log10(\rho)');
    % title('predicted model')
    set(gca,'FontSize',18,'FontWeight','bold')
    caxis([-4,2])
    set(gca,'ydir','reverse')

    for i = 1:ns
        text(i*0.5-0.25, 2, num2str(i), ...
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

    saveas(gcf, fullfile(filefolder,'\反演成像图\', ['选择v1.tif']  ) )

%     close all
