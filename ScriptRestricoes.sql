/*
Script de restrições do banco de dados BDSpotPer
*/

USE BDSpotPer;

--Restrição referente a: Part I (i) c
ALTER TABLE album
ADD CONSTRAINT data_compra_limit CHECK(dt_compra > '01-01-2000');

--Restrição referente a: Part I (i) e)
CREATE TRIGGER preco_album_limit_TR ON album
INSTEAD OF INSERT AS
IF (SELECT pr_compra FROM inserted) > 3 * 
(SELECT AVG(pr_compra) FROM album
	WHERE NOT EXISTS (SELECT faixa.cod_album FROM faixa WHERE tipo_gravacao = 'ADD' AND album.cod_album = faixa.cod_album))
 BEGIN
	RAISERROR('O preço de compra de um álbum não dever ser superior a três vezes a
média do preço de compra de álbuns, com todas as faixas com tipo de
gravação DDD.', 10, 1)
	ROLLBACK TRANSACTION
 END
ELSE
 BEGIN
	INSERT INTO album SELECT * FROM inserted
 END

--Restrição referente a: Part I (ii) b)
ALTER TABLE faixa
ADD CONSTRAINT restri_tipos_gravacao CHECK( tipo_gravacao= 'DDD' OR tipo_gravacao = 'ADD');

--Restrição referente a: Part II 3) a)

CREATE TRIGGER TR_album_faixa_periodo_tipograva ON faixa_compositor
INSTEAD OF INSERT AS
IF (SELECT periodoMsc.descricao FROM inserted INNER JOIN compositor
	ON compositor.cod_compositor = inserted.cod_compositor INNER JOIN periodoMsc
	ON compositor.cod_periodoMsc = periodoMsc.cod_periodoMsc) = 'Barroco' AND 
	(SELECT tipo_gravacao FROM inserted INNER JOIN faixa
	ON faixa.cod_album = inserted.cod_album AND faixa.num_faixa = inserted.num_faixa) != 'DDD'
 BEGIN
 	 RAISERROR('Um álbum, com faixas de músicas do período barroco, só pode ser adquirido, caso o tipo de gravação seja DDD.', 10, 1)
 	 ROLLBACK TRANSACTION
 END
ELSE
 BEGIN
	INSERT INTO faixa_compositor SELECT * FROM inserted
 END



--Restrição referente a: Part II 3) b)
CREATE TRIGGER limit_faixas_album_TR ON faixa
INSTEAD OF INSERT AS
IF (SELECT COUNT(faixa.cod_album) FROM inserted INNER JOIN faixa ON faixa.cod_album = inserted.cod_album) >= 64
 BEGIN
	RAISERROR('Um álbum não pode ter mais que 64 faixas', 10, 1)
	ROLLBACK TRANSACTION
 END
ELSE
 BEGIN
	INSERT INTO faixa SELECT * FROM inserted
 END

--Restrições referentes a: Part II 3) c)
ALTER TABLE faixa
DROP CONSTRAINT faixa_FK_cod_album;

ALTER TABLE faixa
ADD CONSTRAINT faixa_FK_cod_album FOREIGN KEY (cod_album) REFERENCES album
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE playlist_faixa
DROP CONSTRAINT playlist_faixa_FK_cod_faixa;

ALTER TABLE playlist_faixa
ADD CONSTRAINT playlist_faixa_FK_cod_faixa FOREIGN KEY (cod_album, num_faixa) REFERENCES faixa
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE faixa_interprete
DROP CONSTRAINT faixa_interprete_FK_cod_interprete;

ALTER TABLE faixa_interprete
ADD 	CONSTRAINT faixa_interprete_FK_cod_interprete FOREIGN KEY (cod_interprete)
		REFERENCES interprete (cod_interprete) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE faixa_compositor
DROP CONSTRAINT faixa_compositor_FK_cod_compositor;

ALTER TABLE faixa_compositor
ADD CONSTRAINT faixa_compositor_FK_cod_compositor FOREIGN KEY (cod_compositor)
		REFERENCES compositor (cod_compositor) ON UPDATE CASCADE ON DELETE CASCADE;

