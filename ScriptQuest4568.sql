USE BDspotPer

-- Q4)

--CREATE CLUSTERED INDEX faixa_IDX_cod_album ON faixa (cod_album) WITH (fillfactor=100, pad_index=on)

-- (cod_album já é chave primária)

CREATE NONCLUSTERED INDEX faixa_IDX_composicao ON faixa (cod_composicao) WITH (fillfactor=100, pad_index=on)

-- Q5)

CREATE VIEW v1 (nome_da_playlist, qntd_de_albuns) WITH SCHEMABINDING
AS
SELECT nome, COUNT_BIG(DISTINCT album.cod_album) AS qtd_albuns FROM dbo.playlist INNER JOIN
	dbo.playlist_faixa ON playlist.cod_playlist = playlist_faixa.cod_playlist INNER JOIN dbo.album
	ON album.cod_album = playlist_faixa.cod_album
	GROUP BY nome

select * from v1

--CREATE UNIQUE CLUSTERED INDEX  I_v1
--on v1 (nome_da_playlist)


-- Q6)
CREATE FUNCTION albuns_compositor_f (@nome NVARCHAR(50))
RETURNS TABLE
AS
RETURN(
		SELECT a.cod_album, a.descricao FROM album a INNER JOIN faixa f
		ON a.cod_album = f.cod_album INNER JOIN faixa_compositor fc
		ON f.cod_album = fc.cod_album AND f.num_faixa = fc.num_faixa
		INNER JOIN compositor c ON c.cod_compositor = fc.cod_compositor
		WHERE c.nome like CONCAT('%', @nome, '%')
	)

-- Q8) A - Listar os álbuns com preço de compra maior que a média de preços de compra de todos os álbuns.

SELECT cod_album, descricao FROM album WHERE pr_compra > (SELECT AVG(pr_compra) FROM album)

-- Q8) B - Listar nome da gravadora com maior número de playlists que possuem pelo menos uma faixa composta pelo compositor Dvorack

CREATE VIEW v_q8ib AS
SELECT COUNT(g.cod_gravadora) AS numero_de_playlists, g.nome FROM gravadora g INNER JOIN album 
	ON album.cod_gravadora = g.cod_gravadora INNER JOIN faixa
	ON faixa.cod_album = album.cod_album INNER JOIN playlist_faixa
	ON faixa.cod_album = playlist_faixa.cod_album AND faixa.num_faixa = playlist_faixa.num_faixa INNER JOIN faixa_compositor
	ON faixa.cod_album = faixa_compositor.cod_album AND faixa.num_faixa = faixa_compositor.num_faixa INNER JOIN compositor
	ON faixa_compositor.cod_compositor = compositor.cod_compositor
	WHERE compositor.cod_compositor = ANY(SELECT cod_compositor FROM compositor WHERE nome LIKE '%Dvorack%')
GROUP BY g.nome

SELECT nome FROM v_q8ib WHERE numero_de_playlists = (SELECT MAX(numero_de_playlists) FROM v_q8ib)


-- Q8) C - Listar nome do compositor com maior número de faixas nas playlists existentes.

CREATE VIEW v_q8ic AS
SELECT c.nome, COUNT(CONCAT(faixa.cod_album, faixa.num_faixa)) AS qtd_musica_em_playlts FROM compositor c INNER JOIN faixa_compositor
	ON c.cod_compositor = faixa_compositor.cod_compositor INNER JOIN faixa
	ON faixa.num_faixa = faixa_compositor.num_faixa AND faixa_compositor.cod_album = faixa.cod_album INNER JOIN playlist_faixa
	ON playlist_faixa.cod_album = faixa.cod_album AND playlist_faixa.num_faixa = faixa.num_faixa
GROUP BY c.nome

SELECT nome FROM v_q8ic WHERE qtd_musica_em_playlts = (SELECT MAX(qtd_musica_em_playlts) FROM v_q8ic)

-- Q8) D - Listar playlists, cujas faixas (todas) têm tipo de composição “Concerto” e período “Barroco”.

SELECT fp.cod_playlist, playlist.nome FROM playlist INNER JOIN playlist_faixa fp
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