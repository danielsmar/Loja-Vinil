

/*
__________________________________________________________
Descrição: PSET 00 - Projeto Loja de Vinil                        				  
Grupo: Daniel Valadares Marculano
       Guilherme Araujo Lopes 
       Pedro Lima Carari
       Joao Vitor Antunes            				                  
Orientador    : prof. Abrantes Araújo S. Filho.                                          
SGBD          : PostgresSQL								                              
___________________________________________________________
*/



BEGIN;
-- Criação do usuário para administrar o BD.
CREATE USER administrador WITH PASSWORD '123456' CREATEDB;

COMMIT;


-- Criação do Banco de dados

CREATE DATABASE loja_vinil
    WITH 
    OWNER = administrador
    TEMPLATE = template0
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    CONNECTION LIMIT = -1;

--Conectando ao banco de dados
\c loja_vinil administrador;

DROP SCHEMA IF EXISTS filial CASCADE;

--Criação do schema e autorização para o usuário criado anteriormente.
CREATE SCHEMA filial  AUTHORIZATION administrador;

--Tornando o Schema como padrão.
SET SEARCH_PATH TO filial, "\$user", public;
select current_schema();



-- Criação das tabelas.


CREATE TABLE filial.Funcionario (
                CPF_funcionario CHAR(11) NOT NULL,
                Nome_Completo VARCHAR(60) NOT NULL,
                Data_nascimento DATE NOT NULL,
                salario NUMERIC(10,2),
                RG CHAR(7) NOT NULL,
                sexo CHAR(1) NOT NULL,
                telefone CHAR(14) NOT NULL,
                email VARCHAR(30) NOT NULL,
                CPF_supervisor CHAR(11),
                CONSTRAINT funcionario_pk PRIMARY KEY (CPF_funcionario)
);
COMMENT ON TABLE filial.Funcionario IS 'Tabela Funcionário';
COMMENT ON COLUMN filial.Funcionario.CPF_funcionario IS 'CPF funcionário';
COMMENT ON COLUMN filial.Funcionario.Nome_Completo IS 'Nome completo do funcionário';
COMMENT ON COLUMN filial.Funcionario.Data_nascimento IS 'Data de nascimento do funcionário';
COMMENT ON COLUMN filial.Funcionario.RG IS 'RG do funcionário';
COMMENT ON COLUMN filial.Funcionario.sexo IS 'Sexo do funcionário';
COMMENT ON COLUMN filial.Funcionario.telefone IS 'Telefone do funcionário';
COMMENT ON COLUMN filial.Funcionario.email IS 'Email do funcionário';
COMMENT ON COLUMN filial.Funcionario.CPF_supervisor IS 'CPF do supervisor';


CREATE TABLE filial.Fornecedor (
                idFornecedor INTEGER NOT NULL,
                Nome VARCHAR(60) NOT NULL,
                CNPJ CHAR(14) NOT NULL,
                Razao_Social VARCHAR(60) NOT NULL,
                telefone CHAR(14) NOT NULL,
                email VARCHAR(30) NOT NULL,
                CPF_funcionario CHAR(11) NOT NULL,
                CONSTRAINT fornecedor_pk PRIMARY KEY (idFornecedor)
);
COMMENT ON TABLE filial.Fornecedor IS 'Tabela Fornecedor';
COMMENT ON COLUMN filial.Fornecedor.idFornecedor IS 'Código de identificação do Fornecedor';
COMMENT ON COLUMN filial.Fornecedor.Nome IS 'Nome completo do fornecedor';
COMMENT ON COLUMN filial.Fornecedor.CNPJ IS 'Cnpj do Fornecedor';
COMMENT ON COLUMN filial.Fornecedor.Razao_Social IS 'Razao Social do Fornecedor';
COMMENT ON COLUMN filial.Fornecedor.telefone IS 'Telefone do funcionário';
COMMENT ON COLUMN filial.Fornecedor.email IS 'Email do funcionário';
COMMENT ON COLUMN filial.Fornecedor.CPF_funcionario IS 'CPF funcionário';


