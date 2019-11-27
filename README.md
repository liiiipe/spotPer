# spotPer

Antes de executar "scriptCriacaoFilegroups" tem q criar um diretorio no C:, chamado BDspotPer. Ficando assim -> C:\BDspotPer.
Depois executar o "scriptCriacaoBD".

Para abrir o projeto no QTCreator, basta clicar em open project e selecionar oque tem na pasta 'spotper'.

Antes de executar o aplicativo é necessário configurar o banco de dados. Ao abrir o projeto no QTCreator, vá em mainwindow.cpp, e configure esses campos: 
QString servername = "DESKTOP-5LSHH6H\\SQLEXPRESS";
QString dbname = "BDspotPer";
QString dbuser = "sa";
QString dbpassword = "123456";

No caso já está configurado para o meu BD.

Para executar o aplicativo fora do QTCreator, clique na pasta build-spotPer-Desktop_Qt_5_12_5_MinGW_32_bit-Release, em seguida em release, e depois execute spotPer.exe