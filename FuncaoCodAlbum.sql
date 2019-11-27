CREATE FUNCTION cod_album_nome (@nome VARCHAR(50))
RETURNS TABLE
AS
RETURN(
		select a.cod_album from album a where a.descricao like CONCAT('%', @nome, '%')
	)

