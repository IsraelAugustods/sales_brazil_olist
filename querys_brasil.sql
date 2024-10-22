
-- Quantidade de clientes 
SELECT 
	COUNT(customer_unique_id) AS qtd_clientes_total
FROM 
	customers 

-- Quantidade de cliente por estado 
SELECT 
	customer_state,  
	COUNT(customer_unique_id) AS qtd_clientes_total
FROM 
	customers 
GROUP BY 
	customer_state 
ORDER BY 
	qtd_clientes_total DESC 

-- Quantidade de clientes por cidade 
SELECT 
	customer_city,  
	COUNT(customer_unique_id) AS qtd_clientes_total
FROM 
	customers 
GROUP BY 
	customer_city 
ORDER BY 
	qtd_clientes_total DESC 

-- Quantos clientes tiveram os seus pedidos entregues?
SELECT 
	o.order_status, 
	COUNT(customer_unique_id) AS qtd_clientes 
FROM 
	customers AS c
LEFT JOIN 
	orders  AS o 
ON 
	c.customer_id = o.customer_id
GROUP BY 
	o.order_status 
ORDER BY 
	qtd_clientes DESC 

-- Quantidade de pedidos 
SELECT 
	COUNT(DISTINCT order_id) AS  qtd_pedidos
FROM 
	orders 

-- Quantidade de pedidos por tipo de pagamento
SELECT 
	op.payment_type, 
	COUNT(o.order_id) AS qtd_pedidos 
FROM 
	orders o 
LEFT JOIN 
	order_payments op 
ON
	o.order_id  = op.order_id 
WHERE 
	op.payment_type IS NOT NULL 
GROUP BY
	op.payment_type 
ORDER BY 
	qtd_pedidos DESC 

-- Faturamento Total 
SELECT 
	SUM(oi.price) AS futaramento_total 
FROM 
	order_items oi 

-- Qual TOP 10 categorias de produtos mais vendido?
SELECT 
	p.product_category_name, 
	COUNT(o.order_id) AS vendas,
	ROUND (SUM(oi.price), 2) AS faturamento
FROM
	products AS p 
LEFT JOIN 
	order_items AS oi 
ON 
	p.product_id = oi.product_id 
LEFT JOIN 
	orders o 
ON 
	o.order_id  = oi.order_id 
WHERE 
	o.order_status = 'delivered'
GROUP BY 
	p.product_category_name
ORDER BY 
	vendas DESC
LIMIT 10 
	
-- Quais são as categorias de produto mais vendidas em cada mês?
WITH rankdata AS (
    SELECT 
        strftime('%m', o.order_approved_at) AS meses,
        p.product_category_name AS categorias_produtos,
        COUNT(o.order_id) AS qtd_vendida,
        ROW_NUMBER() OVER (
            PARTITION BY strftime('%m', o.order_approved_at) 
            ORDER BY COUNT(o.order_id) DESC
        ) AS rank
    FROM 
        products p
    LEFT JOIN 
        order_items oi 
    ON 
        p.product_id = oi.product_id
    LEFT JOIN 
        orders o 
    ON 
        oi.order_id = o.order_id
    WHERE 
        o.order_approved_at IS NOT NULL AND o.order_status = 'delivered'
    GROUP BY 
        meses, categorias_produtos
)
SELECT 
    meses, 
    categorias_produtos, 
    qtd_vendida
FROM 
    rankdata
WHERE 
    rank <= 3
ORDER BY 
    meses, qtd_vendida DESC 
  
 -- Qual é o ticket médio das compras por estado?    
SELECT 
	c.customer_state AS estado,
	COUNT( c.customer_unique_id) AS qtd_clientes,
	ROUND(SUM(oi.price) / COUNT(o.order_id), 2) AS ticket_medio
FROM 
	order_items oi 
LEFT JOIN  
	orders o 
ON 
	oi.order_id  = o.order_id 
LEFT JOIN 
	customers c 
ON	
	c.customer_id = o.customer_id
GROUP BY 
	estado 
ORDER BY 
	ticket_medio DESC        
	
-- Como a quantidade de parcelas afeta o valor total das vendas?
SELECT 
	op.payment_installments AS qtd_parcelas,
	SUM(oi.price) AS valor_vendas 
FROM
	order_payments op 
LEFT JOIN
	order_items oi 
ON	
	op.order_id = oi.order_id 
GROUP BY 
	qtd_parcelas  
ORDER BY
	valor_vendas DESC

-- Qual é o percentual de pedidos cancelados por categoria de produto?
 SELECT   
 	p.product_category_name  AS categoria_produto,
 	ROUND(COUNT(CASE WHEN o.order_status = 'canceled' THEN 1 END) * 100.0 / 
    COUNT(o.order_id), 1)  AS percentual_cancelados
 FROM
 	orders o 
 LEFT JOIN 
 	order_items oi 
 ON
 	o.order_id = oi.order_id  
 LEFT JOIN 
 	products p 
 ON 
 	p.product_id = oi.product_id  
 WHERE 
 	categoria_produto IS NOT NULL 
 GROUP BY 
 	categoria_produto
 ORDER BY 
 	percentual_cancelados DESC
 
