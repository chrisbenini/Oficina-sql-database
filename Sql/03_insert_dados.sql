USE oficina;

INSERT INTO cliente (nome, telefone, email) VALUES
('Carlos Silva', '11999990001', 'carlos.silva@email.com'),
('Mariana Souza', '11999990002', 'mariana.souza@email.com'),
('Joao Pereira', '11999990003', 'joao.pereira@email.com'),
('Fernanda Lima', '11999990004', 'fernanda.lima@email.com'),
('Ricardo Alves', '11999990005', 'ricardo.alves@email.com');

INSERT INTO veiculo (id_cliente, placa, modelo, marca, ano) VALUES
(1, 'ABC1D23', 'Onix', 'Chevrolet', 2020),
(1, 'EFG4H56', 'HB20', 'Hyundai', 2022),
(2, 'IJK7L89', 'Corolla', 'Toyota', 2019),
(3, 'MNO1P23', 'Gol', 'Volkswagen', 2015),
(4, 'QRS4T56', 'Civic', 'Honda', 2021),
(5, 'UVW7X89', 'Fiesta', 'Ford', 2018);

INSERT INTO mecanico (nome, especialidade, telefone) VALUES
('Roberto Mendes', 'Motor', '11988880001'),
('Lucas Ferreira', 'Freios e Suspensao', '11988880002'),
('Patricia Gomes', 'Eletrica Automotiva', '11988880003'),
('Andre Costa', 'Revisao Geral', '11988880004');

INSERT INTO equipe (nome_equipe) VALUES
('Equipe Alfa'),
('Equipe Beta');

INSERT INTO equipe_mecanico (id_equipe, id_mecanico) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4);

INSERT INTO servico (descricao, valor_mao_obra) VALUES
('Troca de oleo', 120.00),
('Alinhamento e balanceamento', 180.00),
('Troca de pastilha de freio', 250.00),
('Revisao completa', 500.00),
('Troca de bateria', 90.00);

INSERT INTO peca (descricao, valor_unitario, quantidade_estoque) VALUES
('Filtro de oleo', 35.00, 20),
('Oleo 5W30', 45.00, 50),
('Pastilha de freio', 180.00, 15),
('Bateria 60Ah', 350.00, 10),
('Filtro de ar', 40.00, 18),
('Correia dentada', 220.00, 8);

INSERT INTO ordem_servico (id_veiculo, id_equipe, data_emissao, data_conclusao, status_os, valor_total, autorizado) VALUES
(1, 1, '2026-03-01', '2026-03-02', 'Concluida', 245.00, 1),
(2, 1, '2026-03-03', '2026-03-04', 'Concluida', 430.00, 1),
(3, 2, '2026-03-05', NULL, 'Em andamento', 500.00, 1),
(4, 2, '2026-03-06', '2026-03-07', 'Concluida', 440.00, 1),
(5, 1, '2026-03-08', NULL, 'Aguardando aprovacao', 590.00, 0),
(6, 2, '2026-03-09', NULL, 'Em andamento', 710.00, 1);

INSERT INTO ordem_servico_servico (id_ordem_servico, id_servico, quantidade, subtotal) VALUES
(1, 1, 1, 120.00),
(2, 2, 1, 180.00),
(2, 3, 1, 250.00),
(3, 4, 1, 500.00),
(4, 5, 1, 90.00),
(5, 4, 1, 500.00),
(6, 3, 1, 250.00),
(6, 2, 1, 180.00);

INSERT INTO ordem_servico_peca (id_ordem_servico, id_peca, quantidade, subtotal) VALUES
(1, 1, 1, 35.00),
(1, 2, 2, 90.00),
(2, 3, 1, 180.00),
(3, 5, 1, 40.00),
(4, 4, 1, 350.00),
(5, 6, 1, 220.00),
(6, 3, 1, 180.00),
(6, 5, 2, 80.00);

INSERT INTO pagamento (id_ordem_servico, forma_pagamento, valor_pago, data_pagamento, status_pagamento) VALUES
(1, 'Cartao de credito', 245.00, '2026-03-02', 'Pago'),
(2, 'Pix', 430.00, '2026-03-04', 'Pago'),
(3, 'Boleto', 250.00, NULL, 'Pendente'),
(4, 'Dinheiro', 340.00, '2026-03-07', 'Pago'),
(5, 'Cartao de debito', 0.00, NULL, 'Aguardando'),
(6, 'Pix', 300.00, NULL, 'Parcial');