CREATE TABLE filial.Produto (
                IdProduto INTEGER NOT NULL,
                idFornecedor INTEGER NOT NULL,
                Produto VARCHAR(150) NOT NULL,
                codigo_produto INTEGER NOT NULL,
                tipo_produto VARCHAR(100) NOT NULL,
                preco NUMERIC(10,2) NOT NULL,
                Lote VARCHAR(10) NOT NULL,
                Data_fabricacao DATE NOT NULL,
                quantidade INTEGER NOT NULL,
                Descricao VARCHAR(255) NOT NULL,
                data_entrada DATE NOT NULL,
                CONSTRAINT produto_pk PRIMARY KEY (IdProduto)
);
COMMENT ON TABLE filial.Produto IS 'Tabela Produto';
COMMENT ON COLUMN filial.Produto.IdProduto IS 'Código de identificação do produto.';
COMMENT ON COLUMN filial.Produto.idFornecedor IS 'Código de identificação do Fornecedor';
COMMENT ON COLUMN filial.Produto.Produto IS 'Nome do produto em estoque';
COMMENT ON COLUMN filial.Produto.codigo_produto IS 'Código de identificação do produto
';
COMMENT ON COLUMN filial.Produto.tipo_produto IS 'Tipo do Produto';
COMMENT ON COLUMN filial.Produto.preco IS 'Preço dos Produtos';
COMMENT ON COLUMN filial.Produto.Lote IS 'Lote do Produto';
COMMENT ON COLUMN filial.Produto.Data_fabricacao IS 'Data da fabricação do produto';
COMMENT ON COLUMN filial.Produto.quantidade IS 'Quantidade em estoque';
COMMENT ON COLUMN filial.Produto.Descricao IS 'Descrição do Pedido
';
COMMENT ON COLUMN filial.Produto.data_entrada IS 'Data do recebimento';


CREATE TABLE filial.Endereco_fornecedor (
                idFornecedor INTEGER NOT NULL,
                Cidade VARCHAR(15) NOT NULL,
                Estado VARCHAR(2) NOT NULL,
                Bairro VARCHAR(15) NOT NULL,
                CEP CHAR(8) NOT NULL,
                Complemento VARCHAR(150),
                CONSTRAINT endereco_fornecedor_pk PRIMARY KEY (idFornecedor)
);
COMMENT ON TABLE filial.Endereco_fornecedor IS 'Endereço do fornecedor';
COMMENT ON COLUMN filial.Endereco_fornecedor.idFornecedor IS 'Código de identificação do Fornecedor';
COMMENT ON COLUMN filial.Endereco_fornecedor.Cidade IS 'Nome da Cidade';
COMMENT ON COLUMN filial.Endereco_fornecedor.Estado IS 'Estado';
COMMENT ON COLUMN filial.Endereco_fornecedor.Bairro IS 'Nome do Bairro';
COMMENT ON COLUMN filial.Endereco_fornecedor.CEP IS 'CEP';
COMMENT ON COLUMN filial.Endereco_fornecedor.Complemento IS 'Complemento';


CREATE TABLE filial.Clientes (
                CPF_cliente CHAR(11) NOT NULL,
                Nome_Completo VARCHAR(60) NOT NULL,
                telefone CHAR(14) NOT NULL,
                sexo CHAR(1) NOT NULL,
                RG CHAR(12) NOT NULL,
                email VARCHAR(30) NOT NULL,
                CPF_funcionario CHAR(11) NOT NULL,
                CONSTRAINT clientes_pk PRIMARY KEY (CPF_cliente)
);
COMMENT ON TABLE filial.Clientes IS 'Tabela Clientes';
COMMENT ON COLUMN filial.Clientes.CPF_cliente IS 'CPF Clientes';
COMMENT ON COLUMN filial.Clientes.Nome_Completo IS 'Nome completo do Cliente';
COMMENT ON COLUMN filial.Clientes.telefone IS 'Telefone do cliente';
COMMENT ON COLUMN filial.Clientes.sexo IS 'Sexo do cliente';
COMMENT ON COLUMN filial.Clientes.RG IS 'RG do cliente (1.111.111-RR)';
COMMENT ON COLUMN filial.Clientes.email IS 'Email do cliente';
COMMENT ON COLUMN filial.Clientes.CPF_funcionario IS 'CPF funcionário';


