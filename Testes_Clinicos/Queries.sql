USE testesClinicos;
-- ****************** PROCEDURES ******************

-- Procedure para inserção de um novo Profissional de Saúde 
DELIMITER //
CREATE PROCEDURE inserePS( IN Nome VARCHAR(45),IN Data_Nascimento DATE,IN Rua VARCHAR(45),IN Codigo_Postal VARCHAR(10),IN Localidade VARCHAR(20),IN Especialidade INT)
	BEGIN 
			DECLARE lastId_PS INT;
            DECLARE Error BOOLEAN DEFAULT 0;
			DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET Error =1;
            START TRANSACTION;
			SET lastId_PS = (SELECT Id_PS FROM Profissional_de_Saude ORDER BY Id_PS DESC LIMIT 1);
            INSERT INTO Profissional_de_Saude(Id_PS,Nome,Data_Nascimento,Rua,Codigo_Postal,Localidade,Especialidade_Id_Especialidade) VALUES(lastId_PS+1,Nome,Data_Nascimento,Rua,Codigo_Postal,Localidade,Especialidade);
    
			IF Error=1
				THEN	
					BEGIN
					ROLLBACK;
					SELECT('Erro a introduzir os dados');
				END;
			ELSE COMMIT;
			END IF;
    END //
DELIMITER //


-- Procedure para inserção de um novo Atleta
DELIMITER // 
	CREATE PROCEDURE insereAtleta(IN CC INT,IN Nome VARCHAR(45),IN Nacionalidade VARCHAR(20),IN Telemóvel INT,IN Clube VARCHAR(50),IN Data_Nascimento DATE,IN Rua VARCHAR(45),IN Codigo_Postal VARCHAR(10),IN Localidade VARCHAR(20),IN Sexo VARCHAR(1))
		BEGIN
			DECLARE nCategoria INT DEFAULT 0;
            DECLARE nIdade INT DEFAULT 0;
			DECLARE Error BOOLEAN DEFAULT 0;
			DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET Error =1;
			START TRANSACTION;
            SET nIdade = idade(Data_Nascimento);
            
				IF (nIdade>=7 AND nIdade<=9) THEN SET nCategoria=1; END IF;
                IF (nIdade>=10 AND nIdade<=11) THEN SET nCategoria=2;END IF;
                IF (nIdade>=12 AND nIdade<=13) THEN SET nCategoria=3;END IF;
                IF (nIdade>=14 AND nIdade<=15) THEN SET nCategoria=4;END IF;
                IF (nIdade>=16 AND nIdade<=17) THEN SET nCategoria=5;END IF;
                IF (nIdade>=18 AND nIdade<=19) THEN SET nCategoria=6;END IF;
                IF (nIdade>=20 AND nIdade<=34) THEN SET nCategoria=7;END IF;
                IF (nIdade>=35) THEN SET nCategoria=8;END IF;
		
                
			INSERT INTO Atleta VALUES (CC,Nome,Nacionalidade,0,Telemóvel,Clube,Data_Nascimento,Rua,Codigo_Postal,Localidade,Sexo,nCategoria);
		IF Error=1
        THEN
			BEGIN
            ROLLBACK;
        SELECT('Erro a introduzir os dados');
      END;
		ELSE COMMIT;
        END IF;
        END //
DELIMITER //
	
-- Procedure que calcula o número total de testes clinicos realizados por um determinado profissional de saúde
DELIMITER //
	CREATE PROCEDURE nTestesPorMedico(IN idPS INT)
		BEGIN 
			SELECT COUNT(*) from Profissional_de_Saude AS PS
            JOIN Teste_Clinico as TC ON TC.PS_Id_PS
            WHERE PS.Id_PS=idPS AND TC.PS_Id_PS=idPS AND TC.Estado = 'Concluido';
		END //
DELIMITER //


