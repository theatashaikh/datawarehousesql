-- To get the server name
SELECT @@SERVERNAME AS ServerName;

-- to get the port number
SELECT DISTINCT local_tcp_port 
FROM sys.dm_exec_connections 
WHERE local_tcp_port IS NOT NULL;

