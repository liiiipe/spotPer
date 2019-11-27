-------------PLAYLIST
INSERT INTO playlist (nome, dt_criacao, tempo_execucao) VALUES('playlist_1', '11-11-2011', '00:00:00')

INSERT INTO playlist (nome, dt_criacao, tempo_execucao) VALUES('playlist_2', '10-01-2012', '00:00:00')

INSERT INTO playlist (nome, dt_criacao, tempo_execucao) VALUES('playlist_funk', '19-01-2019', '00:00:00')

INSERT INTO playlist (nome, dt_criacao, tempo_execucao) VALUES('playlist_sertanejo', '30-08-2017', '00:00:00')

------------GRAVADORA
INSERT INTO gravadora (cod_gravadora, nome, endereco, homepage)
VALUES (1, 'Ultra', 'Londres, Inglaterra', 'https://www.ultra.com/')

INSERT INTO gravadora (cod_gravadora, nome, endereco, homepage)
VALUES (2, 'Sony', 'São Paulo, São Paulo', 'https://www.sonymusic.com.br/')

INSERT INTO gravadora (cod_gravadora, nome, endereco, homepage)
VALUES (3,'Spinnin', 'Berlim, Alemanha', 'https://www.spinnin.com/')

-----------PERIODO MUSICAL
INSERT INTO periodoMsc (cod_periodoMsc, descricao, intervalo)
VALUES(1, 'Barroco', 160)

INSERT INTO periodoMsc (cod_periodoMsc, descricao, intervalo)
VALUES(2, 'Romantismo', 40)

INSERT INTO periodoMsc (cod_periodoMsc, descricao, intervalo)
VALUES(3, 'Rock', 50)

----------COMPOSITOR
INSERT INTO compositor (cod_compositor, cod_periodoMsc, nome, cidade_nasc, pais_nasc, dt_nasc, dt_morte)
VALUES(1, 1, 'Sebastian Bach', 'Berlim', 'Alemanha', '21-03-1685', '28-07-1750')

INSERT INTO compositor (cod_compositor, cod_periodoMsc, nome, cidade_nasc, pais_nasc, dt_nasc, dt_morte)
VALUES(2, 2, 'Ludwig van Beethoven', 'Viena', 'Austria', '17-12-1770', '26-03-1827')

INSERT INTO compositor (cod_compositor, cod_periodoMsc, nome, cidade_nasc, pais_nasc, dt_nasc)
VALUES(3, 3, 'Jimmy Page', 'Londres', 'Inglaterra', '17-12-1950')

INSERT INTO compositor (cod_compositor, cod_periodoMsc, nome, cidade_nasc, pais_nasc, dt_nasc)
VALUES(4, 3, 'Roger Waters', 'Londres', 'Inglaterra', '17-12-1950')

----------ALBUM
INSERT INTO album (cod_album, cod_gravadora, descricao, pr_compra, dt_compra, tipo_compra, dt_gravacao)
VALUES (1, 3, 'Led Zeppelin', 30.50, '02-02-2008', 'Física', '12-01-1969')

INSERT INTO album (cod_album, cod_gravadora, descricao, pr_compra, dt_compra, tipo_compra, dt_gravacao)
VALUES (2, 3, 'The Wall', 39.99, '24-10-2001', 'Física', '30-11-1979')

INSERT INTO album (cod_album, cod_gravadora, descricao, pr_compra, dt_compra, tipo_compra, dt_gravacao)
VALUES(3, 2, 'OnlyDDD', 9, '03-12-2018','Download', '03-12-2018')

INSERT INTO album (cod_album, cod_gravadora, descricao, pr_compra, dt_compra, tipo_compra, dt_gravacao)
VALUES(4, 1, 'AlbumAlgum', 4, '25-12-2019', 'Download', '01-12-2018')

----------COMPOSICAO
INSERT INTO composicao VALUES(1, 'Concerto')

INSERT INTO composicao VALUES(2, 'Rock')

INSERT INTO composicao VALUES(3, 'Ópera')

----------FAIXA
INSERT INTO faixa (num_faixa, tempo_execucao, tipo_gravacao, descricao, cod_album, cod_composicao)
VALUES (1, '00:02:46', 'ADD', 'Good Times Bad Times', 1, 2)

INSERT INTO faixa (num_faixa, tempo_execucao, tipo_gravacao, descricao, cod_album, cod_composicao)
VALUES (2, '00:06:41', 'ADD', 'Babe Im Gonna Leave You', 1, 2)

INSERT INTO faixa (num_faixa, tempo_execucao, tipo_gravacao, descricao, cod_album, cod_composicao)
VALUES (3, '00:06:28', 'ADD', 'You Shook Me', 1, 2)

INSERT INTO faixa (num_faixa, tempo_execucao, tipo_gravacao, descricao, cod_album, cod_composicao)
VALUES (1, '00:03:21', 'ADD', 'Another Brick in the Wall', 2, 2)

INSERT INTO faixa (num_faixa, tempo_execucao, tipo_gravacao, descricao, cod_album, cod_composicao)
VALUES (2, '00:06:24', 'ADD', 'Comfortably Numb', 2, 2)

INSERT INTO faixa (num_faixa, tempo_execucao, tipo_gravacao, descricao, cod_album, cod_composicao)
VALUES (1, '00:08:25', 'DDD', 'The Violin Concertos', 3, 1)

INSERT INTO faixa (num_faixa, tempo_execucao, tipo_gravacao, descricao, cod_album, cod_composicao)
VALUES (1, '00:16:45', 'DDD', 'Nach Italienischen Gusto', 4, 3)

--------faixa playlist
INSERT INTO playlist_faixa (cod_playlist, num_faixa, cod_album)
VALUES (1, 1, 1)

INSERT INTO playlist_faixa (cod_playlist, num_faixa, cod_album)
VALUES (1, 2, 1)

INSERT INTO playlist_faixa (cod_playlist, num_faixa, cod_album)
VALUES (1, 3, 1)

INSERT INTO playlist_faixa (cod_playlist, num_faixa, cod_album)
VALUES (2, 1, 2)

INSERT INTO playlist_faixa (cod_playlist, num_faixa, cod_album)
VALUES (2, 2, 2)

INSERT INTO playlist_faixa (cod_playlist, num_faixa, cod_album)
VALUES (3, 1, 3)

INSERT INTO playlist_faixa (cod_playlist, num_faixa, cod_album)
VALUES (4, 1, 4)

----------FAIXA COMPOSITOR
INSERT INTO faixa_compositor (num_faixa, cod_album, cod_compositor)
VALUES (1, 1, 3)

INSERT INTO faixa_compositor (num_faixa, cod_album, cod_compositor)
VALUES (2, 1, 3)

INSERT INTO faixa_compositor (num_faixa, cod_album, cod_compositor)
VALUES (3, 1, 3)

INSERT INTO faixa_compositor (num_faixa, cod_album, cod_compositor)
VALUES (1, 2, 4)

INSERT INTO faixa_compositor (num_faixa, cod_album, cod_compositor)
VALUES (2, 2, 4)

INSERT INTO faixa_compositor (num_faixa, cod_album, cod_compositor)
VALUES (1, 3, 1)

INSERT INTO faixa_compositor (num_faixa, cod_album, cod_compositor)
VALUES (1, 4, 2)
