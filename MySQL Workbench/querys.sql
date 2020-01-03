USE cleinics;


-- Procurar todos os atletas com consultas marcadas
select a.nome, a.escalao 
from atleta a
inner join consulta c 
on a.idAtleta = c.Atleta_idAtleta;

-- Procurar todas as consultas que foram pagas
select a.nome, a.escalao, c.custo, c.descrição
from atleta a
inner join consulta c
on a.idAtleta = c.Atleta_idAtleta 
and c.pago = 1;

-- Consulta mais lucrativa
select c.custo, c.pago, m.Nome, m.Especialidade, m.Reputação
from consulta c
inner join medico m
on c.Medico_idMedico = m.idMedico
order by c.custo desc
limit 1;

-- Médico com mais consultas dadas 
select count(*), m.nome, m.especialidade, m.reputação
from consulta c
inner join medico m
on c.Medico_idMedico = m.idMedico
group by c.Medico_idMedico
limit 1;

-- Devolve o top 3 das modalidades com mais atletas
select count(*), m.modalidade
from categoria c
inner join modalidades m
on c.Modalidades_idModalidades = m.idModalidades
inner join atleta a 
on c.idCategoria = a.Categoria_idCategoria
group by m.modalidade
limit 3;

