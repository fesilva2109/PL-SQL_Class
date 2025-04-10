
CREATE OR REPLACE FUNCTION FUN_VALIDA_NOME(
    p_nome IN VARCHAR2
) RETURN BOOLEAN
IS
BEGIN
    IF LENGTH(p_nome) <= 3 THEN
        RETURN FALSE;
    END IF;
    
    FOR i IN 1..LENGTH(p_nome) LOOP
        IF SUBSTR(p_nome, i, 1) BETWEEN '0' AND '9' THEN
            RETURN FALSE;
        END IF;
    END LOOP;
    
    RETURN TRUE;
EXCEPTION
    WHEN OTHERS THEN
        RETURN FALSE;
END FUN_VALIDA_NOME;
/


CREATE OR REPLACE PROCEDURE ListarPedidosCliente(
    p_cod_cliente IN CLIENTE.COD_CLIENTE%TYPE
)
IS
    v_cliente_existe NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_cliente_existe FROM CLIENTE WHERE COD_CLIENTE = p_cod_cliente;
    
    IF v_cliente_existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Cliente não encontrado!');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('=== PEDIDOS DO CLIENTE ' || p_cod_cliente || ' ===');
    FOR pedido IN (
        SELECT COD_PEDIDO, DAT_PEDIDO, VAL_TOTAL_PEDIDO 
        FROM PEDIDO 
        WHERE COD_CLIENTE = p_cod_cliente
        ORDER BY DAT_PEDIDO DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Pedido: ' || pedido.COD_PEDIDO || 
            ' | Data: ' || TO_CHAR(pedido.DAT_PEDIDO, 'DD/MM/YYYY') || 
            ' | Valor: R$ ' || pedido.VAL_TOTAL_PEDIDO
        );
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE ListarItensPedido(
    p_cod_pedido IN PEDIDO.COD_PEDIDO%TYPE
)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== ITENS DO PEDIDO ' || p_cod_pedido || ' ===');
    FOR item IN (
        SELECT i.COD_ITEM_PEDIDO, p.NOM_PRODUTO, i.QTD_ITEM
        FROM ITEM_PEDIDO i
        JOIN PRODUTO p ON i.COD_PRODUTO = p.COD_PRODUTO
        WHERE i.COD_PEDIDO = p_cod_pedido
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Item: ' || item.COD_ITEM_PEDIDO || 
            ' | Produto: ' || item.NOM_PRODUTO || 
            ' | Qtd: ' || item.QTD_ITEM
        );
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE prc_insere_produto(
    p_nom_produto IN PRODUTO.NOM_PRODUTO%TYPE,
    p_cod_barra IN PRODUTO.COD_BARRA%TYPE DEFAULT NULL,
    p_retorno OUT VARCHAR2
)
IS
BEGIN
    IF NOT FUN_VALIDA_NOME(p_nom_produto) THEN
        RAISE_APPLICATION_ERROR(-20002, 'Nome do produto inválido!');
    END IF;
    
    INSERT INTO PRODUTO (
        COD_PRODUTO, NOM_PRODUTO, COD_BARRA, STA_ATIVO, DAT_CADASTRO
    ) VALUES (
        (SELECT NVL(MAX(COD_PRODUTO),0)+1 FROM PRODUTO),
        p_nom_produto, p_cod_barra, 'S', SYSDATE
    );
    
    p_retorno := 'Produto cadastrado com sucesso!';
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        p_retorno := 'Erro: ' || SQLERRM;
        ROLLBACK;
END;
/


CREATE OR REPLACE PROCEDURE prc_insere_cliente(
    p_nom_cliente IN CLIENTE.NOM_CLIENTE%TYPE,
    p_num_cpf_cnpj IN CLIENTE.NUM_CPF_CNPJ%TYPE,
    p_retorno OUT VARCHAR2
)
IS
BEGIN
    IF NOT FUN_VALIDA_NOME(p_nom_cliente) THEN
        RAISE_APPLICATION_ERROR(-20003, 'Nome do cliente inválido!');
    END IF;
    
    INSERT INTO CLIENTE (
        COD_CLIENTE, NOM_CLIENTE, NUM_CPF_CNPJ, DAT_CADASTRO, STA_ATIVO
    ) VALUES (
        (SELECT NVL(MAX(COD_CLIENTE),0)+1 FROM CLIENTE),
        p_nom_cliente, p_num_cpf_cnpj, SYSDATE, 'S'
    );
    
    p_retorno := 'Cliente cadastrado com sucesso!';
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        p_retorno := 'Erro: ' || SQLERRM;
        ROLLBACK;
END;
/


DECLARE
    v_retorno VARCHAR2(500);
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== TESTE 1: ListarPedidosCliente ===');
    ListarPedidosCliente(1);
    
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '=== TESTE 2: ListarItensPedido ===');
    ListarItensPedido(134190);
    
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '=== TESTE 3: prc_insere_produto ===');
    prc_insere_produto('Teclado Gamer', '789123456', v_retorno);
    DBMS_OUTPUT.PUT_LINE(v_retorno);
    
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '=== TESTE 4: prc_insere_cliente ===');
    prc_insere_cliente('Carlos Silva', '12345678901', v_retorno);
    DBMS_OUTPUT.PUT_LINE(v_retorno);
    
    BEGIN
        prc_insere_cliente('Ana1', '98765432100', v_retorno);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(CHR(10) || '=== TESTE 5: ERRO ESPERADO ===');
            DBMS_OUTPUT.PUT_LINE('Erro capturado: ' || SQLERRM);
    END;
END;
/