# ✅ Checkpoint – Projeto de Business Intelligence e ETL de Vendas

Este documento apresenta a entrega do projeto conforme o **Escopo da Entrega** definido em sala de aula. O trabalho foi desenvolvido a partir do modelo de pedidos utilizado nas atividades, seguindo as etapas de modelagem, ETL e análise em dashboard.

- Felipe Silva Maciel - RM555307
- Eduardo Henrique Strapazzon Nagado - RM558158

---

## 🚀 Como Executar

Para recriar e popular o ambiente do Data Warehouse, execute os scripts SQL na seguinte ordem:

1. **`1_CRIACAO_AMBIENTE.sql`** → Apaga qualquer estrutura antiga e cria as tabelas de Dimensão, Fato e as `SEQUENCEs` necessárias.  
2. **`2_PACKAGE_ETL.sql`** → Compila o `PACKAGE SPEC` e o `PACKAGE BODY` com toda a lógica de ETL.  
3. **`3_TRIGGER EXECUCAO.sql`** → Cria a `TRIGGER` de auditoria.PRC_CARGA_GERAL_ETL`.  
4. **`4_EXECUCAO_ETL.sql`** → Executa o processo de carga completo chamando a procedure `PKG_ETL_VENDAS.PRC_CARGA_GERAL_ETL`. 
---

## 📌 Desenvolvimento do Modelo Estrela

Foi realizada uma pesquisa sobre o conceito de **Star Schema** e, em seguida, elaborado um **modelo estrela** para análise de vendas.  
O modelo contém:

- **Tabela Fato:** `FATO_VENDAS`  
- **5 Tabelas Dimensão:** `DIM_CLIENTE`, `DIM_VENDEDOR`, `DIM_PRODUTO`, `DIM_TEMPO`, `DIM_LOCALIDADE`  

Esse modelo foi estruturado para otimizar consultas analíticas, permitindo segmentações por cliente, vendedor, produto, tempo e localidade.

 `prints/creates.png`
---

## 📌 Criação de Procedures para Dimensões

Foi desenvolvida uma **procedure específica para cada dimensão**, centralizadas em package (`PKG_ETL_VENDAS`).  
As procedures incluem:

- **Validação de dados** (checagem de integridade e consistência).  
- **Tratamento de exceções** (controle de erros durante o processo de carga).  
- **Transformações** (padronização de formatos, limpeza de nulos, ajustes de dados).  

`prints/procedure.png`

---

## 📌 Carregamento de Dados

Com base no **modelo de pedidos** fornecido em sala, os dados foram carregados na tabela fato e nas dimensões do modelo estrela.  

- Arquivos SQL:  
  - `2_PACKAGE_ETL.sql` → Procedures de carga  
  - `3_TRIGGER EXECUCAO.sql` → Execução e testes de carga  

`prints/final_result.png`

---

## 📌 Empacotamento em Packages

Todas as procedures e funções foram consolidadas em um único **package PL/SQL**, facilitando a execução e manutenção do processo ETL.  

- Arquivo: `2_PACKAGE_ETL.sql`

---

## 📌 Execução das Procedures

As procedures foram executadas com sucesso, populando as dimensões e a tabela fato.  
Foi criado um script de execução (`3_TRIGGER EXECUCAO`) para garantir a reprodutibilidade.  

`prints/final_result.png`

---

## 📌 Trigger de Auditoria

Uma **trigger** foi desenvolvida para auditar as operações de inserção nas dimensões, garantindo rastreabilidade.  

- Arquivo: `3_TRIGGER EXECUCAO.sql`  
- `prints/trigger.png`

---

## 📌 Desenvolvimento de Dashboard

Foi desenvolvido um **dashboard no Power BI (`cp4_v1.pbix`)**, conectado ao Data Warehouse, para responder às seguintes perguntas de negócio:

- Qual é o volume de vendas segmentado por **estado, ano, mês, vendedor e cliente**?  
- Qual foi o **produto mais rentável**?  
- Qual é o **perfil de consumo dos clientes**?  

---

## 📌 Documentação de Dados

### 🔹 Tabela de Fatos: `FATO_VENDAS`

**Descrição:** Tabela central que armazena as métricas quantitativas de cada item de um pedido de venda.

| Coluna              | Tipo de Dado     | Chave | Descrição |
|---------------------|-----------------|-------|-----------|
| **SK_CLIENTE**      | `NUMBER(10)`    | PK/FK | Chave estrangeira para a `DIM_CLIENTE`. |
| **SK_VENDEDOR**     | `NUMBER(10)`    | PK/FK | Chave estrangeira para a `DIM_VENDEDOR`. |
| **SK_PRODUTO**      | `NUMBER(10)`    | PK/FK | Chave estrangeira para a `DIM_PRODUTO`. |
| **SK_TEMPO**        | `NUMBER(10)`    | PK/FK | Chave estrangeira para a `DIM_TEMPO`. |
| **SK_LOCALIDADE**   | `NUMBER(10)`    | PK/FK | Chave estrangeira para a `DIM_LOCALIDADE`. |
| **COD_PEDIDO**      | `NUMBER(10)`    | PK    | Código original do pedido. Parte da PK composta. |
| **QUANTIDADE_VENDIDA** | `NUMBER(10)` | Métrica | Quantidade de itens vendidos no pedido. |
| **VALOR_UNITARIO**  | `NUMBER(12,2)`  | Métrica | Preço unitário do produto na venda. |
| **VALOR_DESCONTO**  | `NUMBER(12,2)`  | Métrica | Valor do desconto aplicado ao item. |
| **VALOR_TOTAL_ITEM** | `NUMBER(12,2)` | Métrica | Valor total calculado (Qtd \* Vlr Unit - Desconto). |

---

### 🔹 Tabelas de Dimensão

#### 1. DIM_CLIENTE 👤

**Descrição:** Armazena os atributos descritivos dos clientes.

| Coluna              | Tipo de Dado     | Chave | Descrição |
|---------------------|-----------------|-------|-----------|
| **SK_CLIENTE**      | `NUMBER(10)`    | PK    | Chave substituta (Surrogate Key) única para o cliente. |
| **COD_CLIENTE_ORIGEM** | `NUMBER(10)` |       | Chave original do cliente no sistema transacional. |
| **NOME_CLIENTE**    | `VARCHAR2(50)`  |       | Nome do cliente. |
| **TIPO_PESSOA**     | `CHAR(1)`       |       | Tipo de pessoa (F - Física, J - Jurídica). |
| **CPF_CNPJ**        | `VARCHAR2(20)`  |       | CPF ou CNPJ do cliente. |

---

#### 2. DIM_VENDEDOR 💼

**Descrição:** Armazena os atributos dos vendedores.

| Coluna              | Tipo de Dado     | Chave | Descrição |
|---------------------|-----------------|-------|-----------|
| **SK_VENDEDOR**     | `NUMBER(10)`    | PK    | Chave substituta (Surrogate Key) única para o vendedor. |
| **COD_VENDEDOR_ORIGEM** | `NUMBER(4)` |       | Chave original do vendedor no sistema transacional. |
| **NOME_VENDEDOR**   | `VARCHAR2(50)`  |       | Nome do vendedor. |

---

#### 3. DIM_PRODUTO 📦

**Descrição:** Armazena os atributos dos produtos.

| Coluna              | Tipo de Dado     | Chave | Descrição |
|---------------------|-----------------|-------|-----------|
| **SK_PRODUTO**      | `NUMBER(10)`    | PK    | Chave substituta (Surrogate Key) única para o produto. |
| **COD_PRODUTO_ORIGEM** | `NUMBER(10)` |       | Chave original do produto no sistema transacional. |
| **NOME_PRODUTO**    | `VARCHAR2(50)`  |       | Nome do produto. |
| **COD_BARRA**       | `VARCHAR2(20)`  |       | Código de barras do produto. |

---

#### 4. DIM_TEMPO 📅

**Descrição:** Dimensão de tempo com granularidade diária.

| Coluna              | Tipo de Dado     | Chave | Descrição |
|---------------------|-----------------|-------|-----------|
| **SK_TEMPO**        | `NUMBER(10)`    | PK    | Chave substituta (Surrogate Key) única para o dia. |
| **DATA_COMPLETA**   | `DATE`          |       | Data completa (ex: 02/09/2025). |
| **DIA**             | `NUMBER(2)`     |       | Dia do mês (1-31). |
| **MES**             | `NUMBER(2)`     |       | Mês do ano (1-12). |
| **ANO**             | `NUMBER(4)`     |       | Ano. |
| **NOME_MES**        | `VARCHAR2(20)`  |       | Nome do mês por extenso (ex: Setembro). |
| **TRIMESTRE**       | `CHAR(2)`       |       | Trimestre do ano (Q1, Q2, Q3, Q4). |
| **SEMESTRE**        | `CHAR(2)`       |       | Semestre do ano (S1, S2). |

---

#### 5. DIM_LOCALIDADE 🌍

**Descrição:** Dimensão geográfica com os dados de localização das vendas.

| Coluna              | Tipo de Dado     | Chave | Descrição |
|---------------------|-----------------|-------|-----------|
| **SK_LOCALIDADE**   | `NUMBER(10)`    | PK    | Chave substituta (Surrogate Key) única para a localidade. |
| **COD_CIDADE_ORIGEM** | `NUMBER(6)`   |       | Chave original da cidade no sistema transacional. |
| **CIDADE**          | `VARCHAR2(30)`  |       | Nome da cidade. |
| **ESTADO**          | `VARCHAR2(50)`  |       | Nome do estado. |
| **PAIS**            | `VARCHAR2(50)`  |       | Nome do país. |


---

