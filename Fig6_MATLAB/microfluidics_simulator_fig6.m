%%
%% Model of L-2L microfluidic circuit
%%
clear; close all
% time constant and gain
filename = '_steady_timeconstant.xlsx';
sheet = 'timeconstant';
T = readmatrix(filename,'Sheet',sheet);
T1 = T(5, 2); T2 = T(3, 2); T3 = T(1, 2); %solution time constant data 1:upstream
T4 = T(5, 1); T5 = T(3, 1); T6 = T(1, 1); %solvent time constant data 4:upstream

filename = '_steady_timeconstant.xlsx';
sheet = 'steady';
K = readmatrix(filename,'Sheet',sheet);
K1 = K(5, 5); K2 = K(3, 5); K3 = K(2, 5); %solution steady-state gain 1:upstream
K4 = K(5, 5); K5 = K(3, 5); K6 = K(2, 5); %solvent steady state gain 4:upstream

% bases
f = cell(1,6);
f{1} = Readfile(0,1); %bit1-1 data
f{2} = Readfile(0,2); %bit2-1 data
f{3} = Readfile(0,4); %bit3-1 data
f{4} = Readfile(1,0); %bit1-0 data
f{5} = Readfile(2,0); %bit2-0 data
f{6} = Readfile(4,0); %bit3-0 data
f{7} = K(2, 5); %steady state gain data:upstream
f{8} = K(3, 5); %steady state gain data
f{9} = K(5, 5); %steady state gain data:downstream
f{10} = Readfile2(0,1);

% simulate dynamic input from i to j (e.g. i=2 (010) to j=3 (011))

% t = -1:0.01:0; %simulation time (for 5sec)
ibase = [0,0,0]; % order is reversed!! (5 is not [1 1 0] but [0 1 1])
jbase = [0,0,0];

for i=0:7 
    for j=0:7
        if(i==j) 
            continue;
        end
        
        %convert i and j to base 2
        m=i; n=j;
        for bit=1:3
            ibase(bit) = mod(m,2); jbase(bit) = mod(n,2);
            m = floor(m/2); n = floor(n/2);
        end
        
        display(['convert from ', num2str(i) , ' to ', num2str(j)]);
        % simulate the response
        output = zeros(1,length(f{1}));  %initialize output
        for k=1:3
            if(ibase(k) == 1 && jbase(k) == 0) %change k-th bit from 1 to 0
                output = output + f{k+3};
            elseif(ibase(k) == 0 && jbase(k) == 0) %change k-th bit from 1 to 0
                output = output + 0;
            elseif(ibase(k) == 1 && jbase(k) == 1) %change k-th bit from 1 to 0
                output = output + f{k+6};
            elseif(ibase(k) == 0 && jbase(k) == 1) %change k-th bit from 0 to 1
                output = output + f{k};
            end
        end

        output2 = zeros(1,length(f{1}));
        output2 = output2 + f{10};
        subplot(8,8,i*8 + j+1); % make a matrix of plots; subplot(size, size, position)
        plot(output2,output,'r','LineWidth',3.0)
        hold on
    end
end

row_start=1; %読み込む行の先頭行
row_end=101; %読み込む行の最終行
column_start=1; %読み込む列の先頭列
column_end=2; %読み込む列の最終列

for j=0:7 
    for k=0:7
        if(j==k) 
            continue;
        end
 %1st figure
        A=zeros(row_end-row_start+1,column_end-column_start+1);%メモリ事前割当
        filename = '_step.xlsx';%data配列に指定ファイルの指定シートのデータを取り込む
        sheet=sprintf('%d%d', j , k); %シート番号
        [data]=readmatrix(filename,'Sheet',sheet,'Range','D82:E182'); %data配列に指定ファイルの指定シートのデータを取り込む  
        for i=column_start:column_end
            A(:,i)=data(row_start:row_end,i); %読み込みデータから所望のセル範囲を切り出す
        end

%2nd figure
        B=zeros(row_end-row_start+1,column_end-column_start+1);%メモリ事前割当
        filename = '_step.xlsx';%data配列に指定ファイルの指定シートのデータを取り込む
        sheet=sprintf('%d%d', j , k); %シート番号
        [data]=readmatrix(filename,'Sheet',sheet,'Range','G82:H182'); %data配列に指定ファイルの指定シートのデータを取り込む  
        for i=column_start:column_end
            B(:,i)=data(row_start:row_end,i); %読み込みデータから所望のセル範囲を切り出す
        end
%         
%3rd figure
        C=zeros(row_end-row_start+1,column_end-column_start+1);%メモリ事前割当
        filename = '_step.xlsx';%data配列に指定ファイルの指定シートのデータを取り込む
        sheet=sprintf('%d%d', j , k); %シート番号
        [data]=readmatrix(filename,'Sheet',sheet,'Range','J82:K182'); %data配列に指定ファイルの指定シートのデータを取り込む  
        for i=column_start:column_end
            C(:,i)=data(row_start:row_end,i); %読み込みデータから所望のセル範囲を切り出す
        end
%         
%4th figure
        D=zeros(row_end-row_start+1,column_end-column_start+1);%メモリ事前割当
        filename = '_step.xlsx';%data配列に指定ファイルの指定シートのデータを取り込む
        sheet=sprintf('%d%d', j , k); %シート番号
        [data]=readmatrix(filename,'Sheet',sheet,'Range','M82:N182'); %data配列に指定ファイルの指定シートのデータを取り込む  
        for i=column_start:column_end
            D(:,i)=data(row_start:row_end,i); %読み込みデータから所望のセル範囲を切り出す
        end
        
