SET SERVEROUTPUT ON;

DECLARE 
    variavel10 NUMBER; 
    nome VARCHAR2(30) := 'Vergs';
BEGIN
    variavel10 := 10; 
    dbms_output.put_line('O valor digital �: ' || variavel10);
    dbms_output.put_line('O nome do d�gito �: ' ||nome);
END;
/
