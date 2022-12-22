%Energy consumption Local
CDw1=0;
CDw2=0;
CDw3=0;
CDw4=0;

ck=1000;

Lk=0;
alpha=(10^-28);

wf1=500000000; %processor frequency for each wearable in GHz
wf2=800000000;
wf3=1000000000;
wf4=1200000000;

for i=1:16000000
    temp=alpha*wf1^2*i*ck;
    CDw1(i)=temp;
    
    temp=alpha*wf2^2*i*ck;
    CDw2(i)=temp;
    
    temp=alpha*wf3^2*i*ck;
    CDw3(i)=temp;
    
    temp=alpha*wf4^2*i*ck;
    CDw4(i)=temp;
    
    Lk(i)=i;
end

h = figure;
%plot(Lk,CDw1,Lk,CDw2,Lk,CDw3,Lk,CDw4,'LineWidth',1.1)
plot(Lk,CDw1,'Color',[0.9290 0.6940 0.1250],'LineWidth',1.1)
hold on
plot(Lk,CDw2,'Color',[0.4940 0.1840 0.5560],'LineWidth',1.1)
hold on
plot(Lk,CDw3,'Color',[0 0.4470 0.7410],'LineWidth',1.1)
hold on
plot(Lk,CDw4,'Color',[0.8500 0.3250 0.0980],'LineWidth',1.1)

%set(gca, 'Xscale', 'log')

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])

%semilogx(Lk,CDw1,Lk,CDw2,Lk,CDw3,Lk,CDw4)
%axis([1600000 16000000 0 5])
axis([1600000 16000000 0 2.5])
%title('Energy consumption for local task execution on wearable')
xlabel('Size of the Input Data (Megabytes)')
xticks ([1600000 3200000 4800000 6400000 8000000 9600000 11200000 12800000 14400000 16000000])
xticklabels({'0.2','0.4','0.6','0.8','1','1.2', '1.4', '1.6', '1.8','2'})
%xticks ([800000 4000000 8000000 12000000 16000000])
%xticklabels({'0.1','0.5','1','1.5', '2'})
ylabel('Energy Consumption (Joules)')
legend('F_w=0.5GHz','F_w=0.8GHz','F_w=1GHz', 'F_w=1.2GHz','Location', 'northwest')
grid on
print(h,'wearable-energy','-dpdf','-r0')