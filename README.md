# spotPer um app desktop para criar e manipular playlists de música

### Configurando SQL Server
- Crie um diretorio no C:, chamado BDspotPer. Ficando o caminho assim -> C:\BDspotPer.
Em seguida execute "scriptCricaoFilegroups".
- Depois execute "scriptCriacaoBD", "scriptRestricoes", "ScriptQuest4568", "scriptPovoamento".

### Configurando QT e executando o projeto
- Baixe o QT Creator.
- Após baixar, abra o projeto que está na pasta spotPer no QTCreator. Abra o arquivo "mainwindow.cpp" e mude as configurações de servername, dbuser, dbpassword de acordo com o que tiver no Sql Server.
- Após isso selecione em 'Kit' a opção 'Desktop Qt 5.12.5 MinGW 32bit', e selecione em 'Build' a opção 'Release'. Após isso ele vai construir o projeto e criar uma nova pasta 'build-spotPer-Desktop_Qt_5_12_5_MinGW_32_bit-Release'.
- Agora temos que configurar o projeto para conseguir rodar fora do qt creator, mas precisamos adicionar algumas coisas necessarias a nova pasta. Nesse video -> https://www.youtube.com/watch?v=mrlFykIaBbs&list=PLx4x_zx8csUhzAyii9-cY-IJwo00p_5AC&index=46&t=0s apartir de 9:16, ele explica oq colocar na nova pasta criada pelo qt, adicionando as dlls e os plugins necessarios para o spotPer.exe rodar sem ser no Qt Creator.
Atenção extra: quando for selecionar todos as pastas dos plugins para excluílas, não exclua a pasta 'sqldrivers'.
- Por fim, para executar o aplicativo fora do QTCreator, clique na pasta build-spotPer-Desktop_Qt_5_12_5_MinGW_32_bit-Release, em seguida em release, e depois execute spotPer.exe .
