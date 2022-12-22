%energy consumption

%Local task execution on wearable

Ew=0; %computation delay for wearable
ck=1000; %computation intensity in cpu cycles per bit
alpha=(10^-28);

D=16000000; %input data size

Fw=1000000000; %processor frequency for wearable

Ew= alpha * (Fw^2) * D * ck;


%%%%%%%%%%%%%%%%%%%%%%%%%%%
%offloading to the smartphone
%energy consumption

%W=20000000;
Pt=1.28;
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
Pr=0.94;

Etw=Pt * D/Rn;
Ers=Pr * D / Rn;

Es=alpha * (Fs^2) * D * ck;
Eexs= Etw + Ers + Es;

Ewidle = 0.022 * (D * ck / Fs);

% %offloading to the edge
% 
% %energy consumption
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
plos1=db2pow(plos1);
Hns1 = 1/plos1;
Rs1 = Ws * log2(1+(Pts * Hns1 / N0));

plos2= 36.7*log10(d2)+26*log10(2.1)+22.7;
plos2=db2pow(plos2);
Hns2 = 1/plos2;
Rs2 = Ws * log2(1+(Pts * Hns2 / N0));

plos3= 36.7*log10(d3)+26*log10(2.1)+22.7;
plos3=db2pow(plos3);
Hns3 = 1/plos3;
Rs3 = Ws * log2(1+(Pts * Hns3 / N0));

Ede1=Pts * D/Rs1;
Ede2=Pts * D/Rs2;
Ede3=Pts * D/Rs3;


Fe=20000000000;
Ee=alpha * (Fe^2) * D * ck;

Eexe1= Etw + Ers + Ede1;
Eexe2= Etw + Ers + Ede2;
Eexe3= Etw + Ers + Ede3;

Ewidle2= 0.022 * ( (D/Rs1) + (D * ck / Fe));
Ewidle3= 0.022 * ( (D/Rs2) + (D * ck / Fe));
Ewidle4= 0.022 * ( (D/Rs3) + (D * ck / Fe));
Esidle= 0.03 * (D * ck / Fe);

%X = categorical({'Local task execution on wearable' 'Offloading to the smartphone' 'Offloading to the edge server (d=50m)' 'Offloading to the edge server (d=200m)' 'Offloading to the edge server (d=500m)'});
%X = reordercats(X,{'Local task execution on wearable' 'Offloading to the smartphone' 'Offloading to the edge server (d=50m)' 'Offloading to the edge server (d=200m)' 'Offloading to the edge server (d=500m)'});

X = categorical({'1' '2' '3a' '3b' '3c'});
X = reordercats(X,{'1' '2' '3a' '3b' '3c'});

Y=[Ew 0 0 0 0 0 0 0; 0 Etw Ers Ewidle Es 0 0 0; 0 Etw Ers Ewidle2 0 Ede1 Esidle 0; 0 Etw Ers Ewidle3 0 Ede2 Esidle 0 ; 0 Etw Ers Ewidle4 0 Ede3 Esidle 0 ];
h = figure;
bar(X,Y,'stacked')
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])

%ylim([0 2.5])

%set(gca, 'Yscale', 'log')
%yticks ([0 0.002 0.02 0.1 0.5 1.5 8])
%yticklabels({'0','0.002','0.02','0.1','0.5','1.5','8'})
xlabel('Task Execution Scenarios')
%ylabel('Energy Consumption (Joules) [logscale]')
ylabel('Energy Consumption (Joules)')
legend('Wearable Computation', 'Wearable Transmission','Smartphone Reception', 'Wearable idle','Smartphone Computation', 'Smartphone Transmission', 'Smartphone idle','Location', 'bestoutside')
%legend('boxoff');
grid on
print(h,'EnergyConsumptionBarPlotCombined','-dpdf','-r0')

