

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

--Criação do schema e autorização para o usuário criado anteriormente.
CREATE SCHEMA filial  AUTHORIZATION administrador;

--Tornando o Schema como padrão.
SET SEARCH_PATH TO filial, "\$user", public;
select current_schema();



-- Criação das tabelas.



CREATE TABLE filial.Gerente (
                idGerente INTEGER NOT NULL,
                CPF CHAR(11) NOT NULL,
                Nome_Completo VARCHAR(60) NOT NULL,
                telefone CHAR(14) NOT NULL,
                Data_nascimento DATE NOT NULL,
                sexo CHAR(1) NOT NULL,
                RG CHAR(12) NOT NULL,
                email VARCHAR(30) NOT NULL,
                CONSTRAINT gerente_pk PRIMARY KEY (idGerente)
);
COMMENT ON TABLE filial.Gerente IS 'Tabela Gerente';
COMMENT ON COLUMN filial.Gerente.idGerente IS 'Código de identificação do gerente.';
COMMENT ON COLUMN filial.Gerente.CPF IS 'CPF funcionário';
COMMENT ON COLUMN filial.Gerente.Nome_Completo IS 'Nome completo do funcionário';
COMMENT ON COLUMN filial.Gerente.telefone IS 'Telefone do funcionário
';
COMMENT ON COLUMN filial.Gerente.Data_nascimento IS 'Data de nascimento do funcionário';
COMMENT ON COLUMN filial.Gerente.sexo IS 'Sexo do funcionário
';
COMMENT ON COLUMN filial.Gerente.RG IS 'RG do funcionário (1.111.111-RR)
';
COMMENT ON COLUMN filial.Gerente.email IS 'Email do funcionário';


CREATE TABLE filial.Fornecedor (
                idFornecedor INTEGER NOT NULL,
                idGerente_Cadastro INTEGER NOT NULL,
                Nome VARCHAR(60) NOT NULL,
                CNPJ CHAR(14) NOT NULL,
                Razao_Social VARCHAR(60) NOT NULL,
                telefone CHAR(14) NOT NULL,
                email VARCHAR(30) NOT NULL,
                CONSTRAINT fornecedor_pk PRIMARY KEY (idFornecedor)
);
COMMENT ON TABLE filial.Fornecedor IS 'Tabela Fornecedor';
COMMENT ON COLUMN filial.Fornecedor.idFornecedor IS 'Código de identificação do Fornecedor
';
COMMENT ON COLUMN filial.Fornecedor.idGerente_Cadastro IS 'Código de identificação do gerente que cadastrou o fornecedor.';
COMMENT ON COLUMN filial.Fornecedor.Nome IS 'Nome completo do fornecedor';
COMMENT ON COLUMN filial.Fornecedor.CNPJ IS 'Cnpj do Fornecedor';
COMMENT ON COLUMN filial.Fornecedor.Razao_Social IS 'Razao Social do Fornecedor
';
COMMENT ON COLUMN filial.Fornecedor.telefone IS 'Telefone do funcionário
';
COMMENT ON COLUMN filial.Fornecedor.email IS 'Email do funcionário';


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
COMMENT ON COLUMN filial.Endereco_fornecedor.idFornecedor IS 'Código de identificação do Fornecedor
';
COMMENT ON COLUMN filial.Endereco_fornecedor.Cidade IS 'Nome da Cidade';
COMMENT ON COLUMN filial.Endereco_fornecedor.Estado IS 'Estado ';
COMMENT ON COLUMN filial.Endereco_fornecedor.Bairro IS 'Nome do Bairro';
COMMENT ON COLUMN filial.Endereco_fornecedor.CEP IS 'CEP';
COMMENT ON COLUMN filial.Endereco_fornecedor.Complemento IS 'Complemento';


