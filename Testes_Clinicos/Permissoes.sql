use testesclinicos;
DROP USER IF EXISTS 'Profissional_de_Saude'@'localhost';
CREATE USER 'Profissional_de_Saude'@'localhost' IDENTIFIED BY '0000';
GRANT EXECUTE ON PROCEDURE testesclinicos.concluiTeste TO 'Profissional_de_Saude'@'localhost';
GRANT EXECUTE ON PROCEDURE testesclinicos.DesmarcaTeste TO 'Profissional_de_Saude'@'localhost';
GRANT EXECUTE ON PROCEDURE testesclinicos.IniciaTeste TO 'Profissional_de_Saude'@'localhost';
GRANT EXECUTE ON PROCEDURE testesclinicos.MarcaTeste TO 'Profissional_de_Saude'@'localhost';
GRANT EXECUTE ON PROCEDURE testesclinicos.RemarcaTeste TO 'Profissional_de_Saude'@'localhost';
GRANT SHOW VIEW ON testesclinicos.naptosview TO 'Profissional_de_Saude'@'localhost';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'Profissional_de_Saude'@'localhost';

