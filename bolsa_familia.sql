

-- Criar tabela principal com as colunas do csv
CREATE TABLE bolsa_familia_pagamentos (
    mes_competencia VARCHAR(10),
    mes_referencia VARCHAR(10),
    uf VARCHAR(2),
    codigo_municipio VARCHAR(15),
    nome_municipio VARCHAR(100),
    cpf_favorecido VARCHAR(14),
    nis_beneficiario VARCHAR(11),
    nome_beneficiario VARCHAR(100),
    valor_parcela VARCHAR(50)
);

-- Importar dados do arquivo CSV completo
COPY bolsa_familia_pagamentos
FROM '/tmp/arquivoComNovaCodificacao.csv'
USING DELIMITERS ';' CSV HEADER;

-- Criar tabela de municípios (apenas com dados únicos)
CREATE TABLE municipios (
    codigo_municipio VARCHAR(15) PRIMARY KEY,
    nome_municipio VARCHAR(100),
    uf VARCHAR(2)
);

-- popular tabela de municípios a partir dos dados importados
INSERT INTO municipios (codigo_municipio, nome_municipio, uf)
SELECT DISTINCT codigo_municipio, nome_municipio, uf
FROM bolsa_familia_pagamentos;

select * from bolsa_familia_pagamentos;

-- contar registros
SELECT COUNT(*) AS total_registros FROM bolsa_familia_pagamentos;
SELECT COUNT(*) AS total_municipios FROM municipios;

-- consulta sem índice entre as duas tabelas

EXPLAIN ANALYSE -- comando que utilizamos para mostrar a performance da consulta. ex: time, time execução e o total
SELECT b.nome_beneficiario, b.nis_beneficiario, m.nome_municipio, m.uf,
COUNT(*) as total_pagamentos
FROM bolsa_familia_pagamentos b
JOIN municipios m ON b.codigo_municipio = m.codigo_municipio
WHERE m.uf = 'SP'
GROUP BY b.nome_beneficiario, b.nis_beneficiario, m.nome_municipio, m.uf;

-- criar índices
CREATE INDEX idx_bolsa_municipio ON bolsa_familia_pagamentos(codigo_municipio); -- encontra rapidamente os pagamentos para cada município
CREATE INDEX idx_municipios_codigo ON municipios(codigo_municipio); -- acelera o acesso aos municípios filtrados
CREATE INDEX idx_municipios_uf ON municipios(uf); -- localiza rapidamente municípios de SP

-- consulta COM índice
EXPLAIN ANALYSE
SELECT b.nome_beneficiario, b.nis_beneficiario, m.nome_municipio, m.uf,
COUNT(*) as total_pagamentos
FROM bolsa_familia_pagamentos b
JOIN municipios m ON b.codigo_municipio = m.codigo_municipio
WHERE m.uf = 'SP'
GROUP BY b.nome_beneficiario, b.nis_beneficiario, m.nome_municipio, m.uf;

-- consulta: Top municípios por valor total 
EXPLAIN ANALYSE
SELECT m.nome_municipio, m.uf,
COUNT(*) as total_pagamentos,
SUM(CAST(REPLACE(b.valor_parcela, ',', '.') AS DECIMAL(10,2))) as valor_total
FROM bolsa_familia_pagamentos b
JOIN municipios m ON b.codigo_municipio = m.codigo_municipio
GROUP BY m.nome_municipio, m.uf
ORDER BY valor_total DESC
LIMIT 10;




