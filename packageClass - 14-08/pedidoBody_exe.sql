CREATE OR REPLACE PACKAGE BODY pkg_pedido AS
    PROCEDURE insert_pedido (
        p_id NUMBER
    )IS 
    BEGIN 
        INSERT INTO insert_pedido VALUES(p_id );
        
        COMMIT;
    END insert_pedido;
    
    FUNCTION contar_pedidos RETURN NUMBER IS
        v_total NUMBER;
    BEGIN 
        SELECT 
            COUNT(1)
            INTO v_total
            FROM 
                insert_pedido
            RETURN v_total;
    END contar_pedidos;
END pkg_pedido
        