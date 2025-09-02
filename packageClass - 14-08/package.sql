CREATE OR REPLACE PACKAGE pkg_aula_01 AS 
    PROCEDURE insert_cliente (
    p_id NUMBER,
    p_nome VARCHAR2,
    p_email VARCHAR2,
    p_data_cadastro DATE
    );

    FUNCTION contar_clientes RETURN NUMBER;

END pkg_aula_01;