-- Procedure que obtém os Testes Clinicos realizados por um dado profissional de saúde num dado dia
DELIMITER //
	CREATE PROCEDURE nTestesPorMedicoEData(IN idPS INT, IN data DATE)
		BEGIN 
			SELECT * from Teste_Clinico AS TC
            JOIN Profissional_de_Saude as PS ON TC.PS_Id_PS
            WHERE PS.Id_PS=idPS AND TC.PS_Id_PS=idPS AND DATE(TC.data_hora)=data AND TC.Estado = 'Concluido';
		END //
DELIMITER //

-- Procedure que apresenta os testes clinicos que um atleta tem marcados
DELIMITER //
	CREATE PROCEDURE mostraTestesPorRealizar(IN CC INT)
		BEGIN 
			SELECT * from Teste_Clinico AS TC
            JOIN Atleta as A ON A.CC=TC.Atleta_CC
            WHERE TC.Estado='Marcado' AND TC.Atleta_CC=CC;
		END //
DELIMITER //

-- Procedure que marca um teste clinico
DELIMITER //
	CREATE PROCEDURE MarcaTeste(IN CC INT, IN dataHora DATETIME, IN nPS INT)
		BEGIN 
			DECLARE lastId_Teste INT;
            DECLARE espec INT;
            DECLARE design VARCHAR(45);
			DECLARE Error BOOLEAN DEFAULT 0;
			 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET Error =1;
            
			 START TRANSACTION;
				
                SET espec = (SELECT Especialidade_Id_Especialidade FROM Profissional_de_Saude
												WHERE Id_PS=nPS);
			
                CASE espec
					WHEN 1 THEN SET design = 'Exame Oftalmológico';
                    WHEN 2 THEN SET design = 'Exame Ectoscópico';
                    WHEN 3 THEN SET design = 'Exame Biométrico';
                    WHEN 4 THEN SET design = 'Exame ORL';
                    WHEN 5 THEN SET design = 'Exame Estomatológico';
                    WHEN 6 THEN SET design = 'Exames Complementares de Diagnóstico';
                    WHEN 7 THEN SET design = 'Exame Génito-Urinário';
                    WHEN 8 THEN SET design = 'Exame Génito-Urinário';
                    WHEN 9 THEN SET design = 'Exame Cárdio-Circulatório e Respiratório';
                    ELSE SET design = '';
				END CASE;
                
                
				SET lastId_Teste = (SELECT Id_Teste FROM Teste_Clinico ORDER BY Id_Teste DESC LIMIT 1);
				INSERT INTO TESTE_CLINICO(Id_Teste,Designacao,data_hora,Estado,Atleta_CC,PS_Id_PS) VALUES
				(lastId_Teste+1,design,dataHora,'Marcado',CC,nPS);
             IF Error=1
        THEN
			 BEGIN
            ROLLBACK;
         SELECT('Não é possível agendar Teste Clinico: Possível sobreposição de datas');
      END;
		ELSE COMMIT;
		END IF;
        END //
DELIMITER //

 
-- Procedure que desmarca um teste clinico
DELIMITER //
	CREATE PROCEDURE DesmarcaTeste(IN CC INT, IN dataHora DATETIME)
		BEGIN 
			DECLARE Error BOOLEAN DEFAULT 0;
			DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET Error =1;
            START TRANSACTION; 
            
				UPDATE Teste_Clinico AS TC SET TC.Estado='Desmarcado'
				WHERE TC.Atleta_CC=CC AND TC.data_hora=dataHora;
        IF Error=1
        THEN
			BEGIN
            ROLLBACK;
        SELECT('Não é possível desmarcar Teste Clinico');
      END;
		ELSE COMMIT;
        END IF;
			END //
DELIMITER //

-- Procedure que remarca uma consulta
DELIMITER //
	CREATE PROCEDURE RemarcaTeste(IN CC INT, IN dataHora DATETIME,IN Nova_dataHora DATETIME)
		BEGIN 
			DECLARE profSaude INT;
        	DECLARE Error BOOLEAN DEFAULT 0;
			DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET Error =1;
            START TRANSACTION;
            
				SET profSaude= (SELECT PS_Id_PS FROM Teste_Clinico as TC
												WHERE TC.Atleta_CC=CC AND TC.data_hora=dataHora);
				CALL DesmarcaTeste(CC,dataHora);
				CALL MarcaTeste(CC,Nova_dataHora,profSaude);
		IF Error=1
        THEN
            ROLLBACK;
		ELSE COMMIT;
        END IF;
		END //