CREATE TABLE filial.Pedido (
                idPedido INTEGER NOT NULL,
                CPF_funcionario CHAR(11) NOT NULL,
                CPF_cliente CHAR(11) NOT NULL,
                data_pedido DATE NOT NULL,
                CONSTRAINT pedido_pk PRIMARY KEY (idPedido)
);
COMMENT ON TABLE filial.Pedido IS 'Tabela Pedido';
COMMENT ON COLUMN filial.Pedido.idPedido IS 'Código de identificação do pedido';
COMMENT ON COLUMN filial.Pedido.CPF_funcionario IS 'CPF funcionário';
COMMENT ON COLUMN filial.Pedido.CPF_cliente IS 'CPF Clientes';
COMMENT ON COLUMN filial.Pedido.data_pedido IS 'Data da Compra';


CREATE TABLE filial.itens_pedido (
                IdItens_pedido INTEGER NOT NULL,
                IdProduto INTEGER NOT NULL,
                idPedido INTEGER NOT NULL,
                Quantidade INTEGER NOT NULL,
                data_saida DATE NOT NULL,
                CONSTRAINT itens_pedido_pk PRIMARY KEY (IdItens_pedido)
);
COMMENT ON COLUMN filial.itens_pedido.IdProduto IS 'Código de identificação do estoque.';
COMMENT ON COLUMN filial.itens_pedido.idPedido IS 'Código de identificação do pedido';
COMMENT ON COLUMN filial.itens_pedido.Quantidade IS 'Quantidade de itens do Pedido';
COMMENT ON COLUMN filial.itens_pedido.data_saida IS 'Data da saida do estoque';


CREATE TABLE filial.Endereco__cliente (
                CPF_cliente CHAR(11) NOT NULL,
                Cidade VARCHAR(15) NOT NULL,
                Estado VARCHAR(2) NOT NULL,
                Bairro VARCHAR(15) NOT NULL,
                CEP CHAR(8) NOT NULL,
                Complemento VARCHAR(150),
                CONSTRAINT endereco_cliente_pk PRIMARY KEY (CPF_cliente)
);
COMMENT ON TABLE filial.Endereco__cliente IS 'Endereço do Cliente';
COMMENT ON COLUMN filial.Endereco__cliente.CPF_cliente IS 'CPF funcionário';
COMMENT ON COLUMN filial.Endereco__cliente.Cidade IS 'Nome da Cidade';
COMMENT ON COLUMN filial.Endereco__cliente.Estado IS 'Estado';
COMMENT ON COLUMN filial.Endereco__cliente.Bairro IS 'Nome do Bairro';
COMMENT ON COLUMN filial.Endereco__cliente.CEP IS 'CEP';
COMMENT ON COLUMN filial.Endereco__cliente.Complemento IS 'Complemento';


CREATE TABLE filial.Endereco_funcionario (
                CPF_funcionario CHAR(11) NOT NULL,
                Cidade VARCHAR(15) NOT NULL,
                Estado VARCHAR(2) NOT NULL,
                Bairro VARCHAR(15) NOT NULL,
                CEP CHAR(8) NOT NULL,
                Complemento VARCHAR(150),
                CONSTRAINT endereco_funcionario_pk PRIMARY KEY (CPF_funcionario)
);
COMMENT ON TABLE filial.Endereco_funcionario IS 'Endereço do Funcionario';
COMMENT ON COLUMN filial.Endereco_funcionario.CPF_funcionario IS 'CPF funcionário';
COMMENT ON COLUMN filial.Endereco_funcionario.Cidade IS 'Nome da Cidade';
COMMENT ON COLUMN filial.Endereco_funcionario.Estado IS 'Estado';
COMMENT ON COLUMN filial.Endereco_funcionario.Bairro IS 'Nome do Bairro';
COMMENT ON COLUMN filial.Endereco_funcionario.CEP IS 'CEP';
COMMENT ON COLUMN filial.Endereco_funcionario.Complemento IS 'Complemento';


