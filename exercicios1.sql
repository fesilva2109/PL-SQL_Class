SET SERVEROUTPUT ON;

DECLARE
    salariominimo NUMBER := 1500;
    aumento NUMBER;
BEGIN
    aumento := salariominimo + (salariominimo * 0.25);
    dbms_output.put_line('O valor do novo salário mínimo com 25% é: ' || aumento);
END;

/
--EX2

DECLARE 
    quantiadolar NUMBER := &valor;
    conversao NUMBER := 5.70;
    novovalor NUMBER;

BEGIN
    novovalor := quantiadolar * conversao;
    dbms_output.put_line('Sua quantia de dólares em reais é: R$' || novovalor);
END;
/

--EX3
DECLARE
    valorDaCompra NUMBER :=&valor;
    taxaDeJuros NUMBER:= 0.03;
    numDeParcelas NUMBER := 10;
    parcelas NUMBER;
    valorParcela NUMBER;
BEGIN

    parcelas := valorDaCompra + (valorDaCompra * taxaDeJuros);
    valorParcela := parcelas/numDeParcelas;
    
    dbms_output.put_line('Valor à vista: ' || valorDaCompra);
    dbms_output.put_line('Valor das parcelas: ' || valorParcela);
    dbms_output.put_line('Valor total da compra: ' || parcelas);
   
END;

--EX4
