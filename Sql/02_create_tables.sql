CREATE TABLE cliente(
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100));

CREATE TABLE veiculo(
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    placa VARCHAR(10) NOT NULL UNIQUE,
    modelo VARCHAR(100) NOT NULL,
    marca VARCHAR(100) NOT NULL,
    ano INT NOT NULL,
    CONSTRAINT fk_veiculo_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente));

CREATE TABLE mecanico(
    id_mecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100),
    telefone VARCHAR(20));

CREATE TABLE equipe(
    id_equipe INT AUTO_INCREMENT PRIMARY KEY,
    nome_equipe VARCHAR(100) NOT NULL);

CREATE TABLE equipe_mecanico(
    id_equipe_mecanico INT AUTO_INCREMENT PRIMARY KEY,
    id_equipe INT NOT NULL,
    id_mecanico INT NOT NULL,
    CONSTRAINT fk_equipe_mecanico_equipe
        FOREIGN KEY (id_equipe)
        REFERENCES equipe(id_equipe),
    CONSTRAINT fk_equipe_mecanico_mecanico
        FOREIGN KEY (id_mecanico)
        REFERENCES mecanico(id_mecanico),
    CONSTRAINT uq_equipe_mecanico UNIQUE (id_equipe, id_mecanico));

CREATE TABLE servico(
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(150) NOT NULL,
    valor_mao_obra DECIMAL(10,2) NOT NULL);

CREATE TABLE peca(
    id_peca INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(150) NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    quantidade_estoque INT NOT NULL DEFAULT 0);

CREATE TABLE ordem_servico(
    id_ordem_servico INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT NOT NULL,
    id_equipe INT NOT NULL,
    data_emissao DATE NOT NULL,
    data_conclusao DATE,
    status_os VARCHAR(50) NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    autorizado TINYINT(1) NOT NULL DEFAULT 0,
    CONSTRAINT fk_ordem_servico_veiculo
        FOREIGN KEY (id_veiculo)
        REFERENCES veiculo(id_veiculo),
    CONSTRAINT fk_ordem_servico_equipe
        FOREIGN KEY (id_equipe)
        REFERENCES equipe(id_equipe));

CREATE TABLE ordem_servico_servico(
    id_os_servico INT AUTO_INCREMENT PRIMARY KEY,
    id_ordem_servico INT NOT NULL,
    id_servico INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    subtotal DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_os_servico_ordem_servico
        FOREIGN KEY (id_ordem_servico)
        REFERENCES ordem_servico(id_ordem_servico),
    CONSTRAINT fk_os_servico_servico
        FOREIGN KEY (id_servico)
        REFERENCES servico(id_servico),
    CONSTRAINT uq_ordem_servico_servico UNIQUE (id_ordem_servico, id_servico));

CREATE TABLE ordem_servico_peca(
    id_os_peca INT AUTO_INCREMENT PRIMARY KEY,
    id_ordem_servico INT NOT NULL,
    id_peca INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    subtotal DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_os_peca_ordem_servico
        FOREIGN KEY (id_ordem_servico)
        REFERENCES ordem_servico(id_ordem_servico),
    CONSTRAINT fk_os_peca_peca
        FOREIGN KEY (id_peca)
        REFERENCES peca(id_peca),
    CONSTRAINT uq_ordem_servico_peca UNIQUE (id_ordem_servico, id_peca));

CREATE TABLE pagamento(
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_ordem_servico INT NOT NULL,
    forma_pagamento VARCHAR(50) NOT NULL,
    valor_pago DECIMAL(10,2) NOT NULL,
    data_pagamento DATE,
    status_pagamento VARCHAR(50) NOT NULL,
    CONSTRAINT fk_pagamento_ordem_servico
        FOREIGN KEY (id_ordem_servico)
        REFERENCES ordem_servico(id_ordem_servico));