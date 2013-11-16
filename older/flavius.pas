program flavius;

type wsk = ^man;
     man = record
       next:wsk;
       number: integer;
     end;

var circle_of_death:wsk;
    n:integer;

procedure makeDeathCircle(var circ:wsk; n:integer);
  var i:integer; 
     nowy, old:wsk;
  begin
    new(old);
    circ := old;
    for i:=1 to n-1 do begin
      new(nowy);
      old^.number := i;
      old^.next := nowy;
      old := nowy;
    end;
    old^.number := n;
    old^.next := circ;
    end;

procedure kill_em(circ:wsk);
  var current,memory:wsk;
  begin
    current := circ;
    while current^.next <> current do begin
       memory := current^.next^.next;
       writeln(' Guy number ', current^.number, ' killed guy number ', current^.next^.number, ' and passed the knife to ', memory^.number); 
       dispose(current^.next); 
       current^.next := memory;
       current := current^.next; 
    end;
    writeln(' I had number ', current^.number,'. My name is Joseph Flavius, and I have survived to tell you this story.');
  end;


begin
  writeln('Please input the size of the circle');
  readln(n);
  makeDeathCircle(circle_of_death,n);
  kill_em(circle_of_death);
end.
