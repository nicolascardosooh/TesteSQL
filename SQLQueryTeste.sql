-- 1. Consulta de Vendedores Ativos
SELECT id_vendedor, nome, salario
FROM vendedores
WHERE INativo = 1
ORDER BY nome ASC;

select * from vendedores
update vendedores set inativo = 1 where id in (1,2,4)
update vendedores set inativo = 0 where id in (3,5)

-- 2. Funcionários com Salário Acima da Média
SELECT id, nome, salario
FROM vendedores
WHERE salario > (SELECT AVG(salario) FROM vendedores)
ORDER BY salario DESC;

-- 3. Resumo por Cliente
SELECT c.id_cliente, c.razao_social, ISNULL(SUM(p.VALOR_TOTAL), 0) AS total
FROM clientes c
LEFT JOIN pedido p ON p.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.razao_social
ORDER BY total DESC;

select * from pedido
select * from clientes

-- 4. Situação por Pedido
SELECT id_pedido, valor_total, DATA_EMISSAO,
       CASE 
         WHEN data_cancelamento IS NOT NULL THEN 'CANCELADO'
         WHEN data_faturamento IS NOT NULL THEN 'FATURADO'
         ELSE 'PENDENTE'
       END AS situacao
FROM pedido;

-- 5. Produtos Mais Vendidos
SELECT TOP 1 IP.ID_PRODUTO, SUM(IP.QUANTIDADE) AS quantidade_vendida,
       SUM(IP.QUANTIDADE * IP.PRECO_PRATICADO) AS total_vendido,
       COUNT(DISTINCT IP.ID_PEDIDO) AS pedidos,
       COUNT(DISTINCT P.ID_CLIENTE) AS clientes
FROM ITENS_PEDIDO IP
JOIN PEDIDO P ON IP.ID_PEDIDO = P.ID_PEDIDO
GROUP BY IP.ID_PRODUTO
ORDER BY quantidade_vendida DESC, total_vendido DESC;
