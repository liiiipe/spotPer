USE BDspotPer;

------- Restrições Parte I

-- item (i) c
ALTER TABLE album ADD CONSTRAINT album_CK_limite_dt_compra CHECK(dt_compra > '01-01-2000');

-- item (i) d
ALTER TABLE album ADD CONSTRAINT album_CK_tipo_compra CHECK (tipo_compra like 'física' or tipo_compra like 'download');

-- item (i) e
CREATE TRIGGER TR_pr_album_limite ON album
INSTEAD OF INSERT AS
IF (SELECT pr_compra FROM inserted) > 3 * 
(SELECT AVG(pr_compra) FROM album a
	WHERE NOT EXISTS (SELECT f.cod_album FROM faixa f WHERE a.cod_album = f.cod_album AND f.tipo_gravacao = 'ADD'))
 BEGIN
	RAISERROR('O preco de compra de um album nao deve ser superior a tres vezes a
media do preco de compra de albuns, com todas as faixas com tipo de
gravacao DDD.', 10, 1)
	ROLLBACK TRANSACTION
 END
ELSE
 BEGIN
	INSERT INTO album SELECT * FROM inserted
 END

-- item (ii) b
ALTER TABLE faixa ADD CONSTRAINT faixa_CK_tipo_gravacao CHECK(tipo_gravacao = 'DDD' OR tipo_gravacao = 'ADD');


------- Restrições Parte II

-- item (3) a
CREATE TRIGGER TR_album_faixa_periodo_tipograva ON faixa_compositor
INSTEAD OF INSERT AS
IF (SELECT periodoMsc.descricao FROM inserted INNER JOIN compositor
	ON compositor.cod_compositor = inserted.cod_compositor INNER JOIN periodoMsc
	ON compositor.cod_periodoMsc = periodoMsc.cod_periodoMsc) = 'Barroco' AND 
	(SELECT tipo_gravacao FROM inserted INNER JOIN faixa
	ON faixa.cod_album = inserted.cod_album AND faixa.num_faixa = inserted.num_faixa) != 'DDD'
 BEGIN
 	 RAISERROR('Um album, com faixas de musicas do periodo barroco, so pode ser adquirido, caso o tipo de gravacao seja DDD.', 10, 1)
 	 ROLLBACK TRANSACTION
 END
ELSE
 BEGIN
	INSERT INTO faixa_compositor SELECT * FROM inserted
 END

-- item (3) b
CREATE TRIGGER TR_limite_faixas_album ON faixa
INSTEAD OF INSERT AS
IF (SELECT COUNT(f.cod_album) FROM inserted INNER JOIN faixa f ON f.cod_album = inserted.cod_album) >= 64
 BEGIN
	RAISERROR('Um album nao pode ter mais que 64 faixas', 10, 1)
	ROLLBACK TRANSACTION
 END
ELSE
 BEGIN
	INSERT INTO faixa SELECT * FROM inserted
 END

-- item (3) c
-- ja estão implementados em "scriptCriacaoBD"