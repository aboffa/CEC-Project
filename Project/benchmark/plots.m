  M =  csvread("result.csv");
  x=M(:,1); % reading its first column
  y1=M(:,2); 
  y2=M(:,3); 
  y3=M(:,4);
  #h = plot(x,y1, x, y2)
  #legend("Sorted array", "Sorted Array (Branch Free+Prefetch)", 'Location',	'northwest')

  set(h(1),'linewidth',2.5);

  #xt = get(gca, 'xtick'); 
  #set(gca, 'xticklabel', sprintf('10^%d', xt));
