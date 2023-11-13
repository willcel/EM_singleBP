
%%
bpresName = fullfile('D:\willcel\',specName,'\EM_singleBP\·ÂÕæ½á¹û\',ftmp) ;
name = [bpresName, '\rawdata'];
filefolder1 = name;
filefolder = bpresName;
mkdir(name)
for i = 1:ns
    cd(fullfile('D:\willcel\',specName,'\EM_singleBP\', ['exp_nanjing',num2str(i)]) )
    copyfile("res2d.dat",fullfile(name, ['res2dns',num2str(i),'.dat']))
    copyfile("err.dat",  fullfile(name,['errns',num2str(i),'.dat']))
    copyfile("log.dat",  fullfile(name,['logns',num2str(i),'.dat']))
end
fclose all;
cd ..