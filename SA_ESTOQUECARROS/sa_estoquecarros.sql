-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 28/02/2025 às 20:32
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `sa_estoquecarros`
--
CREATE DATABASE IF NOT EXISTS `sa_estoquecarros` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `sa_estoquecarros`;

DELIMITER $$
--
-- Procedimentos
--
DROP PROCEDURE IF EXISTS `ConsultarFornecedoresLojas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarFornecedoresLojas` ()   BEGIN
    SELECT 
        f.nome_fornecedor AS NomeFornecedor,
        f.end_fornecedor AS EnderecoFornecedor,
        f.email_fornecedor AS EmailFornecedor,
        f.frete_fornecedor AS FreteFornecedor,
        l.cod_loja AS CodigoLoja,
        l.end_loja AS EnderecoLoja,
        l.tel_loja AS TelefoneLoja,
        l.banco_loja AS BancoLoja,
        l.desconto_loja AS DescontoLoja
    FROM 
        fornecedor f
    JOIN 
        loja_de_carro l
    ON 
        f.tel_fornecedor = l.tel_loja;
END$$

DROP PROCEDURE IF EXISTS `mySp_insertEstoque`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mySp_insertEstoque` (IN `p_marca_carro` VARCHAR(45), IN `p_modelo_carro` VARCHAR(45), IN `p_quant_carros` INT, IN `p_ano_carro` YEAR, IN `p_motor_carro` VARCHAR(45))   BEGIN
    INSERT INTO estoque (marca_carro, modelo_carro, quant_carros, ano_carro, motor_carro)
    VALUES (p_marca_carro, p_modelo_carro, p_quant_carros, p_ano_carro, p_motor_carro);
END$$

DROP PROCEDURE IF EXISTS `mySP_insertFornecedor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mySP_insertFornecedor` (IN `p_cnpj` VARCHAR(18), IN `p_nome_fornecedor` VARCHAR(45), IN `p_end_fornecedor` VARCHAR(45), IN `p_email_fornecedor` VARCHAR(45), IN `p_tel_fornecedor` VARCHAR(15), IN `p_frete_fornecedor` DECIMAL(10,2))   BEGIN
    INSERT INTO fornecedor (cnpj, nome_fornecedor, end_fornecedor, email_fornecedor, tel_fornecedor, frete_fornecedor)
    VALUES (p_cnpj, p_nome_fornecedor, p_end_fornecedor, p_email_fornecedor, p_tel_fornecedor, p_frete_fornecedor);
END$$

DROP PROCEDURE IF EXISTS `mySp_joinEstoqueCarro`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mySp_joinEstoqueCarro` (IN `p_marca_carro` VARCHAR(45))   BEGIN
    SELECT e.cod_estoque, e.marca_carro, e.modelo_carro, e.quant_carros, e.ano_carro, e.motor_carro, c.chassi, c.cor_carro, c.km_carro, c.estado
    FROM estoque e
    JOIN carro c ON e.cod_estoque = c.estoque_cod_estoque
    WHERE e.marca_carro = p_marca_carro;
END$$

DROP PROCEDURE IF EXISTS `mySP_updateEstoque`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mySP_updateEstoque` (IN `p_cod_estoque` INT, IN `p_marca_carro` VARCHAR(45), IN `p_modelo_carro` VARCHAR(45), IN `p_quant_carros` INT, IN `p_ano_carro` YEAR, IN `p_motor_carro` VARCHAR(45))   BEGIN
    UPDATE estoque
    SET marca_carro = p_marca_carro,
        modelo_carro = p_modelo_carro,
        quant_carros = p_quant_carros,
        ano_carro = p_ano_carro,
        motor_carro = p_motor_carro
    WHERE cod_estoque = p_cod_estoque;
END$$

DROP PROCEDURE IF EXISTS `mySp_updateFornecedor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mySp_updateFornecedor` (IN `p_cnpj` VARCHAR(18), IN `p_nome_fornecedor` VARCHAR(45), IN `p_end_fornecedor` VARCHAR(45), IN `p_email_fornecedor` VARCHAR(45), IN `p_tel_fornecedor` VARCHAR(15), IN `p_frete_fornecedor` DECIMAL(10,2))   BEGIN
    UPDATE fornecedor
    SET nome_fornecedor = p_nome_fornecedor,
        end_fornecedor = p_end_fornecedor,
        email_fornecedor = p_email_fornecedor,
        tel_fornecedor = p_tel_fornecedor,
        frete_fornecedor = p_frete_fornecedor
    WHERE cnpj = p_cnpj;
END$$

DROP PROCEDURE IF EXISTS `SP_AtualizarFuncionario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_AtualizarFuncionario` (IN `v_cpf` VARCHAR(15), IN `v_nome` VARCHAR(45), IN `v_tel` VARCHAR(15), IN `v_salario` DECIMAL(10,2), IN `v_comissao` DECIMAL(10,2), IN `v_endereco` VARCHAR(45), IN `v_loja_cod` INT)   BEGIN UPDATE funcionario SET nome_funcionario = v_nome, tel_funcionario = v_tel, salario_funcionario = v_salario, comissao_funcionario = v_comissao, end_funcionario = v_endereco, loja_cod_loja = v_loja_cod WHERE cpf = v_cpf; END$$

DROP PROCEDURE IF EXISTS `SP_AtualizarLoja`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_AtualizarLoja` (IN `p_cod_loja` INT, IN `p_endereco` VARCHAR(45), IN `p_tel` VARCHAR(15), IN `p_banco` VARCHAR(45), IN `p_horario` TIME, IN `p_desconto` DECIMAL(5,2), IN `p_estoque_cod` INT)   BEGIN
    UPDATE loja_de_carro 
    SET 
        end_loja = p_endereco, 
        tel_loja = p_tel, 
        banco_loja = p_banco, 
        hora_loja = p_horario, 
        desconto_loja = p_desconto, 
        estoque_cod_estoque = p_estoque_cod
    WHERE cod_loja = p_cod_loja;
END$$

DROP PROCEDURE IF EXISTS `SP_GetFuncionariosLoja`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetFuncionariosLoja` ()   BEGIN
    SELECT 
        f.nome_funcionario, 
        f.cpf, 
        f.salario_funcionario, 
        f.comissao_funcionario, 
        l.end_loja, 
        l.tel_loja 
    FROM funcionario f 
    LEFT JOIN loja l ON f.loja_cod_loja = l.cod_loja;
END$$

DROP PROCEDURE IF EXISTS `SP_InserirFuncionario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_InserirFuncionario` (IN `v_cpf` VARCHAR(15), IN `v_nome` VARCHAR(45), IN `v_tel` VARCHAR(15), IN `v_salario` DECIMAL(10,2), IN `v_comissao` DECIMAL(10,2), IN `v_endereco` VARCHAR(45), IN `v_loja_cod` INT)   BEGIN INSERT INTO funcionario (cpf, nome_funcionario, tel_funcionario, salario_funcionario, comissao_funcionario, end_funcionario, loja_cod_loja) VALUES (v_cpf, v_nome, v_tel, p_salario, v_comissao, v_endereco, v_loja_cod); END$$

DROP PROCEDURE IF EXISTS `SP_InserirLoja`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_InserirLoja` (IN `v_endereco` VARCHAR(45), IN `v_tel` VARCHAR(15), IN `v_banco` VARCHAR(45), IN `v_horario` TIME, IN `v_desconto` DECIMAL(5,2), IN `v_estoque_cod` INT)   BEGIN INSERT INTO loja_de_carro (end_loja, tel_loja, banco_loja, hora_loja, desconto_loja, estoque_cod_estoque) VALUES (v_endereco, v_tel, v_banco, v_horario, v_desconto, v_estoque_cod); END$$

