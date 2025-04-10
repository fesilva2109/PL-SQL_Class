CREATE OR REPLACE PROCEDURE ListarValorPedidosCliente (
    p_cod_cliente IN CLIENTE.COD_CLIENTE%TYPE
)
IS 
    v_cliente_existe NUMBER;
    valor_total NUMBER := 0; 
BEGIN
    SELECT COUNT(*) INTO v_cliente_existe 
    FROM CLIENTE 
    WHERE COD_CLIENTE = p_cod_cliente;

    IF v_cliente_existe = 0 THEN
       RAISE_APPLICATION_ERROR(-20001, 'Cliente não encontrado!');
    END IF;

    -- Calcula o valor total de todos os pedidos do cliente
    FOR pedido IN (
        SELECT VAL_TOTAL_PEDIDO 
        FROM PEDIDO
        WHERE COD_CLIENTE = p_cod_cliente
    ) LOOP
        valor_total := valor_total + pedido.VAL_TOTAL_PEDIDO;  
    END LOOP;

    -- Mostra o resultado final
    DBMS_OUTPUT.PUT_LINE('Cliente: ' || p_cod_cliente);
    DBMS_OUTPUT.PUT_LINE('Valor total gasto em todos os pedidos: R$ ' || 
                         valor_total);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERRO: ' || SQLERRM);
END ListarValorPedidosCliente;

/