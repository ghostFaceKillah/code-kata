program BFS;

const 
  n = 9; 

type 
  color = (bialy, szary, czarny);
  wsk = ^element;
  element = record
    key : integer;
    next : wsk;
  end;
  graph = array[1..n] of wsk;
  list = array[1..n] of integer;
  colorTable = array[1..n] of color;
  
procedure show(V:graph);
  var
    i : integer;
    x : wsk;
  begin
    for i := 1 to n do begin
      x := V[i];
      write('from ', i,' you can go to: ');
      while x <> Nil do begin 
        write(x^.key,' ');
        x := x^.next;
      end;
      writeln;
    end;
  end;

procedure makeDirectedGraph(var V:graph);
  var
    help : wsk;
      el : wsk;
     inp : text;
       s : string;
       r : string;
     i,k : integer;
    from : integer;
     too : integer;
     err : integer;
  begin 
    assign(inp, 'bfs_input.txt');
    reset(inp);
    while not eof(inp) do begin 
      readln(inp, s);
      r := s;
      i := 1;
      k := Length(s);
      while s[i] <> ' ' do i := i + 1;
      Delete(s,1,i);
      Delete(r,i,k);
      val(s,too,err);
      val(r,from,err);
      new(el);
      el^.key := too;
      el^.next := Nil;
      if V[from] = Nil then V[from] := el else begin 
        help := V[from];
        while help^.next <> Nil do help := help^.next;
        help^.next := el;
      end;
    end;
  end;

procedure push(what:integer; var head : wsk);
  var
    e,help:wsk;
  begin
    new(e);
    e^.next := Nil;
    e^.key := what;
    if head = Nil then head := e else begin 
      help := head; 
      while help^.next <> Nil do help := help^.next;
      help^.next := e;
    end;
  end;

function pop(var head:wsk):integer;
  var
    temp : wsk;
  begin 
    if head <> Nil then begin 
      temp := head;
      head := head^.next;
      pop := temp^.key;
      dispose(temp)
    end else begin 
      writeln('cant do pop: the list is empty');
      pop := -1;
    end;
  end;

procedure BFS(V:graph;s:integer; var P,d : list; kolor:colorTable; kolejka : wsk);
  var 
    i,u : integer;
    temp : wsk;
  begin 
    for i := 1 to n do begin 
      P[i] := 0;
      d[i] := -1;
      kolor[i] := bialy;
    end;
    d[s] := 0; 
    kolor[s] := szary;
    push(s, kolejka);
    while kolejka <> Nil do begin 
      u := pop(kolejka); 
      temp := V[u];
      while temp <> Nil do begin 
        if kolor[temp^.key] = bialy then begin
          d[temp^.key] := d[u] + 1;
          P[temp^.key] := u;
          kolor[temp^.key] := szary; 
          push(temp^.key, kolejka);
        end;
        kolor[u] := czarny;
        temp := temp^.next;
      end;
    end;
  end;

var 
  kolejka : wsk;
  V : graph;
  kolor : colorTable;
  d, P : list;
  s,j : integer;

begin 
  s := 7;
  kolejka := Nil;
  makeDirectedGraph(V);
  writeln('here goes the incident list');
  show(V);
  BFS(V,s,P,d,kolor, kolejka);
  writeln('P(i) jest na poprzednikiem najkrótszej drodze do: ', s,' ');
  for j := 1 to n do write(j, ' ');
  writeln;
  for j := 1 to n do write(P[j], ' ');
  writeln;
  writeln('d(i) jest długością najkrótszej ścieżki z i do: ', s,' ');
  for j := 1 to n do write(d[j], ' ');
  writeln;
end.
