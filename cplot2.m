% % 瀹炴祴鏁版嵁鐨勪綔鍥?
% % function [] = myplot4(ns, nolayer, pset, total_depth, delta_pset)
clear
% close all
dbstop if error
pset = 1:17;
% delta_pset = 1;            % 娴嬬偣涔嬮棿鐨勮窛绂? 锛坢锛?
ns = length(pset);                  % 娴嬬偣鐨勪釜鏁?
nolayer = 5;                  % 鍒掑垎鐨勫眰鏁?
total_depth = 25;           % 鏈?澶ф繁搴? m
no_para = 2 * nolayer -1;
%%



%%
filefolder = 'D:\单点程序06021_减少叠加\仿真结果\0625v1\';
for iter = 1:60 % 
    a1 = []; ind_array = [];
    for i = 1:ns %:ns
        j = pset(i);
        fileid = fopen( fullfile(filefolder, sprintf('res2dns%d.dat', j))   );
        res = textscan(fileid,'%f64');
        fclose(fileid);
        res2 = res{1,1}; res2 = res2';
        atmp = res2(1+(iter-1)*(no_para):iter*(no_para));
        a1 = [a1 ; atmp];
    end

    
    
    %%
    a =a1;
    a = ones(ns, no_para);
    j = 1;
    for i = pset
        a(i,:) = a1(j,:);
        for k = 1:8
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
    
    figure('Position',[200 200 900 600])
    h=pcolor(0.5*(p2-min(p2)), y, log10(mat'));
      % h.EdgeColor = 'none';
    shading flat%interp
    colormap jet
    xlabel('Measurement Line / m','FontSize',15,'FontWeight','bold')
    ylabel('Depth / m','FontSize',15,'FontWeight','bold')
    h=colorbar;
    set(get(h,'title'),'string','log10(\rho)');
    % title('predicted model')
    set(gca,'FontSize',14,'FontWeight','bold')
    caxis([-4,2])
    set(gca,'ydir','reverse')
    title(['迭代次数',num2str(iter)])
    mkdir(fullfile(filefolder,'\反演成像图\'))
    for i = 1:ns
%     scatter(i-0.25,1,'^')
        text(i*0.5-0.25, 2, num2str(i), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', 'FontSize', 12);
    end
    saveas(gcf, fullfile(filefolder,'\反演成像图\', ['迭代次数',num2str(iter),'.tif']  ) )
    close all
end

cplot2_err