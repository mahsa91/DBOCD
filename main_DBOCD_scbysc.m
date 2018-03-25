%clearvars -except runtime scriptOBCD filenames foldername datasetname time runrun

%%%%%% Initialize data variables
foldername = './testdata/birthdeath-birth/';
datasetname = 'birthdeath';
time = 7;


v_DBOCD = zeros(time,1);
modu_DBOCD = zeros(time,1);
K = zeros(time);
totaltime = 0;
for t = 1:time
    fprintf('\n Snapshot: %d\n',t);
    %%%%%%%% Load data
    load(strcat(foldername,datasetname,'.t0',num2str(t),'.mat'))
  %  load(strcat(foldername,datasetname,num2str(t),'.mat'))
    %%%%%%%% theta, alpha, myGamma can be set by passsing through setParameter
    %%%%%%%% Community detection in the first snapshot
    tic
    if(t == 1)
        [CO,K(t), Gnum_pre] = setParameter_scbysc(SW,cellW,100,50,[],[],25,12);
    %%%%%%%% Community detection with previous snapshot
    else
        
        [CO,K(t), Gnum_pre] = setParameter_scbysc(SW,cellW,100,50,Gnum_pre,A_b_pre,25,12);
    end
    totaltime = totaltime + toc;
    v_DBOCD(t) = gnmi(comNtoComK(CO),comNtoComK(trueCom),length(cellW));
    modu_DBOCD(t) = myModularity(cellW,CO,comNtoComK(CO));

    A_b_pre = SW;
end
fprintf('\n')




