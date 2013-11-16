program skladoweSpojneGrafuNiezorientowanego;

const
  n = 10;

type 
  wsk = ^element;
  element = record
             nazwa : integer;
           dlugosc : integer;
    rep,next, last : wsk
  end;

var 
  V : array[1..n] of wsk;
  i : integer;

procedure makeSet(k:integer);
  var 
    u : wsk;
  begin 
    new(u); 
    V[k] := u;
    with u^ do begin 
        nazwa := k; next := Nil;
          rep := u; 
      dlugosc := 1;
         last := u
    end;
  end;

function find(k:integer):wsk;
  begin 
    find := V[k]^.rep;
  end;

procedure union(k,l : integer);
  var u,w,z : wsk;
  begin 
    u := find(k); w := find(l);
    if u <> w then begin 
      if w^.dlugosc < u^.dlugosc then begin 
        z := u; u := w; w := z
      end;
      w^.last^.next := u; 
      w^.dlugosc := w^.dlugosc + u^.dlugosc;
      w^.last := u^.last;
      while u <> Nil do begin 
        u^.rep := w;
        u := u^.next;
      end;
    end;
  end;

begin 
  for i := 1 to n do makeSet(i);
  union(1,2);
  union(1,2);
  writeln(find(1)^.nazwa);
  writeln(find(2)^.nazwa);
  writeln(find(3)^.nazwa);
end.
  

