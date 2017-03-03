beginfig(0)
  u:=2cm;
  path p;
  transform t;
  p:= (u,u)--(-u,u)--(-u,-u)--(u,-u)--cycle;

  (0,0) transformed t=(0,0);
  (u,u) transformed t=(0.7u,u);
  (-u,u) transformed t = (-u,0.7u);

  draw p;

  for i:=1 upto 20:
    p:=p transformed t;
    draw p;
  endfor;
endfig;
end
