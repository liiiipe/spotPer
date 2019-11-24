/*
Script para quest�es 4, 5, 6 e 9
*/


USE BDSpotPer

-- Quest�o 4)

--CREATE CLUSTERED INDEX faixa_IDX_cod_album
--ON faixa (cod_album)
--WITH (fillfactor=100, pad_index=on)

-- (cod_album j� � chave prim�ria)

CREATE NONCLUSTERED INDEX faixa_IDX_composicao
ON faixa (cod_composicao)
WITH (fillfactor=100, pad_index=on)

-- Quest�o 5)

CREATE VIEW v1 (nome_da_playlist, qntd_de_albuns) WITH SCHEMABINDING
AS
SELECT nome, COUNT_BIG(DISTINCT album.cod_album) AS qtd_albuns FROM dbo.playlist INNER JOIN
	dbo.playlist_faixa ON playlist.cod_playlist = playlist_faixa.cod_playlist INNER JOIN dbo.album
	ON album.cod_album = playlist_faixa.cod_album
	GROUP BY nome

select * from v1
-- Tornar vis�o materializada (obs.: SQL SERVER n�o aceita cl�usula DISTINCT, HAVING ou subconsultas para indexa��o):
--CREATE UNIQUE CLUSTERED INDEX  I_v1
--on v1 (nome_da_playlist)


-- Quest�o 6)
CREATE FUNCTION albuns_altor_f (@nome VARCHAR(50))
RETURNS TABLE
AS
RETURN(
		SELECT album.cod_album, album.descricao FROM album INNER JOIN faixa
		ON album.cod_album = faixa.cod_album INNER JOIN faixa_compositor
		ON faixa.cod_album = faixa_compositor.cod_album AND faixa.num_faixa = faixa_compositor.num_faixa
		INNER JOIN compositor ON compositor.cod_compositor = faixa_compositor.cod_compositor
		WHERE compositor.nome like CONCAT('%', @nome, '%')
	)


-- #Consultas:
-- 8 A) Listar os �lbum com pre�o de compra maior que a m�dia de pre�os de compra de todos os �lbuns.

SELECT cod_album, descricao FROM album WHERE pr_compra > (SELECT AVG(pr_compra) FROM album)

-- 8 B) Listar nome da gravadora com maior n�mero de playlists que possuem pelo uma faixa composta pelo compositor Dvorack

CREATE VIEW v_q8ib AS
SELECT COUNT(g.cod_gravadora) AS numero_de_playlists, g.nome FROM gravadora g INNER JOIN album 
	ON album.cod_gravadora = g.cod_gravadora INNER JOIN faixa
	ON faixa.cod_album = album.cod_album INNER JOIN playlist_faixa
	ON faixa.cod_album = playlist_faixa.cod_album AND faixa.num_faixa = playlist_faixa.num_faixa INNER JOIN faixa_compositor
	ON faixa.cod_album = faixa_compositor.cod_album AND faixa.num_faixa = faixa_compositor.num_faixa INNER JOIN compositor
	ON faixa_compositor.cod_compositor = compositor.cod_compositor
	WHERE compositor.cod_compositor = ANY(SELECT cod_compositor FROM compositor WHERE nome LIKE '%Dvo?�k%')
GROUP BY g.nome

SELECT nome FROM v_q8ib WHERE numero_de_playlists = (SELECT MAX(numero_de_playlists) FROM v_q8ib)


-- 8 C) Listar nome do compositor com maior n�mero de faixas nas playlists existentes.

CREATE VIEW v_q8ic AS
SELECT c.nome, COUNT(CONCAT(faixa.cod_album, faixa.num_faixa)) AS qtd_musica_em_playlts FROM compositor c INNER JOIN faixa_compositor
	ON c.cod_compositor = faixa_compositor.cod_compositor INNER JOIN faixa
	ON faixa.num_faixa = faixa_compositor.num_faixa AND faixa_compositor.cod_album = faixa.cod_album INNER JOIN playlist_faixa
	ON playlist_faixa.cod_album = faixa.cod_album AND playlist_faixa.num_faixa = faixa.num_faixa
GROUP BY c.nome

SELECT nome FROM v_q8ic WHERE qtd_musica_em_playlts = (SELECT MAX(qtd_musica_em_playlts) FROM v_q8ic)

-- 8 D) Listar playlists, cujas faixas (todas) t�m tipo de composi��o �Concerto� e per�odo �Barroco�.

SELECT fp.cod_playlist, playlist.nome FROM playlist INNER JOIN playlist_faixa AS fp
	ON playlist.cod_playlist = fp.cod_playlist INNER JOIN faixa
	ON faixa.num_faixa = fp.num_faixa AND faixa.cod_album = fp.cod_album
	GROUP BY fp.cod_playlist, playlist.nome
	HAVING (
		SELECT COUNT(CONCAT(faixa.cod_album, faixa.num_faixa)) FROM faixa INNER JOIN playlist_faixa
		ON faixa.num_faixa = playlist_faixa.num_faixa AND faixa.cod_album = playlist_faixa.cod_album AND playlist_faixa.cod_playlist = fp.cod_playlist) = (
		SELECT COUNT(CONCAT(faixa.cod_album, faixa.num_faixa)) FROM faixa INNER JOIN playlist_faixa
		ON faixa.num_faixa = playlist_faixa.num_faixa AND faixa.cod_album = playlist_faixa.cod_album AND playlist_faixa.cod_playlist = fp.cod_playlist AND faixa.cod_composicao = 1 INNER JOIN faixa_compositor
		ON faixa_compositor.cod_album = faixa.cod_album AND faixa_compositor.num_faixa = faixa.num_faixa INNER JOIN compositor
		ON faixa_compositor.cod_compositor = compositor.cod_compositor AND compositor.cod_periodoMsc = 1)

-- (cod barroco = 1, cod concerto = 1)