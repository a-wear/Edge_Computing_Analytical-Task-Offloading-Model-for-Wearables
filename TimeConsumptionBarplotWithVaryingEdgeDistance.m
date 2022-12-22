%task execution time

%Local task execution on wearable

Tw=0; %computation delay for wearable
ck=1000; %computation intensity in cpu cycles per bit

D=16000000; %input data size
 
Fw=1000000000; %processor frequency for wearable

Tw=(D*ck)/Fw;


%%%%%%%%%%%%%%%%%%%%%%%%%%%
%offloading to the smartphone
%task execution time

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

Tds=D/Rn;

Texs=(D*ck)/Fs;
%Ts= Tds + Texs;

%Twidle=Texs;

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

Tde1=D/Rs1;
Tde2=D/Rs2;
Tde3=D/Rs3;

Texe=(D*ck)/Fe;

%Te1= Tde1 + Texe;
%Te2= Tde2 + Texe;
%Te3= Tde3 + Texe;

%Twidle2= ( (D/Rs1) + (D * ck / Fe));
%Twidle3= ( (D/Rs2) + (D * ck / Fe));
%Twidle4= ( (D/Rs3) + (D * ck / Fe));
%Tsidle= D * ck / Fe;

X = categorical({'1' '2' '3a', '3b','3c'});
X = reordercats(X,{'1' '2' '3a', '3b','3c'});
Y=[Tw 0 0 0 0; 0 Tds Texs 0 0; 0 Tds 0 Tde1 Texe; 0 Tds 0 Tde2 Texe; 0 Tds 0 Tde3 Texe];
h = figure;
bar(X,Y,'stacked')

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])

%set(gca, 'Yscale', 'log')
%ylim([0 0.6])
%yticks ([0 0.02 1 2 4 6 9 13])
%yticklabels({'0','0.02','1','2','4','6','9','12'})
xlabel('Task Execution Scenarios')
ylabel('Task Accomplishment Time (s)')
%axis auto
%ylim([0.01 13])
legend('Wearable Computation', 'Wearable Transmission', 'Smartphone Computation', 'Smartphone Transmission','Edge Computation', 'Location', 'bestoutside')
%legend('boxoff')
grid on
%print(h,'TimeConsumptionBarPlotCombined2','-dpdf','-r0')
print(h,'TimeConsumptionBarPlotCombined2','-dpdf','-r0')
