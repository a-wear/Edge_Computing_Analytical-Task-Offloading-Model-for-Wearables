%Local task execution
%task execution time
CDw=0; %computation delay for each wearable

ck=1000; %computation intensity in cpu cycles per bit

D1=16000000; %input data size
D2=3360000;

wf=1000000000; %processor frequency for wearable

%CDw=(D*ck)/wf;

%%%%%%%%%%%%%%%%%%%%%%%%%%%

%offloading to the smartphone
%task execution time

%previous wifi data rate estimation using shannon
%Rn=0;
%W=20000000;
%Pt=1.28;
%wn= 0.1 * (10^-12);
%Hnw=0.85^-4;
%Rn = W * log2(1+(Pt * Hnw / wn));


DS=48;
M=6;
C=3/4;
SS=1;
SI=4 * 10^-6;
Rn= DS * M * C * SS /SI;

Fs=2200000000;
Twifi=0;
Ts=0;

Twifi1=D1/Rn;
Twifi2=D2/Rn;

CDs1=D1 * ck / Fs;
CDs2=D2 * ck / Fs;
%Ts=Twifi + CDs;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%5
% 
% %offloading to the edge
% 
% %task execution time
% 

Rs=0;
Ws=1000000;
Pts=0.199526;
%N0= 0.01 * (10^-12);
N0= 5.0119 * (10^-15);
Fe=20000000000;

for i=1:600
    
plos= 36.7*log10(i)+26*log10(2.1)+22.7;
plos = db2pow(plos);
Hns = 1/plos;
Rs = Ws * log2(1+(Pts * Hns / N0));    

Tc1(i)=D1/Rs;
Tc2(i)=D2/Rs;

CDe1=D1 * ck / Fe;
CDe2=D2 * ck / Fe;

Te1(i)=Tc1(i)+Twifi1+CDe1;
Te2(i)=Tc2(i)+Twifi2+CDe2;

dist(i)=i;

CDw1(i)=(D1*ck)/wf;
Ts1(i)=Twifi1 + CDs1;

CDw2(i)=(D2*ck)/wf;
Ts2(i)=Twifi2 + CDs2;
    
end

% %
h = figure;
plot(dist,CDw2,'LineWidth',1.1)
hold on
plot(dist,Ts2,':','LineWidth',1.5)
hold on
plot(dist,Te2,'--','LineWidth',1.1)
hold on
plot(dist,CDw1,'LineWidth',1.1)
hold on
plot(dist,Ts1,':','LineWidth',1.5)
hold on
plot(dist,Te1,'--','LineWidth',1.1)

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])

%set(gca, 'Xscale', 'log')
%axis([1600000 16000000 0 12])
%axis([80000 16000000 0 17])
axis([50 600 0 18])

xlabel('Distance between the Smartphone and Edge Server (m)')
%xticks ([80000 800000 4000000 8000000 12000000 16000000])
%xticklabels({'0.01','0.1','0.5','1','1.5', '2'})
%xticks ([1600000 3200000 4800000 6400000 8000000 9600000 11200000 12800000 14400000 16000000])
%xticklabels({'0.2','0.4','0.6','0.8','1','1.2', '1.4', '1.6', '1.8','2'})
ylabel('Task Accomplishment Time (s)')
legend('Local task execution on wearable (D=0.42MB)','Offloading to the smartphone (D=0.42MB)','Offloading to the edge server (D=0.42MB)','Local task execution on wearable (D=2MB)','Offloading to the smartphone (D=2MB)','Offloading to the edge server (D=2MB)','Location', 'northwest')
grid on
print(h,'TaskExecutionTimeLocalVSOffloadingwithDistanceOnXaxis','-dpdf','-r0')
