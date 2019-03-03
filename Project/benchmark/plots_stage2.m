  M5 =  csvread("output-stage2-5.csv");
  M3 =  csvread("output-stage2-3.csv");
  M1 =  csvread("output-stage2-1.csv");
  x=M(:,1); % reading its first column
  mean5=M(:,2);
  mean3=M(:,2);
  mean1=M(:,2);
  #h = plot(x,mean5,x,mean3,x,mean1)
  #legend("Mean of millisends", 'Location',	'northwest')

  set(h(1),'linewidth',2.5);

  #xt = get(gca, 'xtick'); 
  #set(gca, 'xticklabel', sprintf('10^%d', xt));
