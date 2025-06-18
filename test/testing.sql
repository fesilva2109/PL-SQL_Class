-- Exemplo para SQL Server/MySQL/PostgreSQL. Ajuste o tipo de dado se necessário.
CREATE TABLE Usuarios (
    ID INT PRIMARY KEY IDENTITY(1,1), -- AUTO_INCREMENT para MySQL/PostgreSQL
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL
);
-- TESTE 1: Inserção de Usuário Válido
INSERT INTO Usuarios (Nome, Email) VALUES ('Alice Silva', 'alice.silva@example.com');
SELECT * FROM Usuarios WHERE Email = 'alice.silva@example.com';
-- Espera-se que 1 linha seja inserida com sucesso.

-- TESTE 2: Inserção de Usuário com E-mail Duplicado (DEVE FALHAR)
BEGIN TRY
    INSERT INTO Usuarios (Nome, Email) VALUES ('Bruno Costa', 'alice.silva@example.com');
    PRINT 'ERRO: Inserção de e-mail duplicado permitida!';
END TRY
BEGIN CATCH
    PRINT 'SUCESSO: Inserção de e-mail duplicado bloqueada. Mensagem de erro: ' + ERROR_MESSAGE();
END CATCH;

-- Limpeza (para garantir que o teste seja idempotente se rodado várias vezes)
DELETE FROM Usuarios WHERE Email = 'alice.silva@example.com';
DELETE FROM Usuarios WHERE Email = 'teste.duplicado@example.com'; -- Se houver tentativas anteriores

-- TESTE 3: Inserção de Usuário sem Nome (DEVE FALHAR)
-- Este teste espera que o comando abaixo retorne um erro de violação de NOT NULL constraint.
BEGIN TRY
    INSERT INTO Usuarios (Email) VALUES ('sem_nome@example.com');
    PRINT 'ERRO: Inserção de usuário sem nome permitida!';
END TRY
BEGIN CATCH
    PRINT 'SUCESSO: Inserção de usuário sem nome bloqueada. Mensagem de erro: ' + ERROR_MESSAGE();
END CATCH;

-- Limpeza
DELETE FROM Usuarios WHERE Email = 'sem_nome@example.com';