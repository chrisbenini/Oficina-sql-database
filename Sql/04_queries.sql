-- 1) Listar todos os clientes
SELECT * 
FROM cliente;

-- 2) Listar todos os veículos cadastrados
SELECT * 
FROM veiculo;

-- 3) Listar todos os mecânicos
SELECT * 
FROM mecanico;

-- 4) Listar todas as ordens de serviço
SELECT * 
FROM ordem_servico;

-- 5) Veículos da marca Chevrolet
SELECT 
    id_veiculo,
    placa,
    modelo,
    marca,
    ano
FROM veiculo
WHERE marca = 'Chevrolet';

-- 6) Ordens de serviço concluídas
SELECT 
    id_ordem_servico,
    data_emissao,
    data_conclusao,
    status_os,
    valor_total
FROM ordem_servico
WHERE status_os = 'Concluida';

-- 7) Pagamentos pendentes ou aguardando
SELECT 
    id_pagamento,
    id_ordem_servico,
    forma_pagamento,
    valor_pago,
    status_pagamento
FROM pagamento
WHERE status_pagamento IN ('Pendente', 'Aguardando');

-- 8) Peças com estoque abaixo de 15 unidades
SELECT 
    id_peca,
    descricao,
    quantidade_estoque
FROM peca
WHERE quantidade_estoque < 15;

-- 9) Valor restante a pagar por ordem de serviço
SELECT
    os.id_ordem_servico,
    os.valor_total,
    COALESCE(p.valor_pago, 0) AS valor_pago,
    (os.valor_total - COALESCE(p.valor_pago, 0)) AS valor_restante
FROM ordem_servico os
LEFT JOIN pagamento p
    ON os.id_ordem_servico = p.id_ordem_servico
ORDER BY os.id_ordem_servico;

-- 10) Idade aproximada dos veículos
SELECT
    id_veiculo,
    placa,
    modelo,
    marca,
    ano,
    (YEAR(CURDATE()) - ano) AS idade_veiculo
FROM veiculo
ORDER BY idade_veiculo DESC;

-- 11) Subtotal calculado por item de peça
SELECT
    osp.id_os_peca,
    p.descricao AS peca,
    osp.quantidade,
    p.valor_unitario,
    (osp.quantidade * p.valor_unitario) AS subtotal_calculado
FROM ordem_servico_peca osp
INNER JOIN peca p
    ON osp.id_peca = p.id_peca;

-- 12) Subtotal calculado por item de serviço
SELECT
    oss.id_os_servico,
    s.descricao AS servico,
    oss.quantidade,
    s.valor_mao_obra,
    (oss.quantidade * s.valor_mao_obra) AS subtotal_calculado
FROM ordem_servico_servico oss
INNER JOIN servico s
    ON oss.id_servico = s.id_servico;

-- 13) Clientes ordenados por nome
SELECT
    id_cliente,
    nome,
    telefone,
    email
FROM cliente
ORDER BY nome ASC;

-- 14) Ordens de serviço por maior valor
SELECT
    id_ordem_servico,
    status_os,
    valor_total
FROM ordem_servico
ORDER BY valor_total DESC;

-- 15) Peças ordenadas por menor estoque
SELECT
    id_peca,
    descricao,
    quantidade_estoque
FROM peca
ORDER BY quantidade_estoque ASC;

-- 16) Clientes e seus veículos
SELECT
    c.nome AS cliente,
    v.placa,
    v.modelo,
    v.marca,
    v.ano
FROM cliente c
INNER JOIN veiculo v
    ON c.id_cliente = v.id_cliente
ORDER BY c.nome;

-- 17) Ordens de serviço com veículo e cliente
SELECT
    os.id_ordem_servico,
    c.nome AS cliente,
    v.placa,
    v.modelo,
    os.data_emissao,
    os.status_os,
    os.valor_total
FROM ordem_servico os
INNER JOIN veiculo v
    ON os.id_veiculo = v.id_veiculo
INNER JOIN cliente c
    ON v.id_cliente = c.id_cliente
ORDER BY os.id_ordem_servico;

-- 18) Ordens de serviço com equipe responsável
SELECT
    os.id_ordem_servico,
    e.nome_equipe,
    os.status_os,
    os.valor_total
FROM ordem_servico os
INNER JOIN equipe e
    ON os.id_equipe = e.id_equipe
ORDER BY os.id_ordem_servico;

-- 19) Mecânicos e suas equipes
SELECT
    m.nome AS mecanico,
    m.especialidade,
    e.nome_equipe
FROM equipe_mecanico em
INNER JOIN mecanico m
    ON em.id_mecanico = m.id_mecanico
INNER JOIN equipe e
    ON em.id_equipe = e.id_equipe
ORDER BY e.nome_equipe, m.nome;

-- 20) Serviços executados por ordem de serviço
SELECT
    os.id_ordem_servico,
    s.descricao AS servico,
    oss.quantidade,
    oss.subtotal
FROM ordem_servico_servico oss
INNER JOIN ordem_servico os
    ON oss.id_ordem_servico = os.id_ordem_servico
INNER JOIN servico s
    ON oss.id_servico = s.id_servico
ORDER BY os.id_ordem_servico;

