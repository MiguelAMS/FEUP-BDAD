.mode columns
.headers on    
.nullvalue NULL

DROP TABLE IF EXISTS Ciclista;
CREATE TABLE Ciclista(
	idCiclista INTEGER,
	nome VARCHAR2(64) NOT NULL,
	idade INTEGER CHECK (idade >= 18),
	nacionalidade VARCHAR2(32) NOT NULL,
	tempoClassGeral TIME,
	pntsMontanha INTEGER,
	pntsSprint Integer,
	estilo VARCHAR2(32) CHECK (estilo = 'trepador' OR estilo = 'sprinter' OR estilo = 'contrarrelogista' OR estilo = 'gregário' OR estilo = 'passista'),
	equipa INTEGER REFERENCES Equipa(idEquipa),
	CONSTRAINT ciclista_pk PRIMARY KEY(idCiclista)
);



DROP TABLE IF EXISTS Mecanico;
CREATE TABLE Mecanico(
	idMecanico INTEGER,
	nome VARCHAR2(64) NOT NULL,
	idade INTEGER CHECK (idade >= 18),
	nacionalidade VARCHAR2(32) NOT NULL,
	CONSTRAINT mecanico_pk PRIMARY KEY(idMecanico)
);


DROP TABLE IF EXISTS Equipa;
CREATE TABLE Equipa(
	idEquipa INTEGER,
	nome VARCHAR2(64) NOT NULL,
	mecanico Integer REFERENCES Mecanico(idMecanico),
	CONSTRAINT equipa_pk PRIMARY KEY(idEquipa)
);


DROP TABLE IF EXISTS Patrocinador;
CREATE TABLE Patrocinador(
	idPatrocinador INTEGER,
	nome VARCHAR2(64) NOT NULL,
	CONSTRAINT patrociandor_pk PRIMARY KEY(idPatrocinador)
);

DROP TABLE IF EXISTS Condicao;
CREATE TABLE Condicao(
	idCondicao INTEGER,
	posicaoMin Integer CHECK (posicaoMin >0),
	CONSTRAINT condicao_pk PRIMARY KEY(idCondicao)
);

DROP TABLE IF EXISTS Premio;
CREATE TABLE Premio(
	patrocinador INTEGER REFERENCES Patrocinador(idPatrocinador),
	equipa INTEGER REFERENCES Equipa(idEquipa),
	condicao INTEGER REFERENCES Condicao(idCondicao),
	quantia Integer CHECK (quantia > 0),
	CONSTRAINT premio_pk PRIMARY KEY (patrocinador,equipa,condicao)
);

DROP TABLE IF EXISTS Etapa;
CREATE TABLE Etapa(
	idEtapa Integer,
	nome VARCHAR2(64) NOT NULL,
	distancia NUMBER(3,1) CHECK (distancia > 0),
	pntsMontanha INTEGER,
	pntsSprint INTEGER,
	CONSTRAINT etapa_pk PRIMARY KEY (idEtapa)
);

DROP TABLE IF EXISTS Resultado;
CREATE TABLE Resultado(
	ciclista INTEGER REFERENCES Ciclista(idCiclista),
	etapa INTEGER REFERENCES Etapa(idEtapa),
	posicao Integer CHECK (posicao > 0),
	tempo TIME,
	pntsMontanha INTEGER,
	pntsSprint INTEGER,
	CONSTRAINT resultado_pk PRIMARY KEY (ciclista,etapa)
);

DROP TABLE IF EXISTS Contrato;
CREATE TABLE Contrato(
	patrocinador INTEGER REFERENCES Patrocinador(idPatrocinador),
	equipa INTEGER REFERENCES Equipa(idEquipa),
	condicao INTEGER REFERENCES Condicao(idCondicao),
	CONSTRAINT contrato_pk PRIMARY KEY (patrocinador, equipa, condicao)
);

DROP TABLE IF EXISTS Marca;
CREATE TABLE Marca(
	idMarca INTEGER,
	nome VARCHAR2(62) NOT NULL,
	CONSTRAINT marca_pk PRIMARY KEY (idMarca)
);

DROP TABLE IF EXISTS Modelo;
CREATE TABLE Modelo(
	idModelo INTEGER,
	nome VARCHAR2(62) NOT NULL,
	marca INTEGER REFERENCES Marca(idMarca),
	CONSTRAINT modelo_pk PRIMARY KEY (idModelo)
);

DROP TABLE IF EXISTS Bicicleta;
CREATE TABLE Bicicleta(
	idBicicleta INTEGER,
	idCiclista INTEGER REFERENCES Ciclista(idCiclista),
	modelo INTEGER REFERENCES Modelo(idModelo),
	CONSTRAINT bicicleta_pk PRIMARY KEY (idBicicleta)
);

DROP TABLE IF EXISTS Reparacao;
CREATE TABLE Reparacao(
	idReparacao INTEGER,
	tipo VARCHAR2(62) NOT NULL,
	dataHora DATE,
	mecanico INTEGER REFERENCES Mecanico(idMecanico),
	bicicleta INTEGER REFERENCES Bicicleta(idBicicleta),
	etapa INTEGER REFERENCES Etapa(idEtapa),
	CONSTRAINT reparacao_pk PRIMARY KEY (idReparacao)
);

DROP TABLE IF EXISTS Peca;
CREATE TABLE Peca(
	idPeca INTEGER,
	tipo VARCHAR2(62) NOT NULL,
	reparacao INTEGER REFERENCES Reparacao(idReparacao),
	CONSTRAINT peca_pk PRIMARY KEY (idPeca)
);
