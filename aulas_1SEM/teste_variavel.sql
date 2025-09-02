SET SERVEROUTPUT ON;

DECLARE 
    variavel10 NUMBER; 
    nome VARCHAR2(30) := 'Vergs';
BEGIN
    variavel10 := 10; 
    dbms_output.put_line('O valor digital é: ' || variavel10);
    dbms_output.put_line('O nome do dígito é: ' ||nome);
END;
/
