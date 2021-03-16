# temp


sqoop import-all-tables -m 1 --connect jdbc:mysql://localhost/retail_db --username=retail_dba 
--password=cloudera --compression-codec=snappy --as-parquetfile --warehouse-dir=/user/hive/warehouse --hive-import
