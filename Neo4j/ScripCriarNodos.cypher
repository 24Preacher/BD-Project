//Unificar ID Atletas

CREATE CONSTRAINT ON (a:Atleta) ASSERT a.idAtleta IS UNIQUE;

//Import Atletas
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///atleta.csv" AS line
CREATE (a:Atleta {idAtleta: TOINTEGER(line.idAtleta),
Nome: line.Nome,
Escalao: line.Escalao,
Telemovel: TOINTEGER(line.Telemovel),
Email: line.Email,
idCategoria: TOINTEGER(line.Categoria_idCategoria)});

//Unificar ID Categorias

CREATE CONSTRAINT ON (c:Categoria) ASSERT c.idCategoria IS UNIQUE;

//Import Catogorias

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///categoria.csv" AS line
CREATE (c:Categoria {idCategoria: TOINTEGER(line.idCategoria),
Nome: line.Nome,
idModalidades: TOINTEGER(line.Modalidades_idModalidades)});

//Unificar ID Modalidades

CREATE CONSTRAINT ON (m:Modalidade) ASSERT m.idModalidades IS UNIQUE;

//Import Modalidades
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///modalidades.csv" AS line
CREATE (m:Modalidade {idModalidades: TOINTEGER(line.idModalidades),
Nome: line.Nome});

//Unificar ID Medicos

CREATE CONSTRAINT ON (med:Medico) ASSERT med.idMedico IS UNIQUE;

//Import Medicos
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///medico.csv" AS line
CREATE (med:Medico {idMedico: TOINTEGER(line.idMedico),
Nome: line.Nome,
Especialidade: line.Especialidade,
Reputacao: line.Reputacao});

//Unificar ID Consultas

CREATE CONSTRAINT ON (con:Consulta) ASSERT con.idConsulta IS UNIQUE;

//Import Consultas
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///consulta.csv" AS line
CREATE (con:Consulta {idConsulta: TOINTEGER(line.idConsulta),
Descricao: line.Descricao,
Horario: line.Horario,
Duracao: line.Duracao,
Custo: line.Custo,
Pago: line.Pago,
idAtleta: TOINTEGER(line.Atleta_idAtleta),
idMedico: TOINTEGER(line.Medico_idMedico)});

//Relação Atleta/Categoria
MATCH (a:Atleta),(c:Categoria)
WHERE a.idCategoria = c.idCategoria
CREATE(a)-[r:Participa]->(c);

//Relação Categoria/Modalidade
MATCH (c:Categoria),(m:Modalidade)
WHERE c.idModalidades = m.idModalidades
CREATE(c)-[r:Pertence]->(m);

//Relação Atleta/Consulta
MATCH (a:Atleta),(con:Consulta)
WHERE a.idAtleta = con.idAtleta
CREATE(a)-[r:Recebe]->(con);

//Relação Medico/Consulta
MATCH (med:Medico),(con:Consulta)
WHERE med.idMedico = con.idMedico
CREATE(med)-[r:Realiza]->(con);
