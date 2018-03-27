-- ////////PODEMOS EJECUTAR ESTE QUERY CADA CIERTO TIEMPO PARA CREAR UN NUEVO RESPALDO FULL DE TODAS LAS BD

-- ////////declaramos las variables del nombre del backup asi como sus origenes y destinos
		DECLARE @nomBD VARCHAR(50); -- base de datos a respaldar que trae las que tengamos guardadas
		DECLARE @nomArch VARCHAR(256) -- cramos un nuevo archivo en caso de que no exista

-- ////////directorio de destino
		DECLARE @destinoArch VARCHAR(256) = 'C:\Backup\';
 
-- ////////especificamos fecha y formato
		DECLARE @fechaArch VARCHAR(20) = CONVERT(VARCHAR(30),SYSDATETIME(),112) 
 
-- ////////usamos un cursor para la base de datos

		DECLARE BDcursor CURSOR READ_ONLY FOR SELECT name 
		FROM master.dbo.sysdatabases

-- ////////evitamis respaldar las predeterminadas por que no nos permitira
		WHERE name NOT IN ('msdb','model','tempdb','master')
 
-- ////////iniciamos el cursor
		OPEN BDcursor

-- ////////iniciamos el cursor a recorrer
		FETCH NEXT FROM BDcursor INTO @nomBD

-- ////////esperemos a que termine de recorrer todo el registro
		WHILE @@FETCH_STATUS = 0   
			BEGIN   
			-- ////nombrearchivo destinoarchivo   nombrebasedatos         fechacreacion
			   SET @nomArch =    @destinoArch   + @nomBD          + '_' + @fechaArch + '.BAK'  
			   BACKUP DATABASE @nomBD TO DISK = @nomArch
 
		FETCH NEXT FROM BDcursor INTO @nomBD
		END 

-- ////////cerramos el cursor
		CLOSE BDcursor

-- ////////liberamos el cursor
		DEALLOCATE BDcursor