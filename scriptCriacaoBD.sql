use BDspotPer

CREATE TABLE gravadora
(
	cod_gravadora smallint NOT NULL,
	nome nvarchar(50) NOT NULL,
	endereco nvarchar(50) NOT NULL,
	homepage nvarchar(50)

	CONSTRAINT gravadora_PK PRIMARY KEY (cod_gravadora),
) ON BDspotPer_fg01

CREATE TABLE telefone_gravadora
(
	cod_gravadora smallint NOT NULL,
	telefone nvarchar(50) NOT NULL,

	CONSTRAINT telefone_gravadora_FK_cod_gravadora FOREIGN KEY (cod_gravadora)
		REFERENCES gravadora (cod_gravadora) ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT telefone_gravadora_PK PRIMARY KEY (telefone, cod_gravadora),
) ON BDspotPer_fg01

CREATE TABLE album
(
	cod_album smallint NOT NULL,
	cod_gravadora smallint NOT NULL,
	descricao nvarchar(50) NOT NULL,
	pr_compra decimal(6,2) NOT NULL,
	dt_compra date NOT NULL,
	tipo_compra nvarchar(50) NOT NULL,
	dt_gravacao date NOT NULL,

	CONSTRAINT album_PK PRIMARY KEY (cod_album),
	CONSTRAINT album_FK_cod_gravadora FOREIGN KEY (cod_gravadora)
		REFERENCES gravadora (cod_gravadora) ON UPDATE CASCADE ON DELETE CASCADE,
) ON BDspotPer_fg01

CREATE TABLE composicao
(
	cod_composicao smallint NOT NULL,
	descricao nvarchar(50) NOT NULL, 

	CONSTRAINT composicao_PK PRIMARY KEY (cod_composicao),
) ON BDspotPer_fg01

CREATE TABLE faixa
(
	num_faixa smallint NOT NULL,
	tempo_execucao time NOT NULL,
	tipo_gravacao nvarchar(3) NOT NULL,
	descricao nvarchar(50) NOT NULL, 

	cod_album smallint NOT NULL,
	cod_composicao smallint NOT NULL,

	CONSTRAINT faixa_FK_cod_album FOREIGN KEY (cod_album)
		REFERENCES album ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT faixa_FK_cod_composicao FOREIGN KEY (cod_composicao) 
		REFERENCES composicao,

	CONSTRAINT faixa_PK PRIMARY KEY (cod_album, num_faixa),
) ON BDspotPer_fg02

CREATE TABLE interprete
(
	cod_interprete smallint NOT NULL,
	nome nvarchar(50) NOT NULL,
	tipo nvarchar(50) NOT NULL,

	CONSTRAINT interprete_PK PRIMARY KEY (cod_interprete),
) ON BDspotPer_fg01

CREATE TABLE faixa_interprete
(
	num_faixa smallint NOT NULL,
	cod_album smallint NOT NULL,
	cod_interprete smallint NOT NULL,

	CONSTRAINT faixa_interprete_FK_faixa FOREIGN KEY (cod_album, num_faixa)
		REFERENCES faixa ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT faixa_interprete_FK_cod_interprete FOREIGN KEY (cod_interprete)
		REFERENCES interprete (cod_interprete) ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT faixa_interprete_PK PRIMARY KEY (cod_interprete, cod_album, num_faixa),
) ON BDspotPer_fg01

CREATE TABLE periodoMsc
(
	cod_periodoMsc smallint NOT NULL,
	descricao nvarchar(50) NOT NULL,
	intervalo int NOT NULL,

	CONSTRAINT periodoMsc_PK PRIMARY KEY (cod_periodoMsc),
) ON BDspotPer_fg01

CREATE TABLE compositor
(
	cod_compositor smallint NOT NULL,
	cod_periodoMsc smallint NOT NULL,
	nome nvarchar(50) NOT NULL,
	cidade_nasc nvarchar(50) NOT NULL,
	pais_nasc nvarchar(50) NOT NULL,
	dt_nasc date NOT NULL,
	dt_morte date

	CONSTRAINT compositor_PK PRIMARY KEY (cod_compositor),
	CONSTRAINT compositor_FK_cod_periodoMsc FOREIGN KEY (cod_periodoMsc)
		REFERENCES periodoMsc (cod_periodoMsc),
) ON BDspotPer_fg01

CREATE TABLE faixa_compositor
(
	num_faixa smallint NOT NULL,
	cod_album smallint NOT NULL,
	cod_compositor smallint NOT NULL,

	CONSTRAINT faixa_compositor_FK_faixa FOREIGN KEY (cod_album, num_faixa)
		REFERENCES faixa ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT faixa_compositor_FK_cod_compositor FOREIGN KEY (cod_compositor)
		REFERENCES compositor (cod_compositor) ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT faixa_compositor_PK PRIMARY KEY (cod_compositor, cod_album, num_faixa),
) ON BDspotPer_fg01

CREATE TABLE playlist
(
	cod_playlist smallint IDENTITY (1, 1),
	nome nvarchar(50) NOT NULL,
	dt_criacao date NOT NULL,
	tempo_execucao time	NOT NULL,
	
	CONSTRAINT playlist_PK PRIMARY KEY (cod_playlist),
) ON BDspotPer_fg02

CREATE TABLE playlist_faixa
(
	cod_playlist smallint NOT NULL,
	num_faixa smallint NOT NULL,
	cod_album smallint NOT NULL,
	dt_ultexecucao date,
	num_execucao int default 0
	
	CONSTRAINT playlist_faixa_FK_cod_playlist FOREIGN KEY (cod_playlist)
		REFERENCES playlist (cod_playlist) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT playlist_faixa_FK_cod_faixa FOREIGN KEY (cod_album, num_faixa)
		REFERENCES faixa ON UPDATE CASCADE ON DELETE CASCADE,

	CONSTRAINT playlist_faixa_PK PRIMARY KEY (cod_album, num_faixa, cod_playlist),
) ON BDspotPer_fg02