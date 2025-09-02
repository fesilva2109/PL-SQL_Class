CREATE OR REPLACE PACKAGE pkg_pedio AS 
    PROCEDURE insert_pedido (
    p_id NUMBER, 
    p_id_cliente NUMBER, 
    p_id_usario NUMBER, 
    p_data_pedido DATE,
    p_data_entrega DATE,
    p_valor_pedido NUMBER
    );
        
    FUNCTION contar_pedidos RETURN NUMBER;
END pkg_pedido;
    