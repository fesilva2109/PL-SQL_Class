-- =================================================================================================
-- GEF -> Mastering Relational and Non-Relational Database 
-- Integrantes: Eduardo H. S. Nagado, Gustavo R. Lazzuri, Felipe S. Maciel
-- =================================================================================================

-- Habilitar a saída do servidor para ver os resultados dos testes
SET SERVEROUTPUT ON;

-- SEÇÃO 1: DROPS e CRIAÇÃO DE TABELAS E SEQUÊNCIAS 

-- Inicia a limpeza do ambiente removendo sequences existentes para evitar conflitos.
BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE funcionario_seq';
    DBMS_OUTPUT.PUT_LINE('Sequence FUNCIONARIO_SEQ dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -2289 THEN
            DBMS_OUTPUT.PUT_LINE('Sequence FUNCIONARIO_SEQ does not exist.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE paciente_seq';
    DBMS_OUTPUT.PUT_LINE('Sequence PACIENTE_SEQ dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -2289 THEN
            DBMS_OUTPUT.PUT_LINE('Sequence PACIENTE_SEQ does not exist.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE pulseira_seq';
    DBMS_OUTPUT.PUT_LINE('Sequence PULSEIRA_SEQ dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -2289 THEN
            DBMS_OUTPUT.PUT_LINE('Sequence PULSEIRA_SEQ does not exist.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE nfc_seq';
    DBMS_OUTPUT.PUT_LINE('Sequence NFC_SEQ dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -2289 THEN
            DBMS_OUTPUT.PUT_LINE('Sequence NFC_SEQ does not exist.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE abrigo_seq';
    DBMS_OUTPUT.PUT_LINE('Sequence ABRIGO_SEQ dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -2289 THEN
            DBMS_OUTPUT.PUT_LINE('Sequence ABRIGO_SEQ does not exist.');
        ELSE
            RAISE;
        END IF;
END;
/


-- Remove as tabelas na ordem inversa de dependência para garantir a integridade referencial.
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE AUDITORIA CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table AUDITORIA dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('Table AUDITORIA does not exist.');
        ELSE
            RAISE;
        END IF;
END;
/
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE FUNCIONARIO CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table FUNCIONARIO dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('Table FUNCIONARIO does not exist.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PACIENTES CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table PACIENTES dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('Table PACIENTES does not exist.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PULSEIRA CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table PULSEIRA dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('Table PULSEIRA does not exist.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE BATIMENTO_CARDIACO CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table BATIMENTO_CARDIACO dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('Table BATIMENTO_CARDIACO does not exist.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE NFC CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table NFC dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('Table NFC does not exist.');
        ELSE
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE ABRIGO CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table ABRIGO dropped.');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('Table ABRIGO does not exist.');
        ELSE
            RAISE;
        END IF;
END;
/
-- =============================================================================
-- Criação das Tabelas e Sequências

-- Tabela ABRIGO: Armazena informações sobre os abrigos.
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE ABRIGO (
        ABRIGOID NUMBER PRIMARY KEY,
        NOME VARCHAR2(255) NOT NULL,
        ENDERECO VARCHAR2(255) NOT NULL
    )';
    DBMS_OUTPUT.PUT_LINE('Tabela ABRIGO criada.');
EXCEPTION WHEN OTHERS THEN IF SQLCODE = -955 THEN DBMS_OUTPUT.PUT_LINE('Tabela ABRIGO já existe.'); ELSE RAISE; END IF;
END;
/
CREATE SEQUENCE abrigo_seq START WITH 1 INCREMENT BY 1 NOCACHE;

-- Tabela NFC: Armazena os identificadores únicos de NFC.
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE NFC ( ID_NFC NUMBER PRIMARY KEY )';
    DBMS_OUTPUT.PUT_LINE('Tabela NFC criada.');
EXCEPTION WHEN OTHERS THEN IF SQLCODE = -955 THEN DBMS_OUTPUT.PUT_LINE('Tabela NFC já existe.'); ELSE RAISE; END IF;
END;
/
CREATE SEQUENCE nfc_seq START WITH 1 INCREMENT BY 1 NOCACHE;

-- Tabela BATIMENTO_CARDIACO: Armazena dados de batimentos cardíacos coletados por dispositivos IoT.
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE BATIMENTO_CARDIACO (
        IDBATIMENTOCARDIACO VARCHAR2(200) PRIMARY KEY,
        BPM NUMBER(3) CHECK (BPM BETWEEN 30 AND 220),
        TIMESTAMP NUMBER(14) NOT NULL
    )';
    DBMS_OUTPUT.PUT_LINE('Tabela BATIMENTO_CARDIACO criada.');
EXCEPTION WHEN OTHERS THEN IF SQLCODE = -955 THEN DBMS_OUTPUT.PUT_LINE('Tabela BATIMENTO_CARDIACO já existe.'); ELSE RAISE; END IF;
END;
/

-- Tabela PULSEIRA: Tabela de associação que conecta um NFC e um dispositivo IoT a uma pulseira.
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE PULSEIRA (
        ID_PULSEIRA NUMBER PRIMARY KEY,
        NFC_ID NUMBER UNIQUE,
        IOT_ID VARCHAR(200) UNIQUE,
        CONSTRAINT FK_PULSEIRA_NFC FOREIGN KEY (NFC_ID) REFERENCES NFC(ID_NFC),
        CONSTRAINT FK_PULSEIRA_IOT FOREIGN KEY (IOT_ID) REFERENCES BATIMENTO_CARDIACO(IDBATIMENTOCARDIACO)
    )';
    DBMS_OUTPUT.PUT_LINE('Tabela PULSEIRA criada.');
EXCEPTION WHEN OTHERS THEN IF SQLCODE = -955 THEN DBMS_OUTPUT.PUT_LINE('Tabela PULSEIRA já existe.'); ELSE RAISE; END IF;
END;
/
CREATE SEQUENCE pulseira_seq START WITH 1 INCREMENT BY 1 NOCACHE;

-- Tabela PACIENTES: Armazena os dados dos pacientes, associando-os a um abrigo e uma pulseira.
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE PACIENTES (
        ID NUMBER PRIMARY KEY,
        NOME VARCHAR2(255) NOT NULL,
        IDADE NUMBER CHECK (IDADE BETWEEN 0 AND 130),
        ENDERECO VARCHAR2(255),
        ABRIGO_ID NUMBER NOT NULL,
        PULSEIRA_ID NUMBER UNIQUE NOT NULL,
        CONSTRAINT FK_PACIENTES_ABRIGO FOREIGN KEY (ABRIGO_ID) REFERENCES ABRIGO(ABRIGOID),
        CONSTRAINT FK_PACIENTES_PULSEIRA FOREIGN KEY (PULSEIRA_ID) REFERENCES PULSEIRA(ID_PULSEIRA)
    )';
    DBMS_OUTPUT.PUT_LINE('Tabela PACIENTES criada.');
EXCEPTION WHEN OTHERS THEN IF SQLCODE = -955 THEN DBMS_OUTPUT.PUT_LINE('Tabela PACIENTES já existe.'); ELSE RAISE; END IF;
END;
/
CREATE SEQUENCE paciente_seq START WITH 1 INCREMENT BY 1 NOCACHE;

-- Tabela FUNCIONARIO: Armazena os dados dos funcionários e voluntários, associando-os a um abrigo.
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE FUNCIONARIO (
        ID NUMBER PRIMARY KEY,
        NOME VARCHAR2(255) NOT NULL,
        EMAIL VARCHAR2(255) NOT NULL UNIQUE,
        PASSWORD VARCHAR2(255) NOT NULL,
        CARGO VARCHAR2(50) NOT NULL CHECK (CARGO IN (''ADMINISTRADOR'', ''FUNCIONARIO'', ''VOLUNTARIO'')),
        ABRIGO_ID NUMBER NOT NULL,
        CONSTRAINT FK_FUNCIONARIO_ABRIGO FOREIGN KEY (ABRIGO_ID) REFERENCES ABRIGO(ABRIGOID)
    )';
    DBMS_OUTPUT.PUT_LINE('Tabela FUNCIONARIO criada.');
EXCEPTION WHEN OTHERS THEN IF SQLCODE = -955 THEN DBMS_OUTPUT.PUT_LINE('Tabela FUNCIONARIO já existe.'); ELSE RAISE; END IF;
END;
/
CREATE SEQUENCE funcionario_seq START WITH 1 INCREMENT BY 1 NOCACHE;


-- =============================================================================
-- SEÇÃO 2: INSERÇÃO DE DADOS INICIAIS (MÍNIMO 5 REGISTROS)
-- =============================================================================
BEGIN
    DBMS_OUTPUT.PUT_LINE('Inserindo dados iniciais...');
    -- Inserir 5 Abrigos
    INSERT INTO ABRIGO(ABRIGOID, NOME, ENDERECO) VALUES (abrigo_seq.NEXTVAL, 'Abrigo Esperança', 'Rua das Flores, 100');
    INSERT INTO ABRIGO(ABRIGOID, NOME, ENDERECO) VALUES (abrigo_seq.NEXTVAL, 'Abrigo Solidário', 'Avenida Principal, 250');
    INSERT INTO ABRIGO(ABRIGOID, NOME, ENDERECO) VALUES (abrigo_seq.NEXTVAL, 'Abrigo do Povo', 'Praça da Liberdade, 15');
    INSERT INTO ABRIGO(ABRIGOID, NOME, ENDERECO) VALUES (abrigo_seq.NEXTVAL, 'Abrigo Luz', 'Travessa dos Sonhos, 50');
    INSERT INTO ABRIGO(ABRIGOID, NOME, ENDereco) VALUES (abrigo_seq.NEXTVAL, 'Abrigo Bem-Estar', 'Alameda das Árvores, 300');

    -- Inserir 5 NFCs, Batimentos e Pulseiras
    FOR i IN 1..5 LOOP
        INSERT INTO NFC(ID_NFC) VALUES (nfc_seq.NEXTVAL);
        INSERT INTO BATIMENTO_CARDIACO(IDBATIMENTOCARDIACO, BPM, TIMESTAMP) VALUES (SYS_GUID(), 70 + i, 1678886400 + (i*60));
        
        -- Associa a nova pulseira ao NFC e ao dado de batimento cardíaco mais recente.
        INSERT INTO PULSEIRA(ID_PULSEIRA, NFC_ID, IOT_ID) VALUES (
            pulseira_seq.NEXTVAL,
            (SELECT MAX(ID_NFC) FROM NFC),
            (SELECT IDBATIMENTOCARDIACO FROM (SELECT IDBATIMENTOCARDIACO FROM BATIMENTO_CARDIACO ORDER BY TIMESTAMP DESC) WHERE ROWNUM = 1)
        );
    END LOOP;

    -- Inserir 5 Pacientes
    INSERT INTO PACIENTES(ID, NOME, IDADE, ENDERECO, ABRIGO_ID, PULSEIRA_ID) VALUES (paciente_seq.NEXTVAL, 'Ana Silva', 75, 'Rua das Palmeiras, 45', 1, 1);
    INSERT INTO PACIENTES(ID, NOME, IDADE, ENDERECO, ABRIGO_ID, PULSEIRA_ID) VALUES (paciente_seq.NEXTVAL, 'Carlos Souza', 68, 'Avenida das Acácias, 123', 2, 2);
    INSERT INTO PACIENTES(ID, NOME, IDADE, ENDERECO, ABRIGO_ID, PULSEIRA_ID) VALUES (paciente_seq.NEXTVAL, 'Maria Oliveira', 82, 'Beco do Sossego, 7', 1, 3);
    INSERT INTO PACIENTES(ID, NOME, IDADE, ENDERECO, ABRIGO_ID, PULSEIRA_ID) VALUES (paciente_seq.NEXTVAL, 'João Santos', 91, 'Estrada Velha, 99', 3, 4);
    INSERT INTO PACIENTES(ID, NOME, IDADE, ENDERECO, ABRIGO_ID, PULSEIRA_ID) VALUES (paciente_seq.NEXTVAL, 'Fernanda Lima', 60, 'Praça da Amizade, 22', 2, 5);

    -- Inserir 5 Funcionários
    INSERT INTO FUNCIONARIO(ID, NOME, EMAIL, PASSWORD, CARGO, ABRIGO_ID) VALUES (funcionario_seq.NEXTVAL, 'Admin Geral', 'admin@gefbio.com', '12345', 'ADMINISTRADOR', 1);
    INSERT INTO FUNCIONARIO(ID, NOME, EMAIL, PASSWORD, CARGO, ABRIGO_ID) VALUES (funcionario_seq.NEXTVAL, 'João da Silva', 'joao@gefbio.com', '12345', 'FUNCIONARIO', 1);
    INSERT INTO FUNCIONARIO(ID, NOME, EMAIL, PASSWORD, CARGO, ABRIGO_ID) VALUES (funcionario_seq.NEXTVAL, 'Maria Pereira', 'maria@gefbio.com', '12345', 'FUNCIONARIO', 2);
    INSERT INTO FUNCIONARIO(ID, NOME, EMAIL, PASSWORD, CARGO, ABRIGO_ID) VALUES (funcionario_seq.NEXTVAL, 'Carlos Dias', 'carlos@gefbio.com', '12345', 'VOLUNTARIO', 2);
    INSERT INTO FUNCIONARIO(ID, NOME, EMAIL, PASSWORD, CARGO, ABRIGO_ID) VALUES (funcionario_seq.NEXTVAL, 'Ana Costa', 'ana@gefbio.com', '12345', 'FUNCIONARIO', 3);

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Carga de dados iniciais concluída.');
END;
/


-- =============================================================================
-- SEÇÃO 3: CÓDIGO DA 3ª SPRINT (PROCEDURES, FUNÇÕES, TRIGGER)
-- =============================================================================

-- Adiciona colunas para suportar as novas regras de negócio.
BEGIN
   EXECUTE IMMEDIATE 'ALTER TABLE ABRIGO ADD CAPACIDADE NUMBER(5) DEFAULT 100 NOT NULL';
EXCEPTION WHEN OTHERS THEN IF SQLCODE = -1430 THEN DBMS_OUTPUT.PUT_LINE('Coluna CAPACIDADE já existe na tabela ABRIGO.'); ELSE RAISE; END IF;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'ALTER TABLE FUNCIONARIO ADD SALARIO NUMBER(10, 2) DEFAULT 1500.00 NOT NULL';
EXCEPTION WHEN OTHERS THEN IF SQLCODE = -1430 THEN DBMS_OUTPUT.PUT_LINE('Coluna SALARIO já existe na tabela FUNCIONARIO.'); ELSE RAISE; END IF;
END;
/
-- Atualiza os registros existentes com valores para as novas colunas.
BEGIN
    UPDATE ABRIGO SET CAPACIDADE = 50 WHERE ABRIGOID = 1;
    UPDATE ABRIGO SET CAPACIDADE = 70 WHERE ABRIGOID = 2;
    UPDATE FUNCIONARIO SET SALARIO = 5000.00 WHERE CARGO = 'ADMINISTRADOR' AND ABRIGO_ID = 1;
    UPDATE FUNCIONARIO SET SALARIO = 2500.00 WHERE CARGO = 'FUNCIONARIO' AND ABRIGO_ID = 1;
    UPDATE FUNCIONARIO SET SALARIO = 2800.00 WHERE CARGO = 'FUNCIONARIO' AND ABRIGO_ID = 2;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Tabelas ABRIGO e FUNCIONARIO atualizadas com dados de exemplo.');
END;
/

-- FUNÇÃO 1: Converte um SYS_REFCURSOR para uma string no formato JSON.
CREATE OR REPLACE FUNCTION FNC_RELACIONAL_PARA_JSON (
    p_cursor IN SYS_REFCURSOR
) RETURN CLOB
IS
    v_json_clob CLOB;
    v_col_count INTEGER;
    v_desc_tab DBMS_SQL.DESC_TAB;
    v_cursor_id INTEGER;
    v_col_value VARCHAR2(4000);
    v_is_first_row BOOLEAN := TRUE;
    -- Variável local para receber a referência do cursor, permitindo sua manipulação pelo pacote DBMS_SQL.
    l_cursor SYS_REFCURSOR; 
BEGIN
    l_cursor := p_cursor;
    v_cursor_id := DBMS_SQL.TO_CURSOR_NUMBER(l_cursor);
    DBMS_SQL.DESCRIBE_COLUMNS(v_cursor_id, v_col_count, v_desc_tab);
    
    FOR i IN 1..v_col_count LOOP
        DBMS_SQL.DEFINE_COLUMN(v_cursor_id, i, v_col_value, 4000);
    END LOOP;
    
    v_json_clob := '[';
    WHILE DBMS_SQL.FETCH_ROWS(v_cursor_id) > 0 LOOP
        IF NOT v_is_first_row THEN v_json_clob := v_json_clob || ','; END IF;
        v_json_clob := v_json_clob || CHR(10) || '{';
        FOR i IN 1..v_col_count LOOP
            DBMS_SQL.COLUMN_VALUE(v_cursor_id, i, v_col_value);
            v_json_clob := v_json_clob || '"' || LOWER(v_desc_tab(i).col_name) || '":"' || REPLACE(v_col_value, '"', '\"') || '"';
            IF i < v_col_count THEN v_json_clob := v_json_clob || ','; END IF;
        END LOOP;
        v_json_clob := v_json_clob || '}';
        v_is_first_row := FALSE;
    END LOOP;
    v_json_clob := v_json_clob || CHR(10) || ']';
    
    DBMS_SQL.CLOSE_CURSOR(v_cursor_id);
    IF v_is_first_row THEN RETURN '[]'; END IF;
    RETURN v_json_clob;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        IF DBMS_SQL.IS_OPEN(v_cursor_id) THEN DBMS_SQL.CLOSE_CURSOR(v_cursor_id); END IF;
        RETURN '{"erro": "Nenhum dado encontrado no cursor."}';
    -- Trata a exceção que ocorre se o cursor de entrada for inválido ou estiver fechado.
    WHEN INVALID_CURSOR THEN
        IF DBMS_SQL.IS_OPEN(v_cursor_id) THEN DBMS_SQL.CLOSE_CURSOR(v_cursor_id); END IF;
        RETURN '{"erro": "Cursor inválido ou fechado fornecido."}';
    WHEN OTHERS THEN
        IF DBMS_SQL.IS_OPEN(v_cursor_id) THEN DBMS_SQL.CLOSE_CURSOR(v_cursor_id); END IF;
        RETURN '{"erro": "Ocorreu um erro ao converter para JSON: ' || SQLERRM || '"}';
END FNC_RELACIONAL_PARA_JSON;
/

-- PROCEDIMENTO 1: Lista pacientes e seus abrigos, retornando o resultado em formato JSON.
CREATE OR REPLACE PROCEDURE PRC_LISTAR_PACIENTES_JSON
IS
    v_cursor SYS_REFCURSOR;
    v_json_result CLOB;
    e_nenhum_paciente EXCEPTION;
BEGIN
    OPEN v_cursor FOR
        SELECT p.NOME AS nome_paciente, p.IDADE, a.NOME AS nome_abrigo, a.ENDERECO AS endereco_abrigo
        FROM PACIENTES p JOIN ABRIGO a ON p.ABRIGO_ID = a.ABRIGOID;
    
    v_json_result := FNC_RELACIONAL_PARA_JSON(v_cursor);
    
    IF v_json_result = '[]' THEN 
        RAISE e_nenhum_paciente; 
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('--- Relatório de Pacientes em formato JSON ---');
    DBMS_OUTPUT.PUT_LINE(v_json_result);
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------');
EXCEPTION
    WHEN e_nenhum_paciente THEN DBMS_OUTPUT.PUT_LINE('Erro Tratado: Nenhum paciente encontrado para gerar o relatório.');
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Erro Tratado: A consulta não retornou nenhum dado (NO_DATA_FOUND).');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Erro Tratado Inesperado no procedimento PRC_LISTAR_PACIENTES_JSON: ' || SQLERRM);
END PRC_LISTAR_PACIENTES_JSON;
/

-- Tabela de Auditoria para registrar alterações na tabela de pacientes.
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE AUDITORIA (
        ID_AUDITORIA NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
        NOME_USUARIO VARCHAR2(100), TIPO_OPERACAO VARCHAR2(10), DATA_HORA TIMESTAMP,
        VALORES_ANTERIORES CLOB, VALORES_NOVOS CLOB )';
EXCEPTION WHEN OTHERS THEN IF SQLCODE = -955 THEN DBMS_OUTPUT.PUT_LINE('Tabela AUDITORIA já existe.'); ELSE RAISE; END IF;
END;
/
-- TRIGGER: Captura operações de DML na tabela PACIENTES e registra na tabela AUDITORIA.
CREATE OR REPLACE TRIGGER TRG_AUDITA_PACIENTES
AFTER INSERT OR UPDATE OR DELETE ON PACIENTES
FOR EACH ROW
DECLARE
    v_old_values CLOB; v_new_values CLOB;
BEGIN
    IF DELETING OR UPDATING THEN 
        v_old_values := 'ID=' || :OLD.ID || ', NOME=' || :OLD.NOME || ', IDADE=' || :OLD.IDADE || ', ABRIGO_ID=' || :OLD.ABRIGO_ID; 
    END IF;
    IF INSERTING OR UPDATING THEN 
        v_new_values := 'ID=' || :NEW.ID || ', NOME=' || :NEW.NOME || ', IDADE=' || :NEW.IDADE || ', ABRIGO_ID=' || :NEW.ABRIGO_ID; 
    END IF;
    
    IF INSERTING THEN 
        INSERT INTO AUDITORIA (NOME_USUARIO, TIPO_OPERACAO, DATA_HORA, VALORES_NOVOS) VALUES (USER, 'INSERT', SYSTIMESTAMP, v_new_values);
    ELSIF UPDATING THEN 
        INSERT INTO AUDITORIA (NOME_USUARIO, TIPO_OPERACAO, DATA_HORA, VALORES_ANTERIORES, VALORES_NOVOS) VALUES (USER, 'UPDATE', SYSTIMESTAMP, v_old_values, v_new_values);
    ELSIF DELETING THEN 
        INSERT INTO AUDITORIA (NOME_USUARIO, TIPO_OPERACAO, DATA_HORA, VALORES_ANTERIORES) VALUES (USER, 'DELETE', SYSTIMESTAMP, v_old_values); 
    END IF;
EXCEPTION 
    WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20001, 'Erro no trigger de auditoria: ' || SQLERRM);
END TRG_AUDITA_PACIENTES;
/

-- FUNÇÃO 2: Verifica a disponibilidade de vagas em um abrigo específico.
CREATE OR REPLACE FUNCTION FNC_VERIFICAR_VAGA_ABRIGO (p_abrigo_id IN NUMBER) RETURN NUMBER
IS
    v_capacidade NUMBER; 
    v_pacientes_atuais NUMBER; 
    e_capacidade_invalida EXCEPTION;
BEGIN
    SELECT CAPACIDADE INTO v_capacidade FROM ABRIGO WHERE ABRIGOID = p_abrigo_id;
    IF v_capacidade IS NULL OR v_capacidade <= 0 THEN 
        RAISE e_capacidade_invalida; 
    END IF;
    
    SELECT COUNT(*) INTO v_pacientes_atuais FROM PACIENTES WHERE ABRIGO_ID = p_abrigo_id;
    -- Retorna 1 se há vaga, 0 se não há vaga.
    IF v_pacientes_atuais < v_capacidade THEN 
        RETURN 1; 
    ELSE 
        RETURN 0; 
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20002, 'Erro Tratado: Abrigo com ID ' || p_abrigo_id || ' não encontrado.');
    WHEN e_capacidade_invalida THEN RAISE_APPLICATION_ERROR(-20003, 'Erro Tratado: A capacidade do abrigo ' || p_abrigo_id || ' não é válida.');
    WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20004, 'Erro Tratado Inesperado ao verificar vagas: ' || SQLERRM);
END FNC_VERIFICAR_VAGA_ABRIGO;
/

-- PROCEDIMENTO 2: Gera um relatório salarial com subtotais por abrigo e um total geral, com lógica de agregação manual.
CREATE OR REPLACE PROCEDURE PRC_RELATORIO_SALARIAL_MANUAL
IS
    CURSOR c_funcionarios IS 
        SELECT a.NOME AS nome_abrigo, f.CARGO, f.SALARIO 
        FROM FUNCIONARIO f
        JOIN ABRIGO a ON f.ABRIGO_ID = a.ABRIGOID 
        ORDER BY a.NOME, f.CARGO;
        
    v_abrigo_atual ABRIGO.NOME%TYPE := NULL; 
    v_subtotal_abrigo NUMBER(12, 2) := 0; 
    v_total_geral NUMBER(14, 2) := 0; 
    v_primeira_linha BOOLEAN := TRUE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Relatório de Salários por Abrigo e Cargo ---');
    DBMS_OUTPUT.PUT_LINE(RPAD('Abrigo', 30) || RPAD('Cargo', 20) || 'Salário');
    DBMS_OUTPUT.PUT_LINE(RPAD('-', 70, '-'));
    
    FOR rec IN c_funcionarios LOOP
        -- Se o abrigo do registro atual for diferente do anterior, exibe o subtotal.
        IF v_abrigo_atual IS NOT NULL AND rec.nome_abrigo != v_abrigo_atual THEN
            DBMS_OUTPUT.PUT_LINE(RPAD('-', 70, '-'));
            DBMS_OUTPUT.PUT_LINE(RPAD('Subtotal ' || v_abrigo_atual, 50) || TO_CHAR(v_subtotal_abrigo, '999G999D99'));
            DBMS_OUTPUT.PUT_LINE('');
            v_total_geral := v_total_geral + v_subtotal_abrigo; 
            v_subtotal_abrigo := 0;
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(RPAD(rec.nome_abrigo, 30) || RPAD(rec.cargo, 20) || TO_CHAR(rec.SALARIO, '999G999D99'));
        v_subtotal_abrigo := v_subtotal_abrigo + rec.SALARIO; 
        v_abrigo_atual := rec.nome_abrigo; 
        v_primeira_linha := FALSE;
    END LOOP;
    
    -- Exibe o subtotal do último grupo e o total geral após o loop.
    IF NOT v_primeira_linha THEN
        DBMS_OUTPUT.PUT_LINE(RPAD('-', 70, '-'));
        DBMS_OUTPUT.PUT_LINE(RPAD('Subtotal ' || v_abrigo_atual, 50) || TO_CHAR(v_subtotal_abrigo, '999G999D99'));
        v_total_geral := v_total_geral + v_subtotal_abrigo;
        DBMS_OUTPUT.PUT_LINE(RPAD('=', 70, '='));
        DBMS_OUTPUT.PUT_LINE(RPAD('TOTAL GERAL', 50) || TO_CHAR(v_total_geral, '999G999D99'));
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Nenhum funcionário encontrado para o relatório.'); 
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('Erro Tratado: Nenhum funcionário foi encontrado para o relatório.');
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Erro Tratado Inesperado ao gerar relatório salarial: ' || SQLERRM);
END PRC_RELATORIO_SALARIAL_MANUAL;
/



-- =============================================================================
-- SEÇÃO 4: BLOCO DE TESTES E EXECUÇÃO FINAL
-- =============================================================================
DECLARE
    v_tem_vaga NUMBER;
    v_cursor_teste SYS_REFCURSOR;
    v_json_teste CLOB;
BEGIN
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- EXECUTANDO TESTES DA SPRINT 3 ---');
    
    -- ===================================
    -- Testes de SUCESSO
    -- ===================================
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- INICIANDO TESTES DE SUCESSO ---');
    
    -- Teste Procedimento 1 (Sucesso)
    PRC_LISTAR_PACIENTES_JSON;
    
    -- Teste Trigger (Sucesso)
    INSERT INTO PULSEIRA (ID_PULSEIRA) VALUES (99);
    INSERT INTO PACIENTES (ID, NOME, IDADE, ENDERECO, ABRIGO_ID, PULSEIRA_ID) VALUES (99, 'Paciente Teste Trigger', 80, 'Rua do Teste', 1, 99);
    UPDATE PACIENTES SET IDADE = 81 WHERE ID = 99;
    DELETE FROM PACIENTES WHERE ID = 99;
    DELETE FROM PULSEIRA WHERE ID_PULSEIRA = 99;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Trigger testado com sucesso. Verifique a tabela AUDITORIA.');

    -- Teste Função 2 (Sucesso)
    v_tem_vaga := FNC_VERIFICAR_VAGA_ABRIGO(p_abrigo_id => 1);
    IF v_tem_vaga = 1 THEN 
        DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Resultado (Abrigo 1): Há vagas disponíveis.');
    ELSE 
        DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Resultado (Abrigo 1): Não há vagas disponíveis.'); 
    END IF;

    -- Teste Procedimento 2 (Sucesso)
    DBMS_OUTPUT.PUT_LINE('');
    PRC_RELATORIO_SALARIAL_MANUAL;

    -- ===================================
    -- Testes de EXCEÇÃO
    -- ===================================
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- INICIANDO TESTES DE EXCEÇÃO ---');
    
    -- Teste de Exceção para a Função 1 (FNC_RELACIONAL_PARA_JSON)
    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Teste de Exceção (Função 1): Passando um cursor inválido/fechado.');
    -- O cursor v_cursor_teste é declarado mas não é aberto, forçando a exceção INVALID_CURSOR.
    v_json_teste := FNC_RELACIONAL_PARA_JSON(v_cursor_teste);
    DBMS_OUTPUT.PUT_LINE(v_json_teste);

    -- Teste de Exceção para o Procedimento 1 (PRC_LISTAR_PACIENTES_JSON)
    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Teste de Exceção (Procedimento 1): Nenhum paciente encontrado.');
    -- Remove todos os pacientes temporariamente para forçar a exceção.
    DELETE FROM PACIENTES;
    PRC_LISTAR_PACIENTES_JSON;
    ROLLBACK; -- Desfaz a remoção dos pacientes para os próximos testes.

    -- Teste de Exceção para a Função 2 (FNC_VERIFICAR_VAGA_ABRIGO)
    BEGIN
        v_tem_vaga := FNC_VERIFICAR_VAGA_ABRIGO(p_abrigo_id => 999);
    EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Teste de Exceção (Função 2 - Abrigo 999): ' || SQLERRM);
    END;

    -- Teste de Exceção para o Procedimento 2 (PRC_RELATORIO_SALARIAL_MANUAL)
    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Teste de Exceção (Procedimento 2): Nenhum funcionário encontrado.');
    -- Remove todos os funcionários temporariamente para forçar a exceção.
    DELETE FROM FUNCIONARIO;
    PRC_RELATORIO_SALARIAL_MANUAL;
    ROLLBACK; 

END;
/