-- 21) Peças utilizadas por ordem de serviço
SELECT
    os.id_ordem_servico,
    p.descricao AS peca,
    osp.quantidade,
    osp.subtotal
FROM ordem_servico_peca osp
INNER JOIN ordem_servico os
    ON osp.id_ordem_servico = os.id_ordem_servico
INNER JOIN peca p
    ON osp.id_peca = p.id_peca
ORDER BY os.id_ordem_servico;

-- 22) Quantidade de veículos por cliente
SELECT
    c.nome,
    COUNT(v.id_veiculo) AS quantidade_veiculos
FROM cliente c
LEFT JOIN veiculo v
    ON c.id_cliente = v.id_cliente
GROUP BY c.id_cliente, c.nome
ORDER BY quantidade_veiculos DESC;

-- 23) Quantidade de ordens de serviço por cliente
SELECT
    c.nome,
    COUNT(os.id_ordem_servico) AS quantidade_ordens
FROM cliente c
INNER JOIN veiculo v
    ON c.id_cliente = v.id_cliente
INNER JOIN ordem_servico os
    ON v.id_veiculo = os.id_veiculo
GROUP BY c.id_cliente, c.nome
ORDER BY quantidade_ordens DESC;

-- 24) Total gasto por cliente
SELECT
    c.nome,
    SUM(os.valor_total) AS total_gasto
FROM cliente c
INNER JOIN veiculo v
    ON c.id_cliente = v.id_cliente
INNER JOIN ordem_servico os
    ON v.id_veiculo = os.id_veiculo
GROUP BY c.id_cliente, c.nome
ORDER BY total_gasto DESC;

-- 25) Quantidade de serviços realizados
SELECT
    s.descricao,
    COUNT(oss.id_servico) AS vezes_realizado
FROM servico s
INNER JOIN ordem_servico_servico oss
    ON s.id_servico = oss.id_servico
GROUP BY s.id_servico, s.descricao
ORDER BY vezes_realizado DESC;

-- 26) Quantidade de peças utilizadas
SELECT
    p.descricao,
    SUM(osp.quantidade) AS total_utilizada
FROM peca p
INNER JOIN ordem_servico_peca osp
    ON p.id_peca = osp.id_peca
GROUP BY p.id_peca, p.descricao
ORDER BY total_utilizada DESC;

-- 27) Clientes com mais de um veículo
SELECT
    c.nome,
    COUNT(v.id_veiculo) AS quantidade_veiculos
FROM cliente c
INNER JOIN veiculo v
    ON c.id_cliente = v.id_cliente
GROUP BY c.id_cliente, c.nome
HAVING COUNT(v.id_veiculo) > 1
ORDER BY quantidade_veiculos DESC;

-- 28) Clientes que abriram mais de uma ordem de serviço
SELECT
    c.nome,
    COUNT(os.id_ordem_servico) AS quantidade_ordens
FROM cliente c
INNER JOIN veiculo v
    ON c.id_cliente = v.id_cliente
INNER JOIN ordem_servico os
    ON v.id_veiculo = os.id_veiculo
GROUP BY c.id_cliente, c.nome
HAVING COUNT(os.id_ordem_servico) > 1
ORDER BY quantidade_ordens DESC;

-- 29) Serviços realizados mais de uma vez
SELECT
    s.descricao,
    COUNT(oss.id_servico) AS vezes_realizado
FROM servico s
INNER JOIN ordem_servico_servico oss
    ON s.id_servico = oss.id_servico
GROUP BY s.id_servico, s.descricao
HAVING COUNT(oss.id_servico) > 1
ORDER BY vezes_realizado DESC;

-- 30) Resumo completo da ordem de serviço
SELECT
    os.id_ordem_servico,
    c.nome AS cliente,
    v.placa,
    v.modelo,
    e.nome_equipe,
    os.data_emissao,
    os.status_os,
    os.valor_total
FROM ordem_servico os
INNER JOIN veiculo v
    ON os.id_veiculo = v.id_veiculo
INNER JOIN cliente c
    ON v.id_cliente = c.id_cliente
INNER JOIN equipe e
    ON os.id_equipe = e.id_equipe
ORDER BY os.id_ordem_servico;

-- 31) Ordens de serviço com pagamento e valor restante
SELECT
    os.id_ordem_servico,
    c.nome AS cliente,
    os.valor_total,
    p.forma_pagamento,
    p.status_pagamento,
    COALESCE(p.valor_pago, 0) AS valor_pago,
    (os.valor_total - COALESCE(p.valor_pago, 0)) AS valor_restante
FROM ordem_servico os
INNER JOIN veiculo v
    ON os.id_veiculo = v.id_veiculo
INNER JOIN cliente c
    ON v.id_cliente = c.id_cliente
LEFT JOIN pagamento p
    ON os.id_ordem_servico = p.id_ordem_servico
ORDER BY os.id_ordem_servico;

-- 32) Clientes, veículos e status da ordem
SELECT
    c.nome AS cliente,
    v.placa,
    v.modelo,
    os.status_os,
    os.data_emissao,
    os.valor_total
FROM cliente c
INNER JOIN veiculo v
    ON c.id_cliente = v.id_cliente
LEFT JOIN ordem_servico os
    ON v.id_veiculo = os.id_veiculo
ORDER BY c.nome, os.data_emissao;
