program collatz;

var
  i,j : longint;
  mistrz, wynikMistrza, wynik : integer;

function collNext(n:Longint) : longint;
begin
  if ((n mod 2) = 0) then collNext := n div 2 else collNext := 3*n + 1;
end;


begin 
  mistrz := 0; wynikMistrza := 0;

  for i := 1 to 10000 do begin
    j := i; wynik := 1;
    while (j <> 1) do begin 
      j := collNext(j);
      wynik := wynik + 1;
    end;
    if wynik > wynikMistrza then begin 
      writeln( 'Nowy champion: ', i, ' a jego wynik to: ', wynik);
      mistrz := i; wynikMistrza := wynik;
    end;
  end;
  writeln( ' Mistrz to ', mistrz, ' a jego wynik to ', wynikMistrza);
  readln();
end.
