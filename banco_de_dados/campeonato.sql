CREATE DATABASE campeonato;
USE campeonato;

CREATE TABLE IF NOT EXISTS  `time` (
  `idTime` INT NOT NULL ,
  `nome` VARCHAR(45) NOT NULL,
  `urlFoto` VARCHAR(45) NULL ,
  PRIMARY KEY (`idTime`) )
;

CREATE TABLE IF NOT EXISTS `jogador` (
  `idJogador` INT NOT NULL ,
  `nome` VARCHAR(45) NOT NULL ,
  `email` VARCHAR(45) NOT NULL ,
  `senha` VARCHAR(45) NOT NULL ,
  `nivelHabilidade` INT NULL DEFAULT 0 ,
  `urlFoto` VARCHAR(45) NULL ,
  PRIMARY KEY (`idJogador`) )
;

CREATE TABLE IF NOT EXISTS  `campeonato` (
  `idCampeonato` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL ,
  `dataInicio` DATE NULL ,
  `dataFim` DATE NULL ,
  `qtdTimes` INT NULL,
  `urlFoto` VARCHAR(45) NULL ,
  PRIMARY KEY (`idCampeonato`) )
;

CREATE TABLE IF NOT EXISTS `Partida` (
  `idPartida` INT NOT NULL ,
  `idCampeonato` INT NULL ,
  `idTime1` INT NULL ,
  `idTime2` INT NULL ,
  `golTime1` INT NULL DEFAULT 0 ,
  `golTime2` INT NULL DEFAULT 0 ,
  PRIMARY KEY (`idPartida`)  ,
  INDEX `fk_Partida_Time1_idx` (`idTime1` ASC)  COMMENT '',
  INDEX `fk_Partida_Campeonato1_idx` (`idCampeonato` ASC)  COMMENT '',
  CONSTRAINT `fk_Partida_Time1`
    FOREIGN KEY (`idTime1`)
    REFERENCES `time` (`idTime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Partida_Campeonato1`
    FOREIGN KEY (`idCampeonato`)
    REFERENCES `campeonato` (`idCampeonato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE TABLE IF NOT EXISTS `participacao` (
  `Jogador_idJogador` INT NOT NULL ,
  `Time_idTime` INT NOT NULL ,
  `Campeonato_idCampeonato` INT NOT NULL ,
  `numeroCamisa` INT NULL ,
  `posicao` VARCHAR(45) NULL ,
  PRIMARY KEY (`Jogador_idJogador`, `Time_idTime`, `Campeonato_idCampeonato`)  ,
  INDEX `fk_Jogador_has_Time_Time1_idx` (`Time_idTime` ASC)  ,
  INDEX `fk_Jogador_has_Time_Jogador1_idx` (`Jogador_idJogador` ASC)  ,
  INDEX `fk_JogadorTime_Campeonato1_idx` (`Campeonato_idCampeonato` ASC)  ,
  CONSTRAINT `fk_Jogador_has_Time_Jogador1`
    FOREIGN KEY (`Jogador_idJogador`)
    REFERENCES `jogador` (`idJogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Jogador_has_Time_Time1`
    FOREIGN KEY (`Time_idTime`)
    REFERENCES `time` (`idTime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_JogadorTime_Campeonato1`
    FOREIGN KEY (`Campeonato_idCampeonato`)
    REFERENCES `campeonato` (`idCampeonato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


CREATE TABLE IF NOT EXISTS `jogadorEventos` (
  `Jogador_idJogador` INT NOT NULL ,
  `Partida_idPartida` INT NOT NULL,
  `gols` INT NULL DEFAULT 0 ,
  `faltasCometidas` INT NULL DEFAULT 0 ,
  `faltasSofridas` INT NULL DEFAULT 0 ,
  `cartaoAmarelo` INT NULL DEFAULT 0 ,
  `cartaoVermelho` INT NULL DEFAULT 0 ,
  INDEX `fk_Jogador_has_Partida_Partida1_idx` (`Partida_idPartida` ASC)  ,
  INDEX `fk_Jogador_has_Partida_Jogador1_idx` (`Jogador_idJogador` ASC)  ,
  PRIMARY KEY (`Jogador_idJogador`, `Partida_idPartida`) ,
  CONSTRAINT `fk_Jogador_has_Partida_Jogador1`
    FOREIGN KEY (`Jogador_idJogador`)
    REFERENCES `jogador` (`idJogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Jogador_has_Partida_Partida1`
    FOREIGN KEY (`Partida_idPartida`)
    REFERENCES `partida` (`idPartida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


CREATE TABLE IF NOT EXISTS `evento` (
  `idEvento` INT NOT NULL ,
  `data` DATE NULL ,
  `hora` VARCHAR(45) NULL ,
  PRIMARY KEY (`idEvento`)  )
;

CREATE TABLE IF NOT EXISTS `presenca` (
  `Evento_idEvento` INT NOT NULL ,
  `Jogador_idJogador` INT NOT NULL ,
  PRIMARY KEY (`Evento_idEvento`, `Jogador_idJogador`)  ,
  INDEX `fk_Evento_has_Jogador_Jogador1_idx` (`Jogador_idJogador` ASC)  ,
  INDEX `fk_Evento_has_Jogador_Evento1_idx` (`Evento_idEvento` ASC)  ,
  CONSTRAINT `fk_Evento_has_Jogador_Evento1`
    FOREIGN KEY (`Evento_idEvento`)
    REFERENCES `evento` (`idEvento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Evento_has_Jogador_Jogador1`
    FOREIGN KEY (`Jogador_idJogador`)
    REFERENCES `jogador` (`idJogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