DROP PROCEDURE IF EXISTS `sp_insertCarro`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertCarro` (IN `v_chassi` VARCHAR(20), IN `v_cor` VARCHAR(45), IN `v_estado` VARCHAR(10), IN `v_km` INT, IN `v_estoque_cod` INT)   BEGIN
    IF BINARY v_estado IN ('Novo', 'Seminovo', 'Usado') 
       AND v_estoque_cod IS NOT NULL 
       AND v_estoque_cod > 0 THEN
       
        INSERT INTO carro (chassi, cor_carro, estado, km_carro, estoque_cod_estoque) 
        VALUES (v_chassi, v_cor, v_estado, v_km, v_estoque_cod);
    
    ELSE
        SELECT 'Erro: Todos os campos devem ser informados corretamente!' AS Msg;
    END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_insertCliente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertCliente` (IN `v_cpf` VARCHAR(15), IN `v_nome` VARCHAR(45), IN `v_email` VARCHAR(45), IN `v_tel` VARCHAR(15), IN `v_end` VARCHAR(45), IN `v_banco` VARCHAR(45), IN `v_carro_chassi` VARCHAR(20))   BEGIN
    IF v_cpf IS NOT NULL AND v_cpf != '' 
       AND v_nome IS NOT NULL AND v_nome != '' 
       AND v_email IS NOT NULL AND v_email != '' 
       AND v_tel IS NOT NULL AND v_tel != '' 
       AND v_end IS NOT NULL AND v_end != '' 
       AND v_banco IS NOT NULL AND v_banco != '' THEN

        INSERT INTO cliente (cpf, nome_cliente, email_cliente, tel_cliente, end_cliente, banco_cliente, carro_chassi) 
        VALUES (v_cpf, v_nome, v_email, v_tel, v_end, v_banco, 
                CASE WHEN v_carro_chassi = '' THEN NULL ELSE v_carro_chassi END); 
    
    END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_listaClientesCarros`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listaClientesCarros` ()   BEGIN
    SELECT 
        c.cpf AS 'CPF do Cliente',
        c.nome_cliente AS 'Nome',
        c.email_cliente AS 'E-mail',
        c.tel_cliente AS 'Telefone',
        c.end_cliente AS 'Endereço',
        c.banco_cliente AS 'Banco',
        ca.chassi AS 'Chassi do Carro',
        e.marca_carro AS 'Marca', -- Pegando a marca da tabela estoque
        ca.cor_carro AS 'Cor',
        ca.km_carro AS 'KM',
        ca.estado AS 'Estado',
        ca.estoque_cod_estoque AS 'Código do Estoque'
    FROM cliente c
    LEFT JOIN carro ca ON c.carro_chassi = ca.chassi
    LEFT JOIN estoque e ON ca.estoque_cod_estoque = e.cod_estoque;
END$$

DROP PROCEDURE IF EXISTS `sp_listarCarrosVendidos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listarCarrosVendidos` ()   BEGIN
    SELECT 
        c.chassi AS 'Chassi',
        c.cor_carro AS 'Cor',
        c.estado AS 'Estado',
        c.km_carro AS 'Quilometragem',
        CASE 
            WHEN cl.nome_cliente IS NOT NULL THEN cl.nome_cliente
            ELSE 'Disponível'
        END AS 'Dono'
    FROM carro c
    LEFT JOIN cliente cl ON c.chassi = cl.carro_chassi;
END$$

DROP PROCEDURE IF EXISTS `sp_loja_funcionario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_loja_funcionario` ()   BEGIN
    SELECT 
        l.end_loja, 
        l.tel_loja, 
        l.hora_loja, 
        l.banco_loja, 
        f.nome_funcionario, 
        f.comissao_funcionario, 
        f.salario_funcionario, 
        f.cpf 
    FROM loja l 
    JOIN funcionario f ON l.cod_loja = f.loja_cod_loja;
END$$

DROP PROCEDURE IF EXISTS `sp_updateCarro`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_updateCarro` (IN `v_chassi` VARCHAR(20), IN `v_cor` VARCHAR(45), IN `v_estado` VARCHAR(10), IN `v_km` INT, IN `v_estoque_cod` INT)   BEGIN
    IF BINARY v_estado IN ('Novo', 'Seminovo', 'Usado') 
       AND v_estoque_cod IS NOT NULL 
       AND v_estoque_cod > 0 THEN
       
        UPDATE carro 
        SET cor_carro = v_cor, 
            estado = v_estado, 
            km_carro = v_km,
            estoque_cod_estoque = v_estoque_cod 
        WHERE chassi = v_chassi;
    
    ELSE
        SELECT 'Erro: Todos os campos devem ser informados corretamente!' AS Msg;
    END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_updateCliente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_updateCliente` (IN `v_cpf` VARCHAR(15), IN `v_nome` VARCHAR(45), IN `v_email` VARCHAR(45), IN `v_tel` VARCHAR(15), IN `v_end` VARCHAR(45), IN `v_banco` VARCHAR(45), IN `v_carro_chassi` VARCHAR(20))   BEGIN
    IF v_cpf IS NOT NULL AND v_cpf != '' 
       AND v_nome IS NOT NULL AND v_nome != '' 
       AND v_email IS NOT NULL AND v_email != '' 
       AND v_tel IS NOT NULL AND v_tel != '' 
       AND v_end IS NOT NULL AND v_end != '' 
       AND v_banco IS NOT NULL AND v_banco != '' THEN

        UPDATE cliente 
        SET nome_cliente = v_nome,
            email_cliente = v_email,
            tel_cliente = v_tel,
            end_cliente = v_end,
            banco_cliente = v_banco,
            carro_chassi = CASE WHEN v_carro_chassi = '' THEN NULL ELSE v_carro_chassi END
        WHERE cpf = v_cpf;
    
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `carro`
--

