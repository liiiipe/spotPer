CREATE DATABASE BDspotPer
ON
    PRIMARY
    (
    NAME = 'BDspotPer',
    FILENAME = 'C:\BDspotPer\BDspotPer.mdf',
    SIZE = 5120KB,
    FILEGROWTH = 1024KB
    ),

    FILEGROUP BDspotPer_fg01
    (
    NAME = 'BDspotPer_001',
    FILENAME = 'C:\BDspotPer\BDspotPer_001.ndf',
    SIZE = 1024KB,
    FILEGROWTH = 30%
    ),
    (
    NAME ='BDspotPer_002',
    FILENAME = 'C:\BDspotPer\BDspotPer_002.ndf',
    SIZE = 1024KB,
    MAXSIZE = 3072KB,
    FILEGROWTH = 15%
    ),

    FILEGROUP BDspotPer_fg02
    (
    NAME = 'BDspotPer_003',
    FILENAME = 'C:\BDspotPer\BDspotPer_003.ndf',
    SIZE = 2048KB,
	MAXSIZE = 5120KB,
	FILEGROWTH = 1024KB
    )

    LOG ON
    (
    NAME = 'BDspotPer_log',
    FILENAME = 'C:\BDspotPer\BDspotPer.ldf',
    SIZE = 1024KB,
	FILEGROWTH = 10%
    )