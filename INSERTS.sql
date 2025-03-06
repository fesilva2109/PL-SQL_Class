
INSERT INTO PAIS (ID_PAIS, NOME_PAIS) 
VALUES 
(1, 'Brasil'),
(2, 'Argentina'),
(3, 'Chile'),
(4, 'Espanha'),
(5, 'Fran�a');

COMMIT;

INSERT INTO ESTADO (ID_ESTADO, NOME_ESTADO, ID_PAIS) 
VALUES 
(1, 'S�o Paulo', 1),
(2, 'Buenos Aires', 2),
(3, 'Santiago', 3),
(4, 'Madrid', 4),
(5, 'Paris', 5);

COMMIT;

INSERT INTO CIDADE (ID_CIDADE, NOME_CIDADE, ID_ESTADO) 
VALUES 
(1, 'S�o Paulo', 1),
(2, 'La Plata', 2),
(3, 'Valpara�so', 3),
(4, 'Barcelona', 4),
(5, 'Lyon', 5);

COMMIT;
  


INSERT INTO BAIRRO (ID_BAIRRO, NOME_BAIRRO, ID_CIDADE) 
VALUES 
(1, 'Centro', 1),
(2, 'Palermo', 2),
(3, 'Re�aca', 3),
(4, 'Eixample', 4),
(5, 'Presqu��le', 5);

COMMIT;

INSERT INTO ENDERECO_CLIENTE (ID_ENDERECO, CEP, LOGRADOURO, NUMERO, REFERENCIA, ID_BAIRRO) 
VALUES 
(1, 12345678, 'Rua dos Tr�s Irm�os', 45, 'Pr�ximo ao mercado', 1),
(2, 23456789, 'Avenida Central', 100, 'Em frente � pra�a', 2),
(3, 34567890, 'Rua dos Navegantes', 200, 'Perto da praia', 3),
(4, 45678901, 'Carrer de la Pau', 150, 'Ao lado do museu', 4),
(5, 56789012, 'Rue de la Libert�', 250, 'Perto da esta��o de metr�', 5);

COMMIT;

