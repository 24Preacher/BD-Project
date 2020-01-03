USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///atleta.csv" AS line
CREATE (a:Atleta {idAtleta: TOINTEGER(line.idAtleta),
Nome: line.Nome,
Escalao: line.Escalao,
Telemovel: TOINTEGER(line.Telemovel),
Email: line.Email,
idCategoria: TOINTEGER(line.Categoria_idCategoria)});

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///categoria.csv" AS line
CREATE (c:Categoria {idCategoria: TOINTEGER(line.idCategoria),
Nome: line.Nome,
idModalidade: TOINTEGER(line.Modalidade_idModalidade)});

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///modalidades.csv" AS line
CREATE (m:Modalidade {idModalidade: TOINTEGER(line.idModalidade),
Nome: line.Nome});

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///medico.csv" AS line
CREATE (med:Medico {idMedico: TOINTEGER(line.idMedico),
Nome: line.Nome,
Especialidade: line.Especialidade,
Reputacao: line.Reputacao});

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///consulta.csv" AS line
CREATE (con:Consulta {idConsulta: TOINTEGER(line.idConsulta),
Descricao: line.Descricao,
Horario: line.Horario,
Duracao: line.Duracao,
Custo: line.Custo,
Pago: TOINTEGER(line.pago),
idAtleta: TOINTEGER(line.Atleta_idAtleta),
idMedico: TOINTEGER(line.Medico_idMedico)});

CREATE CONSTRAINT ON (a:Atleta) ASSERT a.idAtleta IS UNIQUE;
CREATE CONSTRAINT ON (c:Categoria) ASSERT c.idCategoria IS UNIQUE;
CREATE CONSTRAINT ON (m:Modalidade) ASSERT m.idModalidade IS UNIQUE;
CREATE CONSTRAINT ON (med:Medico) ASSERT med.idMedico IS UNIQUE;
CREATE CONSTRAINT ON (con:Consulta) ASSERT con.idConsulta IS UNIQUE;


MATCH (a:Atleta),(c:Categoria)
WHERE a.idCategoria = c.idCategoria
CREATE(a)-[r:Participa]->(c);

MATCH (c:Categoria),(m:Modalidade)
WHERE c.Modalidade = m.idModalidade
CREATE(c)-[r:Pertence]->(m);

MATCH (a:Atleta),(con:Consulta)
WHERE a.idAtleta = con.idAtleta
CREATE(a)-[r:Recebe]->(con);

MATCH (med:Medico),(con:Consulta)
WHERE med.idMedico = con.idMedico
CREATE(med)-[r:Realiza]->(con);
