program DFS;

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
    assign(inp, 'dfs_input.txt');
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

procedure DFSvisit(V : graph; i : integer;  var P,d,f : list; var kolor : colorTable; var time : integer); 
  var 
    temp : wsk;
  begin 
    kolor[i] := szary;
    time := time + 1; 
    d[i] := time;
    temp := V[i];
    while temp <> Nil do begin 
      if kolor[temp^.key] = bialy then begin 
        P[temp^.key] := i;
        DFSvisit(V, temp^.key, P, d, f, kolor, time);
      end;
      temp := temp^.next;
    end;
    kolor[i] := czarny; time := time + 1; f[i] := time;
  end;

procedure DFS(V : graph; var P,d,f : list; kolor : colorTable);
  var 
    time : integer; 
       i : integer; 
  begin 
    for i := 1 to n do begin 
      kolor[i] := bialy;
      d[i] := 0;
      f[i] := 0;
      P[i] := 0;
    end;
    time := 0;
    for i := 1 to n do if kolor[i] = bialy then DFSvisit(V, i, P, d, f, kolor, time);
  end;

var 
  V : graph;
  kolor : colorTable;
  d, P, f : list;
  j : integer;

begin 
  makeDirectedGraph(V);
  writeln('here goes the incident list');
  show(V);
  DFS(V, P, d, f, kolor);
  writeln('P(i) : ');
  for j := 1 to n do write(j, ' ');
  writeln;
  for j := 1 to n do write(P[j], ' ');
  writeln;
  writeln('d(i) : ');
  for j := 1 to n do write(d[j], ' ');
  writeln;
  writeln('f(i) : ');
  for j := 1 to n do write(f[j], ' ');
  writeln;
end.