%5rd figure
        E=zeros(row_end-row_start+1,column_end-column_start+1);%メモリ事前割当
        filename = '_step.xlsx';%data配列に指定ファイルの指定シートのデータを取り込む
        sheet=sprintf('%d%d', j , k); %シート番号
        [data]=readmatrix(filename,'Sheet',sheet,'Range','P82:Q182'); %data配列に指定ファイルの指定シートのデータを取り込む  
        for i=column_start:column_end
            E(:,i)=data(row_start:row_end,i); %読み込みデータから所望のセル範囲を切り出す
        end
        
        SUM = (A(:,2)+B(:,2)+C(:,2)+D(:,2)+E(:,2))/5;
        subplot(8,8,j*8 + k+1); % make a matrix of plots; subplot(size, size, position)box on
        figure(1);
        p = plot(A(:,1),SUM,':b','LineWidth',3.0);
%         p.LineWidth = 2
        
        xlim([-1 4]);
        ylim([0 1.1]);
%         set(gca,'FontSize',25);
        xticks([-1 0 4]);
%         yticks([0 1]);
%         title(sprintf('From %d to %d', j, k));
        hold off

    end
end

function SUM=Readfile(j,k)

row_start=1; %読み込む行の先頭行
row_end=101; %読み込む行の最終行
column_start=1; %読み込む列の先頭列
column_end=1; %読み込む列の最終列

%4th figure
        D=zeros(row_end-row_start+1,1);%メモリ事前割当
        filename = '_step.xlsx';%data配列に指定ファイルの指定シートのデータを取り込む
        sheet=sprintf('%d%d', j , k); %シート番号
        [data]=readmatrix(filename,'Sheet',sheet,'Range','M82:N182'); %data配列に指定ファイルの指定シートのデータを取り込む  
%        for i=column_start:column_end
            D=data(row_start:row_end,2); %読み込みデータから所望のセル範囲を切り出す
%       for i=column_start:column_end
%             A(:,i)=data(row_start:row_end,i); %読み込みデータから所望のセル範囲を切り出す
%       end
 %1st figure
        A=zeros(row_end-row_start+1,1);%メモリ事前割当
        filename = '_step.xlsx';%data配列に指定ファイルの指定シートのデータを取り込む
        sheet=sprintf('%d%d', j , k); %シート番号
        [data]=readmatrix(filename,'Sheet',sheet,'Range','D82:E182'); %data配列に指定ファイルの指定シートのデータを取り込む  
%         for i=column_start:column_end
            A=data(row_start:row_end,2); %読み込みデータから所望のセル範囲を切り出す
%         end
        
%2nd figure
        B=zeros(row_end-row_start+1,1);%メモリ事前割当
        filename = '_step.xlsx';%data配列に指定ファイルの指定シートのデータを取り込む
        sheet=sprintf('%d%d', j , k); %シート番号
        [data]=readmatrix(filename,'Sheet',sheet,'Range','G82:H182'); %data配列に指定ファイルの指定シートのデータを取り込む  
%         for i=column_start:column_end
              B=data(row_start:row_end,2);
%             B(:,i)=data(row_start:row_end,i); %読み込みデータから所望のセル範囲を切り出す
%         end
%         
%         subplot(8,8,k*8 + j+1); % make a matrix of plots; subplot(size, size, position)box on
%         figure(1);
%         p = plot(A(:,1),A(:,2),'sr','MarkerSize',2,'MarkerFaceColor','r');
%         p.LineWidth = 3.0
%3rd figure
        C=zeros(row_end-row_start+1,1);%メモリ事前割当
        filename = '_step.xlsx';%data配列に指定ファイルの指定シートのデータを取り込む
        sheet=sprintf('%d%d', j , k); %シート番号
        [data]=readmatrix(filename,'Sheet',sheet,'Range','J82:K182'); %data配列に指定ファイルの指定シートのデータを取り込む  
% %         for i=column_start:column_end
            C=data(row_start:row_end,2);
%             C(:,i)=data(row_start:row_end,i); %読み込みデータから所望のセル範囲を切り出す
%         end

%5rd figure
        E=zeros(row_end-row_start+1,1);%メモリ事前割当
        filename = '_step.xlsx';%data配列に指定ファイルの指定シートのデータを取り込む
        sheet=sprintf('%d%d', j , k); %シート番号
        [data]=readmatrix(filename,'Sheet',sheet,'Range','P82:Q182'); %data配列に指定ファイルの指定シートのデータを取り込む  
% %        for i=column_start:column_end
            E=data(row_start:row_end,2);
%             E(:,i)=data(row_start:row_end,i); %読み込みデータから所望のセル範囲を切り出す
%         end
        
        SUM = (A+B+C+D+E)/5;



end
% 
function t=Readfile2(j,k)

row_start=1; %読み込む行の先頭行
row_end=101; %読み込む行の最終行
column_start=1; %読み込む列の先頭列
column_end=1; %読み込む列の最終列

        t=zeros(row_end-row_start+1,1);%メモリ事前割当
        filename = '_step.xlsx';%data配列に指定ファイルの指定シートのデータを取り込む
        sheet=sprintf('%d%d', j , k); %シート番号
        [data]=readmatrix(filename,'Sheet',sheet,'Range','M82:N182'); %data配列に指定ファイルの指定シートのデータを取り込む  
%        for i=column_start:column_end
            t=data(row_start:row_end,1); %読み込みデータから所望のセル範囲を切り出す
%       for i=column_start:column_end
%             A(:,i)=data(row_start:row_end,i); %読み込みデータから所望のセル範囲を切り出す
%       end
end

