# spotPer

-- SQL Server
1) Crie um diretorio no C:, chamado BDspotPer. Ficando o caminho assim -> C:\BDspotPer.
Em seguida execute "scriptCricaoFilegroups".
2) Depois execute "scriptCriacaoBD", "scriptRestricoes", "ScriptQuest4568", "scriptPovoamento".

-- QT
1) Baixe o QT Creator de acordo com esse video -> https://www.youtube.com/watch?v=QQDGb4AkY4c&list=PLx4x_zx8csUhzAyii9-cY-IJwo00p_5AC&index=2&t=0s .
Link para baixar -> https://www.qt.io/download-open-source?hsCtaTracking=9f6a2170-a938-42df-a8e2-a9f0b1d6cdce%7C6cb0de4f-9bb5-4778-ab02-bfb62735f3e5 .
No minuto 6:08 do video marque para baixar a versao 5.12.5, (pode desmarcar as opções dos componentes MSVC, UWP, Android. Deixando MinGW 32bits, MinGW 64bits e as outras coisas).
2) Após baixar, abra o Qt Creator e abra o projeto que está na pasta spotPer. Abra o arquivo "mainwindow.cpp" e mude as configurações de servername, dbuser, dbpassword de acordo com o que tiver no Sql Server.
3) Após isso clique no computador no canto inferior esquerdo, selecione em 'Kit' a opção 'Desktop Qt 5.12.5 MinGW 32bit', selecione em 'Build' a opção 'Release'. Após isso ele vai construir projeto e criar uma nova pasta 'build-spotPer-Desktop_Qt_5_12_5_MinGW_32_bit-Release'.
4) Agora temos que configurar o projeto para conseguir rodar fora do qt creator, mas precisamos adicionar algumas coisas necessarias a nova pasta. Nesse video -> https://www.youtube.com/watch?v=mrlFykIaBbs&list=PLx4x_zx8csUhzAyii9-cY-IJwo00p_5AC&index=46&t=0s apartir de 9:16, ele explica oq colocar na nova pasta criada pelo qt, adicionando as dlls e os plugins necessarios para o spotPer.exe rodar sem ser no Qt Creator.
Atenção extra: quando for selecionar todos as pastas dos plugins para excluílas, não exclua a pasta 'sqldrivers'.

Por fim, para executar o aplicativo fora do QTCreator, clique na pasta build-spotPer-Desktop_Qt_5_12_5_MinGW_32_bit-Release, em seguida em release, e depois execute spotPer.exe .