CREATE TABLE filial.Funcionario (
                idFuncionario INTEGER NOT NULL,
                id_gerente_supervisor INTEGER NOT NULL,
                Nome_Completo VARCHAR(60) NOT NULL,
                Data_nascimento DATE NOT NULL,
                RG CHAR(7) NOT NULL,
                CPF CHAR(11) NOT NULL,
                sexo CHAR(1) NOT NULL,
                telefone CHAR(14) NOT NULL,
                email VARCHAR(30) NOT NULL,
                CONSTRAINT funcionario_pk PRIMARY KEY (idFuncionario)
);
COMMENT ON TABLE filial.Funcionario IS 'Tabela Funcionário';
COMMENT ON COLUMN filial.Funcionario.idFuncionario IS 'Código de identificação do funcionário.';
COMMENT ON COLUMN filial.Funcionario.id_gerente_supervisor IS 'Código de identificação do gerente supervisor do funcionário.';
COMMENT ON COLUMN filial.Funcionario.Nome_Completo IS 'Nome completo do funcionário';
COMMENT ON COLUMN filial.Funcionario.Data_nascimento IS 'Data de nascimento do funcionário';
COMMENT ON COLUMN filial.Funcionario.RG IS 'RG do funcionário 
';
COMMENT ON COLUMN filial.Funcionario.CPF IS 'CPF funcionário';
COMMENT ON COLUMN filial.Funcionario.sexo IS 'Sexo do funcionário
';
COMMENT ON COLUMN filial.Funcionario.telefone IS 'Telefone do funcionário
';
COMMENT ON COLUMN filial.Funcionario.email IS 'Email do funcionário';


CREATE TABLE filial.Clientes (
                idCliente INTEGER NOT NULL,
                idFuncionario INTEGER NOT NULL,
                CPF CHAR(11) NOT NULL,
                Nome_Completo VARCHAR(60) NOT NULL,
                telefone CHAR(14) NOT NULL,
                sexo CHAR(1) NOT NULL,
                RG CHAR(12) NOT NULL,
                email VARCHAR(30) NOT NULL,
                CONSTRAINT clientes_pk PRIMARY KEY (idCliente)
);
COMMENT ON TABLE filial.Clientes IS 'Tabela Clientes';
COMMENT ON COLUMN filial.Clientes.idCliente IS 'Código de identificação do Cliente';
COMMENT ON COLUMN filial.Clientes.idFuncionario IS 'Código de identificação do funcionário.';
COMMENT ON COLUMN filial.Clientes.CPF IS 'CPF Clientes';
COMMENT ON COLUMN filial.Clientes.Nome_Completo IS 'Nome completo do Cliente
';
COMMENT ON COLUMN filial.Clientes.telefone IS 'Telefone do cliente
';
COMMENT ON COLUMN filial.Clientes.sexo IS 'Sexo do cliente
';
COMMENT ON COLUMN filial.Clientes.RG IS 'RG do cliente (1.111.111-RR)
';
COMMENT ON COLUMN filial.Clientes.email IS 'Email do cliente';


CREATE TABLE filial.Pedido (
                idPedido INTEGER NOT NULL,
                idFuncionario INTEGER NOT NULL,
                idCliente INTEGER NOT NULL,
                Data_compra DATE NOT NULL,
                Quantidade VARCHAR(10) NOT NULL,
                CONSTRAINT pedido_pk PRIMARY KEY (idPedido)
);
COMMENT ON TABLE filial.Pedido IS 'Tabela compra';
COMMENT ON COLUMN filial.Pedido.idPedido IS 'Código de identificação do pedido
';
COMMENT ON COLUMN filial.Pedido.idFuncionario IS 'Código de identificação do funcionário.';
COMMENT ON COLUMN filial.Pedido.idCliente IS 'Código de identificação do Cliente';
COMMENT ON COLUMN filial.Pedido.Data_compra IS 'Data da Compra';
COMMENT ON COLUMN filial.Pedido.Quantidade IS 'Quantidade comprada';


CREATE TABLE filial.Estoque (
                IdEstoque INTEGER NOT NULL,
                idFornecedor INTEGER NOT NULL,
                idPedido INTEGER NOT NULL,
                Produto VARCHAR(30) NOT NULL,
                Lote VARCHAR(10) NOT NULL,
                Data_fabricacao DATE NOT NULL,
                quantidade VARCHAR(10) NOT NULL,
                data_entrada DATE NOT NULL,
                data_saida DATE NOT NULL,
                CONSTRAINT estoque_pk PRIMARY KEY (IdEstoque)
);
COMMENT ON TABLE filial.Estoque IS 'Tabela Estoque';
COMMENT ON COLUMN filial.Estoque.IdEstoque IS 'Código de identificação do estoque.
';
COMMENT ON COLUMN filial.Estoque.idFornecedor IS 'Código de identificação do Fornecedor
';
COMMENT ON COLUMN filial.Estoque.idPedido IS 'Código de identificação da compra';
COMMENT ON COLUMN filial.Estoque.Produto IS 'Nome do produto em estoque';
COMMENT ON COLUMN filial.Estoque.Lote IS 'Lote do Produto
';
COMMENT ON COLUMN filial.Estoque.Data_fabricacao IS 'Data da fabricação do produto
';
COMMENT ON COLUMN filial.Estoque.quantidade IS 'Quantidade em estoque ';
COMMENT ON COLUMN filial.Estoque.data_entrada IS 'Data do recebimento';
COMMENT ON COLUMN filial.Estoque.data_saida IS 'Data da venda';


