function vendilina = minratio(T,vendidalkur)
  ratio= T(2:end,end)./T(2:end,vendidalkur);
  leyfileg=find(ratio>0); 
  [~,venditmp]=min(ratio(leyfileg)); 
  vendilina=leyfileg(venditmp)+1; % þurfum að bæta við línunni fyrir z
end