-- Quais cidades têm a maior concentração de entregas atrasadas?
WITH entregas_atrasadas AS (
    SELECT 
        c.customer_city AS cidades,
        julianday(o.order_estimated_delivery_date) - julianday(o.order_delivered_customer_date) AS dias_de_atraso
    FROM 
        orders o 
    LEFT JOIN 
        customers c ON o.customer_id = c.customer_id
    WHERE
        o.order_estimated_delivery_date IS NOT NULL 
        AND o.order_delivered_customer_date IS NOT NULL 
        AND (julianday(o.order_estimated_delivery_date) - julianday(o.order_delivered_customer_date)) < 0
        AND c.customer_city IS NOT NULL
)
SELECT 
    cidades, 
    COUNT(*) AS total_entregas_atrasadas
FROM 
    entregas_atrasadas
GROUP BY 
    cidades
ORDER BY 
    total_entregas_atrasadas DESC
 LIMIT 10 

-- Como o peso e as dimensões dos produtos afetam o tempo de entrega, na média?
SELECT 
    CASE
        WHEN p.product_weight_g <= 1000 
             AND (p.product_length_cm + p.product_height_cm + p.product_width_cm) <= 60 
             AND p.product_length_cm <= 30 
             AND p.product_height_cm <= 30 
             AND p.product_width_cm <= 30 THEN 'Pequena' 
        WHEN p.product_weight_g > 1000 AND p.product_weight_g <= 5000
             AND (p.product_length_cm + p.product_height_cm + p.product_width_cm) BETWEEN 60 AND 150 
             AND p.product_length_cm <= 60 
             AND p.product_height_cm <= 60 
             AND p.product_width_cm <= 60 THEN 'Média'             
        WHEN p.product_weight_g > 5000 
             OR (p.product_length_cm + p.product_height_cm + p.product_width_cm) > 150 THEN 'Grande'
        ELSE 'Não categorizado'
	END AS tamanho_caixa, 
	ROUND(AVG(julianday(o.order_delivered_customer_date) - julianday(o.order_approved_at)), 2) AS tempo_entrega
	FROM
		products p 
	LEFT JOIN 
		order_items oi 
	ON 
		p.product_id = oi.product_id
	LEFT JOIN 
		orders o 
	ON
		oi.order_id = o.order_id 
	GROUP BY tamanho_caixa
	
-- Qual é a avaliação média por estado?
SELECT 
	c.customer_state,
	ROUND(AVG(or2.review_score), 2) AS avaliacao_media
FROM 
	order_reviews or2
LEFT JOIN
	orders o 
ON 
	or2.order_id = o.order_id 
LEFT JOIN 
	customers c
ON 
	o.customer_id = c.customer_id 
GROUP BY 
	c.customer_state
ORDER BY 
	avaliacao_media DESC 
-- 
	
-- Existe alguma correlação entre o número de fotos dos produtos e a avaliação dos clientes?
SELECT 
	CASE
		WHEN p.product_photos_qty <= 2 THEN 'Baixa Atratividade Visual'
		WHEN p.product_photos_qty > 2 AND p.product_photos_qty < 5 THEN 'Moderada Atratividade Visual'
		WHEN p.product_photos_qty >= 5 THEN 'Alta Atratividade Visual'
	END atratividade_visual,
	ROUND(AVG(or2.review_score), 2 ) AS avaliacao_media   
FROM
	products p
LEFT JOIN 
	order_items oi
ON 
	p.product_id = oi.product_id 
LEFT JOIN 
	order_reviews or2 
ON 
	or2.order_id = oi.order_id 
WHERE 
	p.product_photos_qty IS NOT NULL 
GROUP BY 
	atratividade_visual 

-- Quais categorias de produtos recebem mais avaliações negativas com comentários?	
SELECT 
	p.product_category_name AS cateogria_produtos, 
	COUNT(CASE 
            WHEN or2.review_score <= 2 AND or2.review_comment_message IS NOT NULL 
            THEN 1 
            ELSE NULL 
          END) AS avaliacao_negativa_comentarios
FROM 
	order_reviews or2 
LEFT JOIN 
	order_items oi 
ON
	or2.order_id = oi.order_id 
LEFT JOIN
	products p 
ON 
	p.product_id  = oi.product_id 
WHERE
	p.product_category_name IS NOT NULL 
GROUP BY 
	p.product_category_name
ORDER BY
	avaliacao_negativa_comentarios DESC 
LIMIT 10 

-- Conversão de Leads (%)
SELECT  
	ROUND(
        COUNT(DISTINCT lc.mql_id) * 100 / NULLIF(COUNT(DISTINCT lq.mql_id), 0), 2
    ) AS taxa_conversao_percentual
FROM 
	leads_qualified lq 
LEFT JOIN 
	leads_closed lc 
ON lq.mql_id = lc.mql_id 