CREATE TABLE filial.Produtos (
                idProduto INTEGER NOT NULL,
                IdEstoque INTEGER NOT NULL,
                idPedido INTEGER NOT NULL,
                CONSTRAINT produtos_pk PRIMARY KEY (idProduto)
);
COMMENT ON TABLE filial.Produtos IS 'Tabela Produtos';
COMMENT ON COLUMN filial.Produtos.idProduto IS 'Codigo de identificação do produto';
COMMENT ON COLUMN filial.Produtos.IdEstoque IS 'Código de identificação do estoque.
';
COMMENT ON COLUMN filial.Produtos.idPedido IS 'Código de identificação do pedido
';


CREATE TABLE filial.CDs (
                idProduto INTEGER NOT NULL,
                Nome_Produto_CD VARCHAR(150) NOT NULL,
                Data_lancamento DATE NOT NULL,
                Genero VARCHAR(30) NOT NULL,
                Lote VARCHAR(10) NOT NULL,
                preco NUMERIC(10,2) NOT NULL,
                CONSTRAINT cds_pk PRIMARY KEY (idProduto)
);
COMMENT ON TABLE filial.CDs IS 'Tabela CD''s';
COMMENT ON COLUMN filial.CDs.idProduto IS 'Codigo de identificação do produto';
COMMENT ON COLUMN filial.CDs.Nome_Produto_CD IS 'Nome do CD';
COMMENT ON COLUMN filial.CDs.Data_lancamento IS 'Data do lançamento do CD';
COMMENT ON COLUMN filial.CDs.Genero IS 'Genero musical do disco.';
COMMENT ON COLUMN filial.CDs.Lote IS 'Lote do CD
';
COMMENT ON COLUMN filial.CDs.preco IS 'Preço do produto
';


CREATE TABLE filial.Vitrola (
                idProduto INTEGER NOT NULL,
                Nome_Produto_Vitrola VARCHAR(50) NOT NULL,
                Marca VARCHAR(50) NOT NULL,
                preco NUMERIC(10,2) NOT NULL,
                CONSTRAINT vitrola_pk PRIMARY KEY (idProduto)
);
COMMENT ON COLUMN filial.Vitrola.idProduto IS 'Codigo de identificação do produto';
COMMENT ON COLUMN filial.Vitrola.Nome_Produto_Vitrola IS 'Nome da Vitrola';
COMMENT ON COLUMN filial.Vitrola.Marca IS 'Marca da Vitrola';
COMMENT ON COLUMN filial.Vitrola.preco IS 'Preço do produto
';


CREATE TABLE filial.Discos (
                idProduto INTEGER NOT NULL,
                Nome_Produto_Disco VARCHAR(150) NOT NULL,
                Data_lancamento DATE NOT NULL,
                Genero VARCHAR(15) NOT NULL,
                preco NUMERIC(10,2) NOT NULL,
                CONSTRAINT discos_pk PRIMARY KEY (idProduto)
);
COMMENT ON TABLE filial.Discos IS 'Tabela Discos
';
COMMENT ON COLUMN filial.Discos.idProduto IS 'Codigo de identificação do produto';
COMMENT ON COLUMN filial.Discos.Nome_Produto_Disco IS 'Nome do Disco';
COMMENT ON COLUMN filial.Discos.Data_lancamento IS 'Data do lançamento do Disco';
COMMENT ON COLUMN filial.Discos.Genero IS 'Genero musical do disco.';
COMMENT ON COLUMN filial.Discos.preco IS 'Preço do produto
';


