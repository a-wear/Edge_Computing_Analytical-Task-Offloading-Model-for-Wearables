%Local task execution
%task execution time
CDw1=0; %computation delay for each wearable
CDw2=0;
CDw3=0;
CDw4=0;

ck=1000; %computation intensity in cpu cycles per bit

Lk=0; %input data array

wf1=500000000; %processor frequency for each wearable in GHz
wf2=800000000;
wf3=1000000000;
wf4=1200000000;

for i=1:16000000
    temp=(i*ck)/wf1;
    CDw1(i)=temp;
    
    temp=(i*ck)/wf2;
    CDw2(i)=temp;
    
    temp=(i*ck)/wf3;
    CDw3(i)=temp;
    
    temp=(i*ck)/wf4;
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

%xlabel('Size of the input data (Megabytes)')
xlabel('Size of the Input Data (Megabytes)')
axis([1600000 16000000 0 35])

%xticks ([800000 4000000 8000000 12000000 16000000])
%xticklabels({'0.1','0.5','1','1.5', '2'})

xticks ([1600000 3200000 4800000 6400000 8000000 9600000 11200000 12800000 14400000 16000000])
xticklabels({'0.2','0.4','0.6','0.8','1','1.2', '1.4', '1.6', '1.8','2'})
ylabel('Task Accomplishment Time (s)')

legend('F_w=0.5GHz','F_w=0.8GHz','F_w=1GHz', 'F_w=1.2GHz','Location', 'northwest')
grid on
print(h,'wearable-delay','-dpdf','-r0')


%plot(Lk,CDw1,Lk,CDw2,Lk,CDw3,Lk,CDw4)
%set(gca, 'Xscale', 'log')
%semilogx(Lk,CDw1,Lk,CDw2,Lk,CDw3,Lk,CDw4)
%title('Local Task Execution on Wearable')
%axis([80000 16000000 1 35])
%xlabel('Size of the input data (Megabytes)')
%xticks ([80000 800000 4000000 8000000 12000000 16000000])
%xticklabels({'0.01','0.1','0.5','1','1.5', '2'})
%axis([3200000 16000000 1 16])

%xticks ([3200000 4800000 6400000 8000000 9600000 11200000 12800000 14400000 16000000])
%xticklabels({'0.4','0.6','0.8','1','1.2', '1.4', '1.6', '1.8','2'})

% xticks ([1600000 3200000 4800000 6400000 8000000 9600000 11200000 12800000 14400000 16000000])
% xticklabels({'0.2','0.4','0.6','0.8','1','1.2', '1.4', '1.6', '1.8','2'})
%ylabel('Task Accomplishment Time (s)')

%legend('F_w=1GHz','F_w=1.2GHz','F_w=1.5GHz', 'F_w=1.7GHz','Location', 'northwest')
%grid on