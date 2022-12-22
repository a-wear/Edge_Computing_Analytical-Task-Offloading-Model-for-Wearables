%energy consumption

%Local task execution on wearable

ck1=500; %computation intensity in cpu cycles per bit
ck2=1000;
ck3=2000;

alpha=(10^-28);

D=16000000; %input data size
 
Fw=1000000000; %processor frequency for wearable

Ew1= alpha * (Fw^2) * D * ck1;
Ew2= alpha * (Fw^2) * D * ck2;
Ew3= alpha * (Fw^2) * D * ck3;


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
SI=4 * (10^-6);
Rn= DS * M * C * SS/SI;

Fs=2200000000;
Pr=0.94;

Etw=Pt * D/Rn;
Ers=Pr * D / Rn;

Es1=alpha * (Fs^2) * D * ck1;
Es2=alpha * (Fs^2) * D * ck2;
Es3=alpha * (Fs^2) * D * ck3;

Eexs1= Etw + Ers + Es1;
Eexs2= Etw + Ers + Es2;
Eexs3= Etw + Ers + Es3;

Ewidle1 = 0.022 * (D * ck1 / Fs);
Ewidle2 = 0.022 * (D * ck2 / Fs);
Ewidle3 = 0.022 * (D * ck3 / Fs);

% %offloading to the edge
% 
% %energy consumption
% 

Ws=1000000;
Pts=0.199526;
%N0= 0.01 * (10^-12);
N0= 5.0119 * (10^-15);
Fe=20000000000;

d=300;

plos= 36.7*log10(d)+26*log10(2.1)+22.7;
plos=db2pow(plos);
Hns = 1/plos;
Rs = Ws * log2(1+(Pts * Hns / N0));

Ede=Pts * D/Rs;

Fe=20000000000;

Ee1=alpha * (Fe^2) * D * ck1;
Ee2=alpha * (Fe^2) * D * ck2;
Ee3=alpha * (Fe^2) * D * ck3;

% Eexe1= Etw + Ers + Ede + Ee1;
% Eexe2= Etw + Ers + Ede + Ee2;
% Eexe3= Etw + Ers + Ede + Ee3;

Eexe1= Etw + Ers + Ede;
Eexe2= Etw + Ers + Ede;
Eexe3= Etw + Ers + Ede;

Ewidle4= 0.022 * ( (D/Rs) + (D * ck1 / Fe));
Ewidle5= 0.022 * ( (D/Rs) + (D * ck2 / Fe));
Ewidle6= 0.022 * ( (D/Rs) + (D * ck3 / Fe));

Esidle1= 0.03 * (D * ck1 / Fe);
Esidle2= 0.03 * (D * ck2 / Fe);
Esidle3= 0.03 * (D * ck3 / Fe);

% X = categorical({'Local Execution on Wearable' 'Offloading to Smartphone' 'Offloading to Edge'});
% X = reordercats(X,{'Local Execution on Wearable' 'Offloading to Smartphone' 'Offloading to Edge'});

X = categorical({'1' '2' '3'});
X = reordercats(X,{'1' '2' '3'});

% X = categorical({'Wearable' 'Smartphone' 'Edge'});
% X = reordercats(X,{'Wearable' 'Smartphone' 'Edge'});

%Y=[Ew1 Ew2 Ew3; Eexs1 Eexs2 Eexs3; Eexe1 Eexe2 Eexe3];
Y=[Ew1 Ew2 Ew3; Etw+Ewidle1 Etw+Ewidle2 Etw+Ewidle3; Etw+Ewidle4 Etw+Ewidle5 Etw+Ewidle6];

h = figure;
ax1 = subplot(2,1,1);

bar(ax1,X,Y)
ylim([0 16])
%xticks ([0 1 3 5 10])
title('Wearable Energy Consumption')
xlabel('Task Execution Scenarios')
ylabel('Energy Consumption (Joules)')
legend('C = 500 cycles/bit', 'C = 1000 cycles/bit', 'C = 2000 cycles/bit', 'Location', 'northeast')
grid on
Y=[0 0 0; Ers+Es1 Ers+Es2 Ers+Es3 ; Ers+Ede+Esidle1 Ers+Ede+Esidle2 Ers+Ede+Esidle3];
ax2 = subplot(2,1,2);
bar(ax2,X,Y)
%xticks ([0 1 3 5 10 15 20])
%set(gca, 'Yscale', 'log')
ylim([0 16])
%yticks ([0 0.8 1.5 4 5 10 15 20 25])
%yticklabels({'0.5','3','10','25'})

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])

xlabel('Task Execution Scenarios')
ylabel('Energy Consumption (Joules)')
title('Smartphone Energy Consumption')
%ylabel('Energy Consumption (Joules) [logscale]')
legend('C = 500 cycles/bit', 'C = 1000 cycles/bit', 'C = 2000 cycles/bit', 'Location', 'northeast')
grid on
print(h,'EnergyConsumptionperDevice_varyingC','-dpdf','-r0')