ALTER TABLE filial.Endereco_funcionario ADD CONSTRAINT funcionario_endere_o__funcionario_fk
FOREIGN KEY (CPF_funcionario)
REFERENCES filial.Funcionario (CPF_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE filial.Funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (CPF_supervisor)
REFERENCES filial.Funcionario (CPF_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE filial.Clientes ADD CONSTRAINT funcionario_clientes_fk
FOREIGN KEY (CPF_funcionario)
REFERENCES filial.Funcionario (CPF_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE filial.Fornecedor ADD CONSTRAINT funcionario_fornecedor_fk
FOREIGN KEY (CPF_funcionario)
REFERENCES filial.Funcionario (CPF_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE filial.Pedido ADD CONSTRAINT funcionario_compra_fk
FOREIGN KEY (CPF_funcionario)
REFERENCES filial.Funcionario (CPF_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE filial.Endereco_fornecedor ADD CONSTRAINT fornecedor_endere_o__fornecedor_fk
FOREIGN KEY (idFornecedor)
REFERENCES filial.Fornecedor (idFornecedor)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE filial.Produto ADD CONSTRAINT fornecedor_produto_fk
FOREIGN KEY (idFornecedor)
REFERENCES filial.Fornecedor (idFornecedor)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE filial.itens_pedido ADD CONSTRAINT itens_compra_fk
FOREIGN KEY (IdProduto)
REFERENCES filial.Produto (IdProduto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE filial.Endereco__cliente ADD CONSTRAINT clientes_endereco__cliente_fk
FOREIGN KEY (CPF_cliente)
REFERENCES filial.Clientes (CPF_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE filial.Pedido ADD CONSTRAINT clientes_compra_fk
FOREIGN KEY (CPF_cliente)
REFERENCES filial.Clientes (CPF_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE filial.itens_pedido ADD CONSTRAINT compra_itens_compra_fk
FOREIGN KEY (idPedido)
REFERENCES filial.Pedido (idPedido)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIAÇÃO DO DADOS

INSERT INTO filial.funcionario
(cpf_funcionario, nome_completo, data_nascimento, salario, rg, sexo, telefone, email, cpf_supervisor)
values
('77084836039', 'António Pinheiro Loio', '1990/02/15', 15000, '2144455', 'M', '(88)99609-7617', 'António.Pinheiro@gmail.com', NULL),
('18154684080', 'Destiny Gameiro Salgueiro', '1991/05/13', 1000, '2674235', 'F', '(28)99909-1217', 'Destiny.Gameiro@gmail.com','77084836039' ),
('78657880024', 'Isis Alves Bensaúde', '2000/12/20', 1500, '2234675', 'F', '(11)98944-1618', 'Isis.Alves@gmail.com','77084836039' ),
('71232259020', 'Denis Lalanda Sítima', '1995/08/10', 3500, '1046759', 'M', '(17)92244-7890', 'Denis.Lalanda@gmail.com','77084836039' );

INSERT INTO filial.endereco_funcionario
(cpf_funcionario, cidade, estado, bairro, cep, complemento)
values
('77084836039', 'Vila Velha', 'ES', 'Glória', '29122125', 'Casa 2 Andar'),
('18154684080', 'Salvador', 'BA', 'caldas de sipó', '19124122', 'Casa Cansada'),
('78657880024', 'Minas Gerais', 'MG', 'Jiminos', '12312312', 'Pao de Queijo'),
('71232259020', 'São Paulo', 'SP', 'Calco', '12345678', 'Perto de Guarulhos');

INSERT INTO filial.fornecedor(idfornecedor, nome, cnpj, razao_social, telefone, email, cpf_funcionario) 
values
(1, 'Renato de Souza Lima', '71459730000101', 'Carneiro Distribuição de Aparelhos de Som', '(27)99915-8963', 'carneiro.discos@gmail.com', '18154684080'),
(2, 'Daniel Bastos Gomes', '08345269000111', 'Daniel Distribuição de CDs e DVDs', '(27)99929-2953', 'daniel.dvd@gmail.com', '78657880024'),
(3, 'Felipe Galvão Antunes', '76298085000106', 'Galvão Distribuição de CDs e DVDs', '(27)99901-2867', 'galvao.cd@gmail.com', '71232259020');

INSERT INTO filial.endereco_fornecedor(idfornecedor, cidade, estado, bairro, cep, complemento) 
values
(1, 'Petropolis', 'RJ', 'Quitandinha', '25651000', 'segundo andar'),
(2, 'Niteroi', 'RJ', 'Baldeador', '24140005', 'portão da esquerda'),
(3, 'Macae', 'RJ', 'Imbetiba', '27913280', 'portão da direita');

INSERT INTO filial.Clientes(cpf_cliente, nome_completo, telefone, sexo, rg, email, cpf_funcionario) 
VALUES
('12345678900', 'John Cena', '(31)98888-6768', 'M', '7654345', 'john@cena.pog', '18154684080'),
('09090909090', 'Belle Belinha', '(55)98846-4110', 'F', '7654345', 'belle@bela.lina', '18154684080'),
('12312312345', 'Grey Anatony', '(27)9876543210', 'F', '7654345', 'gray@hosp.sus', '78657880024'),
('54354354367', 'Edgar Mourão', '(21)93456-5605', 'M', '7654345', 'ed@gar.edu', '78657880024'),
('12345676543', 'Cristina Ina', '(46)92345-1543', 'f', '7654345', 'cris@tal.com', '71232259020');

INSERT INTO filial.endereco__cliente(cpf_cliente, Cidade, Estado, Bairro, CEP, Complemento) VALUES
('12345678900', 'Los Angels', 'CL', 'Belair', '09876543', 'Arroz'),
('09090909090', 'São Paulo', 'SP', 'Amarelinha', '43234554', 'Feijão'),
('12312312345', 'Santa Catarina', 'SS', 'Belair', '09876543', 'Batata'),
('54354354367', 'Ibatuba', 'MG', 'Prima', '09876543', 'Macarrão'),
('12345676543', 'Caraje', 'RJ', 'file', '09876543', 'Farofa');

INSERT INTO filial.produto
(idproduto, idfornecedor, produto, codigo_produto, tipo_produto, preco, lote, data_fabricacao, quantidade, descricao, data_entrada)
VALUES(10, 1, 'Vinil Metallica - Live Reading Festival 1997', 001, 'Vinil', 227.00, 15, '2020/02/12', 52, 'Disco_vinil_rock', '2022/02/28'),
    (20, 3, 'Cd Jackson 5 - Icon Grandes Sucessos', 002, 'CD', 27.49, 16, '1998/06/17', 256, 'cd_pop', '2020/05/02'),
    (30, 2, 'Vitrola Chrome Brown com Usb e Bluetooth, Bivolt', 003, 'Vitrola', 450.90, 16, '2018/09/21', 345, 'Áudio', '2020/05/02');



INSERT INTO filial.pedido
(idpedido, cpf_funcionario, cpf_cliente, data_pedido)
VALUES(3, '77084836039', '12345678900', '2022/01//09'),
    (2, '78657880024', '12312312345', '2022/04/30'),
    (1, '71232259020', '09090909090', '2021/11/23'),
    (5, '77084836039', '54354354367', '2021/05/30'),
    (6, '71232259020', '12345676543', '2021/10/12');
   
INSERT INTO filial.itens_pedido
(iditens_pedido, idproduto, idpedido, quantidade, data_saida) 
values
(1, 10, 1, 25, '2022/05/24'),
(2, 20, 2, 12, '2022/02/07'),
(3, 30, 3, 8, '2022/03/12');
