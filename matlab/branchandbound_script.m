>> A = [1 0 5 0;1 1 -1 0;6 -5 0 0;-1 0 2 -2]
A =
     1     0     5     0
     1     1    -1     0
     6    -5     0     0
    -1     0     2    -2
>> b = [10;1;0;3]
b =
    10
     1
     0
     3
>> c = [4;-2;7;-1]
c =
     4
    -2
     7
    -1
>> Z = c'*x
Z =
   14.2500
>> format rational
x = linprog(-c,A,b,[],[],zeros(1,4))
Optimization terminated.
x =
       5/4     
       3/2     
       7/4     
       0
% Itrun 1: -------------------------------------------------
% x(1) = 5/4 => baetum vid skordu x(1) <= 1 og x(2) >= 2
>> A1 = [A;1 0 0 0]; b1 = [b;1];
>> A2 = [A;-1 0 0 0]; b2 = [b;-2];
>> x1 = linprog(-c,A1,b1,[],[],zeros(1,4))
Optimization terminated.
x1 =
       1      
       6/5     
       9/5     
       0
>> x2 = linprog(-c,A2,b2,[],[],zeros(1,4))
Exiting: One or more of the residuals, duality gap, or total relative error has stalled:
         the primal appears to be infeasible (and the dual unbounded).
         (The dual residual < TolFun=1.00e-008.)
x2 =
       2      
       3/5     
       8/5     
     549/119   
>> Z1 = c'*x1
Z1 =
   14.2000

% Undirverkefni 2 er ekki loglegt F(2) eyding!
% Itrun 2: -------------------------------------------------
% x(1) er heiltala faerum okkur yfir a x(2) sem er 3/5 
% tvo ny undir-undirverkefni: x(1) <= 1 og x(2) <= 1 eda x(2) >= 2
>> A11 = [A1;0 1 0 0]; b11 = [b1;1];
>> A12 = [A1;0 -1 0 0]; b12 = [b1;-2];
>> x11 = linprog(-c,A11,b11,[],[],zeros(1,4))
Optimization terminated.
x11 =
       5/6     
       1      
      11/6     
       0
>> x12 = linprog(-c,A12,b12,[],[],zeros(1,4))
Optimization terminated.
x12 =
       5/6     
       2      
      11/6     
       0
>> Z = c'*x11
Z =
   14.1667
>> Z = c'*x12
Z =
   12.1667
% engin eyding moguleg!
% Itrun 3: -------------------------------------------------
% vegna thess ad 14.1667 > 12.1667 veljum vid tha lausn til ad kvisla og vonumst til thess ad nota F(1) eydingu a 12.1667 grein.
% (fra vinstri til haegri finna breytu sem er ekki heiltala og a ad vera heiltala, th.e.a.s. x(1) aftur!)
% nu er x(1) < 1 thannig ad annad hvort er x(1) = 0 eda x(1) = 1
>> A11eq1 = [1 0 0 0]; b11eq1 = [0];
>> A11eq2 = [1 0 0 0]; b11eq2 = [1];
>> x111 = linprog(-c,A11,b11,A11eq1,b11eq1,zeros(1,4))
Optimization terminated.
x111 =
       0      
       0
       2      
       1/2
% thessi lausn er ny "incumbent" allar heiltolur sem eiga ad vera  heiltolur eru thad og besta Z er:
>> Z = c'*x111
Z =
   13.5000
% vegna thess ad 13.5 > 12.1667 tha er haegt ad nota F(1) eydingu a undirverkefni "12" (sja ofar)
>> x112 = linprog(-c,A11,b11,A11eq2,b11eq2,zeros(1,4))
Exiting: One or more of the residuals, duality gap, or total relative error has grown 100000 times greater than its minimum value so far:
         the primal appears to be infeasible (and the dual unbounded).
         (The dual residual < TolFun=1.00e-008.)
x112 =
       1      
    1391/1045  
    1605/919   
     874/255   
% thessi lausn er ologleg thannig ad vid beitum F(2) eydingu og besta lausnin hefur thvi verid fundin:
>> xbesta = x111
xbesta =
    0.0000
    0.0000
    2.0000
    0.5000
>> Zbesta = c'*xbesta
Zbesta =
   13.5000
