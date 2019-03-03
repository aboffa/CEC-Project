  M5 =  csvread("output-stage1-5.txt");
  M3 =  csvread("output-stage1-3.txt");
  #M1 =  csvread("output-stage1-5.csv");
  x=M5(:,1); % reading its first column
  mean5=M5(:,2);
  mean3=M3(:,2);
  h = plot(x,mean5,x,mean3)
  legend("Mean of millisends","Mean of millisends", 'Location',	'northwest')

  set(h(1),'linewidth',2.5);
  set(h(2),'linewidth',2.5);
  #xt = get(gca, 'xtick'); 
  #set(gca, 'xticklabel', sprintf('10^%d', xt));
