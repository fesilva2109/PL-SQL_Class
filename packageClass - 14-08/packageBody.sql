CREATE OR REPLACE PACKAGE BODY pkg_aula_01 AS
    PROCEDURE insert_cliente (
        p_id            NUMBER,
        p_nome          VARCHAR2,
        p_email         VARCHAR2,
        p_data_cadastro DATE
    ) IS
    BEGIN
        INSERT INTO insert_clientes VALUES ( p_id,
                                             p_nome,
                                             p_email,
                                             p_data_cadastro );

        COMMIT;
    END insert_cliente;

    FUNCTION contar_clientes RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        SELECT
            COUNT(1)
            
        INTO v_total
        FROM
            insert_clientes;

        RETURN v_total;
    END contar_clientes;

END pkg_aula_01;