DROP TABLE IF EXISTS `carro`;
CREATE TABLE `carro` (
  `chassi` varchar(20) NOT NULL COMMENT 'armazena o chassi do carro',
  `cor_carro` varchar(45) DEFAULT NULL COMMENT 'armazena a cor do carro',
  `km_carro` int(11) DEFAULT NULL COMMENT 'armazena a quilometragem do carro',
  `estado` enum('Novo','Seminovo','Usado') NOT NULL COMMENT 'armazena o estado em que o carro está (Novo, Seminovo, Usado)',
  `estoque_cod_estoque` int(11) NOT NULL COMMENT 'chave estrangeira da tabela estoque'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `carro`
--

INSERT INTO `carro` (`chassi`, `cor_carro`, `km_carro`, `estado`, `estoque_cod_estoque`) VALUES
('0HBZZZ456AB007985', 'Branco', 36000, 'Usado', 20),
('0RCZZZ890UV004537', 'Cinza', 61000, 'Usado', 30),
('0VWZZZ234GH009876', 'Azul', 39000, 'Usado', 10),
('1GAXZZ123YZ003421', 'Preto', 0, 'Novo', 19),
('1QBZZZ567ST009812', 'Vermelho', 0, 'Novo', 29),
('1TUZZZ789EF002345', 'Prata', 0, 'Novo', 9),
('2FZZZZ890WX005678', 'Cinza', 55000, 'Usado', 18),
('2PAZZZ234QR003659', 'Azul', 58000, 'Usado', 28),
('2RSZZZ123AB004567', 'Branco', 27000, 'Usado', 8),
('3EYZZZ567UV002143', 'Vermelho', 0, 'Novo', 17),
('3OIZZZ789OP007214', 'Prata', 0, 'Novo', 27),
('3PQZZZ456CD008901', 'Preto', 0, 'Novo', 7),
('4DXZZZ234ST008732', 'Azul', 47000, 'Usado', 16),
('4MNZZZ789XZ005678', 'Cinza', 51000, 'Usado', 6),
('4NHZZZ456MN004732', 'Branco', 25000, 'Usado', 26),
('5CZZZZ789QR004561', 'Prata', 0, 'Novo', 15),
('5KLZZZ234OP007654', 'Vermelho', 0, 'Novo', 5),
('5MGZZZ123KL009876', 'Preto', 0, 'Novo', 25),
('6BYZZZ456OP009342', 'Branco', 28000, 'Usado', 14),
('6HJZZZ567GH002341', 'Azul', 32000, 'Usado', 4),
('6LFZZZ890IJ003658', 'Cinza', 43000, 'Usado', 24),
('7AXZZZ123MN007654', 'Preto', 0, 'Novo', 13),
('7FGZZZ890KL009874', 'Prata', 0, 'Novo', 3),
('7KEZZZ567GH007892', 'Vermelho', 0, 'Novo', 23),
('8ADZZZ123YT003562', 'Branco', 45000, 'Usado', 2),
('8JDZZZ234EF004325', 'Azul', 49000, 'Usado', 22),
('8ZUZZZ890KL003218', 'Cinza', 62000, 'Usado', 12),
('9BWZZZ377VT004251', 'Preto', 0, 'Novo', 1),
('9ICZZZ789CD009112', 'Prata', 0, 'Novo', 21),
('9YXZZZ567IJ005432', 'Vermelho', 0, 'Novo', 11);

-- --------------------------------------------------------

--
-- Estrutura para tabela `cliente`
--

DROP TABLE IF EXISTS `cliente`;
CREATE TABLE `cliente` (
  `cpf` varchar(15) NOT NULL COMMENT 'armazena o cpf do cliente',
  `nome_cliente` varchar(45) DEFAULT NULL COMMENT 'armazena o nome do cliente',
  `email_cliente` varchar(45) DEFAULT NULL COMMENT 'armazena o email do cliente',
  `tel_cliente` varchar(15) DEFAULT NULL COMMENT 'armazena o telefone do cliente',
  `end_cliente` varchar(45) DEFAULT NULL COMMENT 'armazena o endereço do cliente',
  `banco_cliente` varchar(45) DEFAULT NULL COMMENT 'armazena o banco do cliente',
  `carro_chassi` varchar(20) DEFAULT NULL COMMENT 'chave estrangeira da tabela carro'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `cliente`
--

INSERT INTO `cliente` (`cpf`, `nome_cliente`, `email_cliente`, `tel_cliente`, `end_cliente`, `banco_cliente`, `carro_chassi`) VALUES
('12345678901', 'João Silva', 'joao.silva@email.com', '(11) 98765-4321', 'Rua das Flores, 123', 'Banco do Brasil', NULL),
('12398745605', 'Mauro Castro', 'mauro.castro@email.com', '(51) 92345-6789', 'Rua Azul, 1212', 'Santander', '5KLZZZ234OP007654'),
('14725836914', 'Sandra Pires', 'sandra.pires@email.com', '(41) 96547-8932', 'Travessa do Sol, 2121', 'Bradesco', '6BYZZZ456OP009342'),
('14736985220', 'Ricardo Martins', 'ricardo.martins@email.com', '(31) 91234-5678', 'Vila Nova, 2727', 'C6 Bank', '0HBZZZ456AB007985'),
('15935785209', 'Gustavo Carvalho', 'gustavo.carvalho@email.com', '(91) 97654-3210', 'Vila Alegre, 1616', 'Original', '1TUZZZ789EF002345'),
('15975325896', 'Paulo Rocha', 'paulo.rocha@email.com', '(71) 98712-3456', 'Alameda dos Anjos, 404', 'Nubank', NULL),
('25814736904', 'Daniela Alves', 'daniela.alves@email.com', '(41) 95678-2134', 'Alameda Verde, 1111', 'Bradesco', '6HJZZZ567GH002341'),
('25836914777', 'Juliana Mendes', 'juliana.mendes@email.com', '(81) 97623-4120', 'Rua das Palmeiras, 505', 'BTG Pactual', NULL),
('25896314716', 'Adriano Gomes', 'adriano.gomes@email.com', '(61) 98723-4561', 'Avenida Estrela, 2323', 'Banco Inter', '4DXZZZ234ST008732'),
('32178965433', 'Ana Martins', 'ana.martins@email.com', '(41) 95432-1678', 'Travessa da Paz, 101', 'Bradesco', NULL),
('35715948610', 'Patrícia Melo', 'patricia.melo@email.com', '(31) 93210-6547', 'Rua das Violetas, 1717', 'C6 Bank', '0VWZZZ234GH009876'),
('36914725888', 'André Costa', 'andre.costa@email.com', '(91) 96541-2309', 'Vila Bela, 606', 'Original', NULL),
('36925814719', 'Raquel Lemos', 'raquel.lemos@email.com', '(91) 93412-7856', 'Rua Bela Vista, 2626', 'Original', '1GAXZZ123YZ003421'),
('36974185215', 'Joaquina Barros', 'joaquina.barros@email.com', '(51) 92341-7654', 'Rua Lua Nova, 2222', 'Santander', '5CZZZZ789QR004561'),
('36985214703', 'Ricardo Santos', 'ricardo.santos@email.com', '(31) 94567-8923', 'Rua dos Pinhais, 1010', 'Itaú', '7FGZZZ890KL009874'),
('45612378922', 'Carlos Oliveira', 'carlos.oliveira@email.com', '(31) 97654-3210', 'Praça das Árvores, 789', 'Itaú', NULL),
('65498732144', 'Luciana Ferreira', 'luciana.ferreira@email.com', '(61) 99876-5432', 'Avenida Paulista, 303', 'Banco Inter', NULL),
('74125896302', 'Amanda Ribeiro', 'amanda.ribeiro@email.com', '(21) 97845-2310', 'Avenida das Rosas, 909', 'Caixa Econômica', '8ADZZZ123YT003562'),
('74136985206', 'Elaine Fernandes', 'elaine.fernandes@email.com', '(61) 91234-5678', 'Avenida das Palmeiras, 1313', 'Banco Inter', '4MNZZZ789XZ005678'),
('75385215917', 'Fernanda Moraes', 'fernanda.moraes@email.com', '(71) 97632-1895', 'Rua Jardim, 2424', 'Nubank', '3EYZZZ567UV002143'),
('75395145611', 'Eduardo Torres', 'eduardo.torres@email.com', '(11) 97856-3210', 'Rua Primavera, 1818', 'Banco do Brasil', '9YXZZZ567IJ005432'),
('78945612355', 'Fernando Almeida', 'fernando.almeida@email.com', '(51) 91234-5678', 'Rua Nova, 202', 'Santander', NULL),
('85214796307', 'Tiago Lopes', 'tiago.lopes@email.com', '(71) 98765-4321', 'Travessa Amarela, 1414', 'Nubank', '3PQZZZ456CD008901'),
('85214796318', 'Gustavo Farias', 'gustavo.farias@email.com', '(81) 94567-8123', 'Travessa Alegria, 2525', 'BTG Pactual', '2FZZZZ890WX005678'),
('85236974101', 'Roberto Lima', 'roberto.lima@email.com', '(11) 93456-7890', 'Rua São Paulo, 808', 'Banco do Brasil', '9BWZZZ377VT004251'),
('85236974112', 'Isabela Nunes', 'isabela.nunes@email.com', '(21) 93478-5123', 'Avenida Marfim, 1919', 'Caixa Econômica', '8ZUZZZ890KL003218'),
('95175385213', 'Marcelo Azevedo', 'marcelo.azevedo@email.com', '(31) 91234-7856', 'Rua Esperança, 2020', 'Itaú', '7AXZZZ123MN007654'),
('96385274108', 'Renata Martins', 'renata.martins@email.com', '(81) 96543-2109', 'Rua das Hortênsias, 1515', 'BTG Pactual', '2RSZZZ123AB004567'),
('98732165499', 'Mariana Souza', 'mariana.souza@email.com', '(31) 93210-6547', 'Rua das Acácias, 707', 'C6 Bank', NULL),
('98765432100', 'Maria Santos', 'maria.santos@email.com', '(21) 96543-2109', 'Avenida Central, 456', 'Caixa Econômica', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `estoque`
--

DROP TABLE IF EXISTS `estoque`;
CREATE TABLE `estoque` (
  `cod_estoque` int(11) NOT NULL COMMENT 'armazena o código do estoque',
  `marca_carro` varchar(45) DEFAULT NULL COMMENT 'armazena a marca do carro',
  `modelo_carro` varchar(45) DEFAULT NULL COMMENT 'armazena o modelo do carro',
  `quant_carros` int(11) DEFAULT NULL COMMENT 'armazena a quantidade de carros',
  `ano_carro` year(4) DEFAULT NULL COMMENT 'armazena o ano do carro',
  `motor_carro` varchar(45) DEFAULT NULL COMMENT 'armazena as cilindradas do carro'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `estoque`
--

INSERT INTO `estoque` (`cod_estoque`, `marca_carro`, `modelo_carro`, `quant_carros`, `ano_carro`, `motor_carro`) VALUES
(1, 'Toyota', 'Corolla', 5, '2020', '2.0'),
(2, 'Honda', 'Civic', 3, '2018', '1.5 Turbo'),
(3, 'Ford', 'Focus', 4, '2019', '2.0'),
(4, 'Chevrolet', 'Onix', 6, '2021', '1.0 Turbo'),
(5, 'Volkswagen', 'Golf', 2, '2022', '1.4 TSI'),
(6, 'Hyundai', 'HB20', 7, '2017', '1.6'),
(7, 'Nissan', 'Kicks', 5, '2023', '1.6'),
(8, 'Fiat', 'Argo', 4, '2020', '1.3'),
(9, 'Renault', 'Duster', 3, '2019', '2.0'),
(10, 'Jeep', 'Compass', 2, '2021', '2.0 Turbo'),
(11, 'Peugeot', '208', 6, '2016', '1.2'),
(12, 'Citroen', 'C3', 5, '2015', '1.6'),
(13, 'BMW', '320i', 2, '2022', '2.0 Turbo'),
(14, 'Mercedes', 'C200', 1, '2023', '2.0 Turbo'),
(15, 'Audi', 'A3', 3, '2018', '1.4 TFSI'),
(16, 'Mitsubishi', 'Lancer', 4, '2019', '2.0'),
(17, 'Subaru', 'Impreza', 2, '2017', '2.5'),
(18, 'Toyota', 'Yaris', 6, '2020', '1.5'),
(19, 'Honda', 'HR-V', 3, '2021', '1.8'),
(20, 'Ford', 'EcoSport', 5, '2019', '1.5'),
(21, 'Chevrolet', 'Tracker', 4, '2022', '1.2 Turbo'),
(22, 'Volkswagen', 'T-Cross', 6, '2018', '1.0 TSI'),
(23, 'Hyundai', 'Creta', 3, '2016', '2.0'),
(24, 'Nissan', 'Versa', 7, '2023', '1.6'),
(25, 'Fiat', 'Cronos', 5, '2015', '1.3'),
(26, 'Renault', 'Sandero', 4, '2017', '1.0'),
(27, 'Jeep', 'Renegade', 3, '2021', '1.8'),
(28, 'Peugeot', '3008', 2, '2022', '1.6 Turbo'),
(29, 'Citroen', 'Aircross', 6, '2020', '1.6'),
(30, 'Mitsubishi', 'Outlander', 4, '2019', '2.4');

-- --------------------------------------------------------

--
-- Estrutura para tabela `fornecedor`
--

DROP TABLE IF EXISTS `fornecedor`;
CREATE TABLE `fornecedor` (
  `cnpj` varchar(18) NOT NULL COMMENT 'armazena o cnpj do fornecedor',
  `nome_fornecedor` varchar(45) DEFAULT NULL COMMENT 'armazena o nome do fornecedor',
  `end_fornecedor` varchar(45) DEFAULT NULL COMMENT 'armazena o endereço do fornecedor',
  `email_fornecedor` varchar(45) DEFAULT NULL COMMENT 'armazena o email do fornecedor',
  `tel_fornecedor` varchar(15) DEFAULT NULL COMMENT 'armazena o telefone do fornecedor',
  `frete_fornecedor` decimal(10,2) DEFAULT NULL COMMENT 'armazena o preço do frete do fornecedor'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `fornecedor`
--

INSERT INTO `fornecedor` (`cnpj`, `nome_fornecedor`, `end_fornecedor`, `email_fornecedor`, `tel_fornecedor`, `frete_fornecedor`) VALUES
('00.111.222/0001-10', 'Speed Race', 'Rua da Corrida, 1000', 'suporte@speedrace.com', '(31) 90123-4567', 200.00),
('00.111.222/0001-20', 'Road Master', 'Rua Mestre das Estradas, 2000', 'suporte@roadmaster.com', '(31) 98123-4567', 210.00),
('00.111.222/0001-30', 'Pit Stop Auto', 'Rua Pit Stop, 3000', 'suporte@pitstop.com', '(31) 98123-4567', 220.00),
('10.111.222/0001-01', 'Auto Peças Brasil', 'Rua das Indústrias, 100', 'contato@autopecasbr.com', '(11) 91234-5678', 120.50),
('10.111.222/0001-11', 'Auto Parts Ltda', 'Rua dos Acessórios, 1100', 'contato@autoparts.com', '(11) 90234-5678', 125.50),
('10.111.222/0001-21', 'Performance Auto', 'Rua Performance, 2100', 'contato@performanceauto.com', '(11) 98234-5678', 130.50),
('20.222.333/0001-02', 'Motors Turbo', 'Avenida dos Motores, 200', 'suporte@motorsturbo.com', '(21) 92345-6789', 150.75),
('20.222.333/0001-12', 'Maxi Pex Auto', 'Avenida Maxi Peças, 1200', 'suporte@maxipex.com', '(21) 91345-6789', 145.75),
('20.222.333/0001-22', 'RaceWay Parts', 'Avenida RaceWay, 2200', 'suporte@raceway.com', '(21) 99345-6789', 150.75),
('30.333.444/0001-03', 'Velox Car', 'Praça da Velocidade, 300', 'vendas@veloxcar.com', '(31) 93456-7890', 180.00),
('30.333.444/0001-13', 'Power Drive', 'Praça da Potência, 1300', 'vendas@powerdrive.com', '(31) 92456-7890', 175.00),
('30.333.444/0001-23', 'Grand Prix Auto', 'Praça Grand Prix, 2300', 'vendas@grandprix.com', '(31) 90456-7890', 170.00),
('40.444.555/0001-04', 'DriveWay Auto', 'Rua do Automóvel, 400', 'info@driveway.com', '(41) 94567-8901', 140.20),
('40.444.555/0001-14', 'Turbo Peças', 'Rua Turbo, 1400', 'info@turbopecas.com', '(41) 93567-8901', 135.20),
('40.444.555/0001-24', 'Dynamic Drive', 'Rua Direção Dinâmica, 2400', 'info@dynamicdrive.com', '(41) 91567-8901', 140.20),
('50.555.666/0001-05', 'Auto Mecânica', 'Avenida das Oficinas, 500', 'contato@automecanica.com', '(51) 95678-9012', 160.90),
('50.555.666/0001-15', 'High Speed Motors', 'Avenida Alta Velocidade, 1500', 'contato@highspeed.com', '(51) 94678-9012', 165.90),
('50.555.666/0001-25', 'Speedway Auto', 'Avenida da Velocidade, 2500', 'contato@speedway.com', '(51) 92678-9012', 160.90),
('60.666.777/0001-06', 'CarFix Peças', 'Rua dos Consertos, 600', 'suporte@carfix.com', '(61) 96789-0123', 190.30),
('60.666.777/0001-16', 'Top Auto Suprimentos', 'Rua Top Auto, 1600', 'suporte@topauto.com', '(61) 95789-0123', 195.30),
('60.666.777/0001-26', 'Thunder Auto', 'Rua do Trovão, 2600', 'suporte@thunderauto.com', '(61) 93789-0123', 190.30),
('70.777.888/0001-07', 'Super Rodas', 'Avenida das Rodas, 700', 'vendas@superrodas.com', '(71) 97890-1234', 130.40),
('70.777.888/0001-17', 'Racer Parts', 'Avenida dos Pilotos, 1700', 'vendas@racerparts.com', '(71) 96890-1234', 140.40),
('70.777.888/0001-27', 'Storm Motors', 'Avenida da Tempestade, 2700', 'vendas@stormmotors.com', '(71) 94890-1234', 135.40),
('80.888.999/0001-08', 'Fast Track Auto', 'Rua da Pista Rápida, 800', 'info@fasttrack.com', '(81) 98901-2345', 170.80),
('80.888.999/0001-18', 'Auto King', 'Rua Rei dos Autos, 1800', 'info@autoking.com', '(81) 97901-2345', 180.80),
('80.888.999/0001-28', 'TrackLine Peças', 'Rua da Linha de Pista, 2800', 'info@trackline.com', '(81) 95901-2345', 175.80),
('90.999.000/0001-09', 'Tork Motors', 'Avenida da Potência, 900', 'contato@torkmotors.com', '(91) 99012-3456', 155.60),
('90.999.000/0001-19', 'Mega Motors', 'Avenida Mega Motores, 1900', 'contato@megamotors.com', '(91) 98012-3456', 160.60),
('90.999.000/0001-29', 'Revolution Auto', 'Avenida da Revolução, 2900', 'contato@revolutionauto.com', '(91) 97012-3456', 150.60);

-- --------------------------------------------------------

--
-- Estrutura para tabela `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
CREATE TABLE `funcionario` (
  `cpf` varchar(15) NOT NULL COMMENT 'armazena o cpf do funcionário',
  `nome_funcionario` varchar(45) DEFAULT NULL COMMENT 'armazena o nome do funcionario',
  `tel_funcionario` varchar(15) DEFAULT NULL COMMENT 'armazena o telefone do funcionário',
  `salario_funcionario` decimal(10,2) DEFAULT NULL COMMENT 'armazena o salário do funcionário',
  `comissao_funcionario` decimal(10,2) DEFAULT NULL COMMENT 'armazena a comissão do funcionário',
  `end_funcionario` varchar(45) DEFAULT NULL COMMENT 'armazena o endereço do funcionário',
  `loja_cod_loja` int(11) DEFAULT NULL COMMENT 'chave estrangeira da tabela loja_de_carro'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `funcionario`
--

INSERT INTO `funcionario` (`cpf`, `nome_funcionario`, `tel_funcionario`, `salario_funcionario`, `comissao_funcionario`, `end_funcionario`, `loja_cod_loja`) VALUES
('99901234117', 'Thiago Nogueira', '(11) 99999-0067', 2800.00, 6.00, 'Rua das Rosas, 6700', 13),
('99901234127', 'André Correia', '(11) 99999-0077', 2400.00, 4.90, 'Avenida Paraná, 7700', 16),
('99901234137', 'Sandro Pereira', '(11) 99999-0087', 2200.00, 3.80, 'Rua das Acácias, 8700', 19),
('99901234147', 'Lucas Almeida', '(11) 99999-0097', 2800.00, 6.00, 'Rua das Rosas, 6700', 23),
('99901234157', 'Rodrigo Lima', '(11) 99999-0107', 2400.00, 4.90, 'Avenida Paraná, 7700', 26),
('99901234167', 'Daniela Pereira', '(11) 99999-0117', 2200.00, 3.80, 'Rua das Acácias, 8700', 29),
('99901234567', 'Adriano Oliveira', '(11) 99999-0037', 2800.00, 6.20, 'Rua Santa Catarina, 3700', 3),
('99901234578', 'Luciano Cardoso', '(11) 99999-0047', 2450.00, 5.20, 'Avenida Paraná, 4700', 6),
('99901234598', 'Patrícia Ramos', '(11) 99999-0057', 2200.00, 3.90, 'Rua Rui Barbosa, 5700', 9),
('99912345118', 'Isabela Fernandes', '(11) 99999-0068', 2500.00, 5.10, 'Avenida Goiás, 6800', 13),
('99912345128', 'Camila Rocha', '(11) 99999-0078', 2200.00, 3.70, 'Rua Dom Pedro I, 7800', 16),
('99912345138', 'Luciana Mendes', '(11) 99999-0088', 2750.00, 6.00, 'Rua Dom Manuel, 8800', 20),
('99912345148', 'Amanda Costa', '(11) 99999-0098', 2500.00, 5.10, 'Avenida Goiás, 6800', 23),
('99912345158', 'Roberta Rocha', '(11) 99999-0108', 2200.00, 3.70, 'Rua Dom Pedro I, 7800', 26),
('99912345168', 'Paula Gomes', '(11) 99999-0118', 2750.00, 6.00, 'Rua Dom Manuel, 8800', 30),
('99912345678', 'Carla Nogueira', '(11) 99999-0038', 2500.00, 5.10, 'Avenida Getúlio Vargas, 3800', 3),
('99912345689', 'Mariana Ribeiro', '(11) 99999-0048', 2250.00, 4.10, 'Rua Santa Maria, 4800', 6),
('99912345699', 'Gustavo Monteiro', '(11) 99999-0058', 2750.00, 6.10, 'Rua Sete de Setembro, 5800', 10),
('99923456119', 'Mateus Oliveira', '(11) 99999-0069', 2300.00, 4.30, 'Rua Dom Bosco, 6900', 13),
('99923456129', 'Diego Santos', '(11) 99999-0079', 2700.00, 5.80, 'Rua Joaquim Nabuco, 7900', 17),
('99923456139', 'Eduardo Silveira', '(11) 99999-0089', 2500.00, 5.40, 'Avenida João Goulart, 8900', 20),
('99923456149', 'Fernando Souza', '(11) 99999-0099', 2300.00, 4.30, 'Rua Dom Bosco, 6900', 23),
('99923456159', 'Lívia Silva', '(11) 99999-0109', 2700.00, 5.80, 'Rua Joaquim Nabuco, 7900', 27),
('99923456169', 'Renato Costa', '(11) 99999-0119', 2500.00, 5.40, 'Avenida João Goulart, 8900', 30),
('99923456700', 'Camila Andrade', '(11) 99999-0059', 2500.00, 5.30, 'Avenida das Laranjeiras, 5900', 10),
('99923456789', 'Thiago Barreto', '(11) 99999-0039', 2300.00, 4.40, 'Rua Dom Pedro II, 3900', 3),
('99923456790', 'Eduardo Teixeira', '(11) 99999-0049', 2700.00, 5.90, 'Rua da Liberdade, 4900', 7),
('99934567120', 'Ana Clara Souza', '(11) 99999-0070', 2700.00, 5.90, 'Rua São Paulo, 7000', 14),
('99934567130', 'Fernanda Oliveira', '(11) 99999-0080', 2350.00, 4.60, 'Avenida Tiradentes, 8000', 17),
('99934567140', 'Tatiane Costa', '(11) 99999-0090', 2300.00, 4.30, 'Rua Pedro Álvares Cabral, 9000', 20),
('99934567150', 'Gabriela Oliveira', '(11) 99999-0100', 2700.00, 5.90, 'Rua São Paulo, 7000', 24),
('99934567160', 'Gustavo Ribeiro', '(11) 99999-0110', 2350.00, 4.60, 'Avenida Tiradentes, 8000', 27),
('99934567170', 'Marcelo Silva', '(11) 99999-0120', 2300.00, 4.30, 'Rua Pedro Álvares Cabral, 9000', 30),
('99934567801', 'Leonardo Campos', '(11) 99999-0060', 2300.00, 4.20, 'Rua São Francisco, 6000', 10),
('99934567890', 'Rafaela Mendes', '(11) 99999-0040', 2600.00, 5.70, 'Rua Maranhão, 4000', 4),
('99934567891', 'Amanda Fernandes', '(11) 99999-0050', 2400.00, 4.80, 'Avenida Marechal Deodoro, 5000', 7),
('99945678111', 'Daniel Santos', '(11) 99999-0061', 2700.00, 5.70, 'Rua das Acácias, 6100', 11),
('99945678121', 'Bruno Martins', '(11) 99999-0071', 2350.00, 4.50, 'Avenida Independência, 7100', 14),
('99945678131', 'Renato Monteiro', '(11) 99999-0081', 2200.00, 3.90, 'Rua Dom Helder Câmara, 8100', 17),
('99945678141', 'Roberta Lima', '(11) 99999-0091', 2700.00, 5.70, 'Rua das Acácias, 6100', 21),
('99945678151', 'Bruno Alves', '(11) 99999-0101', 2350.00, 4.50, 'Avenida Independência, 7100', 24),
('99945678161', 'Tatiane Costa', '(11) 99999-0111', 2200.00, 3.90, 'Rua Dom Helder Câmara, 8100', 27),
('99945678901', 'Fábio Souza', '(11) 99999-0031', 2650.00, 5.60, 'Rua Bela Vista, 3100', 1),
('99945678912', 'Pedro Silva', '(11) 99999-0041', 2350.00, 4.60, 'Rua Amazonas, 4100', 4),
('99945678992', 'Rafael Almeida', '(11) 99999-0051', 2200.00, 3.70, 'Rua XV de Novembro, 5100', 7),
('99956789012', 'Natália Ferreira', '(11) 99999-0032', 2300.00, 4.90, 'Avenida Industrial, 3200', 1),
('99956789023', 'Jéssica Almeida', '(11) 99999-0042', 2200.00, 3.90, 'Avenida Beira Rio, 4200', 4),
('99956789093', 'Vanessa Matos', '(11) 99999-0052', 2600.00, 5.40, 'Rua José Bonifácio, 5200', 8),
('99956789112', 'Juliana Mendes', '(11) 99999-0062', 2400.00, 4.90, 'Avenida Paulista, 6200', 11),
('99956789122', 'Vanessa Lima', '(11) 99999-0072', 2200.00, 3.80, 'Rua Barão de Mauá, 7200', 14),
('99956789132', 'Patrícia Nunes', '(11) 99999-0082', 2800.00, 6.20, 'Rua do Comércio, 8200', 18),
('99956789142', 'Carlos Alberto', '(11) 99999-0092', 2400.00, 4.90, 'Avenida Paulista, 6200', 21),
('99956789152', 'Patrícia Lima', '(11) 99999-0102', 2200.00, 3.80, 'Rua Barão de Mauá, 7200', 24),
('99956789162', 'José Oliveira', '(11) 99999-0112', 2800.00, 6.20, 'Rua do Comércio, 8200', 28),
('99967890113', 'Lucas Rocha', '(11) 99999-0063', 2200.00, 3.60, 'Rua Ipiranga, 6300', 11),
('99967890123', 'Ricardo Andrade', '(11) 99999-0033', 2100.00, 3.70, 'Rua São João, 3300', 1),
('99967890133', 'Rafael Figueiredo', '(11) 99999-0083', 2500.00, 5.30, 'Avenida das Nações, 8300', 18),
('99967890134', 'Henrique Castro', '(11) 99999-0043', 2650.00, 5.80, 'Rua das Palmeiras, 4300', 5),
('99967890143', 'Simone Pereira', '(11) 99999-0093', 2200.00, 3.60, 'Rua Ipiranga, 6300', 21),
('99967890153', 'Carlos Henrique', '(11) 99999-0103', 2750.00, 6.10, 'Rua Bela Cintra, 7300', 25),
('99967890163', 'Marcela Almeida', '(11) 99999-0113', 2500.00, 5.30, 'Avenida das Nações, 8300', 28),
('99967890194', 'Fernando Nunes', '(11) 99999-0053', 2350.00, 4.90, 'Rua das Hortênsias, 5300', 8),
('99967890199', 'Gustavo Almeida', '(11) 99999-0073', 2750.00, 6.10, 'Rua Bela Cintra, 7300', 15),
('99978901114', 'Mariana Castro', '(11) 99999-0064', 2750.00, 5.80, 'Rua das Oliveiras, 6400', 12),
('99978901124', 'Eduarda Campos', '(11) 99999-0074', 2450.00, 5.20, 'Avenida Itamarati, 7400', 15),
('99978901134', 'Juliana Cardoso', '(11) 99999-0084', 2300.00, 4.20, 'Rua das Hortênsias, 8400', 18),
('99978901144', 'Thiago Martins', '(11) 99999-0094', 2750.00, 5.80, 'Rua das Oliveiras, 6400', 22),
('99978901154', 'Vanessa Costa', '(11) 99999-0104', 2450.00, 5.20, 'Avenida Itamarati, 7400', 25),
('99978901164', 'Amanda Silva', '(11) 99999-0114', 2300.00, 4.20, 'Rua das Hortênsias, 8400', 28),
('99978901234', 'Fernanda Prado', '(11) 99999-0034', 2700.00, 5.90, 'Rua das Amendoeiras, 3400', 2),
('99978901245', 'Tatiane Figueiredo', '(11) 99999-0044', 2400.00, 4.70, 'Avenida Santo Antônio, 4400', 5),
('99978901295', 'Lucas Farias', '(11) 99999-0054', 2200.00, 3.80, 'Avenida Bento Gonçalves, 5400', 8),
('99989012115', 'Felipe Moreira', '(11) 99999-0065', 2450.00, 4.70, 'Avenida Brasil, 6500', 12),
('99989012125', 'Henrique Vasconcelos', '(11) 99999-0075', 2250.00, 4.40, 'Rua João Pessoa, 7500', 15),
('99989012135', 'Carlos Macedo', '(11) 99999-0085', 2650.00, 5.50, 'Rua do Rosário, 8500', 19),
('99989012145', 'Renata Gomes', '(11) 99999-0095', 2450.00, 4.70, 'Avenida Brasil, 6500', 22),
('99989012155', 'Ricardo Souza', '(11) 99999-0105', 2250.00, 4.40, 'Rua João Pessoa, 7500', 25),
('99989012165', 'Fernando Mendes', '(11) 99999-0115', 2650.00, 5.50, 'Rua do Rosário, 8500', 29),
('99989012345', 'Guilherme Farias', '(11) 99999-0035', 2400.00, 4.50, 'Avenida Presidente Vargas, 3500', 2),
('99989012356', 'Felipe Rocha', '(11) 99999-0045', 2150.00, 3.60, 'Rua das Camélias, 4500', 5),
('99989012396', 'Tatiane Lopes', '(11) 99999-0055', 2650.00, 5.50, 'Rua das Araucárias, 5500', 9),
('99990123116', 'Carolina Ribeiro', '(11) 99999-0066', 2250.00, 3.90, 'Rua Santos Dumont, 6600', 12),
('99990123126', 'Raquel Ferreira', '(11) 99999-0076', 2650.00, 5.60, 'Rua Amazonas, 7600', 16),
('99990123136', 'Lorena Martins', '(11) 99999-0086', 2400.00, 4.70, 'Avenida dos Expedicionários, 8600', 19),
('99990123146', 'Felipe Barbosa', '(11) 99999-0096', 2250.00, 3.90, 'Rua Santos Dumont, 6600', 22),
('99990123156', 'Juliana Almeida', '(11) 99999-0106', 2650.00, 5.60, 'Rua Amazonas, 7600', 26),
('99990123166', 'Bruna Souza', '(11) 99999-0116', 2400.00, 4.70, 'Avenida dos Expedicionários, 8600', 29),
('99990123456', 'Tatiane Mendes', '(11) 99999-0036', 2250.00, 3.80, 'Rua Rui Barbosa, 3600', 2),
('99990123467', 'Beatriz Moreira', '(11) 99999-0046', 2750.00, 6.00, 'Rua Almirante Barroso, 4600', 6),
('99990123497', 'Roberto Souza', '(11) 99999-0056', 2400.00, 4.60, 'Avenida do Comércio, 5600', 9);

-- --------------------------------------------------------

--
-- Estrutura para tabela `loja_de_carro`
--

DROP TABLE IF EXISTS `loja_de_carro`;
CREATE TABLE `loja_de_carro` (
  `cod_loja` int(11) NOT NULL COMMENT 'armazena o código da loja',
  `end_loja` varchar(45) DEFAULT NULL COMMENT 'armazena o endereço da loja',
  `tel_loja` varchar(15) DEFAULT NULL COMMENT 'armazena o telefone da loja',
  `banco_loja` varchar(45) DEFAULT NULL COMMENT 'armazena o banco da loja',
  `hora_loja` time DEFAULT NULL COMMENT 'armazena o horário de atendimento da loja',
  `desconto_loja` decimal(5,2) DEFAULT NULL COMMENT 'armazena o quanto de desconto a loja pode fornecer',
  `estoque_cod_estoque` int(11) DEFAULT NULL COMMENT 'chave estrangeira da tabela estoque'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `loja_de_carro`
--

INSERT INTO `loja_de_carro` (`cod_loja`, `end_loja`, `tel_loja`, `banco_loja`, `hora_loja`, `desconto_loja`, `estoque_cod_estoque`) VALUES
(1, 'Av. Paulista, 1000', '(11) 98765-4321', 'Banco do Brasil', '08:00:00', 5.00, 1),
(2, 'Rua das Rosas, 500', '(21) 96543-2109', 'Caixa Econômica', '09:00:00', 7.50, 2),
(3, 'Av. Atlântica, 200', '(31) 97654-3210', 'Santander', '10:00:00', 10.00, 3),
(4, 'Rua Azul, 300', '(41) 95432-1678', 'Bradesco', '11:00:00', 6.00, 4),
(5, 'Av. Central, 400', '(51) 91234-5678', 'Itaú', '12:00:00', 8.50, 5),
(6, 'Rua Verde, 600', '(61) 99876-5432', 'Banco Inter', '13:00:00', 5.50, 6),
(7, 'Av. das Palmeiras, 700', '(71) 98712-3456', 'Banco Pan', '14:00:00', 9.00, 7),
(8, 'Rua Amarela, 800', '(81) 97623-4120', 'BTG Pactual', '15:00:00', 7.00, 8),
(9, 'Av. dos Carros, 900', '(91) 96541-2309', 'Safra', '16:00:00', 6.50, 9),
(10, 'Rua das Máquinas, 1000', '(31) 93210-6547', 'Original', '17:00:00', 10.00, 10),
(11, 'Rua das Lojas, 1100', '(11) 98877-6655', 'Neon', '08:30:00', 5.20, 11),
(12, 'Av. dos Veículos, 1200', '(21) 97766-5544', 'C6 Bank', '09:15:00', 6.80, 12),
(13, 'Rua Comercial, 1300', '(31) 96655-4433', 'Sicoob', '10:45:00', 7.40, 13),
(14, 'Av. Sul, 1400', '(41) 95544-3322', 'Banrisul', '11:30:00', 8.10, 14),
(15, 'Rua das Vendas, 1500', '(51) 94433-2211', 'Mercantil', '12:45:00', 5.90, 15),
(16, 'Alameda Auto, 1600', '(61) 93322-1100', 'BRB', '14:10:00', 9.30, 16),
(17, 'Av. Norte, 1700', '(71) 92211-0099', 'BMG', '15:50:00', 6.70, 17),
(18, 'Rua Financeira, 1800', '(81) 91100-9988', 'PagBank', '16:20:00', 8.00, 18),
(19, 'Praça do Carro, 1900', '(91) 90099-8877', 'ModalMais', '17:10:00', 7.80, 19),
(20, 'Av. Capital, 2000', '(31) 98988-7766', 'XP Investimentos', '18:00:00', 10.50, 20),
(21, 'Rua Principal, 2100', '(11) 97655-4433', 'Banco ABC', '08:45:00', 6.30, 21),
(22, 'Av. Nova, 2200', '(21) 96544-3322', 'Banco XYZ', '09:50:00', 7.20, 22),
(23, 'Rua dos Negócios, 2300', '(31) 95433-2211', 'CrediBank', '10:25:00', 9.10, 23),
(24, 'Av. Automotiva, 2400', '(41) 94322-1100', 'AutoFin', '11:40:00', 5.80, 24),
(25, 'Rua das Velocidades, 2500', '(51) 93211-0099', 'VelociBank', '12:30:00', 8.70, 25),
(26, 'Av. dos Motores, 2600', '(61) 92100-9988', 'CarroBank', '14:15:00', 7.60, 26),
(27, 'Rua dos Cilindros, 2700', '(71) 91099-8877', 'MotorBank', '15:05:00', 6.90, 27),
(28, 'Av. Turbo, 2800', '(81) 90988-7766', 'TurboFin', '16:45:00', 9.80, 28),
(29, 'Rua da Aceleração, 2900', '(91) 90877-6655', 'HighSpeed', '17:20:00', 10.20, 29),
(30, 'Av. Direção, 3000', '(31) 90766-5544', 'FullDrive', '18:10:00', 7.90, 30);

-- --------------------------------------------------------

--
-- Estrutura para tabela `loja_de_carro_has_cliente`
--

DROP TABLE IF EXISTS `loja_de_carro_has_cliente`;
CREATE TABLE `loja_de_carro_has_cliente` (
  `loja_cod_loja` int(11) NOT NULL,
  `cliente_cpf` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `loja_de_carro_has_cliente`
--

INSERT INTO `loja_de_carro_has_cliente` (`loja_cod_loja`, `cliente_cpf`) VALUES
(1, '85236974101'),
(2, '74125896302'),
(3, '36985214703'),
(4, '25814736904'),
(5, '12398745605'),
(6, '74136985206'),
(7, '85214796307'),
(8, '96385274108'),
(9, '15935785209'),
(10, '35715948610'),
(11, '75395145611'),
(12, '85236974112'),
(13, '95175385213'),
(14, '14725836914'),
(15, '36974185215'),
(16, '25896314716'),
(17, '75385215917'),
(18, '85214796318'),
(19, '36925814719'),
(20, '14736985220');

-- --------------------------------------------------------

--
-- Estrutura para tabela `loja_de_carro_has_fornecedor`
--

DROP TABLE IF EXISTS `loja_de_carro_has_fornecedor`;
CREATE TABLE `loja_de_carro_has_fornecedor` (
  `loja_cod_loja` int(11) NOT NULL,
  `fornecedor_cnpj` varchar(18) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `loja_de_carro_has_fornecedor`
--

INSERT INTO `loja_de_carro_has_fornecedor` (`loja_cod_loja`, `fornecedor_cnpj`) VALUES
(1, '00.111.222/0001-10'),
(2, '00.111.222/0001-20'),
(3, '00.111.222/0001-30'),
(4, '10.111.222/0001-01'),
(5, '10.111.222/0001-11'),
(6, '10.111.222/0001-21'),
(7, '20.222.333/0001-02'),
(8, '20.222.333/0001-12'),
(9, '20.222.333/0001-22'),
(10, '30.333.444/0001-03'),
(11, '30.333.444/0001-13'),
(12, '30.333.444/0001-23'),
(13, '40.444.555/0001-04'),
(14, '40.444.555/0001-14'),
(15, '40.444.555/0001-24'),
(16, '50.555.666/0001-05'),
(17, '50.555.666/0001-15'),
(18, '50.555.666/0001-25'),
(19, '60.666.777/0001-06'),
(20, '60.666.777/0001-16'),
(21, '60.666.777/0001-26'),
(22, '70.777.888/0001-07'),
(23, '70.777.888/0001-17'),
(24, '70.777.888/0001-27'),
(25, '80.888.999/0001-08'),
(26, '80.888.999/0001-18'),
(27, '80.888.999/0001-28'),
(28, '90.999.000/0001-09'),
(29, '90.999.000/0001-19'),
(30, '90.999.000/0001-29');

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `sp_detalhes_carros`
-- (Veja abaixo para a visão atual)
--
DROP VIEW IF EXISTS `sp_detalhes_carros`;
CREATE TABLE `sp_detalhes_carros` (
`Chassi` varchar(20)
,`Cor` varchar(45)
,`Quilometragem` int(11)
,`Estado` enum('Novo','Seminovo','Usado')
,`Marca` varchar(45)
,`Modelo` varchar(45)
,`Ano` year(4)
,`Codigo_Loja` int(11)
,`Endereco_Loja` varchar(45)
,`Nome_Cliente` varchar(45)
,`Email_Cliente` varchar(45)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `sp_detalhes_completos`
-- (Veja abaixo para a visão atual)
--
DROP VIEW IF EXISTS `sp_detalhes_completos`;
CREATE TABLE `sp_detalhes_completos` (
`Chassi` varchar(20)
,`Cor` varchar(45)
,`Quilometragem` int(11)
,`Estado` enum('Novo','Seminovo','Usado')
,`Marca` varchar(45)
,`Modelo` varchar(45)
,`Ano` year(4)
,`Codigo_Loja` int(11)
,`Endereco_Loja` varchar(45)
,`Nome_Cliente` varchar(45)
,`Email_Cliente` varchar(45)
,`Nome_Funcionario` varchar(45)
,`Salario_Funcionario` decimal(10,2)
,`Telefone_Funcionario` varchar(15)
,`Nome_Fornecedor` varchar(45)
,`Email_Fornecedor` varchar(45)
,`Telefone_Fornecedor` varchar(15)
);

-- --------------------------------------------------------

--
-- Estrutura para view `sp_detalhes_carros`
--
DROP TABLE IF EXISTS `sp_detalhes_carros`;

DROP VIEW IF EXISTS `sp_detalhes_carros`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sp_detalhes_carros`  AS SELECT `c`.`chassi` AS `Chassi`, `c`.`cor_carro` AS `Cor`, `c`.`km_carro` AS `Quilometragem`, `c`.`estado` AS `Estado`, `e`.`marca_carro` AS `Marca`, `e`.`modelo_carro` AS `Modelo`, `e`.`ano_carro` AS `Ano`, `l`.`cod_loja` AS `Codigo_Loja`, `l`.`end_loja` AS `Endereco_Loja`, `cl`.`nome_cliente` AS `Nome_Cliente`, `cl`.`email_cliente` AS `Email_Cliente` FROM (((`carro` `c` join `estoque` `e` on(`c`.`estoque_cod_estoque` = `e`.`cod_estoque`)) left join `cliente` `cl` on(`c`.`chassi` = `cl`.`carro_chassi`)) left join `loja_de_carro` `l` on(`e`.`cod_estoque` = `l`.`estoque_cod_estoque`)) ;

-- --------------------------------------------------------

--
-- Estrutura para view `sp_detalhes_completos`
--
DROP TABLE IF EXISTS `sp_detalhes_completos`;

DROP VIEW IF EXISTS `sp_detalhes_completos`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sp_detalhes_completos`  AS SELECT `c`.`chassi` AS `Chassi`, `c`.`cor_carro` AS `Cor`, `c`.`km_carro` AS `Quilometragem`, `c`.`estado` AS `Estado`, `e`.`marca_carro` AS `Marca`, `e`.`modelo_carro` AS `Modelo`, `e`.`ano_carro` AS `Ano`, `l`.`cod_loja` AS `Codigo_Loja`, `l`.`end_loja` AS `Endereco_Loja`, `cl`.`nome_cliente` AS `Nome_Cliente`, `cl`.`email_cliente` AS `Email_Cliente`, `f`.`nome_funcionario` AS `Nome_Funcionario`, `f`.`salario_funcionario` AS `Salario_Funcionario`, `f`.`tel_funcionario` AS `Telefone_Funcionario`, `fo`.`nome_fornecedor` AS `Nome_Fornecedor`, `fo`.`email_fornecedor` AS `Email_Fornecedor`, `fo`.`tel_fornecedor` AS `Telefone_Fornecedor` FROM ((((((`carro` `c` join `estoque` `e` on(`c`.`estoque_cod_estoque` = `e`.`cod_estoque`)) left join `cliente` `cl` on(`c`.`chassi` = `cl`.`carro_chassi`)) left join `loja_de_carro` `l` on(`e`.`cod_estoque` = `l`.`estoque_cod_estoque`)) left join `funcionario` `f` on(`l`.`cod_loja` = `f`.`loja_cod_loja`)) left join `loja_de_carro_has_fornecedor` `lf` on(`l`.`cod_loja` = `lf`.`loja_cod_loja`)) left join `fornecedor` `fo` on(`lf`.`fornecedor_cnpj` = `fo`.`cnpj`)) ;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `carro`
--
ALTER TABLE `carro`
  ADD PRIMARY KEY (`chassi`),
  ADD KEY `estoque_cod_estoque` (`estoque_cod_estoque`);

--
-- Índices de tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`cpf`),
  ADD KEY `carro_chassi` (`carro_chassi`);

--
-- Índices de tabela `estoque`
--
ALTER TABLE `estoque`
  ADD PRIMARY KEY (`cod_estoque`);

--
-- Índices de tabela `fornecedor`
--
ALTER TABLE `fornecedor`
  ADD PRIMARY KEY (`cnpj`);

--
-- Índices de tabela `funcionario`
--
ALTER TABLE `funcionario`
  ADD PRIMARY KEY (`cpf`),
  ADD KEY `loja_cod_loja` (`loja_cod_loja`);

--
-- Índices de tabela `loja_de_carro`
--
ALTER TABLE `loja_de_carro`
  ADD PRIMARY KEY (`cod_loja`),
  ADD KEY `estoque_cod_estoque` (`estoque_cod_estoque`);

--
-- Índices de tabela `loja_de_carro_has_cliente`
--
ALTER TABLE `loja_de_carro_has_cliente`
  ADD PRIMARY KEY (`loja_cod_loja`,`cliente_cpf`),
  ADD KEY `cliente_cpf` (`cliente_cpf`);

--
-- Índices de tabela `loja_de_carro_has_fornecedor`
--
ALTER TABLE `loja_de_carro_has_fornecedor`
  ADD PRIMARY KEY (`loja_cod_loja`,`fornecedor_cnpj`),
  ADD KEY `fornecedor_cnpj` (`fornecedor_cnpj`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `estoque`
--
ALTER TABLE `estoque`
  MODIFY `cod_estoque` int(11) NOT NULL AUTO_INCREMENT COMMENT 'armazena o código do estoque', AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de tabela `loja_de_carro`
--
ALTER TABLE `loja_de_carro`
  MODIFY `cod_loja` int(11) NOT NULL AUTO_INCREMENT COMMENT 'armazena o código da loja', AUTO_INCREMENT=31;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `carro`
--
ALTER TABLE `carro`
  ADD CONSTRAINT `carro_ibfk_1` FOREIGN KEY (`estoque_cod_estoque`) REFERENCES `estoque` (`cod_estoque`) ON DELETE CASCADE;

--
-- Restrições para tabelas `loja_de_carro`
--
ALTER TABLE `loja_de_carro`
  ADD CONSTRAINT `fk_loja_estoque` FOREIGN KEY (`estoque_cod_estoque`) REFERENCES `estoque` (`cod_estoque`);

--
-- Restrições para tabelas `loja_de_carro_has_cliente`
--
ALTER TABLE `loja_de_carro_has_cliente`
  ADD CONSTRAINT `fk_cliente` FOREIGN KEY (`cliente_cpf`) REFERENCES `cliente` (`cpf`),
  ADD CONSTRAINT `fk_loja_cliente` FOREIGN KEY (`loja_cod_loja`) REFERENCES `loja_de_carro` (`cod_loja`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
