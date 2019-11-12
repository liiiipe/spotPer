CREATE DATABASE spotPer

use spotPer

CREATE TABLE album -- (i)
(
	cod_album smallint NOT NULL,
	cod_gravadora smallint NOT NULL,
	descricao nvarchar(50) NOT NULL,
	pr_compra decimal(6,2) NOT NULL,
	dt_compra date NOT NULL,
	tipo_compra nvarchar(50) NOT NULL,
	dt_gravacao date NOT NULL,

	CONSTRAINT album_PK PRIMARY KEY (cod_album),
)


CREATE TABLE faixa -- (ii)
(
	cod_faixa smallint NOT NULL,
	num_faixa smallint NOT NULL,
	tempo_execucao time NOT NULL,
	tipo_gravacao nvarchar(3) NOT NULL,
	descricao nvarchar(50) NOT NULL, 

	cod_album smallint NOT NULL,
	cod_composicao smallint NOT NULL,

	CONSTRAINT faixa_PK PRIMARY KEY (cod_faixa),
)

CREATE TABLE composicao -- (iii)
(
	cod_composicao smallint NOT NULL,
	descricao nvarchar(50) NOT NULL, 

	CONSTRAINT composicao_PK PRIMARY KEY (cod_composicao),
)

CREATE TABLE interprete -- (iv)
(
	cod_interprete smallint NOT NULL,
	nome nvarchar(50) NOT NULL,
	tipo nvarchar(50) NOT NULL,

	CONSTRAINT interprete_PK PRIMARY KEY (cod_interprete),
)

CREATE TABLE faixa_interprete
(
	cod_faixa smallint NOT NULL,
	cod_interprete smallint NOT NULL,

	CONSTRAINT faixa_interprete_FK_cod_faixa FOREIGN KEY (cod_faixa)
		REFERENCES faixa (cod_faixa) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT faixa_interprete_FK_cod_interprete FOREIGN KEY (cod_interprete)
		REFERENCES interprete (cod_interprete) ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE compositor -- (v)
(
	cod_compositor smallint NOT NULL,
	nome nvarchar(50) NOT NULL,
	cidade_nasc nvarchar(50) NOT NULL,
	pais_nasc nvarchar(50) NOT NULL,
	dt_nasc date NOT NULL,
	dt_morte date

	CONSTRAINT compositor_PK PRIMARY KEY (cod_compositor),
)

CREATE TABLE faixa_compositor
(
	cod_faixa smallint NOT NULL,
	cod_compositor smallint NOT NULL,

	CONSTRAINT faixa_compositor_FK_cod_faixa FOREIGN KEY (cod_faixa)
		REFERENCES faixa (cod_faixa) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT faixa_compositor_FK_cod_compositor FOREIGN KEY (cod_compositor)
		REFERENCES compositor (cod_compositor) ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE periodoMsc -- (vi)
(
	cod_periodoMsc smallint NOT NULL,
	descricao nvarchar(50) NOT NULL,
	intervalo int NOT NULL,

	CONSTRAINT periodoMsc_PK PRIMARY KEY (cod_periodoMsc),
)

CREATE TABLE compositor_periodoMsc
(
	cod_compositor smallint NOT NULL,
	cod_periodoMsc smallint NOT NULL,

	CONSTRAINT compositor_periodoMsc_FK_cod_compositor FOREIGN KEY (cod_compositor)
		REFERENCES compositor (cod_compositor) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT compositor_periodoMsc_FK_cod_periodoMsc FOREIGN KEY (cod_periodoMsc)
		REFERENCES periodoMsc (cod_periodoMsc) ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE gravadora -- (vii)
(
	cod_gravadora smallint NOT NULL,
	nome nvarchar(50) NOT NULL,
	endereco nvarchar(50) NOT NULL,
	homepage nvarchar(50)

	CONSTRAINT gravadora_PK PRIMARY KEY (cod_gravadora),
)

CREATE TABLE telefone_gravadora
(
	cod_gravadora smallint NOT NULL,
	telefone nvarchar(50) NOT NULL,

	CONSTRAINT telefone_gravadora_FK_cod_gravadora FOREIGN KEY (cod_gravadora)
		REFERENCES gravadora (cod_gravadora) ON UPDATE CASCADE ON DELETE CASCADE,
)

CREATE TABLE playlist
(
	cod_playlist smallint NOT NULL,
	nome nvarchar(50) NOT NULL,
	dt_criacao date NOT NULL,
	tempo_execucao time	NOT NULL,
	
	CONSTRAINT playlist_PK PRIMARY KEY (cod_playlist),
)

CREATE TABLE playlist_faixa
(
	cod_playlist smallint NOT NULL,
	cod_faixa smallint NOT NULL,
	dt_ultexecucao date,
	num_execucao int default 0
	
	CONSTRAINT playlist_faixa_FK_cod_playlist FOREIGN KEY (cod_playlist)
		REFERENCES playlist (cod_playlist) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT playlist_faixa_FK_cod_faixa FOREIGN KEY (cod_faixa)
		REFERENCES faixa (cod_faixa) ON UPDATE CASCADE ON DELETE CASCADE,
)


------CONTRAINTS TABELA ALBUM
ALTER TABLE album --item (i) c
	ADD CONSTRAINT album_CK_dt_compra CHECK (dt_compra > CONVERT(date, '01.01.2000')) -- testado ok*/

ALTER TABLE album --item (i) d
	ADD CONSTRAINT album_CK_tipo_compra CHECK (tipo_compra like 'física' or tipo_compra like 'download') -- testado ok*/

/* tentativa abaixo nao da certo, teremos que criar um gatilho
ALTER TABLE album --item (i) e
	ADD CONSTRAINT album_CK_pr_compra CHECK (pr_compra < (select 3*avg(a.pr_compra)
															from album a, faixa f
															where a.cod_album = f.cod_faixa and f.tipo_gravacao like 'DDD')
											)
*/


-- FOREIGN KEYS DAS TABELAS DE RELACAO 1 , N
ALTER TABLE faixa ADD
	CONSTRAINT faixa_FK_cod_album FOREIGN KEY (cod_album)
		REFERENCES album (cod_album) ON UPDATE CASCADE ON DELETE CASCADE

ALTER TABLE faixa ADD
	CONSTRAINT faixa_FK_cod_composicao FOREIGN KEY (cod_composicao)
		REFERENCES composicao (cod_composicao) ON UPDATE CASCADE ON DELETE CASCADE

