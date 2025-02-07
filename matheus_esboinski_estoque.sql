-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 06-Fev-2025 às 19:52
-- Versão do servidor: 10.4.27-MariaDB
-- versão do PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `matheusesboinskiestoque`
--
DROP DATABASE IF EXISTS `matheusesboinskiestoque`;
CREATE DATABASE IF NOT EXISTS `matheusesboinskiestoque` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `matheusesboinskiestoque`;

-- --------------------------------------------------------

--
-- Estrutura da tabela `cliente`
--

CREATE TABLE `cliente` (
  `cod_cliente` int(11) NOT NULL COMMENT 'Esse campo é responsável de armazenar o código do cliente.',
  `nome_cliente` varchar(50) DEFAULT NULL COMMENT 'Esse campo é responsável de armazenar o nome do cliente.',
  `endereco` varchar(50) DEFAULT NULL COMMENT 'Esse campo é responsável de armazenar o endereço do cliente.',
  `cidade` varchar(50) DEFAULT NULL COMMENT 'Esse campo é responsável de armazenar a cidade do cliente.',
  `cep` varchar(10) DEFAULT NULL COMMENT 'Esse campo é responsável de armazenar o CEP do cliente.',
  `uf` char(2) DEFAULT NULL COMMENT 'Esse campo é responsável de armazenar a unidade federal do cliente.',
  `cnpj` varchar(30) DEFAULT NULL COMMENT 'Esse campo é responsável de armazenar o CNPJ do cliente.',
  `ie` int(10) DEFAULT NULL COMMENT 'Esse campo é responsável de armazenar a inscrição estadual do cliente.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `cliente`
--

INSERT INTO `cliente` (`cod_cliente`, `nome_cliente`, `endereco`, `cidade`, `cep`, `uf`, `cnpj`, `ie`) VALUES
(20, 'Beth', 'Av Climério n. 45', 'São Paulo', '25679300', 'SP', '3248512673268', 9280),
(110, 'Jorge', 'Rua Caiapó 13', 'Curitiba', '30078500', 'PR', '1451276498349', NULL),
(130, 'Edmar', 'Rua da Prais s/n', 'Salvador', '30079300', 'BA', '234632842349', 7121),
(157, 'Paulo', 'Tv. Moraes c/3', 'Londrina', NULL, 'PR', '328482233242', 1923),
(180, 'Livio', 'Av. Beira Mar n.1256', 'Florianópolis', '30077500', 'SC', '1273657123474', NULL),
(222, 'Lúcia', 'Rua Itabira 123 loja 09', 'Belo Horizonte', '22124391', 'MG', '2831521393488', 2985),
(234, 'José', 'Quadra 3 bl. 3 sl 1003', 'Brasilia', '22841650', 'DF', '2176357612323', 2931),
(260, 'Susana', 'Rua Lopes Mendes 12', 'Niterói', '30046500', 'RJ', '217635712329', 2530),
(290, 'Renato', 'Rua Meireles n. 123 bl.2 sl.345', 'São Paulo', '30225900', 'SP', '1327657112314', 1820),
(390, 'Sebastião', 'Rua da Igreja n. 10', 'Uberaba', '30438700', 'MG', '321765472133', 9071),
(410, 'Rodolfo', 'Largo da Lapa 27 sobrado', 'Rio de Janeiro', '30078900', 'RJ', '1283512823469', 7431),
(720, 'Ana', 'Rua 17 n.19', 'Niterói', '24358-310', 'RJ', '12113231/0001-43', 2134),
(830, 'Mauricio', 'Av Paulista 1236 sl/2345', 'São Paulo', '3012683', 'SP', '3281698574656', 9343),
(870, 'Flavio', 'Av. Pres Vargas 10', 'São Paulo', '22763931', 'SP', '2253412693879', 4631);

-- --------------------------------------------------------

--
-- Estrutura da tabela `item_de_pedido`
--

CREATE TABLE `item_de_pedido` (
  `pedido_num_pedido` int(11) NOT NULL COMMENT 'Esse campo é responsável de armazenar a chave estrangeira da tabela pedido.',
  `produto_cod_produto` int(11) NOT NULL COMMENT 'Esse campo é responsável de armazenar a chave estrangeira da tabela produto.',
  `qntd` int(11) NOT NULL COMMENT 'Esse campo é responsável de armazenar a quantidade de produtos no pedido.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `item_de_pedido`
--

INSERT INTO `item_de_pedido` (`pedido_num_pedido`, `produto_cod_produto`, `qntd`) VALUES
(91, 77, 40),
(97, 77, 20),
(101, 31, 9),
(103, 53, 37),
(104, 53, 32),
(105, 78, 10),
(108, 13, 17),
(111, 25, 10),
(111, 78, 70),
(119, 13, 6),
(119, 22, 10),
(119, 53, 43),
(119, 77, 40),
(121, 25, 10),
(121, 31, 35),
(137, 13, 8),
(138, 22, 10),
(138, 53, 18),
(138, 77, 35),
(143, 31, 20),
(148, 25, 10),
(148, 31, 7),
(148, 45, 8),
(148, 77, 3),
(148, 78, 30),
(189, 78, 45),
(203, 31, 6);

-- --------------------------------------------------------

--
-- Estrutura da tabela `pedido`
--

CREATE TABLE `pedido` (
  `num_pedido` int(11) NOT NULL COMMENT 'este campo é responsavel por  armazenar  o número do pedido',
  `prazo_entrega` int(10) DEFAULT NULL COMMENT 'este campo é responsavel por  armazenar o prazo da entrega',
  `cod_cliente` int(11) NOT NULL COMMENT 'este campo é responsavel por  armazenar o código do cliente',
  `cod_vendedor` int(11) NOT NULL COMMENT 'este campo é responsavel por  armazenar o código do vendedor ',
  `vendedor_cod_vendedor` int(11) NOT NULL,
  `cliente_cod_cliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `pedido`
--

INSERT INTO `pedido` (`num_pedido`, `prazo_entrega`, `cod_cliente`, `cod_vendedor`, `vendedor_cod_vendedor`, `cliente_cod_cliente`) VALUES
(91, 20, 260, 11, 0, 0),
(97, 20, 720, 101, 0, 0),
(98, 20, 410, 209, 0, 0),
(101, 15, 720, 101, 0, 0),
(103, 20, 260, 11, 0, 0),
(104, 30, 110, 101, 0, 0),
(105, 15, 180, 240, 0, 0),
(108, 15, 290, 310, 0, 0),
(111, 20, 260, 240, 0, 0),
(112, 20, 260, 240, 0, 0),
(119, 30, 390, 250, 0, 0),
(121, 20, 410, 209, 0, 0),
(127, 10, 410, 11, 0, 0),
(137, 20, 720, 720, 0, 0),
(138, 20, 260, 11, 0, 0),
(143, 30, 20, 111, 0, 0),
(148, 20, 720, 101, 0, 0),
(189, 15, 870, 213, 0, 0),
(203, 30, 830, 250, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `produto`
--

CREATE TABLE `produto` (
  `cod_produto` int(11) NOT NULL COMMENT 'Esse campo é responsável de armazenar o código do produto.',
  `unid_produto` varchar(10) DEFAULT NULL COMMENT 'Esse campo é responsável de armazenar a unidade de medida do produto.',
  `desc_produto` varchar(50) DEFAULT NULL COMMENT 'Esse campo é responsável de armazenar a descrição do produto.',
  `valor_unit` decimal(15,2) DEFAULT NULL COMMENT 'Esse campo é responsável de armazenar o valor unitário do produto.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `produto`
--

INSERT INTO `produto` (`cod_produto`, `unid_produto`, `desc_produto`, `valor_unit`) VALUES
(13, 'G', 'Ouro', '6.18'),
(22, 'M', 'Linho', '0.11'),
(25, 'Kg', 'Queijo', '0.97'),
(30, 'SAC', 'Açucar', '0.30'),
(31, 'Bar', 'Chocolate', '0.87'),
(45, 'M', 'Madeira', '0.25'),
(53, 'M', 'Linha', '1.80'),
(77, 'M', 'Papel', '1.05'),
(78, 'L', 'Vinho', '2.00'),
(87, 'M', 'Cano', '1.97');

-- --------------------------------------------------------

--
-- Estrutura da tabela `vendedor`
--

CREATE TABLE `vendedor` (
  `cod_vendedor` int(11) NOT NULL COMMENT 'Esse campo é responsável de armazenar o código do vendedor.',
  `nome_vendedor` varchar(50) DEFAULT NULL COMMENT 'Esse campo é responsável de armazenar o nome do vendedor.',
  `sal_fixo` decimal(15,2) DEFAULT NULL COMMENT 'Esse campo é responsável de armazenar o salário fixo do vendedor.',
  `faixa_comissao` char(2) DEFAULT NULL COMMENT 'Esse campo é responsável de armazenar a faixa de comissão do vendedor.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `vendedor`
--

INSERT INTO `vendedor` (`cod_vendedor`, `nome_vendedor`, `sal_fixo`, `faixa_comissao`) VALUES
(11, 'João', '2780.00', 'C'),
(101, 'João', '2650.32', 'C'),
(111, 'Carlos', '2490.00', 'A'),
(209, 'José', '1800.00', 'C'),
(213, 'Jonas', '2300.50', 'A'),
(240, 'Antonio', '9500.00', 'C'),
(250, 'Mauricío', '2930.00', 'B'),
(310, 'Josias', '870.00', 'B'),
(720, 'Felipe', '4600.00', 'A');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`cod_cliente`);

--
-- Índices para tabela `item_de_pedido`
--
ALTER TABLE `item_de_pedido`
  ADD PRIMARY KEY (`pedido_num_pedido`,`produto_cod_produto`),
  ADD KEY `fk_pedido_has_produto_produto1_idx` (`produto_cod_produto`),
  ADD KEY `fk_pedido_has_produto_pedido_idx` (`pedido_num_pedido`);

--
-- Índices para tabela `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`num_pedido`,`vendedor_cod_vendedor`,`cliente_cod_cliente`),
  ADD KEY `fk_pedido_vendedor1_idx` (`vendedor_cod_vendedor`),
  ADD KEY `fk_pedido_cliente1_idx` (`cliente_cod_cliente`);

--
-- Índices para tabela `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`cod_produto`);

--
-- Índices para tabela `vendedor`
--
ALTER TABLE `vendedor`
  ADD PRIMARY KEY (`cod_vendedor`);

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `item_de_pedido`
--
ALTER TABLE `item_de_pedido`
  ADD CONSTRAINT `fk_pedido_has_produto_pedido` FOREIGN KEY (`pedido_num_pedido`) REFERENCES `pedido` (`num_pedido`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pedido_has_produto_produto1` FOREIGN KEY (`produto_cod_produto`) REFERENCES `produto` (`cod_produto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `fk_pedido_cliente1` FOREIGN KEY (`cliente_cod_cliente`) REFERENCES `cliente` (`cod_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pedido_vendedor1` FOREIGN KEY (`vendedor_cod_vendedor`) REFERENCES `vendedor` (`cod_vendedor`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