DELIMITER //

-- Procedure que inicia uma consulta
DELIMITER //
	CREATE PROCEDURE IniciaTeste(IN idTeste INT)
		BEGIN 
			
			DECLARE ndata DATETIME;
			DECLARE Error BOOLEAN DEFAULT 0;
			DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET Error =1;
            START TRANSACTION;
				
			  SET ndata = (SELECT data_hora FROM Teste_Clinico AS TC WHERE TC.Id_Teste=idTeste);
             
			IF(CURRENT_TIMESTAMP>TIME(ndata) AND CURRENT_TIMESTAMP<ADDTIME(TIME(ndata),"10:00")) THEN
			UPDATE Teste_Clinico AS TC 
            SET TC.Estado='A decorrer'
            WHERE TC.Id_Teste=idTeste;
            END IF;
            IF Error=1
			THEN
            ROLLBACK;
		ELSE COMMIT;
        END IF;
		END //
DELIMITER //

-- Procedure que conclui uma consulta
DELIMITER //
	CREATE PROCEDURE concluiTeste(IN idTeste INT, IN Descricao VARCHAR(45), IN Aptidao TINYINT)
		BEGIN 
			Declare CCid INT;
            Declare nEstado VARCHAR(20);
            DECLARE espec INT;
			DECLARE Error BOOLEAN DEFAULT 0;
			DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET Error =1;
            START TRANSACTION;
            
            SET espec = especialidadeTC(idTeste);
            
            SET CCid = (SELECT Atleta_CC FROM Teste_Clinico as TC 
					WHERE TC.Id_Teste=idTeste);
			
            SET nEstado = (SELECT Estado from Teste_Clinico AS TC
										 WHERE TC.Id_Teste=idTeste);
            IF( nEstado = 'A decorrer') THEN
            
            UPDATE Teste_Clinico AS TC
            SET TC.Preco = precoEspec(espec)
            WHERE TC.Id_Teste=idTeste;
            
            UPDATE Teste_Clinico AS TC
            SET TC.Aptidao = Aptidao
            WHERE TC.Id_Teste=idTeste;
            
            UPDATE Teste_Clinico AS TC 
            SET TC.Estado='Concluido'
            WHERE TC.Id_Teste=idTeste;
            
            UPDATE Teste_Clinico AS TC 
            SET TC.Descricao=Descricao
            WHERE TC.Id_Teste=idTeste;
            
			END IF;
            IF Error=1
        THEN
            ROLLBACK;
		ELSE COMMIT;
        END IF;
		END //
DELIMITER //

-- Procedure que apresenta a média de idades 
DELIMITER //
	CREATE PROCEDURE mediaIddTestes()
		BEGIN 
			SELECT AVG(idade(Data_Nascimento)) FROM Atleta AS A
            JOIN Teste_Clinico AS TC ON TC.Atleta_CC = A.CC;
        END //
DELIMITER // 

-- ****************** FUNCTIONS ******************

-- Função que calcula a percentagem de testes clinicos a atletas do sexo feminino
DELIMITER // 
	CREATE FUNCTION percentagemFEM() RETURNS DOUBLE
    DETERMINISTIC
		BEGIN 
			DECLARE total INT;
            DECLARE n INT;
            DECLARE percentagem DOUBLE;
            SET total = (SELECT COUNT(*) FROM Teste_Clinico AS TC WHERE TC.Estado='Concluido');
            SET n = (SELECT COUNT(*) FROM Teste_Clinico AS TC JOIN Atleta AS A ON TC.Atleta_CC=A.CC WHERE A.Sexo='F' AND TC.Estado='Concluido');
            SET percentagem = (n/total)*100;
			RETURN percentagem;
		END //
DELIMITER //
            

