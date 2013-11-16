program dijkstra; const n = 6; inf = 100;

type
  color = (bialy, szary, czarny);
  wsk = ^elem;
  elem = record
       too : integer;
    weight : integer;
      next : wsk;
  end;
  pnt = ^element;
  element = record
    key : integer;
    next : pnt; 
  end;
  list = array[1..n] of wsk;
  colorList = array[1..n] of color;
  numList = array[1..n] of integer;

procedure makeEdgeList(var V : list);
  var
    from, too, weight, i, k : integer;
    inp : text;
    s1, s2, s3 : string;
    temp1, temp2, help1, help2 : wsk;
  begin
    assign(inp,'dijkstra_input.txt'); reset(inp);
    while not eof(inp) do begin 
      readln(inp, s1); i := 1;
      s2 := s1; k := Length(s1);
      while s1[i] <> ' ' do i := i + 1;
      Delete(s1, i, k); Delete(s2, 1, i);
      i := 1; k := Length(s2); s3 := s2;
      while s2[i] <> ' ' do i := i + 1;
      Delete(s2, i, k); Delete(s3, 1, i);
      Val(s1, from); Val(s2, too); Val(s3, weight);
      new(temp1); new(temp2);
      temp1^.too := too;
      temp1^.weight := weight;
      temp1^.next := Nil;
      help1 := V[from];
      if help1 = Nil then V[from] := temp1 else begin
        while help1^.next <> Nil do help1 := help1^.next;
        help1^.next := temp1;
      end;
      temp2^.too := from;
      temp2^.weight := weight;
      temp2^.next := Nil;
      help2 := V[too];
      if help2 = Nil then V[too] := temp2 else begin
        while help2^.next <> Nil do help2 := help2^.next;
        help2^.next := temp2;
      end;
    end;
  end;

procedure show(V : list); var i : integer; temp : wsk; begin for i := 1
to n do begin temp := V[i]; write(i,' :'); while temp <> Nil do begin
  write(' ',temp^.too); temp := temp^.next; end; writeln; end; end; 

procedure show2(x : pnt; d : numList); var temp : pnt; begin temp := x;
while temp <> Nil do begin write(temp^.key, ' w:', d[temp^.key],', ');
temp := temp^.next; end; writeln; end;

function initQ(d : numList):pnt;
  var
    tempList : pnt;
    temp : pnt;
    i : integer;
  begin
    tempList := Nil;
    for i := 1 to n do begin
      new(temp);
      temp^.key := i;
      temp^.next := tempList;
      tempList := temp;
    end;
    initQ := tempList;
  end;

function sortQ(Q : pnt; d : numList):pnt;
  var
    worker : pnt;
    resu : pnt;
    temp : pnt;
    walker : pnt;
    waste : pnt;
  begin
    new(resu);
    resu := NIl;
    worker := Q;
    while worker <> Nil do begin
      new(temp); temp^.key := worker^.key; temp^.next := Nil;
       if resu = Nil then resu := temp  else begin
        if d[temp^.key] <= d[resu^.key] then begin
          temp^.next := resu; resu := temp;
        end else begin
          walker := resu; 
          while (walker^.next <> Nil) and (d[walker^.next^.key] < d[temp^.key]) do walker := walker^.next;
          temp^.next := walker^.next; walker^.next := temp;
        end; 
      end; 
      waste := worker;
      worker := worker^.next;
      dispose(waste);
    end;
    sortQ := resu;
  end;

function popFrom(var Q : pnt) : integer;
  var
    temp : pnt;
  begin
    temp := Q;
    if Q = Nil then begin 
      writeln('error: cant pop from empty Q');
      popFrom := -1;
    end else begin
      temp := Q; Q := Q^.next;
      popFrom := temp^.key;
      dispose(temp);
    end;
  end;

procedure dijkstra( var Q : pnt; edgeList : list; var d : numList; var kolor : colorList );
  var
    temp : integer;
      i,k : integer;
    work : wsk;
  begin
    writeln('before Dijjkstras run d table is as follows: ');
    for temp := 1 to n do write(d[temp], ' '); writeln; writeln;
    while Q <> Nil do begin
      i := popFrom(Q);
      kolor[i] := czarny;
      writeln('i is ', i);
      writeln('d[',i,'] is ', d[i]);
      work := edgeList[i];
      while work <> Nil do begin
        k := work^.too;
        if kolor[k] = bialy then begin
          writeln('k is ', k);
          writeln('old d[',k,'] is ', d[k]);
          writeln('the weight is ', work^.weight );
          if d[k] > d[i] + work^.weight then d[k] :=  d[i] + work^.weight;
          writeln('not d[',k,'] is ', d[k]);
          writeln;
        end else writeln('not considering ', k, ' because it is black');
        work := work^.next;
        readln;
      end;
      writeln('after iter d table is: ');
      for temp := 1 to n do write(d[temp], ' '); writeln; writeln;
      Q := sortQ(Q, d);
      writeln; writeln('Here goes the weight Q');
      show2(Q,d);
      writeln;
    end;
  end;

var 
  edgeList : list;
     kolor : colorList;
      d, P : numList;
         i : integer;
         Q : pnt;
    target : integer;

begin
  target := 1; 
  for i := 1 to n do kolor[i] := bialy; for i := 1 to n do d[i] := inf; d[target] := 0;
  for i := 1 to n do P[i] := 0;
  makeEdgeList(edgeList);  // show(edgeList);
  Q := initQ(d); Q := sortQ(Q, d);
  dijkstra(Q, edgeList, d, kolor);
end.