CREATE TABLE filial.Endereco_funcionario (
                idFuncionario INTEGER NOT NULL,
                Cidade VARCHAR(15) NOT NULL,
                Estado VARCHAR(2) NOT NULL,
                Bairro VARCHAR(15) NOT NULL,
                CEP CHAR(8) NOT NULL,
                Complemento VARCHAR(20),
                CONSTRAINT endereco_funcionario_pk PRIMARY KEY (idFuncionario)
);
COMMENT ON TABLE filial.Endereco_funcionario IS 'Endereço do Funcionario';
COMMENT ON COLUMN filial.Endereco_funcionario.idFuncionario IS 'Código de identificação do funcionário.';
COMMENT ON COLUMN filial.Endereco_funcionario.Cidade IS 'Nome da Cidade';
COMMENT ON COLUMN filial.Endereco_funcionario.Estado IS 'Estado ';
COMMENT ON COLUMN filial.Endereco_funcionario.Bairro IS 'Nome do Bairro';
COMMENT ON COLUMN filial.Endereco_funcionario.CEP IS 'CEP';
COMMENT ON COLUMN filial.Endereco_funcionario.Complemento IS 'Complemento';


ALTER TABLE filial.Funcionario ADD CONSTRAINT gerente_funcionario_fk
FOREIGN KEY (id_gerente_supervisor)
REFERENCES filial.Gerente (idGerente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE filial.Fornecedor ADD CONSTRAINT gerente_fornecedor_fk
FOREIGN KEY (idGerente_Cadastro)
REFERENCES filial.Gerente (idGerente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE filial.Endereco_fornecedor ADD CONSTRAINT fornecedor_endere_o__fornecedor_fk
FOREIGN KEY (idFornecedor)
REFERENCES filial.Fornecedor (idFornecedor)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE filial.Estoque ADD CONSTRAINT fornecedor_estoque_fk
FOREIGN KEY (idFornecedor)
REFERENCES filial.Fornecedor (idFornecedor)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE filial.Endereco_funcionario ADD CONSTRAINT funcionario_endere_o__funcionario_fk
FOREIGN KEY (idFuncionario)
REFERENCES filial.Funcionario (idFuncionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE filial.Clientes ADD CONSTRAINT funcionario_clientes_fk
FOREIGN KEY (idFuncionario)
REFERENCES filial.Funcionario (idFuncionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE filial.Pedido ADD CONSTRAINT funcionario_pedido_fk
FOREIGN KEY (idFuncionario)
REFERENCES filial.Funcionario (idFuncionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE filial.Pedido ADD CONSTRAINT clientes_compra_fk
FOREIGN KEY (idCliente)
REFERENCES filial.Clientes (idCliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE filial.Estoque ADD CONSTRAINT compra_estoque_fk
FOREIGN KEY (idPedido)
REFERENCES filial.Pedido (idPedido)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE filial.Produtos ADD CONSTRAINT pedido_produtos_fk
FOREIGN KEY (IdEstoque)
REFERENCES filial.Pedido (idPedido)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE filial.Produtos ADD CONSTRAINT estoque_produtos_fk
FOREIGN KEY (IdEstoque)
REFERENCES filial.Estoque (IdEstoque)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE filial.Discos ADD CONSTRAINT produtos_discos_fk
FOREIGN KEY (idProduto)
REFERENCES filial.Produtos (idProduto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE filial.Vitrola ADD CONSTRAINT produtos_vitrola_fk
FOREIGN KEY (idProduto)
REFERENCES filial.Produtos (idProduto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE filial.CDs ADD CONSTRAINT produtos_cd_s_fk
FOREIGN KEY (idProduto)
REFERENCES filial.Produtos (idProduto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Inserindo Dados nas tabelas


INSERT INTO filial.Gerente(
    idGerente,CPF,Nome_Completo,telefone,Data_nascimento,sexo,RG,email)
    VALUES(1,'17014501780','Daniel Valadares Marculano','27996886562','2000/02/20','M', '1123334','vinil@loja.com.br'); 

INSERT INTO filial.Fornecedor(
    idFornecedor,idGerente_Cadastro,Nome,CNPJ,Razao_Social,telefone,email) 
VALUES
(1,1,'João Carlos Cabral','34280090000133','Carneiro Distribuição de Aparelhos de Som',2899954-8742,'jãocarlos.cabral@carneiro.com'),
(2,1,'Renato Araujo Valadares','45350072000133','Renato Distribuição de CDs e DVDs',2899986-8253,'valadares@renato.com'),
(3,1,'Antetegemom de Souja da Rocha','52420064000133','Rocha Distribuição de CDs e DVDs',2899972-3105,'antetegemom@rocha.com');

INSERT INTO filial.Endereco_fornecedor(
    idFornecedor,Cidade,estado,Bairro,CEP,Complemento) 
VALUES
(1,'São Paulo','ES','Liberdade',29107053,'Em frente à Farmácia'),
(2,'Rio de Janeiro','SP','Leblon',29184564,'Em frente à Dadalto'),
(3,'Vitória','MT','Mata da Praia',29412368,'Próximo ao ponto de ônibus'); 

INSERT INTO filial.Funcionario(
    idFuncionario, id_gerente_supervisor, Nome_Completo,data_nascimento, RG, CPF, sexo, telefone, email)
 VALUES
(1, 1, 'Erlon Santo', '1999/01/01', '1234567', '12345678901', 'M', 12341234, 'Erlon@Jubileu.br'),
(2, 1, 'Paul Walker', '1937/02/27', '1231231', '11111111111', 'M', 244466666, 'paulWalker@gmail.uc'),
(3, 1, 'Lorena Valentina', '1989/11/07', '3213213', '22222222222', 'M', 2121212121, 'lolo@icloud.loud'); 

INSERT INTO filial.Clientes(
    idCliente, idFuncionario, Nome_Completo, RG, CPF, sexo, telefone, email) 
VALUES
(1, 1, 'Gary Pinto', '123456789012', '12345678901', 'M', 12341234, 'bob@marley.co'),
(2, 1, 'Nefasto Arno', '123123123123', '3213123123', 'M', 312312312, 'pomba@nerf.com'),
(3, 2, 'Mary Gene', '543211234511', '54321543211', 'F', 987987987, 'cana@bis.com'); 

INSERT INTO filial.Pedido(
    idPedido, idFuncionario,idCliente, Data_compra, Quantidade) 
VALUES(1, 2, 3,'1995/01/09', 2),
(2, 1, 2,'2003/03/12', 1 ),
(3, 3, 3,'1999/06/09', 2 ); 

INSERT INTO filial.Estoque(
    idEstoque, idFornecedor, idPedido, Produto, Lote, Data_fabricacao, quantidade, data_entrada, data_saida) 
VALUES(1, 1, 1, 'CD', 'lote_1', '2022/05/03', '50_unid', '2022/06/01', '2022/06/07'),
(2, 2, 2, 'Disco', 'lote_2', '2022/04/01', '15_unid', '2022/05/01', '2022/05/07'),
(3, 3, 3, 'toca_disco', 'lote_3', '2022/01/01', '10_unid', '2022/02/01', '2022/02/07'); 

INSERT INTO filial.Produtos(
    idProduto, IdEstoque, idPedido) 
VALUES(1, 1, 1),
      (2, 2, 2),
      (3, 2, 3); 

INSERT INTO filial.CDs(
    idProduto,Nome_Produto_CD,Data_lancamento,Genero,Lote,preco) 
VALUES(1,'Cd Pink Floyd - Dark Side Of The Moon Duplo','1973/05/27','Rock','15ASD65',39.50),
      (2,'Red Hot Chili Peppers - Californication','1999/07/13','Rock','15DFD98',42.00),
      (3,'Cd Ac/dc - Back In Black','2003/06/05','Rock','23ERD98',22.70); --ok

INSERT INTO filial.Vitrola(
    idProduto,Nome_Produto_Vitrola,marca,preco) 
VALUES(1,'Victrola Vsz-550Bt','Victrola Mini System',1338.00),
(2,'Victrola Stadio','Radio Stadio BT',1148.82),
(3,'Victrola Pulse','Pulse Perkins Turntable - SP365',366.99); 

INSERT INTO filial.Discos(
    idProduto,nome_produto_disco, Data_lancamento, Genero, preco) 
VALUES(1,'COISA NOSSA', '2018/05/03', 'Pop',199.90),
      (2,'BANIDO BANIDO BANIDO', '1986/09/10', 'Rock',359.90),
      (3,'VALE NADA VALU TUDO', '2022/12/08', 'Pop',299.90);  
      
INSERT INTO filial.Endereco_funcionario(
    idFuncionario, Cidade,estado, Bairro, CEP, complemento) 
VALUES(1, 'Vila Velha','ES', 'Alvorada', 12345678, 'Av. Carlos Gomes' ),
      (2, 'Vitoria','ES','Monte Belo', 09876543, 'Rua das Flores' ),
      (3, 'Vila Velha','ES', 'Itaparica',11223344, NULL );