-- Função que calcula a percentagem de atletas de uma modalidade com aptidao física válida
DELIMITER //
CREATE FUNCTION percentagemValidoMod(modalidadeP INT) RETURNS DOUBLE
DETERMINISTIC
		BEGIN
				DECLARE total INT;
				DECLARE aprovados INT;
                DECLARE percentagem DOUBLE;
					SET total = (SELECT COUNT(*) FROM Atleta 
									JOIN Atleta_has_Modalidade AS AhM ON AhM.Atleta_CC=Atleta.CC 
										WHERE AhM.Modalidade_Id_Modalidade=modalidadeP);
					SET aprovados = (SELECT COUNT(*) FROM Atleta 
										JOIN Atleta_has_Modalidade AS AhM ON AhM.Atleta_CC=Atleta.CC 
											WHERE AhM.Modalidade_Id_Modalidade=modalidadeP AND Atleta.Aptidao = 1);
					SET percentagem = (aprovados/total)*100;
				RETURN percentagem;
		END//
DELIMITER // 

-- Funçao que verifica se existe alguma consulta marcada para o mesmo médico numa determinada data e hora ou num intervalo menor que 15min após essa data
DELIMITER // 
CREATE FUNCTION tempoValido(nData DATETIME, nMedico int) returns BOOLEAN
DETERMINISTIC
	BEGIN
		DECLARE res BOOLEAN DEFAULT 1;
        DECLARE num INT DEFAULT 0;
        SET num = (SELECT COUNT(*) FROM Teste_Clinico AS TC
		   WHERE TC.Ps_Id_PS=nMedico AND nData>=SUBTIME(TC.data_hora,TIME('00:14:59')) AND nData<=(ADDTIME(TC.data_hora,TIME('00:14:59'))) AND TC.Estado<>'Desmarcado' AND TC.Estado<>'Concluido');
		IF(num>0) THEN SET res=0;
        END IF;
	RETURN res;
END//
DELIMITER //


-- Função que calcula a idade a partir de um Date
DELIMITER // 
CREATE FUNCTION idade(dN DATE) RETURNS INT
DETERMINISTIC
	BEGIN 
		DECLARE ano INT;
        SET ano = TIMESTAMPDIFF(YEAR,dN,CURDATE());
        RETURN ano;
	END //
DELIMITER // 


-- Função que devolve o id do último teste de uma dada especialidade para um dado Atleta
DELIMITER // 
CREATE FUNCTION ultimoTesteEspecialidade(idEspecialidade INT,CCAtleta INT) RETURNS INT
DETERMINISTIC
	BEGIN 
		DECLARE res INT;
		SET res = (SELECT Id_Teste FROM Teste_Clinico AS TC
		JOIN Profissional_de_Saude AS PdS ON TC.PS_Id_PS=PdS.Id_PS
		WHERE PdS.Especialidade_Id_Especialidade=idEspecialidade AND TC.Atleta_CC = CCAtleta AND TC.Estado='Concluido'
		ORDER BY TC.data_hora DESC LIMIT 1);
		RETURN res;
	END //
DELIMITER //

-- Função que dado um id de um teste indica a aptidao obtida nesse teste
DELIMITER // 
CREATE FUNCTION aptTeste(idTeste INT) RETURNS INT
DETERMINISTIC
	BEGIN 
		DECLARE res INT;
		SET res = (SELECT Aptidao FROM Teste_Clinico AS TC WHERE TC.Id_Teste=idTeste);
		RETURN res;
	END //
DELIMITER //

