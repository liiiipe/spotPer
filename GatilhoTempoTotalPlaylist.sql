USE [BDspotPer2]
GO

select * from playlist
select * from playlist_faixa
select * from faixa



create view TempoTotalPlaylist as 
select pf.cod_playlist,(SUM(DATEDIFF(SECOND,'00:00:00',f.tempo_execucao))) as TempoTotal  from playlist_faixa pf  
inner join faixa f on  f.num_faixa = pf.num_faixa
inner join playlist p on p.cod_playlist = pf.cod_playlist
group by pf.cod_playlist

select * from TempoTotalPlaylist

ALTER TRIGGER add_tempo_playlist ON playlist_faixa
AFTER INSERT AS
 BEGIN
	UPDATE playlist set tempo_execucao = convert(char(8), dateadd(second, ( 
	select ttp.TempoTotal from TempoTotalPlaylist ttp 
	where
	(select inserted.cod_playlist from inserted )=ttp.cod_playlist 
	), ''), 114)
	where cod_playlist = (select inserted.cod_playlist from inserted )
	
 END


 