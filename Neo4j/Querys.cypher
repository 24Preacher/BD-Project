//1 - Procurar todos os atletas com consultas marcadas
MATCH (a:Atleta)-[r:Recebe]->(con:Consulta)
RETURN a.idAtleta

//2 - Procurar todas as consultas que foram pagas
Match (con:Consulta{Pago: 1})
Return con

//3 - Consulta mais lucrativa
MATCH (con:Consulta)
RETURN con
ORDER BY con.Custo
LIMIT 1

//4 - Médico com mais consultas dadas
MATCH(med:Medico)
WITH med, size((med)-[:Realiza]->()) as NrConsultas
RETURN med.Nome AS Nome, NrConsultas
ORDER BY NrConsultas DESC
LIMIT 1

//5 - Devolve o top 3 das modalidades com mais atletas
MATCH (a:Atleta)-[:Participa]->(c:Categoria)-[:Pertence]->(m:Modalidade)
WITH m, collect(a.Nome) AS atls
RETURN m.Nome AS Modalidades,  size(atls)
ORDER BY size(atls) DESC
LIMIT 3

//6 - Devolve a modalidade com mais categorias
MATCH(m:Modalidade)
WITH m, size(()-[:Pertence]->(m)) AS NrCategorias
RETURN m.Nome AS Nome, NrCategorias
ORDER BY NrCategorias DESC
LIMIT 1

//7 - Número total de consultas que existe
MATCH(con:Consulta)
RETURN count(*) AS NrConsultas

//8 - Atleta com mais consultas
MATCH(a:Atleta)
WITH a, size((a)-[:Recebe]->()) AS NrConsultas
RETURN a.Nome AS Nome, NrConsultas
ORDER BY NrConsultas DESC
LIMIT 1

//9 - Modalidade com mais consultas
MATCH (con:Consulta)<-[:Recebe]-(a:Atleta)-[:Participa]->(c:Categoria)-[:Pertence]->(m:Modalidade)
WITH m, collect(con.idConsulta) AS cons
RETURN m.Nome AS Modalidades,  size(cons)
ORDER BY size(cons) DESC
LIMIT 1