-- Função que indica quantos testes de diferentes especialidades foram realizados por um dado atleta
DELIMITER // 
CREATE FUNCTION quantosTestes(idUtilizador INT) RETURNS INT
DETERMINISTIC
	BEGIN 
		DECLARE res INT DEFAULT 0;
		DECLARE id INT DEFAULT -1;
		SET id = ultimoTesteEspecialidade(1,idUtilizador);
         if(id IS NOT NULL ) THEN Set res = (res+1); END IF;
		SET id = ultimoTesteEspecialidade(2,idUtilizador);
         if(id IS NOT NULL) THEN Set res = (res+1); END IF;
		SET id = ultimoTesteEspecialidade(3,idUtilizador);
         if(id IS NOT NULL) THEN Set res = (res+1); END IF;
		SET id = ultimoTesteEspecialidade(4,idUtilizador);
         if(id IS NOT NULL) THEN Set res = (res+1); END IF;
		SET id = ultimoTesteEspecialidade(5,idUtilizador);
         if(id IS NOT NULL) THEN Set res = (res+1); END IF;
		SET id = ultimoTesteEspecialidade(6,idUtilizador);
         if(id IS NOT NULL) THEN Set res = (res+1); END IF;
		SET id = ultimoTesteEspecialidade(7,idUtilizador);
         if(id IS NOT NULL) THEN Set res = (res+1); END IF;
		SET id = ultimoTesteEspecialidade(8,idUtilizador);
         if(id IS NOT NULL) THEN Set res = (res+1); END IF;
		SET id = ultimoTesteEspecialidade(9,idUtilizador);
         if(id IS NOT NULL) THEN Set res = (res+1); END IF;
		RETURN RES;
	END //;
DELIMITER //
        
-- Funçao que indica o número de últimos testes realizados com a Aptidao a 0
DELIMITER // 
CREATE FUNCTION quantosTestesZero(idUtilizador INT) RETURNS INT
DETERMINISTIC
	BEGIN 
		DECLARE res INT DEFAULT 0;
        DECLARE id INT DEFAULT -1;
        SET id = ultimoTesteEspecialidade(1,idUtilizador);
         if(id IS NOT NULL AND (aptTeste(id)=0)) THEN Set res = (res+1); END IF;
         SET id = ultimoTesteEspecialidade(2,idUtilizador);
         if(id IS NOT NULL AND (aptTeste(id)=0)) THEN Set res = (res+1); END IF;
         SET id = ultimoTesteEspecialidade(3,idUtilizador);
         if(id IS NOT NULL AND (aptTeste(id)=0)) THEN Set res = (res+1); END IF;
         SET id = ultimoTesteEspecialidade(4,idUtilizador);
         if(id IS NOT NULL AND (aptTeste(id)=0)) THEN Set res = (res+1); END IF;
         SET id = ultimoTesteEspecialidade(5,idUtilizador);
         if(id IS NOT NULL AND (aptTeste(id)=0)) THEN Set res = (res+1); END IF;
         SET id = ultimoTesteEspecialidade(6,idUtilizador);
         if(id IS NOT NULL AND (aptTeste(id)=0)) THEN Set res = (res+1); END IF;
         SET id = ultimoTesteEspecialidade(7,idUtilizador);
         if(id IS NOT NULL AND (aptTeste(id)=0)) THEN Set res = (res+1); END IF;
         SET id = ultimoTesteEspecialidade(8,idUtilizador);
         if(id IS NOT NULL AND (aptTeste(id)=0)) THEN Set res = (res+1); END IF;
         SET id = ultimoTesteEspecialidade(9,idUtilizador);
         if(id IS NOT NULL AND (aptTeste(id)=0)) THEN Set res = (res+1); END IF;
	RETURN RES;
END //;
DELIMITER //

-- Função que indica a especialidade de um Teste Clinico
DELIMITER // 
CREATE FUNCTION especialidadeTC(idTeste INT) RETURNS INT
DETERMINISTIC
	BEGIN 
		DECLARE especialidade INT;
        SET especialidade = (SELECT Id_Especialidade FROM Especialidade AS E JOIN Profissional_de_Saude AS PS ON E.Id_Especialidade=PS.Especialidade_id_Especialidade JOIN Teste_Clinico AS TC ON TC.PS_id_PS=PS.Id_PS WHERE TC.Id_Teste=idTeste);
        RETURN especialidade;
    END //
DELIMITER //

-- Funcão que devolve o preço consoante a especialidade
DELIMITER // 
CREATE FUNCTION precoEspec(idEspec INT) RETURNS INT
DETERMINISTIC
	BEGIN 
    DECLARE nPreco INT;
			CASE idEspec
            WHEN 1 THEN SET nPreco=7.5;
            WHEN 2 THEN SET nPreco=7.5;
            WHEN 3 THEN SET nPRECO=5;
            WHEN 4 THEN SET nPRECO=7.5;
            WHEN 5 THEN SET nPRECO=7.5;
            WHEN 6 THEN SET nPRECO=7.5;
            WHEN 7 THEN SET nPRECO=5;
            WHEN 8 THEN SET nPRECO=5;
            WHEN 9 THEN SET nPRECO=5;
            else SET nPreco=0;
            END CASE;
            RETURN nPreco;
    END //
