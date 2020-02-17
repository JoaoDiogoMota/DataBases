USE testesclinicos;

/*
DROP DATABASE testesclinicos;
 SELECT * FROM Teste_Clinico;
 SELECT * FROM Atleta;
 SELECT * FROM Profissional_de_Saude;
 SELECT * FROM Modalidade;
 SELECT * FROM Categoria;
 SELECT * FROM Especialidade;
 SELECT * FROM Atleta_has_Modalidade;
 */
 
 

INSERT INTO  modalidade(Id_Modalidade,Designacao) VALUES
(1,'Corrida de Pista-100m'),
(2,'Corrida de Pista-200m'),
(3,'Corrida de Pista-400m'),
(4,'Corrida de Pista-800m'),
(5,'Corrida de Pista-1500m'),
(6,'Corrida de Obstáculos-100m'),
(7,'Corrida de Obstáculos-200m'),
(8,'Corrida de Obstáculos-2000m'),
(9,'Corrida de Estafetas-2000m'),
(10,'Salto em Comprimento'),
(11,'Salto em Altura'),
(12,'Lançamento de Peso'),
(13,'Lançamento de Dardo'),
(14,'Lançamento de Disco'),
(15,'Lançamento de Martelo');

INSERT INTO especialidade(Id_Especialidade,Designacao) VALUES
(1,'Oftalmologia'),
(2,'Dermatologia'),
(3,'Medicina Geral e Familiar'),
(4,'Otorrinolaringologia'),
(5,'Estomatologia'),
(6,'Radiologia'),
(7,'Urologia'),
(8,'Ginecologia-Obstetrícia'),
(9,'Cardiologia');

INSERT INTO Categoria(Id_Categoria,Designacao) VALUES
(1,'Benjamins A'),
(2,'Benjamins B'),
(3,'Infantis'),
(4,'Iniciados'),
(5,'Juvenis'),
(6,'Juniores'),
(7,'Seniores'),
(8,'Veteranos');

INSERT INTO Profissional_de_Saude(Id_PS,Nome,Data_Nascimento,Rua,Codigo_Postal,Localidade,Especialidade_Id_Especialidade) VALUES
(1,'António Ribeiro','1867/04/12','Rua do Capitão', '4710-409','Braga',7),
(2,'José Vieira','1964/10/23','Rua São Marco','4710-423','Braga',2),
(3,'Rita Santos','1986/03/07','Rua das Nogueiras',4800-036,'Guimarães',3),
(4,'Luís Medeiros','1969/07/30','Avenida Dos Soldados','4710-129','Braga',9),
(5,'Ana Meireles','1988/12/23','Rua de Teibães','4820-769','Fafe',8),
(6,'Rui Mota','1978/01/12','Travessa da Padaria','4000-784','Porto',5),
(7,'Isabel Pinto','1982/09/1','Rua do Capitão','4710-409','Braga',4),
(8,'Maria Pereira','1990/09/9','Rua das Flores','1000-112','Lisboa',1),
(9,'João Garcia','1973/03/28','Rua Ferreira Santos','4800-797','Guimarães',6),
(10,'Mariana Nobre','1985/06/13','Avenida da Grande Guerra','4760-219','Famalicão',3),
(11,'José Rangel','1957/04/15','Rua das Bicas','4000-811','Porto',9);

