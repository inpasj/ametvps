IF DB_ID(N'A') IS NULL
BEGIN
    PRINT N'Restoring database A from the configured backup.';
    RESTORE DATABASE [A]
        FROM DISK = N'/var/opt/mssql/backup/AMET.bak'
        WITH MOVE N'ASPNETDB_df2ac074eefe459aa653c7fcf95e053d_DAT'
                 TO N'/var/opt/mssql/data/A.mdf',
             MOVE N'ASPNETDB_TMP_log'
                 TO N'/var/opt/mssql/data/A.ldf',
             RECOVERY,
             STATS = 10;
END
ELSE
BEGIN
    PRINT N'Database A already exists; restore skipped.';
END;
GO