DELIMITER //

-- Função que indica o número de atletas de uma dada categoria
DELIMITER //
CREATE FUNCTION nAtletasCategoria(idCat INT) RETURNS INT
DETERMINISTIC
	BEGIN 
		DECLARE nAtleta INT DEFAULT 0; 
    
		SET nAtleta = (SELECT COUNT(*) FROM Atleta AS A WHERE A.Categoria_id_Categoria = idCat);
    
		RETURN nAtleta; 
    END //
DELIMITER //

-- ****************** TRIGGERS ******************

-- Trigger de controlo de inserção do sexo que nao seja M ou F - Atleta
DELIMITER //
		CREATE TRIGGER controlGenero BEFORE INSERT ON Atleta
        FOR EACH ROW 
        BEGIN 
			IF(new.Sexo<>'M' AND new.Sexo<>'F')
            THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Sexo introduzido Inválido';
			END IF;
		END //
DELIMITER //

-- Trigger de controlo para marcações de datas indisponiveis
DELIMITER //
CREATE TRIGGER controlData BEFORE INSERT ON Teste_Clinico
		FOR EACH ROW 
        BEGIN 
			IF(new.Estado<>'Concluido' AND new.data_hora<(CURRENT_TIMESTAMP) OR tempoValido(new.data_hora,new.PS_Id_PS)=0 )
            THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Data Indisponível';
			END IF;
		END //
DELIMITER //

-- Trigger que altera o estado de Aptidao de um Atleta consoante os resultados dos Testes Conluido após um update em Teste_Clinico
DELIMITER //
CREATE TRIGGER atualizaAptidaoU AFTER UPDATE ON Teste_Clinico
	FOR EACH ROW
		BEGIN
        IF(quantosTestes(new.Atleta_CC)=9 AND quantosTestesZero(new.Atleta_CC)=0) THEN UPDATE Atleta SET Atleta.Aptidao=1 WHERE Atleta.CC=new.Atleta_CC; END IF;
        IF(quantosTestes(new.Atleta_CC)<>9 OR quantosTestesZero(new.Atleta_CC)<>0) THEN UPDATE Atleta SET Atleta.Aptidao=0 WHERE Atleta.CC=new.Atleta_CC; END IF;
	END //
DELIMITER //

-- Trigger que altera o estado de Aptidao de um Atleta consoante os resultados dos Testes Conluido após um Insert em Teste_Clinico
DELIMITER //
CREATE TRIGGER atualizaAptidaoI AFTER INSERT ON Teste_Clinico
	FOR EACH ROW
		BEGIN
        IF(quantosTestes(new.Atleta_CC)=9 AND quantosTestesZero(new.Atleta_CC)=0) THEN UPDATE Atleta SET Atleta.Aptidao=1 WHERE Atleta.CC=new.Atleta_CC; END IF;
        IF(quantosTestes(new.Atleta_CC)<>9 OR quantosTestesZero(new.Atleta_CC)<>0) THEN UPDATE Atleta SET Atleta.Aptidao=0 WHERE Atleta.CC=new.Atleta_CC; END IF;
	END //
DELIMITER // 


DROP VIEW IF EXISTS aDecorrer;
CREATE VIEW aDecorrer AS 
	SELECT DISTINCT * FROM Teste_Clinico AS TC
					WHERE TC.Estado='A decorrer';


DROP VIEW IF EXISTS nAptosView;
CREATE VIEW nAptosView AS 
	SELECT DISTINCT Nome AS 'Nome',
                    idade(Data_Nascimento) AS 'Idade',
                    CC AS 'Nº Cartão de Cidadão'
                    FROM Atleta WHERE Aptidao=0;

				

