INSERT INTO Atleta(CC,Nome,Nacionalidade,Aptidao,Telemovel,Clube,Data_Nascimento,Rua,Codigo_Postal,Localidade,Sexo,Categoria_Id_Categoria) VALUES
(18492049,'Pedro Pimentel','Portuguesa','1','918499890','Sporting Clube de Braga','1996/04/01','Rua Candido Moreira','4710-420','Braga','M',7),
(17283940,'Hugo Silva','Portuguesa','0','918399841','Sporting Clube de Braga','2001/03/13','Rua São Marco','4710-423','Braga','M',6),
(29381940,'Nélson Silvestre','Angolana','1','968199332','Vitória Sport Clube','1995/11/25','Travessa dos Livros','4710-877','Braga','M',7),
(20391029,'Mariana Correira','Portugesa','1','938817283','Sporting Clube de Braga','2000/03/18','Rua das Macieiras','4800-324','Guimarães','F',6),
(17628398,'Félix Nogueira','Portuguesa','1','936527778','Clube de Atletismo de Fafe','1993/11/05','Rua Doutor Silva','4710-032','Braga','M',7),
(14649332,'Luísa Fonseca','Portuguesa','1','914563219','Sporting Clube de Braga','1995/04/25','Rua do Pomar','4800-776','Guimarães','F',7),
(12234987,'Roberto Caiado','Brasileira','0','935374563','Sporting Clube de Braga','1999/01/03','Rua General Gomes','4710-087','Braga','M',7),
(19898972,'Filipe Martins','Portuguesa','1','924235302','Sporting Clube de Braga','1998/09/22','Travessa da Terceira','4710-001','Braga','M',7),
(34008567,'Martim Ribeiro','Portuguesa','0','967821342','Vitória Sport Clube','1999/12/01','Travessa da Ribeirinha','4800-100','Guimarães','M',7),
(19444493,'Soraia Couto','Portuguesa','1','936782937','Sporting Clube de Braga','2006/06/08','Rua Ferreira Santos','4800-797','Guimarães','F',3),
(29481029,'Daniel Leal','Portuguesa','1','918493023','Sporting Clube de Braga','2005/11/12','Rua dos Anjos','4730-122','Vila Verde','M',4),
(19492039,'Catarina Alves','Portuguesa','1','918492009','Sport Lisboa e Benfica','2001/02/21','Rua Nova de Santa Cruz','4710-409','Braga','F',6),
(12398732,'Óscar Silva','Portuguesa','1','962892998','Sporting Clube de Braga','1987/07/28','Rua Da Chuva','4710-064','Braga','M',7),
(11982938,'Manuel Carvalho','Portuguesa','1','919929839','Sporting CLube de Braga','1982/02/12','Rua do Sol','4705-224','Aveleda','M',8),
(28293099,'Margarida Portugal','Portuguesa','1','933323564','Vitória Sport Clube','1995/12/31','Avenida dos Soldados','4710-129','Braga','F',7),
(46738200,'Gabriel Soares','Brasileira','1','962269974','Centro de Atletismo do Porto','1998/10/30','Avenida da Liberdade','4710-251','Braga','M',7),
(28918259,'Patrícia Ribeiro','Portuguesa','0','938877123','Sporting CLube de Braga','1991/05/06','Rua dos Amigos','4700-004','Palmeira','F',7),
(27782902,'Inês Ramalho','Portuguesa','1','961119229','Centro de Atletismo do Porto','1987/01/24','Rua dos Bombeiros','4710-556','Braga','F',7),
(19899758,'Jerónimo Cunha','Portuguesa','0','939918491','Vitória Sport Clube','1985/07/04','Rua Paricular Silva da Cunha','4800-111','Guimarães','M',7);

INSERT INTO Teste_Clinico(Id_Teste,Designacao,data_hora,Descricao,Estado,Aptidao,Preco,Atleta_CC,PS_Id_PS) VALUES
(1,'Exame Biométrico','2019/12/20 12:00:00','Valores normais','Concluido','1',null,18492049,3),
(2,'Exame Dermatologico','2019/12/20 13:00:00','Valores normais','Concluido','1',null,18492049,2),
(3,'Exame Oftalmologico','2019/12/20 13:30:00','Valores normais','Concluido','1',null,18492049,8),
(4,'Exame Urologico','2019/12/20 14:00:00','Valores normais','Concluido','1',null,18492049,1),
(5,'Exame Cardio-Circulatorio','2019/12/20 15:00:00','Valores normais','Concluido','1',null,18492049,4),
(6,'Exame Ginecologico','2019/12/20 15:30:00','Valores normais','Concluido','1',null,18492049,5),
(7,'Exame Estomatologico','2019/12/20 16:00:00','Valores normais','Concluido','1',null,18492049,6),
(8,'Exame ORL','2019/12/20 16:45:00','Valores normais','Concluido','1',null,18492049,7),
(9,'Exame radiologico','2019/12/20 15:00:00','Valores normais','Concluido','1',null,18492049,9),

(10,'Exame Urologico','2020/02/03 10:00:00',null,'Marcado',null,null,17283940,1),
(11,'Exame Dermatologico ','2020/02/03 10:30:00',null,'Marcado',null,null,17283940,2),
(12,'Exame Biométrico','2020/02/03 11:00:00',null,'Marcado',null,null,17283940,3),
(13,'Exame Cardio-Circulatorio','2020/02/03 11:30:00',null,'Marcado',null,null,17283940,4),
(14,'Exame Ginecologico','2020/02/03 14:00:00',null,'Marcado',null,null,17283940,5),
(15,'Exame Estomatologico','2020/02/03 15:00:00',null,'Marcado',null,null,17283940,6),
(16,'Exame ORL','2020/02/03 17:00:00',null,'Marcado',null,null,17283940,7),
(17,'Exame Oftalmologico','2020/02/04 11:00:00',null,'Marcado',null,null,17283940,8),
(18,'Exame Radiologico','2020/02/03 17:30:00',null,'Marcado',null,null,17283940,9),

(19,'Exame Biométrico','2019/10/10 12:16:00','Valores normais','Concluido','1',null,29381940,8),
(20,'Exame Dermatologico','2019/10/11 12:16:00','Valores normais','Concluido','1',null,29381940,2),
(21,'Exame Dermatologico','2019/10/12 12:16:00','Valores anormais','Concluido','0',null,29381940,2),
(22,'Exame Biométrico','2019/10/12 13:10:00','Valores normais','Concluido','1',null,29381940,3),
(23,'Exame ORL','2019/10/12 13:45:00','Valores normais','Concluido','1',null,29381940,7),
(24,'Exame Estomatologico','2019/10/15 12:16:00','Valores normais','Concluido','1',null,29381940,6),
(25,'Exame Radiologico','2019/10/15 17:10:00','Valores normais','Concluido','1',null,29381940,9),
(26,'Exame Urologico','2019/10/15 18:00:00','Valores normais','Concluido','1',null,29381940,1),
(27,'Exame Genito Urinario' ,'2019/10/15 18:45:00','Valores normais','Concluido','1',null,29381940,5),
(28,'Exame Cardio-Circulatorio','2019/10/15 19:15:00','Valores normais','Concluido','1',null,29381940,4),

