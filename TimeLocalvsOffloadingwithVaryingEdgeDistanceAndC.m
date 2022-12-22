%Local task execution
%task execution time
CDw=0; %computation delay for each wearable

%ck=1000; %computation intensity in cpu cycles per bit

D=16000000; %input data size

wf=1000000000; %processor frequency for wearable

for i=1:2000
    temp=(D*i)/wf;
    CDw(i)=temp;
    CI(i)=i;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%

%offloading to the smartphone
%task execution time

%Rn=0;
%W=20000000;
%Pt=1.28;
%wn= 0.1 * (10^-12);
%Hnw=0.85^-4;
%Rn = W * log2(1+(Pt * Hnw / wn));

%M=65 * (10^6);
%SS=2;
%B=2.077;
%k=1.11;
%Rn= M * SS * B * k;

DS=48;
M=6;
C=3/4;
SS=1;
SI= 4 * (10^-6);
Rn= DS * M * C * SS/SI;

Fs=2200000000;
Twifi=0;
Ts=0;

Twifi=D/Rn;

for i=1:2000
    CDs(i)=D * i / Fs;
    Ts(i)=Twifi + CDs(i);
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%5
% 
% %offloading to the edge
% 
% %task execution time
% 

Ws=1000000;
Pts=0.199526;
%N0= 0.01 * (10^-12);
N0= 5.0119 * (10^-15);
Fe=20000000000;

d1=100;
d2=300;
d3=600;

plos1= 36.7*log10(d1)+26*log10(2.1)+22.7;
plos1 = db2pow(plos1);
Hns1 = 1/plos1;
Rs1 = Ws * log2(1+(Pts * Hns1 / N0));

plos2= 36.7*log10(d2)+26*log10(2.1)+22.7;
plos2 = db2pow(plos2);
Hns2 = 1/plos2;
Rs2 = Ws * log2(1+(Pts * Hns2 / N0));

plos3= 36.7*log10(d3)+26*log10(2.1)+22.7;
plos3 = db2pow(plos3);
Hns3 = 1/plos3;
Rs3 = Ws * log2(1+(Pts * Hns3 / N0));

Tc1=D/Rs1;
Tc2=D/Rs2;
Tc3=D/Rs3;

for i=1:2000
    CDe(i)=D * i / Fe;
    
    Te1(i)=Tc1+Twifi+CDe(i);
    Te2(i)=Tc2+Twifi+CDe(i);
    Te3(i)=Tc3+Twifi+CDe(i);
end

% %
h = figure;

plot(CI,CDw,'LineWidth',1.1)
hold on
plot(CI,Ts,':','LineWidth',1.5)
hold on
plot(CI,Te1,'--','LineWidth',1.1)
hold on
plot(CI,Te2,'--','LineWidth',1.1)
hold on
plot(CI,Te3,'--','LineWidth',1.1)

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])

%set(gca, 'Xscale', 'log')
%axis([1600000 16000000 0 12])
%axis([80000 16000000 0 17])

axis([50 2000 0 35])
xticks ([50 200 400 600 800 1000 1200 1400 1600 1800 2000])

xlabel('Computational Intensity of the task (CPU cycles / bit)')
%xticks ([80000 800000 4000000 8000000 12000000 16000000])
%xticklabels({'0.01','0.1','0.5','1','1.5', '2'})
%xticks ([1600000 3200000 4800000 6400000 8000000 9600000 11200000 12800000 14400000 16000000])
%xticklabels({'0.2','0.4','0.6','0.8','1','1.2', '1.4', '1.6', '1.8','2'})
ylabel('Task Accomplishment Time (s)')
legend('Local task execution on wearable','Offloading to the smartphone','Offloading to the edge server (d=100m)','Offloading to the edge server (d=300m)','Offloading to the edge server (d=600m)','Location', 'northwest')
grid on
print(h,'TaskAccomplishmentTimeWithVaryingC','-dpdf','-r0')