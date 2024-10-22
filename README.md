[![author](https://img.shields.io/badge/author-IsraelAugustods-red.svg)](https://www.linkedin.com/in/israelaugustoalmeida/) ![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)
# Analisando Dados de E-Commerce no Brasil — SQL

<p align="center">
  <img alt="brasil" width="60%" src="https://i.pinimg.com/1200x/ea/58/81/ea58811b723da3dfd2a74c395a071677.jpg">
</p>

## Objetivo do Projeto
Neste projeto, meu foco foi responder a diversas questões de negócios nas áreas de vendas, logística e satisfação do cliente, além de abordar aspectos gerais da operação. Busquei identificar padrões de comportamento dos consumidores e tendências de mercado para orientar decisões estratégicas. 

**Pode acessar o link abaixo para acessar as consultas que eu fiz nesse projeto:**
 - [**Consultas (Queries)**](https://github.com/IsraelAugustods/sales_brazil_olist/blob/main/querys_brasil.sql)

## Sobre o Projeto

Como um país de dimensão continental, o Brasil apresenta uma enorme variedade de produtos vendidos diariamente de forma online. Neste projeto, respondi a diversas questões de negócios em áreas como vendas, logística e satisfação do cliente, além de abordar aspectos gerais da operação. Para isso, conduzi uma análise dos dados de vendas de E-commerce no Brasil por meio de consultas em SQL.

SQL, ou Structured Query Language, é uma linguagem de programação amplamente utilizada para gerenciar, consultar e manipular bancos de dados relacionais. Nesse projeto, utilizei o SQL como a principal ferramenta para analisar e explorar os dados de vendas no Brasil, obtendo insights em diversas áreas. Além disso, empreguei o [DBeaver](https://dbeaver.io/), uma ferramenta robusta para gerenciar bancos de dados, facilitando a execução de consultas complexas e a visualização dos dados de forma organizada e eficiente.

## Fonte dos Dados
O banco de dados utilizado foi obtido no Kaggle e está disponível [aqui](https://www.kaggle.com/datasets/terencicp/e-commerce-dataset-by-olist-as-an-sqlite-database/data). Ele é uma junção de dois datasets: Brazilian E-Commerce Public Dataset by Olist e Marketing Funnel by Olist.

## Tecnologias Utilizadas
<p align="left">  
  <a href="https://dbeaver.io/" target="_blank" rel="noreferrer"> <img src="https://upload.wikimedia.org/wikipedia/commons/f/fd/DBeaver_logo.png" alt="DBeaver" width="40" height="40"/> </a> 
  <a href="https://pt.wikipedia.org/wiki/SQL" target="_blank" rel="noreferrer"> <img src="https://github.com/user-attachments/assets/fe035aba-261d-4a5b-b6c3-18f360db07cd" alt="sql" width="50" height="30"/> </a> 
</p> 

## Destaques do Projeto
### Como o peso e as dimensões dos produtos afetam o tempo de entrega, na média?

<p align="center">
  <img alt="r2" width="80%" src="https://miro.medium.com/v2/resize:fit:1400/format:webp/1*Iepn-WkTqrB0yVUEtVJNMg.png">
</p>

As caixas pequenas têm o menor tempo de entrega, levando em média 11,43 dias. Isso se deve ao seu tamanho compacto, que facilita o transporte. Por outro lado, as caixas grandes demoram mais, com uma média de 13,83 dias, o que reflete as dificuldades logísticas que envolvem o manuseio de produtos maiores e mais pesados.

<p align="center">
  <img alt="r1" width="40%" src="https://github.com/user-attachments/assets/f398ef7e-9cbf-4087-bcb4-bf873081981a">
</p>

### Número de Fotos e Avaliação

Será que existe alguma correlação entre o número de fotos dos produtos e a avaliação dos clientes?

<p align="center">
  <img alt="r3" width="80%" src="https://miro.medium.com/v2/resize:fit:1400/format:webp/1*H7GtSVvL6vB4mump-bSqkg.png">
</p>

Eu criei um ranking onde os produtos são classificados em três categorias de atratividade visual, baseando-se no número de fotos disponíveis: “Baixa Atratividade Visual” para produtos com até 2 fotos, “Moderada Atratividade Visual” para aqueles com mais de 2 e menos de 5 fotos, e “Alta Atratividade Visual” para produtos que possuem 5 ou mais fotos.

Os produtos classificados como “Alta Atratividade Visual” têm uma média de avaliação de 4.11, sugerindo que uma apresentação visual mais robusta e atraente está associada a uma maior satisfação do cliente. Em contrapartida, os produtos com “Baixa Atratividade Visual” apresentam uma avaliação média de 4.02, o que indica que menos fotos podem impactar negativamente a percepção dos consumidores.

Os produtos com “Moderada Atratividade Visual” obtêm uma média de 4.07, posicionando-se entre os extremos. Esses resultados sugerem que a quantidade das imagens dos produtos desempenham um papel significativo nas avaliações, reforçando a importância de uma boa apresentação visual para atrair e satisfazer os clientes.

### Conversão de Leads 

<p align="center">
  <img alt="r4" width="80%" src="https://miro.medium.com/v2/resize:fit:640/format:webp/1*JZfec6hEo1eoQbgioT5kSA.png">
</p>
Leads são potenciais clientes que demonstraram interesse em um produto ou serviço de uma empresa, geralmente fornecendo informações de contato, como e-mail ou telefone, em troca de algum conteúdo, oferta ou interação.

A taxa de conversão de leads de 10% significa que, em média, 10% dos leads que foi gerado se tornaram clientes efetivos. Por exemplo, se você tiver 100 leads, isso significa que 10 deles realizaram uma compra ou se tornaram clientes. Essa métrica é fundamental para entender a eficácia das estratégias de marketing e vendas de uma empresa, pois indica quão bem a equipe está convertendo interesse em vendas reais.

## Considerações Finais
Com o rápido crescimento do e-commerce no Brasil, entender profundamente as dinâmicas de vendas, comportamento do consumidor e os desafios logísticos se tornou vital para o sucesso das empresas. Este projeto de análise de dados do mercado brasileiro de e-commerce revela padrões, oferecendo insights práticos para otimizar operações e fortalecer a tomada de decisões estratégicas.

Um exemplo de insights é: A categoria Cama, Mesa e Banho lidera em volume de vendas, enquanto Beleza e Saúde registra o maior faturamento, sugerindo que o valor por item nessa categoria é mais elevado. Esse diferencial indica que focar em produtos de alto valor agregado pode ser uma excelente estratégia para aumentar o faturamento sem necessariamente aumentar o volume de vendas. Já a categoria Esporte e Lazer apresentou uma demanda estável ao longo do ano, mostrando o interesse contínuo por produtos voltados ao bem-estar. Campanhas direcionadas para esse nicho podem ser uma ótima maneira de manter esse segmento ativo e engajado.

Para mais insights e recomendações acesse meu projeto no Medium, clicando [aqui!](https://medium.com/@israelaugusto681/analisando-dados-de-e-commerce-no-brasil-sql-802ed04b1886).

## Contato
Estou sempre aberto para sugestões e melhorias do trabalho! 
**Links para me acharem:**
* [LinkedIn](https://www.linkedin.com/in/israelaugustoalmeida/)
* [GitHub](https://github.com/IsraelAugustods)