(29,'Exame Urologico','2020/03/03 10:00:00',null,'Marcado',null,null,20391029,1),
(30,'Exame Dermatologico ','2020/03/03 10:30:00',null,'Marcado',null,null,20391029,2),
(31,'Exame Biométrico','2020/03/03 11:00:00',null,'Marcado',null,null,20391029,10),
(32,'Exame Cardio-Circulatorio','2020/03/03 11:30:00',null,'Marcado',null,null,20391029,11),
(33,'Exame Ginecologico','2020/03/03 14:00:00',null,'Marcado',null,null,20391029,5),
(34,'Exame Estomatologico','2020/03/03 15:00:00',null,'Marcado',null,null,20391029,6),
(35,'Exame ORL','2020/03/03 17:00:00',null,'Marcado',null,null,20391029,7),
(36,'Exame Oftalmologico','2020/03/04 11:00:00',null,'Marcado',null,null,20391029,8),
(37,'Exame Radiologico','2020/03/03 17:30:00',null,'Marcado',null,null,20391029,9),

(38,'Exame Urologico','2019/11/23 10:00:00','Valores Normais','Concluido','1',null,17628398,1),
(39,'Exame Dermatologico ','2020/03/20 10:30:00',null,'Marcado',null,null,17628398,2),
(40,'Exame Biométrico','2020/03/24 11:00:00',null,'Marcado',null,null,17628398,10),
(41,'Exame Cardio-Circulatorio','2019/11/23 11:30:00','Valores Normais','Concluido','1',null,17628398,11),
(42,'Exame Ginecologico','2020/11/23 14:00:00',null,'Marcado',null,null,17628398,5),
(43,'Exame Estomatologico','2020/03/25 15:00:00',null,'Marcado',null,null,17628398,6),
(44,'Exame ORL','2019/11/23 17:00:00','Valores Normais','Concluido','1',null,17628398,7),
(45,'Exame Oftalmologico','2019/11/23 11:00:00','Valores Normais','Concluido','1',null,17628398,8),
(46,'Exame Radiologico','2020/03/31 17:30:00',null,'Marcado',null,null,17628398,9),

(47,'Exame Biométrico','2019/09/10 12:16:00','Problema na vista','Concluido','0',null,14649332,8),
(48,'Exame Dermatologico','2019/09/11 12:16:00','Valores normais','Concluido','1',null,14649332,2),
(49,'Exame Dermatologico','2019/09/12 12:16:00','Valores Normais','Concluido','1',null,14649332,8),
(50,'Exame Biométrico','2019/09/12 13:10:00','Valores normais','Concluido','1',null,14649332,3),
(51,'Exame ORL','2019/09/12 13:45:00','Valores normais','Concluido','1',null,14649332,7),
(52,'Exame Estomatologico','2019/09/15 12:16:00','Valores normais','Concluido','1',null,14649332,6),
(53,'Exame Radiologico','2019/09/15 17:10:00','Valores normais','Concluido','1',null,14649332,9),
(54,'Exame Urologico','2019/09/15 18:00:00','Valores normais','Concluido','1',null,14649332,1),
(55,'Exame Genito Urinario' ,'2019/09/15 18:45:00','Valores normais','Concluido','1',null,14649332,5),
(56,'Exame Cardio-Circulatorio','2019/09/15 19:15:00','Valores normais','Concluido','1',null,14649332,4);

INSERT INTO Atleta_has_Modalidade(Atleta_CC, Modalidade_Id_Modalidade) VALUES
(18492049,1),
(18492049,2),
(18492049,3),
(18492049,4),
(17283940,12),
(20391029,12),
(17628398,12),
(14649332,4),
(14649332,5),
(20391029,2),
(12234987,14),
(12234987,15),
(19898972,10),
(34008567,15),
(19444493,1),
(19444493,2),
(19444493,3),
(29481029,9),
(29481029,10),
(19492039,7),
(12398732,15),
(12398732,13),
(11982938,4),
(11982938,5),
(28293099,14),
(28293099,15),
(27782902,1),
(27782902,2),
(27782902,3),
(19899758,15);














-- DROP DATABASE testesClinicos;


/*mostraTestesPorRealizar


DELETE FROM Profissional_de_Saude;



SELECT * FROM Atleta;



SELECT * FROM modalidade;

SELECT * FROM Profissional_de_Saude;

DROP TABLE Profissional_de_Saude;
*/
/*
SELECT * FROM TESTE_CLINICO;
SELECT * FROM Atleta
where CC = 18492049;
*/
 -- DROP database testesclinicos;

