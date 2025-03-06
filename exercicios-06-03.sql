set SERVEROUTPUT ON
--1

begin
  for x in 1..10 loop
    DBMS_OUTPUT.PUT_LINE(x*150)
  end loop
end;

--2

DECLARE
    impar NUMBER:= 0;
    par NUMBER:=0;
begin
  for x in 1..15 loop
    IF MOD(X,2) = 0 THEN
        par:= par+1;
    ELSE
        IMPAR:=IMPAR+1;
    END IF;
    end loop;
    
    DBMS_OUTPUT.PUT_LINE('A QUANTIADE DE PARES: '|| PAR);
    DBMS_OUTPUT.PUT_LINE('A QUANTIADE DE IMPARES: '|| IMPAR);
    

end;

--3
